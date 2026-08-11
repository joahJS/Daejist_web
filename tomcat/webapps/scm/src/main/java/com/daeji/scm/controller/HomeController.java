package com.daeji.scm.controller;

import com.daeji.scm.dao.HomeDao;
import com.daeji.scm.service.HomeService;
import com.daeji.scm.vo.UserDetailsVO;
import com.daeji.scm.vo.UserVO;
import java.math.BigDecimal;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource(name="homeService")
    HomeService hService;
    @Autowired(required=false)
    HomeDao hDao;

    @RequestMapping(value={"/"}, method={RequestMethod.GET})
    public String home() {
        return "login";
    }

    @RequestMapping(value={"/member/table.do"}, method={RequestMethod.GET})
    public String table(HttpServletRequest request, Principal principal) {
        if (request.getParameter("cod") != null) {
            String cod = request.getParameter("cod");
            List<UserVO> userList = this.hDao.getUserAuthList(cod);
            if (!userList.isEmpty()) {
                UserVO userInfo = userList.get(0);
                ArrayList<SimpleGrantedAuthority> list = new ArrayList<SimpleGrantedAuthority>();
                list.add(new SimpleGrantedAuthority("ROLE_MEMBER"));
                SecurityContext sc = SecurityContextHolder.getContext();
                UserDetailsVO userDetails = new UserDetailsVO();
                userDetails.setUsername(userInfo.getIDT_NO());
                userDetails.setPassword("{noop}" + userInfo.getSCM_PSWD());
                sc.setAuthentication((Authentication)new UsernamePasswordAuthenticationToken((Object)userDetails, null, list));
                HttpSession session = request.getSession(true);
                session.setAttribute("SPRING_SECURITY_CONTEXT", (Object)sc);
                return "table";
            }
            return "redirect:/";
        }
        if (principal.getName() != null) {
            return "table";
        }
        return "redirect:/";
    }

    @RequestMapping(value={"/member/print.do"}, method={RequestMethod.GET})
    public ModelAndView print(HttpServletRequest request, Principal principal) {
        ModelAndView mav = new ModelAndView();
        List<UserVO> dealerList = this.hDao.getUserAuthList(principal.getName());
        if (dealerList.isEmpty()) {
            return null;
        }
        String sdate = request.getParameter("sdate");
        String edate = request.getParameter("edate");

        // 거래명세서 내용(줄)은 사업자번호에 속한 모든 지점의 매입 내역을 합쳐서 전부 보여준다.
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        for (UserVO dealer : dealerList) {
            HashMap<String, Object> map = new HashMap<String, Object>();
            map.put("sdate", sdate);
            map.put("edate", edate);
            map.put("J_ID1", dealer.getDEALER_CD());
            result.addAll(this.hService.getPrintData(map));
        }
        result.sort((a, b) -> {
            String da = "" + a.get("YY") + a.get("MM") + a.get("DD");
            String db = "" + b.get("YY") + b.get("MM") + b.get("DD");
            return da.compareTo(db);
        });

        // 상단 법인명 등은 지점 데이터 유무와 상관없이 거래시작일이 가장 빠른 지점(dealerList 첫 번째) 것으로 고정한다.
        UserVO repDealer = dealerList.get(0);
        HashMap<String, Object> comInfo = new HashMap<String, Object>();
        String IDT_NO = repDealer.getIDT_NO();
        IDT_NO = IDT_NO.substring(0, 3) + "-" + IDT_NO.substring(3, 5) + "-" + IDT_NO.substring(5);
        comInfo.put("IDT_NO", IDT_NO);
        comInfo.put("DEALER_NM", repDealer.getDEALER_NM());
        comInfo.put("REP_NM", repDealer.getREP_NM());
        comInfo.put("ADDR", repDealer.getADDR() != null && !repDealer.getADDR().isEmpty()
                ? repDealer.getADDR() + " " + repDealer.getDTL_ADDR()
                : repDealer.getDTL_ADDR());
        comInfo.put("BIZ_NM", repDealer.getBIZ_NM());
        comInfo.put("TYPE_NM", repDealer.getTYPE_NM());

        Map<String, Object> daejiInfo = this.hService.getDaejiInfo();
        mav.setViewName("printOut");
        mav.addObject("list", result);
        mav.addObject("daejiInfo", daejiInfo);
        mav.addObject("comInfo", comInfo);
        return mav;
    }

    @ResponseBody
    @RequestMapping(value={"/login/logout.do"}, method={RequestMethod.POST})
    public String loout(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "로그아웃";
    }

    @ResponseBody
    @RequestMapping(value={"/member/getTableData.do"}, method={RequestMethod.POST})
    public List<Map<String, Object>> getTableData(HttpServletRequest request, Principal principal) {
        List<UserVO> dealerList = this.hDao.getUserAuthList(principal.getName());
        if (dealerList.isEmpty()) {
            return null;
        }
        String sdate = request.getParameter("sdate");
        String edate = request.getParameter("edate");

        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        for (UserVO dealer : dealerList) {
            HashMap<String, Object> map = new HashMap<String, Object>();
            map.put("sdate", sdate);
            map.put("edate", edate);
            map.put("J_ID1", dealer.getDEALER_CD());
            System.out.println("거래처코드: " + dealer.getDEALER_CD());
            List<Map<String, Object>> branchResult = this.hService.getTableData(map);
            for (Map<String, Object> row : branchResult) {
                row.put("DEALER_CD", dealer.getDEALER_CD());
                row.put("DEALER_NM", dealer.getDEALER_NM());
            }
            result.addAll(branchResult);
        }

        result.sort((a, b) -> {
            String sa = a.get("J_DATE") == null ? "" : a.get("J_DATE").toString();
            String sb = b.get("J_DATE") == null ? "" : b.get("J_DATE").toString();
            return sa.compareTo(sb);
        });

        return result;
    }

    @ResponseBody
    @RequestMapping(value={"/member/getCarryOver.do"}, method={RequestMethod.POST})
    public Map<String, Object> getCarryOver(HttpServletRequest request, Principal principal) {
        List<UserVO> dealerList = this.hDao.getUserAuthList(principal.getName());
        if (dealerList.isEmpty()) {
            return null;
        }
        String sdate = request.getParameter("sdate");
        String edate = request.getParameter("edate");

        BigDecimal total = BigDecimal.ZERO;
        HashMap<String, Object> byDealer = new HashMap<String, Object>();

        for (UserVO dealer : dealerList) {
            HashMap<String, Object> map = new HashMap<String, Object>();
            map.put("sdate", sdate);
            map.put("edate", edate);
            map.put("J_ID1", dealer.getDEALER_CD());
            System.out.println("거래처코드: " + dealer.getDEALER_CD());
            Map<String, Object> branchResult = this.hService.getCarryOver(map);
            Object amt = branchResult == null ? null : branchResult.get("CARRY_OVER_AMT");
            BigDecimal branchAmt = amt == null ? BigDecimal.ZERO : new BigDecimal(amt.toString());
            total = total.add(branchAmt);
            byDealer.put(String.valueOf(dealer.getDEALER_CD()), branchAmt);
        }

        HashMap<String, Object> result = new HashMap<String, Object>();
        result.put("CARRY_OVER_AMT", total);
        result.put("byDealer", byDealer);
        return result;
    }

    @ResponseBody
    @RequestMapping(value={"/member/getTableDataPRE.do"}, method={RequestMethod.POST})
    public List<Map<String, Object>> getTableDataPRE(HttpServletRequest request, Principal principal) {
        List<UserVO> dealerList = this.hDao.getUserAuthList(principal.getName());
        if (dealerList.isEmpty()) {
            return null;
        }
        String sdate = request.getParameter("sdate");
        String edate = request.getParameter("edate");
        System.out.println("=====================");
        System.out.println(sdate);
        System.out.println(edate);

        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        for (UserVO dealer : dealerList) {
            HashMap<String, Object> map = new HashMap<String, Object>();
            map.put("sdate", sdate);
            map.put("edate", edate);
            map.put("J_ID1", dealer.getDEALER_CD());
            List<Map<String, Object>> branchResult = this.hService.getTableDataPRE(map);
            for (Map<String, Object> row : branchResult) {
                row.put("DEALER_CD", dealer.getDEALER_CD());
                row.put("DEALER_NM", dealer.getDEALER_NM());
            }
            result.addAll(branchResult);
        }

        result.sort((a, b) -> {
            String sa = a.get("J_DATE") == null ? "" : a.get("J_DATE").toString();
            String sb = b.get("J_DATE") == null ? "" : b.get("J_DATE").toString();
            return sa.compareTo(sb);
        });

        return result;
    }

    @ResponseBody
    @RequestMapping(value={"/member/chgScmPw.do"}, method={RequestMethod.POST})
    public Map<String, String> chgScmPw(HttpServletRequest request, Principal principal) {
        List<UserVO> dealerList = this.hDao.getUserAuthList(principal.getName());
        if (dealerList.isEmpty()) {
            return null;
        }
        String SCMPW = request.getParameter("SCMPW");
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("SCMPW", SCMPW);
        // 사업자번호가 같은 모든 지점(거래처코드)의 비밀번호를 함께 갱신해서
        // 다음 로그인 시 지점 간 비밀번호가 어긋나지 않도록 한다.
        map.put("IDT_NO", principal.getName());
        Map<String, String> result = this.hService.chgScmPw(map);
        return result;
    }

    @ResponseBody
    @RequestMapping(value={"/member/getPrintData.do"}, method={RequestMethod.POST})
    public List<Map<String, Object>> getPrintData(HttpServletRequest request, Principal principal) {
        List<UserVO> dealerList = this.hDao.getUserAuthList(principal.getName());
        if (dealerList.isEmpty()) {
            return null;
        }
        UserVO userInfo = dealerList.get(0);
        String sdate = request.getParameter("sdate");
        String edate = request.getParameter("edate");
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("sdate", sdate);
        map.put("edate", edate);
        map.put("J_ID1", userInfo.getDEALER_CD());
        List<Map<String, Object>> result = this.hService.getPrintData(map);
        return result;
    }

    @ResponseBody
    @RequestMapping(value={"/member/getDaejiInfo.do"}, method={RequestMethod.POST})
    public Map<String, Object> getDaejiInfo() {
        Map<String, Object> result = this.hService.getDaejiInfo();
        return result;
    }
}

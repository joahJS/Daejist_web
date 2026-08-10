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
        // 거래명세서는 세금계산서 성격의 대외 문서이므로, 동일 사업자번호에 지점이 여러 건
        // 연결되어 있더라도 지금은 대표 거래처(첫 번째 등록 건) 기준으로만 발행한다.
        // 지점별로 별도 발행할지, 한 문서에 합산할지는 별도 확인이 필요하다.
        UserVO userInfo = dealerList.get(0);
        String sdate = request.getParameter("sdate");
        String edate = request.getParameter("edate");
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("sdate", sdate);
        map.put("edate", edate);
        map.put("J_ID1", userInfo.getDEALER_CD());
        List<Map<String, Object>> result = this.hService.getPrintData(map);
        HashMap<String, Object> comInfo = new HashMap<String, Object>();
        int i = 0;
        while (i < result.size()) {
            Map<String, Object> rMap = result.get(i);
            if (i == 0) {
                String IDT_NO = rMap.get("IDT_NO").toString();
                IDT_NO = String.valueOf(IDT_NO.substring(0, 3)) + "-" + IDT_NO.substring(3, 5) + "-" + IDT_NO.substring(5);
                comInfo.put("IDT_NO", IDT_NO);
                comInfo.put("DEALER_NM", rMap.get("DEALER_NM"));
                comInfo.put("REP_NM", rMap.get("REP_NM"));
                comInfo.put("ADDR", rMap.get("ADDR"));
                comInfo.put("BIZ_NM", rMap.get("BIZ_NM"));
                comInfo.put("TYPE_NM", rMap.get("TYPE_NM"));
                break;
            }
            ++i;
        }
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

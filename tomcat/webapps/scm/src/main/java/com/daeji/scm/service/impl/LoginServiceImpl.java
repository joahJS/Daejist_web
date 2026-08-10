/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  org.springframework.beans.factory.annotation.Autowired
 *  org.springframework.security.core.userdetails.UserDetails
 *  org.springframework.security.core.userdetails.UserDetailsService
 *  org.springframework.security.core.userdetails.UsernameNotFoundException
 *  org.springframework.stereotype.Service
 */
package com.daeji.scm.service.impl;

import com.daeji.scm.dao.HomeDao;
import com.daeji.scm.vo.UserDetailsVO;
import com.daeji.scm.vo.UserVO;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl
implements UserDetailsService {
    @Autowired(required=false)
    HomeDao hDao;

    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserDetailsVO userDetails = new UserDetailsVO();
        List<UserVO> userList = this.hDao.getUserAuthList(username);
        if (userList == null || userList.isEmpty()) {
            throw new UsernameNotFoundException(username);
        }
        UserVO userInfo = userList.get(0);
        userDetails.setUsername(userInfo.getIDT_NO());
        userDetails.setPassword("{noop}" + userInfo.getSCM_PSWD());
        ArrayList<String> authlist = new ArrayList<String>();
        authlist.add("ROLE_MEMBER");
        userDetails.setAuthorities(authlist);
        return userDetails;
    }
}

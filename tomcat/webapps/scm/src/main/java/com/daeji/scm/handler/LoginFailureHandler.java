/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.servlet.ServletException
 *  javax.servlet.ServletRequest
 *  javax.servlet.ServletResponse
 *  javax.servlet.http.HttpServletRequest
 *  javax.servlet.http.HttpServletResponse
 *  org.springframework.security.core.AuthenticationException
 *  org.springframework.security.web.authentication.AuthenticationFailureHandler
 */
package com.daeji.scm.handler;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class LoginFailureHandler
implements AuthenticationFailureHandler {
    private String loginidname;
    private String loginpwdname;
    private String defaultFailureUrl;

    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        String username = request.getParameter(this.loginidname);
        String password = request.getParameter(this.loginpwdname);
        request.setAttribute(this.loginidname, (Object)username);
        request.setAttribute(this.loginpwdname, (Object)password);
        request.getRequestDispatcher(this.defaultFailureUrl).forward((ServletRequest)request, (ServletResponse)response);
    }

    public String getLoginidname() {
        return this.loginidname;
    }

    public void setLoginidname(String loginidname) {
        this.loginidname = loginidname;
    }

    public String getLoginpwdname() {
        return this.loginpwdname;
    }

    public void setLoginpwdname(String loginpwdname) {
        this.loginpwdname = loginpwdname;
    }

    public String getDefaultFailureUrl() {
        return this.defaultFailureUrl;
    }

    public void setDefaultFailureUrl(String defaultFailureUrl) {
        this.defaultFailureUrl = defaultFailureUrl;
    }
}

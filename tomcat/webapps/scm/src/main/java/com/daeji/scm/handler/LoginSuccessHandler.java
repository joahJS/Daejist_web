/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.servlet.ServletException
 *  javax.servlet.http.HttpServletRequest
 *  javax.servlet.http.HttpServletResponse
 *  javax.servlet.http.HttpSession
 *  org.springframework.security.core.Authentication
 *  org.springframework.security.web.DefaultRedirectStrategy
 *  org.springframework.security.web.RedirectStrategy
 *  org.springframework.security.web.authentication.AuthenticationSuccessHandler
 *  org.springframework.security.web.savedrequest.HttpSessionRequestCache
 *  org.springframework.security.web.savedrequest.RequestCache
 *  org.springframework.security.web.savedrequest.SavedRequest
 */
package com.daeji.scm.handler;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

public class LoginSuccessHandler
implements AuthenticationSuccessHandler {
    private String loginidname;
    private String defaultUrl;
    private RequestCache requestCache = new HttpSessionRequestCache();
    private RedirectStrategy redirectStratgy = new DefaultRedirectStrategy();

    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        this.clearAuthenticationAttributes(request);
        this.resultRedirectStrategy(request, response, authentication);
    }

    protected void clearAuthenticationAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }
        session.removeAttribute("SPRING_SECURITY_LAST_EXCEPTION");
    }

    protected void resultRedirectStrategy(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        SavedRequest savedRequest = this.requestCache.getRequest(request, response);
        if (savedRequest != null) {
            String targetUrl = savedRequest.getRedirectUrl();
            this.redirectStratgy.sendRedirect(request, response, targetUrl);
        } else {
            this.redirectStratgy.sendRedirect(request, response, this.defaultUrl);
        }
    }

    public String getLoginidname() {
        return this.loginidname;
    }

    public void setLoginidname(String loginidname) {
        this.loginidname = loginidname;
    }

    public String getDefaultUrl() {
        return this.defaultUrl;
    }

    public void setDefaultUrl(String defaultUrl) {
        this.defaultUrl = defaultUrl;
    }
}

package com.contoso.payroll;

import java.io.IOException;
import javax.servlet.ServletException;
import org.springframework.http.HttpHeaders;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.core.AuthenticationException;

// By Default Java Adds the WWW-Authtenticate header which triggers pop up on web browsers - https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/WWW-Authenticate 
public class NoWWWAuthenticateEntryPoint implements AuthenticationEntryPoint {
	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException arg2) throws IOException, ServletException {
		response.setHeader(HttpHeaders.WWW_AUTHENTICATE, "");

		response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Access Denied");
	}
}

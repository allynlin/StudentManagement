package com.cshbxy.config;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

/**
 * @author Allyn
 */
@WebFilter(
    filterName = "encodingFilter",
    urlPatterns = {"/*"})
public class EncodingFilter implements Filter {
  @Override
  public void init(FilterConfig filterConfig) {}

  @Override
  public void doFilter(
      ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
      throws IOException, ServletException {
    servletRequest.setCharacterEncoding("utf-8");
    servletResponse.setCharacterEncoding("utf-8");
    filterChain.doFilter(servletRequest, servletResponse);
  }

  @Override
  public void destroy() {}
}

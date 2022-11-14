package com.cshbxy.interceptor;

import com.cshbxy.pojo.User;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author Allyn
 */
public class ResourcesInterceptor extends HandlerInterceptorAdapter {
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
      throws Exception {
    String uri = request.getRequestURI();
    System.out.println(uri);
    if (uri.indexOf("login") >= 0) {
      return true;
    }
    if (request.getSession().getAttribute("USER_SESSION") != null) {
      return true;
    } else {
      User user = (User) request.getSession().getAttribute("USER_SESSION");
      // 获取请求的路径
      // 判断是否是登录请求
      if (user != null) {
        return true;
      }
      // 其他情况都直接跳转到登录页面
      request.setAttribute("msg", "loginerror");
      request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
      return false;
    }
  }
}

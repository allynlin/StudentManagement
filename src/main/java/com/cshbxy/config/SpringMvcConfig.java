package com.cshbxy.config;

import com.cshbxy.interceptor.ResourcesInterceptor;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;

/**
 * @author Allyn
 */
@Configuration
@ComponentScan({"com.cshbxy.controller"})
@EnableWebMvc
public class SpringMvcConfig implements WebMvcConfigurer {
  @Override
  public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
    configurer.enable();
  }

  @Override
  public void configureViewResolvers(ViewResolverRegistry registry) {
    registry.jsp("/WEB-INF/pages/", ".jsp");
  }

  @Override
  public void addInterceptors(InterceptorRegistry registry) {
    registry
        .addInterceptor(new ResourcesInterceptor())
        .addPathPatterns("/**")
        .excludePathPatterns("/css/**", "/js/**", "/images/**");
  }
}

package com.cshbxy.config;

import com.github.pagehelper.PageInterceptor;
import org.apache.ibatis.plugin.Interceptor;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.mapper.MapperScannerConfigurer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;

import javax.sql.DataSource;
import java.util.Properties;

/**
 * @author Allyn
 */
public class MyBatisConfig {
  // 配置分页插件
  @Bean
  public PageInterceptor getPageInterceptor() {
    PageInterceptor pageInterceptor = new PageInterceptor();
    Properties properties = new Properties();
    properties.setProperty("value", "true");
    pageInterceptor.setProperties(properties);
    return pageInterceptor;
  }

  @Bean
  public SqlSessionFactoryBean getSqlSessionFactoryBean(
      @Autowired DataSource dataSource, @Autowired PageInterceptor pageInterceptor) {
    SqlSessionFactoryBean ssfb = new SqlSessionFactoryBean();
    ssfb.setDataSource(dataSource);
    Interceptor[] plugins = {pageInterceptor};
    ssfb.setPlugins(plugins);
    return ssfb;
  }

  @Bean
  public MapperScannerConfigurer getMapperScannerConfigurer() {
    MapperScannerConfigurer msc = new MapperScannerConfigurer();
    msc.setBasePackage("com.cshbxy.mapper");
    return msc;
  }
}

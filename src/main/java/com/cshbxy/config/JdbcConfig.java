package com.cshbxy.config;

import com.alibaba.druid.pool.DruidDataSource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.PropertySource;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;

/**
 * @author Allyn
 */
@PropertySource("classpath:jdbc.properties")
public class JdbcConfig {
  /*
  使用注入的形式，读取 properties 文件中的配置信息
   */
  @Value("${jdbc.driverClassName}")
  private String driver;

  @Value("${jdbc.url}")
  private String url;

  @Value("${jdbc.username}")
  private String username;

  @Value("${jdbc.password}")
  private String password;

  @Bean("dataSource")
  public DataSource getDataSource() {
    // 创建对象
    DruidDataSource ds = new DruidDataSource();
    // 设置属性
    ds.setDriverClassName(driver);
    ds.setUrl(url);
    ds.setUsername(username);
    ds.setPassword(password);
    return ds;
  }

  @Bean("jdbcTemplate")
  public JdbcTemplate getJdbcTemplate() {
    // 创建对象
    DruidDataSource ds = new DruidDataSource();
    // 设置属性
    ds.setDriverClassName(driver);
    ds.setUrl(url);
    ds.setUsername(username);
    ds.setPassword(password);
    return new JdbcTemplate(ds);
  }
}

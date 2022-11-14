package com.cshbxy.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Import;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.sql.DataSource;

/**
 * @author Allyn
 */
@Import({MyBatisConfig.class, JdbcConfig.class})
@ComponentScan("com.cshbxy.service")
@EnableTransactionManagement
public class SpringConfig {
  @Bean("transactionManager")
  public DataSourceTransactionManager getDataSourceTxManager(@Autowired DataSource dataSource) {
    DataSourceTransactionManager dtm = new DataSourceTransactionManager();
    dtm.setDataSource(dataSource);
    return dtm;
  }
  @Bean("multipartResolver")
  public CommonsMultipartResolver getMultipartResolver() {
    CommonsMultipartResolver commonsMultipartResolver=new CommonsMultipartResolver();
    return commonsMultipartResolver;
  }
}

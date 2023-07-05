package com.human.springboot;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class JA_WebConfig implements WebMvcConfigurer {
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/imageTemp/**")
				.addResourceLocations("file:///E:/imageTemp/");
		registry.addResourceHandler("/imageSave/**")
				.addResourceLocations("file:///C:/Users/admin/eclipse-workspace/project_test/src/main/resources/static/img/post_img/");
		
	}
}

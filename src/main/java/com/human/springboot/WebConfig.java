package com.human.springboot;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer{
	// 임시파일 경로
	private String tempConnectPath = "/tempPath/**";
    private String tempResourcePath = "file:///D:/imgPath/";
    // 프로젝트 경로
    private String connectPath = "/imagePath/**";
    private String resourcePath = 
    		"file:///C:/Users/admin/eclipse-workspace/ShoppingMall2/src/main/resources/static/img/prod_desc_img/";
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler(tempConnectPath)
                .addResourceLocations(tempResourcePath);
        registry.addResourceHandler(connectPath)
        		.addResourceLocations(resourcePath);
        registry.addResourceHandler("/imageTemp/**")
				.addResourceLocations("file:///C:/imageTemp/");
        registry.addResourceHandler("/post_img/**")
				.addResourceLocations("file:///C:/Users/admin/eclipse-workspace/project_test/src/main/resources/static/post_img/");
    }
}

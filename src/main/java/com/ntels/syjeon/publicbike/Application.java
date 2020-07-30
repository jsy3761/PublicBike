package com.ntels.syjeon.publicbike;

import com.google.gson.Gson;
import com.ntels.syjeon.publicbike.model.api.RentBikeStatus;
import com.ntels.syjeon.publicbike.model.api.ResponseApi;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

@SpringBootApplication
public class Application extends SpringBootServletInitializer {
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(Application.class);
	}
	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);

		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders httpHeaders = new HttpHeaders();
		HttpEntity<Object> httpEntity = new HttpEntity<>(httpHeaders);


		String url = new StringBuilder()
				.append("http://openapi.seoul.go.kr:8088/737a6a6d756a737937317568694a7a/json/bikeList/")
				.append(1)
				.append("/")
				.append(1000)
				.toString();

		ResponseEntity<String> responseEntity = restTemplate.exchange(url, HttpMethod.GET, httpEntity, String.class);
		String jsonString = responseEntity.getBody();
		RentBikeStatus rentBikeStatus = new Gson().fromJson(jsonString,ResponseApi.class).getRentBikeStatus();

	}

}

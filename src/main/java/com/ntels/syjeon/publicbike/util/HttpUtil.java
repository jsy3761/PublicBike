package com.ntels.syjeon.publicbike.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

/**
 * Http Util
 *
 * @author syjeon@ntels.com
 */
@Component
public class HttpUtil {

    /**
     * Logger
     */
    private static final Logger logger = LoggerFactory.getLogger(HttpUtil.class);

    /**
     * Api Service Url
     */
    @Value("${covid.api.url}")
    private String serviceUrl;

    /**
     * 공공 Api Service를 호출하여 full JsonString 형태로 리턴
     *
     * @return full JsonString
     */
    public String apiCall(int startRow, int Endrow) {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders httpHeaders = new HttpHeaders();
        HttpEntity<Object> httpEntity = new HttpEntity<>(httpHeaders);


        String url = new StringBuilder()
                .append(serviceUrl)
                .append(startRow)
                .append("/")
                .append(Endrow)
                .toString();
        logger.debug("Request Url : {}", url);

        ResponseEntity<String> responseEntity = restTemplate.exchange(url, HttpMethod.GET, httpEntity, String.class);
        String jsonString = responseEntity.getBody();
        return jsonString;

    }

}

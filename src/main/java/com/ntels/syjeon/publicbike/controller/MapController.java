package com.ntels.syjeon.publicbike.controller;

import com.google.gson.Gson;
import com.ntels.syjeon.publicbike.model.api.RentBikeStatus;
import com.ntels.syjeon.publicbike.model.api.ResponseApi;
import com.ntels.syjeon.publicbike.model.api.Row;
import com.ntels.syjeon.publicbike.util.HttpUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author syjeon@ntels.com
 */
@Controller
public class MapController {

    @Autowired
    private HttpUtil httpUtil;

    @GetMapping(value = "/")
    public String index(){
        return "map";
    }

    @GetMapping(value = "/hello")
    public String hello(){
        return "hello";
    }

    @ResponseBody
    @GetMapping("/location.ajax")
    public List<Row> getLocations(){
        Gson gson = new Gson();

        List<Row> rows =
                gson.fromJson(httpUtil.apiCall(1,1000),ResponseApi.class).getRentBikeStatus().getRow();

        gson.fromJson(httpUtil.apiCall(1001,2000),ResponseApi.class).getRentBikeStatus().getRow()
                .forEach(s -> rows.add(s));

        gson.fromJson(httpUtil.apiCall(2001,3000),ResponseApi.class).getRentBikeStatus().getRow()
                .forEach(s -> rows.add(s));

        System.out.println(rows.size());

        return rows;
    }
}

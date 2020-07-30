<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>지도 생성하기</title>
</head>
<style>
    .image {
        position: relative;
        text-align: center;
        color: #FFFFFF;
    }

    .image div {
        position: absolute;
        top: 45%;
        left: 50%;
        transform: translate(-50%, -50%);
        text-shadow: -1px 0 1px black, 0 1px 1px black, 1px 0 1px black, 0 -1px 1px black;
    }
</style>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d901fd1b634e3cfb4c705faa31a14357"></script>
<script>
    $(document).ready(function () {

        getLocation();
    });

    


    function getLocation() {
        var map = new kakao.maps.Map(document.getElementById('map'),
                    mapOption = {
                        center: new kakao.maps.LatLng(37.5175184, 127.039276), // 지도의 중심좌표
                        level: 5 // 지도의 확대 레벨
                    }); // 지도를 생성합니다
                // 지도 타입 컨트롤을 지도에 표시합니다
                var mapTypeControl = new kakao.maps.MapTypeControl();
                map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
                var imageSrc = "/img/marker/marker.png";
        
        $.ajax({
            type: "GET",
            url: "/location.ajax",
            success: function (result) {
                for (var i = 0; i < result.length; i++) {
                    var name = result[i].stationName.split(".")[1];
                    var content = '<div class="image"><img src="' + imageSrc + '"><div id="text">' + result[i].parkingBikeTotCnt + '</div></div>';
                    var position = new kakao.maps.LatLng(result[i].stationLatitude, result[i].stationLongitude);

                    var customOverlay = new kakao.maps.CustomOverlay({
                        map: map,
                        position: position,
                        content: content
                    });

                }
            }
        })
    }
</script>


<body>
    <!-- 지도를 표시할 div 입니다 -->
    <div id="map" style="width:100%;height:800px;"></div>
</body>
</html>
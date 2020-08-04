<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="utf-8">
        <title>지도 생성하기</title>
    </head>
    <style>
        #text {
            color: #FFFFFF;
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
        $(document).ready(function() {
            getLocation();

        });
        var map;
        var arr = new Array();

        function getLocation() {
            map = new kakao.maps.Map(document.getElementById('map'),
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
                success: function(result) {
                    arr = result;
                    for (var i = 0; i < result.length; i++) {

                        var content = '<a onclick="view(\'' + result[i].stationName + '\')"><img src="' + imageSrc + '"></a><div id="text">' + result[i].parkingBikeTotCnt + '</div>';
                        var position = new kakao.maps.LatLng(result[i].stationLatitude, result[i].stationLongitude);

                        var customOverlay = new kakao.maps.CustomOverlay({
                            map: map,
                            clickable: true,
                            position: position,
                            content: content
                        });
                    }
                }
            })
        }

        function view(data) {
            for (var i = 0; i < arr.length; i++) {
                if (data == arr[i].stationName) {
                    var iwContent = '<div class="wrap" >' +
                        '    <div class="info">' +
                        '        <div class="title"><h3 style="text-align:center;">' + arr[i].stationName.split(".")[1] +
                        '            </h3><div class="close" onclick="closeOverlay()" title="닫기"></div>' +
                        '        </div>' +
                        '        <div class="body"><div id="roadview" style="width:100%;height:200px;"></div>' +
                        '            <div class="desc">' +
                        '                <div class="ellipsis"><h3>대여가능 자전거: ' + arr[i].parkingBikeTotCnt + '</h3></div>' +
                        '            </div>' +
                        '        </div>' +
                        '    </div>' +
                        '</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다


                        iwPosition = new kakao.maps.LatLng(arr[i].stationLatitude, arr[i].stationLongitude), //인포윈도우 표시 위치입니다
                        iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

                    // 인포윈도우를 생성하고 지도에 표시합니다
                    var infowindow = new kakao.maps.InfoWindow({
                        map: map, // 인포윈도우가 표시될 지도
                        position: iwPosition,
                        content: iwContent,
                        removable: iwRemoveable
                    });
                    var roadviewContainer = document.getElementById('roadview'); //로드뷰를 표시할 div
                    var roadview = new kakao.maps.Roadview(roadviewContainer); //로드뷰 객체
                    var roadviewClient = new kakao.maps.RoadviewClient(); //좌표로부터 로드뷰 파노ID를 가져올 로드뷰 helper객체

                    var position = new kakao.maps.LatLng(arr[i].stationLatitude, arr[i].stationLongitude);

                    // 특정 위치의 좌표와 가까운 로드뷰의 panoId를 추출하여 로드뷰를 띄운다.
                    roadviewClient.getNearestPanoId(position, 50, function(panoId) {
                        roadview.setPanoId(panoId, position); //panoId와 중심좌표를 통해 로드뷰 실행
                    });

                }
            }
        }
    </script>

    <body>
        <!-- 지도를 표시할 div 입니다 -->
        <div id="map" style="width:100%;height:800px;"></div>
    </body>

    </html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="../assets/img/favicon.png">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <title>
    지하철 알리미
  </title>
  <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
    name='viewport' />
  <!--     Fonts and icons     -->
  <link rel="stylesheet" type="text/css"
    href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
  <!-- CSS Files -->
  <link href="../assets/css/material-dashboard.css?v=2.1.0" rel="stylesheet" />
  <!-- CSS Just for demo purpose, don't include it in your project -->
  <link href="../assets/demo/demo.css" rel="stylesheet" />
  <script>
    $(document).ready(function () {
      getLists();
      getStns();
      getdata();
      
      pulling();
    });
   
    function getStns() {
      var subId = $('#sub').val();
      var stnName = $('#stName').val();
      var preStation;
      var station;
      var nextStation;
      $.ajax({
        type: "GET",
        url: "/stnNames.ajax",
        data: { subwayId: subId },
        success: function (result) {
          $('#stn').empty();
          $('#prev').empty();
          $('#on').empty();
          $('#next').empty();
          for (var i = 0; i < result.length; i++) {
            $('#stn').append(
              '<a href="../' + subId + '/' + result[i] + '" class="btn btn-primary btn-round">' +
              '<h4>' + result[i] + '</h4>' +
              '</a>'
            )
            if(stnName == result[i]){
              station = result[i]; 
              if(i == 0){
                preStation = "X";
                nextStation = result[i+1];
              }else if(i == result.length-1){
                preStation = result[i-1];
                nextStation = "X";
              }else{
                preStation = result[i-1];
                nextStation = result[i+1];
              }
            }
          } 
          $('#prev').append('<a href="../${subId}/'+preStation+'">'+preStation+'역</a>');
          $('#on').append('<a href="../${subId}/'+station+'">'+station+'역</a>');
          $('#next').append('<a href="../${subId}/'+nextStation+'">'+nextStation+'역</a>');
        }
      }) 
    }
    function getLists() {
      var url = location.href.split('/')[3];
      var decode = decodeURI(url);
      var id;
      $.ajax({
        type: "GET",
        url: "/names.ajax",
        success: function (result) {
          const ojb = JSON.parse(result).lines;
    
          $('#hoseon').empty();
          for (var i = 0; i < ojb.length; i++) {
            $('#hoseon').append(
              '<li id="'+ ojb[i].key +'">' +
              '<a class="nav-link" href="/' + ojb[i].key + '">' +
              '<i class="material-icons">train</i>' +
              '<p><h4>' +
                ojb[i].value +
              '</h4></p>' +
              '</a>' +
              '</li>'
            )
            if(decode == ojb[i].key){
              id = ojb[i].key;
            }
          }
          $('#'+id).attr('class','active');
        }
      })
    }
    function getdata(){
      var subId = $('#sub').val();
      var name = $('#stName').val();
      $.ajax({
        type: "GET",
        url: "/data.ajax",
        data: { subwayId: subId,
                stnName: name },
        success: function (result) {
          $('#upname1').empty();
          $('#upnum1').empty();
          $('#upmsg1').empty();
          $('#dnname1').empty();
          $('#dnnum1').empty();
          $('#dnmsg1').empty();
          $('#upname2').empty();
          $('#upnum2').empty();
          $('#upmsg2').empty();
          $('#dnname2').empty();
          $('#dnnum2').empty();
          $('#dnmsg2').empty();

          var uplist1 = result[Object.keys(result)[1]][0];
          var uplist2 = result[Object.keys(result)[1]][1];
          var dnlist1 = result[Object.keys(result)[0]][0];
          var dnlist2 = result[Object.keys(result)[0]][1];

          var upcode1 = uplist1.arvlCd;
          var upcode2 = uplist2.arvlCd;
          var dncode1 = dnlist1.arvlCd;
          var dncode2 = dnlist2.arvlCd;

          $('#upname1').append(uplist1.trainLineNm);
          $('#upnum1').append(uplist1.btrainNo);

          $('#dnname1').append(dnlist1.trainLineNm);
          $('#dnnum1').append(dnlist1.btrainNo);

          $('#upname2').append(uplist2.trainLineNm);
          $('#upnum2').append(uplist2.btrainNo);

          $('#dnname2').append(dnlist2.trainLineNm);
          $('#dnnum2').append(dnlist2.btrainNo);

          if(upcode1==99){
            $('#upmsg1').append(time(uplist1.barvlDt));
          }else{
            $('#upmsg1').append(uplist1.arvlMsg2);
          }

          if(dncode1==99){
            $('#dnmsg1').append(time(dnlist1.barvlDt));
          }else{
            $('#dnmsg1').append(dnlist1.arvlMsg2);
          }

          if(upcode2==99){
            $('#upmsg2').append(time(uplist2.barvlDt));
          }else{
            $('#upmsg2').append(uplist2.arvlMsg2);
          }

          if(dncode2==99){
            $('#dnmsg2').append(time(dnlist2.barvlDt));
          }else{
            $('#dnmsg2').append(dnlist2.arvlMsg2);
          }   
        }
      })
    }

    function time(value){
        var min = Math.floor(value/60)+1;
        var str = min + '분 후 도착';
        return str;
    }

    function pulling() {
      setInterval(function(){
        getdata();
      },30000);
    }

  </script>
</head>

<input type="hidden" id="sub" value="${subId}">
<input type="hidden" id="stName"value="${stnName}" >

<body class="dark-edition">
  <div class="wrapper ">
    <div class="sidebar" data-color="purple" data-background-color="black" data-image="../assets/img/sidebar-2.jpg">
      <!--
        Tip 1: You can change the color of the sidebar using: data-color="purple | azure | green | orange | danger"

        Tip 2: you can also add an image using data-image tag
    -->
      <div class="logo">
        <a href="/" class="simple-text logo-normal">
          <h3><span class="tim-note">서울 지하철 노선</span></h3>
        </a>
      </div>
      <div class="sidebar-wrapper">
        <ul class="nav" id="hoseon">
          <!-- 지하철 노선 정보 표시 -->
        </ul>
      </div>
    </div>

    <div class="main-panel">
      <!-- Navbar -->
      <nav class="navbar navbar-expand-lg navbar-transparent navbar-absolute fixed-top " id="navigation-example">
        <div class="container-fluid">
          <div class="navbar-wrapper">
            <a class="navbar-brand" href="javascript:void(0)">
              <h3><span class="tim-note">도착 정보</span></h3>
            </a>
          </div>
          <button class="navbar-toggler" type="button" data-toggle="collapse" aria-controls="navigation-index"
            aria-expanded="false" aria-label="Toggle navigation" data-target="#navigation-example">
            <span class="sr-only">Toggle navigation</span>
            <span class="navbar-toggler-icon icon-bar"></span>
            <span class="navbar-toggler-icon icon-bar"></span>
            <span class="navbar-toggler-icon icon-bar"></span>
          </button>
          <div class="collapse navbar-collapse justify-content-end">
            <form class="navbar-form" action="../${subId}/">
              <div class="input-group no-border">
                <input type="hidden" name="hoseon" value="${subId}">
                <input type="text" id="stnName" class="form-control" placeholder="Search...">
                <button type="submit" class="btn btn-default btn-round btn-just-icon">
                  <i class="material-icons">search</i>
                  <div class="ripple-container"></div>
                </button>
              </div>
            </form>
            <ul class="navbar-nav">
              <li class="nav-item">
                <a class="nav-link" href="javascript:void(0)">
                  <i class="material-icons">dashboard</i>
                  <p class="d-lg-none d-md-block">
                    Stats
                  </p>
                </a>
              </li>
              <li class="nav-item dropdown">
                <a class="nav-link" href="javscript:void(0)" id="navbarDropdownMenuLink" data-toggle="dropdown"
                  aria-haspopup="true" aria-expanded="false">
                  <i class="material-icons">notifications</i>
                  <span class="notification">237</span>
                  <p class="d-lg-none d-md-block">
                    Some Actions
                  </p>
                </a>
                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
                  <a class="dropdown-item" href="javascript:void(0)">Mike John responded to your email</a>
                </div>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="javascript:void(0)">
                  <i class="material-icons">person</i>
                  <p class="d-lg-none d-md-block">
                    Account
                  </p>
                </a>
              </li>
            </ul>
          </div>
        </div>
      </nav>
      <!-- End Navbar -->
      <div class="content">
        <div class="container-fluid">
          <div class="row" id="stn">
            <!-- 지하철역 버튼 생성 -->
          </div>

          <div class="row">
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6">
              <div class="card card-plain">
                <div class="card-header card-header-primary">
                  <h2 style="text-align: center;" class="card-title mt-0" id="prev">
                    
                  </h2>
                </div>
              </div>
            </div>
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6">
              <div class="card card-plain">
                <div class="card-header card-header-primary">
                  <h2 style="text-align: center;" class="card-title mt-0" id="on">
                    
                  </h2>
                </div>
              </div>
            </div>
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6">
              <div class="card card-plain">
                <div class="card-header card-header-primary">
                  <h2 style="text-align: center;" class="card-title mt-0" id="next">
                    
                  </h2>
                </div>
              </div>
            </div>
          </div>

          <div class="row">

            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">
              <div class="card card-stats">
                <div class="card-header card-header-success card-header-icon" id="upResult">
                  <div class="card-icon">
                    <i class="material-icons">subway</i>
                  </div>
                  <p class="card-category">
                    <h2 style="text-align: left; color: #ffffff;" class="card-title">이번 열차</h2>
                  </p><br>
                  <h2 style="text-align: center; color: #ffffff;" class="card-title" id="upname1">
                  </h2><br>
                  <h1 style="text-align: center; color: #ffffff;" class="card-title" id="upnum1">
                  </h1>
                  <h2 style="text-align: right; color: #ffffff;" class="card-title" id="upmsg1">
                  </h2><br>

                </div>
              </div>
            </div>

            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">
              <div class="card card-stats">
                <div class="card-header card-header-success card-header-icon" id="upResult">
                  <div class="card-icon">
                    <i class="material-icons">subway</i>
                  </div>
                  <p class="card-category">
                    <h2 style="text-align: left; color: #ffffff;" class="card-title">이번 열차</h2>
                  </p><br>
                  <h2 style="text-align: center; color: #ffffff;" class="card-title"id="dnname1">
                  </h2><br>
                  <h1 style="text-align: center; color: #ffffff;" class="card-title"id="dnnum1">
                  </h1>
                  <h2 style="text-align: right; color: #ffffff;" class="card-title" id="dnmsg1">
                  </h2><br>

                </div>
              </div>
            </div>

          </div>

          <div class="row">

            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">
              <div class="card card-stats">
                <div class="card-header card-header-success card-header-icon" id="upResult">
                  <div class="card-icon">
                    <i class="material-icons">subway</i>
                  </div>
                  <p class="card-category">
                    <h3 style="text-align: left; color: #ffffff;" class="card-title">다음 열차</h3>
                  </p><br>
                  <h3 style="text-align: center; color: #ffffff;" class="card-title"id="upname2"></h3>
                  <h2 style="text-align: center; color: #ffffff;" class="card-title"id="upnum2">
                  </h2>
                  <h3 style="text-align: right; color: #ffffff;" class="card-title" id="upmsg2">
                  </h3><br>

                </div>
              </div>
            </div>

            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">
              <div class="card card-stats">
                <div class="card-header card-header-success card-header-icon" id="upResult">
                  <div class="card-icon">
                    <i class="material-icons">subway</i>
                  </div>
                  <p class="card-category">
                    <h3 style="text-align: left; color: #ffffff;" class="card-title">다음 열차</h3>
                  </p><br>
                  <h3 style="text-align: center; color: #ffffff;" class="card-title"id="dnname2"></h3>
                  <h2 style="text-align: center; color: #ffffff;" class="card-title"id="dnnum2">
                  </h2>
                  <h3 style="text-align: right; color: #ffffff;" class="card-title" id="dnmsg2">
                  </h3><br>

                </div>
              </div>
            </div>

          </div>

          <footer class="footer">
            <div class="container-fluid">
              <div class="copyright float-right" id="date">
                , made with <i class="material-icons">favorite</i> by
                <a href="/" target="_blank">syjeon@ntels.com</a>
              </div>
            </div>
          </footer>

          <script>
            const x = new Date().getFullYear();
            let date = document.getElementById('date');
            date.innerHTML = '&copy; ' + x + date.innerHTML;
          </script>

        </div>

        <!--   Core JS Files   -->
        <script src="../assets/js/core/jquery.min.js"></script>
        <script src="../assets/js/core/popper.min.js"></script>
        <script src="../assets/js/core/bootstrap-material-design.min.js"></script>
        <script src="https://unpkg.com/default-passive-events"></script>
        <script src="../assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
        <!-- Place this tag in your head or just before your close body tag. -->
        <script async defer src="https://buttons.github.io/buttons.js"></script>
        <!--  Google Maps Plugin    -->
        <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
        <!-- Chartist JS -->
        <script src="../assets/js/plugins/chartist.min.js"></script>
        <!--  Notifications Plugin    -->
        <script src="../assets/js/plugins/bootstrap-notify.js"></script>
        <!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
        <script src="../assets/js/material-dashboard.js?v=2.1.0"></script>
        <!-- Material Dashboard DEMO methods, don't include it in your project! -->
        <script src="../assets/demo/demo.js"></script>
        <script>
          $(document).ready(function () {
            $().ready(function () {
              $sidebar = $('.sidebar');

              $sidebar_img_container = $sidebar.find('.sidebar-background');

              $full_page = $('.full-page');

              $sidebar_responsive = $('body > .navbar-collapse');

              window_width = $(window).width();

              $('.fixed-plugin a').click(function (event) {
                // Alex if we click on switch, stop propagation of the event, so the dropdown will not be hide, otherwise we set the  section active
                if ($(this).hasClass('switch-trigger')) {
                  if (event.stopPropagation) {
                    event.stopPropagation();
                  } else if (window.event) {
                    window.event.cancelBubble = true;
                  }
                }
              });

              $('.fixed-plugin .active-color span').click(function () {
                $full_page_background = $('.full-page-background');

                $(this).siblings().removeClass('active');
                $(this).addClass('active');

                var new_color = $(this).data('color');

                if ($sidebar.length != 0) {
                  $sidebar.attr('data-color', new_color);
                }

                if ($full_page.length != 0) {
                  $full_page.attr('filter-color', new_color);
                }

                if ($sidebar_responsive.length != 0) {
                  $sidebar_responsive.attr('data-color', new_color);
                }
              });

              $('.fixed-plugin .background-color .badge').click(function () {
                $(this).siblings().removeClass('active');
                $(this).addClass('active');

                var new_color = $(this).data('background-color');

                if ($sidebar.length != 0) {
                  $sidebar.attr('data-background-color', new_color);
                }
              });

              $('.fixed-plugin .img-holder').click(function () {
                $full_page_background = $('.full-page-background');

                $(this).parent('li').siblings().removeClass('active');
                $(this).parent('li').addClass('active');


                var new_image = $(this).find("img").attr('src');

                if ($sidebar_img_container.length != 0 && $('.switch-sidebar-image input:checked').length != 0) {
                  $sidebar_img_container.fadeOut('fast', function () {
                    $sidebar_img_container.css('background-image', 'url("' + new_image + '")');
                    $sidebar_img_container.fadeIn('fast');
                  });
                }

                if ($full_page_background.length != 0 && $('.switch-sidebar-image input:checked').length != 0) {
                  var new_image_full_page = $('.fixed-plugin li.active .img-holder').find('img').data('src');

                  $full_page_background.fadeOut('fast', function () {
                    $full_page_background.css('background-image', 'url("' + new_image_full_page + '")');
                    $full_page_background.fadeIn('fast');
                  });
                }

                if ($('.switch-sidebar-image input:checked').length == 0) {
                  var new_image = $('.fixed-plugin li.active .img-holder').find("img").attr('src');
                  var new_image_full_page = $('.fixed-plugin li.active .img-holder').find('img').data('src');

                  $sidebar_img_container.css('background-image', 'url("' + new_image + '")');
                  $full_page_background.css('background-image', 'url("' + new_image_full_page + '")');
                }

                if ($sidebar_responsive.length != 0) {
                  $sidebar_responsive.css('background-image', 'url("' + new_image + '")');
                }
              });

              $('.switch-sidebar-image input').change(function () {
                $full_page_background = $('.full-page-background');

                $input = $(this);

                if ($input.is(':checked')) {
                  if ($sidebar_img_container.length != 0) {
                    $sidebar_img_container.fadeIn('fast');
                    $sidebar.attr('data-image', '#');
                  }

                  if ($full_page_background.length != 0) {
                    $full_page_background.fadeIn('fast');
                    $full_page.attr('data-image', '#');
                  }

                  background_image = true;
                } else {
                  if ($sidebar_img_container.length != 0) {
                    $sidebar.removeAttr('data-image');
                    $sidebar_img_container.fadeOut('fast');
                  }

                  if ($full_page_background.length != 0) {
                    $full_page.removeAttr('data-image', '#');
                    $full_page_background.fadeOut('fast');
                  }

                  background_image = false;
                }
              });

              $('.switch-sidebar-mini input').change(function () {
                $body = $('body');

                $input = $(this);

                if (md.misc.sidebar_mini_active == true) {
                  $('body').removeClass('sidebar-mini');
                  md.misc.sidebar_mini_active = false;

                  $('.sidebar .sidebar-wrapper, .main-panel').perfectScrollbar();

                } else {

                  $('.sidebar .sidebar-wrapper, .main-panel').perfectScrollbar('destroy');

                  setTimeout(function () {
                    $('body').addClass('sidebar-mini');

                    md.misc.sidebar_mini_active = true;
                  }, 300);
                }

                // we simulate the window Resize so the charts will get updated in realtime.
                var simulateWindowResize = setInterval(function () {
                  window.dispatchEvent(new Event('resize'));
                }, 180);

                // we stop the simulation of Window Resize after the animations are completed
                setTimeout(function () {
                  clearInterval(simulateWindowResize);
                }, 1000);

              });
            });
          });
        </script>
</body>

</html>
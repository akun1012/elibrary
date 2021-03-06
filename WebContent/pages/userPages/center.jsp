<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.akun.elibrary.bean.Libuser"%><html>
<head>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/userPages_main.css" />
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>LMS</title>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.ui.css" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery.ui.js"></script>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ext/resources/css/ext-all.css" />
  <link rel="stylesheet" type="text/css" href="" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/ext/adapter/ext/ext-base.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/ext/ext-all.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/ext/src/locale/ext-lang-zh_CN.js"></script>
  <script type="text/javascript">
  
  
	  <% if (session.getAttribute("userInfo") == null) { %>
	     alert("Only open to platform user.Please retry after logged in.");
	     window.location = "<%=request.getContextPath()%>/pages/userPages/userPage.jsp";
	  <% } %>
	  function loadpage(href) {
		  $("#content_page").load(href, function(response, status, xhr) {
	        if (status == "error") {
	          $("#content_page").load("<%=request.getContextPath()%>/pages/404.jsp");
	        }
	      });
		} 
	  //implement side bar and navigation bar by Jquery
    $(document).ready(function() {
      $("#navi>ul>li").mouseover(function() {
        $(this).children("ul").removeClass();
      });
      $("#navi>ul>li").mouseleave(function() {
        $(this).children("ul").addClass("hide");
      });
      $("#sidebar>ul>li>a").click(function() {
        $(this).parents("li").find("ul").toggle();
      });

      $("#content_page").load("<%=request.getContextPath()%>/pages/adminPages/welcome.jsp?rd=" + Math.random());

      $("#sidebar a").click(function($e) {
        $e.preventDefault();
        if ($(this).attr("href") == "javascript:void(0)") {
          return false;
        } else {
          $("#content_page").load($(this).attr("href") + "?rd=" + Math.random(), function(response, status, xhr) {
            if (status == "error") {
              $("#content_page").load("<%=request.getContextPath()%>/pages/adminPages/404.jsp");
            }
          });
        }
      });
    });
    Ext.ux.ThemeChange = Ext.extend(Ext.form.ComboBox,{
        editable : false,
        displayField : 'theme',
        valueField : 'css',
        typeAhead : true,
        mode : 'local',
        value : 'default',
        readonly : true,
        width:50,
        triggerAction : 'all',
        selectOnFocus : true,
        initComponent : function(){
                var themes = [
                                ['default', 'xtheme-gray.css'],
                                ['black', 'xtheme-black.css'],
                                ['darkgray', 'xtheme-darkgray.css'],
                                ['blue', 'ext-all.css'],
                                ['green', 'xtheme-green.css'],
                                ['olive', 'xtheme-olive.css'],
                                ['pink', 'xtheme-pink.css'],
                                ['purple', 'xtheme-purple.css'],
                                ['slate', 'xtheme-slate.css'],
                                ['indigo', 'xtheme-indigo.css'],
                                ['slickness', 'xtheme-slickness.css'],
                                ['midnight', 'xtheme-midnight.css']
                ];
                this.store = new Ext.data.SimpleStore({
                        fields : ['theme', 'css'],
                        data : themes
                });
        },
        initEvents : function(){
                this.on('collapse', function(){
                        var name = this.getValue();
                        var date = new Date();
                        date.setTime(date.getTime() + 30*24*3066*1000);
                        document.cookie = "css=" + name + ";expires=" + date.toGMTString();
 
                        Ext.util.CSS.swapStyleSheet('theme', '../../ext/resources/css/'+ name);
                });
        }
});
Ext.reg('xthemeChange', Ext.ux.ThemeChange);
 
Ext.onReady(function(){
        var cookiesArr = document.cookie.split(";");
        var cssName = "";
 
        for(var i=0; i<cookiesArr.length; i++){
                var arr = cookiesArr[i].split("=");
                if(arr[0] == "css"){
                        cssName = arr[1];
                        break;
                }
        };
 
        var themeList = new Ext.ux.ThemeChange();
 
        if(cssName != ""){
                Ext.util.CSS.swapStyleSheet('theme', "../../ext/resources/css/" + cssName);
                themeList.setValue(cssName);
        }
 
        //instantiate component to change theme
        var pan = new Ext.Panel({
                title:'change theme',
                items: themeList,
                headerAsText:false,
                header:false
                //height:20,
               // width:50
        });
        pan.render("navi");
});
  </script>
</head>
<body>
  <div class="header_bg">
    <div id="header">
      <div id="hd_logo"><span></span></div>
      <div id="hd_banner"><span>Library Management System</span></div>
      <div style="position:absolute; bottom:2px; right:8px">
        <% Libuser userInfo = new Libuser(); if(null != session.getAttribute("userInfo")) { userInfo = (Libuser) session.getAttribute("userInfo"); } %>
        <span style="color:white">Welcome,staff:<%=userInfo.getUsername()%>！</span><a style="color:lightblue" href="<%=request.getContextPath()%>/logout.action">log off</a>
      </div>
    </div>
  </div>
  <div class="navi_bg">
    <div id="navi">
      <ul>
        <li>
          <a href="<%=request.getContextPath()%>/pages/userPages/center.jsp">Homepage</a>
        </li>
        <li>
          <a href="javascript:void(0)">platform introdution</a>
          <ul class="hide">
            <li><a href="javascript:void(0)">home</a></li>
            <li><a href="javascript:void(0)">instruction</a></li>
            <li><a href="javascript:void(0)">contact</a></li>
            <li><a href="javascript:void(0)">management</a></li>
          </ul>
        </li>
        <li>
          <a href="javascript:void(0)">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          
          change theme</a>
        </li>
      </ul>
    </div>
  </div>
  <div class="container_bg">
    <div id="container">
      <div id="sidebar">
        <ul>
          <li>
            <a href="javascript:void(0)">borrow operation</a>
            <ul>
              <li>
            <a href="<%=request.getContextPath()%>/pages/userPages/borrowInfo.jsp">borrow</a>
          </li>
          <li>
            <a href="<%=request.getContextPath()%>/pages/userPages/returnBorrowInfo.jsp">return</a>
          </li>
            </ul>
          </li>
          
          <li>
            <a href="javascript:void(0)">information search</a>
            <ul>
              <li><a href="<%=request.getContextPath()%>/pages/adminPages/borrowList.jsp">borrowinfo list</a></li>
              <li><a href="<%=request.getContextPath()%>/pages/adminPages/borrowLiteratureList.jsp">bookinfo search</a></li>
              <li><a href="<%=request.getContextPath()%>/pages/userPages/literatureList.jsp">book list</a></li>
            </ul>
          </li>
          <li>
            <a href="javascript:void(0)">personal information</a>
            <ul>
              <li><a href="<%=request.getContextPath()%>/pages/adminPages/libuserChangePwd.jsp">change password</a></li>
            </ul>
          </li>
        </ul>
      </div>
      <div id="content_page"><span></span></div>
      <div style="clear:both;"></div>
    </div>
  </div>

  <div class="footer_bg">
    <div id="footer">
      <div style="width:960px">
        <div id="f_police">
          <img alt="police" src="<%=request.getContextPath()%>/images/book.jpg"></img>
        </div>
        <div id="f_copyright_cn">
          <span>&nbsp;&nbsp;&nbsp;&nbsp;Tel: 480-321-6877</span>　<br/><br/>　
          <span>Email：zyang64@asu.edu</span><br/>
        </div>
        <div id="f_contentus">
          <span>&ensp;Arizona State University</span><br /><br />
          <span>&ensp;<a href="<%=request.getContextPath()%>/pages/studentPages/studentPage.jsp"><font color="white">Front Page Entrance</font></a>&nbsp;|&nbsp;
     <a href="<%=request.getContextPath()%>/pages/adminPages/login.jsp">System Admin Entrance</a></span>
        </div>
        <div style="clear:both"></div>
      </div>
      <!-- <div id="f_copyright_en">
        <span>Copyright © 2012 - 2013 Zongkun Yang All Rights Reserved.</span><br /><span>ASU Zongkun Yang</span>     
      </div> -->
    </div>    
  </div>	
</body>
</html>
<%--
  Created by IntelliJ IDEA.
  User: Laomuzhu
  Date: 3/6/2019
  Time: 11:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--头部的导航条--%>
    <div class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <a href="http://localhost:8080/books/list" class="navbar-brand">网络爽文网</a>
                <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-main">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <div class="navbar-collapse collapse" id="navbar-main">
                <ul class="nav navbar-nav">
                    <li>
                        <a href="${pageContext.request.contextPath}/books/list">书籍首页</a>
                    </li>
                    <li>
                        <a href="https://cn.bing.com">试试Bing?很爽的</a>
                    </li>
                </ul>
                <%--登录使用ajax处理，注册使用新页面处理--%>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="${pageContext.request.contextPath}/users/registerPage" target="_blank">注册</a></li>
                    <li><a role="button" id="login" >登录</a></li>
                    <li>
                        <%--增加一个用户登录后的下拉菜单--%>
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Dropdown
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="#dropdown1" data-toggle="tab">查看订阅</a></li>
                            <li class="divider"></li>
                            <li><a href="#dropdown2" data-toggle="tab">修改密码</a></li>
                            <li class="divider"></li>
                            <li><a href="#dropdown3" data-toggle="tab">退出登录</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>

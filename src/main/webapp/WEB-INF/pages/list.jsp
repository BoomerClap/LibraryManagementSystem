<%--
  Created by IntelliJ IDEA.
  User: Laomuzhu
  Date: 3/1/2019
  Time: 10:47 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>图书列表</title>
    <%@include file="common/head.jsp"%>
    <%--<link href="/css/bootstrap.min.css" rel="stylesheet" type="text/css">--%>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <%--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">--%>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <%--头部导航条--%>
        <c:import url="common/nav.jsp" charEncoding="utf-8"></c:import>

        <div class="container">
            <div class="page-header" id="banner">
                <div class="row">
                    <div class="col-lg-6">
                        <h1>图书列表</h1>
                        <p class="lead">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            学习使人进步</p>
                    </div>
                    <div class="col-lg-6">
                    </div>
                </div>

                <div class="bs-docs-section clearfix">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="bs-example">
                                <div class="navbar navbar-inverse">
                                    <div class="navbar-collapse collapse navbar-inverse-collapse">
                                        <form class="navbar-form navbar-left" action="<%= request.getContextPath()%>/books/search", methods="get">
                                            <input type="text" class="form-control col-lg-8" placeholder="Search" name="name" value="${name}"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <%--将搜索功能整理上来--%>
                                        <%--<a class="form-control col-lg-8" href="<%= request.getContextPath()%>/books/search?name=", methods="get">查找图书</a>--%>
                                        <input class="form-control col-lg-6 warning" type="submit" id="tabSub" value="检索" />
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="panel-body">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>图书ID</th>
                    <th>图书名称</th>
                    <th>馆藏数量</th>
                    <th>详细</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${bookList}" var="book">
                    <tr>
                        <td>${book.book_id}</td>
                        <td>${book.name}</td>
                        <td>${book.number}</td>
                        <td><a class="btn btn-info" href="/books/${book.book_id}/detail " target="_blank">详细</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <%--登录弹窗--%>
        <c:import url="common/loginDialog.jsp" charEncoding="UTF-8"></c:import>

        <%--登录成功提示框--%>
        <div class="modal fade" id="loginSuccess" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            ×
                        </button>
                        <h4 class="modal-title">登录提示：</h4>
                    </div>
                    <div class="modal-body">
                        <div class="input-group">
                            <h2>登录成功！</h2>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="loginSuccessBtn" type="button" class="btn btn-success" data-dismiss="modal">确定</button>
                    </div>
                </div>
            </div>
        </div>

    </div>

</body>
    <script src="/js/jquery-3.0.0.min.js" type="text/javascript"></script>
    <script src="/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="/js/jquery_cookie.min.js" type="text/javascript"></script>

    <%--使用里面的验证方法--%>
    <script src="/myScript/bookappointment.js" type="text/javascript"></script>

    <script type="text/javascript">
        <%--点击登录按钮时弹出登录框--%>
        $(document).ready(function () {
            $("#login").click(function () {
                $("#loginModalId").modal({
                    show:true
                });
            });

            //在弹出的对话框中点击了登录按钮，首先进行校验，然后判断是否登录成功，登录成功后在右上角显示姓名并有个下拉菜单提供操作。
            $("#LoginBtn").click(function () {
                var student_id = $("#student_idKey").val();
                var password = $("#passwordKey").val();
                console.log("登录框中学号密码：" + student_id + "--" + password);
                //登录成功时返回true
                var result = bookAppointment.varifyWithDatabase(student_id, password);
                if (result == true){
                    $("#loginSuccess").modal({show:true});
                    $("#loginSuccessBtn").click(function () {
                        window.location.reload(true);
                    });
                }
            });


        });


    </script>

</html>

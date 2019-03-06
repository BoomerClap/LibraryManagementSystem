<%--
  Created by IntelliJ IDEA.
  User: Laomuzhu
  Date: 3/6/2019
  Time: 12:15 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp"%>
<html>
<head>
    <%@include file="common/head.jsp"%>
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <div class="bs-docs-section">
            <div class="row">
                <div class="col-lg-6">
                    <div class="well">
                        <form class="bs-example form-horizontal" action="${pageContext.request.contextPath}/users/register" method="post">
                            <fieldset>
                                <legend>注册</legend>
                                <div class="form-group">
                                    <label for="inputId" class="col-lg-2 control-label">学号</label>
                                    <div class="col-lg-9">
                                        <input name="student_id" type="text" class="form-control" id="inputId" placeholder="请输入学号">
                                    </div>
                                    <%--表单校验不满足要求时显示--%>
                                    <%--学号为空--%>
                                    <label id="idNull" class="col-sm-2 control-label modal" style="color: red">学号不能为空</label>
                                    <%--格式或长度不匹配--%>
                                    <label id="idTypeError" class="col-sm-3 control-label modal" style="color: red">请输入正确的学号</label>
                                </div>
                                <div class="form-group">
                                    <label for="inputPassword" class="col-lg-2 control-label">密码</label>
                                    <div class="col-lg-9">
                                        <input name="password" type="password" class="form-control" id="inputPassword" placeholder="请输入6位数字密码">
                                    </div>
                                    <label id="passwordTypeError" class="col-lg-2 control-label modal" style="color: red">密码格式错误</label>
                                </div>
                                <div class="form-group">
                                    <label for="inputName" class="col-lg-2 control-label">密码</label>
                                    <div class="col-lg-9">
                                        <input name="name" type="text" class="form-control" id="inputName" placeholder="请输入姓名">
                                    </div>
                                    <label id="nameNull" class="col-lg-2 control-label modal" style="color: red">姓名不能为空</label>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-10 col-lg-offset-2">
                                        <button id="cancelBtn" class="btn btn-default">取消</button>
                                        <button id="submitBtn" type="submit" class="btn btn-primary">注册</button>
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
    <script src="/js/jquery-3.0.0.min.js" type="text/javascript"></script>
    <script src="/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            //点击取消按钮时自动关闭该页面
            $("#cancelBtn").click(function () {
                window.close();
            });
        });
    </script>

    <%--进行注册时的表单校验，注册成功时弹出对话框注册成功，并刷新页面--%>
<%--使用bookappointment.js中的方法进行验证--%>
    <script type="text/javascript">
        $("document").ready(function () {
            $("#submitBtn").click(function () {
                if($("#inputId").value().length == 0){
                    alert("学号为空");
                    return false;
                }else if ($("#inputId").value.length != 10){    //应该使用正则表达式判断一下有没有存在非数字的情况
                    alert("长度不对");
                    return false;
                }else if ($("#inputPassword").value.length != 6) {
                    alert("密码长度不对");
                    return false;
                }else {
                    return true;
                }
            });
        })
    </script>
</html>

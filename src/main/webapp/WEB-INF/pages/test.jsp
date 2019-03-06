<%--
  Created by IntelliJ IDEA.
  User: Laomuzhu
  Date: 3/3/2019
  Time: 11:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%--测试获取ajax提交的数据的方式--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp"%>
<html>
<head>
    <title>test</title>
    <%@include file="common/head.jsp"%>
    <%--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">--%>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <button class="btn btn-sm bg-warning" id="btnTest">
            来了老弟
        </button>
    </div>
</body>

    <%--<script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>--%>
    <%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>--%>
    <script src="/js/jquery-3.0.0.min.js" type="text/javascript"></script>
    <script src="/js/bootstrap.min.js" type="text/javascript"></script>
<script type="text/javascript">
        $(document).ready(function () {
           $("#btnTest").click(function(){
               console.log("发起ajax请求");
               var params = {student_id:222200222, password:123};
               $.ajax({
                   url:"${pageContext.request.contextPath}/books/check",
                   data:params,
                   type:"POST",
                   contentType:"application/x-www-form-urlencoded",
                   dataType:"json",
                   async: false,
                   success:function (data) {
                       alert("成功接收到服务器返回信息");
                   }
               });
                console.log("请求结束");
           });
        });
    </script>
</html>

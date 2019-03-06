<%--
  Created by IntelliJ IDEA.
  User: Laomuzhu
  Date: 3/4/2019
  Time: 12:13 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp"%>
<html>
<head>
    <%@include file="common/head.jsp"%>
    <title>您已经预约的书籍</title>
    <%--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">--%>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
    <script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</head>
<body>
    <div class="container">
        <%--判断是否预约了图书--%>
        <c:choose>
            <c:when test="${empty bookList}">
                <script>
                    $(document).ready(function () {setTimeout(function () {window.close();},2000);})
                </script>
                <div>
                    <div class="modal fade" id="bookListNull" tabindex="-1" role="dialog" aria-hidden="true" name="empty">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-body">
                                    <div class="input-group">
                                        <h2>您尚未预约任何书籍！三秒后自动关闭本窗口</h2>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <h2>您已经预约的书籍</h2>
                <hr/>

                <table class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <td>书籍ID</td>
                            <th>图书名称</th>
                            <th>图书简介</th>
                            <th>操作</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach items="${bookList}" var="book">
                            <tr>
                                <td>${book.book_id}</td>
                                <td>${book.name}</td>
                                <td>${book.introd}</td>
                                <td><a href="/books/${book.book_id}/${cookie.get("student_id").value}/cancelAppointment" type="button" class="btn btn-sm btn-success">取消预约</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</body>

    <%--<script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>--%>
    <%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>--%>
    <script src="/js/jquery-3.0.0.min.js" type="text/javascript"></script>
    <script src="/js/bootstrap.min.js" type="text/javascript"></script>
    <script>
        $(document).ready(function () {
           $("#bookListNull").modal({
               //显示弹出层
               show:true,
               backdrop:"static"
           });
        });
    </script>
</html>

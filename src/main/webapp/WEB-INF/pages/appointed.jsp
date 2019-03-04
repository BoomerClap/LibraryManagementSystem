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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>
<body>
    <div class="container">
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
    </div>
</body>
</html>

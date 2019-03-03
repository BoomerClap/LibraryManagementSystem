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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>
<body>
    <div class="container">
        <div class="panel panel-default">
            <div class="panel-heading text-center">
                <h2>图书列表</h2>
            </div>
            <form name="firstForm" action="<%= request.getContextPath()%>/books/search" method="get">
                <div class="panel-heading ">
                    <table class="table table-bookName">
                        <thead>
                        <tr>
                            <th width="90" align="left">图书名称：</th>
                            <th width="150" align="left">
                                <input type="text" name="name" class="allInput" value="${name}" placeholder="请输入检索书名" />
                            </th>
                            <th>
                                <input type="submit" id="tabSub" value="检索" />
                            </th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </form>


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


        </div>
    </div>

</body>

    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

</html>

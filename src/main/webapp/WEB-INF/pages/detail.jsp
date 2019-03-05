<%--
  Created by IntelliJ IDEA.
  User: Laomuzhu
  Date: 3/1/2019
  Time: 7:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookDetail</title>
    <%--<link href="/css/bootstrap.min.css" rel="stylesheet" type="text/css">--%>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

</head>
<body>
    <div class="container">
        <h2>书籍《${book.name}》详情</h2>
        <hr/>

        <div class="panel-body">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>图书ID</th>
                        <th>图书名称</th>
                        <th>图书简介</th>
                        <th>剩余数量</th>
                        <th>预约数量</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>${book.book_id}</td>
                        <td>${book.name}</td>
                        <td>${book.introd}</td>
                        <td>${book.number}</td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="penal-body text-center">
            <%--预约操作--%>
            <%--<a href="/books/{book_id}/varify" class="btn btn-primary success" id="varifyBtn">预约</a>--%>
            <a class="btn btn-primary success" id="varifyBtn">预约</a>

            <h2 class="text-danger">
                <!--用来展示预约控件-->
                <span class="glyphicon" id="appoint-box"></span> <!--在js里面调用这个id还可以动态显示一些其他东西，例如动态时间等（需要插件）-->

                <span class="glyphicon">
                    <%--已经被预约的图书--%>
                    <a class="btn btn-primary btn-lg" href="/books/appointed?student_id=${cookie["student_id"].value}" target="_blank">查看我的已预约书籍</a>
                </span>
            </h2>

        </div>
    </div>


    <div class="modal fade" id="loginModalId" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        ×
                    </button>
                    <h4 class="modal-title" id="myModalLabel">登录提示：</h4>
                </div>
                <div class="modal-body">
                    <div class="input-group">
                        <span class="input-group-addon" >帐号：</span>
                        <input type="text" class="input-sm" id="student_idKey" aria-describedby="basic-addon3" placeholder="请输入学号">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon" >密码：</span>
                        <input type="password" class="input-sm" id="passwordKey" aria-describedby="basic-addon3" placeholder="请输入密码">
                    </div>
                </div>
                <div class="modal-footer">
                    <span id="studentMessage" class="glyphicon"> </span>
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="LoginCancelBtn">取消</button>
                    <button type="button" class="btn btn-primary" id="LoginBtn">登录</button>
                </div>
            </div>
        </div>
    </div>

    <%--<button type="button" class="btn btn-blue nav-external animated hiding" id="loginBntId" hidden="true">点击登录...</button>--%>

    <%--<img src="/myScript/1.jpg" width="300px">--%>
</body>

    <script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
    <%--<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>--%>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    <%--使用CDN 获取公共js http://www.bootcdn.cn/--%>
    <%--jQuery Cookie操作插件--%>
    <script src="http://cdn.bootcss.com/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
    <%--jQuery countDown倒计时插件--%>
    <script src="http://cdn.bootcss.com/jquery.countdown/2.1.0/jquery.countdown.min.js"></script>

    <script src="/myScript/bookappointment.js" type="text/javascript"/>
    <script type="text/javascript">
        var bookAppointment = {
            //封装Ajax的url
            URL:{
                appoint:function (book_id, student_id) {
                    return "/books/" + book_id + "/appoint?student_id=" + student_id;
                },
                verify:function () {
                    return "/books" + "/verify";
                }
            },

            //验证学号和密码，先校验是否为空和校验格式，再去数据库中进行校验
            validateStudent:function (student_id, password) {
                if (student_id == null || password == null) {
                    return "nothing";
                }else if (student_id.length != 10 || password.length != 6 || isNaN(student_id) || isNaN(password)){
                    return "typeError"
                } else {
                    if (bookAppointment.varifyWithDatabase(student_id, password)){
                        console.log("校验数据库成功");
                        return "success";
                    }else {
                        console.log("校验失败");
                        return "misMatch";
                    }
                }
            },

            //将学号和用户名与数据库匹配
            varifyWithDatabase:function (student_id, password) {
                var result = false;
                var params = {};
                params.student_id = student_id;
                params.password = password;
                console.log(JSON.stringify(params));
                var verifyUrl = bookAppointment.URL.verify();
                $.ajax({
                    type:"POST",
                    url:verifyUrl,
                    //使用@requestParams获取参数，不需要转换json
                    data:params,
                    dataType:"json",
                    //这里使用@requestParams获取参数，需要设置成这样
                    contentType:"application/x-www-form-urlencoded",
                    //使用同步方式，保证先接收到服务器发来的校验结果，接收不到时，可以做登录超时处理
                    async:false,
                    success:function (data) {
                        if (data.result == "SUCCESS"){
                            // window.location.reload();
                            //弹窗登录成功
                            alert("登录成功");
                            result = true;
                            console.log("登录成功");

                        }else {
                            result = false;
                        }
                    }
                });
                console.log("匹配数据库验证结果:" + result);
                return result;
            },

            //预约的方法
            appointment:function (book_id, student_id, node) {
                console.log("执行预约的方法");
                //无用的预约按钮，已经整改，可删除
                // node.html("<button class='btn btn-primary btn-lg' id='appointmentBtn'>预约</button>");

                var appointmentUrl = bookAppointment.URL.appoint(book_id, student_id);
                console.log("预约图书请求地址:" + appointmentUrl);

                //绑定一次点击事件，即相当于自动点击，不需要了
                // $("#appointmentBtn").one("click", function () {
                    //执行预约请求
                    //1.先禁用请求
                    $(this).addClass("disable");

                    //2.发送预约请求，执行预约
                    console.log("发送Ajax预约图书请求")
                    $.post(
                        appointmentUrl,
                        {},
                        function (result) {
                        if (result && result["success"]) {
                            var appointResult = result["data"];
                            var state = result["state"];
                            var stateInfo = result["stateInfo"];

                //如何提示预约成功

                            alert(stateInfo);
                            node.html("<span class='label label-success'>" + stateInfo + "</span> ");
                        }
                        console.log("result:" + result);
                    });
                // });
            },

            //预定图书逻辑
            detail:{
                //预定图书初始化，session中有student_id时，才可以执行预约的操作
                init:function (params) {
                    //设置参数
                    var book_id = params["book_id"];
                    console.log("我是js文件");
                    var student_id = $.cookie("student_id");
                    var password = $.cookie("password");
                    //如果cookie中没有保存有用户名和密码
                    if (student_id == null || password == null){
                        console.log("session中没有学号，需要先登录");
                        //设置弹出层属性
                        var IdAndPassword = $("#loginModalId");
                        IdAndPassword.modal({
                            show:true,   //显示弹出层
                            backdrop:'static',    //禁止位置关闭
                            keyboard:false  //关闭键盘
                        });
                        //点击了登录按钮，将值传进来
                        $("#LoginBtn").click(function () {
                           student_id = $("#student_idKey").val();
                           password = $("#passwordKey").val();
                           console.log("登录框中的学号--密码：" + student_id + "--" + password);

                            //进行验证操作
                            //调用验证登录的函数验证用户id和密码
                            var temp = bookAppointment.validateStudent(student_id, password);
                            if (temp == "nothing"){
                                $("#studentMessage").hide().html("<label class='label label-danger'>学号或密码为空！</label>").show(300);
                            }else if (temp == "typeError") {
                                $("#studentMessage").hide().html("<label class='label label-danger'>学号或密码格式不正确！</label>").show(300);
                            }else if (temp == "misMatch"){
                                $("#studentMessage").hide().html("<label class='label label-danger'>学号或密码错误！</label>").show(300);
                            }else {
                                //绑定一次点击取消按钮事件，让登录框消失
                                $("#LoginCancelBtn").click();
                                //匹配正确时，将学号密码保存在cookie中，过期时间使用默认值
                                $.cookie("student_id", student_id, {path: "/books"});
                                $.cookie("password", password, {path: "/books"});

                                //跳转到预约逻辑,appoint-box是遗留的无用的，解释：
                                //在原版本中，一进入详细页面就执行登录操作，然后再给出预约按钮，点击预约按钮时才执行预约
                                //在此版本中，点击预约后再检测是否已经登录
                                var appointBox = $("#appoint-box")
                                bookAppointment.appointment(book_id, student_id, appointBox);
                            }
                        });
                    }else {
                        //保存了学号和密码，直接跳转到预约逻辑
                        if (student_id != null){
                            var appointBox = $("#appoint-box")
                            bookAppointment.appointment(book_id,student_id,appointBox);
                        }
                    }
                }
            }
        }
    </script>


    <script type="text/javascript">

        $(document).ready(function() {
            //点击预约按钮
            document.getElementById("varifyBtn").onclick = function() {
                //执行预约的操作
                bookAppointment.detail.init({book_id:${book.book_id}})
            }
        });
    </script>
</html>

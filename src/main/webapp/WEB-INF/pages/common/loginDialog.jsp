<%--
  Created by IntelliJ IDEA.
  User: Laomuzhu
  Date: 3/1/2019
  Time: 7:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--页面登录框--%>

<%--登录隐藏框--%>
<div class="modal fade" id="loginModalId" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button id="closeDialog" type="button" class="close" data-dismiss="modal" aria-hidden="true">
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

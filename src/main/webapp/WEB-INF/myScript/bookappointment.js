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
							//刷新页面
							window.location.reload();
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
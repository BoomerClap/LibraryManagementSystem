var bookappointment={
		//封装相关ajax的url
		URL:{
			appoint:function(book_id,student_id){
				return '/books/'+book_id+'/appoint?student_id='+student_id;
			},
			verify:function(){
				return '/books'+'/verify';
			}
		},
		
		//验证学号和密码
		validateStudent:function(student_id,password){
			console.log("student_id"+student_id);
			if(!student_id||!password){
				return "nothing";
			}else if(student_id.length!=10 ||isNaN(student_id)||password.length!=6 ||isNaN(password)){
				return "typerror";
			}else {
				if(bookappointment.verifyWithDatabase(student_id, password)){
					console.log("验证成功！");
					return "success";
				}else{
					console.log("验证失败！");
					return "mismatch";
				}
			}  
		},
		//将学号和用户名与数据库匹配
		verifyWithDatabase:function(student_id,password){
			var result=false;
			var params={};
			params.student_id=student_id;
			params.password=password;
			console.log("params.password:"+params.password);
			var verifyUrl=bookappointment.URL.verify();
			$.ajax({
				type:'post',
				url:verifyUrl,
				data:params,
				datatype:'josn', 
				async:false,                       //同步调用，保证先执行result=true,后再执行return result;
				success:function(data){
					if(data.result=='SUCCESS'){
						window.location.reload();
						//弹出登录成功！
						alert("登陆成功！");
						result=true;
					}else{
						result=false;
					}
				}
			});
			console.log("我是验证结果："+result);
			return result;
			
		},
		
		//预定图书逻辑
		detail:{
			//预定初始化
			init:function(params){
				var book_id=params['book_id'];
				console.log("我是js文件！");
				
				var student_id=$.cookie('student_id');
				var password=$.cookie('password');
				if(!student_id||!password){
					//设置弹出层属性
					var  IdAndPasswordModal=$('#varifyModal');
					IdAndPasswordModal.modal({
						show: true,//显示弹出层
	                    backdrop: 'static',//禁止位置关闭
	                    keyboard: false//关闭键盘事件
					});
					$('#studentBtn').click(function (){
						student_id=$('#student_idKey').val();
							console.log("student_id:"+student_id);
						password=$('#passwordKey').val();
							console.log("password:"+password);
						//调用validateStudent函数验证用户id和密码。
						var temp=bookappointment.validateStudent(student_id,password);
						console.log(temp);
						if(temp=="nothing"){
							$('#studentMessage').hide().html('<label class="label label-danger">学号或密码为空!</label>').show(300);
						}else if(temp=="typerror"){
							$('#studentMessage').hide().html('<label class="label label-danger">格式不正确!</label>').show(300);
						}else if(temp=="mismatch"){
							console.log("已经调用验证函数！");
							$('#studentMessage').hide().html('<label class="label label-danger">学号密码不匹配!</label>').show(300);
						}else if(temp=="success"){
							 //学号与密码匹配正确，将学号密码保存在cookie中。不设置cookie过期时间，这样即为session模式，关闭浏览器就不保存密码了。
							$.cookie('student_id', student_id, {  path: '/books'});
							$.cookie('password', password, {  path: '/books'}); 
							// 跳转到预约逻辑 
							var appointbox=$('#appoint-box');
							bookappointment.appointment(book_id,student_id,appointbox);
						}
					}); 
				}else{
					var appointbox=$('#appoint-box');
					bookappointment.appointment(book_id,student_id,appointbox);
				} 
			}	
		},
		appointment:function(book_id,student_id, node){
			console.log("我执行预约的方法!" );
			node.html('<button class="btn btn-primary btn-lg" id="appointmentBtn">预约</button>');
			  
			var appointmentUrl = bookappointment.URL.appoint(book_id,student_id);
			console.log("appointmentUrl:"+appointmentUrl);
			//绑定一次点击事件
			$('#appointmentBtn').one('click', function () {
				//执行预约请求
				//1、先禁用请求
				$(this).addClass('disabled');
				//2、发送预约请求执行预约
				$.post(appointmentUrl,{},function(result){   //Ajax强大之处，向Controller方法提出请求和返回结果在一处!
					if(result && result['success']){         //同时还可以连续取对象的子对象！
						var appointResult=result['data'];
							console.log("appointResult"+appointResult);
						var state=appointResult['state'];
							console.log("state"+state);
						var stateInfo=appointResult['stateInfo'];
							console.log("stateInfo"+stateInfo);
						//显示预约结果                                                          把结果显示给页面，完成了jsp的工作
							 
						node.html('<span class="label label-success">'+stateInfo+'</span>');
					}       //因为公用一个node所以，用来显示“stateInfo”时就不会显示上面的“预约”
					console.log('result'+result);
				});
			 });
			
			
		}
}
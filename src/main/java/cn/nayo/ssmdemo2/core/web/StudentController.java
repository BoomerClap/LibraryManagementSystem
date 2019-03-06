package cn.nayo.ssmdemo2.core.web;/*
  @auther laomuzhu
  @DESCRIPTION 控制层的用户控制
  @creat 3/6/2019
*/

import cn.nayo.ssmdemo2.core.entity.Student;
import cn.nayo.ssmdemo2.core.service.StudentService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

@Controller
@RequestMapping(value = "/users")
public class StudentController {

    @Resource(name = "studentService")
    private StudentService studentService;

    /**
     * 学生注册，参数接收可能出错
     * @return
     */
    @RequestMapping("/registerPage")
    public String registerPage(){
//        System.out.println(student);
        //注册用户，需要开启事务，首先查看是否有重复学号，没有时才注册
//        studentService.regirester(student);
        //注册成功时
        return "register";
    }

    @RequestMapping("/register")
    public String register(Student student){
        int result = studentService.regiresterStu(student);
        if (result > 0){
            System.out.println("注册成功");
        }
        return "redirect:/books/list";
    }
}

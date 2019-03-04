package cn.nayo.ssmdemo2.core.web;/*
  @auther laomuzhu
  @DESCRIPTION 控制器
  @creat 3/1/2019
*/

import cn.nayo.ssmdemo2.core.dto.AppointExecution;
import cn.nayo.ssmdemo2.core.dto.Result;
import cn.nayo.ssmdemo2.core.entity.Book;
import cn.nayo.ssmdemo2.core.entity.Student;
import cn.nayo.ssmdemo2.core.enums.AppointStatementEnum;
import cn.nayo.ssmdemo2.core.exception.NoNumberException;
import cn.nayo.ssmdemo2.core.exception.RepeatAppointException;
import cn.nayo.ssmdemo2.core.service.BookService;
import cn.nayo.ssmdemo2.core.service.StudentService;
import com.sun.org.apache.regexp.internal.RE;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.jws.WebParam;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/books")
public class BookController {

    @Resource(name = "bookService")
    private BookService bookService;
    @Resource(name = "studentService")
    private StudentService studentService;

    Logger logger = Logger.getLogger(BookController.class);

    @RequestMapping(value = "/hello")
    @ResponseBody
    public String hello(){
        return "hello";
    }

    /**
     * 书籍列表
     * @param model
     * @return
     */
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public String List(Model model){
        List<Book> bookList = bookService.getBookList();
        model.addAttribute("bookList", bookList);
        return "list";
    }

    /**
     * 查看书籍详情
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/{id}/detail", method = RequestMethod.GET)
    public String bookDetail(@PathVariable("id")Long id, Model model){
        if (id == null){
            return "redirect:/books/list";
        }
        Book book = bookService.getBookById(id);
        if (book == null){
            model.addAttribute("resultNull", "详情为空，具体见书籍简介。");
        }
        model.addAttribute("book", book);
        return "detail";
    }

    /**
     * 按书名搜索书籍
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public void bookSearch(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //接收页面的值
        String name = request.getParameter("name");
        name = name.trim();
        request.setAttribute("name", name);
        request.setAttribute("bookList", bookService.getSomeList(name));
        request.getRequestDispatcher("/WEB-INF/pages/list.jsp").forward(request, response);
    }

    /**
     * 确认登录的用户名密码是否正确
     * @param
     * @return
     */
    @RequestMapping(value="/verify", method = RequestMethod.POST, produces = {"application/json; charset=utf-8" })
    @ResponseBody
    public Map validate(@RequestParam(value = "student_id", defaultValue = "1000000001") Long student_id,
                        @RequestParam(value = "password", defaultValue = "100000") Long password){
        System.out.println("学号和密码:" + student_id + ":" + password);
        Map resultMap = new HashMap();
        Student student = null;
        System.out.println("验证函数");
        student = studentService.validateStu(student_id, password);
        System.out.println(student);
        if (student != null) {
            System.out.println("查询成功");
            resultMap.put("result", "SUCCESS");
        }else {
            resultMap.put("result", "FAILED");
        }
        return resultMap;
    }

    /**
     * 预约操作的逻辑
     * @param book_id
     * @param student_id
     * @return
     */
    @RequestMapping(value = "/{book_id}/appoint", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
    @ResponseBody
    private Result<AppointExecution> execute(@PathVariable("book_id")long book_id, @RequestParam("student_id") long student_id ){
        System.out.println("预约图书id:学号" + book_id + ":" + student_id);
        Result<AppointExecution> result;
        AppointExecution execution = null;

        //可能会出错，手动try catch
        try {
            execution = bookService.appoint(book_id, student_id);
            result = new Result<AppointExecution>(true,execution);
            return result;
        }catch (NoNumberException e1){
            execution=new AppointExecution(book_id, AppointStatementEnum.NO_NUMBER);
            result=new Result<AppointExecution>(true,execution);
            return result;
        }catch(RepeatAppointException e2){
            execution=new AppointExecution(book_id,AppointStatementEnum.REPEAT_APPOINT);
            result=new Result<AppointExecution>(true,execution);
            return result;
        }catch (Exception e){
            execution=new AppointExecution(book_id,AppointStatementEnum.INNER_ERROR);
            result=new Result<AppointExecution>(true,execution);
            return result;
        }
    }

    /**
     * 按照学号查询该学生已经预约了哪些书籍
     * @param student_id
     * @return
     */
    @RequestMapping("/appointed")
    private String appointedListByStudentId(Long student_id, Model model){
//        System.out.println(student_id);
        logger.info(student_id);
        List<Book> bookList = bookService.getAppointedListByStudentId(student_id);
        model.addAttribute("bookList", bookList);
        return "appointed";
    }

    /**
     * 取消预约图书
     * @param book_id
     * @param model
     * @return
     */
    @RequestMapping(value = "/{book_id}/{student_id}/cancelAppointment")
    public String cancelAppointment(@PathVariable("book_id") long book_id, @PathVariable("student_id") long student_id, Model model){
        int cancelResult = bookService.cancelAppointment(student_id,book_id);
        //重新查找已经预约了哪些书籍
//        appointedListByStudentId(student_id, model);
        return "redirect:/books/appointed?student_id="+ student_id;

    }






    /**
     * 测试获取ajax提交的数据
     * @return
     */
    @RequestMapping(value = "/test")
    public String test(){
        System.out.println("进入test页面");
        return "test";
    }

    /**
     * 测试获取ajax提交的数据的三种方式
     * @param student
     * @return
     */
    @RequestMapping(value = "/check",method = RequestMethod.POST, produces = {"application/json; charset=utf-8" })
    @ResponseBody
    public String check(Student student){
        //3.使用RequestParam方式，注意修改ajax中额contentType和data(不能使用JSON.stringify(params),data需要使用的格式：{'phone':phone})
        //public String check(@RequestParam(value = "student_id", defaultValue = "11111") Long student_id){
        //2.直接使用参数名
//    public String check(Long student_id){
        //1.使用对象的方式，但是对象属性名要对应上
        System.out.println("进入Ajax请求");
        System.out.println(student);
        System.out.println(student.getStudent_id());
//        Long student_id = request.getParameter("student_id");
//        String password = request.getParameter("password");
//        System.out.println(student);
//        System.out.println("学号和密码:" + student_id);
        return "test";
    }
}

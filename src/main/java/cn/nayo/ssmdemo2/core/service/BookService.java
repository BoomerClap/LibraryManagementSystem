package cn.nayo.ssmdemo2.core.service;

import cn.nayo.ssmdemo2.core.dto.AppointExecution;
import cn.nayo.ssmdemo2.core.entity.Book;
import cn.nayo.ssmdemo2.core.entity.Student;
import org.springframework.stereotype.Service;

import java.util.List;

public interface BookService {
    /**
     * 获取表中所有的书籍列表
     * @return
     */
    List<Book> getBookList();

    /**
     * 根据id查找图书
     * @param id
     * @return
     */
    Book getBookById(long id);

    /**
     * 根据书名获取书籍
     * @param name
     * @return
     */
    List<Book> getSomeList(String name);


    /**
     * 预约图书
     * @param book_id
     * @param student_id
     * @return 返回预约成功的实体类
     */
    AppointExecution appoint(long book_id, long student_id);

    /**
     * 查找某个学号的学生预约了哪些书
     * @param student_id
     * @return
     */
    List<Book> getAppointedListByStudentId(Long student_id);

    /**
     * 取消预约图书
     * @param student_id
     * @param book_id
     * @return
     */
    int cancelAppointment(long student_id, long book_id);
}

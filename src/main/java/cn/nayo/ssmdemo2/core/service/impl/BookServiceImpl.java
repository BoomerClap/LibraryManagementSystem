package cn.nayo.ssmdemo2.core.service.impl;/*
  @auther laomuzhu
  @DESCRIPTION BookService接口的实现类
  @creat 3/1/2019
*/

import cn.nayo.ssmdemo2.core.dao.AppointmentDao;
import cn.nayo.ssmdemo2.core.dao.BookDao;
import cn.nayo.ssmdemo2.core.dao.StudentDao;
import cn.nayo.ssmdemo2.core.dto.AppointExecution;
import cn.nayo.ssmdemo2.core.entity.Appointment;
import cn.nayo.ssmdemo2.core.entity.Book;
import cn.nayo.ssmdemo2.core.entity.Student;
import cn.nayo.ssmdemo2.core.enums.AppointStatementEnum;
import cn.nayo.ssmdemo2.core.exception.AppointException;
import cn.nayo.ssmdemo2.core.exception.CancelAppointmentException;
import cn.nayo.ssmdemo2.core.exception.NoNumberException;
import cn.nayo.ssmdemo2.core.exception.RepeatAppointException;
import cn.nayo.ssmdemo2.core.service.BookService;
import org.junit.Test;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class BookServiceImpl implements BookService {

    @Resource(name = "bookDao")
    private BookDao bookDao;

    @Resource(name = "studentDao")
    private StudentDao studentDao;

    @Resource(name = "appointmentDao")
    private AppointmentDao appointmentDao;

    @Override
    public List<Book> getBookList() {
        return bookDao.queryAll(0,1000);
    }

    @Override
    public Book getBookById(long id) {
        return bookDao.queryById(id);
    }

    @Override
    public List<Book> getSomeList(String name) {
        return bookDao.querySome(name);
    }

    /**
     * 预约图书，开启事务
     * 执行的流程：首先从库存中减1，如果-1的结果<=0，则此时无库存，抛出无库存的异常
     * 执行预约操作，判断是否存在重复预约，有则抛出异常，
     * 最后上面两个步骤到执行成功，则预约成功
     * @param book_id
     * @param student_id
     * @return
     */
    @Override
    @Transactional
    public AppointExecution appoint(long book_id, long student_id) {
        try {
            //首先库存数量-1
            int update = bookDao.reduceNumber(book_id);

            //已经没有库存
            if (update < 0){
                throw new NoNumberException("no number");
            }else {
                //首先检查预约表appointment中是否存在book_id、student_id相同的预约信息，即校验该次预约是否是重复预约
                Appointment check = appointmentDao.queryById(student_id, book_id);
                System.out.println(check);
                if (check != null){
                    throw new RepeatAppointException("repeat appoint");
                }else {
                    //执行预约操作
                    int insert = appointmentDao.insertAppointment(book_id, student_id, new Date());
                    if (insert > 0){
                        return new AppointExecution(book_id, AppointStatementEnum.SUCCESS);
                    }else {
                        return new AppointExecution(book_id, AppointStatementEnum.INNER_ERROR);
                    }
                }
            }
        }catch (NoNumberException e1){
            throw e1;
        }catch (RepeatAppointException e2){
            throw e2;
        }catch (Exception e){
            //所有编译期异常转换为运行期异常
            throw new AppointException("Appoint inner error:" + e.getMessage());
        }
    }

    /**
     * 查找某个学号的学生预约了哪些书
     * @param student_id
     * @return
     */
    @Override
    public List<Book> getAppointedListByStudentId(Long student_id) {
        return bookDao.queryBooksByStudentId(student_id);
    }

    /**
     * 取消预约图书，开启事务
     * @param student_id
     * @param book_id
     * @return
     */
    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public int cancelAppointment(long student_id, long book_id) {
        int result = 0;
        try {
            //库存数量+1，book表中number + 1
            int add = bookDao.addNumber(book_id);
            //操作失败
            if (add < 0){
                throw new CancelAppointmentException("取消预约操作失败，book表number+1失败");
            }else {
                //预约表中删除预约的信息，即appoint表中删除相应的行
                int del = appointmentDao.delAppointment(student_id, book_id);
                //操作失败
                if (del < 0){
                    throw new CancelAppointmentException("取消预约操作失败，删除appointment中数据失败");
                }else {
                    result = 1;
                    System.out.println("取消预约成功");
                }
            }
        }catch (CancelAppointmentException e1){
            throw e1;
        }catch (Exception e){
            throw new  CancelAppointmentException("取消预约错误:" + e.getMessage());
        }finally {
            return result;
        }
    }
}

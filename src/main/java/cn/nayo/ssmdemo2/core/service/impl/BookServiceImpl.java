package cn.nayo.ssmdemo2.core.service.impl;/*
  @auther laomuzhu
  @DESCRIPTION BookService接口的实现类
  @creat 3/1/2019
*/

import cn.nayo.ssmdemo2.core.dao.AppointmentDao;
import cn.nayo.ssmdemo2.core.dao.BookDao;
import cn.nayo.ssmdemo2.core.dao.StudentDao;
import cn.nayo.ssmdemo2.core.dto.AppointExecution;
import cn.nayo.ssmdemo2.core.entity.Book;
import cn.nayo.ssmdemo2.core.entity.Student;
import cn.nayo.ssmdemo2.core.enums.AppointStatementEnum;
import cn.nayo.ssmdemo2.core.exception.AppointException;
import cn.nayo.ssmdemo2.core.exception.NoNumberException;
import cn.nayo.ssmdemo2.core.exception.RepeatAppointException;
import cn.nayo.ssmdemo2.core.service.BookService;
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
                //执行预约操作
                int insert = appointmentDao.insertAppointment(book_id, student_id, new Date());

                //如果重复预约
                if (insert <= 0){
                    throw new RepeatAppointException("repeat appoint");
                }else {
                    return new AppointExecution(book_id, AppointStatementEnum.SUCCESS);
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
}

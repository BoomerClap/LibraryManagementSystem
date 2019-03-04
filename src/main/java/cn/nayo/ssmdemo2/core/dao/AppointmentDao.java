package cn.nayo.ssmdemo2.core.dao;

import cn.nayo.ssmdemo2.core.entity.Appointment;
import org.apache.ibatis.annotations.Param;

import java.util.Date;

public interface AppointmentDao {

    /**
     * 预约书籍业务
     * @param book_id
     * @param student_id
     * @return
     */
    int insertAppointment(@Param("book_id") long book_id, @Param("student_id") long student_id, @Param("appoint_time") Date date);

    /**
     * 取消预约书籍的业务
     * @param student_id
     * @param book_id
     * @return
     */
    int delAppointment(@Param("student_id") long student_id, @Param("book_id") long book_id);

    /**
     * 根据id查找表中有没有特定学号预约的特定书籍
     * @param student_id
     * @param book_id
     * @return
     */
    Appointment queryById(@Param("student_id") long student_id, @Param("book_id") long book_id);
}

package cn.nayo.ssmdemo2.core.dao;

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
}

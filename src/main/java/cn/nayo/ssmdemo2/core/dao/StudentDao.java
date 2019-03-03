package cn.nayo.ssmdemo2.core.dao;

import cn.nayo.ssmdemo2.core.entity.Student;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Repository
public interface StudentDao {

    Student queryStudentById(@Param("student_id") long student_id, @Param("password") long password);
}

package cn.nayo.ssmdemo2.core.service;

import cn.nayo.ssmdemo2.core.entity.Student;

public interface StudentService {
    /**
     * 验证输入的学号密码是否正确
     * @param student_id
     * @param password
     * @return
     */
    Student validateStu(Long student_id, Long password);

}

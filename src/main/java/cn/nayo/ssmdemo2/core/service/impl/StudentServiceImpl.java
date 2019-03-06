package cn.nayo.ssmdemo2.core.service.impl;/*
  @auther laomuzhu
  @DESCRIPTION service的实现类
  @creat 3/3/2019
*/

import cn.nayo.ssmdemo2.core.dao.StudentDao;
import cn.nayo.ssmdemo2.core.entity.Student;
import cn.nayo.ssmdemo2.core.service.StudentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class StudentServiceImpl implements StudentService {

    @Resource(name = "studentDao")
    private StudentDao studentDao;

    /**
     * 根据学号获取学生，目的是校验登录信息是否正确
     * @param student_id
     * @param password
     * @return
     */
    @Override
    public Student validateStu(Long student_id, Long password) {
        System.out.println(student_id + "---" + password);
        return studentDao.queryStudentById(student_id, password);
    }

    @Override
    public int regiresterStu(Student student) {
        return studentDao.addStu(student);
    }
}

package cn.nayo.ssmdemo2.core.entity;/*
  @auther laomuzhu
  @DESCRIPTION 
  @creat 3/1/2019
*/

public class Student {

    private Long student_id;
    private Long password;

    public Student(){
    }

    public Long getStudent_id() {
        return student_id;
    }

    public void setStudent_id(Long student_id) {
        this.student_id = student_id;
    }

    public Long getPassword() {
        return password;
    }

    public void setPassword(Long password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "Student{" +
                "student_id=" + student_id +
                ", password=" + password +
                '}';
    }
}

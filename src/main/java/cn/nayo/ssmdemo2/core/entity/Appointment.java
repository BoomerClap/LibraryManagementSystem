package cn.nayo.ssmdemo2.core.entity;/*
  @auther laomuzhu
  @DESCRIPTION 实体类
  @creat 3/1/2019
*/

import java.util.Date;

public class Appointment {

    private long book_id;
    private long student_id;
    private Date appointTime;
    // 多对一的复合属性
    private Book book;// 图书实体
    public Appointment(){
    }

    public long getBook_id() {
        return book_id;
    }

    public void setBook_id(long book_id) {
        this.book_id = book_id;
    }

    public long getStudent_id() {
        return student_id;
    }

    public void setStudent_id(long student_id) {
        this.student_id = student_id;
    }

    public Date getAppointTime() {
        return appointTime;
    }

    public void setAppointTime(Date appointTime) {
        this.appointTime = appointTime;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    @Override
    public String toString() {
        return "Appointment{" +
                "book_id=" + book_id +
                ", student_id=" + student_id +
                ", appointTime=" + appointTime +
                ", book=" + book +
                '}';
    }
}

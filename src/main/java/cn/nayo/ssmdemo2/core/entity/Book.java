package cn.nayo.ssmdemo2.core.entity;/*
  @auther laomuzhu
  @DESCRIPTION 书籍实体类
  @creat 3/1/2019
*/

public class Book {
    private long book_id;//图书ID
    private String name;//图书名称
    private Integer number;//馆藏数量
    private String introd;
    public Book() {  //为什么要有个无参构造器
    }

    public long getBook_id() {
        return book_id;
    }

    public void setBook_id(long book_id) {
        this.book_id = book_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public String getIntrod() {
        return introd;
    }

    public void setIntrod(String introd) {
        this.introd = introd;
    }

    @Override
    public String toString() {
        return "Book{" +
                "book_id=" + book_id +
                ", name='" + name + '\'' +
                ", number=" + number +
                ", introd='" + introd + '\'' +
                '}';
    }
}

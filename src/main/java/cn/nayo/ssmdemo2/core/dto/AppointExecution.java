package cn.nayo.ssmdemo2.core.dto;/*
  @auther laomuzhu
  @DESCRIPTION 预约操作
  @creat 3/2/2019
*/

import cn.nayo.ssmdemo2.core.enums.AppointStatementEnum;

public class AppointExecution {

    //图书ID
    private long book_id;

    //秒杀预约结果状态
    private int state;

    //标识状态
    private String stateInfo;

    public AppointExecution() {
    }

    /**
     * 构造方法，使用AppointStatementEnum中的枚举来确定结果状态和状态标识
     * @param book_id
     * @param statementEnum
     */
    public AppointExecution(long book_id, AppointStatementEnum statementEnum){
        this.book_id = book_id;
        this.state = statementEnum.getState();
        this.stateInfo = statementEnum.getStateInfo();
    }

    public long getBook_id() {
        return book_id;
    }

    public void setBook_id(long book_id) {
        this.book_id = book_id;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getStateInfo() {
        return stateInfo;
    }

    public void setStateInfo(String stateInfo) {
        this.stateInfo = stateInfo;
    }

    @Override
    public String toString() {
        return "AppointExecution{" +
                "book_id=" + book_id +
                ", state=" + state +
                ", stateInfo='" + stateInfo + '\'' +
                '}';
    }
}

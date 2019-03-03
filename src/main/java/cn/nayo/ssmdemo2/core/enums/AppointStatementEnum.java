package cn.nayo.ssmdemo2.core.enums;

/**
 * 使用枚举表述常量数据字典，我们先定义几个预约图书操作返回码的数据字典，也就是要返回给客户端的消息
 */
public enum AppointStatementEnum {
    SUCCESS(1,"预约成功"), NO_NUMBER(0, "库存不足"), REPEAT_APPOINT(-1, "重复预约"), INNER_ERROR(-1,"内部错误");

    private int state;

    private String stateInfo;

    //枚举类的构造方法能是public
    AppointStatementEnum(int state, String stateInfo) {
        this.state = state;
        this.stateInfo = stateInfo;
    }

    public int getState() {
        return state;
    }

    public String getStateInfo() {
        return stateInfo;
    }

    public static AppointStatementEnum stateOf(int index){
        for (AppointStatementEnum state : values()){
            if (state.getState() == index){
                return state;
            }
        }
        return null;
    }
}

package cn.nayo.ssmdemo2.core.exception;/*
  @auther laomuzhu
  @DESCRIPTION 预约业务异常
  @creat 3/2/2019
*/

public class AppointException extends RuntimeException{

    public AppointException(String message) {
        super(message);
    }

    public AppointException(String message, Throwable cause) {
        super(message, cause);
    }
}

package cn.nayo.ssmdemo2.core.exception;/*
  @auther laomuzhu
  @DESCRIPTION 重复预约异常
  @creat 3/2/2019
*/

public class RepeatAppointException extends RuntimeException {

    public RepeatAppointException(String message) {
        super(message);
    }

    public RepeatAppointException(String message, Throwable cause) {
        super(message, cause);
    }
}

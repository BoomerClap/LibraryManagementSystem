package cn.nayo.ssmdemo2.core.exception;/*
  @auther laomuzhu
  @DESCRIPTION 取消预约异常
  @creat 3/4/2019
*/

public class CancelAppointmentException extends RuntimeException {

    public CancelAppointmentException(String message) {
        super(message);
    }

    public CancelAppointmentException(String message, Throwable cause) {
        super(message, cause);
    }
}

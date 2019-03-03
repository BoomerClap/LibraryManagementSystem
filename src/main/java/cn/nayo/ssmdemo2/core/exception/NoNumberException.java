package cn.nayo.ssmdemo2.core.exception;/*
  @auther laomuzhu
  @DESCRIPTION 库存不足异常
  @creat 3/2/2019
*/

public class NoNumberException extends RuntimeException {

    public NoNumberException(String message){
        super(message);
    }

    public NoNumberException(String message, Throwable cause){
        super(message,cause);
    }

}

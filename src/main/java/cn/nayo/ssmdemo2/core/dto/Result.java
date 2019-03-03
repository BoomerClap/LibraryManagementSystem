package cn.nayo.ssmdemo2.core.dto;/*
  @auther laomuzhu
  @DESCRIPTION 用于封装json对象，所有返回结果都使用它
  @creat 3/2/2019
*/

public class Result<T> {

    //是否成功的标志
    private boolean sucess;

    //成功时返回的数据
    private T data;

    //错误信息
    private String error;

    public Result() {
    }

    /**
     * 成功返回时的构造器
     * @param sucess
     * @param data
     */
    public Result(boolean sucess, T data) {
        this.sucess = sucess;
        this.data = data;
    }

    /**
     * 错误时的构造器
     * @param sucess
     * @param error
     */
    public Result(boolean sucess, String error) {
        this.sucess = sucess;
        this.error = error;
    }

    public boolean isSucess() {
        return sucess;
    }

    public void setSucess(boolean sucess) {
        this.sucess = sucess;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
}

package cn.nayo.ssmdemo2.core.dao;

import cn.nayo.ssmdemo2.core.entity.Book;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookDao {

    /**
     * 获取所有书本信息
     * @return
     */
    List<Book> queryAll(@Param("offset") int offset, @Param("limit") int limit);

    /**
     * 根据id查找书籍信息
     * @param id
     * @return
     */
    Book queryById(Long id);

    /**
     * 获取书籍
     * @param name
     * @return
     */
    List<Book> querySome(String name);

    /**
     * 预约书籍业务，库存-1
     * @param book_id
     * @return
     */
    int reduceNumber(long book_id);
}

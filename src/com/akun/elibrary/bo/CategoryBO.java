package com.akun.elibrary.bo;

import java.util.List;

import com.akun.elibrary.bean.Category;
import com.akun.elibrary.bean.CategoryExample;

public interface CategoryBO {
	 /**
     * add<br>
     * @param item
     * @return: 0incorrect data format. 1reapplied name，2operation succeeded，-1operation failed.
     */
	int add(Category item);
    
	/**
	 * delete<br>
	 * @param example
	 * @return: 0incorrect data format.1Operation not allowed.2operation succeeded，-1operation failed.
	 */
	int deleteByPrimaryKey(String ids);
	
	/**
	 * data update<br>
	 * @param json data
	 * @return: 0incorrect data format. 1reapplied name，2operation succeeded，-1operation failed.
	 */
	int update(String categoryJson);
	int update(String catogaryJson1,String categoryJson2);
	
	/**
	 * search<br>
	 * @param
	 * @return:
	 */
	List<Category> selectByExample(CategoryExample example);
}

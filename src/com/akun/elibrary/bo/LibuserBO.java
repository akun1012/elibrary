package com.akun.elibrary.bo;

import java.util.List;

import com.akun.elibrary.bean.Libuser;
import com.akun.elibrary.bean.LibuserExample;

public interface LibuserBO {
   /**
    * login validation
    */
	Libuser validateUser(String username,String userpwd);
	
	 /**
     * add<br>
     * @param item
     * @return:0incorrect data format. 1reapplied name，2operation succeeded，-1operation failed.
     */
	int add(Libuser item);
    
	/**
	 * delete<br>
	 * @param example
	 * @return:0incorrect data format. 1Operation not allowed，2operation succeeded，
	 */
	int deleteByPrimaryKey(String idsToDelete);
	
	/**
	 * data update<br>
	 * @param json data
	 * @return: 0incorrect data format. 1reapplied name，2operation succeeded，-1operation failed.
	 */
	int update(String libuserJson);
	int update(String libuserJson,String libuserJson2);
	
	/**
	 * search<br>
	 * @param
	 * @return:
	 */
	List<Libuser> selectByExample(LibuserExample example);
	/**
	 * change password
	 * @param libuser
	 * @param pwd
	 * @param pwd2
	 * @return
	 */
	int changePwd(String username,String pwd, String pwd2);
}

package com.akun.elibrary.bo;

import java.util.List;

import com.akun.elibrary.bean.Student;
import com.akun.elibrary.bean.StudentExample;

public interface StudentBO {
    /**
     * add new student<br>
     * @param item
     * @return: 0incorrect data format. 1reapplied name，2operation succeeded，-1operation failed.
     */
	int addStudent(Student item);
    
	/**
	 * delete a student<br>
	 * @param example
	 * @return: 0incorrect data format. 1Operation not allowed. 2operation succeeded，
	 */
	int deleteByPrimaryKey(String ids);
	
	/**
	 * data update<br>
	 * @param json data
	 * @return: 0incorrect data format. 1reapplied name，2operation succeeded，-1operation failed.
	 */
	int update(String studentJson);
	
	/**
	 * look up for studen tinfo<br>
	 * @param 
	 * @return list
	 */
	List<Student> selectByCondition(int skipResults, int rows, String key);
	
	/**
	 * return the number of record to be used for paging<br>
	 * @param
	 * @return:
	 */
	int countByExample(StudentExample example);
	
	/**
	 * search<br>
	 * @param
	 * @return:
	 */
	List<Student> selectByExample(StudentExample example);
}

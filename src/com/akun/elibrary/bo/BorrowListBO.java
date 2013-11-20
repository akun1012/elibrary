package com.akun.elibrary.bo;

import java.util.List;

import com.akun.elibrary.bean.Literatureforborrow;

public interface BorrowListBO {
     /**
	 * @param key
	 * @param start
	 * @param limit
	 * @return
	 */
   public List<Literatureforborrow> listBorrowList(String key, int start, int limit);
   /**
	 * get borrow list by book name and paging operation
	 * @param key
	 * @param start
	 * @param limit
	 * @return
	 */
  public List<Literatureforborrow> listBorrowListByName(String key, int start, int limit);
   /**
    * 
    * get borrow list record number
    * @param key
    * @return
    */
   public int countBorrowList(String key);
   /**
    * delete borrowinfo
    * @param ids
    * @return
    */
   public int deleteBorrowInfo(String ids);
   public boolean addBorrowInfo(String snumber,String detailJsonArray);
   public double returnBorrowInfo(String returnJsonArray);
/**
 * get borrow list by gruop
 * @param
 * @return:
 */
public List<Literatureforborrow> listBorrowListByGroup(String key, int start, int limit);
/**
 * get borrow list by category and paging operation
 * @param
 * @return:
 */
public List<Literatureforborrow> listBorrowListByCategory(String key, int start, int limit);
/**
 * get book list that a student has borrowed
 * @param
 * @return:
 */
public List<Literatureforborrow> listBorrowListBySnumber(String theLoginedSnumber, int start,
		int limit);
/**
 * renewal
 * @param deferBorrowids
 * @param deferExpectedReturnTimes
 * @return
 */
public int deferBorrow(String deferBorrowids, String deferExpectedReturnTimes);
/**
 * get the book list that has not been returned
 * @param
 * @return:
 */
public List<Literatureforborrow> listBorrowListNotReturned(String key, int start, int limit);
   
}

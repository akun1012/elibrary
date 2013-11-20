package com.akun.elibrary.action;

import java.util.List;

import net.sf.json.JSONArray;

import com.akun.elibrary.bean.Category;
import com.akun.elibrary.bean.CategoryExample;
import com.akun.elibrary.bo.CategoryBO;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class CategoryAction extends ActionSupport {
    private CategoryBO categoryBO;
    //private Category category;
    private String key;
    private String retvalue;
    private String updateCategoryList;
    private String updateCategoryList2;
    private String idsToDelete;
    private Category category;
    /**
     * search
     */
    public String listCategory(){
    	if(key==null){
    		key="";
    	}
    	CategoryExample categoryExample = new CategoryExample();
    	categoryExample.createCriteria().andCategorynameLike("%"+key+"%");
    	List<Category> list = (List<Category>)categoryBO.selectByExample(categoryExample);
    	retvalue="{\"nodes\":";
    	if(list!=null){
    		retvalue += JSONArray.fromObject(list);
    	}else{
    		retvalue += "[]";
    	}
    	retvalue += "}";
    	System.out.println(retvalue);
    	return SUCCESS;
    }
    
    /**
     * modify
     * @return
     */
    public String updateCategory() {
		int result = categoryBO.update(updateCategoryList,updateCategoryList2);
		switch (result) {
		case 0:
			retvalue = "Incorrect data format!";
			break;
		case 1:
			retvalue = "The name has been used.Try another one.";
			break;
		case 2:
			retvalue = "Operation succeeded.";
			break;
		default:
			retvalue = "Operation failed.";
			break;
		}
		return SUCCESS;
	}
    
    /**
	 * delete
	 * @param
	 * @return:
	 */
	public String deleteCategory() {
		System.out.println(idsToDelete);
		int result = categoryBO.deleteByPrimaryKey(idsToDelete);
		switch (result) {
		case 0:
			retvalue = "Incorrect data format.";
			break;
		case 1:
			retvalue = "Cannot be deleted as quoted!";
			break;
		case 2:
			retvalue = "Deleted.";
			break;
		default:
			retvalue = "Operation failed.";
			break;
		}
		return SUCCESS;
	}
	/**
	 * add
	 * @param
	 * @return:
	 */
	public String addCategory() {
			retvalue = "{\"success\":true,\"msg\":";
			int result = categoryBO.add(category);
			switch (result) {
			case -1:
				retvalue += "\"Operation failed.\"";
				break;
			case 0:
				retvalue += "\"Incorrect data format.\"";
				break;
			case 2:
				retvalue += "\"Operation succeeded.\"";
				break;
			case 5:
				retvalue += "\"Existed category name of index number!\"";
			default:
				break;
			}
			retvalue += "}";

		
		return SUCCESS;
	}
    
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	public String getIdsToDelete() {
		return idsToDelete;
	}
	public void setIdsToDelete(String idsToDelete) {
		this.idsToDelete = idsToDelete;
	}
	public String getUpdateCategoryList2() {
		return updateCategoryList2;
	}
	public void setUpdateCategoryList2(String updateCategoryList2) {
		this.updateCategoryList2 = updateCategoryList2;
	}
	public CategoryBO getCategoryBO() {
		return categoryBO;
	}
	public void setCategoryBO(CategoryBO categoryBO) {
		this.categoryBO = categoryBO;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getRetvalue() {
		return retvalue;
	}
	public void setRetvalue(String retvalue) {
		this.retvalue = retvalue;
	}
	public String getUpdateCategoryList() {
		return updateCategoryList;
	}
	public void setUpdateCategoryList(String updateCategoryList) {
		this.updateCategoryList = updateCategoryList;
	}
	
}
package com.akun.elibrary.action;

import java.util.List;

import net.sf.json.JSONArray;

import com.akun.elibrary.bean.Literature;
import com.akun.elibrary.bean.LiteratureExample;
import com.akun.elibrary.bo.LiteratureBO;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class LiteratureAction extends ActionSupport {
	private LiteratureBO literatureBO;
	private String retvalue;
	private String key;
	private String idsToDelete;
	private Literature literature;
	private String updateList;
	private String updateList2;
	/**
     * List and Search
     * @return
     */
    public String listLiterature(){
    	if(key==""){
    		key="";
    	}
    	System.out.println(key);
    	List<Literature> list  = null;
    	String booknameSearch = "";
		String authorSearch = "";
		if (!key.contains("_")){
			booknameSearch = key;
		}else if (key.trim()!="_"&&!"_".equals(key.trim())){
			key = " "+key+" ";
			if(key.split("_")[0]!=null){
				booknameSearch = key.split("_")[0].trim();				
			}
			if(key.split("_")[1]!=null){
	    		authorSearch = key.split("_")[1].trim(); 
			}
		}
		System.out.println(booknameSearch);
		System.out.println(authorSearch);

    	if(authorSearch==""||"".equals(authorSearch)||authorSearch==null){
    		list = (List<Literature>)literatureBO.selectByKey(booknameSearch);
    	}else{
    		list = (List<Literature>)literatureBO.selectByNameAndAuthor(booknameSearch,authorSearch);
    	}
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
     * update
     * @return
     */
    public String updateLiterature() {
		int result = literatureBO.update(updateList,updateList2);
		switch (result) {
		case 0:
			retvalue = "Incorrect data format.";
			break;
		case 1:
			retvalue = "The name has been used.Try another one.";
			break;
		case 2:
			retvalue = "Updated.";
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
	public String deleteLiterature() {
		System.out.println(idsToDelete);
		int result = literatureBO.deleteByPrimaryKey(idsToDelete);
		switch (result) {
		case 0:
			retvalue = "Incorrect data format!";
			break;
		case 1:
			retvalue = "Cannot delete as quoted!";
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
	public String addLiterature() {
			retvalue = "{\"success\":true,\"msg\":";
			int result = literatureBO.add(literature);
			switch (result) {
			case -1:
				retvalue += "\"Operation failed.\"";
				break;
			case 0:
				retvalue += "\"Incorrect data format.\"";
				break;
			case 2:
				retvalue += "\"Operatoin succeeded.\"";
				break;
			case 5:
				retvalue += "\"Existed name or index number.\"";
			default:
				break;
			}
			retvalue += "}";

		
		return SUCCESS;
	}

	public String getUpdateList() {
		return updateList;
	}

	public void setUpdateList(String updateList) {
		this.updateList = updateList;
	}

	public String getUpdateList2() {
		return updateList2;
	}

	public void setUpdateList2(String updateList2) {
		this.updateList2 = updateList2;
	}

	public LiteratureBO getLiteratureBO() {
		return literatureBO;
	}

	public void setLiteratureBO(LiteratureBO literatureBO) {
		this.literatureBO = literatureBO;
	}

	public String getRetvalue() {
		return retvalue;
	}

	public void setRetvalue(String retvalue) {
		this.retvalue = retvalue;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getIdsToDelete() {
		return idsToDelete;
	}

	public void setIdsToDelete(String idsToDelete) {
		this.idsToDelete = idsToDelete;
	}

	public Literature getLiterature() {
		return literature;
	}

	public void setLiterature(Literature literature) {
		this.literature = literature;
	}
	
}

    
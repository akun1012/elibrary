
package com.akun.elibrary.action;

import java.io.Serializable;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.akun.elibrary.bean.Libuser;
import com.akun.elibrary.bean.LibuserExample;
import com.akun.elibrary.bo.LibuserBO;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class LibuserAction extends ActionSupport implements Serializable {
	private static final long serialVersionUID = 1L;
    private	String username;
	private String userpwd;
    private String retvalue;
    private LibuserBO userBO;
    private String key;
    private List<Libuser> libuserList;
    private String updateLibuserList;
    private String updateLibuserList2;
	private String idsToDelete;
    private Libuser libuser;
    private String newPwd;
    private String newPwd2;
	private String oldPwd;
	HttpSession session;
	private int loginCounter;
	private String loginExceptUser;
    /**
     * User logs in
     * @return
     */
	public String login(){
		if(ServletActionContext.getRequest().getSession().getAttribute("loginCounter")!=null){
			if((Integer)ServletActionContext.getRequest().getSession().getAttribute("loginCounter")>=3){
				retvalue="You have failed 3 times.Not allowed to log in now!";
				return SUCCESS;
			}
		}
		Libuser user = userBO.validateUser(username, userpwd);
		if(!(user==null)&&!"".equals(user)){
		    ServletActionContext.getRequest().getSession().setAttribute("userInfo", user);
			retvalue = "success";
		}else{
			//set up a counter to record the times of failed log-in.Not allowed to log in if failed 3 times.
			if(ServletActionContext.getRequest().getSession().getAttribute("loginCounter") == null){
				loginCounter=1;
				ServletActionContext.getRequest().getSession().setAttribute("loginCounter", loginCounter);
			}else{
				loginCounter++;
				ServletActionContext.getRequest().getSession().setAttribute("loginCounter", loginCounter);
			}
			//retvalue = "error";
			retvalue="Incorrect username or password,   "+loginCounter+"time(s)，Not allowed to log in if failed 3 times.";
            if(loginCounter>=3){
			   retvalue="You have failed 3 times.Not allowed to log in now!";	
			   //loginExceptUser = username;
			   //ServletActionContext.getRequest().getSession().setAttribute("loginExceptUser", loginExceptUser);
			}
		}
		System.out.println(retvalue);
		return SUCCESS;
	}
	/**
	 * User logs off
	 * @return
	 */
	public String logout(){
		ServletActionContext.getRequest().getSession().removeAttribute("userInfo");
		return SUCCESS;
	}
	
	/**
	 * search
	 * @return
	 */
	public String listLibuser(){
		if(key==null){
			key="";
		}
		LibuserExample example = new LibuserExample();
		example.createCriteria().andUsernameLike("%"+key+"%");
		libuserList = userBO.selectByExample(example);
		retvalue="{\"nodes\":";
    	if(libuserList!=null){
    		retvalue += JSONArray.fromObject(libuserList);
    	}else{
    		retvalue += "[]";
    	}
    	retvalue += "}";
		return SUCCESS;
	}
	/**
     * update
     * @return
     */
    public String updateLibuser() {
		int result = userBO.update(updateLibuserList,updateLibuserList2);
		switch (result) {
		case 0:
			retvalue = "Incorrect data format!";
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
	 * Delete
	 * @param
	 * @return:
	 */
	public String deleteLibuser() {
		System.out.println(idsToDelete);
		int result = userBO.deleteByPrimaryKey(idsToDelete);
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
	public String addLibuser() {
			retvalue = "{\"success\":true,\"msg\":";
			int result = userBO.add(libuser);
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
				retvalue += "\"Existed username!\"";
			default:
				break;
			}
			retvalue += "}";

		
		return SUCCESS;
	}
	
	/**
     * changed password
     * @return
     */
	public String changeLibuserPwd(){
		int result=0;
		retvalue = "{\"success\":true,\"msg\":";
		if(oldPwd.equals(userpwd)){
		result = userBO.changePwd(username,newPwd,newPwd2);
		}else{
			result = 0;
		}
		switch (result) {
		case 0:
			retvalue += "\"Incorrect current password!\"";
			break;
		case 2:
			retvalue += "\"Password changed.\"";
			break;
		case 1:
			retvalue += "\"The two passwords differed!\"";
		default:
			retvalue += "\"Operation failed.\"";
		}
		retvalue += "}";
		return SUCCESS;
	}
	
	public String getOldPwd() {
		return oldPwd;
	}
	public void setOldPwd(String oldPwd) {
		this.oldPwd = oldPwd;
	}
	public String getNewPwd() {
		return newPwd;
	}
	public void setNewPwd(String newPwd) {
		this.newPwd = newPwd;
	}
	public String getNewPwd2() {
		return newPwd2;
	}
	public void setNewPwd2(String newPwd2) {
		this.newPwd2 = newPwd2;
	}
	public String getIdsToDelete() {
		return idsToDelete;
	}
	public void setIdsToDelete(String idsToDelete) {
		this.idsToDelete = idsToDelete;
	}
	public Libuser getLibuser() {
		return libuser;
	}
	public void setLibuser(Libuser libuser) {
		this.libuser = libuser;
	}
	public String getUpdateLibuserList() {
		return updateLibuserList;
	}
	public void setUpdateLibuserList(String updateLibuserList) {
		this.updateLibuserList = updateLibuserList;
	}
	public String getUpdateLibuserList2() {
		return updateLibuserList2;
	}
	public void setUpdateLibuserList2(String updateLibuserList2) {
		this.updateLibuserList2 = updateLibuserList2;
	}
	public List<Libuser> getLibuserList() {
		return libuserList;
	}
	public void setLibuserList(List<Libuser> libuserList) {
		this.libuserList = libuserList;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public LibuserBO getUserBO() {
		return userBO;
	}

	public void setUserBO(LibuserBO userBO) {
		this.userBO = userBO;
	}

	public String getRetvalue() {
		return retvalue;
	}

	public void setRetvalue(String retvalue) {
		this.retvalue = retvalue;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUserpwd() {
		return userpwd;
	}

	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}
	public int getLoginCounter() {
		return loginCounter;
	}
	public void setLoginCounter(int loginCounter) {
		this.loginCounter = loginCounter;
	}
	public String getLoginExceptUser() {
		return loginExceptUser;
	}
	public void setLoginExceptUser(String loginExceptUser) {
		this.loginExceptUser = loginExceptUser;
	}
	
}

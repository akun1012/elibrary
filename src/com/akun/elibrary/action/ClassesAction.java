package com.akun.elibrary.action;

import java.util.List;

import net.sf.json.JSONArray;

import com.akun.elibrary.bean.Classes;
import com.akun.elibrary.bo.ClassesBO;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClassesAction extends ActionSupport {
     private ClassesBO classesBO;
     private List<Classes> classesList;
     private String retvalue;
     
     @SuppressWarnings("unchecked")
	public String listClasses(){
    	 retvalue="{\"root\":";
    	 classesList = classesBO.listClasses();
    	 if(classesList != null){
    		 retvalue+=JSONArray.fromObject(classesList);
    	 }else{
    		 retvalue+="[]";
    	 }
    	 retvalue+="}";
    	 System.out.println(retvalue);
    	 return SUCCESS;
     }

	public ClassesBO getClassesBO() {
		return classesBO;
	}

	public void setClassesBO(ClassesBO classesBO) {
		this.classesBO = classesBO;
	}

	public List<Classes> getClassesList() {
		return classesList;
	}

	public void setClassesList(List<Classes> classesList) {
		this.classesList = classesList;
	}

	public String getRetvalue() {
		return retvalue;
	}

	public void setRetvalue(String retvalue) {
		this.retvalue = retvalue;
	}
     
     
}

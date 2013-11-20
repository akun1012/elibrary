
package com.akun.elibrary.action;

import java.io.Serializable;
import java.util.List;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.akun.elibrary.bean.Classes;
import com.akun.elibrary.bean.Student;
import com.akun.elibrary.bean.StudentExample;
import com.akun.elibrary.bo.ClassesBO;
import com.akun.elibrary.bo.StudentBO;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class StudentAction extends ActionSupport implements Serializable {
	private static final long serialVersionUID = 1L;
	private StudentBO studentBO;
	private ClassesBO classesBO;
	private String retvalue;
	private int start, limit;
	private String key;
	private List<Student> studentList;
	private String updateStudentList;
	private Student student;
	private String snumbersToDelete;
    private String loginSnumber;
    private String loginStudentPwd;
    private String addSnumber;
	/**
	 * studentPage, page for students' searching operation
	 * @return
	 */
    public String studentLogin(){
    	System.out.println(loginSnumber);
    	System.out.println(loginStudentPwd);
		StudentExample loginstudentexample = new StudentExample();
		loginstudentexample.createCriteria().andSnumberEqualTo(loginSnumber).andPwdEqualTo(loginStudentPwd);
		List<Student> studentLoginList = (List<Student>)studentBO.selectByExample(loginstudentexample);
    	Student loginedStudent = studentLoginList.get(0);
		if(studentLoginList.size()==0||studentLoginList==null){
    		retvalue="{success:true,\"error\":\"true\"}";
    	}else{
     	    ServletActionContext.getRequest().getSession().setAttribute("loginedStudent", loginedStudent);
     	    retvalue = "{success:true,\"error\":\"false\"}";
    	}
     	return SUCCESS;
	}
    /**
     * student logs off
     * @param
     * @return:
     */
    public String studentLogout(){
    	ServletActionContext.getRequest().getSession().removeAttribute("loginedStudent");
    	return SUCCESS;
    }
	
    /**
	 * paged display student list
	 * @param
	 * @return:
	 */
	public String showStudent() {
		retvalue = "{\"total\":";
		if (key == null) {
			key = "";
		}
		List<Student> theStudentList = studentBO.selectByCondition(start, limit, key);
		//replace classid in theStudentList with cname, then generate JSON
		for (Student theStudent : theStudentList) {
			if (theStudent.getClassnumber() != null && !"".equals(theStudent.getClassnumber())) {
				Classes theClass = classesBO.listClasses(theStudent.getClassnumber());
				theStudent.setClassnumber(theClass.getCname());
			} else {
				continue;
			}
		}
		StudentExample example = new StudentExample();
		example.createCriteria().andSnameLike("%" + key + "%");
		int totalRecords = studentBO.countByExample(example);
		if (theStudentList != null) {
			retvalue += totalRecords + ",\"nodes\":";
			retvalue += JSONArray.fromObject(theStudentList);
		} else {
			retvalue += 0 + ",\"nodes\":[]";
		}
		retvalue += "}";
		return SUCCESS;
	}

	/**
	 *update student info
	 * @param
	 * @return:
	 */
	public String updateStudent() {
		int result = studentBO.update(updateStudentList);
		switch (result) {
		case 0:
			retvalue = "Incorrect data format!";
			break;
		case 1:
			retvalue = "Existed name!";
			break;
		case 2:
			retvalue = "Update accpted.";
			break;
		default:
			retvalue = "Operation failed.";
			break;
		}
		return SUCCESS;
	}

	/**
	 * add stu info
	 * @param
	 * @return:
	 */
	public String addStudent() {
		// check if the student number has been enrolled
			retvalue = "{\"success\":true,\"msg\":";
			int result = studentBO.addStudent(student);
			switch (result) {
			case -1:
				retvalue += "\"Operation failed.\"";
				break;
			case 0:
				retvalue += "\"Incorrect data format!\"";
				break;
			case 1:
				retvalue += "\"Name has been enrolled.Try another one.\"";
				break;
			case 2:
				retvalue += "\"Operation succeeded.\"";
				break;
			case 5:
				retvalue += "\"Existed student number.\"";
			default:
				break;
			}
			retvalue += "}";

		
		return SUCCESS;
	}
	/**
	 * check if the stu num has been enrolled when add a new one
	 * @return
	 */
	public String checkSnumber(){
		//System.out.println(addSnumber);
		StudentExample studentExample = new StudentExample();
		studentExample.createCriteria().andSnumberEqualTo(addSnumber);
		List<Student> list = studentBO.selectByExample(studentExample);
		//System.out.println(list.size());
		if(list.size()>0){
			retvalue="Existed student number!";
		}else{
			retvalue="Valid studeng number";
		}
		return SUCCESS;
	}

	/**
	 * delete stuinfo
	 * @param
	 * @return:
	 */
	public String deleteStudents() {
		int result = studentBO.deleteByPrimaryKey(snumbersToDelete);
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
			retvalue = "Operation failed!";
			break;
		}
		return SUCCESS;
	}

	public ClassesBO getClassesBO() {
		return classesBO;
	}

	public void setClassesBO(ClassesBO classesBO) {
		this.classesBO = classesBO;
	}

	public String getSnumbersToDelete() {
		return snumbersToDelete;
	}

	public void setSnumbersToDelete(String snumbersToDelete) {
		this.snumbersToDelete = snumbersToDelete;
	}

	public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}

	public String getUpdateStudentList() {
		return updateStudentList;
	}

	public void setUpdateStudentList(String updateStudentList) {
		this.updateStudentList = updateStudentList;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public List<Student> getStudentList() {
		return studentList;
	}

	public void setStudentList(List<Student> studentList) {
		this.studentList = studentList;
	}

	public StudentBO getStudentBO() {
		return studentBO;
	}

	public void setStudentBO(StudentBO studentBO) {
		this.studentBO = studentBO;
	}

	public String getRetvalue() {
		return retvalue;
	}

	public void setRetvalue(String retvalue) {
		this.retvalue = retvalue;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public String getLoginSnumber() {
		return loginSnumber;
	}

	public void setLoginSnumber(String loginSnumber) {
		this.loginSnumber = loginSnumber;
	}

	public String getLoginStudentPwd() {
		return loginStudentPwd;
	}

	public void setLoginStudentPwd(String loginStudentPwd) {
		this.loginStudentPwd = loginStudentPwd;
	}
	public String getAddSnumber() {
		return addSnumber;
	}
	public void setAddSnumber(String addSnumber) {
		this.addSnumber = addSnumber;
	}
    
}

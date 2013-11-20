package com.akun.elibrary.bo.imp;

import java.util.List;

import com.akun.elibrary.bean.Classes;
import com.akun.elibrary.bean.ClassesExample;
import com.akun.elibrary.bo.ClassesBO;
import com.akun.elibrary.dao.ClassesDAO;

public class ClassesBOImp implements ClassesBO {
    private ClassesDAO classesDAO;
    
	public ClassesDAO getClassesDAO() {
		return classesDAO;
	}

	public void setClassesDAO(ClassesDAO classesDAO) {
		this.classesDAO = classesDAO;
	}

	/* (non-Javadoc)
	 * @see com.akun.elibrary.bo.ClassesBO#listClasses(com.akun.elibrary.bean.ClassesExample)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List listClasses() {
		ClassesExample example = new ClassesExample();
		List<Classes> list = classesDAO.selectByExample(example);
		return list;
	}
	
	/* (non-Javadoc)
	 * @see com.akun.elibrary.bo.ClassesBO#listClasses(com.akun.elibrary.bean.ClassesExample)
	 */
	@Override
	public Classes listClasses(String classnumber) {
		Classes theclass = classesDAO.selectByPrimaryKey(classnumber);
		return theclass;
	}
	
	/* (non-Javadoc)
	 * @see com.akun.elibrary.bo.ClassesBO#listClasses(com.akun.elibrary.bean.ClassesExample)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List listClasses(ClassesExample example) {
        List<Classes> list = (List<Classes>)classesDAO.selectByExample(example);
		return list;
	}

}

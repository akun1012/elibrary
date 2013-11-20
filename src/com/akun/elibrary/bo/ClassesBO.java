package com.akun.elibrary.bo;

import java.util.List;

import com.akun.elibrary.bean.Classes;
import com.akun.elibrary.bean.ClassesExample;

public interface ClassesBO {
    @SuppressWarnings("unchecked")
	public List listClasses();
    
    @SuppressWarnings("unchecked")
	public List listClasses(ClassesExample example);
    
	public Classes listClasses(String classnumber);
}

package com.akun.elibrary.conf;

import java.util.ResourceBundle.Control;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


public class WebContextHolder {
    private static Log log = LogFactory.getLog(WebContextHolder.class);
    public static final String WEB_CONTEXT_HOLDER_IN_REQUEST = "WEB_CONTEXT_HOLDER_IN_REQUEST";
    private static ThreadLocal<WebContextHolder> context = new ThreadLocal<WebContextHolder>();
    
    private HttpServletRequest request;
    private static WebContextHolder  ControlAdapter = null;
    public static WebContextHolder getInstance(){
    	  if(ControlAdapter == null){
    		  ControlAdapter = new WebContextHolder();
    	  }
    	  return ControlAdapter;
    	 }
    
//    public WebContextHolder(HttpServletRequest request) {
//            this.request = request;
//            this.request.setAttribute(WEB_CONTEXT_HOLDER_IN_REQUEST, this);
//            context.set(this);
//    }
    
    public static WebContextHolder getWebContext() {
            return context.get();
    }
    
    public static WebContextHolder getWebContext(HttpServletRequest request) {
            return (WebContextHolder)request.getAttribute(WEB_CONTEXT_HOLDER_IN_REQUEST);
    }
    
    public HttpServletRequest getRequest() {
            return this.request;
    }
    
    public HttpSession getSession() {
            return this.request.getSession();
    }

   
}


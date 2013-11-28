package test;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.akun.elibrary.conf.SpringContextFactoryUtil;
public class SpringConfForTest {
 
 @BeforeClass
 public static void setUpBeforeClass() throws Exception {

	  //Spring启动所需要的配置参数文件,其中test/JunitTestConf.xml文件中保存了数据库连接等参数,可根据具体情况做修改
	  String[] paths = new String[] {"test/JunitTestConf.xml"};
	  //启动Spring，得到Spring环境上下文
	  ApplicationContext ctx = new ClassPathXmlApplicationContext(paths);  
	  //在此类启动时，将Spring环境上下文保存到单根类WebContextHolder中,以提供给其它的测试类使用
	  SpringContextFactoryUtil.getInstance().setApplicationContext(ctx);
	  //SpringContextFactoryUtil util = new SpringContextFactoryUtil();
 }
 @AfterClass
 public static void tearDownAfterClass() throws Exception {
 }
 @Test
 public void test(){
   //必须要写一个test空方法，否则SpringConfForTest类不会启动
 }
}
package test;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;


@RunWith(Suite.class)
@Suite.SuiteClasses({
 SpringConfForTest.class,
 CategoryActionTest.class,
})
/**
 * 批量执行Junit测试类，把类名写入到上面的Suite.SuiteClasses({})中，用逗号分隔
 */
public class AllTests {
 public static Test suite() {
  TestSuite suite = new TestSuite("Test for test");
  //$JUnit-BEGIN$
  //$JUnit-END$
  return suite;
 }
}
package test;

import static org.junit.Assert.fail;

import org.junit.BeforeClass;
import org.junit.Test;

import com.akun.elibrary.bean.Category;

public class CategoryActionTest {

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		Category category = new Category();
		category.setCategoryname("Test111");
		category.setCindex("test111");
	}

	@Test
	public void test() {
		fail("Not yet implemented");
	}

}

package test;

import static org.junit.Assert.fail;

import org.junit.BeforeClass;
import org.junit.Test;

import com.akun.elibrary.action.CategoryAction;
import com.akun.elibrary.bean.Category;

public class CategoryActionTest {

	@Test
	public void test() {
		Category category = new Category();
		category.setCategoryname("Test111");
		category.setCindex("test111");
		CategoryAction test = new CategoryAction();
		test.setCategory(category);
		test.addCategory();
	}

}

package test;

import org.junit.Test;

import com.akun.elibrary.action.LiteratureAction;
import com.akun.elibrary.bean.Literature;

public class LiteratureActionTest {

	@Test
	public void test() {
		Literature liter = new Literature();
		liter.setAuthor("test");
		liter.setLindex("wer");
		liter.setLiteraturename("test");
		liter.setNum(1);
		liter.setOutnum(1);
		
		LiteratureAction test = new LiteratureAction();
		test.setLiterature(liter);
		test.addLiterature();
	}

}

import org.martus.util.*;

public class DelimiterDriver{
	protected static DatePreference runner;

	public static void main(String[] args){
		setup();
		runner.setDelimiter(args[0].toString().charAt(0));
		System.out.printf("%s", runner.getDelimiter());
		tearDown();
	}
	public static void setup(){
		runner = new DatePreference();
	}
	public static void tearDown(){
		runner = null;
	}
}

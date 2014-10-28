import org.martus.logi

public class HexStringDriver{
	protected static Crypto runner;

	public static void main(String[] args){
		String type = args[0].toString();
		setup();
		if(type.compareToIgnoreCase("long")){
			System.out.print(runner.hexString((long)args[1]));
		}
		else if(type.compareToIgnoreCase("int"){
			System.out.print(runner.hexString((int)args[1]));
		}
		else if(type.compareToIgnoreCase("string"){
			System.out.print(runner.hexString(args[1].toString()));
		}
		else{
			System.out.print("error");
		}

		tearDown();
	}

	public static void setup(){
		runner = new Crypto();
	}

	public static void tearDown(){
		runner = null;
	}	
}

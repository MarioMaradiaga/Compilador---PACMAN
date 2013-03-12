import java.io.*;

public class Main{
    public static void main(String args[]){
        try{
            LexerPacMan scanner = new LexerPacMan(new FileReader(args[0]));
			parser pars = new parser(scanner); 
            
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        System.out.println();
    }
}
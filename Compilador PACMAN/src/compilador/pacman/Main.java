package compilador.pacman;

import java.io.*;
import java_cup.runtime.Symbol;

public class Main{
    public static void main (String args[]){
        try{
            LexerPacMan scanner = new LexerPacMan(new FileReader("Untitled.txt"));
//            Symbol symbol;
//            while((symbol = scanner.next_token()) != null && symbol.sym != 0){
//                System.out.println(symbol.sym +"="+((MiToken)symbol.value).getValor());
//            }
            parser p = new parser(scanner);
            p.parse();
        }catch(Exception e){
            System.out.println("ERROR");
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        System.out.println();
    }
}
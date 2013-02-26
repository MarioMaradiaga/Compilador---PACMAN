package compilador.pacman;

import java.io.*;
import java_cup.runtime.Symbol;

public class Main{
    public static void main(String args[]){
        try{
            LexerPacMan scanner = new LexerPacMan(new FileReader("/Users/mariomaradiaga/NetBeansProjects/Compilador PACMAN/src/compilador/pacman/Untitled.txt"));
            Symbol x = scanner.next_token();
            
            while(x.sym != 0){
                System.out.println("("+x.sym+",'"+x.value+"')");
                x = scanner.next_token();
            }
            
        }catch(Exception e){
            System.out.println("OI"+e.getMessage());
        }
        System.out.println();
    }
}
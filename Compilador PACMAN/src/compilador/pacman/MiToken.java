/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package compilador.pacman;

/**
 *
 * @author mariomaradiaga
 */
public class MiToken {
    private int linea;
    private int columna;
    private Object objeto;
    
    public MiToken(int linea, int columna, Object objeto){
        this.linea = linea;
        this.columna = columna;
        this.objeto = objeto;
    }
    
    public int getLinea(){
        return this.linea;
    }
    
    public int getColumna(){
        return this.columna;
    }
    
    public Object getValor(){
        return this.objeto;
    }
    
    public String toSring(){
        return objeto.toString();
    }
}

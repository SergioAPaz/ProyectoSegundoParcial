
package mx.uach.compiladores.analizadorlexico;
/**
 * @author Sergio Alejandro Paz Holguin 264951
 * @version  1.0
 * @since 16/03/2015
 */
public class Token {

    
    private Integer linea;
  
    private String token;
    
    private String lexema;

   
    public Token(Integer linea, String token, String lexema) {
        this.linea = linea;
        this.token = token;
        this.lexema = lexema;
    }

    public Integer getLinea() {
        return linea;
    }

    public void setLinea(Integer linea) {
        this.linea = linea;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getLexema() {
        return lexema;
    }

    public void setLexema(String lexema) {
        this.lexema = lexema;
    }

    @Override
    public String toString() {
        
        return String.format("%s --- %s --- %s", this.token, this.lexema, this.linea);
    }


}
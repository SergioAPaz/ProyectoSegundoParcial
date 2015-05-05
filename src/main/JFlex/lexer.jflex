import java.io.FileReader;
import java.util.ArrayList;
import java.util.ArrayList;
import java.util.List;

import mx.uach.compiladores.analizadorlexico.Token;
import java.util.stream.Collectors;

/**
 * @author Sergio Alejandro Paz Holguin 264951 y Julio Alberto Alvarez Navarrete 256962
 * @version  1.0
 * @since 04/05/2015
 */

%%
%public
%class Lexer
%standalone



%{

    Token token = null;
    private List<Token> tokens = new ArrayList<>();
    private static Integer linea = 1;

    private static final String Implica = "Implica";
    private static final String Parentesis_izq = "Parentesis Izquierdo"; 
    private static final String Parentesis_der = "Parentesis Derecho"; 
    private static final String Coma = "Coma";    
    private static final String Punto_coma = "Punto y coma"; 
    private static final String Punto = "Punto"; 
     
    private static final String Atomo = "Atomo"; 
    private static final String Variable = "Variable"; 
    private static final String Pto_fijo = "Punto Fijo"; 
    private static final String Pto_flot = "Punto Flotante"; 
    private static final String Cadena = "Cadena"; 
    private static final String Entero = "Entero"; 
    private static final String Lista = "Lista"; 
    private static final String Predicado = "Predicado"; 


%}

%{
    public List<Token> analizar(String archivo){
    //public List<String> analizar(String archivo){
        FileReader in = null;
        try{
            in = new FileReader(archivo);
            Lexer lexer = new Lexer(in);
            while(!lexer.zzAtEOF){
                lexer.yylex();
        }
        }catch(Exception ex){
            System.out.println("Error al analizar el archivo");
        }finally{
            try{
                in.close();
                }catch(Exception ex){
                    System.out.println("Error al cerrar el archivo");
                }
        }
        
          return tokens;
 }
%}

%%

//implica
":-"+ {token = new Token(this.linea, Implica, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList()));}
"("+  {token = new Token(this.linea, Parentesis_izq, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList())); this.linea++;}
")"+  {token = new Token(this.linea, Parentesis_der, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList()));}
","+  {token = new Token(this.linea, Coma, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList()));}
";"+  {token = new Token(this.linea, Punto_coma, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList())); this.linea++;}
"."+  {token = new Token(this.linea, Punto, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList()));}

// Atomo
^[a-z][a-z A-Z 0-9 _]+ {token = new Token(this.linea, Atomo, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList()));}
^[a-z]+ {token = new Token(this.linea, Atomo, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList()));}
[']+[a-zA-Z0-9()!ºª"-"@·#.,;$%&=´+?<>)(/&%_¿‚¡`*+¨Ç :]*[']+ {token = new Token(this.linea, Atomo, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList()));}
[()!ºª@·#$%&=´+?<>)("-"/&%_¿‚¡.,;`*+¨Ç :]*+ {token = new Token(this.linea, Atomo, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList()));}

//variable
^[A-Z][a-z 0-9 _]+ {token = new Token(this.linea, Variable, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList()));}
^[A-Z]+ {token = new Token(this.linea, Variable, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList()));}
^[_][a-z 0-9 _]+ {token = new Token(this.linea, Variable, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList()));}

//pto_fijo
["+""-"0-9"."]+[0-9]*["."][0-9]* {token = new Token(this.linea, Pto_fijo, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList()));}

//pto_flotante
["+""-"0-9 "."][0-9]*["."]*[0-9]*["e""E"]+["+""-"0-9]+[0-9]* {token = new Token(this.linea, Pto_flot, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList()));}

//Cadena
[\"][a-zA-Z0-9()!ºª@·#$.,;%&="-"´+?<>)(/&%_¿‚¡`*+¨Ç :]+[\"]+ {token = new Token(this.linea, Cadena, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList()));}

//Entero
//["+""-"]+[0-9]* {tokens.add("ent"); System.out.println("entero");}
["+""-"]+[0-9]* {token = new Token(this.linea, Entero, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList()));}

//Lista
["["][a-zA-Z0-9!ºª@·#$%.&-='´+?\"<>"-"¿‚¡ ()`*+¨Ç:,;]+["]"] {token = new Token(this.linea, Lista, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList()));}

//Predicado
 [a-zA-Z0-9!*+¨Çº¿‚¡`:ª@·#$.%&='´+?<>"-",;]+["("][a-zA-Z0-9!º%¿ª@·#.$‚¡`*+¨Ç&='\"´"[""]"+?<>"-":,;]+[")"] {token = new Token(this.linea, Predicado, yytext()); tokens.add(token); System.out.println("Tokens = " + tokens.stream().collect(Collectors.toList()));}

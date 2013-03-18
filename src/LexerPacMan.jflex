
import java_cup.runtime.*;


%%
/*-*
 * FUNCIONES LÉXICAS:
 */


%cup
%line
%column
%unicode
%class LexerPacMan

%{

StringBuffer string = new StringBuffer();

/**
 * Retorna un nuevo Symbol con el id del token y la columna y 
 * fila del mismo.
 */
Symbol nuevoSymbol(int tokenId) {
    return new java_cup.runtime.Symbol(tokenId, yyline, yycolumn);
}

/**
 * Retorna un nuevo Symbol con el id del token, la columna y 
 * fila del mismo y su valor. El valor es usado para tokens como
 * identificadores y números.
 */
Symbol nuevoSymbol(int tokenId, Object valor) {
    return new java_cup.runtime.Symbol(tokenId, yyline, yycolumn, 
		   new MiToken(yyline, yycolumn, valor));
}

%}


/*-*
 * DEFINICIONES DE PATRONES:
 */
letra            = [A-Za-z]
digito           = [0-9]
alfanumerico     = {letra}|{digito}
otrosCharId      = [_]
identificador    = {letra}({alfanumerico}|{otrosCharId})*
entero           = {digito}+
real             = {entero}\.{entero}
llaveIzq         = \{
llaveDer         = \}
noLlaveDer       = [^}]
cuerpoComentario = {noLlaveDer}*
comentario       = {llaveIzq}{cuerpoComentario}{llaveDer}
espacio          = \r|\n|\r\n|" "|\t\f|\t
StringCharacter = [^\r\n\"\\]
SingleCharacter = [^\r\n\'\\]

%state STRING, CHARLITERAL

%%
/**
 * REGLAS LEXICAS:
 */
<YYINITIAL>{

/*Palabras Reservadas*/
"bin"             { return nuevoSymbol(sym.BOOL, "bin"); }
"cad"             { return nuevoSymbol(sym.STRING, "cad"); }
"caso"            { return nuevoSymbol(sym.CASE, "caso"); }
"cur"             { return nuevoSymbol(sym.FOR, "cur"); }
"dec"             { return nuevoSymbol(sym.FLOAT, "dec"); }
"defecto"         { return nuevoSymbol(sym.DEFAULT, "defecto"); }
"encasode"        { return nuevoSymbol(sym.SWITCH, "encasode"); }
"ent"             { return nuevoSymbol(sym.INT, "ent"); }
"escribir"        { return nuevoSymbol(sym.WRITE, "escribir"); }
"falso"	          { return nuevoSymbol(sym.FALSE, "falso"); }
"fincaso"         { return nuevoSymbol(sym.BREAK, "fincaso"); }
"leer"            { return nuevoSymbol(sym.READ, "leer"); }
"main"            { return nuevoSymbol(sym.MAIN, "main"); }
"mientras"        { return nuevoSymbol(sym.WHILE, "mientras"); }
"nada"	          { return nuevoSymbol(sym.VOID, "nada"); }
"nulo"	          { return nuevoSymbol(sym.NULL, "nulo"); }
"pacman"          { return nuevoSymbol(sym.FUNCTION, "pacman"); }
"retorno"	        { return nuevoSymbol(sym.RETURN, "retorno"); }
"si"              { return nuevoSymbol(sym.IF, "si"); }
"sim"             { return nuevoSymbol(sym.CHAR, "sim"); }
"sino"            { return nuevoSymbol(sym.ELSE, "sino"); }
"verdadero"       { return nuevoSymbol(sym.TRUE, "verdadero"); }

/*Separadores*/
"("             { return nuevoSymbol(sym.PARIZQ, "("); }
")"             { return nuevoSymbol(sym.PARDER, ")"); }
"["             { return nuevoSymbol(sym.BRAIZQ, "["); }
"]"             { return nuevoSymbol(sym.BRADER, "]"); }
":"             { return nuevoSymbol(sym.DOSPUNTOS, ":"); }
","             { return nuevoSymbol(sym.COMA, ","); }

/*String*/
\"              { yybegin(STRING); string.setLength(0); }

/*Char*/
\'              { yybegin(sym.CHAR); }

/*Operadores*/
"*"             { return nuevoSymbol(sym.MULT, "*"); }
"+"             { return nuevoSymbol(sym.SUMA, "+"); }
"-"             { return nuevoSymbol(sym.RESTA, "-"); }
"/"             { return nuevoSymbol(sym.DIV, "/"); }
";"             { return nuevoSymbol(sym.PUNTOCOMA, ";"); }
"->"            { return nuevoSymbol(sym.ASIG, "->"); }
"<"             { return nuevoSymbol(sym.MENOR, "<"); }
">"             { return nuevoSymbol(sym.MAYOR, ">"); }
"<="            { return nuevoSymbol(sym.MENORIGUAL, "<="); }
">="            { return nuevoSymbol(sym.MAYORIGUAL, ">="); }
"="             { return nuevoSymbol(sym.IGUAL, "="); }
"!="            { return nuevoSymbol(sym.NOIGUAL, "!="); }
"!"				{ return nuevoSymbol(sym.NOT, "!"); }
"||"            { return nuevoSymbol(sym.OR, "||"); }
"&&"            { return nuevoSymbol(sym.AND, "&&"); }
{identificador} { return nuevoSymbol(sym.IDENT, yytext()); }
{entero}        { return nuevoSymbol(sym.ENTERO, new Integer(yytext())); }
{real}          { return nuevoSymbol(sym.FLOATVAL, new Double(yytext())); }
{comentario}    { /* Los comentarios se imprimirán */ System.out.println("COMENTARIO: " + yytext()); }
{espacio}       { /* Ignorar todos los espacios*/ }
.               { System.out.println("Error Léxico: No se identificó el caracter: " + yytext() +
                    "' linea: " + yyline + ", columna: " + yychar); }
}

<STRING> {
\"                             { yybegin(YYINITIAL); 
                                   return nuevoSymbol(sym.CADENA, string.toString()); }
  {StringCharacter}+            { string.append( yytext() ); }
  \\t                            { string.append('\t'); }
  \\n                            { string.append('\n'); }

  \\r                            { string.append('\r'); }
  \\\"                           { string.append('\"'); }
  \\                             { string.append('\\'); }
}

<CHARLITERAL> {
  {SingleCharacter}\'            { yybegin(YYINITIAL); return nuevoSymbol(sym.CHARVAL, new Character(yytext().charAt(0))); }
  
  /* escape sequences */
"\\b"\'                        { yybegin(YYINITIAL); return nuevoSymbol(sym.CHARVAL, new Character('\b'));}
"\\t"\'                        { yybegin(YYINITIAL); return nuevoSymbol(sym.CHARVAL, new Character('\t'));}
"\\n"\'                        { yybegin(YYINITIAL); return nuevoSymbol(sym.CHARVAL, new Character('\n'));}
"\\f"\'                        { yybegin(YYINITIAL); return nuevoSymbol(sym.CHARVAL, new Character('\f'));}
"\\r"\'                        { yybegin(YYINITIAL); return nuevoSymbol(sym.CHARVAL, new Character('\r'));}
"\\\""\'                       { yybegin(YYINITIAL); return nuevoSymbol(sym.CHARVAL, new Character('\"'));}
"\\'"\'                        { yybegin(YYINITIAL); return nuevoSymbol(sym.CHARVAL, new Character('\''));}
"\\\\"\'                       { yybegin(YYINITIAL); return nuevoSymbol(sym.CHARVAL, new Character('\\')); }
  
  /* error cases */
	  \\.                            { throw new RuntimeException("Illegal escape sequence \""+yytext()+"\""); }
}

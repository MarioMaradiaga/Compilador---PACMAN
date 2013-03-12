
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
    return new java_cup.runtime.Symbol(tokenId, yyline, yycolumn, valor);
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
espacio          = \r|\n|\r\n|" "|\t\f
StringCharacter = [^\r\n\"\\]
SingleCharacter = [^\r\n\'\\]

%state STRING, CHARLITERAL

%%
/**
 * REGLAS LEXICAS:
 */
<YYINITIAL>{

/*Palabras Reservadas*/
"bin"             { return nuevoSymbol(sym.BOOL); }
"caso"            { return nuevoSymbol(sym.CASE); }
"cur"             { return nuevoSymbol(sym.FOR); }
"dec"             { return nuevoSymbol(sym.FLOAT); }
"encasode"        { return nuevoSymbol(sym.SWITCH); }
"ent"             { return nuevoSymbol(sym.INT); }
"falso"	          { return nuevoSymbol(sym.FALSE); }
"fincaso"         { return nuevoSymbol(sym.BREAK); }
"mientras"        { return nuevoSymbol(sym.WHILE); }
"nada"	          { return nuevoSymbol(sym.VOID); }
"nulo"	          { return nuevoSymbol(sym.NULL); }
"pacman"          { return nuevoSymbol(sym.FUNCTION); }
"pal"             { return nuevoSymbol(sym.STRING); }
"retorno"	      { return nuevoSymbol(sym.RETURN); }
"si"              { return nuevoSymbol(sym.IF); }
"sim"             { return nuevoSymbol(sym.CHAR); }
"sino"            { return nuevoSymbol(sym.ELSE); }
"verdadero"       { return nuevoSymbol(sym.TRUE); }

/*Separadores*/
"("             { return nuevoSymbol(sym.PARIZQ); }
")"             { return nuevoSymbol(sym.PARDER); }
"["             { return nuevoSymbol(sym.BRAIZQ); }
"]"             { return nuevoSymbol(sym.BRADER); }
"{"             { return nuevoSymbol(sym.LLAVIZQ); }
"}"             { return nuevoSymbol(sym.LLAVDER); }
":"             { return nuevoSymbol(sym.DOSPUNTOS); }
","             { return nuevoSymbol(sym.COMA); }
"."             { return nuevoSymbol(sym.PUNTO); }

/*String*/
\"              { yybegin(sym.STRING); string.setLength(0); }

/*Char*/
\'              { yybegin(sym.CHAR); }

/*Operadores*/
"*"             { return nuevoSymbol(sym.MULT); }
"+"             { return nuevoSymbol(sym.SUMA); }
"-"             { return nuevoSymbol(sym.RESTA); }
"/"             { return nuevoSymbol(sym.DIV); }
";"             { return nuevoSymbol(sym.PUNTOCOMA); }
"->"            { return nuevoSymbol(sym.ASIG); }
"<"             { return nuevoSymbol(sym.MENOR); }
">"             { return nuevoSymbol(sym.MAYOR); }
"=<"            { return nuevoSymbol(sym.MENORIGUAL); }
"=>"            { return nuevoSymbol(sym.MAYORIGUAL); }
"="             { return nuevoSymbol(sym.IGUAL); }
"=!"            { return nuevoSymbol(sym.NOIGUAL); }
"||"            { return nuevoSymbol(sym.OR); }
"&&"            { return nuevoSymbol(sym.AND); }
{identificador} { return nuevoSymbol(sym.IDENT, yytext()); }
{entero}        { return nuevoSymbol(sym.ENTERO, new Integer(yytext())); }
{real}          { return nuevoSymbol(sym.FLOATVAL, new Double(yytext())); }
{comentario}    { /* Los comentarios se imprimirán */ System.out.println("COMENTARIO: " + yytext()); }
{espacio}       { /* Ignorar todos los espacios*/ }
.               { System.out.println("Caracter Ilegal, '" + yytext() +
                    "' line: " + yyline + ", column: " + yychar); }
}

<STRING> {
\"                   { yybegin(YYINITIAL); return nuevoSymbol(sym.CADENA, string.toString()); }
  
{StringCharacter}+   { string.append( yytext() ); }
  
/* escape sequences */
"\\b"                { string.append( '\b' ); }
"\\t"                { string.append( '\t' ); }
"\\n"                { string.append( '\n' ); }
"\\f"                { string.append( '\f' ); }
"\\r"                { string.append( '\r' ); }
"\\\""               { string.append( '\"' ); }
"\\'"                { string.append( '\'' ); }
"\\\\"               { string.append( '\\' ); }
  
/* error cases */
\\.                            { throw new RuntimeException("Illegal escape sequence \""+yytext()+"\""); }
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

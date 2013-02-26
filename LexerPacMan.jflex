
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
entero           = {digito}*
real             = {entero}\.{entero}
caracter         = '.'
llaveIzq         = \{
llaveDer         = \}
noLlaveDer       = [^}]
cuerpoComentario = {noLlaveDer}*
comentario       = {llaveIzq}{cuerpoComentario}{llaveDer}
espacio          = \r|\n|\r\n|" "|\t\f



%%
/**
 * REGLAS LEXICAS:
 */
<YYINITIAL>{
//int
ent             { return nuevoSymbol(sym.INT, yytext()); }

//bool
bin            { return nuevoSymbol(sym.BOOL, yytext()); }

//true
verdadero           { return nuevoSymbol(sym.TRUE, yytext()); }

//false
falso	           { return nuevoSymbol(sym.FALSE, yytext()); }

//null
nulo	           { return nuevoSymbol(sym.NULL, yytext()); }

//void
nada	           { return nuevoSymbol(sym.VOID, yytext()); }

//return
retorno	           { return nuevoSymbol(sym.RETURN, yytext()); }

//float
dec           { return nuevoSymbol(sym.FLOAT, yytext()); }

//char
sim            { return nuevoSymbol(sym.CHAR, yytext()); }

//string
pal          { return nuevoSymbol(sym.STRING, yytext()); }

//for
cur          { return nuevoSymbol(sym.FOR, yytext()); }

//while
mientras          { return nuevoSymbol(sym.WHILE, yytext()); }

//if
si          { return nuevoSymbol(sym.IF, yytext()); }

//else
sino        { return nuevoSymbol(sym.ELSE, yytext()); }

//switch
encasode          { return nuevoSymbol(sym.SWITCH, yytext()); }

//case
caso          { return nuevoSymbol(sym.CASE, yytext()); }

//break
fincaso             { return nuevoSymbol(sym.BREAK, yytext()); }

//function
pacman            { return nuevoSymbol(sym.FUNCTION, yytext()); }

\"              { return nuevoSymbol(sym.COMILLA, yytext()); }
"*"             { return nuevoSymbol(sym.MULT, yytext()); }
"+"             { return nuevoSymbol(sym.SUMA, yytext()); }
"-"             { return nuevoSymbol(sym.RESTA, yytext()); }
"/"             { return nuevoSymbol(sym.DIV, yytext()); }
";"             { return nuevoSymbol(sym.PUNTOCOMA, yytext()); }
","             { return nuevoSymbol(sym.COMA, yytext()); }
"("             { return nuevoSymbol(sym.PARIZQ, yytext()); }
")"             { return nuevoSymbol(sym.PARDER, yytext()); }
"["             { return nuevoSymbol(sym.BRAIZQ, yytext()); }
"]"             { return nuevoSymbol(sym.BRADER, yytext()); }
"->"            { return nuevoSymbol(sym.ASIG, yytext()); }
"<"             { return nuevoSymbol(sym.MENOR, yytext()); }
">"             { return nuevoSymbol(sym.MAYOR, yytext()); }
"=<"            { return nuevoSymbol(sym.MENORIGUAL, yytext()); }
"=>"            { return nuevoSymbol(sym.MAYORIGUAL, yytext()); }
"="             { return nuevoSymbol(sym.IGUAL, yytext()); }
"=!"            { return nuevoSymbol(sym.NOIGUAL, yytext()); }
":"             { return nuevoSymbol(sym.DOSPUNTOS, yytext()); }
"."             { return nuevoSymbol(sym.PUNTO, yytext()); }
{identificador} { return nuevoSymbol(sym.IDENT, yytext()); }
{entero}        { return nuevoSymbol(sym.INT, new Integer(yytext())); }
{real}          { return nuevoSymbol(sym.FLOAT, new Double(yytext())); }
{caracter}      { return nuevoSymbol(sym.CHAR, new Character(yytext().charAt(1))); }
{comentario}    { /* Los comentarios se imprimirán */
                  System.out.println("COMENTARIO: " + yytext()); }
{espacio}        { /* Ignorar todos los espacios*/ }

.                { System.out.println("Caracter Ilegal, '" + yytext() +
                    "' line: " + yyline + ", column: " + yychar); }
}

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
 * Retorna un nuevo Simbolo con el id del token y la columna y 
 * fila del mismo.
 */
Simbolo nuevoSimbolo(int tokenId) {
    return new Simbolo(tokenId, yyline, yycolumn);
}

/**
 * Retorna un nuevo simbolo con el id del token, la columna y 
 * fila del mismo y su valor. El valor es usado para tokens como
 * identificadores y números.
 */
Simbolo nuevoSimbolo(int tokenId, Object valor) {
    return new Simbolo(tokenId, yyline, yycolumn, value);
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
and             { return nuevoSimbolo(sym.AND); }
array           { return nuevoSimbolo(sym.ARRAY); }
begin           { return nuevoSimbolo(sym.BEGIN); }
else            { return nuevoSimbolo(sym.ELSE); }
end             { return nuevoSimbolo(sym.END); }
if              { return nuevoSimbolo(sym.IF); }
of              { return nuevoSimbolo(sym.OF); }
or              { return nuevoSimbolo(sym.OR); }
program         { return nuevoSimbolo(sym.PROGRAM); }
procedure       { return nuevoSimbolo(sym.PROCEDURE); }
then            { return nuevoSimbolo(sym.THEN); }
type            { return nuevoSimbolo(sym.TYPE); }
var             { return nuevoSimbolo(sym.VAR); }
"*"             { return nuevoSimbolo(sym.TIMES); }
"+"             { return nuevoSimbolo(sym.PLUS); }
"-"             { return nuevoSimbolo(sym.MINUS); }
"/"             { return nuevoSimbolo(sym.DIVIDE); }
";"             { return nuevoSimbolo(sym.SEMI); }
","             { return nuevoSimbolo(sym.COMMA); }
"("             { return nuevoSimbolo(sym.LEFT_PAREN); }
")"             { return nuevoSimbolo(sym.RT_PAREN); }
"["             { return nuevoSimbolo(sym.LEFT_BRKT); }
"]"             { return nuevoSimbolo(sym.RT_BRKT); }
"="             { return nuevoSimbolo(sym.EQ); }
"<"             { return nuevoSimbolo(sym.GTR); }
">"             { return nuevoSimbolo(sym.LESS); }
"<="            { return nuevoSimbolo(sym.LESS_EQ); }
">="            { return nuevoSimbolo(sym.GTR_EQ); }
"!="            { return nuevoSimbolo(sym.NOT_EQ); }
":"             { return nuevoSimbolo(sym.COLON); }
":="            { return nuevoSimbolo(sym.ASSMNT); }
"."             { return nuevoSimbolo(sym.DOT); }
{identificador} { return nuevoSimbolo(sym.IDENT, yytext()); }
{entero}        { return nuevoSimbolo(sym.INT, new Integer(yytext())); }
{real}          { return nuevoSimbolo(sym.REAL, new Double(yytext())); }
{caracter}      { return nuevoSimbolo(sym.CHAR, new Character(yytext().charAt(1))); }
{comentario}    { /* Los comentarios se imprimirán */
                  System.out.println("Recognized comment: " + yytext()); }
{espacio}        { /* Ignorar todos los espacios*/ }
.                { System.out.println("Caracter Ilegal, '" + yytext() +
                    "' line: " + yyline + ", column: " + yychar); }

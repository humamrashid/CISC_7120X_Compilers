/* Token definitions and external variables for toy language lexer.
 *
 * Humam Rashid
 * CISC 7120X, Fall 2019.
 *
 * Based primarily on:
 * 1. lexer design in chapter 1 of "Compiler Design in C" by Allen Holub (1990).
 */

#define EOI         0   /* end of input.                */
#define EQUAL       1   /* equal sign: =                */
#define SEMI        2   /* semicolon: ;                 */
#define PLUS        3   /* plus: +                      */
#define MINUS       4   /* minus: -                     */
#define TIMES       5   /* times: *                     */
#define L_PAREN     6   /* left parenthesis: (          */
#define R_PAREN     7   /* right parenthesis: )         */
#define IDENTIFIER  8   /* identitfiers like in C.      */
#define INT_LITERAL 9   /* decimal integer literals.    */

/* Defined in toylang_lex.c. */
extern char *yytext;
extern int  yylength;
extern int  yylinenum;

/* Lexer functions. */
int lex(void);
int match(int token);
void advance(void);

/* EOF. */

/* Token definitions and external variables for toy language lexer.
 *
 * Humam Rashid
 * CISC 7120X, Fall 2019.
 *
 * Based primarily on:
 * 1. lexer design in chapter 1 of "Compielr Design in C" by Holub (1990).
 *
 * Grammar for toy language with left-recursion removed.
 *
 * Let e = epsilon, then:
 *
 * Program       -> Assignment*
 * Assignment    -> Identifier = Exp;
 * Exp           -> Term ExpPrime
 * ExpPrime      -> e | + Term ExpPrime | - Term ExpPrime
 * Term          -> Fact TermPrime
 * TermPrime     -> e | * Fact TermPrime
 * Fact          -> ( Exp ) | - Fact | + Fact | Literal | Identifier
 * Identifier    -> Letter [ Letter | Digit ]*
 * Letter        -> a | ... | z | A | ... | Z | _
 * Literal       -> 0 | NonZeroDigit Digit*
 * NonZeroDigit  -> 1 | ... | 9
 * Digit         -> 0 | 1 | ... | 9
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

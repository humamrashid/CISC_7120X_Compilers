/* Simple lexer for toy language.
 *
 * Humam Rashid
 * CISC 7120X, Fall 2019.
 *
 * Based primarily on:
 * 1. lexer design in chapter 1 of "Compielr Design in C" by Holub (1990).
 *
 * This implementation uses a lookahead.
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
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include "toylang_lex.h"

#define BUFFER_SIZE 256

char        *yytext     = "";   /* lexeme (not '\0' terminated). */
int         yylength    = 0;    /* lexeme length. */
int         yylinenum   = 0;    /* input line number. */
static  int lookahead   = -1;   /* lookahead token. */

int lex(void)
{
    char        *current;
    static char input_buffer[BUFFER_SIZE];

    current = yytext + yylength;    /* Skip current lexeme. */

    while (1)
    {
        while (!(*current))
        {
            /* Get new lines, skipping any leading whitespace on the line,
             * until a nonblank line is found.
             */
            current = input_buffer;
            if (!fgets(input_buffer, BUFFER_SIZE, stdin))
            {
                *current = '\0';
                return EOI;
            }
            ++yylinenum;
            while (isspace(*current))
                ++current;
        }
        for ( ; *current; ++current)
        {
            /* Get the next token. */
            yytext = current;
            yylength = 1;
            switch (*current)
            {
                /* Handle single-character literals. */
                case EOF:   return EOI;
                case '=':   return EQUAL;
                case ';':   return SEMI;
                case '+':   return PLUS;
                case '-':   return MINUS;
                case '*':   return TIMES;
                case '(':   return L_PAREN;
                case ')':   return R_PAREN;

                case ' ':
                case '\n':
                case '\t':  break;

                /* Handle identifiers and integer literals. */
                default: 
                        if (isalpha(*current) || *current == '_')
                        {
                            while (isalnum(*current) || *current == '_')
                                ++current;
                            yylength = current - yytext;
                            return IDENTIFIER;
                        } else if (isdigit(*current))
                        {
                            if (*current == '0' && strlen(current) != 1)
                            {
                                fprintf(stderr, "Lexer: fatal error, leading zero\n");
                                return -1;
                            }
                            while (isdigit(*current))
                                ++current;
                            yylength = current - yytext;
                            return INT_LITERAL;
                        } else if (!isalnum(*current))
                        {
                            fprintf(stderr,
                                    "Lexer: fatal error, illegal input '%c'\n",
                                    *current);
                            return -1;
                        }
                        break;
            }
        }
    }
}

int match(int token)
{
    /* Return true if 'token' matches the current lookahead symbol. */
    if (lookahead == -1)
        lookahead = lex();
    return token == lookahead;
}

void advance(void)
{
    /* Advance the lookahead to the next input symbol. */
    lookahead = lex();
}

/* EOF. */

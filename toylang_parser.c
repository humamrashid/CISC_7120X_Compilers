/* Simple parser for toy language.
 *
 * Humam Rashid
 * CISC 7120X, Fall 2019.
 *
 * Based primarily on:
 * 1. parser designs in chapter 1 of "Compielr Design in C" by Holub (1990).
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
#include <stdlib.h>
#include "toylang_lex.h"
int main(void)
{
    int c;
    while ((c = lex()) != EOI)
    {
        switch (c)
        {
            case -1:
                return EXIT_FAILURE;
            case EQUAL: printf("Entered equal sign.\n");
                        break;
            case INT_LITERAL:
                        printf("Entered number.\n");
                        break;
            case IDENTIFIER:
                        printf("Entered id.\n");
                        break;
        }
    }
}

/* EOF. */

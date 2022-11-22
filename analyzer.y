%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror();
%}

%token IDENTIFIER CONSTANT
%token INC_OP DEC_OP
%token CHAR INT LONG FLOAT DOUBLE CONST VOID
%token IF ELSE WHILE FOR CONTINUE BREAK RETURN
%left '+' '-'
%left '*' '/'

// Starting point
%start translation_unit
// Verbose output
%define parse.error verbose

%%

translation_unit
	: external_declaration
	| translation_unit external_declaration
	;

external_declaration
	: function_definition
	| declaration
	;

declaration
	: type_specifier init_declarator_list ';'
	| CONST type_specifier init_declarator_list ';'
	;

init_declarator_list
	: init_declarator
	| init_declarator_list ',' init_declarator
	;

init_declarator
	: IDENTIFIER
	| IDENTIFIER '=' assignment_expression
	;

function_definition
	: type_specifier IDENTIFIER '(' ')' compound_statement
	;

compound_statement
	: '{' '}'
	| '{' statement_list '}'
	| '{' declaration_list '}'
	| '{' declaration_list statement_list '}'
	;

declaration_list
	: declaration
	| declaration_list declaration
	;

statement_list
	: statement
	| statement_list statement
	;

statement
	: compound_statement
	| expression_statement
	| selection_statement
	| jump_statement
	| iteration_statement
	;

primary_expression
	: IDENTIFIER
	| CONSTANT
	;

postfix_expression
	: primary_expression
	| postfix_expression INC_OP
	| postfix_expression DEC_OP
	;

unary_expression
	: postfix_expression
	| INC_OP unary_expression
	| DEC_OP unary_expression
	;

multiplicative_expression
	: multiplicative_expression '*' unary_expression
	| multiplicative_expression '/' unary_expression
	| unary_expression
	;

additive_expression
	: multiplicative_expression
	| additive_expression '+' multiplicative_expression
	| additive_expression '-' multiplicative_expression
	;

assignment_expression
	: additive_expression
	| unary_expression '=' assignment_expression
	;

expression
	: assignment_expression
	| expression ',' assignment_expression
	;

type_specifier
	: VOID
	| CHAR
	| INT
	| LONG
	| FLOAT
	| DOUBLE
	;

expression_statement
	: ';'
	| expression ';'
	;

selection_statement
	: IF '(' expression ')' statement
	| IF '(' expression ')' statement ELSE statement
	;

iteration_statement
	: WHILE '(' expression ')' statement
	| FOR '(' expression_statement expression_statement ')' statement
	| FOR '(' expression_statement expression_statement expression ')' statement
	;

jump_statement
	: CONTINUE ';'
	| BREAK ';'
	| RETURN ';'
	| RETURN expression ';'
	;


%%

extern int column;
extern FILE *yyin;

void
yyerror(char *s)
{
	fflush(stdout);
	printf("\n%*s\n%*s\n", column, "^", column, s);
	exit(1);
}

// driver code
int main(int nargs, char **args) {
  ++args;--nargs; // skip program name
  if (nargs > 0)
    yyin = fopen(args[0], "r");
  else
    yyin = stdin;

  yyparse();
  printf("Program parsed successfully\n");
  return 0;
}

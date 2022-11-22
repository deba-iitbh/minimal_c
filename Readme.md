# Assignment 2
Name - Debarghya Datta  
Roll - 12210310

## Requirements
- flex
- yacc / bison

## Basic C programming constructs
1. Identifiers
2. Data types: Primitive data types, such as int, float/real, characters, etc.
3. Constants: Integer, float, string, and character literals
4. Operators: +,-,*,/,++,--
5. Statements:
- Simple statements, break, and return
- Control flow: if-else, if-else if, while, for
6. Comments: Single-line (//) and multi-line (/*.. */)

## Execution

```sh
make compiler
```
### Test a right program
```sh
./compiler test/right.c
```

### Test a wrong program
```sh
./compiler test/wrong.c
```

## Lexical Tokens

```txt
'(' 
')'
'*'
'+'
','
'-'
'/'
';'
'='
'{'
'}'
IDENTIFIER
CONSTANT 
INC_OP  -> ++
DEC_OP  -> --
CHAR 
INT 
LONG 
FLOAT 
DOUBLE 
CONST 
VOID 
IF 
ELSE 
WHILE
FOR 
CONTINUE 
BREAK 
RETURN 
```

## Yacc Grammer

```txt
$accept → translation_unit $end
translation_unit → external_declaration
                 | translation_unit external_declaration

external_declaration → function_definition
                     | declaration

declaration → type_specifier init_declarator_list ';'
            | CONST type_specifier init_declarator_list ';'

init_declarator_list → init_declarator
                     | init_declarator_list ',' init_declarator

init_declarator → IDENTIFIER
                | IDENTIFIER '=' assignment_expression

function_definition → type_specifier IDENTIFIER '(' ')' compound_statement

compound_statement → '{' '}'
                   | '{' statement_list '}'
                   | '{' declaration_list '}'
                   | '{' declaration_list statement_list '}'

declaration_list → declaration
                 | declaration_list declaration

statement_list → statement
               | statement_list statement

statement → compound_statement
          | expression_statement
          | selection_statement
          | jump_statement
          | iteration_statement

primary_expression → IDENTIFIER
                   | CONSTANT

postfix_expression → primary_expression
                   | postfix_expression INC_OP
                   | postfix_expression DEC_OP

unary_expression → postfix_expression
                 | INC_OP unary_expression
                 | DEC_OP unary_expression

multiplicative_expression → multiplicative_expression '*' unary_expression
                          | multiplicative_expression '/' unary_expression
                          | unary_expression

additive_expression → multiplicative_expression
                    | additive_expression '+' multiplicative_expression
                    | additive_expression '-' multiplicative_expression

assignment_expression → additive_expression
                      | unary_expression '=' assignment_expression

expression → assignment_expression
           | expression ',' assignment_expression

type_specifier → VOID
               | CHAR
               | INT
               | LONG
               | FLOAT
               | DOUBLE

expression_statement → ';'
                     | expression ';'

selection_statement → IF '(' expression ')' statement
                    | IF '(' expression ')' statement ELSE statement

iteration_statement → WHILE '(' expression ')' statement
                    | FOR '(' expression_statement expression_statement ')' statement
                    | FOR '(' expression_statement expression_statement expression ')' statement

jump_statement → CONTINUE ';'
               | BREAK ';'
               | RETURN ';'
               | RETURN expression ';'
```

## References
- https://www.lysator.liu.se/c/ANSI-C-grammar-l.html
- http://marvin.cs.uidaho.edu/Teaching/CS445/c-Grammar.pdf
- https://developer.ibm.com/tutorials/l-flexbison/#artdownload

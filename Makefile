lexer.c: *.l
	flex -o $@ -v $<

syntax.c: *.y
	bison -d -Wcounterexamples -o $@ $<

compiler: syntax.c lexer.c
	gcc syntax.c lexer.c -o $@

.PHONY: compiler

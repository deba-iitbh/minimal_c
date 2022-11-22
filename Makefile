src/lexer.c: *.l
	flex -o $@ -v $<

src/syntax.c: *.y
	bison -d -Wcounterexamples -o $@ $<

compiler: src/syntax.c src/lexer.c
	gcc src/syntax.c src/lexer.c -o $@

.PHONY: compiler

# Travis example for Modern C++ by Rafał Pocztarski
# For more languages and info see:
# https://github.com/rsp/travis-hello#readme

#!/usr/bin/env bash

GCCFLAGS = -g -Wall -Wfatal-errors 
ALL = identifier
GCC = gcc

all: testsdone
	@rm cov
	@rm identifier.exe

testsdone: cov cppcheck valgrind sanitize 
	
cov: identifier.c
	@echo "Runinng GCOV"
	@echo " "	
	$(GCC) $(GCCFLAGS) -fprofile-arcs -ftest-coverage -o $@ identifier.c
	@echo " "
	@echo "Teste 1: Entrada:abcde   Espera-se: Válido"
	@echo "abcde"  | ./cov
	@echo "Teste 2: Entrada:abab1   Espera-se: Válido"
	@echo "abab1"  | ./cov
	@bash invalid_cov
	@echo " "
	gcov -b identifier.c
	@echo " "
	@echo "----------------------------------------------------------"
	@echo " "

cppcheck: identifier.c
	@echo "Runinng CPPCHECK"
	@echo " "
	cppcheck --enable=all --suppress=missingIncludeSystem identifier.c
	@echo " "
	@echo "----------------------------------------------------------"
	@echo " "

valgrind:
	@echo "Runinng Valgrind"
	@echo " "
	$(GCC) $(GCCFLAGS) identifier.c -o identifier.exe
	@echo " "
	@echo "Teste 1: Entrada:abcde   Espera-se: Válido"
	@echo "abcde"  | valgrind --leak-check=full --show-leak-kinds=all ./identifier.exe
	@echo "Teste 2: Entrada:abab1   Espera-se: Válido"
	@echo "abab1"  | valgrind --leak-check=full --show-leak-kinds=all ./identifier.exe
	@bash invalid_valgrind
	@echo " "
	@echo "----------------------------------------------------------"
	@echo " "

sanitize:
	@echo "Runinng Sanitize"
	@echo " "
	$(GCC) $(GCCFLAGS) -fsanitize=address identifier.c -o identifier.exe
	@echo " "
	@echo "Teste 1: Entrada:abcde   Espera-se: Válido"
	@echo "abcde"  | ./identifier.exe
	@echo "Teste 2: Entrada:abab1   Espera-se: Válido"
	@echo "abab1"  | ./identifier.exe
	@bash invalid_sanitize	
	@echo " "

clean:
	$(RM) $(ALL)   *.o
	

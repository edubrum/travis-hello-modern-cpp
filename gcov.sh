#!/bin/bash
#!/user/bih/bash
echo "Teste 1: Entrada:abcde   Espera-se: Válido"
	echo "abcde"  | ./cov
	echo "Teste 2: Entrada:abab1   Espera-se: Válido"
	echo "abab1"  | ./cov
	echo "Teste 3: Entrada:e3a   Espera-se: Inválido"
	echo "e3a"  | ./cov
	echo "Teste 4: Entrada:9   Espera-se: Inválido"
	echo '9'  | ./cov

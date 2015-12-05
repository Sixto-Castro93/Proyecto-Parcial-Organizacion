.data
saludo:.asciiz "Bienvenidos a la suma, usted puede ingresar números de base decimal y hexadecimal(anteponiendo 0X)\nIngrese los números a sumar \nPara acabar la suma, presione Enter \n"
resultado:.asciiz "El resultado de la suma es: "
errorNum:.asciiz "El dato que ingresó no es un número de base decimal ni hexadecimal.\n Por favor, inténtelo de nuevo:\n"
NumInput: .space 50 #Variable NumInput con tamaño para reservar un máximo de 50 bytes para almacenar el número decimal/hexadecimal ingresado por el usuario.


.text

#Método principal que muestra un mensaje de Bienvenida a la suma de números de base decimal y hexadecimal, y llama al método ingresarNumero para que el usuario pueda ingresar los números a sumar.
#La directiva .globl permite a este método ser invocado desde otro archivo que en este caso sería desde el archivo principal programaPrincipal.asm.
.globl main3
main3: 
la $4, saludo
li $2, 4
syscall
addi $s0,$0,0
j ingresarNumero


#ingresarNumero: Método que permite al usuario ingresar números de base decimal y hexadecimal para la respectiva suma posteriormente.
#También se encarga de verificar si los primeros caracteres ingresados por el usuario comienza con 0X con el fin de saber si se trata un número hexadecimal. Caso contrario llama al método comprobarNumeroDecimal.
#Si se encuentra un Enter al principio de la cadena, en otras palabras si no se ingresó ningún número, se muestra el resultado correspondiente a la suma de los números ingresados previamente.
ingresarNumero: 
li $2,8
la $a0,NumInput
ori $a1,$zero,50
syscall
add $t0, $0,$a0
addi $t4, $0,0
lb $t1,($t0)
beq $t1, 10, mostrarResultado
addi $t6,$0,48
bne $t1, $t6, comprobarNumeroDecimal
add $t5,$t0,1
lb $t1,($t5)
beq $t1, 88, esHexadecimal


#comprobarNumeroDecimal: Método que se encarga de verificar si cada caracter ingresado es un número de base decimal. En caso de no serlo, se muestra el mensaje de error respectivo.
comprobarNumeroDecimal:
lb $t1,($t0)
slti $t3, $t1, 59
beq $t3, 0,  mensajeError
slti $t3,$t1,48
beq $t3, 1, mensajeError
sub $t1,$t1, 48
mul $t4,$t4, 10
add $t4,$t1, $t4
addi $t0, $t0,1
lb $t1,($t0)
beq $t1, 10, suma
j comprobarNumeroDecimal

#Método que suma 2 posiciones a la dirección base del arreglo con el fin de no tomar en consideración los 2 primeros caracteres "0X" para posteriormente hacer la suma.
esHexadecimal:
addi $t0,$t0,2

#comprobarNumeroHex: Método que se encarga de verificar si cada caracter ingresado es un número hexadecimal. En caso de no serlo, se muestra un mensaje de error.
comprobarNumeroHex:
lb $t1,($t0)
slti $t3, $t1, 59
beq $t3, 0,  esLetraMinuscula
slti $t3,$t1,48
beq $t3, 1, mensajeError
sub $t1,$t1, 48
sll $t4, $t4,4
or $t4,$t1, $t4
addi $t0, $t0,1
lb $t1,($t0)
beq $t1, 10, suma
j comprobarNumeroHex

#esLetraMinuscula: Método que se encarga de verificar si el caracter ingresado es un número hexadecimal entre 'a' y 'f'. Sino se cumple, se muestra un mensaje indicando que lo ingresado por el usuario no es número hexadecimal.
esLetraMinuscula:
slti $t3, $t1, 71
beq $t3, 0, esLetraMayuscula
slti $t3,$t1,65
beq $t3, 1, mensajeError
sub $t1,$t1, 55
sll $t4, $t4,4
or $t4,$t1, $t4
addi $t0, $t0,1
lb $t1,($t0)
beq $t1, 10, suma
j comprobarNumeroHex


#esLetraMayuscula: Método que se encarga de verificar si el caracter ingresado es un número hexadecimal entre 'a' y 'f'. Sino se cumple, se muestra un mensaje indicando que lo ingresado por el usuario no es número hexadecimal.
esLetraMayuscula:
slti $t3, $t1, 103
beq $t3, 0,  mensajeError
slti $t3,$t1,97 
beq $t3, 1, mensajeError
sub $t1,$t1, 87
sll $t4, $t4,4
or $t4,$t1, $t4
addi $t0, $t0,1
lb $t1,($t0)
beq $t1, 10, suma
j comprobarNumeroHex

#suma: Método que se encarga de sumar números decimales y/o hexadecimales. Finalmente llama al método ingresarNumero para seguir ingresando números decimales/hexadecimales.
suma: 
add $s0,$t4,$s0
j ingresarNumero


#mostrarResultado: Método que sirve para mostrar el resultado de la suma. Y una vez mostrado el resultado, se le muestra al usuario de nuevo el menú principal para que pueda escoger la operación que desee realizar. 
mostrarResultado:
la $4, resultado
li $2, 4
syscall
la $4, ($s0)
li $2, 1
syscall
jal elegirOpcion


#mensajeError: Método que sirve para indicar al usuario que el número que ingresó no es un número decimal ni hexadecimal mostrando el mensaje: El dato que ingresó no es un hexadecimal. Por favor, inténtelo de nuevo. 
mensajeError:
la $4, errorNum
li $2, 4
syscall
j ingresarNumero

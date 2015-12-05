.data
saludo:.asciiz "Bienvenidos a la suma, usted puede ingresar n�meros de base decimal y hexadecimal(anteponiendo 0X)\nIngrese los n�meros a sumar \nPara acabar la suma, presione Enter \n"
resultado:.asciiz "El resultado de la suma es: "
errorNum:.asciiz "El dato que ingres� no es un n�mero de base decimal ni hexadecimal.\n Por favor, int�ntelo de nuevo:\n"
NumInput: .space 50 #Variable NumInput con tama�o para reservar un m�ximo de 50 bytes para almacenar el n�mero decimal/hexadecimal ingresado por el usuario.


.text

#M�todo principal que muestra un mensaje de Bienvenida a la suma de n�meros de base decimal y hexadecimal, y llama al m�todo ingresarNumero para que el usuario pueda ingresar los n�meros a sumar.
#La directiva .globl permite a este m�todo ser invocado desde otro archivo que en este caso ser�a desde el archivo principal programaPrincipal.asm.
.globl main3
main3: 
la $4, saludo
li $2, 4
syscall
addi $s0,$0,0
j ingresarNumero


#ingresarNumero: M�todo que permite al usuario ingresar n�meros de base decimal y hexadecimal para la respectiva suma posteriormente.
#Tambi�n se encarga de verificar si los primeros caracteres ingresados por el usuario comienza con 0X con el fin de saber si se trata un n�mero hexadecimal. Caso contrario llama al m�todo comprobarNumeroDecimal.
#Si se encuentra un Enter al principio de la cadena, en otras palabras si no se ingres� ning�n n�mero, se muestra el resultado correspondiente a la suma de los n�meros ingresados previamente.
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


#comprobarNumeroDecimal: M�todo que se encarga de verificar si cada caracter ingresado es un n�mero de base decimal. En caso de no serlo, se muestra el mensaje de error respectivo.
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

#M�todo que suma 2 posiciones a la direcci�n base del arreglo con el fin de no tomar en consideraci�n los 2 primeros caracteres "0X" para posteriormente hacer la suma.
esHexadecimal:
addi $t0,$t0,2

#comprobarNumeroHex: M�todo que se encarga de verificar si cada caracter ingresado es un n�mero hexadecimal. En caso de no serlo, se muestra un mensaje de error.
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

#esLetraMinuscula: M�todo que se encarga de verificar si el caracter ingresado es un n�mero hexadecimal entre 'a' y 'f'. Sino se cumple, se muestra un mensaje indicando que lo ingresado por el usuario no es n�mero hexadecimal.
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


#esLetraMayuscula: M�todo que se encarga de verificar si el caracter ingresado es un n�mero hexadecimal entre 'a' y 'f'. Sino se cumple, se muestra un mensaje indicando que lo ingresado por el usuario no es n�mero hexadecimal.
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

#suma: M�todo que se encarga de sumar n�meros decimales y/o hexadecimales. Finalmente llama al m�todo ingresarNumero para seguir ingresando n�meros decimales/hexadecimales.
suma: 
add $s0,$t4,$s0
j ingresarNumero


#mostrarResultado: M�todo que sirve para mostrar el resultado de la suma. Y una vez mostrado el resultado, se le muestra al usuario de nuevo el men� principal para que pueda escoger la operaci�n que desee realizar. 
mostrarResultado:
la $4, resultado
li $2, 4
syscall
la $4, ($s0)
li $2, 1
syscall
jal elegirOpcion


#mensajeError: M�todo que sirve para indicar al usuario que el n�mero que ingres� no es un n�mero decimal ni hexadecimal mostrando el mensaje: El dato que ingres� no es un hexadecimal. Por favor, int�ntelo de nuevo. 
mensajeError:
la $4, errorNum
li $2, 4
syscall
j ingresarNumero

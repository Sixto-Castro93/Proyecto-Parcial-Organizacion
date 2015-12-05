.data
saludo:.asciiz "Bienvenidos a la suma hexadecimal\nIngrese los n�meros a sumar. \nPara acabar la suma, presione Enter \n"
resultado:.asciiz "El resultado de la suma es: "
errorNumHex:.asciiz "El dato que ingres� no es un hexadecimal.\n Por favor, int�ntelo de nuevo:\n"
NumInputHex: .space 50 #Variable NumInputHex con tama�o para reservar un m�ximo de 50 bytes para almacenar el n�mero hexadecimal ingresado por el usuario.

.text

#M�todo principal que muestra un mensaje de Bienvenida a la suma de n�meros hexadecimales y llama al m�todo ingresarNumero para que el usuario pueda ingresar los n�meros a sumar.
#La directiva .globl permite a este m�todo ser invocado desde otro archivo que en este caso ser�a desde el archivo principal programaPrincipal.asm.
.globl main2
main2: 
la $4, saludo
li $2, 4
syscall
addi $s0,$0,0
j ingresarNumeroHex


#ingresarNumeroHex: M�todo que permite al usuario ingresar n�meros hexadecimales para la respectiva suma posteriormente.
ingresarNumeroHex: 
li $2,8
la $a0,NumInputHex
ori $a1,$zero,50
syscall
add $t0, $0,$a0
addi $t4, $0,0


#comprobarNumeroHex: M�todo que se encarga de verificar si cada caracter ingresado es un n�mero hexadecimal. En caso de no serlo, se muestra un mensaje de error.
#Si se encuentra un Enter al principio de la cadena, en otras palabras si no se ingres� ning�n n�mero, se muestra el resultado correspondiente a la suma de los n�meros ingresados previamente.
comprobarNumeroHex:
lb $t1,($t0)
beq $t1, 10, mostrarResultadoHex
slti $t3, $t1, 59
beq $t3, 0,  esLetraMinuscula
slti $t3,$t1,48
beq $t3, 1, mensajeErrorHex
sub $t1,$t1, 48
sll $t4, $t4,4
or $t4,$t1, $t4
addi $t0, $t0,1
lb $t1,($t0)
beq $t1, 10, sumaHex
j comprobarNumeroHex


#esLetraMinuscula: M�todo que se encarga de verificar si el caracter ingresado es un n�mero hexadecimal entre 'a' y 'f'. Sino se cumple, se muestra un mensaje indicando que lo ingresado por el usuario no es n�mero hexadecimal.
esLetraMinuscula:
slti $t3, $t1, 71
beq $t3, 0, esLetraMayuscula
slti $t3,$t1,65
beq $t3, 1, mensajeErrorHex
sub $t1,$t1, 55
sll $t4, $t4,4
or $t4,$t1, $t4
addi $t0, $t0,1
lb $t1,($t0)
beq $t1, 10, sumaHex
j comprobarNumeroHex


#esLetraMayuscula: M�todo que se encarga de verificar si el caracter ingresado es un n�mero hexadecimal entre 'A' y 'F'. Sino se cumple, se muestra un mensaje indicando que lo ingresado por el usuario no es n�mero hexadecimal.
esLetraMayuscula:
slti $t3, $t1, 103
beq $t3, 0,  mensajeErrorHex
slti $t3,$t1,97 
beq $t3, 1, mensajeErrorHex
sub $t1,$t1, 87
sll $t4, $t4,4
or $t4,$t1, $t4
addi $t0, $t0,1
lb $t1,($t0)
beq $t1, 10, sumaHex
j comprobarNumeroHex



#M�todo sumaHex: El valor obtenido en el registro $t4(string ingresado por el usuario transformado a n�mero hexadecimal) se va acumulando en el registro $s0 que se encarga de llevar la suma de todos los n�meros ingresados. Finalmente llama al m�todo ingresarNumeroHex para seguir ingresando n�meros hexadecimales.
sumaHex: 
add $s0,$t4,$s0
j ingresarNumeroHex


#mostrarResultadoHex: M�todo que muestra el resultado de la suma en formato hexadecimal. Y una vez mostrado el resultado, se le muestra al usuario de nuevo el men� principal para que pueda escoger la operaci�n que desee realizar. 
mostrarResultadoHex:
la $4, resultado
li $2, 4
syscall
la $4, ($s0)
li $2, 34
syscall
jal elegirOpcion


#mensajeErrorHex: M�todo que indica al usuario que el n�mero que ingres� no es hexadecimal mostrando el mensaje: El dato que ingres� no es un hexadecimal. Por favor, int�ntelo de nuevo. 
mensajeErrorHex:
la $4, errorNumHex
li $2, 4
syscall
j ingresarNumeroHex

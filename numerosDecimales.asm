.data
bienvenida:.asciiz "Bienvenidos a la suma de n�meros de base decimal\nIngrese los n�meros a sumar \nPara acabar la suma, presione Enter \n"
resultado:.asciiz "El resultado de la suma es: "
errornum:.asciiz "El dato que ingres� no es un n�mero de base 10.\n Por favor, int�ntelo de nuevo:\n"
numInputDecimal: .space 50 #Variable numInputDecimal con tama�o para reservar un m�ximo de 50 bytes para almacenar el n�mero de base decimal ingresado por el usuario.


.text

#M�todo principal que muestra un mensaje de Bienvenida a la suma de n�meros de base 10 y llama al m�todo ingresarNumeroDecimal para que el usuario pueda ingresar los n�meros a sumar.
#La directiva .globl permite a este m�todo ser invocado desde otro archivo que en este caso ser�a desde el archivo principal programaPrincipal.asm.
.globl main1
main1: 
la $4, bienvenida
li $2, 4
syscall
addi $s0,$0,0
j ingresarNumeroDecimal


#ingresarNumeroDecimal: M�todo que permite al usuario ingresar n�meros(base 10) para la respectiva suma posteriormente.
ingresarNumeroDecimal: 
li $2,8 
la $a0,numInputDecimal # $a0 => buffer para guardar la cadena(n�mero ingresado)
ori $a1,$zero,50 # $a1 => tama�o a leer
syscall
add $t0, $0,$a0
addi $t4, $0,0


#comprobarNumeroDecimal: M�todo que se encarga de verificar si cada caracter ingresado es un n�mero de base 10. En caso de no serlo, se muestra un mensaje de error.
#Si se encuentra un Enter al principio de la cadena, en otras palabras si no se ingres� ning�n n�mero, se muestra el resultado correspondiente a la suma de los n�meros ingresados previamente.
comprobarNumeroDecimal:
lb $t1,($t0)
beq $t1, 10, mostrarResultado
slti $t3, $t1, 59
beq $t3, 0, mensajeError
slti $t3,$t1,47
beq $t3, 1, mensajeError
sub $t1,$t1, 48
mul $t4,$t4, 10
add $t4,$t1, $t4 #Registro $t4 se encarga de concatenar cada caracter ingresado hasta antes del Enter con el fin de formar la cadena(n�mero ingresado).
addi $t0, $t0,1
lb $t1,($t0)
beq $t1, 10, sumaDecimal
j comprobarNumeroDecimal


#M�todo sumaDecimal: El valor obtenido en el registro $t4(string ingresado por el usuario transformado a n�mero de base decimal) se va acumulando en el registro $s0 que se encarga de llevar la suma de todos los n�meros ingresados. Finalmente llama al m�todo ingresarNumeroDecimal para seguir ingresando n�meros de base 10.
sumaDecimal: 
add $s0,$t4,$s0
j ingresarNumeroDecimal

#mostrarResultado: M�todo que muestra el resultado de la suma de los n�meros ingresados por el usuario. Y una vez mostrado el resultado, se le muestra al usuario de nuevo el men� principal para que pueda escoger la operaci�n que desee realizar. 
mostrarResultado:
la $4, resultado
li $2, 4
syscall
la $4, ($s0)
li $2, 1
syscall
jal elegirOpcion

#mensajeError: M�todo que sirve para indicar al usuario que ingres� un dato err�neo mostrando el mensaje: El dato que ingres� no es un n�mero de base 10. Por favor, int�ntelo de nuevo. 
mensajeError:
la $4, errornum
li $2, 4
syscall
j ingresarNumeroDecimal

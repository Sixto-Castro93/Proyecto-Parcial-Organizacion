.data
bienvenida:.asciiz "Bienvenidos a la suma de números de base decimal\nIngrese los números a sumar \nPara acabar la suma, presione Enter \n"
resultado:.asciiz "El resultado de la suma es: "
errornum:.asciiz "El dato que ingresó no es un número de base 10.\n Por favor, inténtelo de nuevo:\n"
numInputDecimal: .space 50 #Variable numInputDecimal con tamaño para reservar un máximo de 50 bytes para almacenar el número de base decimal ingresado por el usuario.


.text

#Método principal que muestra un mensaje de Bienvenida a la suma de números de base 10 y llama al método ingresarNumeroDecimal para que el usuario pueda ingresar los números a sumar.
#La directiva .globl permite a este método ser invocado desde otro archivo que en este caso sería desde el archivo principal programaPrincipal.asm.
.globl main1
main1: 
la $4, bienvenida
li $2, 4
syscall
addi $s0,$0,0
j ingresarNumeroDecimal


#ingresarNumeroDecimal: Método que permite al usuario ingresar números(base 10) para la respectiva suma posteriormente.
ingresarNumeroDecimal: 
li $2,8 
la $a0,numInputDecimal # $a0 => buffer para guardar la cadena(número ingresado)
ori $a1,$zero,50 # $a1 => tamaño a leer
syscall
add $t0, $0,$a0
addi $t4, $0,0


#comprobarNumeroDecimal: Método que se encarga de verificar si cada caracter ingresado es un número de base 10. En caso de no serlo, se muestra un mensaje de error.
#Si se encuentra un Enter al principio de la cadena, en otras palabras si no se ingresó ningún número, se muestra el resultado correspondiente a la suma de los números ingresados previamente.
comprobarNumeroDecimal:
lb $t1,($t0)
beq $t1, 10, mostrarResultado
slti $t3, $t1, 59
beq $t3, 0, mensajeError
slti $t3,$t1,47
beq $t3, 1, mensajeError
sub $t1,$t1, 48
mul $t4,$t4, 10
add $t4,$t1, $t4 #Registro $t4 se encarga de concatenar cada caracter ingresado hasta antes del Enter con el fin de formar la cadena(número ingresado).
addi $t0, $t0,1
lb $t1,($t0)
beq $t1, 10, sumaDecimal
j comprobarNumeroDecimal


#Método sumaDecimal: El valor obtenido en el registro $t4(string ingresado por el usuario transformado a número de base decimal) se va acumulando en el registro $s0 que se encarga de llevar la suma de todos los números ingresados. Finalmente llama al método ingresarNumeroDecimal para seguir ingresando números de base 10.
sumaDecimal: 
add $s0,$t4,$s0
j ingresarNumeroDecimal

#mostrarResultado: Método que muestra el resultado de la suma de los números ingresados por el usuario. Y una vez mostrado el resultado, se le muestra al usuario de nuevo el menú principal para que pueda escoger la operación que desee realizar. 
mostrarResultado:
la $4, resultado
li $2, 4
syscall
la $4, ($s0)
li $2, 1
syscall
jal elegirOpcion

#mensajeError: Método que sirve para indicar al usuario que ingresó un dato erróneo mostrando el mensaje: El dato que ingresó no es un número de base 10. Por favor, inténtelo de nuevo. 
mensajeError:
la $4, errornum
li $2, 4
syscall
j ingresarNumeroDecimal

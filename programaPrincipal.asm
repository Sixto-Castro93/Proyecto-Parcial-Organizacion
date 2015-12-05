.data

saludo:.asciiz "Bienvenidos a la suma de números decimales y hexadecimales\nIngrese la opción a ejecutar\n"
errorOpcion:.asciiz "\nIngrese una opción válida \n"
opcion1:.asciiz "\n1- Presione 1 para realizar suma de números decimales\n"
opcion2:.asciiz "2- Presione 2 para realizar suma de números hexadecimales\n"
opcion3:.asciiz "3- Presione 3 para realizar suma de números decimales & hexadecimales\n"
opcion4:.asciiz "4- Salir\n"
msj1:.asciiz "\nNúmeros Decimales\n"
msj2:.asciiz "\nNúmeros Hexadecimales\n"
msj3:.asciiz "\nNúmeros Decimales & hexadecimales\n"
msj4:.asciiz "\nUsted ha salido del programa\n"
opcionInput: .space 50 #Variable opcionInput sirve para almacenar la opción que elija el usuario en el menú.



.text

inicio: 
la $4, saludo
li $2, 4
syscall

#elegirOpcion: Método que muestra un menú principal al usuario para que éste pueda elegir si desea hacer una suma entre números decimales, hexadecimales, ambas a la vez, o salir del programa.
#La directiva .globl permite a este método ser invocado desde otros archivos.
.globl elegirOpcion
elegirOpcion:
addi $t5, $0, 1
addi $t6, $0, 2
addi $t7, $0, 3
addi $t8, $0, 4
la $4, opcion1
li $2, 4
syscall
la $4, opcion2
li $2, 4
syscall
la $4, opcion3
li $2, 4
syscall
la $4, opcion4
li $2, 4
syscall

#ingresarOpcion: Método que permite al usuario ingresar la opción a realizar que éste desee.
ingresarOpcion: 
li $2,8
la $a0,opcionInput
ori $a1,$zero,50
syscall
add $t0, $0,$a0


#comprobarOpcion: Método que se encarga de verificar si la opción ingresada por el usuario es válida o no. En caso de no serlo, se muestra un mensaje de error respectivo.
comprobarOpcion:
lb $t1,($t0)
beq $t1, 10, mensajeErrorOpcion
slti $t3, $t1, 59
beq $t3, 0, mensajeErrorOpcion
slti $t3,$t1,47
beq $t3, 1, mensajeErrorOpcion

addi $t1, $t1,-48 #turns ascii to int
addi $t4,$t1,0
la $4, ($t1)
li $2, 1
syscall

addi $t0, $t0,1
lb $t1,($t0)
beq $t1, 10, opciones
j mensajeErrorOpcion


#opciones: Método que redirige a la opción seleccionada por el usuario. 
opciones:
beq $t4, $t5, OP1
beq $t4, $t6, OP2
beq $t4, $t7, OP3
beq $t4, $t8, OP4
j mensajeErrorOpcion
li $2, 10
syscall


#mensajeError: Método que indica al usuario que ingresó una opción no válida, y le pide ingresar una opción correcta. 
mensajeErrorOpcion:
la $4, errorOpcion
li $2, 4
syscall
j ingresarOpcion


#OP1: Opción que redirige al método main del archivo numerosDecimales.asm para poder realizar la suma entre números de base decimal.
OP1:
la $4, msj1
li $2, 4
syscall
jal main1


#OP2: Opción que redirige al método main del archivo numerosHexadecimales.asm para poder realizar la suma entre números de base hexadecimal.
OP2:
la $4, msj2
li $2, 4
syscall
jal main2


#OP3: Opción que redirige al método main del archivo numerosDecimalHexadecimal.asm para poder realizar la suma entre números de base decimal/hexadecimal.
OP3:
la $4, msj3
li $2, 4
syscall
jal main3


#OP4: Opción que sirve para salir del programa.
OP4:
la $4, msj4
li $2, 4
syscall
li $2, 10
syscall



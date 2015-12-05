.data

saludo:.asciiz "Bienvenidos a la suma de n�meros decimales y hexadecimales\nIngrese la opci�n a ejecutar\n"
errorOpcion:.asciiz "\nIngrese una opci�n v�lida \n"
opcion1:.asciiz "\n1- Presione 1 para realizar suma de n�meros decimales\n"
opcion2:.asciiz "2- Presione 2 para realizar suma de n�meros hexadecimales\n"
opcion3:.asciiz "3- Presione 3 para realizar suma de n�meros decimales & hexadecimales\n"
opcion4:.asciiz "4- Salir\n"
msj1:.asciiz "\nN�meros Decimales\n"
msj2:.asciiz "\nN�meros Hexadecimales\n"
msj3:.asciiz "\nN�meros Decimales & hexadecimales\n"
msj4:.asciiz "\nUsted ha salido del programa\n"
opcionInput: .space 50 #Variable opcionInput sirve para almacenar la opci�n que elija el usuario en el men�.



.text

inicio: 
la $4, saludo
li $2, 4
syscall

#elegirOpcion: M�todo que muestra un men� principal al usuario para que �ste pueda elegir si desea hacer una suma entre n�meros decimales, hexadecimales, ambas a la vez, o salir del programa.
#La directiva .globl permite a este m�todo ser invocado desde otros archivos.
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

#ingresarOpcion: M�todo que permite al usuario ingresar la opci�n a realizar que �ste desee.
ingresarOpcion: 
li $2,8
la $a0,opcionInput
ori $a1,$zero,50
syscall
add $t0, $0,$a0


#comprobarOpcion: M�todo que se encarga de verificar si la opci�n ingresada por el usuario es v�lida o no. En caso de no serlo, se muestra un mensaje de error respectivo.
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


#opciones: M�todo que redirige a la opci�n seleccionada por el usuario. 
opciones:
beq $t4, $t5, OP1
beq $t4, $t6, OP2
beq $t4, $t7, OP3
beq $t4, $t8, OP4
j mensajeErrorOpcion
li $2, 10
syscall


#mensajeError: M�todo que indica al usuario que ingres� una opci�n no v�lida, y le pide ingresar una opci�n correcta. 
mensajeErrorOpcion:
la $4, errorOpcion
li $2, 4
syscall
j ingresarOpcion


#OP1: Opci�n que redirige al m�todo main del archivo numerosDecimales.asm para poder realizar la suma entre n�meros de base decimal.
OP1:
la $4, msj1
li $2, 4
syscall
jal main1


#OP2: Opci�n que redirige al m�todo main del archivo numerosHexadecimales.asm para poder realizar la suma entre n�meros de base hexadecimal.
OP2:
la $4, msj2
li $2, 4
syscall
jal main2


#OP3: Opci�n que redirige al m�todo main del archivo numerosDecimalHexadecimal.asm para poder realizar la suma entre n�meros de base decimal/hexadecimal.
OP3:
la $4, msj3
li $2, 4
syscall
jal main3


#OP4: Opci�n que sirve para salir del programa.
OP4:
la $4, msj4
li $2, 4
syscall
li $2, 10
syscall



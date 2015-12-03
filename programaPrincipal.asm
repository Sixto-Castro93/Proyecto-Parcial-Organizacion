.data

saludo:.asciiz "Bienvenidos a la suma de números decimales y hexadecimales\nIngrese la opción a ejecutar\n"
var2:.asciiz "Para acabar la suma presione Enter \n"
var3:.asciiz "\nIngrese una opción válida \n"


resultado:.asciiz "El resultado de la suma es : "
errornum:.asciiz "El dato que ingresó no es un hexadecimal,\n Por favor, inténtelo de nuevo :\n"

opcion1:.asciiz "\n1- Presione 1 para realizar suma de números decimales\n"
opcion2:.asciiz "2- Presione 2 para realizar suma de números hexadecimales\n"
opcion3:.asciiz "3- Presione 3 para realizar suma de números decimales & hexadecimales\n"
opcion4:.asciiz "4- Salir\n"
msj1:.asciiz "\nDecimales\n"
msj2:.asciiz "\nHexadecimales\n"
msj3:.asciiz "\nDecimales e hexadecimales\n"
msj4:.asciiz "\nUsted ha salido del programa\n"
str1: .space 50
.space 100


.text

_start: la $4, saludo
li $2, 4
syscall


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


ingrenum: 
li $2,8
la $a0,str1
ori $a1,$zero,50
syscall
add $t0, $0,$a0

comprueba:
lb $t1,($t0)
beq $t1, 10, error
slti $t3, $t1, 59
beq $t3, 0, error
slti $t3,$t1,47
beq $t3, 1, error

addi $t1, $t1,-48 # turns ascii to int
addi $t4,$t1,0
la $4, ($t1)
li $2, 1
syscall

addi $t0, $t0,1
lb $t1,($t0)
beq $t1, 10, opciones
j error


opciones:
beq $t4, $t5, OP1
beq $t4, $t6, OP2
beq $t4, $t7, OP3
beq $t4, $t8, OP4
j error

li $2, 10
syscall


error:
la $4, var3
li $2, 4
syscall
j ingrenum



OP1:
la $4, msj1
li $2, 4
syscall
jal main1

OP2:
la $4, msj2
li $2, 4
syscall
jal main2


OP3:
la $4, msj3
li $2, 4
syscall
jal main3

OP4:
la $4, msj4
li $2, 4
syscall
li $2, 10
syscall



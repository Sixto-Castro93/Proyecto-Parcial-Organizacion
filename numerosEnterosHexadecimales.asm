.data
saludo:.asciiz "Bienvenidos a la suma, puede ingresar números enteros y hexadecimales(anteponiendo 0X)\nIngrese los números a sumar \n"
var2:.asciiz "Para acabar la suma presione Enter \n"
resultado:.asciiz "El resultado de la suma es : "
errornum:.asciiz "El dato que ingreso no es un hexadecimal o entero,\n Por favor, inténtelo de nuevo :\n"
str1: .space 50
.space 100
.text
.globl main3

main3: la $4, saludo
li $2, 4
syscall
la $4, var2
li $2, 4
syscall
addi $s0,$0,0
j ingrenum

ingrenum: 
li $2,8
# $a0 = buffer para guardar la cadena
la $a0,str1
# $a1 = tama?o a leer
ori $a1,$zero,50
syscall
add $t0, $0,$a0
addi $t4, $0,0
lb $t1,($t0)
beq $t1, 10, error
addi $t6,$0,48
bne $t1, $t6, comprueba
add $t5,$t0,1
lb $t1,($t5)
beq $t1, 88,  esHexa
comprueba:
lb $t1,($t0)
slti $t3, $t1, 59
beq $t3, 0,  error2
slti $t3,$t1,48
beq $t3, 1, error2
sub $t1,$t1, 48
mul $t4,$t4, 10
add $t4,$t1, $t4
addi $t0, $t0,1
lb $t1,($t0)
beq $t1, 10, suma
j comprueba

esHexa:
addi $t0,$t0,2
Hexa:
lb $t1,($t0)
slti $t3, $t1, 59
beq $t3, 0,  esLetraSum
slti $t3,$t1,48
beq $t3, 1, error2
sub $t1,$t1, 48
sll $t4, $t4,4
or $t4,$t1, $t4
addi $t0, $t0,1
lb $t1,($t0)
beq $t1, 10, suma
j Hexa

esLetraSum:
slti $t3, $t1, 71
beq $t3, 0, esLetraSumM
slti $t3,$t1,65
beq $t3, 1, error2
sub $t1,$t1, 55
sll $t4, $t4,4
or $t4,$t1, $t4
addi $t0, $t0,1
lb $t1,($t0)
beq $t1, 10, suma
j Hexa


esLetraSumM:
slti $t3, $t1, 103
beq $t3, 0,  error2
slti $t3,$t1,97 
beq $t3, 1, error2
sub $t1,$t1, 87
sll $t4, $t4,4
or $t4,$t1, $t4
addi $t0, $t0,1
lb $t1,($t0)
beq $t1, 10, suma
j Hexa

suma: 
add $s0,$t4,$s0
j ingrenum

error:
la $4, resultado
li $2, 4
syscall
la $4, ($s0)
li $2, 1
syscall
jal elegirOpcion
#li $2, 10
#syscall

error2:
la $4, errornum
li $2, 4
syscall
j ingrenum

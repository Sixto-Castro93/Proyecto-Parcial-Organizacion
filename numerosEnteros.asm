.data
var2:.asciiz "Bienvenidos a la suma de números enteros\nIngrese los números a sumar \nPara acabar la suma presione Enter \n"
resultado:.asciiz "El resultado de la suma es : "
errornum:.asciiz "El dato que ingresó no es un entero,\n Por favor, inténtelo de nuevo :\n"
str1: .space 50
.space 100

.text

.globl main1
main1: 
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
comprueba:
lb $t1,($t0)
beq $t1, 10, error
slti $t3, $t1, 59
beq $t3, 0, error2
slti $t3,$t1,47
beq $t3, 1, error2
sub $t1,$t1, 48
mul $t4,$t4, 10
add $t4,$t1, $t4
addi $t0, $t0,1
lb $t1,($t0)
beq $t1, 10, suma
j comprueba

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

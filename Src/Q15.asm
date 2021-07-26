.data 0x10020000
array:	.space	80 # 20 words
start_message: .asciiz "Enter two numbers and I'll show you the sum,\ndifference, product, quotient, and remainder.\n\nFirst number: "
second_number_str: .asciiz "Second  number: "
newline_str: .asciiz "\n"
operation_plus_str: .asciiz " + "
operation_minus_str: .asciiz " - "
operation_multiply_str: .asciiz " x "
operation_divide_str: .asciiz " / "
operation_divide_remainder_str: .asciiz " R "
operation_equals_str: .asciiz " = "

.text
li $a0, 0x10020000
jal init_array
la $a0, start_message
li $v0, 4 # print string
syscall 
li $v0, 5
syscall
add $t4, $v0, $zero # t4 = first number
la $a0, second_number_str
li $v0, 4 # print string
syscall 
li $v0, 5
syscall
add $t5, $v0, $zero # t5 = second number
la $a0, newline_str
li $v0, 4 # print string
syscall

### Plus operation ###
add $a0, $t4, $zero
li $v0, 1
syscall
la $a0, operation_plus_str
li $v0, 4 # print string
syscall
add $a0, $t5, $zero
li $v0, 1
syscall
la $a0, operation_equals_str
li $v0, 4 # print string
syscall
add $t6, $t4, $t5
add $a0, $t6, $zero
li $v0, 1
syscall
la $a0, newline_str
li $v0, 4 # print string
syscall

#### Minus operation ###
add $a0, $t4, $zero
li $v0, 1
syscall
la $a0, operation_minus_str
li $v0, 4 # print string
syscall
add $a0, $t5, $zero
li $v0, 1
syscall
la $a0, operation_equals_str
li $v0, 4 # print string
syscall
sub $t6, $t4, $t5
add $a0, $t6, $zero
li $v0, 1
syscall
la $a0, newline_str
li $v0, 4 # print string
syscall

### Multiply operation ###
add $a0, $t4, $zero
li $v0, 1
syscall
la $a0, operation_multiply_str
li $v0, 4 # print string
syscall
add $a0, $t5, $zero
li $v0, 1
syscall
la $a0, operation_equals_str
li $v0, 4 # print string
syscall
mul $t6, $t4, $t5
add $a0, $t6, $zero
li $v0, 1
syscall
la $a0, newline_str
li $v0, 4 # print string
syscall

### Divide operation ###
add $a0, $t4, $zero
li $v0, 1
syscall
la $a0, operation_divide_str
li $v0, 4 # print string
syscall
add $a0, $t5, $zero
li $v0, 1
syscall
la $a0, operation_equals_str
li $v0, 4 # print string
syscall
div $t6, $t4, $t5
rem $t7, $t4, $t5
add $a0, $t6, $zero
li $v0, 1
syscall
la $a0, operation_divide_remainder_str
li $v0, 4 # print string
syscall
add $a0, $t7, $zero
li $v0, 1
syscall
la $a0, newline_str
li $v0, 4 # print string
syscall
b end

#------------------------#
init_array:
add $t2, $a0, $zero
li $t3, 0
_init_array_loop_start:
	li $v0, 42
	li $a0, 0
	li $a1, 101
	syscall
	subi $a0, $a0, 50
	sw $a0, ($t2)
	addi $t2, $t2, 4
	addi $t3, $t3, 1
	bne $t3, 20, _init_array_loop_start
subi $t2, $t2, 80
jr $ra

#------------------------#
end:

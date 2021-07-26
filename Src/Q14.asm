.data 0x10020000
array:	.space	80 # 20 words
str_to_print: .asciiz "Enter a number: "

.text
li $a0, 0x10020000
jal init_array
la $a0, str_to_print
li $v0, 4 # print string
syscall 
li $v0, 5
syscall
li $a0, 0x10020000
add $a1, $v0, $zero
jal get_occurrences_in_array
add $a0, $v0, $zero
li $v0, 1 # print integer
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
get_occurrences_in_array:
add $t0, $a0, $zero # address of array
add $t6, $a1, $zero
li $t1, 0 # start from index 0
li $t4, 0
_get_occurrences_in_array_loop_start:
	lw $t3, ($t0)
	bne $t3, $t6, _skip_occurrence
		add $t4, $t4, 1
	_skip_occurrence:
	addi $t0, $t0, 4
	addi $t1, $t1, 1
	bne $t1, 20, _get_occurrences_in_array_loop_start
add $v0, $t4, $zero
jr $ra

#------------------------#
end:

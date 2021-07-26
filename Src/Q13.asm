.data 0x10020000
array:	.space	80 # 20 words

.text
li $a0, 0x10020000
jal init_array
li $a0, 0x10020000
jal add_0x1000_to_array
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
add_0x1000_to_array:
add $t0, $a0, $zero
li $t1, 0
_add_0x1000_to_array_loop_start:
	lw $t2, ($t0)
	add $t2, $t2, 0x1000
	sw $t2, ($t0)
	addi $t0, $t0, 4
	addi $t1, $t1, 1
	bne $t1, 20, _add_0x1000_to_array_loop_start
jr $ra

#------------------------#
end:

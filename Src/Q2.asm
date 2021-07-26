.data 0x10020000
array:	.space	80 # 20 words

.text
jal init_array
b end

#------------------------#
init_array:
la $t2, array
li $t3, 0
loop_start:
	li $v0, 42
	li $a0, 0
	li $a1, 101
	syscall
	subi $a0, $a0, 50
	sw $a0, ($t2)
	addi $t2, $t2, 4
	addi $t3, $t3, 1
	bne $t3, 20, loop_start
subi $t2, $t2, 80
jr $ra
	
#------------------------#
end:

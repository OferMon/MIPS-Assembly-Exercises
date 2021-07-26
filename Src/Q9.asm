.data 0x10020000
array:	.space	80 # 20 words

.text
li $a0, 0x10020000
jal init_array
li $a0, 0x10020000
jal get_sum_of_block
add $a0, $v0, $zero # sum of array blocks
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
get_sum_of_block:
add $t0, $a0, $zero
li $t2, 0
li $v0, 0
get_sum_of_block_loop_start:
	lw $t1, ($t0) # word 
	add $v0, $v0, $t1
	addi $t2, $t2, 1
	addi $t0, $t0, 4
	bne $t2, 20, get_sum_of_block_loop_start
jr $ra

#------------------------#
end:

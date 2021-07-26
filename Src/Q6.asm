.data 0x10020000
array:	.space	80 # 20 words

.text
li $a0, 0x10020000
jal init_array
li $a0, 0x10020000
jal find_lowest_word_in_array
add $a0, $v0, $zero # lowest word in array
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
find_lowest_word_in_array:
add $t0, $a0, $zero # address of array
li $t1, 0 # start from index 0
lw $t2, ($t0)
_find_lowest_word_in_array_loop_start:
	addi $t0, $t0, 4
	lw $t3, ($t0)
	ble $t2, $t3, _skip_lowest
		add $t2, $t3, $zero
	_skip_lowest:
	addi, $t1, $t1, 1
	bne $t1, 20, _find_lowest_word_in_array_loop_start
add $v0, $t2, $zero
jr $ra

#------------------------#
end:

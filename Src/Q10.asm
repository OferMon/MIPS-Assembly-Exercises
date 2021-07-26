.data 0x10020000
array:	.space	80 # 20 words

.text
li $a0, 0x10020000
jal init_array
li $a0, 0x10020000
jal add_following_2bytes
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
add_following_2bytes:
add $t0, $a0, $zero # array to exchange following bytes in
li $t4, 0  # internal loop counter
add_following_2bytes_loop_start:
	lh $t1, ($t0)
	lh $t2, 2($t0)
	add, $t1, $t1, $t2
	addi $t0, $t0, 2
	sh $t1, ($t0)
	addi $t0, $t0, 2
	addi $t4, $t4, 4
	bne $t4, 80, add_following_2bytes_loop_start
jr $ra

#------------------------#
end:

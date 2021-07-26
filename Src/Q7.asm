.data 0x10020000
array:	.space	80 # 20 words

.text
li $a0, 0x10020000
jal init_array
li $a0, 0x10020000
jal exchange_following_bytes
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
exchange_following_bytes:
add $t0, $a0, $zero # array to exchange following bytes in
li $t4, 0  # internal loop counter
exchange_following_bytes_loop_start:
	lb $t1, ($t0)
	lb $t2, 1($t0)
	sb $t2, ($t0)
	addi $t0, $t0, 1
	sb $t1, ($t0)
	addi $t0, $t0, 1
	addi $t4, $t4, 2
	bne $t4, 80, exchange_following_bytes_loop_start
jr $ra

#------------------------#
end:

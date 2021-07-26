.data 0x10020000
array:	.space	80 # 20 words

.text
li $a0, 0x10020000
jal init_array
li $a0, 0x10040000
jal init_array
li $a0, 0x10020000
li $a1, 0x10060000
li $a2, 20
jal memory_copy_words
li $a0, 0x10040000
li $a1, 0x10020000
li $a2, 20
jal memory_copy_words
li $a0, 0x10060000
li $a1, 0x10040000
li $a2, 20
jal memory_copy_words
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
memory_copy_words:
add $t0, $a0, $zero # source address
add $t1, $a1, $zero # destination address
add $t2, $a2, $zero # amount of words to copy
_memory_copy_words_loop_start:
	lw $t3, ($t0)
	sw $t3, ($t1)
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	subi $t2, $t2, 1
	bne $t2, 0, _memory_copy_words_loop_start
jr $ra
	
#------------------------#
end:

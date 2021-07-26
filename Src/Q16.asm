.data
buffer:	.space	1400
filename_read:  .asciiz "Allice.txt"	# filename for input
filename_write:	.asciiz "AlliceU.txt"	# filename for output

.text
jal ReadFile
jal Replace
jal WriteFile
b end

#------------------------#
ReadFile:

### open a file that exists ###
li   $v0, 13			# system call for open file
la   $a0, filename_read    	# input file name
li   $a1, 0       		# Open for reading (flags are 0: read, 1: write)
li   $a2, 0       		# mode is ignored
syscall           		# open a file (file descriptor returned in $v0)
move $s6, $v0      		# save the file descriptor 

### read from file just opened ###
li   $v0, 14       		# system call for read from file
move $a0, $s6      		# file descriptor 
la   $a1, buffer   		# address of buffer from which to write
li   $a2, 1385     		# hardcoded buffer length
syscall            		# read from file

### Close the file ### 
li   $v0, 16      		# system call for close file
move $a0, $s6     		# file descriptor to close
syscall          		# close file

### Return ###
jr $ra
  
#------------------------#
Replace:
li $t0, 0
la $t1, buffer	
_to_uppercase_loop:
	lb $t2, ($t1)
	blt $t2, 'a', skip_uppercase
	bgt $t2, 'z', skip_uppercase
		xor $t2, $t2, 0x20	# a->A ... z->Z
		sb $t2, ($t1)
	skip_uppercase:
	addi $t0, $t0, 1
	addi $t1, $t1, 1
	bne $t0, 1385, _to_uppercase_loop
jr $ra
	
#------------------------#	
WriteFile:

### Open (for writing) a file that does not exist ###
li   $v0, 13     		# system call for open file
la   $a0, filename_write	# output file name
li   $a1, 1       		# Open for writing (flags are 0: read, 1: write)
li   $a2, 0        		# mode is ignored
syscall           		# open a file (file descriptor returned in $v0)
move $s6, $v0      		# save the file descriptor 
  
### Write to file just opened ###
li   $v0, 15      		# system call for write to file
move $a0, $s6      		# file descriptor 
la   $a1, buffer   		# address of buffer from which to write
li   $a2, 1385    		# hardcoded buffer length
syscall           		# write to file
  
### Close the file ###
li   $v0, 16      		# system call for close file
move $a0, $s6     		# file descriptor to close
syscall            		# close file

### Return ###
jr $ra

#------------------------#
end:

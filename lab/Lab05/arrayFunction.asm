# arrayFunction.asm
       .data 
array: .word 8, 2, 1, 6, 9, 7, 3, 5, 0, 4
newl:  .asciiz "\n"
valPrefix: .asciiz "minimum value is : "
idxPrefix: .asciiz "minimum value index : "
       .text
main:
	# Print the original content of array
	# setup the parameter(s)
	# call the printArray function
	
	la $a0, array
	li $a1, 10
	jal printArray

	# Ask the user for two indices
	li   $v0, 5         	# System call code for read_int
	syscall           
	addi $t0, $v0, 0    	# first user input in $t0
 
	li   $v0, 5         	# System call code for read_int
	syscall           
	addi $t1, $v0, 0    	# second user input in $t1

	# Call the findMin function
	jal findMin
	# setup the parameter(s)
	# call the function


	# Print the min item
	# place the min item in $t3	for printing

	# Print an integer followed by a newline
	
	li $v0, 4
	la $a0, valPrefix
	syscall
	
	li   $v0, 1   		# system call code for print_int
    addi $a0, $t3, 0    # print $t3
    syscall       		# make system call

	li   $v0, 4   		# system call code for print_string
    la   $a0, newl    	# 
    syscall       		# print newline

	#Calculate and print the index of min item
	
	# Place the min index in $t3 for printing	

	# Print the min index
	# Print an integer followed by a newline
	
	li $v0, 4
	la $a0, idxPrefix
	syscall
	
	la $a0, array
	li   $v0, 1   		# system call code for print_int
	sub $t3, $t5, $a0
	srl $t3, $t3, 2
    addi $a0, $t3, 0    # print $t3
    syscall       		# make system call
	
	li   $v0, 4   		# system call code for print_string
    la   $a0, newl    	# 
    syscall       		# print newline
	
	# End of main, make a syscall to "exit"
	li   $v0, 10   		# system call code for exit
	syscall	       		# terminate program
	

#######################################################################
###   Function printArray   ### 
#Input: Array Address in $a0, Number of elements in $a1
#Output: None
#Purpose: Print array elements
#Registers used: $t0, $t1, $t2, $t3
#Assumption: Array element is word size (4-byte)
printArray:
	addi $t1, $a0, 0	# $t1 is the pointer to the item
	sll  $t2, $a1, 2	# $t2 is the offset beyond the last item
	add  $t2, $a0, $t2 	# $t2 is pointing beyond the last item
l1:	
	beq  $t1, $t2, e1
	lw   $t3, 0($t1)	# $t3 is the current item
	li   $v0, 1   		# system call code for print_int
    addi $a0, $t3, 0   	# integer to print
    syscall       		# print it
	addi $t1, $t1, 4
	j    l1				# Another iteration
e1:
	li   $v0, 4   		# system call code for print_string
    la   $a0, newl    	# 
    syscall       		# print newline
	jr   $ra			# return from this function


#######################################################################
###   Student Function findMin   ### 
#Input: Lower Array Pointer in $a0, Higher Array Pointer in $a1
#Output: $v0 contains the address of min item 
#Purpose: Find and return the minimum item 
#              between $a0 and $a1 (inclusive)
#Registers used: <Fill in with your register usage>
#Assumption: Array element is word size (4-byte), $a0 <= $a1
findMin:
    
	li $v0, 1
    la $a0, array     # a0->addr of first element
	sll $t0, $t0, 2
	add $a0, $a0, $t0
	lw $t3, 0($a0)    
 
	li $v0, 1
	la $a1, array
	sll $t1, $t1, 2
    add $a1, $a1, $t1 # a1->addr of last element
	
	# $t3 for minimum, $t2 for temp

	  beq $a0, $a1, Same
	  bne $a0, $a1, Loop
Same: sw $t3 0($a0)
      move $t5, $a0
      j Exit
	  
Loop: bgt $a0, $a1, Exit
      addi $a0, $a0, 4
	  lw $t2, 0($a0)
	  slt $t4, $t2, $t3
	  beq $t4, $0, Loop
	  move $t3, $t2
	  move $t5, $a0
	  j Loop

Exit:
	jr $ra			# return from this function

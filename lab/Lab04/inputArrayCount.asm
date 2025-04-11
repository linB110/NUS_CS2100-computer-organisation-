# arrayCount.asm
  .data 
arrayA: .word 1, 0, 2, 0, 3, 4, 5, 6   # arrayA has 5 values
count:  .word 999             # dummy value

  .text
main:
 
	la $t2, arrayA
	lw $t8, count
	
    # code for reading in the user value X
    add $t1, $t1, 8
	la $t3, arrayA
	
ReadInput:
    # code to read user input (8 integer) 
	li $v0, 5
	syscall
	move $t0, $v0
	
	sw $t0, 0($t3)
	addi $t3, $t3, 4
	addi $t1, $t1, -1
	bne $t1, 0, ReadInput
	
	li   $v0, 5
	syscall
	
	move $t0, $zero
	move $t1, $v0  # enter 2 by user
	
    # code for counting multiples of X in arrayA
	
	la $t3, arrayA
	move $t0, $zero
	li $t4, 0
	li $t5, 8
	
CheckMultiple:    
    beq $t4, $t5, PrintResult
	
    lw $t6, 0($t3)
	addi $t3, $t3, 4
	addi $t4, $t4, 1
	andi $t7, $t6, 0x0001
    bne $t7, $zero, CheckMultiple
	
    addi $t0, $t0, 1	
	bne $t4, $t5, CheckMultiple
	
    # code for printing result
PrintResult:
	li   $v0, 1
    move $a0, $t0
	syscall
	
    # code for terminating program
    li  $v0, 10
    syscall

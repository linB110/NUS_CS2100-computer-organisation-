# arrayCount.asm
  .data 
arrayA: .word 1, 0, 2, 0, 3, 4, 5, 6   # arrayA has 5 values
count:  .word 999             # dummy value

  .text
main:
    # code to setup the variable mappings
    add $zero, $zero, $zero  #dummy instructions, can be removed
    add $zero, $zero, $zero  #dummy instructions, can be removed
    add $zero, $zero, $zero  #dummy instructions, can be removed
    
	la $t0, arrayA
	lw $t8, count
    # code for reading in the user value X

    # code for counting multiples of X in arrayA

    # code for printing result

    # code for terminating program
    li  $v0, 10
    syscall

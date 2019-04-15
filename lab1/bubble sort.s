.data
msg1:.asciiz "The array before sort : "
msg2 : .asciiz "\nThe array after  sort : "
array : .word 5, 3, 6, 7, 31, 23, 43, 12, 45, 1

.text
.globl main
#------------------------- main -----------------------------
	main :
	li      $v0, 4				# call system call : print string
	la      $a0, msg1			# load address of string into $a0
	syscall                 	# run the syscall

	la $t5, array
	addi $t6, $zero, 0

	loop :
		lw	 $t7, ($t5)
		li   $v0, 1
		move   $a0, $t7
		syscall

		addi $t5, $t5, 4
		addi $t6, $t6, 1
		blt $t6, 10, loop

	jal bubblesort	

	li      $v0, 4				# call system call : print string
	la      $a0, msg2			# load address of string into $a0
	syscall                 	# run the syscall

	la $t5, array
	addi $t6, $zero, 0

	loop3:
		lw	 $t7, ($t5)
		li   $v0, 1
		move  $a0, $t7
		syscall

		addi $t5, $t5, 4
		addi $t6, $t6, 1
		blt $t6, 10, loop3

	li $v0, 10
	syscall

.text	
		bubblesort:
			addi $t1, $zero, 0
			loop1 :
				la $t0, array
				bgt $t1, 9, exit
				addi $t1, $t1, 1
				j loop2

				loop2 :
					bgt $t2, 9, exit1
					addi $t2, $t2, 1
					lw  $a0, 0($t0)   
					lw  $a1, 4($t0)
					slt $t3, $a0, $a1
					beq	$t3, $zero, swap
					addi $t0, $t0, 4
					j loop2
				exit1 :
					addi $t2, $zero, 0
					j loop1
			exit :
				jr $ra
		swap:
			lw  $a2, 0($t0)
			lw  $a3, 4($t0)
			sw $a3, 0($t0)
			sw $a2, 4($t0)
			j loop2
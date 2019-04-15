.data
msg1:.asciiz "Pascal Triangle \nPlease enter the number of levels(1~30): "
msg2 : .asciiz"\n"

.text
.globl main
#------------------------- main -----------------------------
	main :
	li      $v0, 4			#msg1
	la      $a0, msg1		
	syscall                 	

	li      $v0, 5         #read 	
	syscall                 	
	move    $a0, $v0
	addi $t5, $a0, 1

	li      $v0, 4			#msg2
	la      $a0, msg2
	syscall

	addi $t0, $zero, 0
	loop1:
		addi $t1, $zero, 0
		loop2 :
			beq $t1, $zero, set1
			beq $t1, $t0, set1
			j set2

			print:
				li   $v0, 1				#print number
				move $a0,$t3
				syscall

			addi $t1, $t1, 1
			slt $t2, $t0, $t1
			beq $t2, $zero, loop2
		
		li   $v0, 4				#print "\n"
		la   $a0, msg2
		syscall

		addi $t0, $t0, 1
		blt $t0, $t5, loop1
		
		li $v0, 10
		syscall
.text
	set1 :
		addi $t3, $zero, 1
		j print
	set2 :
		sub $t4, $t0, $t1
		addi $t4, $t4, 1
		mult $t3, $t4
		mflo $t3
		div $t3, $t1
		mflo $t3
		j print
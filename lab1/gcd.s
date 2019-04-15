.data
msg1:.asciiz "Enter first integers: "
msg2:.asciiz"Enter second integers: "
msg3:.asciiz"Greatest common divisor:"
msg4:.asciiz"\n"

.text
.globl main
#------------------------- main -----------------------------
main :
	li      $v0, 4	
	la      $a0, msg1
	syscall

	li      $v0, 5         #read
	syscall
	move    $t0, $v0

	li      $v0, 4	
	la      $a0, msg2
	syscall

	li      $v0, 5         #read
	syscall
	move    $t1, $v0

	jal gcd

	li      $v0, 4			
	la      $a0, msg3
	syscall

	li   $v0, 1				#print number
	move $a0, $t0
	syscall

	li $v0, 10
	syscall
.text
	gcd:
		addi $sp, $sp,-4
		sw $ra, 0($sp)       #ra
		slti $t3, $t1, 1 
		beq $t3, $zero, L1
		addi $sp, $sp, 4
		jr $ra
	L1:
		div $t0, $t1
		mfhi $t4
		addi $t0, $t1, 0
		addi $t1, $t4, 0
		jal gcd
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra

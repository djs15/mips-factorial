# MIPS-factorial
# DJS15

.data
prompt:  .asciiz "Enter a number: "
answer: .asciiz "!="
newline: .asciiz "\n"

.text
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $a0, $v0		  #place number in $a0
	addi $s4, $a0, 0

FACT:	
	addi $s0, $a0, 0 	  #stores input to $s0
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $a0, 0($sp)
	slti $t0, $a0, 1 	  #if ($a0<1) $t0=1, else $t0=0
	beq $t0, $0, L1 	  #if ($a0>=1) branch to L1
	addi $v0, $0, 1
	addi $sp, $sp, 8
	jr $ra 			  #jumps to j L2 call in L1

L1:
	addi $a0, $a0, -1
	jal FACT
	j L2

L2:
	lw $a0, 0($sp)	  	#previous values of $a0 were stored in 0($sp)
	addi $sp, $sp, 8
	mul $v0, $a0, $v0
	addi $s5, $v0, 0
	beq $a0, $s4, DONE 	#compares current value of $a0 to $s4
	j L2

DONE:
	li $v0, 1
	la $a0, ($s4)
	syscall
	
	li $v0, 4
	la $a0, answer
	syscall
	
	li $v0, 1
	la $a0, ($s5)
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 10		
	syscall			# exit

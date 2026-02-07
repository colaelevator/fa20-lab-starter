.globl main

.data
source: #int source[] = {3, 1, 4, 1, 5, 9, 0};
    .word   3
    .word   1
    .word   4
    .word   1
    .word   5
    .word   9
    .word   0
dest: #int dest[10];
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0

.text
fun:
    addi t0, a0, 1 # temp_0 = x + 1;
    sub t1, x0, a0 # temp_1 = -x;
    mul a0, t0, t1 # x = temp_0 * temp_1;
    jr ra

main:
    # BEGIN PROLOGUE
    addi sp, sp, -20
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw ra, 16(sp)
    # END PROLOGUE
    addi t0, x0, 0 # temp_0 = 0;
    addi s0, x0, 0 # sum = 0;
    la s1, source # *source
    la s2, dest # *dest
loop:
    slli s3, t0, 2 # s3 == k.bytes
    add t1, s1, s3 # &source[k]
    lw t2, 0(t1) # source[k]
    beq t2, x0, exit
    add a0, x0, t2 # a_0 = temp_2 == source[k]
    addi sp, sp, -8
    sw t0, 0(sp)
    sw t2, 4(sp)
    jal fun
    lw t0, 0(sp)
    lw t2, 4(sp)
    addi sp, sp, 8
    add t2, x0, a0 # temp_2 = a_0 == fun(source[k]);
    add t3, s2, s3 
    sw t2, 0(t3) # dest[k] = temp_2;
    add s0, s0, t2 # sum += temp_2;
    addi t0, t0, 1 # temp_0++;temp_0 == k
    jal x0, loop
exit:
    add a0, x0, s0
    # BEGIN EPILOGUE
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20
    # END EPILOGUE
    jr ra

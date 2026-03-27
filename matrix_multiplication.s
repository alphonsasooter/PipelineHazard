.data
A: .word 1, 2, 3, 4      # 2x2 matrix
B: .word 5, 6, 7, 8
C: .word 0, 0, 0, 0

.text
.globl main
main:
    la x10, A
    la x11, B
    la x12, C

    li x13, 0      # i

outer_i:
    li x14, 0      # j

outer_j:
    li x15, 0      # sum
    li x16, 0      # k

inner_k:
    li x17, 2
    bge x16, x17, store

    # A[i][k]
    mul x18, x13, x17
    add x18, x18, x16
    slli x18, x18, 2
    add x19, x10, x18
    lw x20, 0(x19)

    # B[k][j]
    mul x21, x16, x17
    add x21, x21, x14
    slli x21, x21, 2
    add x22, x11, x21
    lw x23, 0(x22)

    mul x24, x20, x23     # RAW hazard
    add x15, x15, x24

    addi x16, x16, 1
    j inner_k

store:
    mul x18, x13, x17
    add x18, x18, x14
    slli x18, x18, 2
    add x19, x12, x18
    sw x15, 0(x19)

    addi x14, x14, 1
    li x17, 2
    blt x14, x17, outer_j

    addi x13, x13, 1
    li x17, 2
    blt x13, x17, outer_i

end:
    nop

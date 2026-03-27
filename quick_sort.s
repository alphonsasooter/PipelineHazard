.data
array: .word 9, 3, 7, 1, 5
n:     .word 5

.text
.globl main
main:
    la x10, array
    lw x11, n

    li x12, 0              # low
    addi x13, x11, -1      # high

    # pivot = array[high]
    slli x14, x13, 2
    add x15, x10, x14
    lw x16, 0(x15)

    addi x17, x12, -1      # i = low -1
    mv x18, x12            # j = low

loop:
    bge x18, x13, done

    slli x19, x18, 2
    add x20, x10, x19
    lw x21, 0(x20)

    blt x21, x16, swap     # control hazard

    addi x18, x18, 1
    j loop

swap:
    addi x17, x17, 1

    slli x22, x17, 2
    add x23, x10, x22
    lw x24, 0(x23)

    sw x21, 0(x23)
    sw x24, 0(x20)

    addi x18, x18, 1
    j loop

done:
    nop

.data
arr: .word 64, 25, 12, 22, 11
n: .word 5

.text
.globl main

main:
    # Cargar la dirección base del arreglo en $a0
    la $a0, arr

    # Cargar n en $t1
    lw $t1, n

    # Iniciar el bucle externo (i)
    li $t2, 0

bucle_externo:
    # Inicializar minIndex a i
    move $t3, $t2

    # Iniciar el bucle interno (j)
    li $t4, 4   # Tamaño de cada elemento en bytes (un entero)

bucle_interno:
    # Calcular la dirección de arr[j] en $t5
    mul $t5, $t3, $t4
    add $t5, $t5, $a0

    # Cargar arr[j] en $t6
    lw $t6, 0($t5)

    # Calcular la dirección de arr[minIndex] en $t5
    mul $t5, $t2, $t4
    add $t5, $t5, $a0

    # Cargar arr[minIndex] en $t7
    lw $t7, 0($t5)

    # Comparar arr[j] < arr[minIndex]
    blt $t6, $t7, actualizar_minIndex

continuar_bucle_interno:
    # Incrementar j
    addi $t3, $t3, 1

    # Comprobar si hemos llegado al final del arreglo
    bne $t3, $t1, bucle_interno

fin_bucle_interno:
    # Intercambiar arr[i] y arr[minIndex]
    lw $t6, 0($a0)  # Cargar arr[i] en $t6
    sw $t7, 0($a0)  # Almacenar arr[minIndex] en la posición de arr[i]
    sw $t6, 0($t5)  # Almacenar arr[i] en la posición de arr[minIndex]

    # Incrementar i
    addi $t2, $t2, 1

    # Comprobar si hemos llegado al final del arreglo
    bne $t2, $t1, bucle_externo

fin_programa:
    # Salir del programa
    li $v0, 10
    syscall

actualizar_minIndex:
    # Actualizar minIndex a j
    move $t3, $t2
    j continuar_bucle_interno

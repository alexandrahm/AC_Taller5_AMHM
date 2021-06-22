org 100h

    XOR AX, AX
    XOR SI, SI
    XOR BX, BX
    XOR CX, CX
    XOR DX, DX

    MOV SI, 0
    MOV DI, 0d

    MOV DH, 10 ;primera fila donde esta el cursor
    MOV DL, 20 ;primera columna donde esta el cursor

    call ActivarTexto

	;Funcion principal
    FuncionInterar:
        call PosisionCursor ;mover cursor
        MOV CL, [Texto+SI] ;Colocar en CL el caracter actual de la Texto
        
		call EscribiendoCaracteres; Escribir caracter
        INC SI ; SE SUMA 1 A SI 
        INC DL ; SE SUMA 1 A DL
        INC DI ; contador para terminar la ejecuciÃ³n del programa en 10

        CMP DI, 36d ; ComparaciÃ³n de DI con 10d
        JB FuncionInterar ; si DI < 10 = que siga iterando

        jmp IngresarTecla ; else: que salte a esperar tecla

    ActivarTexto: 
        MOV AH, 0h ; activa modo texto
        MOV AL, 03h ;modo grÃ¡fico deseado
        INT 10h
        RET
		
    PosisionCursor:
        MOV AH, 02h ; posiciona el cursor en pantalla.
        MOV BH, 0h

        ;comparacion para  primer nombre
        CMP DI, 10d
        JE IncrementarDH

        ;comparacion para segundo nombre
        CMP DI, 17d
        JE IncrementarDH

        ;comparacion para  primer apellido
        CMP DI, 28d
        JE IncrementarDH

        ;comparacion para segundo apellido
        CMP DI, 28d
        JE IncrementarDH

        INT 10h
        RET
    EscribiendoCaracteres:
        MOV AH, 0Ah ; escribe caracter en pantalla segÃºn donde este el cursor
        MOV AL, CL ; denotamos el caracter a escribir en pantalla
        MOV BH, 0h ; nÃºmero de pÃ¡gina
        MOV CX, 01h ; nÃºmero de veces a escribir el caracter
        INT 10h
        RET

    IncrementarDH:
        INC DH
        INC DH
        MOV DL, 19
        RET

    IngresarTecla:
    ;Se espera que el usuario presione una tecla
        MOV AH, 00h 
        INT 16h
    exit:
        int 20h


   
    Texto DB 'Alexandraa Mariaa Henriquezz Miranda'
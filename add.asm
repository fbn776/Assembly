ASSUME CS:CODE, DS:DATA

DATA SEGMENT
    p1 DB 10,13,"Enter a: $"
    p2 DB 10,13,"Enter b: $"
    m1 DB 10,13,"Sum is: $"
DATA ENDS

PRINT MACRO MSG
    MOV AH, 09
    LEA DX, MSG
    INT 21h
ENDM

; Macro to get a character from input and converts it to decimal and stores in AL
GETDCM MACRO
    MOV AH, 01
    INT 21H
    SUB AL, 30H
ENDM

CODE SEGMENT
    start:
    ; Init Data segment
    MOV AX, DATA
    MOV DS, AX


    PRINT p1
    GETDCM      ; AL = num1
    MOV BL, AL  ; BL = AL

    PRINT p2   
    GETDCM      ; AL = num2
    ADD AL, BL  ; AL = AL(num2) + BL(num1)

    MOV AH, 00H ; Clear AH
    AAA         ; Adjust if num1 + num2 > 9
    MOV BX, AX  ; BX = AX (As AH has to be used for intrs)


    PRINT m1
    
    ; Print higher byte of result
    MOV AH, 02h ; ISR for displaying a character
    MOV DL, BH
    ADD DL, 30H ; Convert to ASCII
    INT 21H
    ; Print lower byte of result
    MOV DL, BL
    ADD DL, 30H ; Convert to ASCII
    INT 21H

    ; HALT
    MOV AH, 4CH
    INT 21H
CODE ENDS

END start
ASSUME CS:CODE, DS:DATA

DATA SEGMENT
    p1 DB 10,13,"Num 1: $"
    p2 DB 10,13,"Num 2: $"
    m1 DB 10,13,"Product is: $"
DATA ENDS

PRINT MACRO MSG
    MOV AH, 09H
    LEA DX, MSG
    INT 21H
ENDM

GETDCM MACRO
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
ENDM

CODE SEGMENT
    start:
    ; Init data segment
    MOV AX, DATA
    MOV DS, AX

    PRINT p1
    GETDCM          ; Get num1
    MOV BL, AL          

    PRINT p2
    GETDCM          ; Get num2

    MOV AH, 00H     ; AH = 00H
    MUL BL          ; AX = AX * BL
    AAM             ; Adjust for mult
    MOV BX, AX      ; BX = AX

    PRINT m1
    
    MOV AH, 02H     ; Set ISR for character printing
    MOV DL, BH
    ADD DL, 30H     ; Convert higher byte to ASCII
    INT 21H         ; Print higher byte

    MOV DL, BL
    ADD DL, 30H     ; Convert lower byte to ASCII
    INT 21H         ; Print lower byte

    ; HALT
    MOV AH, 4CH
    INT 21H
CODE ENDS
END start
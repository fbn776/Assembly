ASSUME CS:CODE, DS:DATA

DATA SEGMENT
    p1 DB 10,13,"Enter a: $"
    p2 DB 10,13,"Enter b: $"
DATA ENDS


PRINT MACRO MSG
    MOV AH, 09
    LEA DX, MSG
    INT 21h
ENDM




CODE SEGMENT
    start:
    MOV AX, DATA
    MOV D


    PRINT p1

    PRINT p2


    MOV AH, 4CH
    INT 21H
CODE ENDS

END start
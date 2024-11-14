ASSUME CS:CODE,DS:DATA

DATA SEGMENT
    MSG1 DB "Hello world$"
    M2 DB 10,13,"Enter a: $"
    M3 DB 10,13,"Enter b: $"
    M4 DB "Sum is: $"
DATA ENDS

PRINT MACRO MSG
    MOV AH, 09
    LEA DX, MSG
    INT 21h
ENDM



CODE SEGMENT
    start:
    ; Initialize DATA Segment
    MOV AX,DATA
    MOV DS,AX

    PRINT MSG1    

    ; STOP
    MOV AH, 4CH
    INT 21h
    
CODE ENDS
END start
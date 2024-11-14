ASSUME CS:CODE, DS:DATA

DATA SEGMENT

DATA ENDS

CODE SEGMENT
    start:
    ; Init the data segment
    MOV AX,DATA
    MOV DS,AX

    ; Code goes here


    ; Halt
    MOVE AH, 4CH
    INT 21H
CODE ENDS
END start
ASSUME CS:CODE, DS:DATA

DATA SEGMENT
    p1 DB 10,13,"Enter num: $"
    m_odd DB 10,13,"Number is ODD$"
    m_even DB 10,13,"Number is EVEN$"
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
        ; Init DATA Segment
        MOV AX, DATA
        MOV DS, AX

        PRINT p1
        GETDCM          ; Get num

        SHR AL, 01H     ; Shift Right by 1. The right most bit gets stored to CF (carry flag)
        
        JC odd          ; If CF = 1, goto odd
        PRINT m_even    ; else print even
        JMP done        ; done

    odd:
        PRINT m_odd
    done:
        MOV AH, 4CH
        INT 21H

CODE ENDS
END start
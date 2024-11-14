ASSUME CS:CODE,DS:DATA
DATA SEGMENT
    ITEMS DB 11H,22H,33H,44H,55H
    M_FOUND DB "Found$"
    M_NOTFOUND DB "Not found$"
    KEY DB 22H
DATA ENDS

PRINT MACRO MSG
    MOV AH,09H
    LEA DX,MSG
    INT 21H
ENDM

CODE SEGMENT
    start: 
        MOV AX,DATA
        MOV DS,AX

        MOV AL,KEY
        LEA SI,ITEMS
        MOV CX,05H

        loop1: 
            MOV BL,[SI]         ; BL = *SI[i]
            CMP AL,BL           ; AL = BL then ZF (zero flag) = 0
            JZ found            ; Jump if ZF = 0
            INC SI              ; SI++
            DEC CX              ; CX--
            JNZ loop1           ; Jump if ZF != 0 (ie CX != 0)

        PRINT M_NOTFOUND
        JMP done

        found:
            PRINT M_FOUND

        done: 
            MOV AH,4CH 
            INT 21H
CODE ENDS
END start

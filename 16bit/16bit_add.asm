ASSUME CS:CODE,DS:DATA
DATA SEGMENT
    p1 DB 10,13,"ENTER FIRST NUMBER:$"
    p2 DB 10,13,"ENTER SECOND NUMBER:$"
    m1 DB 10,13,"SUM:$"
    SUM DB 03           ; Result varible
DATA ENDS

PRINT MACRO MSG
    LEA DX,MSG
    MOV AH,09
    INT 21H
ENDM
 
GETDCM MACRO
    MOV AH,01
    INT 21H
    SUB AL,30H
ENDM

; Print a digit as ASCII
PRTDCM MACRO
    MOV DL,[SI]
    ADD DL,30H          ; Convert to ASCII format
    MOV AH,02
    INT 21H
ENDM
 
CODE SEGMENT
    START : 
        MOV AX,DATA
        MOV DS,AX

        ; Get num1
        PRINT p1
        GETDCM
        MOV BH,AL       ; Higher byte of num1
        GETDCM
        MOV BL,AL       ; Lower byte of num1

        ; Get num2
        PRINT p2
        GETDCM
        MOV CH,AL       ; Higher byte of num2
        GETDCM
        MOV CL,AL       ; Lower byte of num2

        ADD BL,CL       ; BL += CL (lower byte addition)
        MOV AL,BL       ; AL = BL
        MOV AH,00       ; Clear AH
        AAA             ; Adjust for ascii addition

        LEA SI,SUM      ; Get addr of SUM to SI ie SI = &SUM  (sort of like this in C)
        MOV [SI],AL     ; Move AL to location pointed by SI
        
        ADD BH,AH       ; BH = BH + AH (Now AH might have some bits adjusted by AAA
        ADD BH,CH       ; BH = BH + CH
        MOV AL,BH       ; AL = BH
        MOV AH,00       ; Clear AH
        AAA             ; Adjust for ascii addition

        INC SI          ; For storing the higer byte of result, incr SI
        MOV[SI],AL      ; Store the higher byte of result in AL to loc in SI
        INC SI          ; Again incr SI for storing the remaning due to AAA
        MOV [SI],AH     ; Store the remaning to SI

        PRINT m1        
        PRTDCM          ; Print the higher byte
        DEC SI          ; Dec to middle byte
        PRTDCM          ; Print middle byte
        DEC SI          ; Dec to lower byte
        PRTDCM          ; Print lower byte

        ; Halt
        MOV AH,4CH      
        INT 21H
CODE ENDS
END START

ASSUME CS:CODE,DS:DATA
DATA SEGMENT
    p1 DB 10,13,"Enter num1: $"
    p2 DB 10,13,"Enter num2: $"
    m1 DB 10,13,"Product: $"
    PROD DB 3 DUP(00H)          ; Declares a varible PROD of size 3 bytes with initial value 000000H [DUP(00H)]
DATA ENDS

PRINT MACRO MESSAGE
    LEA DX,MESSAGE
    MOV AH,09
    INT 21H
ENDM

GETDCM MACRO
    MOV AH,01
    INT 21H
    SUB AL,30H
ENDM

PRTDCM MACRO
    MOV DL,[SI]
    ADD DL,30H
    MOV AH,02
    INT 21H
ENDM
    
CODE SEGMENT
    START:
        MOV AX,DATA
        MOV DS,AX

        PRINT p1
        ; Get num1 (BH:BL)
        GETDCM
        MOV BH,AL
        GETDCM
        MOV BL,AL

        PRINT p2
        ; Get num2 (CH:CL)
        GETDCM
        MOV CH,AL
        GETDCM
        MOV CL,AL

        LEA SI,PROD         ; Load effective addr of PROD to SI
        MOV AH,00H          ; Clear AH
        MUL BL              ; AX = AX(00:CL) * BL
        AAM                 ; Adjust

        MOV [SI],AL         ; Prod lowest byte
        INC SI              ; SI++
        MOV [SI],AH         ; Prod's new byte     <---+    
                            ;                         |
        MOV AH,00H          ; Clear AH                |
        MOV AL,BH           ; AL = BH                 |
        MUL CL              ; AX = AX(00:BH) * CL     |
        AAM                 ; Adjust                  |
        MOV DX,AX           ; DX = AX                 |
        ADD DL,[SI]         ; DL = DL + (*SI) = DL + AH
        MOV AH,00H          ; 
        MOV AL,CH           ; AL = CH
        MUL BL              ; AX = AX(00:CH) * BL
        AAM                 ; Adjust
        ADD DX,AX           ; DX = DX + AX
        MOV AL,DL           ; AL = DL
        MOV AH,00H          ;
        AAM                 ; Adjust
        ADD DH,AH           ; DH = DH + AH
        MOV DL,DH           ; DL = AL
        MOV DH,00H          ; Clear DH
        MOV [SI],AL         ; Last byte at SI = AL
        INC SI              ; SI++
        MOV AH,00H          ; Clear AH
        MOV AL,BH           ; AL = BH
        MUL CH              ; AX = AX(00:BH) * CH
        AAM                 ; Adjust
        ADD DX,AX           ; DX = DX + AX
        MOV AL,DL           ; AL = DL
        MOV AH,00H          ; AH = 00
        AAM                 ; Adjust
        MOV [SI],AL         ; Next byte at SI = AL
        INC SI              ; SI++
        ADD DH,AH           ; DH = DH + AH
        MOV AL,DH           ; AL = DH
        MOV [SI],AL         ; Next byte at SI = AL

        ; Print result
        PRINT m1
        PRTDCM
        DEC SI
        PRTDCM
        DEC SI
        PRTDCM
        DEC SI
        PRTDCM

        ; Halt
        MOV AH,4CH
        INT 21H
CODE ENDS
END START
ASSUME CS:CODE,DS:DATA,ES:EXTRA
DATA SEGMENT
    M1 DB 10,13,"ENTER STRING(DELIMITER: '):$"
    M2 DB 10,13,"NUMBER OF VOWELS:$"
    M3 DB 10,13,"NUMBER OF DIGITS:$"
    M4 DB 10,13,"NUMBER OF CONSONANTS:$"
    IN_STR DB "HELLO123"
    MAXLEN DB 0AH
    DELIM DB "'"
    VCNT DB 00H
    DGCNT DB 00H
    CNCNT DB 00H
DATA ENDS

EXTRA SEGMENT
    VWSTR DB "aeiouAEIOU"
    DGSTR DB "0123456789"
EXTRA ENDS

PRTMSG MACRO MESSAGE
    LEA DX,MESSAGE
    MOV AH,09
    INT 21H
    ENDM
PRTCNT MACRO COUNT
    MOV DL,COUNT
    ADD DL,30H
    MOV AH,02
    INT 21H
ENDM
	
CODE SEGMENT
    START:
    ; Init data seg
    MOV AX,DATA
    MOV DS,AX
    ; Init extra seg
    MOV AX,EXTRA
    MOV ES,AX

    LEA SI,IN_STR
    PRTMSG M1
    MOV BX,00           ; BX = 0
    MOV CH,00H          ; CH = 0
    MOV CL,MAXLEN       ; CL = MAXLEN

    MOV AH,01           ; Set ISR for getting a character
    GETC:
        INT 21H
        CMP AL,DELIM    ; Check if read character is delim, if yes exit
        JE ENDGET       ; Jump if equal
        INC BL          ; BL++(BL = 0 initially)    
        MOV [SI],AL     ; Move read character to SI[i]
        INC SI          ; SI's i++
        LOOP GETC       ; Decrements CX by 1 each time and loops if CX != 0

    ENDGET:
        CLD             ; Set directional flag to 0 (so string processing happens from left to right)
        LEA SI,IN_STR   
    CHKA:
        MOV AX,[SI]     ; AX = SI[i]
        INC SI          ; i++
        MOV CL,0AH      ; CL = 10
        LEA DI,VWSTR    ; DI = effective address of VWSTR
        REPNZ SCASB     ;
        JNE CHKD
        INC VCNT
        JMP ENDC
    CHKD:
        MOV CL,0AH
        LEA DI,DGSTR
        REPNZ SCASB
        JNE CHKC
        INC DGCNT
        JMP ENDC
    CHKC:
        INC CNCNT
    ENDC:
        MOV CL,BL
    DEC BX
    LOOP CHKA
    
    PRTMSG M2
    PRTCNT VCNT
    PRTMSG M3
    PRTCNT DGCNT
    PRTMSG M4
    PRTCNT CNCNT
    
    MOV AH,4CH
    INT 21H
CODE ENDS
END START

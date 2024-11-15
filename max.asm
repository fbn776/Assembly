CLC
MOV BX, 0700
MOV SI, 0800
MOV CX, 0005
MOV AL, 00H
cmp1:
    CMP AL, [SI]
    JA loop1
    MOV CH, 00H
    loop1:
        INC SI
    LOOPNZ cmp1

MOV [BX], AL
HLT


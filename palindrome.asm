ASSUME CS:CODE, DS:DATA

DATA SEGMENT                 
    msgPrompt DB 'Enter a string: $', 0  ; Prompt message
    msgResult DB 'The string is a palindrome.$', 0
    msgNotPalindrome DB 'The string is not a palindrome.$', 0
    inputString DB 50, ?, 50 DUP(?)    ; Reserve space for input string (50 characters)
DATA ENDS

CODE SEGMENT
    start:
        MOV AX, DATA
        MOV DS, AX

        ; Display prompt message
        MOV AH, 09h         ; DOS interrupt to display string
        LEA DX, msgPrompt
        INT 21h

        ; Read input string
        MOV AH, 0Ah         ; DOS interrupt to read string (buffered input)
        LEA DX, inputString
        INT 21h
        
        ; Now the buffer inputString is of the form <B1><B2><Remaining bytes>
        ; - B1 has the max size
        ; - B2 has the length ie (SI + 1)
        
        ; Find length of string (input starts at byte 2 in buffer)
        LEA SI, inputString
        MOV AL, [SI+1]      ; Load the length of the string (first byte in buffer)
        DEC AL              ; Decrease to get the index of the last character (length - 1)
        MOV CL, AL          ; Store the length - 1 in CL (for index calculation)

        ; Set up pointers for comparing characters (start and end)
        LEA SI, inputString+2  ; SI points to the first character of the string
        ADD SI, CX              ; SI points to the last character
        LEA DI, inputString+2   ; DI points to the first character

    checkPalindrome:
        MOV AL, [SI]          ; Load character from end
        MOV BL, [DI]          ; Load character from start
        CMP AL, BL            ; Compare the two characters
        JNE notPalindrome     ; If they don't match, it's not a palindrome

        ; Move the pointers
        DEC SI                ; Move SI backwards
        INC DI                ; Move DI forwards
        LOOP checkPalindrome  ; Continue loop until SI and DI meet

        ; If loop completes, it's a palindrome
        MOV AH, 09h           ; DOS interrupt to display result
        MOV DX, OFFSET msgResult
        INT 21h
        JMP done

    notPalindrome:
        MOV AH, 09h           ; DOS interrupt to display result
        MOV DX, OFFSET msgNotPalindrome
        INT 21h

    done:
        ; Exit program
        MOV AH, 4Ch           ; DOS interrupt to terminate program
        INT 21h
CODE ENDS
END start
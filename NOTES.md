# NOTES

## Basic Template

The basic template for a 16bit 8086 MASM program is; See [template.asm](template.asm)
```asm
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
```


## Interrupts

Interrupts for DOS 8086 are made by calling `INT <num>`

Calling `INT 21h` is a special DOS interrupt used to provide various DOS services in MS-DOS or PC-DOS.

The 21h interrupt is the primary interface for interacting with the system and performing tasks like reading and writing files, managing memory, displaying output, and more. (Sort of like system calls in modern OS)


Which functionality to execute is determined by value in `AH` register.
It determines which service (function) is being requested. The function number (i.e., the specific service) is placed in the AH register.

Other registers may be used to pass parameters for the function, and the function will place its result in AL, AX, BX, or other registers depending on the specific function.

### Common Functionalities

| **Function (AH)** | **Description**                                         | **Parameters**                                                        | **Return Value**                                           |
|-------------------|---------------------------------------------------------|----------------------------------------------------------------------|------------------------------------------------------------|
| **01h**           | **Read a Character from Standard Input**               | None                                                                 | The ASCII value of the key pressed in **AL**.              |
| **02h**           | **Display a Character**                                | **DL** = character to display                                        | None                                                       |
| **09h**           | **Display a String**                                   | **DX** = Address of the string (terminated with `$`)                  | None                                                       |
| **0Ah**           | **Read a Buffered String**                             | **DX** = Address of input buffer (first byte = max buffer size)      | Input string in buffer; **AL** = number of characters read |
| **10h**           | **Display String (without `$` terminator)**             | **DX** = Address of the string (no `$` required)                     | None                                                       |
| **4Ch**           | **Exit Program**                                       | **AL** = Exit code (optional, default = 0)                           | None                                                       |
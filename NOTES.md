# NOTES

## Registers in 8086

1. General-Purpose Registers
    These are 16-bit registers that can be used for arithmetic, logic, and data manipulation. They can also be accessed as 8-bit registers (lower and higher bytes).

    - AX (Accumulator Register)
        - AH (High byte of AX)
        - AL (Low byte of AX)
    - BX (Base Register)
        - BH (High byte of BX)
        - BL (Low byte of BX)
    - CX (Count Register) 
        - CH (High byte of CX)
        - CL (Low byte of CX)
    - DX (Data Register)
        - DH (High byte of DX)
        - DL (Low byte of DX)
    - SI (Source Index Register): Used in string operations and memory addressing.
    - DI (Destination Index Register): Used in string operations and memory addressing.
    - BP (Base Pointer Register): Typically used for stack operations and accessing local variables.
    - SP (Stack Pointer Register): Points to the top of the stack.

2. Segment Registers
    These are used to hold the addresses of memory segments.
    - CS (Code Segment): Holds the base address of the code segment (where instructions are fetched from).
    - DS (Data Segment): Holds the base address of the data segment (where data is stored).
    - SS (Stack Segment): Holds the base address of the stack segment (used for stack operations).
    - ES (Extra Segment): Used as an additional data segment for string operations and other purposes.

3. Pointer and Index Registers
    These are used for memory addressing in conjunction with segment registers.
    - IP (Instruction Pointer): Holds the offset address of the next instruction to be executed (relative to the CS register).
    - SP (Stack Pointer): Points to the top of the stack.
    - BP (Base Pointer): Points to the base of the stack frame in stack operations.
    - SI (Source Index): Used in string operations to point to the source operand.
    - DI (Destination Index): Used in string operations to point to the destination operand.

4. Flag Register (Status Register)
    The flag register holds several individual bits that control the operation of the CPU and indicate certain conditions (e.g., zero, carry, overflow, etc.).
    - Carry Flag (CF): Set if there is a carry from an arithmetic operation.
    - Parity Flag (PF): Set if the number of set bits in the result is even.
    - Auxiliary Carry Flag (AF): Set if there is a carry from bit 3 to bit 4 in a binary-coded decimal (BCD) operation.
    - Zero Flag (ZF): Set if the result of an operation is zero.
    - Sign Flag (SF): Set if the result is negative.
    - Trap Flag (TF): Used for single-step debugging.
    - Interrupt Flag (IF): Enables or disables interrupts.
    - Direction Flag (DF): Controls the direction of string operations (increment or decrement).
    - Overflow Flag (OF): Set if there is an overflow in signed arithmetic operations.

5. Special Purpose Registers
    These registers are typically used for specific functions:
    - IP (Instruction Pointer): Holds the offset of the next instruction to execute, relative to the CS register.
    - Flags Register: Contains the status flags that indicate the outcome of operations.




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


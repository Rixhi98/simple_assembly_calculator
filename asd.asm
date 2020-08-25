%include "io.inc"
NULL          EQU 0                             
MB_DEFBUTTON1 EQU 0
MB_DEFBUTTON2 EQU 100h
IDNO          EQU 7
MB_YESNO      EQU 4

extern _MessageBoxA@16                          
extern _ExitProcess@4  
    global  _main
    extern  scanf
    extern  printf

    

    section .text
_main:
  

    push   first
    call    _printf
    add     esp, 4
    
    push num1
    push input_int
    call scanf
    add     esp, 8
    
    push   second
    call    _printf
    add     esp, 4
    
    push num2
    push input_int
    call scanf
    add     esp, 8
  get_operation:  
    push   operation
    call    _printf
    add     esp, 4
    
    push char1
    push input_char
    call scanf
    add     esp, 8
    
    mov edx,[char1]
    cmp edx, '+'
    je addition
    cmp edx, '-'
    je substract
    cmp edx, 'X'
    je multiply
    cmp edx, ':'
    je divide
    jmp oper_err
    ret
    
  finish:   
 push  MB_YESNO | MB_DEFBUTTON2                 
 push  msgtitle                        
 push  msgText                           
 push  NULL                                     
 call  _MessageBoxA@16
 
 cmp   EAX, IDNO                                
 je    exit
 jmp   _main
    
ret
    exit:
   ret 
 
   oper_err:
    push   err_msg
    call    _printf
    add     esp, 4
    jmp get_operation
   
    addition:
    
    mov eax,[num1]
    mov ebx,[num2]
    add eax,ebx
    
    push eax
    push   output
    call    _printf
    add     esp, 4
    jmp finish
    ret
    substract:
    
    mov eax,[num1]
    mov ebx,[num2]
    sub eax,ebx
    
    push eax
    push   output
    call    _printf
    add     esp, 4
    jmp finish
    ret
    multiply:
    
    mov eax,[num1]
    mov ebx,[num2]
    mul ebx
    
    push eax
    push   output
    call    _printf
    add     esp, 4
    jmp finish
    ret
    divide:
    
    mov eax,[num1]
    mov ebx,[num2]
    div ebx
    
    push eax
    push   output
    call    _printf
    add     esp, 4
    jmp finish
    ret
    

    
    
    section .data
first: db  'Input first number', 10, 0
second: db  'Input second number', 10, 0
operation:db  'Input operation type(+,-,X,:)', 10, 0
err_msg:db  'Bad Input', 10, 0
res: db 'result',10,0
    input_int: db "%d", 0
    input_char: db "%s", 0
    output: db "%d", 10, 0 ; newline, nul terminator
    
 msgText    db "Do you want to retry", 0
 msgtitle db "retry", 0
    
    section .bss

    num1 resb 8
    num2 resb 8
    char1 resb 8
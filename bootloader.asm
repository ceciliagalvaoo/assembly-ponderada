BITS 16
ORG 0x7C00

start:
    call cls

    ; --- Parte 1: Nome ---
    mov si, msg_nome
    call print_string

    mov di, nome_buffer
    call read_input

    mov si, msg_boasvindas1
    call print_string

    mov si, nome_buffer
    call print_string

    call newline

    ; --- Parte 2: Cidade ---
    mov si, msg_cidade
    call print_string

    mov di, cidade_buffer
    call read_input

    mov si, msg_boasvindas2
    call print_string

    mov si, nome_buffer
    call print_string

    mov si, msg_intermediaria
    call print_string

    mov si, cidade_buffer
    call print_string

hang:
    jmp hang

; -----------------------
; Funções auxiliares
; -----------------------

print_string:
    lodsb
    cmp al, 0
    je .done
    call print_char
    jmp print_string
.done:
    ret

print_char:
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, 0x07
    int 0x10
    ret

read_input:
    xor cx, cx
.read:
    mov ah, 0x00
    int 0x16
    cmp al, 13
    je .done
    stosb
    inc cx
    cmp cx, 50
    jae .done
    call print_char
    jmp .read
.done:
    mov al, 0
    stosb
    call newline
    ret

newline:
    mov al, 0x0D
    call print_char
    mov al, 0x0A
    call print_char
    ret

cls:
    mov ax, 0x0600
    mov bh, 0x07
    mov cx, 0x0000
    mov dx, 0x184F
    int 0x10
    mov ah, 0x02
    mov bh, 0x00
    mov dx, 0x0000
    int 0x10
    ret

; -----------------------
; Dados
; -----------------------

msg_nome         db 'Digite seu nome: ', 0
msg_boasvindas1  db 0x0D, 0x0A, 'Bem vindo(a), ', 0
msg_cidade       db 0x0D, 0x0A, 'Digite sua cidade: ', 0
msg_boasvindas2  db 0x0D, 0x0A, 'Bem vindo(a) ', 0
msg_intermediaria db ', da cidade de ', 0

nome_buffer      times 50 db 0
cidade_buffer    times 50 db 0

; -----------------------
; Finalização
; -----------------------

times 510 - ($ - $$) db 0
dw 0xAA55

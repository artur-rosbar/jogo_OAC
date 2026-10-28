Fui brincando aqui e por enquanto é isso que tenho:

```
CALL DesenhaBorda
LOADN R0, #'@'
LOADN R1, #621
STORE 4999, R0
STORE 5000, R1
OUTCHAR R0, R1


LoopJogo:
    INCHAR R7
    LOADN R6, #'w'
    CMP R7, R6
    CEQ MoveCobraCima
    LOADN R6, #'a'
    CMP R7, R6
    CEQ MoveCobraEsq
    LOADN R6, #'s'
    CMP R7, R6
    CEQ MoveCobraBaixo
    LOADN R6, #'d'
    CMP R7, R6
    CEQ MoveCobraDir
    JMP LoopJogo

Fim: HALT

MoveCobraCima:
    PUSH R0
    PUSH R1
    PUSH R2
    CALL ConferirColisaoCima
    LOAD R0, 4999
    LOADN R2, #40
    LOAD R1, 5000
    SUB R1, R1, R2
    OUTCHAR R0, R1
    STORE 5000, R1
    LOADN R0, #' '
    ADD R1, R1, R2
    OUTCHAR R0, R1
    POP R2
    POP R1
    POP R0
    RTS
    
MoveCobraBaixo:
    PUSH R0
    PUSH R1
    PUSH R2
    LOADN R0, #'s'
    CALL ConferirColisaoBaixo
    LOAD R0, 4999
    LOADN R2, #40
    LOAD R1, 5000
    ADD R1, R1, R2
    OUTCHAR R0, R1
    STORE 5000, R1
    LOADN R0, #' '
    SUB R1, R1, R2
    OUTCHAR R0, R1
    POP R2
    POP R1
    POP R0
    RTS
    
MoveCobraDir:
    PUSH R0
    PUSH R1
    LOADN R0, #'d'
    CALL ConferirColisaoDir
    LOAD R0, 4999
    LOAD R1, 5000
    INC R1
    OUTCHAR R0, R1
    STORE 5000, R1
    LOADN R0, #' '
    DEC R1
    OUTCHAR R0, R1
    POP R1
    POP R0
    RTS
    
MoveCobraEsq:
    PUSH R0
    PUSH R1
    LOADN R0, #'a'
    CALL ConferirColisaoEsq
    LOAD R0, 4999
    LOAD R1, 5000
    DEC R1
    OUTCHAR R0, R1
    STORE 5000, R1
    LOADN R0, #' '
    INC R1
    OUTCHAR R0, R1
    POP R1
    POP R0
    RTS
    
DesenhaBorda:
    PUSH R0
    PUSH R1
    PUSH R2
    PUSH R3
    LOADN R0, #'X'
    LOADN R1, #0
    LOADN R2, #1160
    LOADN R3, #40
    CALL DesenhaVertical
    LOADN R2, #39
    CALL DesenhaHorizontal
    LOADN R1, #39
    LOADN R2, #1199
    CALL DesenhaVertical
    LOADN R1, #1160
    LOADN R2, #1199
    CALL DesenhaHorizontal
    POP R3
    POP R2
    POP R1
    POP R0
    RTS
    
DesenhaVertical:
    PUSH R0
    PUSH R1
    PUSH R2
    PUSH R3
    ComecoDesenhaVertical: OUTCHAR R0, R1
    ADD R1, R1, R3
    CMP R1, R2
    JEL ComecoDesenhaVertical
    POP R3
    POP R2
    POP R1
    POP R0
    RTS
    
DesenhaHorizontal:
    PUSH R0
    PUSH R1
    PUSH R2
    ComecoDesenhaHorizontal: OUTCHAR R0, R1
    INC R1
    CMP R1, R2
    JEL ComecoDesenhaHorizontal
    POP R2
    POP R1
    POP R0
    RTS

ConferirColisaoCima:
    PUSH R0
    PUSH R1
    LOAD R0, 5000
    LOADN R1, #40
    SUB R0, R0, R1
    CMP R0, R1
    LOADN R0, #'w'
    CLE GameOver
    POP R1
    POP R0
    RTS

ConferirColisaoEsq:
    PUSH R0
    PUSH R1
    LOAD R0, 5000
    LOADN R1, #1
    SUB R0, R0, R1
    LOADN R1, #40
    MOD R0, R0, R1
    LOADN R1, #0
    CMP R0, R1
    LOADN R0, #'a'
    CEQ GameOver
    POP R1
    POP R0
    RTS

ConferirColisaoDir:
    PUSH R0
    PUSH R1
    LOAD R0, 5000
    LOADN R1, #1
    ADD R0, R0, R1
    LOADN R1, #40
    MOD R0, R0, R1
    LOADN R1, #39
    CMP R0, R1
    LOADN R0, #'d'
    CEQ GameOver
    POP R1
    POP R0
    RTS

ConferirColisaoBaixo:
    PUSH R0
    PUSH R1
    LOAD R0, 5000
    LOADN R1, #40
    ADD R0, R0, R1
    LOADN R1, #1160
    CMP R0, R1
    LOADN R0, #'s'
    CGR GameOver
    POP R1
    POP R0
    RTS

GameOver:
    PUSH R0
    PUSH R1
    PUSH R2
    JMP CondicoesGameOver
    
    CimaGameOver:
        LOAD R1, 5000
        LOADN R0, #40
        SUB R1, R1, R0
        LOADN R0, #'X'
        LOADN R2, #2304
        ADD R0, R0, R2
        OUTCHAR R0, R1
        JMP SaidaGameOver
    BaixoGameOver:
        LOAD R1, 5000
        LOADN R0, #40
        ADD R1, R1, R0
        LOADN R0, #'X'
        LOADN R2, #2304
        ADD R0, R0, R2
        OUTCHAR R0, R1
        JMP SaidaGameOver
    EsqGameOver:
        LOAD R1, 5000
        LOADN R0, #1
        SUB R1, R1, R0
        LOADN R0, #'X'
        LOADN R2, #2304
        ADD R0, R0, R2
        OUTCHAR R0, R1
        JMP SaidaGameOver
    DirGameOver:
        LOAD R1, 5000
        LOADN R0, #1
        ADD R1, R1, R0
        LOADN R0, #'X'
        LOADN R2, #2304
        ADD R0, R0, R2
        OUTCHAR R0, R1
        JMP SaidaGameOver
        
    CondicoesGameOver:
    
        LOADN R1, #'w'
        CMP R0, R1
        JEQ CimaGameOver
        
        LOADN R1, #'a'
        CMP R0, R1
        JEQ EsqGameOver
        
        LOADN R1, #'s'
        CMP R0, R1
        JEQ BaixoGameOver
        
        LOADN R1, #'d'
        CMP R0, R1
        JEQ DirGameOver
    
    SaidaGameOver:
    POP R2
    POP R1
    POP R0
    JMP Fim
    RTS
```
Existe colisão e quando eu colido além do jogo encerrar o 'X' da borda que eu bati muda de cor para vermelho. E agora, qual o próximo passo?

CALL DesenhaBorda
LOADN R0, #'!'
LOADN R1, #621
STORE 4999, R0
STORE 5000, R1 ; 5000 GUARDA A POSICAO ATUAL DA CABECA
OUTCHAR R0, R1
LOADN R1, #frase
LOADI R0, R1
LOADN R1, #247
LOADN R2, #512
ADD R0, R0, R2
OUTCHAR R0, R1
STORE 5001, R1
LOADN R0, #0
STORE 5002, R0 ; 5002 GUARDA A PONTUACAO
LOADN R5, #0
LOADN R2, #255

LoopJogo:
    INCHAR R1
    CMP R1, R2
    JEQ Pulo
    STORE 5050, R1
    LOAD R7, 5050
    Pulo:
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
    LOADN R6, #1118
    MOD R5, R5, R6
    INC R5
    CALL Delay
    JMP LoopJogo
Fim:
HALT
MoveCobraCima:
    PUSH R0
    PUSH R1
    PUSH R2
    LOADN R0, #'w'
    CALL ConferirColisao
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
    CALL ConferirColisao
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
    CALL ConferirColisao
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
    CALL ConferirColisao
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

ConferirColisao:
    PUSH R0
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R4
    PUSH R6
    PUSH R6
    PUSH R7
	
	LOADN R1, #'w'
	LOADN R2, #'a'
	LOADN R3, #'s'
	LOADN R4, #'d'
	
	CMP R0, R1
	JEQ ColisaoCima
	CMP R0, R2
	JEQ ColisaoEsq
	CMP R0, R3
	JEQ ColisaoBaixo
	CMP R0, R4
	JEQ ColisaoDir
	
	ColisaoCima:
	    LOAD R1, 5000
  	  	LOADN R2, #40
    	SUB R1, R1, R2
    	CMP R1, R2
   		LOADN R0, #'w'
    	CLE GameOver
    	LOAD R1, 5000
    	LOAD R2, 5001
    	LOADN R3, #40
    	SUB R1, R1, R3
    	CMP R1, R2
    	CEQ Pontuacao
    	JMP FinalColisoes
	
	ColisaoEsq:
		LOAD R1, 5000
    	LOADN R2, #1
    	SUB R1, R1, R2
    	LOADN R2, #40
    	MOD R1, R1, R2
    	LOADN R2, #0
    	CMP R1, R2
    	LOADN R1, #'a'
    	CEQ GameOver
    	LOAD R1, 5000
    	LOAD R2, 5001
    	DEC R1
    	CMP R1, R2
    	CEQ Pontuacao
    	JMP FinalColisoes
	
	ColisaoBaixo:
		LOAD R1, 5000
		LOADN R2, #40
		ADD R1, R1, R2
		LOADN R2, #1160
		CMP R1, R2
		LOADN R1, #'s'
		CGR GameOver
		LOAD R1, 5000
		LOAD R2, 5001
		LOADN R3, #40
		ADD R1, R1, R3
		CMP R1, R2
		CEQ Pontuacao
    	JMP FinalColisoes
	
	ColisaoDir:
		LOAD R1, 5000
		LOADN R2, #1
		ADD R1, R1, R2
		LOADN R2, #40
		MOD R1, R1, R2
		LOADN R2, #39
		CMP R1, R2
		LOADN R1, #'d'
		CEQ GameOver
		LOAD R1, 5000
		LOAD R2, 5001
		INC R1
		CMP R1, R2
		CEQ Pontuacao
    	JMP FinalColisoes
	
FinalColisoes:
    POP R7
    POP R6
    POP R5
    POP R4
    POP R3
    POP R2
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
Pontuacao:
    PUSH R0
    PUSH R1
    LOAD R0, 5002
    LOADN R1, #frase
    INC R0
    STORE 5002, R0
    CALL SpawnAleatorioLetra
    ;CALL Rabo
    POP R1
    POP R0
    RTS
SpawnAleatorioLetra:
    PUSH R0
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R5
    LOADN R0, #frase
    LOAD R1, 5002
    ADD R0, R0, R1
    STORE 5002, R1
    LOADI R1, R0
    LOADN R2, #512
    ADD R0, R1, R2
    LOAD R1, 5001
Aleatoriedade:LOADN R2, #1159
    ADD R1, R1, R5
    MOD R1, R1, R2
    LOADN R2, #40
    CMP R1, R2
    JLE Aleatoriedade
    LOADN R2, #40
    MOD R3, R1, R2
    LOADN R2, #0
    CMP R2, R3
    JEQ Aleatoriedade
    LOADN R2, #40
    MOD R3, R1, R2
    LOADN R2, #39
    CMP R2, R3
    JEQ Aleatoriedade
    OUTCHAR R0, R1
    STORE 5001, R1
    POP R5
    POP R3
    POP R2
    POP R1
    POP R0
    RTS
Delay:
	PUSH R7
    PUSH R6
    PUSH R5
    PUSH R4
    LOAD R5, 5002
    LOADN R4, #30
    SUB R4, R4, R5
    LOADN R5, #60000
    LOADN R7, #0
    LoopExternoDelay: LOADN R6, #0
    LoopInternoDelay:INC R6
    CMP R6, R5
    JNE LoopInternoDelay
    INC R7
    CMP R7, R4
    JNE LoopExternoDelay
    POP R4
    POP R5
    POP R6
    POP R7	
    RTS
    
Rabo:
	PUSH R7
    PUSH R6
    PUSH R5
    PUSH R4
    LOAD R4, 5002
    LOADN R5, #frase
    ADD R5, R5, R4
    STOREI R4, R5
    LOAD 5000, R5
    OUTCHAR R4, R5
    POP R4
    POP R5
    POP R6
    POP R7
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
    
    
    
    
    
    
    
    
    
frase: string "CHUPA_FEDERAL_AQUI_E_CAASO"

*******************************************************************
/*
   FILE NAME : REDE.PRG
   BY        : HELIO-SP
   DESC      : FUNCOES DE REDE (TRAVAMENTO E LIBERACAO DE ARQUIVOS)
*/
*******************************************************************
#include "box.ch"
#include "migracao.ch"

**************************************************************************
FUNCTION VERIOUT(M_COR,M_LIN,M_ARQ) // Verifica se arquivo pode ser aberto
**************************************************************************
IF M_COR = NIL
   M_COR = C_CORG
ENDIF
IF M_LIN = NIL
   M_LIN = 23
ENDIF
M_CORA = SETCOLOR()
SETCOLOR(C_CORG)
LI=SAVESCREEN(M_LIN,00,M_LIN+1,79)
@ M_LIN,1 CLEAR TO M_LIN,78
M_RETU = .T.
@ M_LIn,23 say "Abrindo arquivo... "+Trim(m_arq)
WHILE .T.
  USE &M_ARQ SHARED
  IF NETERR()
     M_RETU = .F.
     @ M_LIn,23 say "Tentando abrir arquivo... Por favor aguarde."
  ELSE
     M_RETU = .T.
     @ M_LIN,23 say "Abrindo arquivo... Por favor aguarde "+trim(m_arq)
     EXIT
  ENDIF
ENDDO
RESTSCREEN(M_LIN,00,M_LIN+1,79,LI)
SETCOLOR(M_CORA)
RETURN(M_RETU)

**************************************************************************
FUNCTION EXCLOUT(M_COR,M_LIN,M_ARQ) // Verifica se arquivo pode ser aberto
**************************************************************************
IF M_COR = NIL
   M_COR = C_CORG
ENDIF
IF M_LIN = NIL
   M_LIN = 21
ENDIF
M_CORA = SETCOLOR()
SETCOLOR("W+/R+")
LI=SAVESCREEN(M_LIN,00,M_LIN+1,79)
@ M_LIN,1 CLEAR TO M_LIN,78
M_RETU = .T.
WHILE .T.
  USE &M_ARQ EXCLUSIVE
  IF NETERR()
     M_RETU = .F.
     Alert("Arquivo N„o Dispon¡vel... Outro Usu rio Est  Acessando..."+m_arq)
     Close all
     Clear
     Quit
  ELSE
     M_RETU = .T.
     @ M_LIN,13 say "Abrindo arquivo... Por favor aguarde."
     EXIT
  ENDIF
ENDDO
RESTSCREEN(M_LIN,00,M_LIN+1,79,LI)
SETCOLOR(M_CORA)
RETURN(M_RETU)

FUNCTION BLOQREG(VEZES)
************************
LOCAL SEMPRE,VTELA,VCORA
IF RLOCK()
   RETURN (.T.)
ENDIF
VCORA = SETCOLOR()
VTELA = SAVESCREEN(0,0,24,79)
SETCOLOR("W+/R")
@ 10,21 clear to 12,69
@ 10,21 TO 12,69 DOUBLE
@ 11,22 SAY "Aguarde... Tentando acesso ao arquivo: "+Alltrim(alias())
SETCOLOR(VCORA)
SEMPRE:=(VEZES = 0)
WHILE (SEMPRE .OR. VEZES > 0) .AND. INKEY() <> 27
  IF RLOCK()
     RESTSCREEN(0,0,24,79,VTELA)
     RETURN (.T.)
  ENDIF
  INKEY(0.5)
  VEZES --
ENDDO
RESTSCREEN(0,0,24,79,VTELA)
RETURN (.F.)

FUNCTION ADIREG(VEZES)
**********************
LOCAL SEMPRE,VTELA,VCORA
VCORA = SETCOLOR()
 APPEND BLANK
 IF !NETERR()
    RETURN (.T.)
 ENDIF
VTELA = SAVESCREEN(0,0,24,79)
SETCOLOR("W+/R")
@ 10,21 TO 12,59 DOUBLE
@ 11,22 SAY "Aguarde... Tentando acesso ao arquivo"
SETCOLOR(VCORA)
SEMPRE:=(VEZES = 0)
WHILE (SEMPRE .OR. VEZES > 0) .AND. INKEY() <> 27
  APPEND BLANK
  IF !NETERR()
     RESTSCREEN(0,0,24,79,VTELA)
     RETURN (.T.)
  ENDIF
  INKEY(0.5)
  VEZES --
ENDDO
RESTSCREEN(0,0,24,79,VTELA)
RETURN (.F.)

FUNCTION BLOQARQ()
***********************
LOCAL SEMPRE,VTELA,VCORA
VCORA = SETCOLOR()
IF FLOCK()
   RETURN (.T.)
ENDIF
VTELA:=SAVESCREEN(10,21,12,59)
SETCOLOR("W+/R")
@ 10,21 TO 12,59 DOUBLE
@ 11,22 SAY "Arquivo Ocupado, Tentando Acesso....."
SETCOLOR(VCORA)
WHILE INKEY() <> 27
  IF FLOCK()
     RESTSCREEN(10,21,12,59,VTELA)
     RETURN (.T.)
  ENDIF
ENDDO
RESTSCREEN(10,21,12,59,VTELA)
RETURN (.F.)

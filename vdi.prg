#include "box.ch"
#include "migracao.ch"

Procedure Vdi()

WHILE .T.
SETCOLOR(C_CORG)
SOMBRA(15,31,18,48,BOX)
@ 16,32 prom "V¡deo"
@ 17,32 prom "Impressora/V¡deo"
menu to relax1
SET COLOR TO
  MENURL1 = SAVESCREEN(0,0,24,79)
  DO CASE
     CASE RELAX1 = 0
          SETCOLOR(C_CORN)
          RETURN
     CASE RELAX1 = 1
          RELAX=1
          RETURN
     CASE RELAX1 = 2
          RELAX=2
          RETURN
     OTHE
          SETCOLOR(C_CORN)
          @ 15,31 CLEAR TO 18,48
          RELAX1 = 0
          RETURN
ENDCASE
ENDDO

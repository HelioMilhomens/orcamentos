******************************************
**  Arquivo de "PROCEDURES" para impressao
******************************************
#include "migracao.ch"
#include "box.ch"

//*****************
  PROCEDURE IMPRIME
//*****************
   M_TE=SAVESCREEN(02,02,24,79)
   CLEAR GETS
   SELE 48
   Veriout(SetColor(),23,"empresa")
   SELE 48
   Goto Top
   I_PERC   = PERC
   I_JU     = JU
   I_DIAS   = DIAS
   I_FERI   = FERI
   I_UTEIS  = UTEIS
   I_DESCA  = DESCA
   IP_PREX  = PREX
   IPS_ESTX = SPC
   I_DARUMA = DARUMA
   I_NOMET  = NOMET
   I_ENDET  = ENDET
   I_PLACA  = PLACA

 SETCOLOR("W+/BG+, B/RG,X")

 @ 03,2 to 24,79

   COR=SETCOLOR()
   SET CURSOR ON
   SETCOLOR("N+/BG+")
   @ 02,04 SAY ENDEREC
   @ 03,08 SAY "Configura‡”es"
   SETCOLOR(COR)
   @ 04,4 SAY "(%) P/Tabela Pre‡³" GET I_PERC  PICT '999.99'
   @ 05,4 SAY "Cobran‡a Juros   ³" GET I_JU    PICT '999.99'
  /*
   @ 06,4 SAY "Dias no Mˆs      ³" GET I_DIAS  PICT '99'
   @ 07,4 SAY "Feriados no Mˆs  ³" GET I_FERI  PICT '99'
   @ 08,4 SAY "Dias £teis no Mˆs³" GET I_UTEIS PICT '99'
   @ 09,4 SAY "Descanso Remuner ³" GET I_DESCA PICT '99'
   @ 10,4 SAY "Cota Mensal R$   ³" GET IP_PREX PICT "@e 9,999,999.99"
  */
   @ 06,4 SAY "C¢digo SPC       ³" GET IPS_ESTX
   @ 07,4 SAY "Impressora Daruma³" GET I_DARUMA
   @ 08,4 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
   SETCOLOR("N+/BG+")
   @ 10,4 SAY "Cadastro de Motoristas - S.I.E "
   SETCOLOR(COR)
   @ 11,4 SAY "Nome :"GET I_NOMET PICT "@!S20"
   @ 12,4 SAY "Ender:"GET I_ENDET PICT "@!S20"
   @ 13,4 SAY "Placa:"GET I_PLACA
   SETCOLOR("N+/BG+")
   @ 15,4 SAY "Tipo de Impressora Fiscal"
   SETCOLOR(COR)
   @ 16,4 SAY "Bematech"
   SETCOLOR("N+/BG+")
   @ 03,40 SAY "Comiss”es Lojas I,II,VI,VIII,IX,X,XI"
   SETCOLOR(COR)
   @ 04,35 SAY "VDA A VISTA  ELETRO  1,00% At‚ 15% (0,80%)  "
   @ 05,35 SAY "VDA A VISTA  MOVEIS  2,00% At‚ 20% (1,50%)  "
   @ 06,35 SAY "VDA C/CHEQUE ELETRO  1,20% S/DESC, C/DESC 1%"
   @ 07,35 SAY "VDA C/CHEQUE MOVEIS  2,50% S/DESC, C/DESC 2%"
   @ 08,35 SAY "VDA C/CARNˆ  ELETRO  0,80%                  "
   @ 09,35 SAY "VDA C/CARNˆ  MOVEIS  1,50%                  "
   @ 10,35 SAY "VDA FINANC   ELETRO  1,00% At‚ 15%  (0,80%) "
   @ 11,35 SAY "VDA FINANC   MOVEIS  2,00% At‚ 20%  (1,50%) "
   @ 12,35 SAY "VDA CARTAO   ELETRO  1,00% At‚ 15%  (0,80%) "
   @ 13,35 SAY "VDA CARTAO   MOVEIS  2,00% At‚ 20%  (1,50%) "
   SETCOLOR("N+/BG+")
   @ 14,40 SAY "Comiss”es Demais Filiais"
   SETCOLOR(COR)
   @ 15,35 SAY "VDA A VISTA  ELETRO  1,00% At‚ 15% (0,80%)  "
   @ 16,35 SAY "VDA A VISTA  MOVEIS  1,00% At‚ 20% (0,80%)  "
   @ 17,35 SAY "VDA C/CHEQUE ELETRO  1,20% S/DESC, C/DESC 1%"
   @ 18,35 SAY "VDA C/CHEQUE MOVEIS  1,20% S/DESC, C/DESC 1%"
   @ 19,35 SAY "VDA C/CARNˆ  ELETRO  0,80%                  "
   @ 20,35 SAY "VDA C/CARNˆ  MOVEIS  0,80%                  "
   @ 21,35 SAY "VDA FINANC   ELETRO  1,00% At‚ 15%  (0,80%) "
   @ 22,35 SAY "VDA FINANC   MOVEIS  1,00% At‚ 20%  (0,80%) "
   @ 23,35 SAY "VDA CARTAO   ELETRO  1,00% At‚ 15%  (0,80%) "
   @ 24,35 SAY "VDA CARTAO   MOVEIS  1,00% At‚ 20%  (0,80%) "
     READ
   RESTSCREEN(02,02,24,79,M_TE)
    SET CURSOR OFF
   IF BLOQREG(0)
    repl perc with i_perc,ju with i_ju,dias with i_dias,feri with i_feri,uteis with i_uteis
    repl desca with i_desca,prex with ip_prex,spc with ips_estx,daruma with i_daruma,nomet with i_nomet
    repl endet with i_endet,placa with i_placa
   ENDIF
TONE(80,4)
RETURN

//****************************
  PROCEDURE OKPRINT(LINHA,COR)
//****************************
M_CORA = SETCOLOR()
IF LINHA = NIL
   LINHA = 23
ENDIF
IF COR   = NIL
   COR   = C_CORG
ENDIF
TELA300=SAVESCREEN(LINHA,1,LINHA+1,78)
WHILE .T.
  IF RELAX1 = 2
     FRASE2(LINHA,"Coloque a Impressora em Linha e Tecle [Enter]           ",,27,13,COR)
  IF LASTKEY() = 27
     EXIT
  ENDIF
  RESTSCREEN(LINHA,1,LINHA+1,78,TELA300)
/*
  IF .NOT. ISPRINTER()
     FRASE2(LINHA,"Impressora Desligada ou Fora de Linha. Pressione <Enter>",,20,13,C_CORG)
     IF LASTKEY() = 27
        EXIT
     ENDIF
  ELSE
     EXIT
  ENDIF
*/
  Exit   // Retirar depois de ajeitar
  ENDIF
ENDDO
RESTSCREEN(LINHA,1,LINHA+1,78,TELA300)
SETCOLOR(M_CORA)
RETURN

PROCEDURE ESCPRINT(ESC,LINHA)
*****************************
IF ESC = NIL
   ESC = INKEY()
ENDIF
IF LINHA = NIL
   LINHA = 23
ENDIF
IF ESC = 27
   FRASE2(LINHA,"Interrompe Impress„o ? < S/N >",,83,78,C_CORG)
   IF     LASTKEY() = 78 .OR. LASTKEY() = 110
      RETURN
   ELSEIF LASTKEY() = 83 .OR. LASTKEY() = 115
      SIGA = "N"
      IF RELAX1 = 2
         SET DEVI TO PRINT
       @ PROW()+1,1 SAY "============================"
       @ PROW()+1,1 SAY "IMPRESS„O INTERROMPIDA ...  "
       @ PROW()+1,1 SAY "============================"
      ENDIF
      SET DEVI TO SCREEN
      RETURN
   ENDIF
  ENDIF
RETURN
//*******************************
  PROCEDURE CABECA(P_TITU,P_PAGI)
//*******************************
SETPRC(0,0)
@ PROW()+1,00 SAY CHR(18)+" "
@ PROW()  ,28 SAY CHR(27)+"E"+TRIM(XY_EMPRESA)+" "+LOJAX+CHR(27)+"F"
@ PROW()+2,2  SAY CHR(27)+"E"+DataExt(M_DATSI)+CHR(27)+"F"
IF P_PAGI <> NIL
   @ PROW()  ,30 say CHR(27)+"E"+XY_SLOGAN+CHR(27)+"F"
   @ PROW()  ,72 SAY CHR(27)+"E"+"P g.:"+STRZERO(P_PAGI,3,0)+CHR(27)+"F"
ENDIF
 IF P_TITU = NIL
     P_TITU = "S.I.E. Sistema Integrado Empresarial"
 ENDIF
   @ PROW()+2,12 say CHR(27)+"E"+P_TITU+CHR(27)+"F"
   @ PROW()+1,00 SAY CHR(18)+" "
@ PROW()  ,00 SAY REPLICATE("Í",79)
RETURN

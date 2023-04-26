********************************************
/*
   FILE NAME : FICHAE.PRG
   BY        : HELIO -SP
   DESC      : RELATORIO DE FICHA DE ESTOQUE
*/
********************************************
#include "box.ch"
#include "migracao.ch"

//***************
  Procedure ficha(m_codx)
//***************
If Empty(m_codx)
   Stor 0 to M_CODX
Endif

While .T.
SETCOLOR("W+/BG+, B/RG,X")
SOMBRA(15,21,17,70,BOX)
@ 15,27 SAY "Ficha de Estoque"
@ 16,22 SAY "C¢digo:"GET M_CODX PICT "999999" VALID M_CODX >0
READ
 IF LASTKEY() = 27
    Set Color to
    RETURN
 ENDIF
 SELE 3
 SET ORDER TO 1
 SEEK M_CODX
 IF EOF()
    FRASE2(24,"Produto N„o Cadastrado !",3,,,C_CORG)
    LOOP
 ENDIF
 @ 16,38 SAY SUBSTR(CD_PROD,1,30)
 M_PROD=CD_PROD
 M_DAT1 = m_datsi
 If Loja = 9                        && DATA DA RE-INAUGURACAO
    M_DAT1 = XY_DTI
 Endif
 If Loja = 15 .or. Loja = 50                        && DATA DA RE-INAUGURACAO
    M_DAT1 = XY_DTI
 Endif
 M_DAT2 = M_DATSI
 SOMBRA(18,22,20,63,BOX)
 @ 18,29 SAY " ENTRE COM O PER¡ODO  "
 @ 19,24 SAY 'DATA In:' GET M_DAT1
 @ 19,44 SAY 'DATA Fn:' GET M_DAT2
 Read
 IF LASTKEY() = 27 .OR. EMPTY(M_DAT1) .OR. EMPTY(M_DAT2)
    Set Color to
    Return
 Endif
 CONFIRMA()
 IF LASTKEY() = 27
    Set Color to
    Return
 Endif
 SETCOLOR(C_CORM)
 Clear
 COR=SETCOLOR()
 SETCOLOR("W+/B+")
 @ 00,20 SAY "FICHA DE ESTOQUE POR PRODUTO    S.I.E. "
 @ 01,00 SAY "C¢digo :"+STRZERO(M_CODX,6,0)+" "+SUBSTR(M_PROD,1,40)+" de "+DATAEXT(M_DAT1) + " a " + DATAEXT(M_DAT2)
 SETCOLOR(COR)
 @ 02,00 SAY REPL("Í",80)
 @ 03,00 SAY " D A T A PROCEDENCIA                                      ENTR.    SAIDA   VEND."
 @ 04,00 SAY REPL("Í",80)
 @ 21,00 SAY REPL("Í",80)
 @ 22,00 SAY " SALDOS DE ESTOQUE ENTRADAS/SAIDAS/SALDO:"
 @ 23,00 SAY REPL("Í",80)

 LIN    = 05
 STOR 0 TO M_ITEN,M_SAIDA,M_ENTRA,M_ANTEE,M_ANTES
 M_DDANT= M_DAT1-1
 M_DATX = M_DAT1
 M_SALDO= 00
 PRIV VET[55000]
 CT="00001"

  SOMBRA(11,10,13,50,BOX)
  @ 12,12 SAY "Aguarde Gerando Saldos..."
  SELE 19                       && ROTINA PARA SALDO ANTERIOR (ENTRADAS)
  SET ORDER TO 1
  GOTO TOP
  SEEK STR(M_CODX,6,0)
  While !Eof() .and. CD_CODI=M_CODX
    IF CD_TRANSF <> "S" .AND. CD_DATA < M_DAT1
       If Loja = 15  .or. Loja = 50
          If cd_data < xy_dti                    // Dta Inicial do Feirao IGT
             M_ANTEE = 0
          Else
             M_ANTEE = M_ANTEE + CD_CENT
	  Endif
       Else
          M_ANTEE = M_ANTEE + CD_CENT
       Endif
    ENDIF
    SKIP
  ENDDO

  SELE 4                       && ROTINA PARA SALDO ANTERIOR (SAIDAS)
  SET ORDER TO 2
  GOTO TOP
  SEEK STR(M_CODX,6,0)
  While !Eof() .and. SD_CODI=M_CODX
      If Loja = 99 .or. Loja=10 .or. Loja=11 .or. Loja=19 .or. Loja=20
         If sd_cpd = "S" .AND. SD_DATA < M_DAT1
            M_ANTES = M_ANTES + SD_QTDE
	 Endif
      Else
          If SD_DATA < M_DAT1
	    If Loja = 15 .or. Loja = 50
	       If sd_data < xy_dti
	          M_ANTES = 0
	       Else
                  M_ANTES = M_ANTES + SD_QTDE
	       Endif
	    Else
               M_ANTES = M_ANTES + SD_QTDE
	    Endif
	  Endif
      Endif
      SKIP
 ENDDO
/*
 SELE 11          && SALDO ANTERIOR TRANSFERENCIAS
 SET ORDER TO 2
 SEEK STR(M_CODX,6,0)
 While !Eof() .AND. TR_CODI=M_CODX
  If TR_DATA < M_DAT1
     If TR_LOJA=LOJA
        If Loja = 15 .or. Loja = 50
           If tr_data < xy_dti
 	      M_ANTEE = 0
	   Else
              M_ANTEE=M_ANTEE+TR_QUANT
	   Endif
        Else
           M_ANTEE=M_ANTEE+TR_QUANT
        Endif
    ElseIf TR_NUMP=LOJA
       If Loja = 15 .or. Loja = 50
          If tr_data < xy_dti
	     M_ANTES = 0
	  Else
             M_ANTES=M_ANTES+TR_QUANT
	  Endif
       Else
          M_ANTES=M_ANTES+TR_QUANT
       Endif
    Endif
  Endif
  Skip
 Enddo
*/
 M_SALDO = M_ANTEE-M_ANTES    && SALDO ANTERIOR (ENTRADAS-SADIAS-SAIDAS DE REQ)
 M_SALDOP= M_SALDO
 @ LIN,00     SAY M_DDANT
 @ LIN,13     SAY "SALDO ANTERIOR...................."
 @ LIN,75     SAY STRZERO(M_SALDO,5)
 VET[&CT] = DTOC(M_DDANT)+' '+'SALDO ANTERIOR.............                                     '+STRZERO(M_SALDO,5,0)
 CT = ALLTRIM(STR(VAL(CT)+1))
 LIN=LIN+1
 @ 12,02 CLEAR TO 12,60

While .T.
/*
 SELE 19    && ENTRADAS
 SET ORDER TO 1
 SEEK STR(M_CODX,6,0)+SUBSTR(DTOC(M_DAT1),7,4)+SUBSTR(DTOC(M_DAT1),4,2)+SUBSTR(DTOC(M_DAT1),1,2)
 IF !EOF()
    WHILE CD_CODI=M_CODX .AND. CD_DATA=M_DAT1
      IF CD_TRANSF <> "S"
         If Loja = 15 .or. Loja = 50
            If cd_data < xy_dti
               M_ENTRA=0
               M_SALDO=0
            Else
               M_ENTRA=M_ENTRA+CD_CENT
               M_SALDO=M_SALDO+CD_CENT
	    Endif
         Else
            M_ENTRA=M_ENTRA+CD_CENT
            M_SALDO=M_SALDO+CD_CENT
         Endif
         If M_ENTRA > 0
            @ LIN,00 SAY CD_DATA
            @ LIN,58 SAY STRZERO(CD_CENT,5)
            VET[&CT] = DTOC(CD_DATA)+' '+'ENTRADAS NO ESTOQUE ==> NOTA NR. '+STRZERO(CD_NOTA,7)+'        '+STRZERO(CD_CENT,5,0)+'           '
            CT = ALLTRIM(STR(VAL(CT)+1))
            COR=SETCOLOR()
            SETCOLOR("B/GB+")
            @ LIN,75     SAY STRZERO(M_SALDO,5)
            SETCOLOR(COR)
            LIN ++
            IF LIN > 20
               LIN = 20
               SCROLL(05,00,20,79,1)
            ENDIF
         Endif
      ENDIF
      SKIP
    ENDDO
 ENDIF
 SELE 11          && TRANSFERENCIAS
 SET ORDER TO 2
 SEEK STR(M_CODX,6,0)+SUBSTR(DTOC(M_DAT1),7,4)+SUBSTR(DTOC(M_DAT1),4,2)+SUBSTR(DTOC(M_DAT1),1,2)
 IF !EOF()
    WHILE TR_CODI=M_CODX .AND. TR_DATA=M_DAT1
     IF TR_LOJA=LOJA
        If Loja = 15 .or. Loja = 50
           If tr_data < xy_dti
              M_ENTRA=0
              M_SALDO=0
           Else
              M_ENTRA=M_ENTRA+TR_QUANT
              M_SALDO=M_SALDO+TR_QUANT
	   Endif
        Else
           M_ENTRA=M_ENTRA+TR_QUANT
           M_SALDO=M_SALDO+TR_QUANT
        Endif
        IF M_ENTRA > 0
           @ LIN,00     SAY TR_DATA
           @ LIN,58     SAY STRZERO(TR_QUANT,5)

           VET[&CT] = DTOC(TR_DATA)+' '+'TRANSFERENCIA DE: '+TR_DE+' NOTA NR. '+STRZERO(TR_NOTA,6)+' '+STRZERO(TR_QUANT,5,0)+'           '
           CT = ALLTRIM(STR(VAL(CT)+1))
           COR= SETCOLOR()
           SETCOLOR("B/GB+")
           @ LIN,75     SAY STRZERO(M_SALDO,5)
           SETCOLOR(COR)
           LIN ++
           IF LIN > 20
              LIN = 20
              SCROLL(05,00,20,79,1)
           ENDIF
        Endif
     ELSEIF TR_NUMP=LOJA
        If Loja = 15 .or. Loja = 50
           If tr_data < xy_dti
              M_SAIDA=0
              M_SALDO=0
	   Else
              M_SAIDA=M_SAIDA+TR_QUANT
              M_SALDO=M_SALDO-TR_QUANT
	   Endif
        Else
           M_SAIDA=M_SAIDA+TR_QUANT
           M_SALDO=M_SALDO-TR_QUANT
        Endif
        If M_SAIDA > 0
           @ LIN,00 SAY TR_DATA
           @ LIN,58 SAY STRZERO(TR_QUANT,5)
           VET[&CT] = DTOC(TR_DATA)+' '+'TRANSFERENCIA P/: '+TR_PARA+' NOTA NR. '+STRZERO(TR_NOTA,6)+'         '+STRZERO(TR_QUANT,5,0)+'   '+STRZERO(M_SALDO,5,0)
           CT =ALLTRIM(STR(VAL(CT)+1))
           COR=SETCOLOR()
           SETCOLOR("B/GB+")
           @ LIN,75     SAY STRZERO(M_SALDO,5)
           SETCOLOR(COR)
           LIN ++
           IF LIN > 20
              LIN = 20
              SCROLL(05,00,20,79,1)
           ENDIF
        Endif
      ENDIF
      SKIP
    ENDDO
 ENDIF
*/
 SELE 4
 SET ORDER TO 2
 SEEK STR(M_CODX,6,0)+SUBSTR(DTOC(M_DAT1),7,4)+SUBSTR(DTOC(M_DAT1),4,2)+SUBSTR(DTOC(M_DAT1),1,2)
 IF !EOF()
   WHILE SD_CODI = M_CODX .AND. SD_DATA=M_DAT1
      m_imp="N"
      If Loja=10 .or. Loja=11 .or. Loja=19 .or. Loja=20
         If sd_cpd = "S"
            m_imp="S"
	 Endif
      Else
         m_imp="S"
      Endif
      If m_imp = "S"
         If Loja = 15 .or. Loja = 50
            If sd_data < xy_dti
               M_SAIDA=0
               M_SALDO=0
	    Else
               M_SAIDA=M_SAIDA+SD_QTDE
               M_SALDO=M_SALDO-SD_QTDE
	    Endif
         Else
            M_SAIDA=M_SAIDA+SD_QTDE
            M_SALDO=M_SALDO-SD_QTDE
         Endif
         If M_SAIDA > 0
            IF SD_TIPO = 1
               VARI=" VD.A VISTA"
               CL_C=SPACE(15)
            ELSEIF SD_TIPO = 2
               VARI=" VD.C/CHEQ "
               CL_C=SUBSTR(SD_NOMECL,1,15)
            ELSEIF SD_TIPO = 4
               VARI=" VD.FINANC "
               CL_C=SPACE(15)
            ELSEIF SD_TIPO = 5
               VARI=" VD.CARTAO "
               CL_C=SPACE(15)
            ELSEIF SD_TIPO = 6
               VARI=" CONVENIO  "
               CL_C=SPACE(15)
            ELSEIF SD_TIPO = 7
               VARI=" VD. BMG   "
               CL_C=SPACE(15)
            ELSEIF SD_TIPO = 8
               VARI=" CAIXA CONV"
               CL_C=SPACE(15)
            ELSE
               VARI=" VD.A PRAZO"
               CL_C=SUBSTR(SD_NOMECL,1,15)
            ENDIF
         @ LIN,00     SAY SD_DATA
         @ LIN,09     SAY "VD.NF "+STRZERO(SD_NOTA,8)+" "+SD_SERI+VARI+" "+CL_C
         @ LIN,67     SAY STRZERO(SD_QTDE,5)
         VET[&CT] = DTOC(SD_DATA)+' VD.NF '+STRZERO(SD_NOTA,8)+' '+SD_SERI+VARI+' '+CL_C+'           '+STRZERO(SD_QTDE,5,0)+'   '+SUBSTR(SD_NOME,1,5)
         CT = ALLTRIM(STR(VAL(CT)+1))
         COR=SETCOLOR()
         SETCOLOR("B/GB+")
         @ LIN,75     SAY STRZERO(M_SALDO,5)
         SETCOLOR(COR)
         LIN ++
         IF LIN > 20
            LIN = 20
            SCROLL(05,00,20,79,1)
         ENDIF
       Endif
    Endif
    SKIP
 ENDDO
ENDIF
 M_DAT1=M_DAT1+1
 IF M_DAT1 > M_DAT2
    EXIT
 ENDIF
ENDDO
 SET DEVI TO SCREEN
 *@ 22,58 SAY STRZERO(M_ENTRA,5)   && TOTAL DAS ENTRADAS
 *@ 22,67 SAY STRZERO(M_SAIDA,5)   && TOTAL DAS SAIDAS
 *@ 22,75 SAY STRZERO(M_SALDO,5)
 SETCOLOR("W+/BG+, B/RG,X")
 @ 05,00 clear to 20,79
 PE=ACHOICE(05,00,20,79,VET)
 RELEASE ALL LIKE VET*
 SELE 3
 SET ORDER TO 1
 GOTO TOP
 SET FILTER TO
 GOTO TOP
 M_DAT1=M_DATX
 C_C=("W+/BG+, B/RG,X")
 FRASE2(24,"< Enter >< Esc > Sai",,13,27,C_C)
 IF LASTKEY() = 27
    SETCOLOR(C_CORG)
 ENDIF
ENDDO
SET COLOR TO
RETURN

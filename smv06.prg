//********************************************************
/*
  FILE NAME : SMV06.PRG
  BY        : HELIO-SP
  DESC      : Consulta NOTA DE VENDA
*/
//********************************************************
#include "migracao.ch"
#include "box.ch"

Procedure Smv06()

While .T.
 TelVen()
    SETCOLOR("N+/W+")
    @ 03,01 clear to 03,78
    @ 03,30 SAY "CONSULTA VENDAS"
    Stor 0 to M_NOTA,M_GRTO
    Stor Space(03) to M_SERI
    IF LOJAS<=9
       M_SERI = "00"+STR(LOJAS,1)
    ELSE
       M_SERI = "0"+STR(LOJAS,2)
    ENDIF
    SET CURSOR ON
    @ 6,49 GET M_NOTA PICT "99999999" VALID M_NOTA >0
    @ 6,64 GET M_SERI
    READ
    IF LASTKEY() = 27
       Release M_TIPO,M_TPF,M_CIDA,M_CGC,M_CPF,M_RG,M_BAIR,M_TXE,M_TXM,M_AUTO,M_FIXO
       Release M_REF,M_REF1,M_OBS,M_FONE,m_tpfin,m_nota,m_seri,m_valorgr,w_vez,M_ENTRCAR,M_AUTOLIM
       Release wPMista,M_AUTO,M_ENTRCAR,M_ENTRFIN,M_ENTRAD
       Exit
    Endif

    SELE 4
    SET ORDER TO 1
    GOTO TOP
    SEEK STR(M_NOTA,8,0)+SUBSTR(M_SERI,1,3)
    IF Eof()
       Alert( "Venda N„o Efetuada. Por Favor Verifique !")
       Loop
    ENDIF
    M_ENTRCAR= 0
    M_AUTO   = 0
    M_AUTOLIM= SD_AUTOLIM
    M_TIPO   = SD_TIPO
    M_TPF    = SD_TPFIN
    M_CIDA   = SD_CIDA
    M_CGC    = SD_CGC
    M_CPF    = SD_CPF
    M_RG     = SD_RG
    M_BAIR   = SD_BAIR
    M_REF    = SD_REFER
    M_REF1   = SD_REFER2
    M_OBS    = SD_OBSERV
    M_FONE   = SD_FONE
    M_DATA   = SD_DATA
    M_CLIE   = SD_CLIE
    M_VEND   = SD_VEND
    M_CONTR  = SD_CONTR
    M_TXE    = SD_TXE
    M_TXM    = SD_TXM
    W_VEZ    = SD_VEZES
    M_ORCA   = SD_ORCA
    M_IMEI   =""
    M_NSERIE =""

    If Sd_AUTO >0
       M_AUTO = SD_AUTO
    Endif
    If SD_ENTRCAR >0
       M_ENTRCAR = SD_ENTRCAR
    Endif

    wNumer    = ""
    wNumert   = ""
    If !Empty(SD_NumeroT)
       wNumer = ", "+Trim(sd_numero)
    Endif
    If !Empty(SD_Numero)
       wNumert = ", "+Trim(sd_numerot)
    Endif

    wComple   = Alltrim(SD_Comple)
    wComplet  = Alltrim(SD_CompleT)
    wEndTrega = Alltrim(SD_EndeT)+" "+wNumerT
    wEnde     = Alltrim(SD_Ende)+" "+wNumer
    wCidaTrega= SD_Cidat
    wBairTrega= SD_bairt
    wUFTrega  = SD_Uft

     m_tpfin=""
     IF M_TPF >0 .and. M_Tipo = 4
        If M_tpf = 1
           M_TPFIN="Losango   "
        ElseIf M_tpf = 2
         * M_TPFIN="Fininvest "
           M_TPFIN="Omni "
        ElseIf M_tpf = 3
           M_TPFIN="Finasa    "
        ElseIf M_tpf = 5
           M_TPFIN="Cetelem"
        ElseIf M_tpf = 6
           M_TPFIN="Semear"
        Endif
     ElseIf M_TPF >0 .and. M_Tipo = 5
        If M_tpf = 1
           M_TPFIN="Visa      "
        Elseif M_tpf = 2
           M_TPFIN="MasterCard"
        Elseif M_tpf = 3
           M_TPFIN="HiperCard "
        Elseif M_tpf = 4
           M_TPFIN="Diners"
        Elseif M_tpf = 5
           M_TPFIN="Outras"
        Elseif M_tpf = 6
           M_TPFIN="FortBrasil"
        Elseif M_tpf = 7
           M_TPFIN="American Exp"
        Elseif M_tpf = 8
           M_TPFIN="Elo"
        ElseIf M_tpf = 11
           M_TPFIN="Cielo/FortBR"
        ElseIf M_tpf = 12
           M_TPFIN="Cielo/Outras"
        ElseIf M_tpf = 13
           M_TPFIN="Rede/CredSystem"
        ElseIf M_tpf = 14
           M_TPFIN="Rede/SoroC"
        ElseIf M_tpf = 15
           M_TPFIN="Rede/Cabal"
        ElseIf M_tpf = 16
           M_TPFIN="Rede/CredZ"
        Endif
     ElseIf  M_Tipo = 6
        M_TPFIN=""
     Endif

While .T.
   TelVen()
   SetColor(c_Corg)
   EMPRESA()

   IF LASTKEY() = 27
      EXIT
   ENDIF
   SetColor("n+/w")
   @ 3,29 clear to 3,78
   IF M_TIPO = 1
     @ 3,29 SAY "  Venda a Vista    "
   ELSEIF M_TIPO = 2
      @ 3,29 SAY " Venda Com Cheque "+" Em "+Strzero(w_vez,2)+" Vezes"
   ELSEIF M_TIPO = 3
      @ 3,29 SAY " Venda Com Carnˆ  "+" Em "+Strzero(w_vez,2)+" Vezes"
   ELSEIF M_TIPO = 4
      @ 3,29 SAY " Venda Financeira - "+m_tpfin
   ELSEIF M_TIPO = 5
      @ 3,29 SAY " Venda Com C/Cr‚d.- "+m_tpfin+" Em "+Strzero(w_vez,2)+" Vezes"
   ELSEIF M_TIPO = 6
      @ 3,29 SAY " Boleto Bancario "
   ELSEIF M_TIPO = 7
      @ 3,29 SAY " Venda BMG (Consignada) "
   ELSEIF M_TIPO = 8
      @ 3,29 SAY " Caixa / Convenio "
   ELSEIF M_TIPO = 9
      @ 3,29 SAY " Caixa / Financ   "
   ELSEIF M_TIPO = 10
      @ 3,29 SAY " Boleto Bancario  "
   ENDIF
   SetColor(c_Corg)

   Sele 25
   Set Order to 1
   Seek Str(m_orca,8,0)
   m_fixo = cd_fixo

   @ 5,12 SAY M_DATA
   @ 6,49 SAY STRZERO(M_NOTA,8)
   @ 6,64 SAY M_SERI
   @ 6,71 SAY STRZERO(M_CONTR,8)
   IF M_CLIE > 0
      SELE 1
      SET ORDER TO 1
      SEEK M_CLIE
      IF EOF()
         Alert( "Error no Arquivo de Clientes.")
         Return
      ENDIF
      @ 05,32 CLEAR TO 05,78
      @ 05,32 SAY STRZERO(CL_CODI,6) + " " + TRIM(CL_NOME)
      M_CIDA = CL_CIDA
      M_CGC  = CL_CGC
      M_CPF  = CL_CPF
      M_BAIR = CL_BAIR
   ENDIF
   SELE 16
   SET ORDER TO 1
   SEEK STR(M_VEND,3,0)
   IF EOF()
      Alert( "Vendedor N„o Cadastrado. Verifique !")
   ELSE
      V_NOME = BA_NOME
      @ 6,12 SAY STRZERO(BA_CODI,3) + "  " + BA_NOME
      NOMEVE=BA_NOME
   ENDIF
   SELE 4
   SET ORDER TO 1
   GOTO TOP
   SEEK STR(M_NOTA,8,0)+SUBSTR(M_SERI,1,3)
   IF EOF()
      Alert( "Error no Arquivo de Notas. Verifique !")
   ENDIF
   IF M_CLIE = 0
      @ 05,32 CLEAR TO 05,78
      @ 05,32 SAY SD_NOMECL
   ENDIF
   LIN = 9
   PRIV M_ACHE[500]
   M="001"
   Stor 0 TO M_TOTA,QUANT,M_ORCA,m_valorgr,wPMista,M_AUTO,M_ENTRCAR,M_ENTRFIN,M_ENTRAD
   While !Eof() .AND. SD_NOTA = M_NOTA .AND. SD_SERI = M_SERI
     If SD_TXe > 0
        M_TXE  = SD_TXE
     Endif
     If SD_TXm > 0
        M_TXM = SD_TXM
     Endif
     If SD_PMista >0
        wPMista = SD_PMista
     Endif
     If SD_AUTO >0
        M_AUTO = SD_AUTO
     Endif
     If Sd_EntrCar >0
        M_ENTRCAR=SD_ENTRCAR
     Endif
     If Sd_EntrFin >0
        M_ENTRFIN=SD_ENTRFIN
     Endif
     M_ENTRAD  = SD_ENTRADA
     If sd_tipo = 3 .or. sd_tipo = 6
        M_ENTRAD  = SD_ENTRADA
     Else
        If SD_ENTRADA = SD_ENTRCAR
           M_ENTRAD   = 0
        Endif
     Endif
     M_CODI = SD_CODI
     M_ORCA = SD_ORCA
     If !Empty(SD_IMEI)
        M_IMEI   = "IMEI: "+Trim(SD_IMEI)
     ElseIf !Empty(SD_NSERIE)
        M_NSERIE = "N SERIE: "+Trim(SD_NSERIE)
     Endif

     SELE 3
     SET ORDER TO 1
     GOTO TOP
     SEEK M_CODI
     IF !Eof()
        M_PRD =CD_PROD
        M_FABR=CD_FABR
        M_COR =Substr(CD_COR,1,7)
     ELSE
        M_PRD =""
        M_FABR=""
        M_COR =space(07)
        @ LIN,14 SAY "Erro no arquivo..."
     ENDIF
     SELE 4
     SET ORDER TO 1
     M_TOTA = M_TOTA + (SD_PREC * SD_QTDE)
     @ 21,65 SAY M_TOTA PICT "@E 99,999,999.99"
     QUANT=QUANT+SD_QTDE
     M_VAL = 0
     IF SD_ENTRADA <> 0
        M_VAL  = SD_ENTRADA
     ENDIF
     @ LIN,01 SAY STRZERO(SD_QTDE,5,1)+"³"+STRZERO(SD_CODI,6)+"³"+SUBSTR(M_PRD,1,26)+"³"+SUBSTR(M_FABR,1,8)+" "+M_COR+"³"+STR(SD_PREC,9,2)+"³"+STR(SD_PREC*SD_QTDE,11,2)
     LIN = LIN + 1
     IF LIN > 19
        LIN = 19
        SCRCANC()
     ENDIF
     If !Empty(sd_cor)
        m_cor = Substr(sd_cor,1,7)
     Endif
     M_ACHE[&M]=STRZERO(SD_QTDE,5)+"³"+STRZERO(SD_CODI,6)+"³"+SUBSTR(M_PRD,1,26)+"³"+M_COR+"³"+SUBSTR(SD_SAIDA,1,6)+"³"+STR(SD_PREC,9,2)+"³"+STR(SD_PREC*SD_QTDE,10,2)+"³"+SUBSTR(SD_FAT,1,1)
     M = STRZERO(VAL(M)+1,3,0)
     SKIP
  ENDDO

   m_valorgr  = 0
   wDatacan = ctod("")
   Sele 35
   Set Order to 2
   Go Top
   Seek Str(M_NOTA,8,0)+SUBSTR(M_SERI,1,3)
   While !Eof() .and. Gr_Minuta = M_NOTA .and. Gr_Seri = M_SERI
     m_valorgr = m_valorgr + gr_fator
     If !Empty(gr_datacan)
        m_valorgr = m_valorgr - gr_fator
        wDatacan = gr_datacan
     Endif
     Skip
   Enddo

    telres=savescreen(13,01,24,33)
    Sombra(13,01,23,31,Box)
    @ 14,02 SAY "Taxa de Entrega : "+str(m_txe,8,2)
    @ 15,02 SAY "Taxa de Montagem: "+str(m_txm,8,2)
    @ 16,02 SAY "Entrada Cart„o  : "+Str(m_entrcar,8,2)
    @ 17,02 SAY "Cod.Autoriza‡„o : "+StrZero(m_auto,8)
    @ 18,02 SAY "Cod.Autor Limite: "+StrZero(m_autolim,8)
    @ 19,02 SAY "Or‡amento       : "+StrZero(m_orca,8)
    @ 20,02 SAY "Garantia Estend.: "+Str(m_valorgr,8,2)
    If !Empty(wDatacan) .and. m_valorgr = 0
       @ 20,02 SAY "G.Est Cancelada em "+Dtoc(wDatacan)
    Endif
    @ 21,02 SAY "Seg PrestaMista : "+Str(wPmista,8,2)
    @ 22,02 say "Or‡to : "+StrZero(m_orca,8)
    If M_ENTRFIN > 0
       @ 22,02 SAY "Entrada Dinheiro: "+Str(M_ENTRFIN,8,2)
    ElseIf M_Entrad >0
       @ 22,02 SAY "Entrada Dinheiro: "+Str(M_ENTRAD,8,2)
    Else
       @ 22,02 SAY "Entrada Dinheiro: "+Str(M_ENTRAD,8,2)
    Endif
    @ 18,68 SAY M_TOTA    PICT "@E 999,999.99"
    @ 19,68 SAY m_valorgr PICT "@E 999,999.99"
    @ 20,68 SAY wPmista   PICT "@E 999,999.99"
    @ 21,68 SAY M_TOTA+m_valorgr+wPmista PICT "@E 999,999.99"
    Release wDatacan

    SETCOLOR("W+/BG+, B/RG,X")
    M_OPCA = ACHOICE(9,1,20,78,M_ACHE)
    RELEASE ALL LIKE M_ACH*

    Set Color To N/W
    @ 11,02,23,78 BOX B_SINGLE
    Set color to B+/W
    @ 11,02 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    @ 12,02 Say "³                                                                           "
    @ 13,02 Say "³                                                                           "
    @ 14,02 Say "³                                                                           "
    @ 15,02 Say "³                                                                           "
    @ 16,02 Say "³                                                                           "
    @ 17,02 Say "³                                                                           "
    @ 18,02 Say "³                                                                           "
    @ 19,02 Say "³                                                                           "
    @ 20,02 Say "³                                                                           "
    @ 21,02 Say "³                                                                           "
    @ 22,02 Say "³                                                                           "
    @ 23,02 Say "À"
    @ 12,04 say "Endere‡o: "+wEnde
    @ 12,59 say "Orcament: "+Str(m_orca)
    @ 13,04 say "Complemento de Endere‡o: "+substr(wComple,1,40)+"   Tel Fixo: "+trim(m_fixo)
    @ 14,04 say "Cidade  : "+Substr(m_cida,1,17)+" Bairro: "+substr(m_bair,1,16)+" Tel Cel: "+trim(m_fone)
    @ 15,04 say "C.P.F   : "+m_cpf +"  R.G. : "+trim(m_rg)+"  CNPJ : "+trim(m_cgc)
    @ 16,04 say "Ser/Obs : "+Trim(m_obs)+" "+Trim(M_IMEI)+" "+Trim(M_NSERIE)
    Set color to GR+/w
    @ 17,04 to 17,77
    @ 17,15 SAY "Endere‡o de Entrega do Cliente  (O.E e Montagem)"
    Set color to B+/W
    @ 18,04 SAY "Endere‡o de Entrega : "+Substr(wEndTrega,1,50)
    @ 19,04 say "Complemento de Endere‡o: "+substr(wComplet,1,40)
    @ 20,04 SAY "Bairro  : "+Substr(wBairTrega,1,20)+" Cidade : "+SubStr(wCidaTrega,1,15)+" UF : "+wUFTrega
    @ 21,04 say "P.Refer : "+Substr(m_ref,1,60)
    @ 22,04 say "P.Refer : "+Substr(m_ref1,1,60)
    Inkey(0)
  Enddo
ENDDO
Release wEndTrega,wCidaTrega,wBairTrega,wUFTrega,m_fixo
RETURN

PROCEDURE CLSCON2
*****************
/* Limpa a tela */
CORA = SETCOLOR()
SET COLOR TO
@ 5,10  CLEAR TO 5,18
@ 5,25  CLEAR TO 5,26
@ 5,35  CLEAR TO 5,77
@ 6,36  CLEAR TO 6,65
SETCOLOR(CORA)

PROCEDURE CLSCONS
*****************
/* Limpa a tela */
CORA = SETCOLOR()
SET COLOR TO
@ 9,01  CLEAR TO 20,05
@ 9,07  CLEAR TO 20,12
@ 9,14  CLEAR TO 20,49
@ 9,51  CLEAR TO 20,63
@ 9,65  CLEAR TO 20,77
SETCOLOR(CORA)
RETURN

//*****************
  PROCEDURE SCRCONS
//*****************
/* Rola tela */
CORA = SETCOLOR()
SET COLOR TO
SCROLL(9,1,19,5,1)
SCROLL(9,7,19,12,1)
SCROLL(9,14,19,49,1)
SCROLL(9,51,19,63,1)
SCROLL(9,65,19,77,1)
SETCOLOR(CORA)
RETURN

//***********
  PROC TelVen
//***********
Set Color to w+/w
@ 00,00 clear to 24,80
@ 00,00 TO 24,79 DOUBLE
@ 01,01 say curdir()
@ 01,30 say "Orcamentos de Vendas"
@ 02,01 TO 02,78
Setcolor(C_CORG)
@ 04,01 TO 04,78
@ 05,02 CLEAR TO 21,78
@ 05,01 SAY "DATA VENDA             CLIENTE:"
@ 06,01 SAY "VENDEDOR                                 MINUTA          LOJA      CT "
@ 07,01 TO 07,78
SETCOLOR("W+/BG+, B/RG,X")
@ 08,01 SAY "Quant´C¢digo´M E R C A D O R I A          COR...  Sa¡da (x)  Vr.Unit Total Fat"
Setcolor(C_CORG)
@ 09,01 SAY "     ´      ´"
@ 10,01 SAY "     ´      ´"
@ 11,01 SAY "     ´      ´"
@ 12,01 SAY "     ´      ´"
@ 13,01 SAY "     ´      ´"
@ 14,01 SAY "     ´      ´"
@ 15,01 SAY "     ´      ´"
@ 16,01 SAY "     ´      ´"
*@ 17,01 SAY "             "
@ 17,01 TO 17,78
@ 18,01 SAY "             "
@ 19,01 SAY "             "
@ 20,01 SAY "             "
@ 21,01 TO 21,78
SETCOLOR("W+/BG+, B/RG,X")
@ 23,01 SAY " [F1]Ajuda  [F10]Processa Venda  [F3]Importa Cliente  [F6]Calc  [Esc]Retorna  "
SETCOLOR("G+/BG+, B/RG,X")
@ 23,03 SAY "F1"
@ 23,14 SAY "F10"
@ 23,35 SAY "F3"
@ 23,56 SAY "F6"
@ 23,66 SAY "Esc"
Return

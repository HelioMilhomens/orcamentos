***************************************************
/*
   FILE NAME : ESTO.PRG
   BY        : HELIO-SP
   DESC      : ESTOQUE (MENU)
*/
********************************************************
#include "box.ch"
#include "migracao.ch"

Procedure Esto()
TEESTO = SAVESCREEN(00,00,24,79)
SETCOLOR("W+/B,B/W,,,W+/B")
SOMBRA(05,18,12,44,BOX)
OP3=ACHOICE(06,20,11,42,V2,.T.,"FUNCAO")
SET COLOR TO
SET KEY -1 TO
IF LASTKEY() = 13
     Set key 22 to
     DO CASE
      CASE OP3 = 1
	IF CLIE2 <> "N"
	   INFORCLI()
	ELSE
	   NADA()
	ENDIF
	   KEYB(CHR(13))
      CASE OP3 = 2
        IF MOVD3 <> "N"
           Clear
	   SMV06()
	ELSE
	   NADA()
	ENDIF
	KEYB(CHR(13))
     CASE OP3 = 3
        Alert("Consulte F12 no Faturamento !")
	KEYB(CHR(13))
     CASE OP3 = 4
	*IF VEND2 <> "N"        && Inibe Comissoes de Vendedores
            RLVENDV()           && NESTE PRG
	*ELSE
	 *  NADA()
	*ENDIF
	KEYB(CHR(13))
     CASE OP3 = 5
	IF RELE1 <> "N"        && O MESMO QUE EMITE RELATORIOS DE ESTOQUE
           SetColor(c_corg)
           Sombra(11,15,13,40,box)
	   @ 12,16 say "Acesso"
	   ACES=M_ACESSO
	   Senha(ACES)
	   IF ACES <> M_ACESSO
	      ALERT("Senha N„o Cadastrada... Verifique !")
	      RETURN
           ELSE
	      GRAFICOVD()         && HELP.PRG
	   ENDIF
	ELSE
	   NADA()
	ENDIF
	KEYB(CHR(13))
     CASE OP3 = 6
	IF RELE1 <> "N"        && O MESMO QUE EMITE RELATORIOS DE ESTOQUE
	   GRAFSET()           && HELP.PRG
	ELSE
	   NADA()
	ENDIF
	KEYB(CHR(13))
     CASE OP3 = 7
	IF RELE1 <> "N"        && O MESMO QUE EMITE RELATORIOS DE ESTOQUE
	*  Arq_morto()         && Arquivo Morto Orcamento
	ELSE
	   NADA()
	ENDIF
	KEYB(CHR(13))
     ENDCASE
    RESTSCREEN(00,00,24,79,TEESTO)
 ELSE
    RESTSCREEN(00,00,24,79,TEESTO)
 ENDIF
Return

//*******************
  PROCEDURE ARQ_MORTO
//*******************
 If M_Nomeusu<>trim("HELIO")
    Return
 Endif
 m_dat=m_datsi
 @ 24,10 say "At‚ "get m_dat
 read
 If lastkey()=27
    Return
 Endif
 Sele 25
 Set order to 1
 Goto Top
 While !Eof()
   m_reg="n"
   If empty(cd_datao)
      m_reg="s"
   ElseIf cd_codior= 0
      m_reg="s"
   ElseIf cd_datao < m_dat
      m_reg="s"
   Endif
   If m_reg= "s"
      If Bloqreg(0)
         Delete
      Endif
   Endif
   Skip
   @ 24,10 say cd_codior
 Enddo

****************
PROCEDURE VDMANU
****************
WHILE .T.
 SETCOLOR(C_CORM)
 @ 17,48 to 20,65
 @ 18,49 prom "V¡deo"
 @ 19,49 prom "Impressora/V¡deo"
 Menu to relax1
 SET COLOR TO
 IF RELAX1 = 1
    RETURN
 ENDIF
 IF RELAX1 = 2
    RETURN
 ENDIF
 IF RELAX1 = 0
    RETURN
 ENDIF
ENDDO
RETURN

//*************
  PROC INFORCLI
//*************
SET KEY -2 TO
M_PASS=0
WHILE .T.
 PRIV M_NOT1[1000]
 M="0001"
 SETCOLOR("W+/BG+, B/RG,X")
 @ 03,01 clear to 22,78
 @ 03,01 to 22,78
 sscv=savescreen(09,20,14,54)
 Sombra(10,20,13,52,box)
 @ 09,22 Say "Defina"
 @ 11,22 Prom "Consulta Por C¢digo Cliente"
 @ 12,22 Prom "Consulta Por CPF Cliente   "
 menu to m_con
 Restscreen(09,20,14,54,sscv)
 If m_con = 1
   CODIX=0
   @ 04,03 SAY "CLIENTE :"GET CODIX PICT "999999"
   Read
 Else
   CPFX=SPACE(14)
   @ 04,03 SAY "C.P.F. :"GET CPFX PICT "999.999.999-99"
   Read

   IF LASTKEY() = 27
      Return
   ENDIF

   Acpf = substr(cpfx,1,3)+substr(cpfx,5,3)+substr(cpfx,9,3)+substr(cpfx,13,2)
   Ver_cpf(acpf)

    SELE 1
    SET ORDER TO 4
    GOTO TOP
    SEEK CPFX
    IF EOF()
        Alert( "CPF N„o Cadastrado. Verifique")
        Loop
    ENDIF
    CODIX=CL_CODI
 Endif

 IF LASTKEY() = 27
    RETURN
 ENDIF

 SELE 1
 SET ORDER TO 1
 SEEK CODIX
 IF EOF()
    Alert( "Cliente N„o Cadastrado. Verifique.")
    LOOP
 ENDIF

 TIPOZM   = CL_TIPOZM
 M_MAIORF = 0

 @ 04,03 SAY "CLIENTE : "+STRZERO(CODIX,6)+" "+SUBSTR(CL_NOME,1,35)+" APELIDO "+SUBSTR(CL_APELIDO,1,8)
 @ 05,02 TO 05,77
 @ 06,03 SAY "ENDERE€O : "+SUBSTR(CL_ENDE,1,30)+" BAIRRO :"+SUBSTR(CL_BAIR,1,10)
 @ 07,03 SAY "CIDADE   : "+SUBSTR(CL_CIDA,1,15)+" UF  :"+SUBSTR(CL_UF,1,2)+"   Fone: "+substr(cl_fon1,1,30)
 @ 08,03 SAY "CPF      : "+CL_CPF+"  CGC :"+CL_CGC+"  CEP :"+CL_CEP
 COR=SETCOLOR()
 SETCOLOR("BR+/B+")
 SOMBRA(09,15,11,65,BOX)
 SETCOLOR(COR)
 @ 10,22 SAY "      [1]ZM1  [2]ZM2  [0]ZM = { }"
 @ 10,53 SAY TIPOZM  PICT "9"

 X_CONTROL= 1    && VARIAVEL DE CONTROLE
 M_NUMCP  = 1
 STOR 0 TO M_MD,M_TOTVR,M_TOTFAT,M_MAIORFT,M_MAIORF,M_FAT,M_FLAG,M_TOTCP
 *************************VENDAS COM CHEQUES*********************
 SELE 4
 SET ORDER TO 7
 SEEK STR(CODIX,6,0)
 IF !EOF()
    M_NOT=SD_NOTA
    M_SER=SD_SERI
 ENDIF
 WHILE !EOF() .AND. SD_CLIE=CODIX
  M_PS="N"
  WHILE SD_NOTA=M_NOT .AND. SD_SERI=M_SER
    M_TOTVR=M_TOTVR+(SD_QTDE*SD_PREC)
    M_TOTFAT=M_TOTFAT+(SD_QTDE*SD_PREC)
    M_PS="S"
    SKIP
  ENDDO
  IF M_PS="N"
     SKIP
  ELSE
     M_FAT=M_FAT+1                  && QUANTAS VENDAS
     IF M_MAIORFT>M_TOTFAT      && CALCULO DA MAIOR FATURA
        M_MAIORF = M_MAIORFT
     ELSE
        M_MAIORF = M_TOTFAT
        M_MAIORFT= M_MAIORF
     ENDIF
     M_TOTFAT = 0
  ENDIF
  M_NOT=SD_NOTA
  M_SER=SD_SERI
ENDDO

 M_MD=M_TOTVR / M_FAT
 COR=SETCOLOR()
 SETCOLOR("BR+/B+")

 SOMBRA(14,44,20,74,BOX)
 @ 15,52 SAY STRZERO(M_FAT,3)+" FATURA(S)"
 @ 16,46 SAY "ToT. Compras R$"
 @ 16,61 SAY M_TOTVR PICT "@E 9,999,999.99"
 @ 17,46 SAY "M‚dia Compra R$"
 @ 17,61 SAY M_MD    PICT "@E 9,999,999.99"
 @ 19,46 SAY "Maior Fatura R$"
 @ 19,61 SAY M_MAIORF PICT "@E 9,999,999.99"
 SETCOLOR(COR)
 TEC =INKEY()
 WHILE TEC <> 13 .AND. TEC <> 27
    TEC = INKEY(0)
 ENDDO
 IF TEC = 27 .OR. TEC = 13
    EXIT
 ENDIF
ENDDO

//************
  PROC RLVENDV       && COMISSOES DE VENDEDORES
//************
 SET KEY -1 TO
 SET KEY -2 TO
 SET KEY -3 TO
 SET KEY -6 TO
 SET KEY -7 TO
 SET KEY -8 TO
 SET KEY -9 TO
 SET KEY 22 TO
 SET KEY -40 TO
 SET KEY -41 TO
 While .T.
   SetColor(c_corg)
   Sombra(11,15,13,40,box)
   @ 12,16 say "Acesso"
   ACES=M_ACESSO
   Senha(ACES)
   IF ACES <> M_ACESSO
      ALERT("Senha N„o Cadastrada... Verifique !")
      RETURN
   ELSE
      OKSENH = "S"
      EXIT
   ENDIF
 Enddo
 nResp:=0
 nResp:= Alert( " Vendas  " , {"Comiss”es" , "Qtde. Vendas" , "Vendas Detalhado"} )
 IF Lastkey()=27
    Return
 Endif
 If nResp = 3
    Comvendas()
    Return
 Endif

 SET COLOR TO
 R_TELA=SAVESCREEN(0,0,24,79)
 SETCOLOR(C_CORG)
 @ 00,00 clear to 24,79
 SETCOLOR("bg+/B+")
 @ 00,01 to 00,79
 @ 01,01 SAY 'C¢d Vendedor(es)     Vendas  D‚b.Com  Comiss”es Servi‡os Com 5%  Total  Rentab'
 @ 02,01 to 02,78
 While .T.
   SELE 16
   SET ORDER TO 1
   GOTO TOP
   SEEK STR(VEND3,3,0)
   IF EOF()
      Alert("C¢digo do vendedor n„o existe... Por favor verifique.")
      Return
   ENDIF
   SETCOLOR(C_CORG)
   SET CURSOR ON

   SOMBRA(18,22,21,64,BOX)
   M_DAT1 = M_DATSI
   M_DAT2 = M_DATSI
   @ 18,29 SAY " ENTRE COM O PER¡ODO  "
   @ 19,24 SAY 'DATA In:' GET M_DAT1
   @ 20,44 SAY 'DATA Fn:' GET M_DAT2
   Read
   @ 18,22 clear to 22,66
   IF LASTKEY() = 27 .OR. EMPTY(M_DAT1) .OR. EMPTY(M_DAT2)
      Release m_dat1,m_dat2
      Return
   ENDIF
   If nResp = 2
      Stor 0 to m_codi
      @ 16,24 clear to 16,65
      SOMBRA(15,22,17,64,BOX)
      @ 16,23 say "Codigo Prod "get m_codi pict "999999"
      Read
      If Lastkey() = 27
         Return
      Endif

      Sele 3
      Set Order to 1
      Seek m_codi
      If eof()
         Alert("Codigo de Produto n„o Encontrado !")
         Return
      Endif
      m_prod=cd_prod
   Endif
   M_DATX=M_DAT1
   P_TITU = "Vendas / Comiss”es " + DATAEXT(M_DAT1) + " a " + DATAEXT(M_DAT2)
   @ 00,20 SAY P_TITU
   Exit
 ENDDO

   // Criando Arquivos temporarios
   arqenvi=substr(dtoc(m_datsi),1,2)+substr(dtoc(m_datsi),4,2)+substr(time(),1,2)+substr(time(),4,2)+"_"+substr(time(),7,2)
   Sele 130
   Veriout(SETCOLOR(),23,"debitocom")
   Set Index to index_debitocom

   Sele 140
   Veriout(SETCOLOR(),23,"f_rankvd")
   copy stru to mains.&arqenvi
   copy stru to wmains.&arqenvi
   Use

   Sele 140
   Exclout(SETCOLOR(),23,"mains.&arqenvi")
   index on cd_codi to index_&mains.&arqenvi
   Use
   Sele 141
   Exclout(SETCOLOR(),23,"wmains.&arqenvi")
   Index on cd_saldo * -1 to i_&mains.&arqenvi
   Use

   Sele 140
   Veriout(SETCOLOR(),23,"mains.&arqenvi")
   Set Index to index_&mains.&arqenvi
   Sele 141
   Veriout(SETCOLOR(),23,"wmains.&arqenvi")
   Set Index to i_&mains.&arqenvi

   SETCOLOR(C_CORG)
   SIGA    ="S"
   P_PAGI  = 1
   LIN     = 03
   STOR 0 TO M_ITEN,TOTVEND,TOTCOM,T_GR,T_COMGR,M_GARAN,M_QTDE,COMISSAO,M_DEBITO,M_ADTO,G_TVENDA,G_TCUSTO
   STOR 0 TO M_V,TOTDES,X_TOTDES,TOTCOM,M_GR
   STOR 0 TO m_bk,m_book,t_bk,t_combk,t_comt,m_efici
   // Vendas Por Hora
   STOR 0 to wHora7_8,wHora8_9,wHora9_10,wHora10_11,wHora11_12,wHora12_13
   STOR 0 to wHora13_14,wHora14_15,wHora15_16,wHora16_17,wHora17_18,wHora18_
   STOR 0 to m_totvPJ

   NOMEV=""
   X    =1
   SELE 4
   SET ORDER TO 5
   GOTO TOP
   SET DEVI TO SCREEN
   While .T.
     Seek Str(VEND3,3,0)+SUBSTR(DTOC(M_DAT1),7,4)+SUBSTR(DTOC(M_DAT1),4,2)+SUBSTR(DTOC(M_DAT1),1,2)
     IF Eof()
        M_DAT1=M_DAT1+1
        IF M_DAT1 >M_DAT2
           EXIT
        ENDIF
     Else
        EXIT
     Endif
   Enddo
   While !Eof() .AND. SD_VEND=VEND3 .AND. SD_DATA<=M_DAT2
      M_V     = M_V + (SD_QTDE * SD_PREC)  && QUANTIDADE x UNITARIO VENDA
      M_VE    = (SD_QTDE * SD_PREC)
      G_TVENDA= G_TVENDA + (SD_QTDE * SD_PREC)
      G_TCUSTO= G_TCUSTO + (SD_QTDE * SD_CUSTO)

      wItem  = Val(sd_contad)
      wNota  = sd_nota
      wSerie = sd_seri
      wData  = sd_data
      wQtde  = sd_qtde
      wProd  = sd_prod
      wCodi  = sd_codi

      STOR 0 TO TOTVEND,COMI1
      TOTDES   = SD_TDESCO
      NOMEV    = SD_NOME
      X_TOTDES = X_TOTDES + SD_TDESCO
      TOTVEND  = M_VE - TOTDES             && TOTAL COMISSOES POR VENDA
      COMI1    = (TOTVEND * SD_COMI)/100
      TOTCOM   = TOTCOM + COMI1

      If nResp = 2
         If sd_codi = m_codi
            m_qtde  = m_qtde+sd_qtde
         Endif
      Endif

      If sd_hora < "08:00:00"
         wHora7_8 = wHora7_8 + m_ve
      ElseIf sd_hora >= "08:00:00" .and. sd_hora < "09:00:00"
         wHora8_9   = wHora8_9 + m_ve
      ElseIf sd_hora >= "09:00:00" .and. sd_hora < "10:00:00"
         wHora9_10  = wHora9_10+ m_ve
      ElseIf sd_hora >= "10:00:00" .and. sd_hora < "11:00:00"
         wHora10_11= wHora10_11+ m_ve
      ElseIf sd_hora >= "11:00:00" .and. sd_hora < "12:00:00"
         wHora11_12= wHora11_12+ m_ve
      ElseIf sd_hora >= "12:00:00" .and. sd_hora < "13:00:00"
         wHora12_13= wHora12_13+ m_ve
      ElseIf sd_hora >= "13:00:00" .and. sd_hora < "14:00:00"
         wHora13_14= wHora13_14+ m_ve
      ElseIf sd_hora >= "14:00:00" .and. sd_hora < "15:00:00"
         wHora14_15= wHora14_15+ m_ve
      ElseIf sd_hora >= "15:00:00" .and. sd_hora < "16:00:00"
         wHora15_16= wHora15_16+ m_ve
      ElseIf sd_hora >= "16:00:00" .and. sd_hora < "17:00:00"
         wHora16_17= wHora16_17+ m_ve
      ElseIf sd_hora >= "17:00:00" .and. sd_hora < "18:00:00"
         wHora17_18= wHora17_18+ m_ve
      ElseIf sd_hora > "18:00:00"
         wHora18_  = wHora18_ + m_ve
      Endif
      w_vdgr   = sd_vdgr
      w_pass_e = "n"
      wCPF     = sd_cpf
      wCGC     = sd_cgc
      wNomev   = sd_nome

      Sele 3
      Set Order to 1
      Seek wCodi
      If cd_faixap >0 .and. cd_gr >0
         w_pass_e = "s"                      //  Produto Elegivel1
      Endif
      If (cd_faixap >0 .and. cd_gr > 12) .and. (cd_SBGRUP=8 .or. cd_SBGRUP=304)
          w_pass_e = "n"                     //  Produto Nao Elegivel1 (Cama Box e Colchoes acima de 12 meses do fabricante)
      Endif
      If Trim(wNomev) = "ATACADO"
          w_pass_e = "n"                     // Venda para Atacado nao e' elegivel
      Endif
      If w_pass_e = "s"
         m_efici = m_efici + M_VE            // Vendas Elegiveis
         If Empty(wCpf) .and. !Empty(wCgc)
            m_totvPJ = m_totvPJ + M_VE
         Endif
      Endif
      If Substr(wProd,1,4) <> "CHIP" .and. Substr(wProd,1,6) <> "CARTAO"
         Sele 140
         Set Order to 1
         If Adireg(0)
            Repl cd_codi With wCodi,cd_saldo with wQtde
         Endif
      Endif

      wPss = "n"
      Sele 53           // Mobile Cursos
      Set Order to 1
      Seek str(wNota,8,0)+substr(wSerie,1,3)
      While !Eof() .and. minuta = wNota .and. serie = wSerie
       If data_venda = wdata .and. vendedor = vend3 .and. status = "V" .and. ITEM = wItem
          wPss = "s"
          M_book = m_book + valor_vend
       Endif
       Skip
      Enddo
      If wPss = "s"
         m_bk   = ( ( m_book * 5 ) / 100 )
         t_combk= t_combk + m_bk
      Endif
      SELE 4
      SET ORDER TO 5
      Skip
   Enddo

//********************COMISSOES DE GARANTIA EXTENDIDA **************************
   If XY_GR ="S" .AND. NRESP = 1
      M_DAT1=M_DATX
      Sele 35                      //DBF de Garantia Estendida
      Set Order to 3
      While .t.
        Seek SUBSTR(DTOC(M_DAT1),7,4)+SUBSTR(DTOC(M_DAT1),4,2)+SUBSTR(DTOC(M_DAT1),1,2)+STR(VEND3,3,0)
        IF Eof()
           M_DAT1++
           IF M_DAT1 >M_DAT2
              Exit
           ENDIF
        Else
           Exit
        Endif
      Enddo

      m_ps  = "n"
      m_grc = 5  // 5% Comissoes para os vendedores de Garantia Extendida
      While !Eof()
        If gr_data <=m_dat2 .and. gr_vende=vend3 .and. gr_status = "V"
           m_garan=m_garan+gr_fator
           m_ps ="s"
        Endif
        Skip
      Enddo
      If m_ps ="s"
         m_gr  = ( ( m_garan * m_grc ) / 100 )
         t_gr  = t_gr + m_garan
         t_comgr=t_comgr + m_gr
      Endif
   Endif

   wEficiencia = 0
   If m_garan >0 .and. m_efici >0
      m_efici = m_efici - m_totvPJ
      wEficiencia = (m_garan / m_efici)*100
   Endif

   ****************DEBITOS DE COMISSOES E ADTOS. *******************
   IF NRESP =1
      STOR 0 TO M_DEBITO,M_ADTO,COMISSAO
      If M_V >0
         M_Debito := ValorDeb(vend3,M_DATX,m_dat2)    //BALC1.PRG
      Endif
   ENDIF

   M_V      = M_V - X_TOTDES
   COMISSAO = TOTCOM - M_DEBITO - M_ADTO

   IF (M_V >0 .and. NRESP = 1) .or. (m_garan >0 .and. NRESP = 1)
      W_PERC = ((M_GARAN+M_BOOK)*5)/100
      t_bk   = t_bk + m_book
      t_comt = t_comt + W_PERC
      m_rent = ((G_TVENDA-G_TCUSTO)/G_TVENDA)*100
      @ LIN,01 SAY STRZERO(VEND3,3)+" "+SUBSTR(NOMEV,1,12)+STR(M_V,11,2)+" "+STR(M_DEBITO,8,2)+" "+STR(COMISSAO,9,2)+"³"+str(m_garan+m_book,8,2)+" "+str(w_perc,7,2)+" "+STR((w_perc+comissao),8,2)+""+STR((m_rent),6,2)
      Stor 0 to m_bk
      LIN ++
   ELSEIF NRESP = 2
      @ LIN,01 SAY STRZERO(VEND3,3)+" "+SUBSTR(NOMEV,1,15)+"  "+STRZERO(M_QTDE,4)+" Codigo "+strzero(m_codi,6)+" "+trim(m_prod)
      LIN ++
   ENDIF
   IF LIN > 20
      LIN = 20
      SCROLL(10,00,20,79,1)
   ENDIF

   SETCOLOR("gr+/BG, B/RG,X")
   // Resuno de Cotas de Vendas
   @ LIN,01 TO LIN,78
   LIN ++
   @ LIN,01 Say "Cota Vendas    (%)    M‚dia Di ria  Cota Di ria  Faltam     Eficiˆncia G.E (%)"
   LIN ++
   @ LIN,01 TO LIN,78
   LIN ++
   SETCOLOR("w+/BG, B/RG,X")
   W_mes =substr(dtoc(m_datsi),4,2)+"/"+substr(dtoc(m_datsi),9,2)

   Stor 0 to T_cota,M_cota
   Sele 130
   Use
   Sele 130
   Veriout(SETCOLOR(),23,"cotas")
   Set Index to index_cotas
   Sele 130
   Seek Substr(w_mes,1,15)+str(vend3,3,0)
   If !Eof()
      M_COTA  = CT_VAL
      W_UTEIS = CT_UTEIS
   Else
      M_COTA  = 0
      W_UTEIS = 1
   Endif

   m_v = m_v - m_book

   w_perc  = (M_V / m_cota ) * 100
   w_cotaut = m_cota / w_uteis
   w_faltam = 100 - w_perc
   w_vdia   = M_V / w_uteis

   @ LIN,01 SAY Str(M_Cota,12,2)+" "+Str(w_perc,6,2)+" %"+" "+Str(w_vdia,11,2)+" "+Str(w_cotaut,12,2)+"    "+Str(w_faltam,6,2)+" %"+"       "+Str(wEficiencia,6,2)+" %     "
   LIN=LIN+1
   If m_book >0
      @ LIN,01 SAY "Valor de Vendas de Produtos       "+Str(m_v,10,2)
      LIN++
      @ LIN,01 SAY "Valor de Vendas de Cursos On Line "+Str(m_book,10,2)
      LIN++
      @ LIN,01 SAY "Valor Total                       "+Str(m_book+m_v,10,2)
      Inkey(0)
   Endif
   SETCOLOR("gr+/BG, B/RG,X")
   @ LIN,01 TO LIN,78

   // Resuno de Cotas de Garantia Estendida
   @ LIN,01 TO LIN,78
   LIN ++
   @ LIN,01 clear to LIN,78
   @ LIN,01 Say "Cota G Estendida (%)   M‚dia Di ria  Cota Di ria  J  Vendeu R$   Faltam "
   LIN ++
   @ LIN,01 TO LIN,78
   LIN ++
   SETCOLOR("w+/BG, B/RG,X")
   W_mes =substr(dtoc(m_datsi),4,2)+"/"+substr(dtoc(m_datsi),9,2)

   Stor 0 to T_cota,M_cota
   Sele 130
   Seek Substr(w_mes,1,15)+str(vend3,3,0)
   If !Eof()
      M_COTA  = CT_METAGE
      W_UTEIS = CT_UTEIS
   Else
      M_COTA  = 0
      W_UTEIS = 1
   Endif

   w_perc  = (m_garan / m_cota ) * 100
   w_cotaut = m_cota / w_uteis
   w_faltam = 100 - w_perc
   w_vdia   = m_garan / w_uteis
   Use

   @ LIN,01 clear to LIN,78
   @ LIN,01 SAY Str(M_Cota,12,2)+" "+Str(w_perc,6,2)+" %"+" "+Str(w_vdia,11,2)+" "+Str(w_cotaut,12,2)+"  "+Str(m_garan,12,2)+"     "+Str(w_faltam,6,2)+" %"
   LIN=LIN+1
   @ LIN,01 TO LIN,78

 //  Vendas Por Hora
     SetColor("gr+/b")
     @ 12,01 to 12,78
     @ 12,01 Say "Evolu‡„o de Vendas Por Hora "
     Setcolor(c_corg)
     @ 13,01 Say "De 07 at‚ 08 hrs"
     @ 14,01 Say "De 08 at‚ 09 hrs"
     @ 15,01 Say "De 09 at‚ 10 hrs"
     @ 16,01 Say "De 10 at‚ 11 hrs"
     @ 17,01 Say "De 11 at‚ 12 hrs"
     @ 18,01 Say "De 12 at‚ 13 hrs"
     @ 19,01 Say "De 13 at‚ 14 hrs"
     @ 20,01 Say "De 14 at‚ 15 hrs"
     @ 21,01 Say "De 15 at‚ 16 hrs"
     @ 22,01 Say "De 16 at‚ 17 hrs"
     @ 23,01 Say "De 17 at‚ 18 hrs"
     @ 24,01 Say "Ap¢s as   18 hrs"

     SetColor("w+/b")
     Cor = SetColor()
     wCor= SetColor()
     wPicoVnd = wHora7_8
     If wPicoVnd < wHora8_9
        wPicoVnd = wHora8_9
        wCor=SetColor("r+/b")
     Endif
     If wPicoVnd < wHora9_10
        wPicoVnd = wHora9_10
        wCor=SetColor("r+/b")
     Endif
     If wPicoVnd < wHora10_11
        wPicoVnd = wHora10_11
        wCor=SetColor("r+/b")
     Endif
     If wPicoVnd < wHora11_12
        wPicoVnd = wHora11_12
        wCor=SetColor("r+/b")
     Endif
     If wPicoVnd < wHora12_13
        wPicoVnd = wHora12_13
        wCor=SetColor("r+/b")
     Endif
     If wPicoVnd < wHora13_14
        wPicoVnd = wHora13_14
        wCor=SetColor("r+/b")
     Endif
     If wPicoVnd < wHora14_15
        wPicoVnd = wHora14_15
        wCor=SetColor("r+/b")
     Endif
     If wPicoVnd < wHora15_16
        wPicoVnd = wHora15_16
        wCor=SetColor("r+/b")
     Endif
     If wPicoVnd < wHora16_17
        wPicoVnd = wHora16_17
        wCor=SetColor("r+/b")
     Endif
     If wPicoVnd < wHora17_18
        wPicoVnd = wHora17_18
        wCor=SetColor("r+/b")
     Endif
     If wPicoVnd < wHora18_
        wPicoVnd = wHora18_
        wCor=SetColor("r+/b")
     Endif
     If wPicoVnd = wHora7_8
        SetColor(wCor)
     Else
        SetColor("w+/b")
     Endif
     @ 13,17 Say wHora7_8   pict "@E 999,999,999,999.99"
     @ 13,37 Say ((wHora7_8/M_V)*100) PICT '999.99'+' %'
     SetColor(Cor)

     If wPicoVnd = wHora8_9
        SetColor(wCor)
     Else
        SetColor("w+/b")
     Endif
     @ 14,17 Say wHora8_9   pict "@E 999,999,999,999.99"
     @ 14,37 Say ((wHora8_9/M_V)*100) PICT '999.99'+' %'
     SetColor(Cor)

     If wPicoVnd = wHora9_10
        SetColor(wCor)
     Else
        SetColor("w+/b")
     Endif
     @ 15,17 Say wHora9_10  pict "@E 999,999,999,999.99"
     @ 15,37 Say ((wHora9_10/M_V)*100) PICT '999.99'+' %'
     SetColor(Cor)

     If wPicoVnd = wHora10_11
        SetColor(wCor)
     Else
        SetColor("w+/b")
     Endif
     @ 16,17 Say wHora10_11 pict "@E 999,999,999,999.99"
     @ 16,37 Say ((wHora10_11/M_V)*100) PICT '999.99'+' %'
     SetColor(Cor)

     If wPicoVnd = wHora11_12
        SetColor(wCor)
     Else
        SetColor("w+/b")
     Endif
     @ 17,17 Say wHora11_12 pict "@E 999,999,999,999.99"
     @ 17,37 Say ((wHora11_12/M_V)*100) PICT '999.99'+' %'
     SetColor(Cor)

     If wPicoVnd = wHora12_13
        SetColor(wCor)
     Else
        SetColor("w+/b")
     Endif
     @ 18,17 Say wHora12_13 pict "@E 999,999,999,999.99"
     @ 18,37 Say ((wHora12_13/M_V)*100) PICT '999.99'+' %'
     SetColor(Cor)

     If wPicoVnd = wHora13_14
        SetColor(wCor)
     Else
        SetColor("w+/b")
     Endif
     @ 19,17 Say wHora13_14 pict "@E 999,999,999,999.99"
     @ 19,37 Say ((wHora13_14/M_V)*100) PICT '999.99'+' %'
     SetColor(Cor)

     If wPicoVnd = wHora14_15
        SetColor(wCor)
     Else
        SetColor("w+/b")
     Endif
     @ 20,17 Say wHora14_15 pict "@E 999,999,999,999.99"
     @ 20,37 Say ((wHora14_15/M_V)*100) PICT '999.99'+' %'
     SetColor(Cor)

     If wPicoVnd = wHora15_16
        SetColor(wCor)
     Else
        SetColor("w+/b")
     Endif
     @ 21,17 Say wHora15_16 pict "@E 999,999,999,999.99"
     @ 21,37 Say ((wHora15_16/M_V)*100) PICT '999.99'+' %'
     SetColor(Cor)

     If wPicoVnd = wHora16_17
        SetColor(wCor)
     Else
        SetColor("w+/b")
     Endif
     @ 22,17 Say wHora16_17 pict "@E 999,999,999,999.99"
     @ 22,37 Say ((wHora16_17/M_V)*100) PICT '999.99'+' %'
     SetColor(Cor)

     If wPicoVnd = wHora17_18
        SetColor(wCor)
     Else
        SetColor("w+/b")
     Endif
     @ 23,17 Say wHora17_18 pict "@E 999,999,999,999.99"
     @ 23,37 Say ((wHora17_18/M_V)*100) PICT '999.99'+' %'
     SetColor(Cor)

     If wPicoVnd = wHora18_
        SetColor(wCor)
     Else
        SetColor("w+/b")
     Endif
     @ 24,17 Say wHora18_   pict "@E 999,999,999,999.99"
     @ 24,37 Say ((wHora18_/M_V)*100) PICT '999.99'+' %'
     SetColor(Cor)

     Stor 0 to wCodi_1,wCodi_2,wCodi_3,wCodi_4,wCodi_5,wQtde_1,wQtde_2,wQtde_3,wQtde_4,wQtde_5
     Stor "" to wProd_1,wProd_2,wProd_3,wProd_4,wProd_5
     wCont = 1
     Sele 140
     Set Order to 1
     Go Top
     While !Eof()
       wCodi = cd_codi
       Stor 0 to wQuant
       wSkp = "n"
       While !Eof() .and. cd_codi = wCodi
         wQuant = wQuant + cd_saldo
         wSkp   = "s"
         Skip
       Enddo
       Sele 141
       Set Order to 1
       If Adireg(0)
          Repl cd_codi with wCodi,cd_saldo with wQuant
       Endif
       Unlock
       Sele 140
       Set Order to 1
       If wSkp = "n"
          Skip
       Endif
     Enddo
     Sele 140
     Use
     Release wSkp
     wCont = 1
     Sele 141
     Set Order to 1
     Go top
     While !Eof()
       wCodi  = cd_codi
       wQuant = cd_saldo
       Sele 3
       Set Order to 1
       Seek wCodi
       wProduto = cd_prod
       Sele 141
       Set Order to 1
       If wCont = 1
          wCodi_1 = wCodi
          wProd_1 = wProduto
          wQtde_1 = wQuant
       ElseIf wCont =2
          wCodi_2 = wCodi
          wProd_2 = wProduto
          wQtde_2 = wQuant
       ElseIf wCont =3
          wCodi_3 = wCodi
          wProd_3 = wProduto
          wQtde_3 = wQuant
       ElseIf wCont =4
          wCodi_4 = wCodi
          wProd_4 = wProduto
          wQtde_4 = wQuant
       ElseIf wCont =5
          wCodi_5 = wCodi
          wProd_5 = wProduto
          wQtde_5 = wQuant
       Endif
       Skip
       wCont++
       If wCont >5
          Exit
       Endif
     Enddo
     Sele 141
     Use

     SetColor("gr+/b")
     @ 13,50 Say "Cinco Produtos Mais Vendidos"
     @ 15,50 Say "C¢digo Descr Produto     Qtde"
     SetColor("w+/b")
     @ 14,50 to 14,78
     @ 16,50 to 16,78
     @ 17,50 Say Strzero(wCodi_1,6)+" "+Substr(wProd_1,1,16)+"  "+Strzero(wQtde_1,4)
     @ 18,50 Say Strzero(wCodi_2,6)+" "+Substr(wProd_2,1,16)+"  "+Strzero(wQtde_2,4)
     @ 19,50 Say Strzero(wCodi_3,6)+" "+Substr(wProd_3,1,16)+"  "+Strzero(wQtde_3,4)
     @ 20,50 Say Strzero(wCodi_4,6)+" "+Substr(wProd_4,1,16)+"  "+Strzero(wQtde_4,4)
     @ 21,50 Say Strzero(wCodi_5,6)+" "+Substr(wProd_5,1,16)+"  "+Strzero(wQtde_5,4)
     Release wCodi_1,wCodi_2,wCodi_3,wCodi_4,wCodi_5,wQtde_1,wQtde_2,wQtde_3,wQtde_4,wQtde_5
     Release wProd_1,wProd_2,wProd_3,wProd_4,wProd_5,wCont,wQuant
     wCont = 1

 wArq = "index_&mains.&arqenvi"+".."+"cdx"
 If File("&wArq")
    DeleteFile("&wArq")
 Endif
 wArq = "i_&mains.&arqenvi"+".."+"cdx"
 If File("&wArq")
    DeleteFile("&wArq")
 Endif
 If File("mains.&arqenvi")
    DeleteFile("mains.&arqenvi")
 Endif
 If File("wmains.&arqenvi")
    DeleteFile("wmains.&arqenvi")
 Endif
 Release w_uteis,m_cota,w_perc,w_cotaut,w_faltam,w_vdia,m_bk,m_book,t_bk,t_combk
 Release SIGA,P_PAGI,LIN,M_ITEN,TOTVEND,TOTCOM,T_GR,T_COMGR,M_V,COMISSAO,M_DEBITO,TOTDES,X_TOTDES
 Release M_ADTO,M_DAT1,M_DAT2,M_GARAN,M_GR,M_GRC,T_GR,T_COMGR,M_V,MVE,NOMEV,X,M_QTDE,NRESP,M_GR
 Release wItem,wNota,wSerie,wData,t_comt,arqenvi,wEficiencia
 Inkey(0)
Return

//*****************
  Function ValorDeb(wCod,wDatai,wDataf)
//******************
 Local wRet
 wRet = 0
 Sele 130
 Set Order to 1
 Go Top
 While .t.
  Seek Str(wCod,3,0)+substr(dtoc(wDatai),7,4)+substr(dtoc(wDatai),4,2)+substr(dtoc(wDatai),1,2)
  If Eof()
     wDatai++
     If wDatai > wDataf
        Exit
     Endif
  Else
     Exit
  Endif
 Enddo
 While !Eof() .and. ba_codi = wCod .and. ba_data <= wDataf
   wRet = wRet + ba_debito
   Skip
 Enddo
Return(wRet)

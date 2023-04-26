//**********************************************************
/*
   FILE NAME : Comvendas.PRG
   BY        : HELIO-SP
   DESC      : RELATORIO DE COMISSOES DE VENDAS POR VENDEDOR
*/
//**********************************************************
#include "migracao.ch"

Procedure Comvendas()

 R_tela = SAVESCREEN(0,0,24,79)
 SET COLOR TO
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
 R_TELA=SAVESCREEN(0,0,24,79)
 SETCOLOR(C_CORG)
 @ 00,00 clear to 24,79
 @ 00,00  to 24,79
 @ 01,20 SAY 'COMISS”ES DE VENDAS / VENDEDORES '
 SETCOLOR("W+/B+")
 @ 02,01 SAY 'C¢d Vendedor  Depto      Vendas  D‚b.Com Comissoes Gr.Est.  Com 5% TT(Com-D‚b)'
 Relax1 =1
 m_detal = 2
 If LASTKEY() = 27
    SET COLOR TO
    RESTSCREEN(0,0,24,79,R_tela)
    Release m_detal,R_tela
    Return
 ENDIF

 Sele 130
 Veriout(SETCOLOR(),23,"debitocom")
 Set Index to index_debitocom

 While .T.
  /*
  SELE 16
  SET ORDER TO 1
  GO TOP
  M_VEND=BA_CODI
  GO BOTT
  M_VENDF=BA_CODI
  GOTO TOP
  SET CURSOR ON
  SETCOLOR(C_CORG)
 */
  m_vend = Vend3
  m_vendf= Vend3
  PR=SAVESCREEN(15,22,17,61)
  /*
  SETCOLOR(C_CORG)
  SOMBRA(15,22,17,60,BOX)
  @ 15,29 SAY " Entre com C¢d.Vendedor"
  @ 16,24 SAY 'C¢d.Ini:' GET M_VEND  PICT '999'
  @ 16,42 SAY 'C¢d.Fin:' GET M_VENDF PICT '999'
  Read
  IF LASTKEY() = 27
     SET COLOR TO
     RESTSCREEN(0,0,24,79,R_tela)
     Sele 130
     Use
     RETURN
  ENDIF
  */
  SELE 16
  SET ORDER TO 1
  GOTO TOP
  SEEK STR(M_VEND,3,0)
  IF EOF()
     FRASE2(22,"C¢digo inicial n„o existe... Por favor verifique.",4,,,C_CORG)
     SAVESCREEN(15,22,17,61,PR)
     Return
  ENDIF

  wMeses = Month(m_datsi)
  @ 15,02 Say "Mes"
  SOMBRA(16,02,18,15,BOX)
  @ 17,03 prom "Janeiro  "
  @ 17,03 prom "Fevereiro"
  @ 17,03 prom "Marco    "
  @ 17,03 prom "Abril    "
  @ 17,03 prom "Maio     "
  @ 17,03 prom "Junho    "
  @ 17,03 prom "Julho    "
  @ 17,03 prom "Agosto   "
  @ 17,03 prom "Setembro "
  @ 17,03 prom "Outubro  "
  @ 17,03 prom "Novembro "
  @ 17,03 prom "Dezembro "
  Menu to wMeses
  If Lastkey() = 27
     RESTSCREEN(0,0,24,79,R_tela)
     Return
  Endif
  wAno = Year(M_Datsi)
  SOMBRA(19,02,23,25,BOX)
  @ 20,03 Say "Ano"Get wAno pict "9999"
  Read
  wAno=Str(wAno)
  If wMeses = 1
     w_dt  = "01/01/"+wAno
     m_dat1 = ctod(w_dt)
     w_dt  = "31/01/"+wAno
     m_dat2 = ctod(w_dt)
  ElseIf wMeses = 2
     wMes = "FEVEREIRO"
     mes_ = "02"
     w_dt  = "01/02/"+wAno
     m_dat1 = ctod(w_dt)
     w_dt  = "28/02/"+wAno
     m_dat2 = ctod(w_dt)
  ElseIf wMeses = 3
     w_dt  = "01/03/"+wAno
     m_dat1 = ctod(w_dt)
     w_dt  = "31/03/"+wAno
     m_dat2 = ctod(w_dt)
  ElseIf wMeses = 4
     w_dt  = "01/04/"+wAno
     m_dat1 = ctod(w_dt)
     w_dt  = "30/04/"+wAno
     m_dat2 = ctod(w_dt)
  ElseIf wMeses = 5
     w_dt  = "01/05/"+wAno
     m_dat1 = ctod(w_dt)
     w_dt  = "31/05/"+wAno
     m_dat2 = ctod(w_dt)
  ElseIf wMeses = 6
     w_dt  = "01/06/"+wAno
     m_dat1 = ctod(w_dt)
     w_dt  = "30/06/"+wAno
     m_dat2 = ctod(w_dt)
  ElseIf wMeses = 7
     w_dt  = "01/07/"+wAno
     m_dat1 = ctod(w_dt)
     w_dt  = "31/07/"+wAno
     m_dat2 = ctod(w_dt)
  ElseIf wMeses = 8
     w_dt  = "01/08/"+wAno
     m_dat1 = ctod(w_dt)
     w_dt  = "31/08/"+wAno
     m_dat2 = ctod(w_dt)
  ElseIf wMeses = 9
     w_dt  = "01/09/"+wAno
     m_dat1 = ctod(w_dt)
     w_dt  = "30/09/"+wAno
     m_dat2 = ctod(w_dt)
  ElseIf wMeses = 10
     w_dt  = "01/10/"+wAno
     m_dat1 = ctod(w_dt)
     w_dt  = "31/10/"+wAno
     m_dat2 = ctod(w_dt)
  ElseIf wMeses = 11
     w_dt  = "01/11/"+wAno
     m_dat1 = ctod(w_dt)
     w_dt  = "30/11/"+wAno
     m_dat2 = ctod(w_dt)
  ElseIf wMeses = 12
     w_dt  = "01/12/"+wAno
     m_dat1 = ctod(w_dt)
     w_dt  = "31/12/"+wAno
     m_dat2 = ctod(w_dt)
  Endif
  @ 21,03 Say "Data Inical"Get m_dat1
  @ 22,03 Say "Data Final "Get m_dat2
  Read

   M_Mes = (M_DAT2 - M_DAT1) /30
   If M_Mes = 0 .or. M_Mes < 1
      M_Mes = 1
   Endif

   @ 20,02 clear to 23,55

   M_DATX = M_DAT1
   P_TITU = "Vendas/Comiss”es " + DATAEXT(M_DAT1) + " a " + DATAEXT(M_DAT2)

   @ 24,10 SAY "Verificando,Aguarde..."+p_titu

   Sele 53
   Exit
 Enddo
   SETCOLOR(C_CORG)
   @ 06,01 clear to 20,78
   M_SETOR ="MOV/ELE"
   SIGA    ="S"
   P_PAGI  = 1
   LIN     = 3
   Stor 0 to M_ITEN,T_FATU,T_COMI,T_GERALC,T_GERAL,TOTVEND,T_COMIS,T_FERI,TOTCOM,T_GR,T_COMGR
   Stor 0 to M_AVISTA,M_CHEQ,M_APRAZO,M_FINANC,M_CARTAO,m_eletri,T_COMT
   Stor 0 to w_AVISTA,w_CHEQ,w_APRAZO,w_FINANC,w_CARTAO
   Stor 0 to m_grp_1,m_grp_2,m_grp_3,m_grp_4,m_grp_5,m_grp_7,m_grp_8
   Stor 0 to w_grp_1,w_grp_2,w_grp_3,w_grp_4,w_grp_5,w_grp_7,w_grp_8
   Stor 0 to C_AVISTA,C_CHEQ,C_APRAZO,C_FINANC,C_CARTAO
   Stor 0 to c_grp_1,c_grp_2,c_grp_3,c_grp_4,c_grp_5,c_grp_7,c_grp_8
   Stor 0 to c_rent_1,c_rent_2,c_rent_3,c_rent_4,c_rent_5,c_rent_7,c_rent_8
   Stor 0 to M_RENT_E,M_ELETRI,C_ELETRI,T_BK,T_COMBK,T_BK_DEL
   Stor 0 to w50,w70,w90,w99,wMinutas

   PRIV M_ACHE[900]
   NOMEV= ""
   X    = 1
   M    = "001"

   If m_detal = 2
      Sele 131
      Exclout(SETCOLOR(),23,"vendasdetalhe")
      Zap
      Use
      Sele 131
      Veriout(SETCOLOR(),23,"vendasdetalhe")
      wTotalVdas:=Ret_VendasT(m_dat1,m_dat2)    // Neste Prg
   Endif
Sele 16
Set Order to 1
While !Eof() .AND. SIGA = 'S' .AND. PROW() < 58 .AND. IF(M_VENDF > 0,M_VEND <= M_VENDF,.T.)

     SET DEVI TO SCREE
     ESC = INKEY()
     ESCPRINT(ESC,22)

     Sele 4
     Set Order to 5
     Go Top
     SET DEVI TO SCREEN

     Stor 0 to M_V,M_C,TOTDES,X_TOTDES,M_M,TOTCOM,M_GARAN,M_GR,G_TVENDA,G_TCUSTO
     Stor 0 to M_book,M_book_del
     Stor 0 to w_grp_1,w_grp_2,w_grp_3,w_grp_4,w_grp_5,w_grp_7,w_grp_8
     Stor 0 to c_rent_1,c_rent_2,c_rent_3,c_rent_4,c_rent_5,c_rent_7,c_rent_8
     Stor 0 to w_AVISTA,w_CHEQ,w_APRAZO,w_FINANC,w_CARTAO
     Stor 0 to w_eletri

     While .T.
       Seek STR(M_VEND,3,0)+SUBSTR(DTOC(M_DAT1),7,4)+SUBSTR(DTOC(M_DAT1),4,2)+SUBSTR(DTOC(M_DAT1),1,2)
       IF EOF()
          M_DAT1++
          IF M_DAT1 >M_DAT2
             M_VEND++
             M_DAT1=M_DATX
             IF M_VEND >M_VENDF
                EXIT
             ENDIF
          ENDIF
       Else
          Exit
       Endif
     Enddo
     If !Eof()
        Sele 16
        Set Order to 1
        Seek Str(m_vend,3,0)
        NOMEV = Substr(Ba_Partic,1,20)     // Nome completo do vendedor
        If Empty(NOMEV)
           NOMEV = Ba_Nome
        Endif
        Sele 4
        Set Order to 5
     Endif
     wQtdeItens = 0
     wQtdeMin   = 0
     While !Eof() .AND. SD_VEND=M_VEND .AND. SD_DATA<=M_DAT2
      Stor 0 to m_ve
      If sd_prec >0
         M_V   = M_V + (SD_QTDE * SD_PREC)  && QUANTIDADE x UNITARIO VENDA
         M_VE  = (SD_QTDE * SD_PREC)
         M_C     = M_C + (SD_QTDE * SD_CUSTO)     && QUANTIDADE x UNITARIO CUSTO
         G_TVENDA= G_TVENDA + M_VE
         G_TCUSTO= G_TCUSTO + (SD_QTDE * SD_CUSTO)
      Endif
 
      wQtdeItens = wQtdeItens + SD_Qtde
      wItem = Val(sd_contad)
      wNota = sd_nota
      wSerie= sd_seri
      wData = sd_data
      W_Pass= "N"

      If m_ve >0
         If SD_TIPO = 1 .or. SD_TIPO = 7 .OR. SD_TIPO = 8
            m_avista = m_avista + M_VE
            w_avista = w_avista + M_VE
            c_avista = c_avista + (SD_QTDE * SD_CUSTO)
         Elseif SD_TIPO = 2
            m_cheq = m_cheq + M_VE
            w_cheq = w_cheq + M_VE
            c_cheq = c_cheq + (SD_QTDE * SD_CUSTO)
         Elseif SD_TIPO = 3 .or. SD_TIPO = 6
            m_aprazo = m_aprazo + M_VE
            w_aprazo = w_aprazo + M_VE
            c_aprazo = c_aprazo + (SD_QTDE * SD_CUSTO)
         Elseif SD_TIPO = 4 .or. sd_tipo = 9 .or. sd_tipo = 10
            m_financ = m_financ + M_VE
            w_financ = w_financ + M_VE
            c_financ = c_financ + (SD_QTDE * SD_CUSTO)
         Elseif SD_TIPO = 5
            m_cartao = m_cartao + M_VE
            w_cartao = w_cartao + M_VE
            c_cartao = c_cartao + (SD_QTDE * SD_CUSTO)
         Endif
         Sele 3
         Set Order to 1
         Seek CDSAID->SD_CODI
         If !Eof()
             M_SBGRUP=CD_SBGRUP
             Sele 43
             Set Order to 1
             Seek M_SBGRUP
             If !Eof() .and. GR_Comi > 0
                Sele 4
                Set Order to 5
                m_eletri = m_eletri + M_VE
                w_eletri = w_eletri + M_VE
                c_eletri = c_eletri + (SD_QTDE * SD_CUSTO)
                W_Pass = "S"
             Endif
         Endif
      Endif
      Sele 53           // Mobile Cursos
      Set Order to 1
      Seek str(wNota,8,0)+substr(wSerie,1,3)
      wPss = "n"
      While !Eof() .and. minuta = wNota .and. serie = wSerie
        If data_venda = wdata .and. vendedor = m_vend .and. status = "V" .and. ITEM = wItem
           wPss = "s"
           M_book = m_book + valor_vend
        ElseIf data_venda = wdata .and. vendedor = m_vend .and. status = "C" .and. ITEM = wItem
           wPss = "s"
           M_book_del = m_book_del + valor_vend
        Endif
        Skip
       Enddo
       If wPss = "s"
          m_bk   = ( ( m_book * 5 ) / 100 )
          t_combk= t_combk + m_bk
       Endif

       Sele 4
       Set Order to 5
       If W_Pass = "N" .and. m_ve >0                 // Por causa da Rentabilidade
          If sd_grup = 1
             m_grp_1  = m_grp_1  + M_VE
             w_grp_1  = w_grp_1  + M_VE
             c_grp_1  = c_grp_1  + (SD_QTDE * SD_CUSTO)
             c_rent_1 = c_rent_1 + (SD_QTDE * SD_CUSTO)
          ElseIf sd_grup = 2
             m_grp_2  = m_grp_2  + M_VE
             w_grp_2  = w_grp_2  + M_VE
             c_grp_2  = c_grp_2  + (SD_QTDE * SD_CUSTO)
             c_rent_2 = c_rent_2 + (SD_QTDE * SD_CUSTO)
          ElseIf sd_grup = 3 .or. sd_grup = 5 .or. sd_grup = 15 .or. sd_grup = 16 .or. sd_grup = 17
             m_grp_3  = m_grp_3  + M_VE
             w_grp_3  = w_grp_3  + M_VE
             c_grp_3  = c_grp_3  + (SD_QTDE * SD_CUSTO)
             c_rent_3 = c_rent_3 + (SD_QTDE * SD_CUSTO)
          ElseIf sd_grup = 4
             m_grp_4  = m_grp_4  + M_VE
             w_grp_4  = w_grp_4  + M_VE
             c_grp_4  = c_grp_4  + (SD_QTDE * SD_CUSTO)
             c_rent_4 = c_rent_4 + (SD_QTDE * SD_CUSTO)
          ElseIf sd_grup = 7
             m_grp_7  = m_grp_7  + M_VE
             w_grp_7  = w_grp_7  + M_VE
             c_grp_7  = c_grp_7  + (SD_QTDE * SD_CUSTO)
             c_rent_7 = c_rent_7 + (SD_QTDE * SD_CUSTO)
          ElseIf sd_grup = 8
             m_grp_8  = m_grp_8  + M_VE
             w_grp_8  = w_grp_8  + M_VE
             c_grp_8  = c_grp_8  + (SD_QTDE * SD_CUSTO)
             c_rent_8 = c_rent_8 + (SD_QTDE * SD_CUSTO)
          Endif
       Endif
       Stor 0 to X_TOTVEND,TOTVEND,COMI1
       If m_ve >0
          TOTDES    = SD_TDESCO
          X_TOTDES  = X_TOTDES + SD_TDESCO
          X_TOTVEND = M_V  - TOTDES
          TOTVEND   = M_VE - TOTDES             && TOTAL COMISSOES POR VENDA
          If Trim(sd_nome) = "ATACADO"
             wComVenda = 0
          Else
             wComVenda = SD_COMI
          Endif
          COMI1  = (TOTVEND * wComVenda)/100
          TOTCOM = TOTCOM + COMI1
          @ LIN,01 SAY STRZERO(SD_VEND,3)
          @ LIN,05 SAY SUBSTR(NOMEV,1,20)
          @ LIN,26 SAY M_V - TOTDES PICT '@E 9,999,999.99'
       Endif
       SKIP
       If Sd_Nota <> wNota .and. !Eof()
          wQtdeMin++
       Endif
     Enddo
     ******************** COMISSOES DE GARANTIA ESTENDIDA **************************
     M_DAT1=M_DATX
     Sele 35                      //DBF de Garantia Estendida
     Set Order to 3
     While .t.
       Seek SUBSTR(DTOC(M_DAT1),7,4)+SUBSTR(DTOC(M_DAT1),4,2)+SUBSTR(DTOC(M_DAT1),1,2)+STR(M_VEND,3,0)
       If Eof()
          M_DAT1=M_DAT1+1
          If M_DAT1 >M_DAT2
             Exit
          Endif
       Else
          Exit
       Endif
     Enddo
     IF M_Vend >M_VendF
        Exit
     Endif
     m_ps  = "n"
     m_grc = 5      // 5% Comissoes para os vendedores de Garantia Estendida
     While !Eof()
       If gr_data <= m_dat2 .and. gr_vende=m_vend .and. gr_status = "V"
          m_garan = m_garan+gr_fator
          m_ps = "s"
       Endif
       Skip
     Enddo
     If m_ps ="s"
        m_gr   = ( ( m_garan * m_grc ) / 100 )
        t_gr   = t_gr + m_garan
        t_comgr= t_comgr + m_gr
     Endif
 **********************DEBITOS DE COMISSOES E ADTOS. **************************
 Stor 0 to M_DEBITO,COMISSAO

  M_DEBITO := ValorDeb(m_vend,m_datx,m_dat2)    //BALC1.PRG

  Sele 4
  Set Order to 5
  Go Top

  M_UTEIS  = TOTCOM / I_UTEIS
  M_FERI   = M_UTEIS * (I_FERI+I_DESCA)
  M_M      = M_FERI + TOTCOM
  M_V      = M_V - X_TOTDES
  COMISSAO = M_M - M_DEBITO
  IF M_V >0
     m_v = m_v - m_book
     @ LIN,26 SAY M_V          PICT '@E 9,999,999.99'  && VENDAS
     @ LIN,41 SAY (M_V/M_MES)  PICT '@E 9,999,999.99'  && MEDIA DE VENDAS
     @ LIN,54 SAY M_DEBITO     PICT '@E 9,999,999.99'  && DEBITO DE COMISSAO
     @ LIN,66 SAY COMISSAO     PICT '@E 9,999,999.99'  && VALOR DE COMISSOES

     W_PERC   = ((M_GARAN+M_BOOK)*5)/100
     t_bk     = t_bk + m_book
     T_BK_DEL = T_BK_DEL + m_book_del
     t_comt   = t_comt + W_PERC

     M_ACHE[&M]=STRZERO(M_VEND,3)+" "+SUBSTR(NOMEV,1,15)+" "+STR(M_V,11,2)+" "+STR(M_DEBITO,8,2)+" "+STR(COMISSAO+M_DEBITO,9,2)+"³"+str(m_garan+m_book,8,2)+" "+str(W_PERC,7,2)+" "+STR((W_PERC+comissao),10,2)
     M = STRZERO(VAL(M)+1,3,0)

     If Trim(NOMEV) <> "ATACADO"
        If m_v < 50000
           w50++
        ElseIf m_v >= 50000 .and. m_v < 70000
           w70++
        ElseIf m_v >= 70000 .and. m_v < 90000
           w90++
        ElseIf m_v > 90000
           w99++
        Endif
     Endif

     If M_Detal = 2
        M_ACHE[&M]= Str(((w_avista/m_v)*100),6,2)+"%"+" "+Str(((w_cheq/m_v)*100),6,2)+"%"+" "+Str(((w_aprazo/m_v)*100),6,2)+"%"+" "+Str(((w_financ/m_v)*100),6,2)+"%"+" "+Str(((m_cartao/m_v)*100),6,2)+"%"
        t_medio = (m_v/wQtdeMin)
        w_cpfs  = wQtdeMin
        wMinutas = wMinutas + wQtdeMin

        wPrMedio= (m_v/wQtdeItens)
        M_ACHE[&M]= " "
        M = STRZERO(VAL(M)+1,3,0)
        M_ACHE[&M] = "Vda Mercantil  Qt Vdas Qt Itens   Servicos CPF's Atend Ticket Medio  Pr Med It"
        M = STRZERO(VAL(M)+1,3,0)
        M_ACHE[&M]=Str(M_V,12,2)+" "+Str(wQtdeMin,7)+" "+Str(wQtdeItens,7)+" "+Str(M_Garan,12,2)+" "+Str(w_Cpfs,8)+"   "+Str(t_medio,11,2)+"   "+Str(wPrMedio,11,2)
        M = STRZERO(VAL(M)+1,3,0)
        M_ACHE[&M]= " "
        M = STRZERO(VAL(M)+1,3,0)
        M_ACHE[&M]= " Som /Imagem     Frios    Eletros  Eletrinho     Moveis  Informatica   Celular"
        M = STRZERO(VAL(M)+1,3,0)
        M_ACHE[&M]= Str(w_grp_1,11,2)+""+Str(w_grp_2,11,2)+""+Str(w_grp_3,11,2)+""+Str(w_eletri,11,2)+" "+Str(w_grp_4,11,2)+""+Str(w_grp_7,11,2)+""+Str(w_grp_8,11,2)
        M = STRZERO(VAL(M)+1,3,0)
        M_ACHE[&M]= Space(04)+Str(((w_grp_1 /m_v)*100),6,2)+"%"+"    "+Str(((w_grp_2 /m_v)*100),6,2)+"%"+"    "+Str(((w_grp_3 /m_v)*100),6,2)+"%"+"    "+Str(((w_eletri/m_v)*100),6,2)+"%"+"     "+Str(((w_grp_4 /m_v)*100),6,2)+"%"+"    "+Str(((w_grp_7 /m_v)*100),6,2)+"%"+"    "+Str(((w_grp_8 /m_v)*100),6,2)+"%"
        M = STRZERO(VAL(M)+1,3,0)
        M_ACHE[&M]= " "
        M = STRZERO(VAL(M)+1,3,0)
        M_ACHE[&M]="     A vista       Cheque      Carnet        Financ       Cartao"
        M = STRZERO(VAL(M)+1,3,0)
        M_ACHE[&M]= Str(w_avista,12,2)+" "+Str(w_cheq,12,2)+" "+Str(w_aprazo,12,2)+" "+Str(w_financ,12,2)+" "+Str(w_cartao,12,2)
        M = STRZERO(VAL(M)+1,3,0)
        M_ACHE[&M]= Str(((w_avista/m_v)*100),6,2)+"%"+" "+Str(((w_cheq/m_v)*100),6,2)+"%"+" "+Str(((w_aprazo/m_v)*100),6,2)+"%"+" "+Str(((w_financ/m_v)*100),6,2)+"%"+" "+Str(((w_cartao/m_v)*100),6,2)+"%"
        M_ACHE[&M]= " "
        M = STRZERO(VAL(M)+1,3,0)

        M_RENT = ((G_TVENDA-G_TCUSTO)/G_TVENDA)*100
        M_ACHE[&M] = "Rentabilidade: "+Str(M_Rent,7,2)
        M = STRZERO(VAL(M)+1,3,0)
        M_ACHE[&M]= REPL("Í",78)

        Sele 131
        If Adireg(0)
           Repl Loja with I_fili+" "+Trim(Lojax),Vendedor with STRZERO(M_VEND,3)+" "+SUBSTR(NOMEV,1,15)
        Endif
        If Adireg(0)
           Repl Vda_Mercan with m_v,Qtde_Venda with wQtdeMin,Qtde_Itens with wQtdeItens,Servicos with M_Garan,;
                CPFS_Atend with w_Cpfs,Ticket_Med with t_medio,Pr_Med_Vda with wPrMedio
        Endif
        If Adireg(0)
           Repl Som_Imagem with w_grp_1,Frios with w_grp_2,Eletros with w_grp_3,Eletrinhos with w_eletri,;
                Moveis with w_grp_4,Informatic with w_grp_7,Celulares with w_grp_8
        Endif
        If Adireg(0)
           Repl A_Vista with w_avista,Cheque with w_cheq,Carne with w_aprazo,Financeira with w_financ,Cartao with w_cartao
        Endif
     Endif
     Stor 0 to m_bk
     M = STRZERO(VAL(M)+1,3,0)
  ENDIF

  T_FATU  = T_FATU   + M_V
  T_COMI  = T_COMI   + M_DEBITO
  T_GERAL = T_GERAL  + COMISSAO
  T_GERALC= T_GERALC + COMISSAO+M_DEBITO
  T_COMIS = T_COMIS  + TOTCOM
  T_FERI  = T_FERI   + M_FERI

  LIN ++
  IF LIN > 18
     LIN = 18
     SCROLL(03,01,18,78,1)
  ENDIF

  SET DEVI TO SCREEN
  ESC = INKEY()
  ESCPRINT(ESC,22)

  M_DAT1=M_DATX
  M_VEND++
ENDDO
 Sele 130
 Use
 Sele 131
 Use
 IF RELAX1 = 1
   SET DEVI TO SCREEN
   lin=18
   @ lin,20 SAY repl ('_',59)
   lin=lin+1
   @ lin,18 SAY T_FATU    PICT '@E 999,999,999.99'    && VENDAS
   @ lin,32 SAY T_COMI    PICT '@E 99,999.99'         && DEBITO DE COMISSAO
   @ lin,42 SAY T_COMIS   PICT '@E 99,999.99'         && VALOR DE COMISSOES
   @ lin,53 SAY T_GR+T_BK PICT '@E 99999.99'          && VALOR DE Garantias
   @ lin,62 SAY T_comT    PICT '@E 9999.99'           && VALOR DE Comissoes de Garantia
   @ lin,68 SAY T_comT+T_geral PICT '@E 9999,999.99'  && VALOR DE Comissoes de Garantia+comisoes normais
   lin++
  /*
   @ lin,02 SAY "Mobile Cursos"
   @ lin,18 SAY T_BK+T_BK_DEL  PICT '@E 999,999,999.99'    && Cursos On Line
   If T_BK_DEL >0
      lin++
      @ lin,02 SAY "Cancelados"
      @ lin,18 SAY T_BK_DEL       PICT '@E 999,999,999.99'    && Cursos On Line
   Endif
   lin++
   @ lin,18 SAY T_FATU+T_BK   PICT '@E 999,999,999.99'    && Cursos On Line
   If t_gr >0 .or. t_bk >0
      t_gr = t_gr + t_bk
      @ 23,02 SAY "2% Gerente s/G.Estendidas/  Cursos  "
      @ 23,37 SAY  ( t_gr * 2 ) / 100 Pict "@e 999,999.99"
      @ 23,52 SAY ((t_gr-t_bk) / t_fatu) * 100 pict "999.99"+" %"
      @ 24,02 SAY "1% Supervisor s/G.Estendidas /Cursos"
      @ 24,37 SAY  ( t_gr * 1 ) / 100 Pict "@e 999,999.99"
   Endif
  */
   SETCOLOR("W+/BG, B/RG,X")
   M_OPCA = ACHOICE(03,01,18,78,M_ACHE)
   RELEASE ALL LIKE M_ACH*

   Padrao()  //cores
   MOV_LINHA := 6; MOV_COLUNA := 9
   JANELA( MOV_LINHA, MOV_COLUNA, MOV_LINHA + 12, MOV_COLUNA + 61, "Resumo por faixa de faturamento" )
   SETCOLOR( CONTECOR[ 11 ] + "," + CONTECOR[ 9 ] + ",,," + CONTECOR[ 8 ] )
   @ 08,16 Say " Vendedores Acima de       90.000  [   ]"
   @ 10,16 Say "            Entre 70.000 e 89.999  [   ]"
   @ 12,16 Say "            Entre 50.000 e 69.999  [   ]"
   @ 14,16 Say "            Abaixo de      50.000  [   ]"
   @ 16,16 Say "            Vendas Atendidas    [      ]"

   SETCOLOR( CONTECOR[ 2 ] + "," + CONTECOR[ 3 ] + ",,," + CONTECOR[ 2 ] )
   @ 08,52 say Strzero(w99,3)
   @ 10,52 say Strzero(w90,3)
   @ 12,52 say Strzero(w70,3)
   @ 14,52 say Strzero(w50,3)
   @ 16,49 say Strzero(wminutas,6)
   inkey(0)

   svtela=Savescreen(16,00,23,79)

   SETCOLOR("gr+/BG, B/RG,X")
   Sombra(16,00,23,79,Box)
   @ 17,01 say "Som /Imagem       Frios    Eletros  Eletrinho      Moveis Informatica  Celular"
   SETCOLOR("w+/BG, B/RG,X")
   @ 18,01    say m_grp_1    pict "@e 9999,999.99"
   @ 18,col() say m_grp_2    pict "@e 9999,999.99"
   @ 18,col() say m_grp_3    pict "@e 9999,999.99"
   @ 18,col()+1 say m_eletri pict "@e 9999,999.99"
   @ 18,col()+1 say m_grp_4  pict "@e 9999,999.99"
   @ 18,col()+1 say m_grp_7  pict "@e 9999,999.99"
   @ 18,col() say m_grp_8    pict "@e 9999,999.99"
   @ 19,08 say ((m_grp_1 /t_fatu)*100) pict "@e 999.99"+"%"
   @ 19,19 say ((m_grp_2 /t_fatu)*100) pict "@e 999.99"+"%"
   @ 19,29 say ((m_grp_3 /t_fatu)*100) pict "@e 999.99"+"%"
   @ 19,40 say ((m_eletri/t_fatu)*100) pict "@e 999.99"+"%"
   @ 19,52 say ((m_grp_4 /t_fatu)*100) pict "@e 999.99"+"%"
   @ 19,64 say ((m_grp_7 /t_fatu)*100) pict "@e 999.99"+"%"
   @ 19,72 say ((m_grp_8 /t_fatu)*100) pict "@e 999.99"+"%"
   SETCOLOR("gr+/BG, B/RG,X")
   @ 20,03 say "      A vista       Cheque        Carnet         Financ         Cartao"
   SETCOLOR("w+/BG, B/RG,X")
   @ 21,03 say m_avista pict "@e 99,999,999.99"
   @ 21,16 say m_cheq   pict "@e 99,999,999.99"
   @ 21,30 say m_aprazo pict "@e 99,999,999.99"
   @ 21,45 say m_financ pict "@e 99,999,999.99"
   @ 21,60 say m_cartao pict "@e 99,999,999.99"
   @ 22,10 say ((m_avista/t_fatu)*100) pict "@e 999.99"+"%"
   @ 22,23 say ((m_cheq/t_fatu)*100)   pict "@e 999.99"+"%"
   @ 22,37 say ((m_aprazo/t_fatu)*100) pict "@e 999.99"+"%"
   @ 22,52 say ((m_financ/t_fatu)*100) pict "@e 999.99"+"%"
   @ 22,67 say ((m_cartao/t_fatu)*100) pict "@e 999.99"+"%"
   Inkey(0)
   M_RENT_1 = ((M_GRP_1-C_GRP_1)/M_GRP_1)*100
   M_RENT_2 = ((M_GRP_2-C_GRP_2)/M_GRP_2)*100
   M_RENT_3 = ((M_GRP_3-C_GRP_3)/M_GRP_3)*100
   M_RENT_4 = ((M_GRP_4-C_GRP_4)/M_GRP_4)*100
   M_RENT_7 = ((M_GRP_7-C_GRP_7)/M_GRP_7)*100
   M_RENT_8 = ((M_GRP_8-C_GRP_8)/M_GRP_8)*100
   M_RENT_E = ((M_ELETRI-C_ELETRI)/M_ELETRI)*100
   @ 18,02 Clear to 19,79
   @ 18,03 Say "Rentabilidade.............."
   @ 19,06 say m_RENT_1 pict "@e 999.99"+"%"
   @ 19,18 say m_RENT_2 pict "@e 999.99"+"%"
   @ 19,29 say m_RENT_3 pict "@e 999.99"+"%"
   @ 19,40 say m_RENT_E pict "@e 999.99"+"%"
   @ 19,52 say m_RENT_4 pict "@e 999.99"+"%"
   @ 19,63 say m_RENT_7 pict "@e 999.99"+"%"
   @ 19,72 say m_RENT_8 pict "@e 999.99"+"%"
   @ 21,03 Clear to 22,76
   M_RENT_1 = ((M_AVISTA-C_AVISTA)/M_AVISTA)*100
   M_RENT_2 = ((M_CHEQ-C_CHEQ)/M_CHEQ)*100
   M_RENT_3 = ((M_APRAZO-C_APRAZO)/M_APRAZO)*100
   M_RENT_4 = ((M_FINANC-C_FINANC)/M_FINANC)*100
   M_RENT_5 = ((M_CARTAO-C_CARTAO)/M_CARTAO)*100
   @ 21,03 Say "Rentabilidade.............."
   @ 22,10 say m_RENT_1 pict "@e 999.99"+"%"
   @ 22,23 say m_RENT_2 pict "@e 999.99"+"%"
   @ 22,37 say m_RENT_3 pict "@e 999.99"+"%"
   @ 22,52 say m_RENT_4 pict "@e 999.99"+"%"
   @ 22,67 say m_RENT_5 pict "@e 999.99"+"%"
 ENDIF
 SET DEVI TO SCREEN
 Restscreen(16,00,23,79,svtela)
 Release M_TTCUSTO,M_TTVENDA,SIGA,P_PAGI,LIN,M_ITEN,T_FATU,T_COMI,T_ADTO,T_GERAL,M_DAT1,M_DAT2,M_RENT
 Release T_COMIS,TOTCOM,T_GR,T_COMGR,NOMEV,X,X_TOTVEND,TOTVEND,COMI1,M_V,M_VE,M_C,wItem,wPss,wdata
 Release M_AVISTA,M_CHEQ,M_APRAZO,M_FINANC,M_CARTAO,m_eletri,C_ELETRI,wNota,wSerie,m_book_del
 Release m_grp_1,m_grp_2,m_grp_3,m_grp_4,m_grp_5,m_grp_7,m_grp_8,T_COMT,T_BK_DEL,t_medio,w_cpfs,wPrMedio
 Release C_AVISTA,C_CHEQ,C_APRAZO,C_FINANC,C_CARTAO,M_book,M_bk,t_bk,t_combk,svtela
 Release c_grp_1,c_grp_2,c_grp_3,c_grp_4,c_grp_5,c_grp_7,c_grp_8,w50,w70,w90,w99
 Release M_RENT_1,M_RENT_2,M_RENT_3,M_RENT_4,M_RENT_5,M_RENT_7,M_RENT_8,M_GR,G_TVENDA,G_TCUSTO,M_C
/*
 If M_Detal = 2
    EnviaEmailV()
 Endif
*/
Return

//********************
  Function Ret_VendasT(wDt1,wDt2,wVended)
//********************
 Stor 0 to wTotalVdas
 Sele 4
 Set Order to 8
 While .T.
   Seek SUBSTR(DTOC(wDt1),7,4)+SUBSTR(DTOC(wDt1),4,2)+SUBSTR(DTOC(wDt1),1,2)
   IF Eof()
      wDt1++
      IF wDt1 > wDt2
         Exit
      Endif
   Else
      Exit
   Endif
 Enddo
 While !Eof() .and. SD_Data <= wDt2
   If sd_prec >0 .and. sd_codi >5
      If wVended <> Nil
         If sd_vend = wVended
            wTotalVdas = wTotalVdas + (SD_QTDE * SD_PREC)
         Endif
      Else
         wTotalVdas = wTotalVdas + (SD_QTDE * SD_PREC)
      Endif
   Endif
   Skip
 Enddo
Return(wTotalVdas)

//********************
  Function EnviaEmailV
//********************
 wMes := Ret_NomeMes(m_datx)
 wAno := Substr(Str(Year(m_datx)),4,2)
 wDestinatario ="ilivelton@sucessoemvendas.com.br"
 wArq = "vd_"+wMes+wAno+"_Lj"+Trim(i_fili)+".dbf"

 wDestinatario ="fabricio@grupozenir.com.br"
 *wDestinatario ="helio@grupozenir.com.br"
 wArq = "vd_"+wMes+wAno+"_Lj"+Trim(i_fili)+".dbf"

 wCp = "/zenir/sistemas/tabela/vendasdetalhe.dbf &wArq"
 !cp &wCp

 * wEnvio = 'cp /zenir/sistemas/loja&I_fili/&wArq /zenir/arq_pub/arqcom'
 *!&wEnvio

 wen=savescreen(20,40,22,78)
 Sombra(20,40,22,78,Box)
 @ 21,41 Say "E-Mail:"Get wDestinatario
 @ 22,41 Say "Arq   :"Get wArq
 Read
 wEnvio = '/zenir/sistemas/loja&I_fili/&wArq | mail -s "Arquivo de Comissoes de Vendedores (Zenir Moveis e Eletros)" -r servidores@grupozenir.com.br -a /zenir/sistemas/loja&I_fili/&wArq &wDestinatario'
 Restscreen(20,40,22,78,wen)
 If LastKey() <> 27
    !cat &wEnvio
 Endif
Return

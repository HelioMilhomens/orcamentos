#include "migracao.ch"
#include "box.ch"

Procedure mobilec()

    Set key -2 to
    M_CORA = SETCOLOR()
    TELA100=SAVESCREEN(05,00,22,79)
    SETCOLOR(C_CORGX)
    Sele 53
    Set Order to 2
    Goto Bott
    @ 05,01 clear to 21,78
    @ 05,01 to 21,78
    @ 12,01 SAY CHR(24)
    @ 15,01 SAY CHR(25)
    @ 21,02 SAY "[Esc]Retorna"

    SETCOLOR(MENU)
    PRIV VETOR1[10],VETOR2[10]

    VETOR1[1] ='CERTIF'
    VETOR1[2] ='STATUS'
    VETOR1[3] ='DATA_VENDA'
    VETOR1[4] ='VALOR_VEND'
    VETOR1[5] ='DATA_CANCE'
    VETOR1[6] ='MINUTA'
    VETOR1[7] ='SERIE'
    VETOR1[8] ='CPFCNPJ'
    VETOR1[9] ='VENDEDOR'
    VETOR1[10]='CODIGO'

    VETOR2[1] ='Nr Matricula'
    VETOR2[2] ='Status'
    VETOR2[3] ='Data Venda'
    VETOR2[4] ='Valor R$'
    VETOR2[5] ='Data Canc'
    VETOR2[6] ='Minuta'
    VETOR2[7] ='Serie'
    VETOR2[8] ='CPF/CNPJ'
    VETOR2[9] ='Vendedor'
    VETOR2[10]='Codigo'

    SETCOLOR("W+/BG+, B/RG,X")
    DBEDIT(06,02,20,77,VETOR1,"FUNCR_MC",,VETOR2," ")

    RELEASE VETOR1,VETOR2
    RESTSCREEN(05,00,22,79,TELA100)
    SETCOLOR(M_CORA)
//****************
  FUNCTION FUNCR_MC
//****************
 PARAMETERS MODO, PONTEIRO
 PRIVATE POS_CURSOR, REGISTRO, SALVA_TELA
 If Ponteiro=0
    Ponteiro=1
 EndIf
 POS_CURSOR=VETOR1[PONTEIRO]
 DO CASE
    CASE LASTKEY()=27
         RELEASE POS_CURSOR, REGISTRO, SALVA_TELA
         RELEASE VETOR1,VETOR2,PONTEIRO
         RETURN(0)
 EndCase
Return

//*********************
  Procedure Rank_Mobile                   // Ranking de Vendas de Mobile Cursos
//*********************
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

 SELE 16
 SET ORDER TO 1
 GOTO TOP
 M_VEND=BA_CODI
 GOTO BOTT
 M_VENDF=BA_CODI

 SETCOLOR(C_CORG)
 SET CURSOR ON
 SOMBRA(15,22,17,64,BOX)
 M_DAT1 = M_DATSI
 M_DAT2 = M_DATSI
 @ 15,29 SAY " ENTRE COM O PER¡ODO  "
 @ 16,24 SAY 'DATA In:' GET M_DAT1
 @ 16,44 SAY 'DATA Fn:' GET M_DAT2
 READ
 If LASTKEY() = 27 .OR. EMPTY(M_DAT1) .OR. EMPTY(M_DAT2)
    Release m_dat1,m_dat2,m_vend,m_vendf
    Return
 Endif
 nResp:=0
 nResp:=Alert("Classificar Ranking" , {"Por Quantidade" , "Por Valor R$", "Por Eficiencia"} )
 If LASTKEY() = 27 .OR. EMPTY(M_DAT1) .OR. EMPTY(M_DAT2)
    Release m_dat1,m_dat2,m_vend,m_vendf
    Return
 Endif
 Sele 53
 arqenvi=substr(dtoc(m_datsi),1,2)+substr(dtoc(m_datsi),4,2)+substr(time(),1,2)+substr(time(),4,2)+"_"+substr(time(),7,2)
 copy stru to mains.&arqenvi
 Sele 63
 Exclout(SETCOLOR(),23,"mains.&arqenvi")
 If nResp = 1 .or. nResp = 3
    Index on minuta * -1 to i_mc               && Utilizei gr_numero como qtde provisorio
 Else
    Index on valor_vend * - 1 to i_mc
 Endif
 Use
 Sele 63
 Veriout(setcolor(),23,"mains.&arqenvi")
 Set Index to i_mc
 M_Datx = M_Dat1
 Stor 0 to m_tot,t_tot,w_vlr

//***************QUANTIDADE DE GARANTIA ESTENDIDA VENDIDA POR VENDEDOR*********
 Sele 16
 Set Order to 1
 Goto top
 m_vend = ba_codi
 While .t.
    M_Dat1 = M_Datx
    Sele 16
    Set Order to 1
    Seek Str(m_vend,3,0)
    If !Eof()
       M_Nomev=Substr(Ba_Nome,1,10)
    Else
       Go Top
       m_vend++
       Loop
    Endif

    Stor 0 to m_item
    Sele 53                      // DBF de Mobile Cursos
    Set Order to 4
    While .t.
      Seek STR(M_VEND,3,0)+SUBSTR(DTOC(M_Dat1),7,4)+SUBSTR(DTOC(M_Dat1),4,2)+SUBSTR(DTOC(M_Dat1),1,2)
      If Eof()
         M_DAT1=M_DAT1+1
         If M_DAT1 > M_DAT2
            Exit
         Endif
      Else
         Exit
      Endif
    Enddo
    While !Eof() .and. Vendedor = m_vend
      If Status = "V" .and. data_venda <= m_dat2
         m_item = m_item + 1
         m_tot  = m_tot + 1
         w_vlr  = w_vlr + valor_vend
         t_tot  = t_tot + valor_vend
      Endif
      Skip
    Enddo
    Stor 0 TO M_V
    M_Dat1 = M_Datx
    If nResp = 3
       Sele 4
       Set Order to 5
       Go Top
       While .T.
         Seek STR(M_VEND,3,0)+SUBSTR(DTOC(M_DAT1),7,4)+SUBSTR(DTOC(M_DAT1),4,2)+SUBSTR(DTOC(M_DAT1),1,2)
         If Eof()
            M_DAT1=M_DAT1+1
            IF M_DAT1 >M_DAT2
               Exit
            Endif
         Else
            Exit
         Endif
       Enddo
       While !Eof() .and. SD_VEND=M_VEND .and. SD_DATA <= M_DAT2
         M_V = M_V + (SD_QTDE * SD_PREC)  && QUANTIDADE x UNITARIO VENDA
         Skip
       Enddo
    Endif

    If m_item >0
       w_perc = (w_vlr / m_v) * 100
       Sele 63
       Set Order to 1
       If Adireg(0)
          Repl vendedor with m_vend,minuta with m_item,valor_vend with w_vlr, ;
               valor_brut with w_perc,certif with m_nomev
       Endif
    Endif
    Stor 0 to m_item,w_vlr
    Sele 16
    Set Order to 1
    Go Top
    m_vend++
    If m_vend > m_vendf
       exit
    Endif
 Enddo
 If nResp = 3
    Sele 63
    Index on valor_brut * -1 to i_mc               && Utilizei minuta como qtde provisorio
    Set Index to i_mc
 Endif
 Sele 63
 Set Order to 1
 Goto Top
 Priv m_ache[1000]
 m = "0001"
 While !Eof()
   If nResp = 3
      m_ache[&m] = strzero(vendedor,3)+"  "+substr(certif,1,10)+"       "+strzero(minuta,3)+"        "+str(valor_vend,8,2)+"  "+str(valor_brut,8,2)+" %"
   Else
      m_ache[&m] = strzero(vendedor,3)+"  "+substr(certif,1,10)+"       "+strzero(minuta,3)+"        "+str(valor_vend,8,2)
   Endif
   m = STRZERO(VAL(m)+1,4,0)
   Skip
 Enddo
 Sele 63
 Use
 If file("mains.&arqenvi")
    Deletefile("mains.&arqenvi")
 Endif
 If file("i_mc.cdx")
    Deletefile("i_mc.cdx")
 Endif
 SETCOLOR("W+/B+")
 If nResp = 3
    Sombra(05,02,22,56,Box)
 Else
    Sombra(05,02,22,46,Box)
 Endif
 SETCOLOR("GR+/B+")
 If nResp = 3
    @ 06,03 SAY 'C¢d  Vendedor(es)    Curs Vend   Valor R$  Eficiencia'
 Else
    @ 06,03 SAY 'C¢d  Vendedor(es)    Curs Vend   Valor R$'
 Endif
 @ 21,03 say "Total "
 @ 21,24 say strzero(m_tot,4)
 @ 21,34 say t_tot pict "@e 999,999.99"
 SETCOLOR("W+/B+")
 If nResp = 3
    @ 07,03 to 07,55
    M_OPCA = ACHOICE(08,03,20,55,M_ACHE)
 Else
    @ 07,03 to 07,45
    M_OPCA = ACHOICE(08,03,20,45,M_ACHE)
 Endif
 Release ALL LIKE M_ACH*
 Release M_VEND,M_DATX,M_DAT1,M_DAT2,M_NOMEV,M,M_OPCA,M_ITEM,M,T_TOT,W_VLR,M_V,W_perc,nResp,nRespw
Return

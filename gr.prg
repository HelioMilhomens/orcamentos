//****************************************
/*
   FILE NAME : GR.PRG
   BY        : HELIO-SP
   DESC      : ESTOQUE (MENU)
*/
//****************************************
#include "box.ch"
#include "migracao.ch"

Procedure Gr()
TEESTO = SAVESCREEN(00,00,24,79)
SETCOLOR("W+/B,B/W,,,W+/B")
SOMBRA(05,60,09,78,BOX)
OP4=ACHOICE(06,61,08,77,V4,.T.,"FUNCAO")
SET COLOR TO
SET KEY -1 TO
IF LASTKEY() = 13
   Set key 22 to
   DO CASE
      CASE OP4 = 1
           GrCad()              // Cadastro de Garantias Aon
           KEYB(CHR(13))
      CASE OP4 = 2
           Rank()              // Ranking de Vendas de Garantia
           KEYB(CHR(13))
      CASE OP4 = 3
           Brows()             // Browse
           KEYB(CHR(13))
      CASE OP4 = 5
           *Mobilec()
           KEYB(CHR(13))
      CASE OP4 = 6
           *Rank_Mobile()
           KEYB(CHR(13))
      ENDCASE
      RESTSCREEN(00,00,24,79,TEESTO)
 ELSE
      RESTSCREEN(00,00,24,79,TEESTO)
 ENDIF
Return

//**************
  Procedure Rank                   // Ranking de Vendas de Garantias
//**************
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
 nResp:=Alert("Classificar Ranking" , {"Por Quantidade" , "Por Valor R$" , "Por Eficiencia"} )
 If LASTKEY() = 27 .OR. EMPTY(M_DAT1) .OR. EMPTY(M_DAT2)
    Release m_dat1,m_dat2,m_vend,m_vendf
    Return
 Endif
 Sele 35
 arqenvi=substr(dtoc(m_datsi),1,2)+substr(dtoc(m_datsi),4,2)+substr(time(),1,2)+substr(time(),4,2)+"_"+substr(time(),7,2)
 copy stru to mains.&arqenvi
 Sele 55
 Exclout(SETCOLOR(),23,"mains.&arqenvi")
 If nResp = 1
    Index on gr_numero * -1 to i_gr               && Utilizeir gr_numero como qtde provisorio
 ElseIf nResp = 2
    Index on gr_vdprod * - 1 to i_gr
 Else
    Index on gr_fator * - 1 to i_gr
 Endif
 Use

 Sele 55
 Veriout(setcolor(),23,"mains.&arqenvi")
 Set Index to i_gr
 M_Datx = M_Dat1
 Stor 0 to m_tot,t_tot,w_vlr
 @ 18,29 Say "Calculando, Aguarde..."
//***************QUANTIDADE DE GARANTIA ESTENDIDA VENDIDA POR VENDEDOR*********
 Sele 16
 Set Order to 1
 Go top
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
   Stor 0 to m_item,m_efici
   Sele 35                      // DBF de Garantia Estendida
   Set Order to 4
   While .t.
     Seek STR(M_VEND,3,0)+SUBSTR(DTOC(M_Dat1),7,4)+SUBSTR(DTOC(M_Dat1),4,2)+SUBSTR(DTOC(M_Dat1),1,2)
     If Eof()
        M_DAT1++
        If M_DAT1 > M_DAT2
           Exit
        Endif
     Else
        Exit
     Endif
   Enddo
   While !Eof() .and. Gr_vende = m_vend
     @ 18,51 Say gr_data
     If gr_status = "V" .and. gr_data <= m_dat2
        w_vlr  = w_vlr + gr_fator
        t_tot  = t_tot + gr_fator
        m_item++
        m_tot++
     Endif
     Sele 35                      // DBF de Garantia Estendida
     Set Order to 4
     Skip
   Enddo
   If m_item >0
      m_efici := RetVenD(M_VEND,M_Datx,M_DAT2)     // Neste prg
      *? w_vlr
      *Alert(m_efici)
      wEficiencia = 0
      If m_efici >0
         wEficiencia = (w_vlr / m_efici)*100
      Endif
      Sele 55
      Set Order to 1
      If Adireg(0)
         Repl gr_vende with m_vend,gr_numero with m_item,gr_fator with wEficiencia,;
              gr_cupom with m_nomev,gr_vdprod with w_vlr
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
 Sele 55
 Set Order to 1
 Go Top
 Priv m_ache[1000]
 m = "0001"
 While !Eof()
   m_ache[&m] = strzero(gr_vende,3)+"  "+substr(gr_cupom,1,10)+"       "+strzero(gr_numero,4)+"       "+str(gr_vdprod,9,2)+"   "+Str(gr_fator,7,2)+"%"
   m = STRZERO(VAL(m)+1,4,0)
   Skip
 Enddo
 Sele 55
 Use
 If File("mains.&arqenvi")
    DeleteFile("mains.&arqenvi")
 Endif
 If file("i_gr.cdx")
    DeleteFile("i_gr.cdx")
 Endif
 SETCOLOR("W+/B+")
 Sombra(05,02,22,58,Box)
 SETCOLOR("GR+/B+")
 @ 06,03 SAY 'C¢d  Vendedor(es)    GR.E Vend   Valor R$   Eficiencia'
 @ 21,03 say "Total "
 @ 21,23 say strzero(m_tot,6)
 @ 21,32 say t_tot pict "@e 99,999,999.99"
 SETCOLOR("W+/B+")
 @ 07,03 to 07,57
 M_OPCA = ACHOICE(08,03,20,55,M_ACHE)
 Release ALL LIKE M_ACH*
 Release M_VEND,M_DATX,M_DAT1,M_DAT2,M_NOMEV,M,M_OPCA,M_ITEM,M,T_TOT,W_VLR
Return

//***************
  Function RetVenD(VEND3,M_DAT1,M_DAT2)
//***************
  Local M_Efici
  M_Efici = 0
  SELE 4
  SET ORDER TO 5
  GO TOP
  SET DEVI TO SCREEN
  While .T.
     Seek Str(VEND3,3,0)+SUBSTR(DTOC(M_DAT1),7,4)+SUBSTR(DTOC(M_DAT1),4,2)+SUBSTR(DTOC(M_DAT1),1,2)
     IF Eof()
        M_DAT1++
        IF M_DAT1 >M_DAT2
           EXIT
        ENDIF
     Else
        EXIT
     Endif
  Enddo
  While !Eof() .AND. SD_VEND=VEND3 .AND. SD_DATA<=M_DAT2
     If sd_cpf <> "   .   .   -  "  .and. sd_cpf <> space(14)   // P.F.
        M_VE = (SD_QTDE * SD_PREC)
        wCodi    = sd_codi
        m_cpf    = sd_cpf
        m_cgc    = sd_cgc
        w_pass_e = "n"

        Sele 3
        Set Order to 1
        Seek wCodi
        If cd_faixap >0 .and. cd_gr >0
           w_pass_e = "s"                 //  Produto Elegivel1
        Endif
        If (cd_faixap >0 .and. cd_gr > 12) .and. (cd_SBGRUP=8 .or. cd_SBGRUP=304)
           w_pass_e = "n"                 //  Produto Nao Elegivel1 (Cama Box e Colchoes acima de 12 meses do fabricante)
        Endif
        If Empty(m_cpf) .and. !Empty(m_cgc)
           w_pass_e = "n"
        Endif
        If w_pass_e = "s"
            m_efici = m_efici + M_VE       // Eficiencia de G.E.
        Endif
     Endif
     SELE 4
     SET ORDER TO 5
     Skip
  Enddo
Return(m_efici)

//***************
  PROCEDURE GrCad(m_nota,m_plano)     // Garantia no Orcamento
//***************
Set Color to W+/W

@ 00,00 Clear to 24,79
@ 01,00,24,79 BOX B_SINGLE

@ 03,00 Say "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 07,02,13,49 BOX B_SINGLE

Set color to N/W
    @ 04,52,10,75 BOX B_SINGLE     // Grade da apresentacao
    @ 08,04,12,47 BOX B_SINGLE    // Grade do Grupo e Sub_grupo
    @ 01,00 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    @ 02,00 Say "³                           Zenir M¢veis / TWG"
    @ 03,00 Say "Ã"
    @ 04,00 Say "³"
    @ 05,00 Say "³"
    @ 06,00 Say "³"
    @ 07,00 Say "³"
    @ 08,00 Say "³"
    @ 09,00 Say "³"
    @ 10,00 Say "³"
    @ 11,00 Say "³"
    @ 12,00 Say "³"
    @ 13,00 Say "³"
    @ 14,00 Say "³"
    @ 15,00 Say "³"
    @ 16,00 Say "³"
    @ 17,00 Say "³"
    @ 18,00 Say "³"
    @ 19,00 Say "³"
    @ 20,00 Say "³"
    @ 21,00 Say "³"
    @ 22,00 Say "³"
    @ 23,00 Say "³"
    @ 24,00 Say "À"

    @ 07,02 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"  //Grade dos valores
    @ 08,02 Say "³"
    @ 09,02 Say "³"
    @ 10,02 Say "³"
    @ 11,02 Say "³"
    @ 12,02 Say "³"
    @ 13,02 Say "À"

    Set color to W+/W     // Grade da apresentacao
    @ 04,52 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    @ 05,52 Say "³"
    @ 06,52 Say "³"
    @ 07,52 Say "³"
    @ 08,52 Say "³"
    @ 09,52 Say "³"
    @ 10,52 Say "À"

    Set color to B/W
    @ 06,54 Say " Garantia Estendida"
    @ 07,54 Say " Cadastro de Garantia"
    @ 08,54 Say " no Or‡amento        "

   Cor=SetColor()

    Set color to W+/W      // Grade do Grupo e Sub_grupo
    @ 08,04 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    @ 09,04 Say "³"
    @ 10,04 Say "³"
    @ 11,04 Say "³"
    @ 12,04 Say "À"

   Set color to N/W
   @ 04,01,06,48 BOX B_DOUBLE
   Set color to W+/W

   @ 04,01 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ 05,01 Say "³  Garantia Estendida TWG"
   @ 06,01 Say "À"

   Set cursor On
 While .t.
  Stor 0 to m_grupog,m_Subgru,m_custo,m_impo,m_comis,m_venda,m_codx
  If empty(m_nota)
     Stor 0 to m_nota,m_plano
     Keyb(chr(13))
  Endif
   Set color to B/W
   @ 09,05 clear to 11,45
   @ 14,02 clear to 23,78
   @ 09,05 say "Or‡amento: "get m_nota pict "99999999" valid m_nota >0
   read
   If Lastkey()=27 .or. m_nota=0
      Exit
   Endif
   Sele 25
   Set Order to 1
   Seek Str(m_nota,8,0)
   If Eof()
      Alert("Or‡amento n„o Efetuado !")
      Loop
   Endif
   @ 10,05 say "Data da Compra "+dtoc(cd_datao)
   @ 11,05 say substr(cd_nomecl,1,35)

   PRIV M_ACHE[20],m_codi[20],m_plan[20],m_gr[20],m_dtgr[20],m_qtde[20],m_valor[20],m_faixa[20]
   M="01"
   WHILE !EOF() .AND. CD_CODIOR = M_NOTA
     M_CODI[&M] = CD_CODI
     M_QUANT    = CD_QUANT
     M_GR[&M]   = CD_GR
     If cd_plano = 1 .or. cd_plano = 3
        M_PLAN[&M] = 12
     ElseIf cd_plano = 2 .or. cd_plano = 4
        M_PLAN[&M] = 24
     Else
        M_PLAN[&M] = 0
     Endif
     M_DTGR[&M] = CD_DTGR
     M_QTDE[&M] = CD_QTDEGR
     M_VALOR[&M]= CD_UNIT
     SELE 3
     SET ORDER TO 1
     GOTO TOP
     SEEK M_CODI[&M]
     If Eof()
        m_prod="Produto N„o Cadastrado"
        m_faixa[&m]= 0
        m_valor[&M]= 0
     Else
        m_prod     = cd_prod
        m_faixa[&m]= cd_faixap
        m_valor[&M]= cd_avista2
     Endif
     M_ACHE[&M]=STRZERO(M_QUANT,5)+"³"+STRZERO(M_CODI[&M],6)+"³"+SUBSTR(M_PROD,1,36)+"     "+substr(m_gr[&M],1,1)+"   "+str(m_plan[&M],2,0)+"      "+dtoc(m_dtgr[&M])
     M = STRZERO(VAL(M)+1,2)
     SELE 25
     SET ORDER TO 1
     SKIP
  ENDDO
  @ 14,20 say "Produtos"
  @ 14,57 say "Gr Plano      Data"
  @ 15,02 say repl("Í",76)
  @ 21,02 say repl("Í",76)
  COR=SETCOLOR()
  SETCOLOR("w/b+")
  @ 16,03 clear to 20,78
  M_OPCA = ACHOICE(16,3,20,78,M_ACHE)
  RELEASE ALL LIKE M_ACH*
  IF LASTKEY() = 27
     RELEASE ALL LIKE M_ACH*
     LOOP
  ENDIF
  If Empty(m_plano)
     p_plano=M_PLAN[M_OPCA]
  Else
     p_plano=M_PLANO
  Endif
  P_CODI =M_CODI[M_OPCA]
  P_QTDE =M_QTDE[M_OPCA]
  P_DTGR =M_DTGR[M_OPCA]
  P_GR   =M_GR[M_OPCA]
  P_VALOR=M_VALOR[M_OPCA]
  P_FAIXA=M_FAIXA[M_OPCA]
  Sele 3
  Set Order to 1
  Seek P_Codi
  If cd_faixap <= 0
     Alert("Nao Ha Garantia Cadastrada P/ este Produto !")
     Keyb(chr(13))
     Loop
  Endif
  If p_qtde =0
     p_qtde =1
  Endif
  p_plano=1
  Set Color to n/w+
  @ 19,04 to 23,25
  If P_FAIXA <> 61
     @ 20,05 Prom "Plano 12 Meses "
     @ 21,05 Prom "Plano 24 Meses "
     @ 22,05 Prom "Desfaz         "
  Else
     @ 20,05 Prom "Troca Garantida 12 M"
     @ 21,05 Prom "Troca Garantida 24 M"
     @ 22,05 Prom "Desfaz         "
  Endif
  SETCOLOR("B+/W, W+/B")
  Menu to p_plano
  If p_plano = 1
     w_plano = 12
  ElseIf p_plano = 2
     w_plano = 24
  ElseIf p_plano = 3
     w_plano = 0
  Else
     w_plano = 0
  Endif
  If p_plano >0
     Stor 0 to m_venda
     Sele 101
     Veriout(SetColor(24),23,"faixapr")
     *Set Index to pr_faixa
     Set Index to index_faixapr
     Goto Top
     Seek p_faixa
     While !Eof() .and. faixa = p_faixa
       If p_valor >= DE .and. p_valor <= ATE .and. plano = W_plano
          m_venda = premio_tot
       Endif
       Skip
     Enddo
     Use
     @ 23,50 say "Valor do Plano "+str(m_venda,6,2)
 Else
      Alert("Cancelando Garantia Estendida P/ Este Produto !" )
 Endif

  m_conf="S"
  @ 22,63 say "***** Confirma ?"
  @ 23,75 get m_conf pict "@!" valid m_conf = "S" .OR. m_conf = "s" .or. m_conf="N" .or. m_conf="n"
  Read
  If LastKey()<>27
     Sele 25
     Set Order to 1
     Seek str(m_nota,8,0)
     While !eof() .and. cd_codior = m_nota
      If cd_codi = p_codi
         If Bloqreg(0)
            Repl cd_gr with m_conf,cd_dtgr with m_datsi,cd_status with "O", ;
	         cd_qtdegr with p_qtde,cd_vrgr with m_venda
            If P_faixa <> 61
               Repl cd_plano with p_plano
            ElseIf P_faixa = 61 .and. p_plano = 1
               Repl cd_plano with 3
            ElseIf P_faixa = 61 .and. p_plano = 2
               Repl cd_plano with 4
 	    Endif
            If m_conf <> "S"
               Repl cd_plano with 0
            Endif
	    If p_plano = 3
               Repl cd_gr with "N",cd_dtgr with ctod("")
	    Endif
         Endif
         Unlock
         Keyb(chr(13))
         Exit
      Endif
      Skip
     Enddo
     SETCOLOR(COR)
  Endif
  Release p_faixa
 Enddo
Return
//***************
  Procedure Brows      //  Browse de garantia Estendida
//***************
    M_CORA = SETCOLOR()
    TELA100=SAVESCREEN(05,00,22,79)
    SETCOLOR(C_CORGX)
    Sele 25
    Set Order to 1
    Goto Bott
    @ 05,01 clear to 20,78
    @ 05,01 to 20,78
    @ 12,01 SAY CHR(24)
    @ 15,01 SAY CHR(25)
    @ 20,30 SAY '<PgUp>Sobe'
    @ 20,52 SAY '<PgDn>Desce'
    @ 09,35 SAY 'Help Solicitado...'

    SETCOLOR(MENU)
    PRIV VETOR1[17],VETOR2[17]
    VETOR1[1] ='CD_CODIOR'
    VETOR1[2] ='CD_PLANO'
    VETOR1[3] ='CD_DTGR'
    VETOR1[4] ='CD_VRGR'
    VETOR1[5] ='CD_NOMECL'
    VETOR1[6] ='CD_CODICL'
    VETOR1[7] ='CD_ENDE'
    VETOR1[8] ='CD_BAIR'
    VETOR1[9] ='CD_CIDA'
    VETOR1[10]='CD_CEP'
    VETOR1[11]='CD_FONE'
    VETOR1[12]='CD_CPF'
    VETOR1[13]='CD_CGC'
    VETOR1[14]='CD_DATAO'
    VETOR1[15]='CD_CODI'
    VETOR1[16]='CD_PROD'
    VETOR1[17]='CD_VENDED'

    VETOR2[1] ='Or‡to '
    VETOR2[2] ='Plano'
    VETOR2[3] ='Data Garantia'
    VETOR2[4] ='Valor R$'
    VETOR2[5] ='Nome do Cliente'
    VETOR2[6] ='Cod_Cli'
    VETOR2[7] ='Endere‡o do Cliente'
    VETOR2[8] ='Bairro'
    VETOR2[9] ='Cidade'
    VETOR2[10]='CEP.'
    VETOR2[11]='Telefone'
    VETOR2[12]='C.P.F. '
    VETOR2[13]='C.G.C'
    VETOR2[14]='DATA ORCTO'
    VETOR2[15]='CODIGO PROD'
    VETOR2[16]='DESCRI€AO DO PRODUTO'
    VETOR2[17]='VENDEDOR'
    SETCOLOR("W+/BG+, B/RG,X")
    DBEDIT(06,02,19,77,VETOR1,"FUNCR_S",,VETOR2," ")

    RELEASE VETOR1,VETOR2
    RESTSCREEN(05,00,22,79,TELA100)
    SETCOLOR(M_CORA)
//****************
  FUNCTION FUNCR_S
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

********************************************
/*
   FILE NAME : IMEI.PRG
   BY        : HELIO-SP
   DESC      : Cadastro e Envio de Imei
*/
*******************************************
#include "box.ch"
#include "migracao.ch"

Procedure Imei()

TEESTO = SAVESCREEN(00,00,24,79)
SETCOLOR("W+/B,B/W,,,W+/B")
SOMBRA(05,37,12,63,BOX)
OP2=ACHOICE(06,39,11,62,V3,.T.,"FUNCAO")
SET COLOR TO
SET KEY -1 TO
IF LASTKEY() = 13
     set key 22 to
     DO CASE
      CASE OP2 = 1
	   Brow_Imei()              
	   KEYB(CHR(13))
      CASE OP2 = 2
           Entr_imei(0,"I")              
	   KEYB(CHR(13))
      CASE OP2 = 3
	   Transf_imei()            
           KEYB(CHR(13))
      CASE OP2 = 4
	   Brow_Transf()            
           KEYB(CHR(13))
      CASE OP2 = 5
           Envio_Imei(1)             
           KEYB(CHR(13))
      CASE OP2 = 6
           Estoque()
           KEYB(CHR(13))
      CASE OP2 = 7
           RouboFurto()
           KEYB(CHR(13))
      CASE OP2 = 8
           ImportaImeioDoo()
           KEYB(CHR(13))
     ENDCASE
    RESTSCREEN(00,00,24,79,TEESTO)
 ELSE
    RESTSCREEN(00,00,24,79,TEESTO)
 ENDIF
Return

//************
  PROC Estoque
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
 P_OPC = 1
 SET CURSOR ON

 mlj = Alltrim(str(Loja))
 While .T.
   M_CODX = 0
   M_CODF = 999999
   SETCOLOR(C_CORG)
   SELE 44
   SET ORDER TO 2
   GOTO TOP
   M_CODX=CEL_CODI
   GOTO BOTTOM
   M_CODF=CEL_CODI
   GOTO TOP

   @ 22,1 CLEAR TO 22,78
   Sombra(12,66,17,78,Box)
   @ 13,67 SAY "C¢d Inicial"
   @ 14,67 GET M_CODX PICT "999999"
   @ 15,67 SAY "C¢d Final"
   READ
   IF LASTKEY() = 27
      SET COLOR TO
      RETURN
   ENDIF
   SELE 3
   SET ORDER TO 1
   GOTO TOP
   SEEK M_CODX
   IF EOF()
      FRASE2(22,"C¢digo inicial n„o existe... Por favor verifique.",4,,,C_CORG)
      LOOP
   ENDIF

   Sele 44
   Set order to 2
   Seek Str(m_codx,6,0)
   If Eof()
      Alert("Codigo Nao Encontrado no Cadastro de IMEI")
      Loop
   Endif
   @ 16,67 GET M_CODF PICT "999999"
   READ
   IF LASTKEY() = 27
      SET COLOR TO
      RETURN
   ENDIF
   P_TITU = "RELA€AO ESTOQUE ORDEM DE C¢DIGO DE "+STRZERO(M_CODX,6)+" A "+STRZERO(M_CODF,6)
   Exit
 Enddo

 If File("relatoimei.dbf")
    DeleteFile("relatoimei.dbf")
 Endif

 AtualizaCSV()           //  Neste prg

 Sele 44
 Set order to 2
 Copy stru to relatoimei

 Sele 24
 Veriout(setcolor(),23,"relatoimei")

 Sele 44
 Set order to 2
 While !EOF() .and. CEL_CODI<= M_CODF
   If minuta >0 .or. cel_transf >0
      Skip
      Loop
   Endif
   If(At("Roubado",Motivo)) >0
     Skip
     Loop
   Endif
   wCodi = CEL_CODI

   wIMei   = cel_imei
   wnSerie = cel_nSerie

   wDatae= CEL_DATAE
   wDatat= CEL_DATATR
   wBP   = BIPADO

   Sele 24
   If Adireg(0)
      Repl CEL_CODI with wCodi,cel_datae with wDatae,CEL_IMEI with wImei,;
           Bipado with wBp,CEL_DATATR with wDatat,CEL_NSERIE with wnSerie
   Endif
   Unlock
   Sele 44
   Set order to 2
   Skip
 Enddo

 Sele 24
 Go Top

 RELAx1 = 2

/*
 OKPRINT()
 IF LASTKEY() = 27
    Return
 Endif
*/

 Prn_File=FS_Set("PrintFile")
 Set devi to screen

 M_ITEN = 0
 M_SUBT = 0
 P_PAGI = 1
 SIGA   = "S"

 SETCOLOR(C_CORN)
 @ 13,01 CLEAR TO 18,78

 While !EOF() .AND. SIGA='S' .AND. PROW() <60;
  .AND. IF(P_OPC = 1,CEL_CODI<= M_CODF,.T.)
   SET DEVI TO SCREE
   ESC = INKEY()
   ESCPRINT(ESC,24)
   SET DEVI TO PRINT
   @ PROW(),1 SAY CHR(18)
   CABECA(P_TITU,P_PAGI)
   @ PROW()+1,01 SAY 'CODIGO DESCRICAO DO PRODUTO           IMEI/N§ S‚rie    BP Dta Entrada  Qtde Estq'
   @ PROW()+1,01  SAY REPLICATE('Í',80)
 While !EOF() .AND. SIGA='S' .AND. PROW() <60;
  .AND. IF(P_OPC = 1,CEL_CODI<= M_CODF,.T.)

   SET DEVICE TO SCREEN
   ESC = INKEY()
   ESCPRINT(ESC,24)

   wultCodi = Cel_codi

   Sele 3
   Set Order to 1
   Seek wultCodi
   If !Eof()
      wProduto = cd_prod
   Else
      wProduto = ""
   Endif

   Stor 0 to Saldo_Est,M_Pendenc,wTransit
   If XY_ESTOQODOO <> "S"
      SD_Fisc(wultCodi,,,@Saldo_Est,@M_Pendenc,@wTransit)
      M_SdPendenc := SD_Pend(wultCodi)
      M_Pendenc    = M_Pendenc + M_SdPendenc
      M_Res       := SD_Reserv(wultCodi)
      Saldo_Est   := Saldo_Est - m_Pendenc
   Else
      Saldo_Est   := cd_centl&mlj
   Endif

   Sele 24
   Set Order to 2
   If cel_datatr >= cel_datae
      wDataE =  cel_datatr
   Else
      wDataE =  cel_datae
   Endif
   wBIPADO = BIPADO
   If Empty(BIPADO)
      wBIPADO = "N"
   Endif

   If !Empty(cel_imei)
      wIMei = cel_imei
   ElseIF !Empty(cel_nSerie)
      wIMei = Substr(cel_nSerie,1,17)
   Endif

   SET DEVI TO PRINT
   If len(wIMei)>15
      @ PROW()+1,01 SAY STRZERO(CEL_CODI,6)+" "+SUBSTR(wProduto,1,30)+" "+wIMei+" "+wBIPADO+"  "+Dtoc(wDataE)
   Else
      @ PROW()+1,01 SAY STRZERO(CEL_CODI,6)+" "+SUBSTR(wProduto,1,30)+" "+wIMei+"   "+wBIPADO+"  "+Dtoc(wDataE)
   Endif

   M_ITEN++
   M_SUBT++
   SKIP
   If cel_codi <> wultCodi
      @ PROW() ,PCOl() SAY STR(M_SUBT,5)+""+Str(Saldo_Est,5)
      M_SUBT = 0
   Endif
   IF Prow() >= 60
      P_PAGI++
      EJECT
      EXIT
   ENDIF

  ENDDO
 ENDDO
 IF M_ITEN >0
    SET DEVICE TO PRINT
    @ PROW()+1,1 SAY REPLICATE('Í',80)
    @ PROW()+1,1 SAY "TOTAL DE ITENS: "+STRZERO(M_ITEN,5,0)+"  "+TIME()
    EJECT
    !mcedit &prn_file
    If(Alert("Relatorio de Estoque, Imprime ?", {"N„o ", "Sim "})) = 2
      Imp_Fatu(i_fili)
      !("./imp &fisca &prn_file")
    Endif
    DeleteFile("&prn_file")
 Else
    Alert("Sem Registro para Listar !")
 Endif
 Sele 24
 Use
 SET DEVI TO SCREEN
 Release m_item,M_SUBT,P_PAGI,SIGA
Return

//***************
  PROC RouboFurto
//***************
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
 SET CURSOR ON
 wData = M_Datsi
 While .T.
   @ 22,1 CLEAR TO 22,78
   Sombra(12,60,17,78,Box)
   @ 13,61 SAY "Data Relatorio"
   @ 14,61 GET wData
   Read
   IF LASTKEY() = 27
      SET COLOR TO
      RETURN
   ENDIF
   P_TITU = "RELA€AO DE PRODUTOS ROUBADOS/FURTADOS EM: "+Dtoc(wData)
   Exit
 Enddo

 Sele 44
 Set order to 2
 Go Top

 RELAx1 = 2

 OKPRINT()
 IF LASTKEY() = 27
    Return
 Endif

 Prn_File=FS_Set("PrintFile")
 Set devi to screen

 M_ITEN = 0
 P_PAGI = 1
 SIGA   = "S"

 SETCOLOR(C_CORN)
 @ 13,01 CLEAR TO 18,78

 While !EOF() .AND. SIGA='S' .AND. PROW() <60
   SET DEVI TO SCREE
   ESC = INKEY()
   ESCPRINT(ESC,24)
   SET DEVI TO PRINT
   @ PROW(),1 SAY CHR(18)
   CABECA(P_TITU,P_PAGI)
   @ PROW()+1,01 SAY 'CODIGO DESCRICAO DO PRODUTO                        IMEI                 '
   @ PROW()+1,01  SAY REPLICATE('Í',80)
 While !EOF() .AND. SIGA='S' .AND. PROW() <60
   SET DEVICE TO SCREEN
   ESC = INKEY()
   ESCPRINT(ESC,24)
   wSkip = .f.
   If Cel_DataS = wData
      wCont = .f.
      If(At("Roubado",Motivo)) >0
        wCont = .t.
      Endif
      If wCont = .t.
         wCodi = Cel_codi

         Sele 3
         Set Order to 1
         Seek wCodi
         If !Eof()
            wProduto = cd_prod
         Else
            wProduto = ""
         Endif
         Sele 44
         Set Order to 2
         SET DEVI TO PRINT
         @ PROW()+1,01 SAY STRZERO(CEL_CODI,6)+" "+SUBSTR(wProduto,1,40)+"    "+CEL_IMEI+"   "
         M_ITEN++
         SKIP
         wSkip = .t.
         IF Prow() >= 60
            P_PAGI++
            EJECT
            Exit
         Endif
      Endif
   Endif
   If wSkip = .f.
      Skip
   Endif
  ENDDO
 ENDDO
 IF M_ITEN >0
    SET DEVICE TO PRINT
    @ PROW()+1,1 SAY REPLICATE('Í',80)
    @ PROW()+1,1 SAY "TOTAL DE ITENS: "+STRZERO(M_ITEN,5,0)+"  "+TIME()
    EJECT
    !mcedit &prn_file
    If(Alert("Relatorio de Roubos/Furtos, Imprime ?", {"Sim ","N„o "})) = 1
      Imp_Fatu(i_fili)
      !("./imp &fisca &prn_file")
    Endif
    DeleteFile("&prn_file")
 Else
    Alert("Sem Registro para Listar !")
 Endif
 SET DEVI TO SCREEN
 Release m_item,P_PAGI,SIGA
Return

//**************
  PROC Brow_imei           && Browse do Arquivo de IMEI
//**************
 SET KEY -1 TO
 SET KEY -2 TO
 SET KEY -3 TO
 SET KEY -4 TO
 SET KEY -5 TO
 SET KEY -6 TO
 SET KEY -7 TO
 SET KEY -8 TO
 SET KEY -9 TO
 SET KEY 22 TO
 SET KEY -40 TO
 SET KEY -41 TO

 Set color to n/W
 @ 04,01 Clear to 23,78
 @ 05,01 Say "[F2]Busca/Conf [F3]Libera Or‡amento [F4]Mostru rio [F5]Devol/Vda [F6]Roub/Furt"
 @ 06,02,21,76 BOX B_SINGLE
 cor=setcolor()
 setcolor("r+/w")
 @ 05,02 Say "F2"
 @ 05,17 Say "F3"
 @ 05,38 Say "F4"
 @ 05,53 Say "F5"
 @ 05,67 Say "F6"
 cor=setcolor(cor)

 @ 06,02 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
 @ 07,02 Say "³"
 @ 08,02 Say "³"
 @ 09,02 Say "³"
 @ 10,02 Say "³"
 @ 11,02 Say "³"
 @ 12,02 Say "³"
 @ 13,02 Say "³"
 @ 14,02 Say "³"
 @ 15,02 Say "³"
 @ 16,02 Say "³"
 @ 17,02 Say "³"
 @ 18,02 Say "³"
 @ 19,02 Say "³"
 @ 20,02 Say "³"
 @ 21,02 Say "À"
 cor=setcolor()
 setcolor("w+/r")
 @ 22,02 Say Substr(m_nomeusu,1,10)+" -> Modulo de Vendas - Imei de Celulares                   F7 Geral"
 setcolor(cor)
 @ 23,02 to 23,78

 PRIV VETOR1[30],VETOR2[30]

 Sele 44
 Set order to
 Go Bott

 VETOR1[1] ='CEL_NOTA'
 VETOR1[2] ='CEL_CODI'
 VETOR1[3] ='CEL_IMEI'
 VETOR1[4] ='CEL_NSERIE'
 VETOR1[5] ='CEL_FORN'
 VETOR1[6] ='CEL_NOMEFO'
 VETOR1[7] ='CEL_DATAE'
 VETOR1[8] ='CEL_DATAS'
 VETOR1[9] ='VENDIDO_LJ'
 VETOR1[10]='CEL_TRANSF'
 VETOR1[11]='CEL_DE'
 VETOR1[12]='CEL_PARA'
 VETOR1[13]='CEL_DATATR'
 VETOR1[14]='CEL_PARA_2'
 VETOR1[15]='DATA_TRF_2'
 VETOR1[16]='TRANSFER_2'
 VETOR1[17]='CEL_PARA_3'
 VETOR1[18]='DATA_TRF_3'
 VETOR1[19]='TRANSFER_3'
 VETOR1[20]='CEL_PARA_4'
 VETOR1[21]='DATA_TRF_4'
 VETOR1[22]='TRANSFER_4'
 VETOR1[23]='CEL_PARA_5'
 VETOR1[24]='DATA_TRF_5'
 VETOR1[25]='TRANSFER_5'
 VETOR1[26]='DEVOLUCAO'
 VETOR1[27]='MOTIVO'
 VETOR1[28]='Bipado'
 VETOR1[29]='ORCAMENTO'
 VETOR1[30]='MINUTA'

 VETOR2[1] ='Nota Entrada'
 VETOR2[2] ='C¢digo Cel'
 VETOR2[3] ='N£mero de IMEI'
 VETOR2[4] ='N£mero de SERIE'
 VETOR2[5] ='Forn'
 VETOR2[6] ='Nome do Fornecedor'
 VETOR2[7] ='Data Entrada'
 VETOR2[8] ='Data Venda'
 VETOR2[9] ='Vendido Lj'
 VETOR2[10]='N£m Transf'
 VETOR2[11]='Dˆ'
 VETOR2[12]='Para'
 VETOR2[13]='Data Transf'
 VETOR2[14]='Para (2)'
 VETOR2[15]='Data (2)'
 VETOR2[16]='Transf (2)'
 VETOR2[17]='Para (3)'
 VETOR2[18]='Data (3)'
 VETOR2[19]='Transf (3)'
 VETOR2[20]='Para (4)'
 VETOR2[21]='Data (4)'
 VETOR2[22]='Transf (4)'
 VETOR2[23]='Para (5)'
 VETOR2[24]='Data (5)'
 VETOR2[25]='Transf (5)'
 VETOR2[26]='Dt. Devolu‡„o'
 VETOR2[27]='Motivo'
 VETOR2[28]='Bipado'
 VETOR2[29]='Or‡amento'
 VETOR2[30]='Minuta'

 SETCOLOR("B+/W, W+/B")
 @ 07,03 clear to 20,75
 DBEDIT(7,03,20,75,VETOR1,"FUNCIMEI",,VETOR2," ")
//*****************
  FUNCTION FUNCIMEI
//*****************
PARAMETERS MODO, PONTEIRO
PRIVATE POS_CURSOR, REGISTRO, SALVA_TELA
If Ponteiro=0
   Ponteiro=1
EndIf
If Valtype(VETOR1[PONTEIRO]) <> "U"
   POS_CURSOR=VETOR1[PONTEIRO]
Else
   Return(0)
Endif
SET CURSOR ON
M_NOTA  =CEL_NOTA
M_DAT1  =CEL_DATAE
M_IMEI  =CEL_IMEI
M_NSERIE=CEL_NSERIE
M_DEVOL =DEVOLUCAO
M_MOTIVO=MOTIVO
   If !empty(DEVOLUCAO)
      Cor=Setcolor()
      Setcolor("w+/r+")
      m_d=savescreen(17,34,19,70)
      Sombra(17,34,19,69,box)
      @ 18,36 Say "Celular Devolvido em "+dtoc(devolucao)
      Inkey(5)
      Restscreen(17,34,19,70,m_d)
      Setcolor(cor)
   Endif
   DO CASE
   CASE LASTKEY()=27
     RELEASE POS_CURSOR, REGISTRO, SALVA_TELA
     RELEASE VETOR1,VETOR2
     Keyb(chr(13))
     RETURN(0)
   CASE LASTKEY()=-1              && Buscando IMEI ou NSerie
     ime=savescreen(13,03,18,40)
     cor=setcolor()
     Stor SPACE(15) to m_imei
     Stor SPACE(20) to m_nserie
     Set color to r+/W
     @ 13,03 Say "Buscando/Confirmando IMei/N S‚rie"
     Setcolor(C_Corg)
     Sombra(14,03,17,35,Box)
     Set color to w/b
     @ 15,04 Say "Imei:                "
     @ 16,04 Say "N§ S‚rie:                     "
     @ 15,10 GET M_imei
     @ 16,13 GET M_nSerie pict "@!"
     Read
     If !Empty(m_imei) .and. !Empty(m_nSerie)
        Alert("Error ao Consultar. Escolha um: Imei ou N§ S‚rie")
        Setcolor(cor)
        restscreen(13,03,18,40,ime)
        Return(1)
     Endif
     If Empty(m_imei) .and. Empty(m_nSerie)
        Setcolor(cor)
        restscreen(13,03,18,40,ime)
        Return(1)
     Endif
     If LastKey() <> 27
        If !Empty(m_imei)
           Sele 44
           Set Order to 1
           Seek m_imei
           If Eof()
              If(Alert("Imei N„o Cadastrado. Cadastra um Novo IMEI ?", {"Sim ","N„o "})) = 1
                Entr_imei(0,"I")
                Return(0)
                Setcolor(cor)
                restscreen(13,03,18,40,ime)
              Endif
           Else
              If Bloqreg(0)
                 Repl bipado with "S"
              Endif
              Unlock
              cor=setcolor()
              setcolor("w+/r")
              @ 15,04 say "Conferido com Sucesso"
              Inkey(2)
              setcolor(cor)
           Endif
        Else
           Sele 44
           Set Order to 6
           Seek m_nserie
           If Eof()
              If(Alert("N§ Serie N„o Cadastrado. Cadastra um Novo N§ S‚rie ?", {"Sim ","N„o "})) = 1
                Entr_imei(0,"S")
                Return(0)
                Setcolor(cor)
                restscreen(13,03,18,40,ime)
              Endif
           Else
              If Bloqreg(0)
                 Repl bipado with "S"
              Endif
              Unlock
              cor=setcolor()
              setcolor("w+/r")
              @ 15,04 say "Conferido com Sucesso"
              Inkey(2)
              setcolor(cor)
           Endif
        Endif
     Endif
     Setcolor(cor)
     restscreen(13,03,18,30,ime)
     Return(1)
   CASE LASTKEY()=-2              && Libera Orcamento
     ime=savescreen(13,03,18,34)
     cor=setcolor()
     Stor SPACE(15) to m_imei
     Stor SPACE(20) to m_nSerie
     Set color to n/w
     @ 14,03,17,34 BOX B_SINGLE
     Set color to r+/W
     @ 13,03 Say "Liberando Or‡amento"
     Set color to B+/W
     @ 14,03 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
     @ 15,03 Say "³Imei:                        "
     @ 16,03 Say "³N§ S‚rie:                    "
     @ 17,03 Say "À"
     @ 15,09 GET M_imei
     @ 16,14 GET M_nSerie pict "@!" when Empty(m_imei)
     Read
     If Empty(m_imei) .and. Empty(m_nSerie)
        Setcolor(cor)
        restscreen(13,03,18,34,ime)
        Return(1)
     Endif
     If LastKey() <> 27
        Sele 44
        If !Empty(m_imei)
           Set Order to 1
           Seek m_imei
        ElseIf !Empty(m_nSerie)
           Set Order to 6
           Seek m_nSerie
        Endif
        If Eof()
           If !Empty(m_imei)
              If(Alert("Imei N„o Cadastrado. Cadastra um Novo IMEI ?", {"Sim ","N„o "})) = 1
                 Entr_imei(0,"I")
                 Return(0)
                 Setcolor(cor)
                 restscreen(13,03,18,34,ime)
              Endif
           ElseIf !Empty(m_nSerie)
              If(Alert("N§ S‚rie N„o Cadastrado. Cadastra um Novo N§ S‚rie ?", {"Sim ","N„o "})) = 1
                 Entr_imei(0,"I")
                 Return(0)
                 Setcolor(cor)
                 restscreen(13,03,18,34,ime)
              Endif
           Endif
        Else
           wImei  = cel_imei
           wnSerie= cel_nSerie
           wOrca  = orcamento
           wDevol = .f.
           Sele 4
           Set Order to 15
           Seek Str(wOrca,8,0)
           While !Eof() .and. sd_orca = wOrca
             If !Empty(sd_imei) .and. trim(sd_imei) = wImei .and. sd_fat = "D"
                wDevol = .t.
             Endif
             If !Empty(sd_nSerie) .and. trim(sd_nSerie) = wnSerie .and. sd_fat = "D"
                wDevol = .t.
             Endif
             Skip
           Enddo
           Sele 44
           Set Order to 1
           If minuta = 0 .or. wDevol = .t.
              If Bloqreg(0)
                 If wDevol = .t.
                    Repl orcamento with 0,minuta with 0,cel_datas with ctod(""),vendido_lj with 0,Motivo With Trim(Motivo)+"- Devolu‡„o"
                 ElseIf minuta = 0
                    Repl orcamento with 0,cel_transf with 0
                 Endif
                 Unlock
              Endif
              Alert("Imei/N§ S‚rie Liberado para Venda !")
           Else
              Alert("Opera‡„o recusada; Imei J  Vendido em: "+Dtoc(ceL_datas))
           Endif
        Endif
     Endif
     Setcolor(cor)
     restscreen(13,03,18,34,ime)
     Return(1)
   CASE LASTKEY()=-3              && Setando Mostruario
     ime=savescreen(13,03,16,34)
     cor=setcolor()
     Stor SPACE(15) to m_imei
     Stor SPACE(20) to m_nSerie
     Set color to n/w
     @ 14,03,17,34 BOX B_SINGLE
     Set color to r+/W
     @ 13,03 Say "Setando Imei de Mostru rio"
     Set color to B+/W
     @ 14,03 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
     @ 15,03 Say "³Imei"
     @ 16,03 Say "³N§ S‚rie"
     @ 17,03 Say "À"
     @ 15,09 GET M_imei   pict "@!"
     @ 16,12 GET M_nSerie pict "@!"
     Read
     If Empty(m_imei) .and. Empty(m_nSerie)
        Setcolor(cor)
        restscreen(13,03,16,34,ime)
        Return(1)
     Endif
     If LastKey() <> 27
        Sele 44
        If !Empty(m_imei)
           Set Order to 1
           Seek m_imei
        ElseIf !Empty(m_nSerie)
           Set Order to 6
           Seek m_nSerie
        Endif
        If Eof()
           If !Empty(m_imei)
              If(Alert("Imei N„o Cadastrado. Cadastra um Novo IMEI ?", {"Sim ","N„o "})) = 1
                Entr_imei(0,"I")
              Else
                 If(Alert("N§ S‚rie N„o Cadastrado. Cadastra um Novo N§ S‚rie ?", {"Sim ","N„o "})) = 1
                   Entr_imei(0,"S")
                 Endif
              Endif
              Return(0)
              Setcolor(cor)
              restscreen(13,03,16,34,ime)
           Endif
        Else
           If Bloqreg(0)
              Repl Bipado with "S",Motivo With Trim(Motivo)+"- Mostru rio"
           Endif
           Unlock
           cor=setcolor()
           setcolor("w+/r")
           If !Empty(m_imei)
              @ 15,04 say "  Imei Setado para Mostru rio"
              Inkey(3)
           Else
              @ 15,04 say "  N§ S‚rie Setado para Mostru rio"
              Inkey(3)
           Endif
           setcolor(cor)
        Endif
     Endif
     Setcolor(cor)
     restscreen(13,03,16,34,ime)
     Return(1)

   CASE LASTKEY()=-4             && Devolucao / Troca
     ime=savescreen(13,03,17,34)
     cor=setcolor()
     Stor SPACE(15) to OldImei,NewImei
     Set color to n/w
     @ 14,03,17,31 BOX B_SINGLE
     Set color to r+/W
     @ 13,03 Say "Devolu‡„o / Troca"
     Set color to B+/W
     @ 14,03 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
     @ 15,03 Say "³"
     @ 16,03 Say "À"
     @ 17,03 Say "À"
     Set color to w/b
     @ 15,04 Say "Imei Antigo:               "
     @ 16,04 Say "Imei Novo  :               "
     Set color to B+/W
     @ 15,16 GET OldImei valid OldImei <> space(15)
     Read
     If LastKey() <> 27
        Sele 44
        Set Order to 1
        Seek OldImei
        If !Eof() .and. (orcamento = 0 .or. minuta =0)
           wTem = .f.
           wData = ctod("02/01/2021")     // Fazendo Verificacao pelas Vendas antes para atualizar possivel venda futura
           Sele 4
           Set Order to 8
           Seek substr(dtoc(wData),7,4)+substr(dtoc(wData),4,2)+substr(dtoc(wData),1,2)
           While !Eof() .and. sd_data >= wData
             If !Empty(sd_imei) .and. trim(sd_imei) = OldImei .and. sd_fat <> "D"
                wOrcamento = sd_orca
                wMinuta    = sd_nota
                wDtVenda   = sd_data
                wTem = .t.
                Exit
             Endif
             Skip
           Enddo
           Sele 44
           Set Order to 1
           If wTem = .t.
              If Bloqreg(0)
                 Repl bipado with "S",Vendido_lj with Loja,CEL_DATAS with wDtVenda,cel_transf with 0,;
                      orcamento with wOrcamento,minuta with wMinuta,Motivo With Trim(Motivo)+"- Devolu‡„o"
              Endif
              Comm
              Unlock
           Endif
        Endif
        If !Eof() .and. (orcamento = 0 .or. minuta =0)
           Alert("Troca N„o Autorizada !; Imei N„o Foi Vendido !")
        ElseIf Eof()
           Alert("Imei Antigo N„o Encontrado !")
        Else
           wRecno     = Recno()
           wMinuta    = minuta
           wOrcamento = orcamento
           wCodi      = cel_codi

           @ 16,16 GET NewImei valid NewImei <> space(15)
           Read
           Seek NewImei
           If Eof()
              Alert("Novo Imei N„o Encontrado !")
           Else
              If(At("Roubado",Motivo)) >0
                 Alert("Novo Imei N„o Disponivel !; Roubado/Furtado ")
              ElseIf orcamento >0 
                 Alert("Novo Imei N„o Disponivel !; Em uso, Orcamento")
              ElseIf minuta >0
                 Alert("Novo Imei N„o Disponivel !; Ja tem Venda para esse Imei")
              ElseIf cel_transf >0
                 Alert("Novo Imei N„o Disponivel !; Imei Transferido")
              ElseIf cel_codi <> wCodi
                 Alert("Troca N„o Autorizada !; Codigos Diferentes")
              Else
                 wStatus = .f.
                 Sele 4
                 Set Order to 1
                 Seek Str(wminuta,8,0)
                 While !Eof() .and. sd_nota = wMinuta
                   If !Empty(sd_imei) .and. trim(sd_imei) = OldImei .and. sd_fat <> "D"
                      If Bloqreg(0)
                         Repl sd_imei with NewImei
                      Endif
                      Comm
                      Unlock
                      wStatus = .t.
                   Endif
                   Skip
                 Enddo
                 Sele 44
                 Set Order to 1
                 If wStatus = .t.     // Setando Novo IMei de Troca
                    If Bloqreg(0)
                       Repl bipado with "S",Vendido_lj with loja,CEL_DATAS with m_datsi,cel_transf with 0,;
                            orcamento with wOrcamento,minuta with wMinuta,Motivo With Trim(Motivo)+"- Troca"
                    Endif
                    Unlock
                    cor=setcolor()
                    setcolor("w+/r")
                    @ 15,04 say " Imei Devolvido c Sucesso "
                    @ 16,04 say " Fazer a Transf ou Venda  "
                    Inkey(3)
                    setcolor(cor)
                    Go wRecno
                    If Bloqreg(0)        // Setando IMei Antigo
                       Repl bipado with "S",Vendido_lj with 0,CEL_DATAS with CTOD(""),cel_transf with 0,;
                            orcamento with 0,minuta with 0,Motivo With Trim(Motivo)+"- Devolu‡„o em "+Dtoc(m_datsi)
                    Endif
                    Unlock
                 Endif
              Endif
           Endif
        Endif
     Endif
     Setcolor(cor)
     restscreen(13,03,17,34,ime)
     Return(1)
   CASE LASTKEY()=-5             && Roubou/Furto
     ime=savescreen(13,03,16,34)
     cor=setcolor()
     Stor SPACE(15) to m_imei
     Set color to n/w
     @ 14,03,16,25 BOX B_SINGLE
     Set color to r+/W
     @ 13,03 Say "Setendo Imei Roubou/Furto"
     Set color to B+/W
     @ 14,03 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
     @ 15,03 Say "³"
     @ 16,03 Say "À"
     Set color to w/b
     @ 15,04 Say "Imei:                "
     Set color to B+/W
     @ 15,10 GET M_imei valid m_imei <> space(15)
     Read
     If LastKey() <> 27
        Sele 44
        Set Order to 1
        Seek m_imei
        If Eof()
           Alert("Imei N„o Encontrado !")
        Else
           If Bloqreg(0)
              Repl bipado with "S",CEL_DATAS with M_Datsi,Motivo With Trim(Motivo)+"- Roubado - "+Dtoc(m_datsi)+" Usuario: "+Trim(m_nomeusu)
           Endif
           Unlock
           cor=setcolor()
           setcolor("w+/r")
           @ 15,04 say "Imei Setado c Sucesso"
           Inkey(2)
           setcolor(cor)
        Endif
     Endif
     Setcolor(cor)
     restscreen(13,03,16,34,ime)
     Return(1)
   CASE LASTKEY()=-6             && Geral
     If Trim(m_nomeusu) = "HELIO"
        If Bloqreg(0)
           telim=savescreen(10,03,20,79)
           Sombra(10,03,19,78,Box)
           @ 11,04 say "Vendido Loja:"Get vendido_lj pict "99"
           @ 12,04 say "Data Venda  :"Get cel_datas
           @ 13,04 say "Orcamento   :"Get orcamento  pict "99999999"
           @ 14,04 say "Minuta      :"Get minuta     pict "99999999"
           @ 15,04 say "Nr Transfer :"Get cel_transf pict "99999999"
           @ 16,04 say "Bipado      :"Get bipado     pict "@!"
           @ 17,04 say "Nr Serie    :"Get cel_nserie pict "@!"
           @ 18,04 say "Motivo      :"Get motivo
           Read
        Endif
        Unlock
        restscreen(10,03,20,79,telim)
     Endif
     Return(1)
   CASE LASTKEY()=7              && Deleta IMEI
     Confirma()
     If Lastkey() = 13
        M_Codicel = cel_codi
        M_Minuta  = Minuta
        wMotivo = Space(40)
        If orcamento > 0 .and. minuta >0
           If(Alert("Celular J  Vendido., Deleta Imei ?", {"Sim", "N„o"})) = 1
              Sombra(18,09,20,70,Box)
              @ 19,10 say "Motivo da Delec„o:"get wMotivo pict "@!" valid wMotivo <> space(40)
              Read
              If Bloqreg(0)
                 Delete
              Endif
              Comm
              Unlock
              Sele 22
              Veriout(SETCOLOR(),23,"lixo")
              If Adireg(0)
                 Repl OCORRENCIA WITH "Imei Deletado: "+Trim(m_imei),Codigo WITH M_Codicel,MOTIVO WITH Trim(wMotivo)+" Obs: Celular Ja Vendido Minuta: "+Str(M_Minuta), ;
                      OPERACAO WITH "PROGRAMA IMEI.PRG",USUARIO WITH M_NOMEUSU,DATAI WITH M_DATSI,HORA WITH TIME()
              Endif
              Comm
              Unlock
              Use
              Sele 44
              Set Order to 1
              Alert("Imei Deletado !")
           Endif
        Else
           Sombra(18,09,20,70,Box)
           @ 19,10 say "Motivo da Delec„o:"get wMotivo pict "@!" valid wMotivo <> space(40)
           Read
           If Bloqreg(0)
              Delete
           Endif
           Comm
           Unlock
           Sele 22
           Veriout(SETCOLOR(),23,"lixo")
           If Adireg(0)
              Repl OCORRENCIA WITH "Imei Deletado: "+Trim(m_imei),Codigo WITH M_Codicel,MOTIVO WITH wMotivo,;
                   OPERACAO WITH "PROGRAMA IMEI.PRG",USUARIO WITH M_NOMEUSU,DATAI WITH M_DATSI,HORA WITH TIME()
           Endif
           Comm
           Unlock
           Use
           Sele 44
           Set Order to 1
           Alert("Imei Deletado !")
        Endif
        Release wMotivo,M_Codicel,M_Minuta
     Endif
     Return(1)
   EndCase
Return(1)

//**************
  PROC Entr_imei(wCodi,wTipo)           && Entradas de Celulares por Imei ou Nr Serie
//**************
 SET KEY -1 TO
 SET KEY -2 TO
 SET KEY -3 TO
 SET KEY -4 TO
 SET KEY -5 TO
 SET KEY -6 TO
 SET KEY -7 TO
 SET KEY -8 TO
 SET KEY -9 TO
 SET KEY 22 TO
 SET KEY -40 TO
 SET KEY -41 TO

 Set color to W+/W
 @ 05,03 clear to 20,50
 @ 06,03 to 06,50
 Set color to n/w
 @ 07,03,09,34 BOX B_SINGLE

 Set color to n/w
 @ 08,42,21,75 BOX B_SINGLE
 If wTipo = "I"
    @ 07,42 Say "Nota N£m  C¢digo  Imei           "
 Else
    @ 07,42 Say "Nota N£m  C¢digo  N§ S‚rie       "
 Endif
 Set color to W+/W
 @ 08,42 Say "ÚÄÄÄÄÄÄÄÄÚÄÄÄÄÄÄÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
 @ 09,42 Say "³        ³      ³                "
 @ 10,42 Say "³        ³      ³                "
 @ 11,42 Say "³        ³      ³                "
 @ 12,42 Say "³        ³      ³                "
 @ 13,42 Say "³        ³      ³                "
 @ 14,42 Say "³        ³      ³                "
 @ 15,42 Say "³        ³      ³                "
 @ 16,42 Say "³        ³      ³                "
 @ 17,42 Say "³        ³      ³                "
 @ 18,42 Say "³        ³      ³                "
 @ 19,42 Say "³        ³      ³                "
 @ 20,42 Say "³        ³      ³                "
 @ 21,42 Say "À"

 lin   =9
While .t.

 Set color to W+/W
 @ 07,03 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
 @ 08,03 Say "³                             "
 @ 09,03 Say "À"
 Set color to n+/W
 @ 08,04 Say "³C¢digo "
 If wCodi = Nil
    Stor 0 TO M_CODI
 Else
    M_CODI = wCodi
 Endif
 Stor 0 TO M_VALOR,M_NOTA
 @ 08,12 GET M_CODI PICT "999999"
 Read
 IF LASTKEY() = 27 .OR. M_CODI = 0
    Keyb(chr(13))
    Exit
 Endif
 Sele 3
 Set Order to 1
 Seek M_CODI
 IF Eof()
    Alert("Produto N„o Cadastrado... Por favor verifique.")
    Loop
 Endif
 @ 08,18 SAY SUBSTR(CD_PROD,1,15)
 M_DAT1    = M_DATSI
 M_NOMEPROD= CD_PROD
 M_PRODF   = CD_PRODF
 M_FORN    = 0

 Set color to n/w
 @ 10,03,13,34 BOX B_SINGLE
 Set color to W+/W
 @ 10,03 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
 @ 11,03 Say "³                              "
 @ 12,03 Say "³                              "
 @ 13,03 Say "À"
 Set color to n+/W
 @ 11,04 Say "Nota Tranf N§                 "
 @ 12,04 Say "Data Entrada                  "

 If SubStr(M_PRODF,1,5) = "COMPO"
    Alert("Produto Com Componente")
    Stor 0 to m_valor
    @ 14,03 say "Valor Unit rio "get m_valor pict "@e 99,999.99" valid m_valor >0
    @ 15,03 say "Cod Fornecedor "get m_forn  pict "999" valid m_forn >0
    Read
    If Lastkey() = 27
       Alert("Cadastro Recusado !")
       Loop
    Endif
 Endif

 Sele 20
 Veriout(setcolor(),23,"cdfisc")
 Set index to index_cdfisc

 Sele 20
 Set Order to 1
 Seek Str(m_codi,6,0)
 If Eof()
    Use
    Alert("Falta Entrada no Fiscal Desse Produto. Comunique Faturamento.")
    Loop
 Endif
 wPs = "n"
 While !Eof() .and. F_Codigo = m_codi
   If F_Entra >0 .and. !Empty(f_cgccpf)
      M_Valor = F_Custof
      M_Nota  = Val(Substr(alltrim(F_Nota),1,8))
      M_Dat1  = F_Data
      wCnpj   = F_cgccpf
      wPs     = "s"
   Endif
   Skip
 Enddo
 If wPs = "s" .and. m_forn = 0
    M_Valor = f_custof
    wCnpj   = f_cgccpf
    m_nomef = ""
    BuscaCNPJ(@m_nomef,@m_forn,wCnpj)    // funcoes.prg
 Endif
 Sele 20
 Use
 If M_NOTA = 0
    @ 11,17 GET M_NOTA pict "99999999" VALID M_NOTA >0
    @ 12,17 GET M_DAT1
    Read
    If LastKey() = 27 .OR. EMPTY(M_DAT1)
       Sele 20
       Use
       Loop
    Endif
 Else
    @ 11,17 Say M_NOTA
    @ 12,17 Say M_DAT1
 Endif

 While .t.
   Stor SPACE(15) to m_imei
   Stor SPACE(20) to m_nserie
   Set color to n/w
   @ 14,03,17,39 BOX B_SINGLE
   Set color to W+/W
   @ 14,03 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ 15,03 Say "³Imei"
   @ 16,03 Say "³N§ S‚rie"
   @ 17,03 Say "À"
   @ 15,09 GET M_imei
   @ 16,12 GET M_nSerie pict "@!"
   Read
   If !Empty(m_imei) .and. !Empty(m_nSerie)
      Alert("Error ao Cadastrar. Escolha um: Imei ou N§ S‚rie")
      Loop
   Endif
   If LastKey() = 27
      Exit
   Endif
   Set color to b+/W
   If !Empty(m_imei)
      Sele 44
      Set Order to 1
      Seek m_imei
      If !Eof()
         Alert("Imei J  Cadastrado !")
         Loop
      Endif
      If Len(trim(m_imei)) <> 15
         Alert("Imei Incompleto !")
         Loop
      Endif
   Else
      Sele 44
      Set Order to 6
      Seek m_nSerie
      If !Eof()
         Alert("N§ S‚rie J  Cadastrado !")
         Loop
      Endif
   Endif
   @ lin,43 Say STRZERO(m_nota,8)
   @ lin,52 Say STRZERO(m_codi,6)
   If !Empty(M_imei)
      @ lin,59 Say M_imei
   ElseIf !Empty(m_nSerie)
      @ lin,59 Say Substr(m_nSerie,1,15)
   Endif
   lin=lin+1
   If Lin > 20
      LIN = 20
      SCROLL(09,43,20,50,1)
      SCROLL(09,52,20,57,1)
      SCROLL(09,59,20,74,1)
   Endif
   If Adireg(0)
      Repl cel_nota with m_nota,cel_codi with m_codi,cel_imei with m_imei,cel_nserie with m_nserie,;
           cel_valor with m_valor,cel_datae with m_dat1,cel_forn with m_forn, ;
           cel_nomefo with m_nomef,cel_de with lojax,Bipado with "S"
   Endif
   Comm
   Unlock
 Enddo
Enddo
Release m_codi,m_valor,nomeprod,m_imei,m_nume,m_forn,m_nota,m_nomef,m_nserie
Return

//****************
  PROC Transf_imei           && Transferencia de IMEI p/ Filiais
//****************
 SET KEY -1 TO
 SET KEY -3 TO
 SET KEY -6 TO
 SET KEY -7 TO
 SET KEY -8 TO
 SET KEY -9 TO
 SET KEY 22 TO
 SET KEY -40 TO
 SET KEY -41 TO

 wResp:=Alert("Transfere", {"Imei","N§ S‚rie"})

 ime=savescreen(15,03,20,38)
 cor=setcolor()
 Set Color to n/w
 @ 13,03 clear to 20,35
 @ 15,03,17,35 BOX B_SINGLE
 Set color to B+/W
 @ 14,03 Say "                               "
 @ 15,03 Say "ÚÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
 @ 16,03 Say "³                              "
 @ 17,03 Say "À"
 Set color to n/w
 @ 18,03,20,35 BOX B_SINGLE
 Set color to B+/W
 @ 18,03 Say "ÚÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
 If wResp = 1
    @ 19,03 Say "³Insira os Imei:               "
 Else
    @ 19,03 Say "³Insira Ser:                   "
 Endif
 @ 20,03 Say "À"
 While .t.
   SETCOLOR("B+/W, W+/B")
   Sele 52
   Veriout(setcolor(),23,"ip_lojas")
   Go Top
   While !Eof()
     If xy_cap_int = "CC"
        If nr_filial = "19"
           Exit
        Endif
     Else
        If nr_filial = "20"
           Exit
        Endif
     Endif
     Skip
   Enddo
   M_CORA=SETCOLOR()
   @ 16,28 say chr(24)+chr(25)
   PRIV VETOR1[1],VETOR2[1]
   VETOR1[1]='FILIAL'
   VETOR2[1]='Escolha a Filial'
   DBEDIT(14,04,16,25,VETOR1,,,VETOR2)
   m_lj   = NR_Filial
   m_para = Trim(Filial)
   RELEASE VETOR1,VETOR2
   SETCOLOR(M_CORA)
   Use
   If m_lj = "01" .or. m_lj = "12" .or. m_lj = "15" .or. m_lj = "08" .or. m_lj = "22" .or. m_lj = "33" .or. m_lj = "62"
      Alert("Escolha a Filial Correta")
      Loop
   Else
      Exit
   Endif
 Enddo
 Menu To M_LJ2
 Use
 If Lastkey() = 27
    Keyb(chr(13))
    Return
 Endif

 wTransf = 0
 Sele 44
 Set Order to 3
 Go Bott
 While !Bof()
   If cel_transf >0
      wTransf = cel_transf+1
      Exit
   Endif
   Skip -1
 Enddo
 If wTransf = 0
    wTransf = 1
 Endif

 Sele 52                                 && Arquivo de Envio para as filiais
 Exclout(SETCOLOR(),23,"f_imei")
 Zap
 Stor 0 to X
 While .t.
   SETCOLOR("B+/W, W+/B")
   Stor SPACE(15) to m_imei
   Stor SPACE(20) to m_nSerie
   If wResp = 1
      @ 19,19 GET m_imei
   Else
      @ 19,15 GET M_nSerie pict "@!"
   Endif
   Read
   If LastKey() <> 27
      Sele 44
      If !Empty(m_imei)
         Set Order to 1
         Seek m_imei
         If Eof()
            Alert("Imei N„o Cadastrado !")
            Loop
         Endif
      Else
         Set Order to 6
         Seek m_nSerie
         If Eof()
            Alert("N§ S‚rie N„o Cadastrada !")
            Loop
         Endif
      Endif
   Else
      Exit
   Endif

   x=x+1

   @ 19,30 say strzero(x,4)

   m_nota = cel_nota
   m_codi = cel_codi
   m_imei = cel_imei
   m_valor= cel_valor
   m_dat1 = cel_datae
   m_forn = cel_forn

   Sele 52
   Append Blank
   Repl cel_nota with m_nota,cel_codi with m_codi,cel_imei with m_imei, ;
        cel_valor with m_valor,cel_datae with m_dat1,cel_forn with m_forn, ;
        cel_de with m_loja1,cel_para with m_para,cel_datatr with m_datsi, ;
        cel_lojatr with val(m_lj),cel_transf with wTransf,cel_nSerie with m_nSerie

  Sele 44
  If !Empty(m_imei)
     Set Order to 1
  Else
     Set Order to 6
  Endif
  If Bloqreg(0)
     Repl cel_transf with wTransf
  Endif
  Unlock

  nResp:=0
  If !Empty(m_imei)
     nResp:=Alert("Imei Identificado P/ Transferencia, Escolha as Op‡oes ", {"Press [Enter] P/Transferir Outro","Press [Esc] P/Sair e Enviar OnLine"})
  Else
     nResp:=Alert("NSerie Identificado P/ Transferencia, Escolha as Op‡oes ", {"Press [Enter] P/Transferir Outro","Press [Esc] P/Sair e Enviar OnLine"})
  Endif
  If nResp = 2
     Exit
  Endif
 Enddo
 Sele 52
 Use
 Setcolor(cor)
 *Keyb(chr(13))
 RestScreen(15,03,20,38,ime)
 If x > 0
    nResp:=0
    nResp:=Alert("Transferindo On Line ?", {"Press [Enter] P/Enviar","Press [ESC] P/Desistir"})
    If nResp = 1
       Envio_imei(wResp)
    Endif
 Endif
 Release x,nResp,m_nota,m_codi,m_imei,m_valor
 Release m_para,m_lj,m_numtr,m_forn,m_de,m_dat1
Return

//****************
  PROC Brow_Transf           && Browse do Arquivo de Transferencias de IMEI
//****************
 SET KEY -1 TO
 SET KEY -3 TO
 SET KEY -6 TO
 SET KEY -7 TO
 SET KEY -8 TO
 SET KEY -9 TO
 SET KEY 22 TO
 SET KEY -40 TO
 SET KEY -41 TO

 Set color to n/W
 @ 05,03 Clear to 21,76
 @ 05,03 Say "Arquivo de Transferencias de IMEI                   [Del]Exclui"
 @ 06,02,21,76 BOX B_SINGLE
 Set color to b+/W
 @ 06,02 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
 @ 07,02 Say "³"
 @ 08,02 Say "³"
 @ 09,02 Say "³"
 @ 10,02 Say "³"
 @ 11,02 Say "³"
 @ 12,02 Say "³"
 @ 13,02 Say "³"
 @ 14,02 Say "³"
 @ 15,02 Say "³"
 @ 16,02 Say "³"
 @ 17,02 Say "³"
 @ 18,02 Say "³"
 @ 19,02 Say "³"
 @ 20,02 Say "³"
 @ 21,02 Say "À"

 Sele 52
 Use
 Sele 52                                 && Arquivo de Envio para as filiais
 EXCLOUT(SETCOLOR(),23,"f_imei")
 Go top

 PRIV VETOR1[11],VETOR2[11]

 VETOR1[1] ='CEL_NOTA'
 VETOR1[2] ='CEL_CODI'
 VETOR1[3] ='CEL_IMEI'
 VETOR1[4] ='CEL_VALOR'
 VETOR1[5] ='CEL_FORN'
 VETOR1[6] ='CEL_DATAE'
 VETOR1[7] ='CEL_DATAS'
 VETOR1[8] ='CEL_TRANSF'
 VETOR1[9] ='CEL_DE'
 VETOR1[10]='CEL_PARA'
 VETOR1[11]='CEL_DATATR'

 VETOR2[1] ='Nota Entrada'
 VETOR2[2] ='C¢digo Cel'
 VETOR2[3] ='N£mero de IMEI'
 VETOR2[4] ='Valor Compra'
 VETOR2[5] ='Fornecedor'
 VETOR2[6] ='Data Entrada'
 VETOR2[7] ='Data Venda'
 VETOR2[8] ='N£m Transf'
 VETOR2[9] ='Dˆ'
 VETOR2[10]='Para'
 VETOR2[11]='Data Transf'

 SETCOLOR("B+/W, W+/B")
 @ 07,03 clear to 20,75
 DBEDIT(7,03,20,75,VETOR1,"FUNCTRIMEI",,VETOR2," ")
//*******************
  FUNCTION FUNCTRIMEI
//*******************
  PARAMETERS MODO, PONTEIRO
  PRIVATE POS_CURSOR, REGISTRO, SALVA_TELA
  If Ponteiro=0
     Ponteiro=1
  Endif

  POS_CURSOR=VETOR1[PONTEIRO]
  SET CURSOR ON
  M_NOTA=CEL_NOTA
  M_DAT1=CEL_DATAE

  DO CASE
  CASE LASTKEY()=27
       Sele 52
       Use
       RELEASE POS_CURSOR, REGISTRO, SALVA_TELA
       RELEASE VETOR1,VETOR2
       Keyb(chr(13))
       RETURN(0)
  CASE LASTKEY()=7
       @ row(),03 say "*"
       Confirma()
       If Lastkey()=13
          If Bloqreg(0)
             Delete
          Endif
          Comm
          Unlock
          Alert("Registro Deletado !")
       Endif
       Return(1)
  EndCase
Return(1)

//***************
  PROC Envio_imei(wTipo)            && Envio de Transferencia de IMEI p/ Filiais
//***************
 SET KEY -1 TO
 SET KEY -3 TO
 SET KEY -6 TO
 SET KEY -7 TO
 SET KEY -8 TO
 SET KEY -9 TO
 SET KEY 22 TO
 SET KEY -40 TO
 SET KEY -41 TO

 Sele 52
 Use
 Sele 52
 Exclout(SETCOLOR(),23,"f_imei")
 Go top

 m_transf = cel_transf
 m_lj     = cel_lojatr
 m_para   = cel_para
 ime=savescreen(16,03,20,34)
 cor=setcolor()
 Set Color to n/w
 @ 16,03,19,24 BOX B_SINGLE
 Set color to b+/W
 @ 15,03 Say "Transferˆncia N£mero"
 @ 16,03 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
 @ 17,03 Say "³                    "
 @ 18,03 Say "³P/                  "
 @ 19,03 Say "À"
 @ 17,05 Say m_transf pict "99999999"
 @ 18,07 Say m_para
 Read
 restscreen(16,03,20,34,ime)
 If Lastkey() = 27
    Sele 52
    Use
    Keyb(chr(13))
    Return
 Endif
 Sele 58
 Veriout(setcolor(),23,"filiais")
 Go Top
 While !Eof()
   If Val(fili) = m_lj
      N_Fil = Val(fili)
      W_IP  = Trim(ip_tUNEL)
      Exit
   Endif
   Skip
 Enddo
 Use
 Sele 52
 If Lastkey() = 27
    Release N_Fil,W_IP
    restscreen(09,35,22,55,sslf)
    Use
    Return
 Endif
 If n_fil = 1
    Use
    Alert("Iguatu 1 Esta Desativada !")
    Return
 ElseIf n_fil = 8     && Sobral I
    Use
    Alert("Sobral 1. Esta Desativado !")
    Return
 ElseIf n_fil = 22    && Senador I
    Use
    Alert("Senador-I. Esta Desativado !")
    Return
 ElseIf n_fil = 33    && Senador 3
    Use
    Alert("Senador-3. Esta Desativado !")
    Return
 ElseIf n_fil = 62    && Cariri Shopping
    Use
    Alert("Cariri Shopping. Esta Desativado !")
    Return
 ElseIf n_fil = val(i_fili)
    Use
    Alert("Entrada Recusada. Mesma Filial !")
    Return
 Endif

 mljm = alltrim(strzero(n_fil,2))

 scp = "scp -C f_imei.dbf imei@&w_Ip:/zenir/sistemas/loja&mljm"
 Run &scp

 ssh = 'ssh -C -l imei '+w_Ip+' -t -q "/zenir/modulo/imei/imei "'+mljm+' '+'f_imei.dbf'
 Run &ssh

 Release mljm,scp,ssh,imei,W_ip
 Sele 52
 Go Top
 While !Eof()
   m_imei   = cel_imei
   m_nserie = cel_nserie
   m_dats = cel_datatr
   Sele 44
   If wTipo = 1
      Set Order to 1
      Seek m_imei
   Else
      Set Order to 6
      Seek m_nserie
   Endif
   If !Eof()
      If Bloqreg(0)
         If Empty(cel_para)                  && 1o envio
            Repl cel_datatr with m_dats,cel_transf with m_transf,cel_lojatr with m_lj,cel_para with m_para
         ElseIf Empty(cel_para_2)            && A filial retransmitiu p/ outra
            Repl data_trf_2 with m_dats,transfer_2 with m_transf,cel_para_2 with m_para
         ElseIf Empty(cel_para_3)            && A filial retransmitiu p/ outra
            Repl data_trf_3 with m_dats,transfer_3 with m_transf,cel_para_3 with m_para
         ElseIf Empty(cel_para_4)            && A filial retransmitiu p/ outra
            Repl data_trf_4 with m_dats,transfer_4 with m_transf,cel_para_4 with m_para
         ElseIf Empty(cel_para_5)            && A filial retransmitiu p/ outra
            Repl data_trf_5 with m_dats,transfer_5 with m_transf,cel_para_5 with m_para
         Endif
      Endif
      Unlock
   Endif
   Sele 52
   Skip
   If Eof()
      Exit
   Endif
 Enddo
 Sele 52
 nResp:=0
 nResp:=Alert("Foi enviado com sucesso ?", {"Sim ","N„o "})
 If nResp = 1
    Zap
 Endif
 Use
 Release m_transf,m_imei,m_para,m_dats
 Keyb(chr(13))
Return

//*************************
  Procedure ImportaImeioDoo()
//*************************
  wtelimei=savescreen(15,15,18,76)
 *wChaveNFe  = "23220941426966000334550010003019761476993240"
  wChaveNFe = Space(44)

  Sombra(15,15,17,74,Box)
  @ 16,16 SAY "Chave da NFe:"Get wChaveNFe pict "99999999999999999999999999999999999999999999"
  Read
  If Lastkey() = 27 .or. Empty(wChaveNFe)
     restscreen(15,15,18,76,wtelimei)
     Return
  Endif

  M_Nota = Val(SubStr(wChaveNFe,26,9))

  @ 20,28 Say "Aguarde, Gerando Arquivo CSV  "
  wEnvia := "python3.6 /opt/odoo_rpc/itens_imei_loja.py -c "+wChaveNFe
  !&wEnvia

  wArq = "/tmp/"+wChaveNFe+".csv"

  If !File("/opt/odoo_rpc/itens_imei_loja.py")
     Alert("Arquivo /opt/odoo_rpc/itens_imei_loja.py N„o Encontrado !")
     Return
  Endif

  If !File("&wArq")
     Alert("Arquivo de Imei's N„o Encontrado !")
     Return
  Endif

  Priv wCnpj[10000],wCodigo[10000],wImei[10000],wVrUnitario[10000],wCnpjDestino[10000]

  wRegistrosCSV:=LerCSVcarr(wArq)

  // Conferindo Produtos
  wEof  = .f.
  wEofImei = .f.
  m_ct = 1
  While m_ct <= Val(wRegistrosCSV) -1
    Sele 3
    Set Order to 1
    Seek wCodigo[m_ct]
    IF Eof()
       Alert("Produto N„o Cadastrado ou Arquivo CSV Vazio. Verifique: "+str(wCodigo[m_ct]))
       wEof = .t.
       Exit
    Endif
   /*
    If wImei[m_ct] <> "NumSerie" .and. Len(alltrim(wImei[m_ct])) < 15
       Alert("Imei Incompleto !")
       wEofImei = .t.
       Exit
    Endif
   */
    m_ct++
  Enddo
  If wEof = .t.
     Alert("Registros Recusados. Produto sem Cadastro ou CSV Vazio !")
     Release wEof
     Return
  Endif
  Release wEof
  If wEofImei = .t.
     Alert("Registros Recusados. Produtos sem Imei !")
     Release wEofImei
     Return
  Endif
  Release wEofIMei

  Stor "" to M_LOJAD,M_LOJAP
  m_ct = 1
  While m_ct <= Val(wRegistrosCSV) -1

    If m_ct = 1
       M_forn  = 0
       m_nomef = ""
       BuscaCNPJ(@m_nomef,@m_forn,wCnpj[m_ct])    // funcoes.prg

       Sele 2
       Set Order to 1
       Seek M_FORN
       If !Eof()
          M_Nomef=FN_NOME
       Else
          M_Nomef="FORNECEDOR NAO CADASTRADO !"
       Endif

       Sele 58
       Veriout(setcolor(),23,"filiais")
       Go Top
       While !Eof()
         If Fili <> "01" .and. Fili <> "08" .and. Fili <> "12" .and. Fili <> "15" .and. Fili <> "18" .and. Fili <> "22" .and. Fili <> "33" .and. Fili <> "50" .and. Fili <> "62"
            If cgc = wCnpj[m_ct]
               M_LOJAD = M_Lojad
            Endif
         Endif
         Skip
       Enddo
       Use
       If Empty(M_LOJAD)
          Alert("Loja Destino Errada !")
          Return
       Endif
    Endif

    wnSerie:=CharOnly("ABCDEFGHIJKLMNOPQRSTUWVXZ",wImei[m_ct])
    Sele 44
    If Empty(wnSerie)
       Set Order to 1
       wnSerie = ""
       wnImei = wImei[m_ct]
    Else
       Set Order to 6
       wnSerie = wImei[m_ct]
       wnImei  = ""
    Endif
    Seek wImei[m_ct]
    If !Eof()
       m_ct++
       Loop
    Endif
    If Adireg(0)
       Repl cel_nota with m_nota,cel_codi with wCodigo[m_ct],cel_imei with wnImei,cel_nSerie with wnSerie,;
            cel_valor with wVrUnitario[m_ct],cel_datae with m_datsi,cel_forn with m_forn,;
            cel_nomefo with m_nomef,cel_de with m_Lojad,cel_para with Lojax,bipado with "S"
    Endif
    Comm
    Unlock
    m_ct++
  Enddo
  restscreen(15,15,18,76,wtelimei)
  If m_ct > 1
     Alert("Imei's Importado do oDoo Com Sucesso !")
  Else
     Alert("Imei's N„o Importados; Arquivo Vazio !")
  Endif
  Release wtelimei,wnImei,wnSerie
Return

//===================
  Function LerCSVCarr(wArq)          // Retorna os Itens do csv dos Imei
//===================

 Local nRegistro, cBuffer, nLenArq, nLido
 Local nEol, cConteudo, cLinha
 Local nPointer := 0
 Local cEol := Chr( 10 )

 cArquivoCSV := wArq

 nHandle := FOpen( cArquivoCSV, 2 )

 M = "00001"

 nRegistro := 0
 cBuffer := Space( 1200 )                  // se houver linha maior aumente o 1200
 nLenArq := FSeek( nHandle, nPointer, 2 )  // pega tamanho arquivo
 FSeek( nHandle, nPointer, 0 )             // posiciona o pointer noinicio

 nLido := FRead( nHandle , @cBuffer, 1200 )
 nEol := AT( cEol, cBuffer )
 nPointer += nEol + 1           // vamos ignorar a linha de nomes de campo
 FSeek( nHandle, nPointer, 0 )  // posiciona o pointer na segunda linha

While nEol > 0

nLido := FRead( nHandle , @cBuffer, 1200)
 nEol := AT( cEol, cBuffer )

 If nEol > 0
    cLinha := Left( cBuffer, nEol - 1 )
    wFCount = FCount()
    If FCount() = 0
       wFCount = 6
    Endif
    wtotCampos = 0
    For x=1 To wFCount
       cLinha:= clinha+","         // Inserindo uma virgula no final para ler o ultimo campo
       cConteudo:=SubSt( cLinha, 0, At( ",", cLinha ) )
       cLinha:= StrTran( cLinha, cConteudo, Nil, 1, 1 )  // remove apenas esta sequencia
       cConteudo:=Left( cConteudo, Len( cConteudo ) - 1 )  // tira o "," do final
       cCampo := Field( x )
       If(At("registro",cConteudo)) >0       // Registro gerado do csv do oDoo (Descartar)
         Exit
       Endif
       wtotCampos++
       If wtotCampos = 2
          wCnpj[&m]  = alltrim(cConteudo)
       ElseIf wtotCampos = 3
          wCodigo[&m] = Val(cConteudo)
       ElseIf wtotCampos = 4
          wImei[&m] = cConteudo
         /*
          Retorno:=CharOnly("ABCDEFGHIJKLMNOPQRSTUWVXZ",cConteudo)
          If Empty(Retorno)
             wImei[&m] = cConteudo
          Else
             wImei[&m] = "NumSerie"
          Endif
         */
       ElseIf wtotCampos = 5
          wVrUnitario[&m] = Val(cConteudo)
       ElseIf wtotCampos = 6
          wCnpjDestino[&m] = cConteudo
          M = STRZERO(VAL(M)+1)
       Endif
    Next
 EndIf

 nPointer += nEol + 1              // incrementa o pointer
 If nPointer >= nLenArq            // se fim de arquivo,
    Exit                           // fim...
 Else                              // se nao,
    FSeek( nHandle, nPointer, 0 )  // posiciona o pointer
 EndIf
Enddo
Return(m)

//********************
  Function AtualizaCSV                // Importacsv do oDoo gerado pelo IBM
//********************
Local nPointer := 0
Local nEol, cConteudo, cLinha
Local nRegistro, cBuffer, nLenArq, nLido
Local cEol := Chr( 10 )

@ 22,25 say "Aguarde, Processando relatorio...."

cArquivoCSV = "/tmp/estoque_geral.csv"
wArq = "scp -C cliecred@168.190.30.253:/tmp/estoque_geral.csv /tmp/"
!&wArq

If !file(cArquivoCSV)
   Alert("Arquivo de Estoque do oDoo nao Encontrado !")
   Return
Endif

nHandle := FOpen( cArquivoCSV, 2 )

Private cCampo

wCnpJFilial:=CharOnly("0123456789",xy_cgc)
wLjm = Alltrim(str(val(i_fili)))

nRegistro := 0
cBuffer := Space( 1200 )                  // se houver linha maior aumente o 1200
nLenArq := FSeek( nHandle, nPointer, 2 )  // pega tamanho arquivo
FSeek( nHandle, nPointer, 0 )             // posiciona o pointer noinicio

nLido := FRead( nHandle , @cBuffer, 1200 )
nEol := AT( cEol, cBuffer )
nPointer += nEol + 1           // vamos ignorar a linha de nomes de campo
FSeek( nHandle, nPointer, 0 )  // posiciona o pointer na segunda linha

While nEol > 0
nLido := FRead( nHandle , @cBuffer, 1200)
 nEol := AT( cEol, cBuffer )

 If nEol > 0
    cLinha := Left( cBuffer, nEol - 1 )
    wFCount = FCount()
    If FCount() = 0
       wFCount = 5                                  // TotaL de Campos
    Endif
    wtotCampos = 0
    For x=1 To 5
       cLinha:= clinha+","         // Inserindo uma virgula no final para ler o ultimo campo
       cConteudo:=SubSt( cLinha, 0, At( ",", cLinha ) )
       cLinha:= StrTran( cLinha, cConteudo, Nil, 1, 1 )  // remove apenas esta sequencia
       cConteudo:=Left( cConteudo, Len( cConteudo ) - 1 )  // tira o "," do final
       cCampo := Field( x )
       If(At("registro",cConteudo)) >0          // Registro gerado do csv do oDoo (Descartar)
         Exit
       Endif
       If cConteudo <> "41426966004321" .or. cConteudo <> "41426966006960"   //  Tiangua 44 desativada e Ze Flex
          wtotCampos++
          If wtotCampos = 1
             wCodigo = Val(cConteudo)
          ElseIf wtotCampos  = 2                  // CNPJ
             wCnpj   =  cConteudo
          ElseIf wtotCampos  = 3
             wSaldo     = Val(cConteudo)
          ElseIf wtotCampos  = 4
             wReservado  = Val(cConteudo)
          ElseIf wtotCampos  = 5
             wDisponivel = Val(cConteudo)
          Endif
          If wtotCampos = 5 .and. wCnpJFilial = wCnpj
             Sele 3
             Set Order to 1
             Seek wCodigo
             If !Eof()
                If CD_CENTL&wLjm <> wDisponivel
                   If RLock()    // Se estiver travado nao atualiza
                      Repl CD_CENTL&wLjm WITH wDisponivel
                   Endif
                   Unlock
                Endif
             Endif
          Endif
       Endif
    Next
 EndIf

 nPointer += nEol + 1            // incrementa o pointer
 If nPointer >= nLenArq          // se fim de arquivo,
    Exit                         // fim...
 Else                            // se nao,
    FSeek( nHandle, nPointer, 0 )  // posiciona o pointer
 EndIf
Enddo
FClose(nHandle)

If File(cArquivoCSV)
  DeleteFile(cArquivoCSV)
Endif

Return

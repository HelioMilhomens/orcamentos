//********************************************
/*
   FILE NAME : PFILE.PRG
   BY        : HELIO-SP
   DESC      : ARQUIVOS "PROCEDURES"
*/
//*******************************************
#include "migracao.ch"
#include "box.ch"

//**************
  PROC CONSULTA
//*************
Set Key 1 to
Set Key -2 to
Set Key -3 to
Set Key -4 to
Set Key -5 to
Set Key -6 to
Set Key -7 to
Set Key -8 to
Set Key 22 to

Set Key -1 to Letrasub()
M_TELA01=SAVESCREEN(00,00,24,80)
Stor 0 to m_codx
While .T.
*Set key -1 to
Set Cursor On

    Set Color to n+/w
    Clear
    M_DATS=CTOD("  /  /   ")
    M_DAT=CTOD("  /  /    ")

    Stor 0 TO M_GRUP,M_FORN,CENTX,M_QUANT,m_transit,M_Pendenc
    Set Color to b+/w
    @ 00,52,08,78 BOX B_SINGLE
    @ 03,00,08,51 BOX B_SINGLE

    Set Color to gr+/w
    @ 00,01 Say "Cod "

    @ 03,00 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"   // Estoque
    @ 04,00 Say "³"
    @ 05,00 Say "³"
    @ 06,00 Say "³"
    @ 07,00 Say "³"
    @ 08,00 Say "À"
    @ 00,52 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"   // Fornecedores
    @ 01,52 Say "³"
    @ 02,52 Say "³"
    @ 03,52 Say "³"
    @ 04,52 Say "³"
    @ 05,52 Say "³"
    @ 06,52 Say "³"
    @ 07,52 Say "³"
    @ 08,52 Say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"   // Grade de Atualizacao

    SETCOLOR("w+/b+")

    @ 09,01 clear to 09,79
    @ 11,01 clear to 11,79
    @ 13,01 clear to 13,79
    @ 17,01 clear to 17,79

    If Loja = 34 .or. Loja = 44 .or. Loja = 49 .or. Loja = 70 .or. Loja = 14
       @ 11,01 Say "                                                S Bened         Ubajara       "
       @ 13,01 Say "                                                Tiangua         Guarac         "
    ElseIf Loja = 37 .or. Loja = 39
    @ 13,01 Say "        Parambu          Taua                                                  "
    ElseIf Loja = 8 .or. Loja = 31 .or. Loja = 48 .or. Loja = 63
       @ 09,01 Say "                                                        Sobr-1  Sobr-2  Sobr-3"
       @ 11,01 Say "                                                        Sobr-4 "
    ElseIf Loja = 2 .or. Loja = 28
       @ 09,01 Say "Iguat-2 Iguat-3"
    ElseIf Loja = 38 .or. Loja = 42 .or. Loja = 43
       @ 13,01 Say "                Tabulei         Limoeir Mo.Nova                                "
    ElseIf Loja = 6 .or. Loja = 9 .or. Loja = 32 .or. Loja = 54 .or. Loja = 62
       @ 09,01 Say "                                         Crato"
       @ 11,01 Say "Juaze-1 Juaze-2 "
       *@ 15,01 Say "        Barbalh "
    ElseIf Loja = 25 .or. Loja = 45 .or. Loja = 53
       @ 17,01 Say "                                Maracan                         Marang."
       @ 19,73 Say "ShopMara"
    ElseIf Loja = 41 .or. Loja = 47
       @ 17,01 Say "                                                Horizon Pacajus                "
    ElseIf Loja = 16 .or. Loja = 17 .or. Loja = 23 .or. Loja = 33 .or. Loja = 65 .or. Loja = 72
       @ 17,01 Say " Barao  Gen.Sam  Sen(2)  Sen(4) P‡ Ferr                                        "
    Endif
    If Loja = 56 .or. Loja = 57 .or. Loja = 58 .or. Loja = 53 .or. Loja = 66
       If Loja = 53
          @ 17,01 Say "                                Maracan                         Marang."
       Endif
       @ 19,01 Say "        MeShopp RioMarK RioMarP"
       @ 19,49 Say "Iguatem"
       @ 19,73 Say "ShopMara"
    Endif
    Set Color to gb+/rg
    @ 21,01 Say "F.Iguat F.Sobr "
    Set Color to w+/rg
    @ 21,17 Say "CDZ Igt"
    @ 21,25 Say "CDZ For"
    @ 21,33 Say "CDZ Sob"
    @ 21,41 Say "CDZ Car"
    If Loja = 37 .or. Loja = 39
       @ 21,49 Say "CDZ Taua"
    Endif
   /*
    Set Color to g+/n
    @ 21,56 Say "  Total "
   */
    Set Color to gr+/w

    @ 09,08 to 22,08
    @ 09,16 to 22,16
    @ 09,24 to 22,24
    @ 09,32 to 22,32
    @ 09,40 to 22,40
    @ 09,48 to 22,48
    @ 09,56 to 22,56
    @ 09,64 to 22,64
    @ 09,72 to 22,72

    @ 21,72 SAY "Garantia"
    @ 23,01 to 23,79
    Set Color to b+/w
    @ 24,01 SAY '[F2]Fatores p/C lculo  [F3]Componentes [F4]Cores [F5]Ficha [F6]Caract [F7]Promoc'
    @ 00,55 say "[F1]Ajuda [F2]Sub_Grupo"
    @ 00,05 get m_codx pict "999999"
    Read
    IF LASTKEY() = 27
       Release M_CODX,M_DATS,M_GRUP,M_FORN,CENTX,M_QUANT,M_DAT,M_QUANTS,M_ANTE,M_AVARIA
       Release M_NOTAS,M_SERIS,M_TOTA,M_AUTO,TEC,M_NOMG,M_DAT1,LINX,M_AUTORIZ,M_TRANSIT
       Release m_txab,m_frt,m_mon,m_entr,obser1,obser2,obser3,m_prz,m_vezes,m_przcpd,m_avista
       Release w_faixap,w_garant_12,w_garant_24,w_opc,w_vrgr,sstgr,w_gr,M_Pendenc,ljm
       Release m_res,m_transit,m_avaria,m_autoriz,m_pendenc,wEletr
       RESTSCREEN(00,00,24,80,M_TELA01)
       Set Key -3 to consulta
       EXIT
    ENDIF

    SELE 3
    SET ORDER TO 1
    SEEK M_CODX
    If EOF()
       Alert("Produto N„o Cadastrado.Verifique...")
       Loop
    Endif
  While .T.
      Set key -1 to
      @ 00,05 SAY STRZERO(CD_CODI,6)
      @ 01,01 SAY SUBSTR(CD_PROD,1,40)
      @ 02,01 SAY "MARCA "+SUBSTR(CD_FABR,1,15)+" COR "+SUBSTR(CD_COR,1,15)

      If !Empty(cd_fl)
         Cor=Setcolor()
         SetColor("r*/w")
         @ 02,38 say "F L"
         Setcolor(Cor)
      Else
         @ 02,38 say "             "
      Endif

      M_GRUP    = CD_GRUP
      M_SBGRUP  = CD_SBGRUP
      M_FORN    = CD_FORN
      M_CODX    = CD_CODI
      M_AVISTA  = CD_AVISTA2
      m_dataprom= CD_PROMO
      m_vrprom  = CD_VRPROMO
      m_dat1    = CD_DAT1
      m_gr      = CD_GR
      m_vezes   = CD_VEZES
      m_prz     = CD_VEND
      m_przcpd  = CD_VEND
      w_faixap  = CD_FAIXAP
      OBSER1    = SUBSTR(CD_OBS,1,78)
      OBSER2    = SUBSTR(CD_OBS,79,78)
      OBSER3    = SUBSTR(CD_OBS,157,78)

      cor=setcolor()
      SetColor("r/w")
      @ 00,12 say "Perfil [   ] [A]      [B]      [C]"
      *@ 00,32 say "Localiz "+cd_local
      setcolor(cor)
      @ 00,20 say cd_perfil
      @ 00,28 say Alltrim(Str(cd_perf_a,6))
      @ 00,37 say Alltrim(Str(cd_perf_b,6))
      @ 00,46 say Alltrim(Str(cd_perf_c,6))

      setcolor(cor)
      W_GR = "N"
      If w_faixap >0
         W_GR = "S"
         Stor 0  to W_garant_12,W_garant_24,W_garant_36
         /*
          If m_datsi < ctod("02/05/2016")  // Encerramento de Contrato da Garantec
             Veriout(SetColor(24),23,"faixapr")
             Set Index to index_faixapr
          Endif
         */
         Sele 101
         If xy_cap_int = "CC"
           Veriout(SetColor(24),23,"faixaprtwgcp")
           Set Index to index_faixaprtwgcp
         Else
            Veriout(SetColor(24),23,"faixaprtwg")
            Set Index to index_faixaprtwg
         Endif
         Go Top
         Seek cdsie->cd_faixap
         While !Eof() .and. faixa = w_faixap
           If M_AVISTA >= DE .and. M_AVISTA <= ATE .and. plano = 12
              w_garant_12 = premio_tot
              If xy_percentgr >0
                 w_garant_12 = w_garant_12 + (w_garant_12*xy_percentgr/100)
              Endif
           Endif
           If M_AVISTA >= DE .and. M_AVISTA <= ATE .and. plano = 24
              w_garant_24 = premio_tot
              If xy_percentgr >0
                 w_garant_24 = w_garant_24 + (w_garant_24*xy_percentgr/100)
              Endif
           Endif
           If M_AVISTA >= DE .and. M_AVISTA <= ATE .and. plano = 36 .and. M_GR >0 .and. M_GR <=12
              w_garant_36 = premio_tot
              If xy_percentgr >0
                 w_garant_36 = w_garant_36 + (w_garant_36*xy_percentgr/100)
              Endif
           Endif
           Skip
         Enddo
         Use
         cor=setcolor()
         setcolor("w+/r")
         subs=savescreen(00,15,01,55)
         If w_faixap = 34 .and. m_avista <= xy_vrtroca
            If w_garant_24 >0 .and. m_gr < 24
  	       @ 00,17 Say "Troca Garantida (12) R$ "+str(w_garant_12,7,2)
  	       @ 01,17 Say "                (24) R$ "+str(w_garant_24,7,2)
            Else
  	       @ 00,17 Say "Troca Garantida R$ "+str(w_garant_12,7,2)
	    Endif
         Else
            If w_garant_24 >0 .and. m_gr < 24
 	       @ 00,17 Say "Garantia Estendida (12) R$ "+str(w_garant_12,7,2)
  	       @ 01,17 Say "                   (24) R$ "+str(w_garant_24,7,2)
            Else
 	       @ 00,17 Say "Garantia Estendida (12) R$ "+str(w_garant_12,7,2)
	    Endif
         Endif
         SetColor(cor)
         Inkey(1)
         Restscreen(00,15,01,55,subs)
         Release subs
      Endif
      Sele 30
      Set Order to 1
      Seek M_codx
      If !Eof()
         CENTX     = CD_SALDO
         M_QUANT   = CD_QUANTE
         M_DAT     = CD_DATAE
         M_QUANTS  = CD_QUANTS
         M_DATS    = CD_DATAS
         M_AVARIA  = CD_AVARIA
         M_AUTORIZ = CD_AUTORIZ
         If cd_transit < 0
            If Bloqreg(0)
               Repl CD_TRANSIT With 0
            Endif
            Comm
            Unlock
         Endif
         M_Transit = CD_TRANSIT
       Else
         Alert("Produto N„o Cadastrado. Atualize Tabela !")
         Exit
       Endif

       Stor 0 to Centx,M_Pendenc,wTransit
       SD_Fisc(M_Codx,,,@Centx,@M_Pendenc,@wTransit)
       M_SdPendenc := SD_Pend(m_codx)
       M_Pendenc = M_Pendenc + M_SdPendenc
       If m_transit <> wTransit
          m_transit = wTransit
       Endif

       @ 01,53 SAY "Grupo "+STRZERO(M_GRUP,3)
       @ 02,53 SAY "Sub Grupo "+STRZERO(M_SBGRUP,3)
       @ 03,53 SAY "Forn  "+STRZERO(M_FORN,3)
       @ 04,53 SAY "U.Entrada "+DTOC(M_DAT)+" "+STRZERO(M_QUANT,4)
       @ 05,53 SAY "U.Sa¡da   "+DTOC(M_DATS)+" "+STRZERO(M_QUANTS,4)
       @ 06,53 SAY "U.At.Pre‡ "+DTOC(M_DAT1)

       Sele 17
       Set Order to 1
       Seek M_GRUP
       IF Eof()
          M_NOMG= SPACE(20)
          M_TABE= 1
       ELSE
          M_NOMG = SUBSTR(GR_NOME,1,14)
          M_TABE = GR_TABE
       ENDIF
       @ 01,64 SAY M_NOMG
       wCom   = 0
       m_NomG = ""
       RetornaEletr(M_SBGRUP,@wCom,@m_NomG)
       If wCom >0
          wEletr = .t.
       Else
          wEletr = .f.
       Endif
       Release wCom
       @ 02,67 SAY m_NomG
       Sele 2
       Set Order to 1
       Seek M_FORN
       If Eof()
          M_NOMG= SPACE(20)
       Else
          M_NOMG = SUBSTR(FN_NOME,1,14)
       Endif
       @ 03,64 SAY M_NOMG

   SELE 3
   SET ORDER TO 1
   SETCOLOR("w+/b+")
   @ 04,01 clear to 07,50
   @ 04,01 SAY "ESTOQUE  "+STRZERO(CENTX,7)
   Stor 0 to m_txab,m_frt,m_mon,M_ENTR
   If xy_cap_int = "CC"
      If m_grup = 4 .or. m_grup = 6
         m_txab = I_TAC             && Tarifa de Cadastro
         m_frt  = I_TXE             && Frete
         m_mon  = I_TXM             && Montagem
      Endif
      If M_SBGRUP = 3 .or. M_SBGRUP = 13   // ( Roupeiros e Cozinhas ) Alterado -> Sr.Ribeiro em 07/02/2014
         m_mon  = 35.00             && Montagem a partir de 09/01/2015 Sr. Mario
      Endif
   Endif
   m_vendag = cd_avista2
   m_vd     = m_vendag + m_txab + m_frt + m_mon

   If m_grup = 8
      cor=setcolor()
      SETCOLOR("gr+/b")
      @ 04,39 SAY "A Vista "
      @ 06,39 SAY "A Prazo 12 x"
      SETCOLOR(cor)
      @ 05,41 SAY cd_avista2 Pict "@E 999,999.99"
      @ 07,41 SAY M_VENDAG PICT "99,999.99"
   Else
      cor=setcolor()
      SETCOLOR("gr+/b")
      @ 04,44 SAY "A Vista"
      @ 06,39 SAY "A Prazo 12 x"
      SETCOLOR(cor)
      @ 05,41 SAY cd_avista2 Pict "@E 999,999.99"
   Endif
   If m_grup = 8
      Set key -1 to pr_avista
   Endif
   If xy_cap_int = "CC"
      If wEletr = .t.
         *m_tx_cc:= RetornaTaxa(99,5,12)     // indice 99 e Indice 5 e 12 vezes (eletrinho e cartao)
         *? m_tx_cc
         *inkey(0)
         m_tx_cc = I_TXELECAP            // Taxa de eletrinho
         *inkey(0)
      Else
         *m_tx_cc:= RetornaTaxa(M_GRUP,5,12) // indice do grupo e Indice 5 e 12 vezes (grupo e cartao)
         *? m_tx_cc
         *inkey(0)
         If M_GRUP = 1 .or. M_GRUP = 2 .or. M_GRUP = 3 .or. M_GRUP = 6 .or. M_GRUP = 9 .or. M_GRUP = 12 .or. M_GRUP = 13 .or. M_GRUP = 14 .or. M_GRUP = 15 .or. M_GRUP = 16 .or. M_GRUP = 17
            m_tx_cc = I_TXELECAP
         ElseIf M_GRUP = 8
            m_tx_cc  = I_TXCELCC           // Taxa de celulares p/ Capital e Interior (cartao)
         ElseIf M_GRUP = 7 .or. M_GRUP = 11
            *m_tx_cc = I_TXINFCAR
            m_tx_cc = I_TXINFCCC
         ElseIf M_GRUP = 4
            m_tx_cc = I_TXMOVCAP          // Taxa de moveis p/ capital (cartao)
         ElseIf M_GRUP = 5
           m_tx_cc = I_TXMOTOS           // Taxa de motos ( Cartao )
         Endif
         *? m_tx_cc
         *inkey(0)
      Endif
   Else
      If wEletr = .t.
         *m_tx_cc:= RetornaTaxa(99,3,12)   // indice 99 e Indice 3 e 12 vezes (eletrinho e carne)
         *? m_tx_cc
         *inkey(0)
         m_tx_cc = I_TXELEINT          // Taxa de eletrinho
         *? m_tx_cc
         *inkey(0)
      Else
         *m_tx_cc:= RetornaTaxa(M_GRUP,3,12)  // indice do grupo e Indice 3 e 12 vezes (grupo e carne)
         *? m_tx_cc
         *inkey(0)
          If M_GRUP = 1 .or. M_GRUP = 2 .or. M_GRUP = 3 .or. M_GRUP = 6 .or. M_GRUP = 9 .or. M_GRUP = 12 .or. M_GRUP = 13 .or. M_GRUP = 14 .or. M_GRUP = 15 .or. M_GRUP = 16 .or. M_GRUP = 17
            m_tx_cc = I_TXELEINT
         ElseIf M_GRUP = 8
            m_tx_cc = I_TXCELCAR
         ElseIf M_GRUP = 7 .or. M_GRUP = 11
            m_tx_cc = I_TXINFCAR
         ElseIf M_GRUP = 4
            m_tx_cc = I_TXMOVINT          // Taxa de moveis p/ interior (cartao)
         ElseIf M_GRUP = 5
            m_tx_cc = I_TXELEINT           // Taxa de motos ( Carnet )
         Endif
         *? m_tx_cc
         *inkey(0)
      Endif
   Endif

   // Solicitado por Joaozinho em 27/10/2021 S Benedito
   M_PRZ = Parc_Fin(m_vendag,M_TX_CC,12,.f.)

   @ 07,41 say M_PRZ pict "@E 99,999.99"
   Stor 0 to M_Res

   M_Res := Ret_Res(m_codx)    // Funcoes.prg

   Sele 4
   Set Order to 2
   Go Top
   Seek Str(M_codx,6,0)+substr(dtoc(m_datsi),7,4)+substr(dtoc(m_datsi),4,2)+substr(dtoc(m_datsi),1,2)
   Stor 0 to wAfaturar
   While !Eof() .and. sd_codi = m_codx .and. sd_data = m_datsi
    If Trim(sd_saida) = "LOJA/MOSTR"
       wNota = SD_Nota
       wJaFat := SD_JaFat(sd_codi,sd_nota)
       If wJafat = 0
          wAfaturar = wAfaturar + sd_qtde
          If M_PENDENC >0
             Stor 0 to wSaldo
             Sele 54
             Set Order to 2
             Seek M_codx
             While !Eof() .and. CODIGO = M_codx
              If Empty(Data_Fat) .and. Minuta = wNota
                 wAfaturar = wAfaturar - Quant
              Endif
              Skip
             Enddo
          Endif
       Endif
    Endif
    Sele 4
    Set Order to 2
    Skip
   Enddo
 
   CENTX = CENTX - (M_RES+M_AVARIA+M_TRANSIT+M_PENDENC+wAfaturar)  // Autorizada ja na NFe

   @ 04,19 SAY "A Faturar "+STRzero(wAfaturar,7)
   @ 05,01 SAY "Avarias  "+STRzero(M_AVARIA,7)
   @ 05,19 SAY "Em Trƒns  "+STRZERO(M_TRANSIT,7)
   @ 06,01 SAY "Autoriz  "+STRzero(M_AUTORIZ,7)
   @ 06,19 SAY "Pendenc   "+STRZERO(M_PENDENC,7)
   @ 07,01 SAY "Reserva  "+STRzero(M_RES,7)

   Release datex,datex1,m_datw,m_res,wAfaturar,wJafat,wAfaturar,wJafat

    cor=setcolor()
    SETCOLOR("gr+/b")
    @ 07,19 say "Virtual   "+Str(CENTX,7)
    setcolor(cor)

    SELE 3
    SET ORDER TO 1
    @ 07,53 SAY "Atual                    "
    @ 07,59 SAY dtoc(CD_DATAAT)+" as  "
    @ 07,70 SAY trim(CD_HORAAT)
    SETCOLOR("w+/n")
    cor=setcolor()

    If Loja = 2 .or. Loja = 28
       If Loja = 2
          If CENTX <0
             SETCOLOR("r/n")
          Endif
          @ 10,01 SAY CENTX pict "9999999"
          SETCOLOR(cor)
          If cd_centl28 <0
             SETCOLOR("r/n")
          Endif
          @ 10,09 SAY CD_CENTL28 pict "9999999"
          SETCOLOR(cor)
       ElseIf Loja = 28
          If CENTX <0
             SETCOLOR("r/n")
          Endif
          @ 10,09 SAY CENTX pict "9999999"
          SETCOLOR(cor)
          If cd_centl2 <0
             SETCOLOR("r/n")
          Endif
          @ 10,01 SAY CD_CENTL2 pict "9999999"
          SETCOLOR(cor)
       Endif
    Endif
    SETCOLOR(cor)
    If Loja = 6 .or. Loja = 9 .or. Loja = 32
       If Loja = 6
          If CENTX <0
             SETCOLOR("r/n")
          Endif
          @ 10,41 SAY CENTX pict "9999999"
          SETCOLOR(cor)
          If cd_centl9 <0
             SETCOLOR("r/n")
          Endif
          @ 12,01 SAY CD_CENTL9  pict "9999999"
          SETCOLOR(cor)
          If cd_centl32 <0
             SETCOLOR("r/n")
          Endif
          @ 12,09 SAY CD_CENTL32 pict "9999999"
          SETCOLOR(cor)
       ElseIf Loja = 9
          If CENTX <0
             SETCOLOR("r/n")
          Endif
          @ 12,01 SAY CENTX pict "9999999"
          SETCOLOR(cor)
          If cd_centl6 <0
             SETCOLOR("r/n")
          Endif
          @ 10,41 SAY CD_CENTL6 pict "9999999"
          SETCOLOR(cor)
          If cd_centl32 <0
             SETCOLOR("r/n")
          Endif
          @ 12,09 SAY CD_CENTL32 pict "9999999"
          SETCOLOR(cor)
       ElseIf Loja = 32
          If CENTX <0
             SETCOLOR("r/n")
          Endif
          @ 12,09 SAY CENTX pict "9999999"
          SETCOLOR(cor)
          If cd_centl9 <0
             SETCOLOR("r/n")
          Endif
          @ 12,01 SAY CD_CENTL9  pict "9999999"
          SETCOLOR(cor)
          If cd_centl6 <0
             SETCOLOR("r/n")
          Endif
          @ 10,41 SAY CD_CENTL6 pict "9999999"
          SETCOLOR(cor)
       Endif
    Endif
    SETCOLOR(cor)
    If Loja = 8 .or. Loja = 31 .or. Loja = 48 .or. Loja = 63
       If Loja = 08
          If CENTX <0
             SETCOLOR("r/n")
          Endif
          @ 10,57 SAY CENTX pict "9999999"
          SETCOLOR(cor)
          If cd_centl31 <0
             SETCOLOR("r/n")
          Endif
          @ 10,65 SAY CD_CENTL31 pict "9999999"
          SETCOLOR(cor)
          If cd_centl48 <0
             SETCOLOR("r/n")
          Endif
          @ 10,73 SAY CD_CENTL48 pict "9999999"
          SETCOLOR(cor)
          If cd_centl63 <0
             SETCOLOR("r/n")
          Endif
          @ 12,57 SAY CD_CENTL63 pict "9999999"
       ElseIf Loja = 31
          If CENTX <0
             SETCOLOR("r/n")
          Endif
          @ 10,65 SAY CENTX pict "9999999"
          SETCOLOR(cor)
          If cd_centl8 <0
             SETCOLOR("r/n")
          Endif
          @ 10,57 SAY CD_CENTL8 pict "9999999"
          SETCOLOR(cor)
          If cd_centl48 <0
             SETCOLOR("r/n")
          Endif
          @ 10,73 SAY CD_CENTL48 pict "9999999"
          SETCOLOR(cor)
          If cd_centl63 <0
             SETCOLOR("r/n")
          Endif
          @ 12,57 SAY CD_CENTL63 pict "9999999"
       ElseIf Loja = 48
          If CENTX <0
             SETCOLOR("r/n")
          Endif
          @ 10,73 SAY CENTX pict "9999999"
          SETCOLOR(cor)
          If cd_centl8 <0
             SETCOLOR("r/n")
          Endif
          @ 10,57 SAY CD_CENTL8 pict "9999999"
          SETCOLOR(cor)
          If cd_centl31 <0
             SETCOLOR("r/n")
          Endif
          @ 10,65 SAY CD_CENTL31 pict "9999999"
          SETCOLOR(cor)
          If cd_centl63 <0
             SETCOLOR("r/n")
          Endif
          @ 12,57 SAY CD_CENTL63 pict "9999999"
       ElseIf Loja = 63
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 12,57 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl8 <0
            SETCOLOR("r/n")
         Endif
         @ 10,57 SAY CD_CENTL8 pict "9999999"
         SETCOLOR(cor)
         If cd_centl31 <0
            SETCOLOR("r/n")
         Endif
         @ 10,65 SAY CD_CENTL31 pict "9999999"
         SETCOLOR(cor)
         If cd_centl48 <0
            SETCOLOR("r/n")
         Endif
         @ 10,73 SAY CD_CENTL48 pict "9999999"
       Endif
    Endif
   SETCOLOR(cor)
   If Loja = 38 .or. Loja = 42 .or. Loja = 43
      If Loja = 38
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 14,17 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl42 <0
            SETCOLOR("r/n")
         Endif
         @ 14,33 SAY CD_CENTL42 pict "9999999"
         SETCOLOR(cor)
         If cd_centl43 <0
            SETCOLOR("r/n")
         Endif
         @ 14,41 SAY CD_CENTL43 pict "9999999"
      ElseIf Loja = 42
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 14,33 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl38 <0
            SETCOLOR("r/n")
         Endif
         @ 14,17 SAY CD_CENTL38 pict "9999999"
         SETCOLOR(cor)
         If cd_centl43 <0
            SETCOLOR("r/n")
         Endif
         @ 14,41 SAY CD_CENTL43 pict "9999999"
      ElseIf Loja = 43
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 14,41 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl38 <0
            SETCOLOR("r/n")
         Endif
         @ 14,17 SAY CD_CENTL38 pict "9999999"
         SETCOLOR(cor)
         If cd_centl42 <0
            SETCOLOR("r/n")
         Endif
         @ 14,33 SAY CD_CENTL42 pict "9999999"
      Endif
   Endif
   SETCOLOR(cor)
   If Loja = 34 .or. Loja = 44 .or. Loja = 49 .or. Loja = 70 .or. Loja = 14
      If Loja = 34
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 12,65 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl70 <0
            SETCOLOR("r/n")
         Endif
         @ 12,49 SAY CD_CENTL70 pict "9999999"
         SETCOLOR(cor)
         If cd_centl14 <0
            SETCOLOR("r/n")
         Endif
         @ 14,49 SAY CD_CENTL14 pict "9999999"
         SETCOLOR(cor)
         If cd_centl49 <0
            SETCOLOR("r/n")
         Endif
         @ 14,65 SAY CD_CENTL49 pict "9999999"
      ElseIf Loja = 49
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 14,65 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl70 <0
            SETCOLOR("r/n")
         Endif
         @ 12,49 SAY CD_CENTL70 pict "9999999"
         SETCOLOR(cor)
         If cd_centl34 <0
            SETCOLOR("r/n")
         Endif
         @ 12,65 SAY CD_CENTL34 pict "9999999"
         SETCOLOR(cor)
         If cd_centl14 <0
            SETCOLOR("r/n")
         Endif
         @ 14,49 SAY CD_CENTL14 pict "9999999"
      ElseIf Loja = 44 .or. Loja = 14
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 14,49 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl70 <0
            SETCOLOR("r/n")
         Endif
         @ 12,49 SAY CD_CENTL70 pict "9999999"
         SETCOLOR(cor)
         If cd_centl34 <0
            SETCOLOR("r/n")
         Endif
         @ 12,65 SAY CD_CENTL34 pict "9999999"
         SETCOLOR(cor)
         If cd_centl49 <0
            SETCOLOR("r/n")
         Endif
         @ 14,65 SAY CD_CENTL49 pict "9999999"
      ElseIf Loja = 70
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 12,49 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl14 <0
            SETCOLOR("r/n")
         Endif
         @ 14,49 SAY CD_CENTL14 pict "9999999"
         SETCOLOR(cor)
         If cd_centl34 <0
            SETCOLOR("r/n")
         Endif
         @ 12,65 SAY CD_CENTL34 pict "9999999"
         SETCOLOR(cor)
         If cd_centl49 <0
            SETCOLOR("r/n")
         Endif
         @ 14,65 SAY CD_CENTL49 pict "9999999"
      Endif
   Endif
   SETCOLOR(cor)
   If Loja = 37 .or. Loja = 39
      If Loja = 37
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 14,09 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl39 <0
            SETCOLOR("r/n")
         Endif
         @ 14,25 SAY CD_CENTL39 pict "9999999"
      ElseIf Loja = 39
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 14,25 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl37 <0
            SETCOLOR("r/n")
         Endif
         @ 14,09 SAY CD_CENTL37 pict "9999999"
      Endif
   Endif
   If Loja = 41 .or. Loja = 47
      If Loja = 41
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 18,49 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl47 <0
            SETCOLOR("r/n")
         Endif
         @ 18,57 SAY CD_CENTL47 pict "9999999"
      ElseIf Loja = 47
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 18,57 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl41 <0
            SETCOLOR("r/n")
         Endif
         @ 18,49 SAY CD_CENTL41 pict "9999999"
      Endif
   Endif
   If Loja = 25 .or. Loja = 45
      If Loja = 25
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 18,33 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl45 <0
            SETCOLOR("r/n")
         Endif
         @ 18,65 SAY CD_CENTL45 pict "9999999"
         SETCOLOR(cor)
         If cd_centl53 <0
            SETCOLOR("r/n")
         Endif
         @ 18,73 SAY CD_CENTL53 pict "9999999"
      ElseIf Loja = 45
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 18,65 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl25 <0
            SETCOLOR("r/n")
         Endif
         @ 18,33 SAY CD_CENTL25 pict "9999999"
         SETCOLOR(cor)
         If cd_centl53 <0
            SETCOLOR("r/n")
         Endif
         @ 18,73 SAY CD_CENTL53 pict "9999999"
      Endif
   Endif
   If Loja = 56 .or. Loja = 57 .or. Loja = 58 .or. Loja = 53 .or. Loja = 66
      If Loja = 53
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 20,73 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl25 <0
            SETCOLOR("r/n")
         Endif
         @ 18,33 SAY CD_CENTL25 pict "9999999"
         SETCOLOR(cor)
         If cd_centl45 <0
            SETCOLOR("r/n")
         Endif
         @ 18,65 SAY CD_CENTL45 pict "9999999"
         SETCOLOR(cor)
         If cd_centl56 <0
            SETCOLOR("r/n")
         Endif
         @ 20,09 SAY CD_CENTL56 pict "9999999"
         SETCOLOR(cor)
         If cd_centl57 <0
            SETCOLOR("r/n")
         Endif
         @ 20,17 SAY CD_CENTL57 pict "9999999"
         SETCOLOR(cor)
         If cd_centl58 <0
            SETCOLOR("r/n")
         Endif
         @ 20,25 SAY CD_CENTL58 pict "9999999"
         SETCOLOR(cor)
         If cd_centl66 <0
            SETCOLOR("r/n")
         Endif
         @ 20,49 SAY CD_CENTL66 pict "9999999"
         SETCOLOR(cor)
      ElseIf Loja = 56
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 20,09 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl57 <0
            SETCOLOR("r/n")
         Endif
         @ 20,17 SAY CD_CENTL57 pict "9999999"
         SETCOLOR(cor)
         If cd_centl58 <0
            SETCOLOR("r/n")
         Endif
         @ 20,25 SAY CD_CENTL58 pict "9999999"
         SETCOLOR(cor)
         If cd_centl53 <0
            SETCOLOR("r/n")
         Endif
         @ 20,73 SAY CD_CENTL53 pict "9999999"
         SETCOLOR(cor)
         If cd_centl66 <0
            SETCOLOR("r/n")
         Endif
         @ 20,49 SAY CD_CENTL66 pict "9999999"
         SETCOLOR(cor)
      ElseIf Loja = 57
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 20,17 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl56 <0
            SETCOLOR("r/n")
         Endif
         @ 20,09 SAY CD_CENTL56 pict "9999999"
         SETCOLOR(cor)
         If cd_centl58 <0
            SETCOLOR("r/n")
         Endif
         @ 20,25 SAY CD_CENTL58 pict "9999999"
         SETCOLOR(cor)
         If cd_centl53 <0
            SETCOLOR("r/n")
         Endif
         @ 20,73 SAY CD_CENTL53 pict "9999999"
         SETCOLOR(cor)
         If cd_centl66 <0
            SETCOLOR("r/n")
         Endif
         @ 20,49 SAY CD_CENTL66 pict "9999999"
         SETCOLOR(cor)
      ElseIf Loja = 58
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 20,25 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl56 <0
            SETCOLOR("r/n")
         Endif
         @ 20,09 SAY CD_CENTL56 pict "9999999"
         SETCOLOR(cor)
         If cd_centl57 <0
            SETCOLOR("r/n")
         Endif
         @ 20,17 SAY CD_CENTL57 pict "9999999"
         SETCOLOR(cor)
         If cd_centl53 <0
            SETCOLOR("r/n")
         Endif
         @ 20,73 SAY CD_CENTL53 pict "9999999"
         SETCOLOR(cor)
         If cd_centl66 <0
            SETCOLOR("r/n")
         Endif
         @ 20,49 SAY CD_CENTL66 pict "9999999"
         SETCOLOR(cor)
      ElseIf Loja = 66    // Iguatemi
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 20,49 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl56 <0
            SETCOLOR("r/n")
         Endif
         @ 20,09 SAY CD_CENTL56 pict "9999999"
         SETCOLOR(cor)
         If cd_centl58 <0
            SETCOLOR("r/n")
         Endif
         @ 20,25 SAY CD_CENTL58 pict "9999999"
         SETCOLOR(cor)
         If cd_centl57 <0
            SETCOLOR("r/n")
         Endif
         @ 20,17 SAY CD_CENTL57 pict "9999999"
         SETCOLOR(cor)
         If cd_centl53 <0
            SETCOLOR("r/n")
         Endif
         @ 20,73 SAY CD_CENTL53 pict "9999999"
         SETCOLOR(cor)
      Endif
   Endif
   If Loja = 16 .or. Loja = 17 .or. Loja = 23 .or. Loja = 65 .or. Loja = 72
      If Loja = 16
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 18,01 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl17 <0
            SETCOLOR("r/n")
         Endif
         @ 18,09 SAY CD_CENTL17 pict "9999999"
         SETCOLOR(cor)
         If cd_centl23 <0
            SETCOLOR("r/n")
         Endif
         @ 18,17 SAY CD_CENTL23 pict "9999999"
         SETCOLOR(cor)
         If cd_centl65 <0
            SETCOLOR("r/n")
         Endif
         @ 18,25 SAY CD_CENTL65 pict "9999999"
         SETCOLOR(cor)
         If cd_centl72 <0
            SETCOLOR("r/n")
         Endif
         @ 18,33 SAY CD_CENTL72 pict "9999999"
      ElseIf Loja = 17
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 18,09 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl16 <0
            SETCOLOR("r/n")
         Endif
         @ 18,01 SAY CD_CENTL16 pict "9999999"
         SETCOLOR(cor)
         If cd_centl23 <0
            SETCOLOR("r/n")
         Endif
         @ 18,17 SAY CD_CENTL23 pict "9999999"
         SETCOLOR(cor)
         If cd_centl65 <0
            SETCOLOR("r/n")
         Endif
         @ 18,25 SAY CD_CENTL65 pict "9999999"
         SETCOLOR(cor)
         If cd_centl72 <0
            SETCOLOR("r/n")
         Endif
         @ 18,33 SAY CD_CENTL72 pict "9999999"
      ElseIf Loja = 23
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 18,17 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl16 <0
            SETCOLOR("r/n")
         Endif
         @ 18,01 SAY CD_CENTL16 pict "9999999"
         SETCOLOR(cor)
         If cd_centl17 <0
            SETCOLOR("r/n")
         Endif
         @ 18,09 SAY CD_CENTL17 pict "9999999"
         SETCOLOR(cor)
         If cd_centl65 <0
            SETCOLOR("r/n")
         Endif
         @ 18,25 SAY CD_CENTL65 pict "9999999"
         SETCOLOR(cor)
         If cd_centl72 <0
            SETCOLOR("r/n")
         Endif
         @ 18,33 SAY CD_CENTL72 pict "9999999"
      ElseIf Loja = 65
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 18,25 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl16 <0
            SETCOLOR("r/n")
         Endif
         @ 18,01 SAY CD_CENTL16 pict "9999999"
         SETCOLOR(cor)
         If cd_centl17 <0
            SETCOLOR("r/n")
         Endif
         @ 18,09 SAY CD_CENTL17 pict "9999999"
         If cd_centl23 <0
            SETCOLOR("r/n")
         Endif
         @ 18,17 SAY CD_CENTL23 pict "9999999"
         SETCOLOR(cor)
         If cd_centl65 <0
            SETCOLOR("r/n")
         Endif
         SETCOLOR(cor)
         If cd_centl72 <0
            SETCOLOR("r/n")
         Endif
         @ 18,33 SAY CD_CENTL72 pict "9999999"
      ElseIf Loja = 72
         If CENTX <0
            SETCOLOR("r/n")
         Endif
         @ 18,33 SAY CENTX pict "9999999"
         SETCOLOR(cor)
         If cd_centl16 <0
            SETCOLOR("r/n")
         Endif
         @ 18,01 SAY CD_CENTL16 pict "9999999"
         SETCOLOR(cor)
         If cd_centl17 <0
            SETCOLOR("r/n")
         Endif
         @ 18,09 SAY CD_CENTL17 pict "9999999"
         If cd_centl23 <0
            SETCOLOR("r/n")
         Endif
         @ 18,17 SAY CD_CENTL23 pict "9999999"
         SETCOLOR(cor)
         If cd_centl65 <0
            SETCOLOR("r/n")
         Endif
         @ 18,25 SAY CD_CENTL65 pict "9999999"
      Endif
   Endif

   SETCOLOR(cor)
   If cd_centl15 <0
      SETCOLOR("r/n")
   Endif
   @ 22,01 SAY CD_CENTL15 pict "9999999"
   SETCOLOR(cor)
   If cd_centl50 <0
      SETCOLOR("r/n")
   Endif
   @ 22,09 SAY CD_CENTL50 pict "9999999"
   SETCOLOR(cor)
   If cd_centl20 <0
      SETCOLOR("r/n")
   Endif
   @ 22,17 SAY CD_CENTL20 pict "9999999"
   SETCOLOR(cor)
   If cd_centl19 <0
      SETCOLOR("r/n")
   Endif
   @ 22,25 SAY CD_CENTL19 pict "9999999"
   SETCOLOR(cor)
   If cd_centl11 <0
      SETCOLOR("r/n")
   Endif
   @ 22,33 SAY CD_CENTL11 pict "9999999"
   SETCOLOR(cor)
   If cd_centl99 <0
      SETCOLOR("r/n")
   Endif
   @ 22,41 SAY CD_CENTL99 pict "9999999"
   SETCOLOR(cor)
   If Loja = 37 .or. Loja = 39
      If cd_centl10 <0               // CD Taua
         SETCOLOR("r/n")
      Endif
      @ 22,49 SAY CD_CENTL10 pict "9999999"
   Endif
   SETCOLOR(cor)
   If centx < 0
      SETCOLOR("r/n")
   Endif

 If Loja = 15
    @ 22,01 SAY centx pict "9999999"    && Feirao Iguatu
 ElseIf Loja = 50
    @ 22,09 SAY centx pict "9999999"    && Feirao Sobral
 ELseIf Loja = 20
    setcolor("b/g")
    @ 22,17 SAY centx pict "9999999"
    setcolor("bg+/b")
    m_totx=cd_centl1+cd_centl2+cd_centl3+cd_centl4+cd_centl5+cd_centl6+cd_centl7+cd_centl8+cd_centl9+cd_centl11+cd_centl13+cd_centl14+cd_centl15+cd_centl16+cd_centl17+cd_centl18+cd_centl19+centx+cd_centl21+cd_centl22+cd_centl23+cd_centl24+cd_centl25+cd_centl26+cd_centl27+cd_centl28+cd_centl29+cd_centl50+cd_centl99+cd_centl30+cd_centl31+cd_centl32+cd_centl33+cd_centl34+cd_centl35+cd_centl36+cd_centl37+cd_centl38+cd_centl39+cd_centl40+cd_centl41+cd_centl42+cd_centl43+cd_centl44+cd_centl45+cd_centl46+cd_centl47+cd_centl48+cd_centl49+cd_centl10+cd_centl51+cd_centl52+cd_centl53+cd_centl54+cd_centl55+cd_centl56+cd_centl57+cd_centl58+cd_centl59+cd_centl60+cd_centl61+cd_centl62+cd_centl63+cd_centl64+cd_centl65+cd_centl66+cd_centl67+cd_centl68+cd_centl69+cd_centl70+cd_centl71+cd_centl72+cd_centl73+cd_centl74+cd_centl75
 ElseIf Loja = 19
    setcolor("b/g")
    @ 22,25 SAY centx pict "9999999"    && CDZ Fortaleza
    setcolor("bg+/b")
    m_totx=cd_centl1+cd_centl2+cd_centl3+cd_centl4+cd_centl5+cd_centl6+cd_centl7+cd_centl8+cd_centl9+cd_centl11+cd_centl13+cd_centl14+cd_centl15+cd_centl16+cd_centl17+cd_centl18+centx+cd_centl20+cd_centl21+cd_centl22+cd_centl23+cd_centl24+cd_centl25+cd_centl26+cd_centl27+cd_centl28+cd_centl29+cd_centl50+cd_centl99+cd_centl30+cd_centl31+cd_centl32+cd_centl33+cd_centl34+cd_centl35+cd_centl36+cd_centl37+cd_centl38+cd_centl39+cd_centl40+cd_centl41+cd_centl42+cd_centl43+cd_centl44+cd_centl45+cd_centl46+cd_centl47+cd_centl48+cd_centl49+cd_centl10+cd_centl51+cd_centl52+cd_centl53+cd_centl54+cd_centl55+cd_centl56+cd_centl57+cd_centl58+cd_centl59+cd_centl60+cd_centl61+cd_centl62+cd_centl63+cd_centl64+cd_centl65+cd_centl66+cd_centl67+cd_centl68+cd_centl69+cd_centl70+cd_centl71+cd_centl72+cd_centl73+cd_centl74+cd_centl75
 ElseIf Loja = 11                        && CDZ Sobral
    setcolor("b/g")
    @ 22,33 SAY centx pict "9999999"
    setcolor("bg+/b")
    m_totx=cd_centl1+cd_centl2+cd_centl3+cd_centl4+cd_centl5+cd_centl6+cd_centl7+cd_centl8+cd_centl9+centx+cd_centl13+cd_centl14+cd_centl15+cd_centl16+cd_centl17+cd_centl18+cd_centl19+cd_centl20+cd_centl21+cd_centl22+cd_centl23+cd_centl24+cd_centl25+cd_centl26+cd_centl27+cd_centl28+cd_centl29+cd_centl50+cd_centl99+cd_centl30+cd_centl31+cd_centl32+cd_centl33+cd_centl34+cd_centl35+cd_centl36+cd_centl37+cd_centl38+cd_centl39+cd_centl40+cd_centl41+cd_centl42+cd_centl43+cd_centl44+cd_centl45+cd_centl46+cd_centl47+cd_centl48+cd_centl49+cd_centl10+cd_centl51+cd_centl52+cd_centl53+cd_centl54+cd_centl55+cd_centl56+cd_centl57+cd_centl58+cd_centl59+cd_centl60+cd_centl61+cd_centl62+cd_centl63+cd_centl64+cd_centl65+cd_centl66+cd_centl67+cd_centl68+cd_centl69+cd_centl70+cd_centl71+cd_centl72+cd_centl73+cd_centl74+cd_centl75
 ElseIf Loja = 99                        && CD Juazeiro
    setcolor("b/g")
    @ 22,41 SAY centx pict "9999999"
    setcolor("bg+/b")
    m_totx=cd_centl1+cd_centl2+cd_centl3+cd_centl4+cd_centl5+cd_centl6+cd_centl7+cd_centl8+cd_centl9+cd_centl11+cd_centl13+cd_centl14+cd_centl15+cd_centl16+cd_centl17+cd_centl18+cd_centl19+cd_centl20+cd_centl21+cd_centl22+cd_centl23+cd_centl24+cd_centl25+cd_centl26+cd_centl27+cd_centl28+cd_centl29+centx+cd_centl50+cd_centl30+cd_centl31+cd_centl32+cd_centl33+cd_centl34+cd_centl35+cd_centl36+cd_centl37+cd_centl38+cd_centl39+cd_centl40+cd_centl41+cd_centl42+cd_centl43+cd_centl44+cd_centl45+cd_centl46+cd_centl47+cd_centl48+cd_centl49+cd_centl10+cd_centl51+cd_centl52+cd_centl53+cd_centl54+cd_centl55+cd_centl56+cd_centl57+cd_centl58+cd_centl59+cd_centl60+cd_centl61+cd_centl62+cd_centl63+cd_centl64+cd_centl65+cd_centl66+cd_centl67+cd_centl68+cd_centl69+cd_centl70+cd_centl71+cd_centl72+cd_centl73+cd_centl74+cd_centl75
 ElseIf Loja = 10                          // CDZ Taua
    setcolor("b/g")
    @ 22,49 SAY centx pict "9999999"
    setcolor("bg+/b")
    m_totx=cd_centl1+cd_centl2+cd_centl3+cd_centl4+cd_centl5+cd_centl6+cd_centl7+cd_centl8+cd_centl9+centx+cd_centl11+cd_centl13+cd_centl14+cd_centl15+cd_centl16+cd_centl17+cd_centl18+cd_centl19+cd_centl20+cd_centl21+cd_centl22+cd_centl23+cd_centl24+cd_centl25+cd_centl26+cd_centl27+cd_centl28+cd_centl29+cd_centl50+cd_centl99+cd_centl30+cd_centl31+cd_centl32+cd_centl33+cd_centl34+cd_centl35+cd_centl36+cd_centl37+cd_centl38+cd_centl39+cd_centl40+cd_centl41+cd_centl42+cd_centl43+cd_centl44+cd_centl45+cd_centl46+cd_centl47+cd_centl48+cd_centl49+cd_centl51+cd_centl52+cd_centl53+cd_centl54+cd_centl55+cd_centl56+cd_centl57+cd_centl58+cd_centl59+cd_centl60+cd_centl61+cd_centl62+cd_centl63+cd_centl64+cd_centl65+cd_centl66+cd_centl67+cd_centl68+cd_centl69+cd_centl70+cd_centl71+cd_centl72+cd_centl73+cd_centl74+cd_centl75
 ElseIf Loja = 12                         && Admistracao
    m_totx=cd_centl1+cd_centl2+cd_centl3+cd_centl4+cd_centl5+cd_centl6+cd_centl7+cd_centl8+cd_centl9+cd_centl10+cd_centl11+cd_centl13+cd_centl14+cd_centl15+cd_centl16+cd_centl17+cd_centl18+cd_centl19+cd_centl20+cd_centl21+cd_centl22+cd_centl23+cd_centl24+cd_centl25+cd_centl26+cd_centl27+cd_centl28+cd_centl29+cd_centl50+cd_centl99+cd_centl30+cd_centl31+cd_centl32+cd_centl33+cd_centl34+cd_centl35+cd_centl36+cd_centl37+cd_centl38+cd_centl39+cd_centl40+cd_centl41+cd_centl42+cd_centl43+cd_centl44+cd_centl45+cd_centl46+cd_centl47+cd_centl48+cd_centl49+cd_centl51+cd_centl52+cd_centl53+cd_centl54+cd_centl55+cd_centl56+cd_centl57+cd_centl58+cd_centl59+cd_centl60+cd_centl61+cd_centl62+cd_centl63+cd_centl64+cd_centl65+cd_centl66+cd_centl67+cd_centl68+cd_centl69+cd_centl70+cd_centl71+cd_centl72+cd_centl73+cd_centl74+cd_centl75
 Endif

 SETCOLOR(cor)
 @ 22,72 SAY Strzero(M_GR,2)+" Meses"
 SetColor("b+/w")
 cor=setcolor()
 SETCOLOR("r/w")
*@ 22,57 say m_totx pict "9999999"
 SETCOLOR(cor)

    If cd_compo = 0 .and. cd_cust <=0
       Alert("Produto Com Custo Zerado. Comunique CPD !")
    Endif

    TEC =INKEY()
    WHILE TEC <> 27 .AND. TEC <> 5 .AND. TEC <> 24 .AND. TEC <> -1 .AND. TEC <> -2 .AND. TEC <> -3 .AND. TEC <> -4 .AND. TEC <> -5 .AND. TEC <> -6 .AND. TEC <> 13
      TEC = INKEY(0)
    ENDDO
       IF TEC = 27 .OR. TEC = 13
          EXIT
       ENDIF
       IF TEC = -4           // Ficha de Estoque
          SST=SAVESCREEN(0,0,24,78)
	  Keyb(chr(13))
          Ficha(m_codx)
          RESTSCREEN(0,0,24,78,SST)
       ENDIF
       IF TEC = 5
          SKIP - 1
          M_CODX=CD_CODI
          IF BOF()
             GOTO BOTT
          ENDIF
       ENDIF
       IF TEC = 24
          SKIP
          M_CODX=CD_CODI
          IF EOF()
             GOTO TOP
          ENDIF
       ENDIF
 If TEC = -6
    cor=setcolor()
    SST=SAVESCREEN(00,01,24,78)
    m_passci = "n"
    Sele 57
    Set Order to 1
    Seek Str(m_codx,6,0)
    While !Eof() .and. ci_codigo = m_codx
     If ci_datini <= m_datsi .and. ci_datlimi >= m_datsi
        m_passci = "s"
        Exit
     Endif
     Skip
    Enddo
    If m_passci = "s"                        && circcpd.dbf
       Set Filter to ci_codigo = m_codx .and. m_datsi >= ci_datini .and. m_datsi <= ci_datlimi
       Go Top
       If !Eof()
          ssor=savescreen(19,01,22,79)

          PRIV VETOR1[10],VETOR2[10]

          VETOR1[1]='CI_CODIGO'
          VETOR1[2]='CI_AVISTA'
          VETOR1[3]='CI_XAP'
          VETOR1[4]='CI_APRAZO'
          VETOR1[5]='CI_DATINI'
          VETOR1[6]='CI_DATLIMI'
          VETOR1[7]='CI_TIPO'
          VETOR1[8]='CI_AUTORIZ'
          VETOR1[9]='CI_MODALID'
          VETOR1[10]='CI_LOJA'
          VETOR2[1]='Codigo'
          VETOR2[2]= "A Vista"
          VETOR2[3]='(x)'
          VETOR2[4]='A Prazo'
          VETOR2[5]='Inicio da Promocao'
          VETOR2[6]='Limite da Promocao'
          VETOR2[7]='Tip Circular'
          VETOR2[8]='Nr Autoriz'
          VETOR2[9]='Modalidade'
          VETOR2[10]='Loja'

	  SETCOLOR("nb+/gr")
          DBEDIT(19,01,22,79,VETOR1,,,VETOR2)
          RELEASE VETOR1,VETOR2
          Restscreen(19,01,22,79,ssor)
          Set filter to
	  Go Top
	  Release ssor,vetor1,vetor2,m_passci
       Endif
    Endif
    RESTSCREEN(00,01,24,78,sst)
    setcolor(cor)
 Endif
 IF TEC = -1      && fatores para Calculo
    SST=SAVESCREEN(00,01,24,78)
    SETCOLOR("W+/B+")                      && Tabela para o Interior
    @ 00,52 clear to 08,77
    @ 03,01 clear to 24,77
    SSTGR=SAVESCREEN(18,20,20,73)
    cor=setcolor()
     w_vrgr = 0
     If w_gr = "S"
        mfrt=Savescreen(18,04,24,77)
	SETCOLOR("W+/BG+, B/RG,X")
        If w_faixap <> 34 .AND. M_GR >0 .AND. M_GR < 24
	   If w_garant_24 >0
              @ 18,14 clear to 20,58
              @ 18,14 to 20,58
              @ 19,15 prom "C/Garantia(24)" 
              @ 19,31 prom "C/Garantia(12)" 
	      @ 19,47 prom "S/Garantia" 
	      Menu to w_opc
	      If w_opc = 1
                 If xy_percentgr >0
                    w_garant_24 = w_garant_24 + (w_garant_24*xy_percentgr/100)
                 Endif
 	         w_vrgr = w_garant_24
	      ElseIf w_opc = 2
                 If xy_percentgr >0
                    w_garant_12 = w_garant_12 + (w_garant_12*xy_percentgr/100)
                 Endif
 	         w_vrgr = w_garant_12
	      ElseIf w_opc = 3
 	         w_vrgr = 0
	      Endif
           ElseIf M_GR >0
              @ 18,20 clear to 20,48
              @ 18,20 to 20,48
              @ 19,21 prom "C/Garantia(12)"
	      @ 19,37 prom "S/Garantia"
   	      Menu to w_opc
	      If w_opc = 1
                 If xy_percentgr >0
                    w_garant_12 = w_garant_12 + (w_garant_12*xy_percentgr/100)
                 Endif
 	         w_vrgr = w_garant_12
	      ElseIf w_opc = 2
 	         w_vrgr = 0
	      Endif
	   Endif
        ElseIf w_faixap = 34 .AND. M_GR >0 .AND. M_GR < 24 .and. m_avista > xy_vrtroca
	   If w_garant_24 >0
              @ 18,14 clear to 20,58
              @ 18,14 to 20,58
              @ 19,15 prom "C/Garantia(24)" 
              @ 19,31 prom "C/Garantia(12)" 
	      @ 19,47 prom "S/Garantia" 
	      Menu to w_opc
	      If w_opc = 1
                 If xy_percentgr >0
                    w_garant_24 = w_garant_24 + (w_garant_24*xy_percentgr/100)
                 Endif
 	         w_vrgr = w_garant_24
	      ElseIf w_opc = 2
                 If xy_percentgr >0
                    w_garant_12 = w_garant_12 + (w_garant_12*xy_percentgr/100)
                 Endif
 	         w_vrgr = w_garant_12
	      ElseIf w_opc = 3
 	         w_vrgr = 0
	      Endif
           ElseIf M_GR >0
              @ 18,20 clear to 20,48
              @ 18,20 to 20,48
              @ 19,21 prom "C/Garantia(12)"
	      @ 19,37 prom "S/Garantia"
   	      Menu to w_opc
	      If w_opc = 1
                 If xy_percentgr >0
                    w_garant_12 = w_garant_12 + (w_garant_12*xy_percentgr/100)
                 Endif
 	         w_vrgr = w_garant_12
	      ElseIf w_opc = 2
 	         w_vrgr = 0
	      Endif
	   Endif
        Else                                         // Troca Garantida
	   If w_garant_24 >0 .and. M_GR >0 .and. M_GR < 24 .and. m_avista <= xy_vrtroca
              @ 18,04 clear to 20,65
              @ 18,04 to 20,65
              @ 19,05 prom "Troca Garantida(24)" 
              @ 19,26 prom "Troca Garantida(12)" 
	      @ 19,52 prom "S/Garantia" 
   	      Menu to w_opc
	      If w_opc = 1
                 If xy_percentgr >0
                    w_garant_24 = w_garant_24 + (w_garant_24*xy_percentgr/100)
                 Endif
 	         w_vrgr = w_garant_24
	      ElseIf w_opc = 2
                 If xy_percentgr >0
                    w_garant_12 = w_garant_12 + (w_garant_12*xy_percentgr/100)
                 Endif
 	         w_vrgr = w_garant_12
	      ElseIf w_opc = 3
 	         w_vrgr = 0
	      Endif
           ElseIf M_GR >0 .and. m_avista <= xy_vrtroca
              @ 18,10 clear to 20,47
              @ 18,10 to 20,47
              @ 19,11 prom "Troca Garantida(12)"
	      @ 19,32 prom "S/Garantia"
   	      Menu to w_opc
	      If w_opc = 1
                 If xy_percentgr >0
                    w_garant_12 = w_garant_12 + (w_garant_12*xy_percentgr/100)
                 Endif
 	         w_vrgr = w_garant_12
	      ElseIf w_opc = 2
 	         w_vrgr = 0
	      Endif
	   Endif
	Endif
        Restscreen(18,04,24,77,mfrt)
	setcolor(cor)
        Release w_faixap,mfrt,w_opc
   Endif
   RESTSCREEN(18,20,20,73,SSTGR)
   m_vendag = m_vendag + w_vrgr
   m_vd = m_vendag 
   If xy_cap_int = "CC"
      @ 00,55 SAY "A Vista R$ "get m_vendag pict "@e 999,999.99" valid m_vendag >= m_vd
   ElseIf m_grup = 8
      @ 00,55 SAY "A Vista R$ "get m_vendag pict "@e 999,999.99" valid m_vendag >=m_vd
   Endif    
   @ 01,55 SAY "Entrada R$ "get m_entr pict "@e 999,999.99"
   Read
   @ 00,55 clear to 00,77
   If xy_cap_int = "CC"
      @ 02,55 SAY "T.C.         R$ "get m_txab pict "@e 99.99"
      @ 03,55 SAY "Frete        R$ "get m_frt  pict "@e 99.99"
      @ 04,55 SAY "Montagem     R$ "get m_mon  pict "@e 99.99"
      Read
   Endif

   M_VEND  = M_VENDAG-M_ENTR
   M_VENDAG= M_VEND+M_TXAB+M_FRT+M_MON
   M_PARC  = 12
 
   @ 04,05 say "Parcelas "get m_parc pict "99" Valid m_parc <= 15
   Read
   If Lastkey() = 27
      RESTSCREEN(00,00,24,80,M_TELA01)
      Return
   Endif
   If xy_cap_int = "CC"
      @ 05,67 SAY "Financiado"
      @ 06,67 SAY m_vendag pict "@E 999,999.99"
   ElseIf m_grup = 8
      @ 05,67 SAY "Financiado"
      @ 06,67 SAY m_vendag pict "@E 999,999.99"
   Endif
 /*
   If wEletr = .t.
      m_tx_car:= RetornaTaxa(99,3)        // indice 99 e Indice 3 (eletrinho e carne)
      m_tx_chq:= RetornaTaxa(99,2)
      m_tx_fin:= RetornaTaxa(99,4)
      m_tx_con:= RetornaTaxa(99,3)
      m_tx_cc := RetornaTaxa(99,5)
   Else
      m_tx_car:= RetornaTaxa(M_GRUP,3)    // indice do grupo e Indice 1 (grupo e cartao)
      m_tx_chq:= RetornaTaxa(M_GRUP,2)
      m_tx_fin:= RetornaTaxa(M_GRUP,4)
      m_tx_con:= RetornaTaxa(M_GRUP,3)
      m_tx_cc := RetornaTaxa(M_GRUP,5)
   Endif
 */
   m_tx_car = I_TXCARNE
   m_tx_chq = I_TXCHEQUE
   m_tx_fin = I_TXFINANC
   m_tx_con = I_TXCONVEN

   If xy_cap_int = "CC"
      If wEletr = .t.
        *m_tx_cc:= RetornaTaxa(99,5,12)   // indice 99 e Indice 5 e 12 vezes (eletrinho e cartao)
         m_tx_cc = I_TXELECAP         // Taxa de eletrinho
      Else
        *m_tx_cc:= RetornaTaxa(m_grup,5,12)   // indice 99 e Indice 5 e 12 vezes (eletrinho e cartao)
         If m_grup = 1 .or. m_grup = 2 .or. m_grup = 3 .or. m_grup = 6 .or. m_grup = 9 .or. m_grup = 12 .or. m_grup = 13 .or. m_grup = 14 .or. m_grup = 15 .or. M_GRUP = 16 .or. M_GRUP = 17
            m_tx_cc = I_TXELECAP
         ElseIf m_grup = 8
            m_tx_cc  = I_TXCELCC           // Taxa de celulares p/ capital (cartao)
         ElseIf m_grup = 7 .or. m_grup = 11
            m_tx_cc  = I_TXINFCCC          // Taxa de informtica p/ capital (cartao)
            m_tx_car = I_TXINFCAR
         ElseIf m_grup = 4
            m_tx_cc = I_TXMOVCAP          // Taxa de moveis p/ capital (cartao)
         ElseIf m_grup = 5
            m_tx_cc = I_TXMOTOS           // Taxa de motos ( Cartao ) 
         Endif
      Endif
   Else      && Interior
      If wEletr = .t.
        *m_tx_cc:= RetornaTaxa(99,5,12)   // indice 99 e Indice 5 e 12 vezes (eletrinho e carne)
         m_tx_cc = I_TXELEINT          // Taxa de eletrinho
      Else
        *m_tx_cc:= RetornaTaxa(m_grup,5,12)   // indice 99 e Indice 5 e 12 vezes (eletrinho e carne)
         If m_grup = 1 .or. m_grup = 2 .or. m_grup = 3 .or. m_grup = 6 .or. m_grup = 9 .or. m_grup = 12 .or. m_grup = 13 .or. m_grup = 14 .or. m_grup = 15 .or. m_grup = 16 .or. m_grup = 17
            m_tx_cc = I_TXELEINT
         ElseIf m_grup = 8
            m_tx_cc = I_TXCELCC            // Taxa de celulares p/ interior (cartao)
            m_tx_car = I_TXCELCAR          // Taxa de celulares
         ElseIf m_grup = 7 .or. m_grup = 11
            m_tx_cc  = I_TXINFCCI          // Taxa de informtica p/ interior (cartao)
            m_tx_car = I_TXINFCAR
         ElseIf m_grup = 4
            m_tx_cc = I_TXMOVINT           // Taxa de moveis p/ interior (cartao)
         ElseIf m_grup = 5
            m_tx_cc = I_TXMOTOS            // Taxa de motos ( Cartao ) Igual a de celulares ( Bento )
         Endif
      Endif
   Endif

   // Solicitado por Joaozinho em 27/10/2021 S Benedito
   If (Loja=70) .and. (m_datsi >= ctod("27/10/2021") .and. m_datsi <= ctod("30/11/2021"))
      If m_grup <> 8
         m_tx_cc = 2.92
      Endif
   Endif
   @ 06,05 SAY "Carne            Cheque          Financ/Conv     Cartao         "
   @ 06,10 SAY m_tx_car pict "999.99"+"%"
   @ 06,28 SAY m_tx_chq pict "999.99"+"%"
   @ 06,43 SAY m_tx_fin pict "999.99"+"%"
   @ 06,60 SAY m_tx_cc  pict "999.99"+"%"
   @ 07,05 SAY "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
   @ 08,05 SAY "³PL Vr Parcela   PL Vr.Parcela   PL Vr.Parcela   PL Vr.Parcela ³"
   If m_parc >= 1 
   @ 09,05 SAY "³01              01              01              01            ³"
   m_lin=10
   Endif
   If m_parc >= 2
   @ 10,05 SAY "³02              02              02              02            ³"
   m_lin=11
   Endif
   If m_parc >= 3
   @ 11,05 SAY "³03              03              03              03            ³"
   m_lin=12
   Endif
   If m_parc >= 4
   @ 12,05 SAY "³04              04              04              04            ³"
   m_lin=13
   Endif
   If m_parc >= 5
   @ 13,05 SAY "³05              05              05              05            ³"
   m_lin=14
   Endif
   If m_parc >= 6
   @ 14,05 SAY "³06              06              06              06            ³"
   m_lin=15
   Endif
   If m_parc >= 7
   @ 15,05 SAY "³07              07              07              07            ³"
   m_lin=16
   Endif 
   If m_parc >= 8
   @ 16,05 SAY "³08              08              08              08            ³"
   m_lin=17
   Endif 
   If m_parc >= 9
   @ 17,05 SAY "³09              09              09              09            ³"
   m_lin=18
   Endif 
   If m_parc >= 10
   @ 18,05 SAY "³10              10              10              10            ³"
   m_lin=19
   Endif 
   If m_parc >= 11
   @ 19,05 SAY "³11              11              11              11            ³"
   m_lin=20
   Endif 
   If m_parc >= 12
   @ 20,05 SAY "³12              12              12              12            ³"
   m_lin=21
   Endif 
   If m_parc >= 13
   @ 21,05 SAY "³13              13              13              13            ³"
   m_lin=22
   Endif
   If m_parc >= 14
   @ 22,05 SAY "³14              14              14              14            ³"
   m_lin=23
   Endif 
   If m_parc >= 15
   @ 23,05 SAY "³15              15              15              15            ³"
   m_lin=24
   Endif 
   @ m_lin,05 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

   lin = 09
   For i := 1 to m_parc
    WValor = Parc_Fin(m_vendag,m_tx_car,i,.f.)
    @ lin,11 SAY WValor PICT "@e 9,999.99"
      lin ++
   Next i
   lin = 09
   For i := 1 to m_parc
    WValor = Parc_Fin(m_vendag,m_tx_chq,i,.f.)
       @ lin,27 SAY WValor PICT "@e 9,999.99"
      lin ++
   Next i
   lin = 09

   For i := 1 to m_parc
    m_tx_fin = I_TXFINANC
    If i = 6
       m_tx_fin = i_ft_01l
    ElseIf i = 10
       m_tx_fin = i_ft_02l
    ElseIf i = 12
       m_tx_fin = i_ft_03l
    ElseIf i = 15
       m_tx_fin = i_ft_04l
    Endif
    WValor = Parc_Fin(m_vendag,m_tx_fin,i,.f.)
    @ lin,43 SAY WValor PICT "@e 9,999.99"
      lin ++
   Next i

   lin ++
   m_tx_fin = i_ft_04l
   WValor = Parc_Fin(m_vendag,m_tx_fin,i,.f.)
   @ lin,38 SAY "15"
   @ lin,43 SAY WValor PICT "@e 9,999.99"
   lin ++
   m_tx_fin = i_ft_05l
   WValor = Parc_Fin(m_vendag,m_tx_fin,i,.f.)
   @ lin,38 SAY "16"
   @ lin,43 SAY WValor PICT "@e 9,999.99"
   lin ++
   m_tx_fin = i_ft_18l
   WValor = Parc_Fin(m_vendag,m_tx_fin,i,.f.)
   @ lin,38 SAY "18"
   @ lin,43 SAY WValor PICT "@e 9,999.99"

   lin = 09
   For i := 1 to m_parc
     WValor = Parc_Fin(m_vendag,m_tx_cc,i,.f.)
     @ lin,59 SAY WValor PICT "@e 9,999.99"
       lin ++
   Next i
   Inkey(0)
   @ 09,11 clear to m_lin-1,19
   @ 09,27 clear to m_lin-1,35
   @ 09,43 clear to m_lin-1,51
   @ 09,59 clear to m_lin-1,67
   lin = 09
   For i := 1 to m_parc
    WValor = Parc_Fin(m_vendag,m_tx_car,i,.f.)
    @ lin,11 SAY WValor/m_vendag PICT "9.9999  "
      lin ++
   Next i
   lin = 09
   For i := 1 to m_parc
    WValor = Parc_Fin(m_vendag,m_tx_chq,i,.f.)
    @ lin,27 SAY WValor/m_vendag PICT "9.9999  "
      lin ++
   Next i
   lin = 09
   For i := 1 to m_parc
       m_tx_fin = I_TXFINANC
    If i = 6 
       m_tx_fin = i_ft_01l
    ElseIf i = 10
       m_tx_fin = i_ft_02l
    ElseIf i = 12
       m_tx_fin = i_ft_03l
    ElseIf i = 15
       m_tx_fin = i_ft_04l
    Endif
    WValor = Parc_Fin(m_vendag,m_tx_fin,i,.f.)
    @ lin,43 SAY WValor/m_vendag PICT "9.9999 "
      lin ++
   Next i

   lin ++
   m_tx_fin = i_ft_04l
   WValor = Parc_Fin(m_vendag,m_tx_fin,i,.f.)
   @ lin,38 SAY "15"
   @ lin,43 SAY WValor/m_vendag PICT "9.9999   "
   lin ++
   m_tx_fin = i_ft_05l
   WValor = Parc_Fin(m_vendag,m_tx_fin,i,.f.)
   @ lin,38 SAY "16"
   @ lin,43 SAY WValor/m_vendag PICT "9.9999   "
   lin ++
   m_tx_fin = i_ft_18l
   WValor = Parc_Fin(m_vendag,m_tx_fin,i,.f.)
   @ lin,38 SAY "18"
   @ lin,43 SAY WValor/m_vendag PICT "9.9999   "

   lin = 09
   For i := 1 to m_parc
     WValor = Parc_Fin(m_vendag,m_tx_cc,i,.f.)
     @ lin,59 SAY WValor/m_vendag PICT "9.9999 "
     lin ++
   Next i
   inkey(0)
   @ 09,11 clear to m_lin-1,19
   @ 09,27 clear to m_lin-1,35
   @ 09,43 clear to m_lin-1,51
   @ 09,59 clear to m_lin-1,67
   lin = 09
   For i := 1 to m_parc
    WValor = Parc_Fin(m_vendag,m_tx_car,i,.f.)
    @ lin,11 SAY WValor*i PICT "@e 9,999.99"
      lin ++
   Next i
   lin = 09
   For i := 1 to m_parc
    WValor = Parc_Fin(m_vendag,m_tx_chq,i,.f.)
    @ lin,27 SAY WValor*i PICT "@e 9,999.99"
      lin ++
   Next i
   lin = 09
   For i := 1 to m_parc
       m_tx_fin = I_TXFINANC
    If i = 6
       m_tx_fin = i_ft_01l
    ElseIf i = 10
       m_tx_fin = i_ft_02l
    ElseIf i = 12
       m_tx_fin = i_ft_03l
    ElseIf i = 15
       m_tx_fin = i_ft_04l
    Endif
    WValor = Parc_Fin(m_vendag,m_tx_fin,i,.f.)
    @ lin,43 SAY WValor*i PICT "@e 9,999.99"
      lin ++
   Next i

   lin ++
   m_tx_fin = i_ft_04l
   WValor = Parc_Fin(m_vendag,m_tx_fin,i,.f.)
   @ lin,38 SAY "15"
   @ lin,43 SAY WValor*i PICT "@e 9,999.99"
   lin ++
   m_tx_fin = i_ft_05l
   WValor = Parc_Fin(m_vendag,m_tx_fin,i,.f.)
   @ lin,38 SAY "16"
   @ lin,43 SAY WValor*i PICT "@e 9,999.99"
   lin ++
   m_tx_fin = i_ft_18l
   WValor = Parc_Fin(m_vendag,m_tx_fin,i,.f.)
   @ lin,38 SAY "18"
   @ lin,43 SAY WValor*i PICT "@e 9,999.99"

   lin = 09
   For i := 1 to m_parc
     WValor = Parc_Fin(m_vendag,m_tx_cc,i,.f.)
     @ lin,59 SAY WValor*i PICT "@e 9,999.99"
      lin ++
   Next i
   Release WValor,m_vendag,m_tx_cc,i,m_parc,m_txab,m_frt,m_mon,m_tx_cc
   Release m_tx_car,m_tx_chq,m_tx_fin,m_tx_con,m_vend,m_entr,lin,m_lin
   Inkey(0)

  RESTSCREEN(00,01,24,78,sst)
  setcolor(cor)
 Endif

 If TEC = -2      && EDITA COMPONENTES
    SST=SAVESCREEN(06,05,24,78)
    SETCOLOR("W+/B+")
    @ 06,05 SAY "              COMPONENTES DE ESTOQUE                            "       
    @ 07,05 SAY "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
    @ 08,05 SAY "³ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³"
    Cor=Setcolor()
    Setcolor("gr+/b")
    @ 09,05 SAY "³ C¢digo Descri‡„o dos Produtos                         Estoque³"
    Setcolor(Cor)
    @ 10,05 SAY "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
    @ 11,05 SAY "³                                                              ³"
    @ 12,05 SAY "³                                                              ³"
    @ 13,05 SAY "³                                                              ³"
    @ 14,05 SAY "³                                                              ³"
    @ 15,05 SAY "³                                                              ³"
    @ 16,05 SAY "³                                                              ³"
    @ 17,05 SAY "³                                                              ³"
    @ 18,05 SAY "³                                                              ³"
    @ 19,05 SAY "³                                                              ³"
    @ 20,05 SAY "³                                                              ³"
    @ 21,05 SAY "³                                                              ³"
    @ 22,05 SAY "³                                                              ³"
    @ 23,05 SAY "³                                                              ³"
    @ 24,05 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
    wItens = 0
    Lin=11
    SELE 3
    SET ORDER TO 10
    SEEK M_CODX
    While !Eof() .and. CD_COMPO=M_CODX
      @ LIN,07 SAY STRZERO(CD_CODI,6)
      @ LIN,14 SAY CD_PROD
      Stor 0 to SdoEst,m_pendenc
      SD_Fisc(cd_codi,,,@SdoEst,@M_Pendenc)
      @ LIN,60 SAY sDoEst pict "999999"
      wItens++
      SKIP
      LIN++
    Enddo
    wCodigoComp:=RetDeparaComp(M_CODX)   // Retorna Codigo para venda com relacionamento
    If wCodigoComp >0
       Sele 3
       Set Order to 1
       Seek wCodigoComp
       @ LIN,07 SAY STRZERO(CD_CODI,6)+" "+Substr(CD_PROD,1,30)
       Cor=Setcolor()
       Setcolor("gr+/b")
       @ LIN,COL()+2 Say "(Relacionado)"
       Setcolor(Cor)
       Stor 0 to SdoEst,m_pendenc
       SD_Fisc(cd_codi,,,@SdoEst,@M_Pendenc)
       @ LIN,60 SAY sDoEst pict "999999"
       wItens++
    Endif
    If wItens = 0
       Alert("Componentes N„o Encontrados !")
       Keyb(chr(13))
    Endif
    Release wCodigoComp,wItens
    INKEY(0)
    RESTSCREEN(06,05,24,78,SST)
    EXIT
 Endif

 If TEC = -3      && Cores
    SST=SAVESCREEN(06,02,24,78)
    SET COLOR TO W+/W
    @ 09,05 Clear to 23,73
    @ 09,05,23,73 BOX B_SINGLE
    SET COLOR TO N/W
    @ 09,05 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    @ 10,05 Say "³"
    @ 11,05 Say "³"
    @ 12,05 Say "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    @ 13,05 Say "³"
    @ 14,05 Say "³"
    @ 15,05 Say "³"
    @ 16,05 Say "³"
    @ 17,05 Say "³"
    @ 18,05 Say "³"
    @ 19,05 Say "³"
    @ 20,05 Say "³"
    @ 21,05 Say "³"
    @ 22,05 Say "³"
    @ 23,05 Say "À"

    @ 10,06 SAY "Cores Relacionadas"
    @ 11,06 SAY "C¢digo Descri‡„o dos Produtos                   Cor        Estoq"
    Priv m_codigo[40],m_ache[40]
    ccorr=savescreen(13,00,24,78)
    m="01"
    Lin=13
    Sele 42
    Veriout(setcolor(),23,"cores")      && Cores de estoque (associacao de codigos)
    *Set index to cd_codcor
    Set index to index_cores
    SELE 42
    SET ORDER TO 1
    SEEK STR(M_CODX,6,0)
    WHILE !EOF() .AND. CD_CODI = M_CODX
     @ LIN,06 SAY STRZERO(CD_CODICOR,6)
     m_cd=cd_codicor
     Sele 3
     Set Order to 1
     Seek m_cd
     If !Eof()
        @ LIN,13 SAY CD_PROD+" "+SUBSTR(CD_COR,1,10)
	M_PROD = CD_PROD
	M_COR  = CD_COR
	M_FL   = CD_FL
	Sele 30
	Set Order to 1
        Seek m_cd
        If !Eof()
           @ LIN,65 SAY CD_SALDO PICT "999999"
  	Endif
	
        m_codigo[&m]=cd_codi
	m_ache[&m]=STRZERO(CD_CODI,6)+" "+SUBSTR(M_PROD,1,40)+" "+SUBSTR(M_COR,1,12)+" "+strzero(CD_SALDO,5)+" "+M_FL
        M = STRZERO(VAL(M)+1,2,0)
        LIN=LIN+1
     Endif
        Sele 42
        Set Order to 1
        Skip
    Enddo
       If Lin > 13
          restscreen(13,00,24,78,ccorr)
          SETCOLOR("W+/BG, B/RG,X")
          M_OPCA = ACHOICE(13,06,21,72,M_ACHE)
          If Lastkey()<> 27
	     m_codx = m_codigo[m_opca]
	     Keyb(chr(13))
	  Endif  
       Endif	
       Sele 42
       Use
       RELEASE ALL LIKE M_ACH*
       RELEASE M,LIN,M_OPCA
    RESTSCREEN(06,02,24,78,SST)
    EXIT
 Endif
 If TEC = -5                         && Caracteristicas do Produto
    cor=setcolor()
    sscr=savescreen(19,00,24,79)
    Set Color to n/w
    @ 19,00 clear to 24,79
    @ 20,00,24,79 BOX B_SINGLE
    Set Color to b+/W
    @ 20,00 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    @ 21,00 Say "³"
    @ 22,00 Say "³"
    @ 23,00 Say "³"
    @ 24,00 Say "À"
    Set Color to b+/W
    @ 19,01 Say "Caracter¡sticas do Produto"
    @ 21,01 SAY OBSER1 PICT '@!'
    @ 22,01 SAY OBSER2 PICT '@!'
    @ 23,01 SAY OBSER3 PICT '@!'
    Inkey(0)
    restscreen(19,00,24,79,sscr)
    setcolor(cor)
 Endif
     SELE 3
     SET ORDER TO 1
 Enddo
Enddo
RESTSCREEN(00,00,24,80,M_TELA01)
Return

//*******************
  Procedure pr_avista
//*******************
  @ 00,55 SAY "A Vista R$ "
  @ 00,67 SAY m_vendag pict "@e 999,999.99"
Return
//*****************
  PROCEDURE SAYTITU(LINHA,TITU1,TITU2)
//*****************
M_CORA = SETCOLOR()
IF TITU2 = NIL
   TITU2 = "CADASTRO"
ENDIF
CL2 = 70
CT2 = 0
GT2 = 1
WHILE CL2 > 70 - LEN(TITU1)
  @ 5,CL2 CLEAR TO 5,79
  CL2 --
  @ 5,CL2 SAY TITU2+SUBSTR(TITU1,1,GT2)
  GT2 ++
  TT2 = 1
  WHILE TT2 < 10
    TT2 ++
  ENDDO
ENDDO
@ 5,CL2 SAY TITU2+TITU1
SETCOLOR(M_CORA)
RETURN

PROCEDURE SAYDATA(LIN,COL)
**********************
IF LIN = NIL
   LIN = 2
ENDIF
IF COL = NIL
   COL = 2
ENDIF
@ LIN,COL  SAY " "+DataExt(M_DATSI)
RETURN
******************
PROCEDURE UREG_CL
******************
TLU = SAVESCREEN(8,20,13,58)
SETCOLOR(C_CORM)
SOMBRA(8,20,12,56,BOX)
@ 9,56   SAY CHR(24)
@ 11,56  SAY CHR(25)
SELE 1
SET FILTER TO
SET ORDER TO 1
GOTO BOTT
TEC = INKEY()
DO WHILE TEC <> 27
   @ 9,36  CLEAR TO 11,55
   @ 9,21  SAY 'C¢digo Clie : '+ALLTRIM(STR(CL_CODI))
   @ 10,21 SAY 'Nome Cliente: '+SUBSTR(CL_NOME,1,21)
   @ 11,21 SAY 'Cidade      : '+SUBSTR(CL_CIDA,1,21)
   TEC = INKEY()
   DO WHILE TEC <> 27 .AND. TEC <> 5 .AND. TEC <> 24
      TEC = INKEY(0)
   ENDDO
   IF TEC = 5
      SKIP -1
      IF BOF()
         GOTO BOTT
      ENDIF
   ENDIF
   IF TEC = 24
      SKIP
      IF EOF()
         GOTO TOP
      ENDIF
   ENDIF
ENDDO
SEEK CODIX
SET COLOR TO N/GR
RESTSCREEN(8,20,13,58,TLU)
RETURN
****
Function DataExt(dt)
****
  Local wdata
  wmms  := {"Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez"}
  wmes  := wmms[month(dt)]
  ano   := substr(dtoc(dt),7,4)
  wd    := strzero(day(dt),2)
  wdata := "&wd-&wmes-&ano"
Return(wdata)
*

PROCEDURE FRASE2(LINHA,TITU,TEMPO,ASC1,ASC2,COR)
CORA = SETCOLOR()
IF LINHA = NIL
   LINHA = 23
ENDIF
IF TITU  = NIL
   TITU  = "Erro"
ENDIF
IF TEMPO = NIL
   TEMPO = 3
ENDIF
IF COR   = NIL
   COR   = "W+/R"
ENDIF
FR=SAVESCREEN(LINHA,1,LINHA+1,78)
SETCOLOR(COR)
@ LINHA,1 CLEAR TO LINHA,78
@ LINHA,20 SAY TITU
TONE(450,TEMPO)
IF ASC1 <> NIL .AND. ASC2 <> NIL
   TEC = INKEY()
   WHILE TEC <> ASC1 .AND. TEC <> ASC2
     TEC = INKEY(0)
   ENDDO
ELSE
   INKEY(TEMPO)
ENDIF
SETCOLOR(CORA)
RESTSCREEN(LINHA,1,LINHA+1,78,FR)
RETURN

PROCEDURE TITUP
PARA COR,LIN
CORA = SETCOLOR()
SET COLOR TO &COR
@ LIN,23 say XY_EMPRESA+" "+LOJAX
SET COLOR TO &CORA
RETURN

PROCEDURE CONFIRMA
TEC = INKEY()
SET COLOR TO W+/R
@ 23,1 CLEAR TO 23,78
@ 23,23 say "[Enter] Confirma  [Esc] Aborta"
DO WHILE TEC <> 13 .AND. TEC <> 27
   TONE(450,1)
   TEC = INKEY(0)
ENDDO
@ 23,1 CLEAR TO 23,77
SET COLOR TO
RETURN

PROCEDURE TEMPO
TP = 1
DO WHILE TP < 10
   TP = TP + 1
ENDDO
RETURN

FUNC FUNCAO
***********
PARA MODO,POSICAO
IF LASTKEY()=27
   SET COLOR TO
   @ 10,24 CLEA TO 15,31
   RETU 0
ENDI
IF LASTKEY()=4
   KEYB CHR(4)+CHR(13)
   RETU 0
ENDI
IF LASTKEY()=19
   KEYB CHR(19)+CHR(13)
   RETU 0
ENDI
IF LASTKEY()=13
   RETU 1
ENDIF
RETU 2

PROCEDURE NADA
**************
NADATL = SAVESCREEN(12,21,15,50)
SETCOLOR("W+/R+")
SOMBRA(12,21,14,48,BOX)
SETCOLOR("W+/R+*")
@ 13,23 say 'Acesso N„o Autorizado...'
TONE(1200,2)
TONE(1500,3)
INKEY(2)
SET COLOR TO
RESTSCREEN(12,21,15,50,NADATL)
SET COLOR TO W+/N, R*/W ,,,W/N
RETURN

PROCEDURE REGSIM(P_LIN,P_TITU,P_TEMP)
***********************
IF P_LIN = NIL
   P_LIN = 23
ENDIF
IF P_TITU = NIL
   P_TITU = "Registro n„o existe. Por favor verifique."
ENDIF
IF P_TEMP = NIL
   P_TEMP = 2
ENDIF
SET CURSOR OFF
SET COLOR TO W/R
@ P_LIN,1 CLEAR TO P_LIN,77
SET COLOR TO W/R*
@ P_LIN,23 SAY P_TITU
TONE(600,5)
TONE(400,8)
INKEY(P_TEMP)
SET COLOR TO W/R
@ P_LIN,1 CLEAR TO P_LIN,77
SET COLOR TO
SET CURSOR ON
RETURN
******

PROCEDURE REGNAO(P_LIN,P_TITU,P_TEMP)
*************************************
MMM_VAR = 'S'
IF P_LIN = NIL
   P_LIN = 23
ENDIF
IF P_TITU = NIL
   P_TITU = "Registro n„o existe. Por favor verifique"
   MMM_VAR='N'
ENDIF
IF P_TEMP = NIL
   P_TEMP = 2
ENDIF
SET CURSOR OFF
SETCOLOR(C_CORM)
@ P_LIN,1 CLEAR TO P_LIN,77
SETCOLOR(C_CORM)
@ P_LIN,23 SAY P_TITU
TONE(600,5)
TONE(400,8)
INKEY(P_TEMP)
SETCOLOR(C_CORN)
@ P_LIN,1 CLEAR TO P_LIN,77
SET COLOR TO
SET CURSOR ON
RETURN
******

PROCEDURE P_EXIT(LINHA)
***********************
TONE(100,1)
IF LINHA = NIL
   LINHA = 23
ENDIF
M_CORA=SETCOLOR()
nResp:=0
nResp:= Alert( "C¢digo Solicitado J  Existe " , {"Alterar" , "Excluir" , "Retornar"} )

DO CASE
   CASE nResp=1
        SETCOLOR(M_CORA)
         REGX="S"
         M_PR=1
   CASE nResp=2
        SETCOLOR(M_CORA)
        REGX="S"
        M_PR=2
   OTHER
        M_PR=3
ENDCASE
RETURN

*****************************
PROCEDURE SALVA(LINHA,COLUN)
****************************
M_CORA = SETCOLOR()
IF LINHA = NIL
   LINHA = 24
ENDIF
IF COLUN = NIL
   COLUN = 19
ENDIF
WHILE .T.
  TONE(800,1)
  TONE(900,1)
  SETCOLOR("N*/BG")
  SET CURS OFF
  @ LINHA,COLUN SAY 'Salva'
  TEC = INKEY()
  WHILE TEC <> -1 .AND. TEC <> 27
    TEC = INKEY(0)
  ENDDO
  SETCOLOR("N/BG")
  @ LINHA,COLUN SAY 'Salva'
  TCF2=LASTKEY()
  EXIT
ENDDO
SETCOLOR(M_CORA)
SET CURS ON
RETURN

PROCEDURE LIMPA(LN1,CL1,LN2,CL2,TEMPO)
**************************************
IF LN1 = NIL
   LN1 = 0
ENDIF
IF LN2 = NIL
   LN2 = 24
ENDIF
IF CL1 = NIL
   CL1= 0
ENDIF
IF CL2 = NIL
   CL2 = 79
ENDIF
TOM = 200
TTN = CL1
WHILE TTN <= CL2
  @ LN1,CL1 CLEAR TO LN2,TTN
  TTN ++
  IF TEMPO <> NIL
     WHILE TEMPO > 0
        TEMPO --
     ENDDO
  ENDIF
ENDDO
RETURN
***/
PROCEDURE NEGA(LINHA)
*********************
CORA = SETCOLOR()
IF LINHA = NIL
   LINHA = 23
ENDIF
SETCOLOR(C_CORG)
@ LINHA,1 CLEAR TO LINHA,78
TONE(450,1)
TONE(451,2)
FRASE2(LINHA,"Acesso negado...",,,,C_CORG)
@ LINHA,1 CLEAR TO LINHA,78
SETCOLOR(CORA)
RETURN
***********
PROC VDIMP
***********
WHILE .T.
SETCOLOR("G+/R+")
SOMBRA(16,31,19,48,BOX)
@ 17,32 prom "V¡deo"
@ 18,32 prom "Impressora/V¡deo"
menu to relax1
SET COLOR TO
  MENURL1 = SAVESCREEN(0,0,24,79)
  DO CASE
     CASE RELAX1=0 .OR. RELAX1=1 .OR. RELAX1=2
          SETCOLOR(C_CORN)
          RETURN
     OTHE
          RELAX1=0
          RETURN
ENDCASE
ENDDO
//*******************
  Procedure Muda_Sen
//*******************
 Sele 22
 USE
 Sele 22
 VERIOUT(SETCOLOR(),23,"usuario")
 *SET INDEX TO m_usu
 SET INDEX TO index_usuario
 M_USU = M_NOMEUSU
 M_ACS = M_ACESSO
 SC = SAVESCREEN(12,50,18,78)
 Old_Acess = M_ACESSO
While .t.
  COR=SETCOLOR()
  SETCOLOR("W+/R+")
  Quadro(12,50,16,77,1)
  M_NOMEUSU = SPACE(15)
  M_ACESSO  = SPACE(12)
  @ 13,51 SAY "Usu rio  :"GET M_NOMEUSU PICT "@!" VALID M_NOMEUSU <> SPACE(15)
  @ 14,51 SAY "Sua Senha:"GET M_ACESSO  PICT "@!" VALID M_ACESSO <> SPACE(12)
  @ 15,51 SAY "Nova Senha   :"
  @ 16,51 SAY "Repita Senha :"
  Read
  IF LASTKEY() = 27 .or. Empty(M_NOMEUSU)
     M_NOMEUSU = M_USU
     M_ACESSO  = M_ACS
     Exit
  Endif
  SEEK M_NOMEUSU
  IF Eof()
     Tone(90,5)
     Alert("Usu rio N„o Cadastrado... Verifique !")
     Loop
  Endif
   IF ACESSO <> M_ACESSO
      Tone(90,5)
      Alert("Acesso Incorreto... Verifique !")
      Loop
   Endif
   M_ACESSO = SPACE(12)
   M_ACESS1 = SPACE(12)

   @ 15,65 GET M_ACESSO PICT "@!" Valid M_ACESSO <> SPACE(12)
   @ 16,65 GET M_ACESS1 PICT "@!" Valid M_ACESS1 <> SPACE(12)
   Read
   SETCOLOR(COR)
   If Alltrim(M_ACESS1) <> Alltrim(M_ACESSO)
      Alert("Senha Recusada !")
      RestScreen(12,50,18,78,SC)
      Loop
   Endif
   IF LASTKEY() = 27 .or. Empty(M_ACESSO) .or. Empty(M_ACESS1)
      M_NOMEUSU = M_USU
      M_ACESSO  = M_ACS
      Exit
   Endif
   New_Acess = M_ACESS1
      CLIE1 =U_CLIE1
      CLIE2 =U_CLIE2
      CLIE3 =U_CLIE3
      FORN1 =U_FORN1
      FORN2 =U_FORN2
      FORN3 =U_FORN3
      FORN4 =U_FORN4
      FORN5 =U_FORN5
      ESTO1 =U_ESTO1
      ESTO2 =U_ESTO2
      ESTO3 =U_ESTO3
      ESTO4 =U_ESTO4
      ESTO5 =U_ESTO5
      ESTO6 =U_ESTO6
      ESTO7 =U_ESTO7
      ESTO9 =U_ESTO9
      CUST7 =U_CUSTO
      MOVD1 =U_MOVD1
      MOVD2 =U_MOVD2
      MOVD3 =U_MOVD3
      MOVD4 =U_MOVD4
      MOVD5 =U_MOVD5
      MOVD6 =U_MOVD6
      MOVD7 =U_MOVD7
      MOVD8 =U_MOVD8
      MOVD9 =U_MOVD9
      MOVD10=U_MOVD10
      MOVD11=U_MOVD11
      MOVD12=U_MOVD12
      MOVD13=U_MOVD13
      MOVD14=U_MOVD14
      MOVD15=U_MOVD15
      MOVD16=U_MOVD16
      RELE1 =U_RELE1
      RELE2 =U_RELE2
      RELE3 =U_RELE3
      RELE4 =U_RELE4
      RELE5 =U_RELE5
      RELE6 =U_RELE6
      RELE7 =U_RELE7
      RELE8 =U_RELE8
      RELE9 =U_RELE9
      RELE10=U_RELE10
      RELE11=U_RELE11
      RELE12=U_RELE12
      RELE13=U_RELE13
      RELE14=U_RELE14
      PAGA1 =U_PAGA1
      PAGA2 =U_PAGA2
      RECE1 =U_RECE1
      RECE2 =U_RECE2
      CHEQ1 =U_CHEQ1
      CHEQ2 =U_CHEQ2
      UTIL1 =U_UTIL1
      VEND1 =U_VEND1
      VEND2 =U_VEND2
      VEND3 =U_VEND3
      CX12  =U_CX12
      LOJAU =U_LOJA
      NRLOJA=U_NRLOJA
      FISC  =U_FISC
      U_GER =U_MEM
      ACESS1=U_ACESS1
      ACESS2=U_ACESS2
      ACESS3=U_ACESS3
      ACESS4=U_ACESS4
      ACESS5=U_ACESS5
      ACESS6=U_ACESS6
      If BloqReg(0)
         Repl ACESSO WITH M_ACESSO
      Endif
      Unlock
      If Old_Acess <> New_Acess
         If BloqReg(0)
            Repl U_DATAI WITH M_DATSI,U_DATAF WITH M_DATSI+180
         Endif
      Endif
      Unlock
      Exit
Enddo
RESTSCREEN(12,50,18,78,SC)
Release M_USU,M_ACS,SC,Old_Acess,New_Acess
Sele 22
Use
Return

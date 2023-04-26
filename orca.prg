//***************************************************
/*
   FILE NAME : ORCA.PRG
   BY        : HELIO
   DESC      : ORCAMENTOS DE VENDAS
*/
//***************************************************
#include "box.ch"
#include "migracao.ch"

Procedure Orca()

TEESTO = SAVESCREEN(00,00,24,79)
SETCOLOR("W+/B,B/W,,,W+/B")
SOMBRA(05,03,13,28,BOX)
OP2=ACHOICE(06,04,12,27,V1,.T.,"FUNCAO")
SET COLOR TO
SET KEY -1 TO
IF LASTKEY() = 13
   DO CASE
      CASE OP2 = 1
           IF MOVD2 <> "N"
              SET CURSOR ON
              CORX=SETCOLOR()
              M_TT=SAVESCREEN(07,14,17,65)
              Set Color To N/W
              @ 06,29 Say "Modalidade da Venda      "
              SETCOLOR("W+/B,B/W,,,W+/B")
              SOMBRA(07,26,15,52,BOX)
              @ 08,28 PROM "1. A VISTA Dinheiro/Pix"
              @ 09,28 PROM "2. CHEQUE              "
              @ 10,28 PROM "3. A PRAZO NO CARNET   "
              @ 11,28 PROM "4. PROMOTORA           "
              @ 12,28 PROM "5. CARTAO CREDITO      "
              @ 13,28 PROM "6. BOLETO              "
              @ 14,28 PROM "7. E-Commerce          "
*             @ 13,28 PROM "7. CARNET/CONVENIO     "
*             @ 14,28 PROM "8. BMG (Consignada)    "
*             @ 15,28 PROM "9. CAIXA / CONVENIO    "
              MENU TO M_TIPO
             /*
              If m_tipo = 6 .or. m_tipo = 7
                 Alert("Esta Modalidade de Venda Est  Desativada !")
                 RESTSCREEN(00,00,24,79,TEESTO)
                 Return
              Endif
             */
              m_debcc = 0
              If Lastkey() = 13
                 If xy_cap_int = "CC"
  	            If m_tipo = 5
                       Set Color To N/W
		       @ 11,54 Say "Planos Disponiveis"
   	               SETCOLOR("W+/B,B/W,,,W+/B")
	               @ 12,51 clear to 20,75
	               @ 12,51 to 20,75 double
	   	       @ 13,52 prom "Credito (Parc acima 3x)"
		       @ 14,52 prom "Debito em Conta        "
		       @ 15,52 prom "1 x S/ Juros           "
		       @ 16,52 prom "2 x S/ Juros           "
		       @ 17,52 prom "3 x S/ Juros           "
		       @ 18,52 prom "1+4 S/ Juros           "
		       @ 19,52 prom "5 x S/ Juros           "
		       Menu to m_debcc
	            Endif
                 Else                       // Diferente p o interior CC em 5 x sem juros
  	            If m_tipo = 5
                       Set Color To N/W
		       @ 11,54 Say "Planos Disponiveis"
   	               SETCOLOR("W+/B,B/W,,,W+/B")
	               @ 12,51 clear to 19,75
	               @ 12,51 to 19,75 double
	   	       @ 13,52 prom "Credito (Parc acima 3x)"
		       @ 14,52 prom "Debito em Conta        "
		       @ 15,52 prom "1 x S/ Juros           "
		       @ 16,52 prom "2 x S/ Juros           "
		       @ 17,52 prom "3 x S/ Juros           "
		       @ 18,52 prom "1+4 S/ Juros           "
		       Menu to m_debcc
	            Endif
	         Endif
                 If m_tipo = 6
                    Padrao()  //cores
                    MOV_LINHA := 6; MOV_COLUNA := 9
                    JANELA( MOV_LINHA, MOV_COLUNA, MOV_LINHA + 10, MOV_COLUNA + 61, "Aviso Importante !!!" )
                    SETCOLOR( CONTECOR[ 11 ] + "," + CONTECOR[ 9 ] + ",,," + CONTECOR[ 8 ] )
                    @ 08,16 Say "Esta modalidade de venda estar  restrita apenas"
                    @ 10,18 Say "     para clientes Pessoa Jur¡dica."
                    SETCOLOR( CONTECOR[ 2 ] + "," + CONTECOR[ 3 ] + ",,," + CONTECOR[ 2 ] )
                    @ 13,19 Say "   Sob Autoriza‡„o da Diretoria !!!"
                    inkey(0)
                    m_tipo = 10   // Boleto
                 ElseIf m_tipo = 7
                    Padrao()  //cores
                    MOV_LINHA := 6; MOV_COLUNA := 9
                    JANELA( MOV_LINHA, MOV_COLUNA, MOV_LINHA + 10, MOV_COLUNA + 61, "Aviso Importante !!!" )
                    SETCOLOR( CONTECOR[ 11 ] + "," + CONTECOR[ 9 ] + ",,," + CONTECOR[ 8 ] )
                    @ 08,16 Say "Esta modalidade de venda estar  restrita apenas"
                    @ 10,18 Say "     para o site:  www.zenirmoveis.com.br "
                    SETCOLOR( CONTECOR[ 2 ] + "," + CONTECOR[ 3 ] + ",,," + CONTECOR[ 2 ] )
                    inkey(0)
                    m_tipo = 11     // E-Commerce
                    RESTSCREEN(00,00,24,79,TEESTO)
                    Return
                 Endif
                 RestScreen(07,14,17,65,M_TT)
                 If Lastkey() = 13
                    Clear
                    SMV09()        && ORCAMENTOS DE MERCADORIAS
	         Endif
	      Endif
           ELSE
              NADA()
           ENDIF
           KEYB(CHR(13))
      CASE OP2 = 2
           IF MOVD2 <> "N"
              SETCOLOR("W+/BG+, B/RG,X")
              SET COLOR TO W+/W
	      @ 07,35 Say "Cons.Or‡amentos"
              @ 08,28 clear to 11,59
              @ 08,28,11,59 BOX B_SINGLE
              SET COLOR TO N/W
              @ 08,28 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
              @ 09,28 Say "³"
	      @ 10,28 Say "³"
              @ 11,28 Say "À"

              SET COLOR TO b+/w
              @ 09,30 PROM "Ordem Or‡amento     "
              @ 10,30 PROM "Por Nome do Cliente "
              Menu to op1c
              If Lastkey()=27
	      Else
	         Clear
	         Set Cursor On
                 Smv09_co()                  // smv09.prg
	      Endif
           ELSE
              NADA()
           ENDIF
           KEYB(CHR(13))
      CASE OP2 = 3
           Clear
           Browse_Orca()         && BROWSE   neste prg
           KEYB(CHR(13))
      CASE OP2 = 5
           IF MOVD2 <> "N"
              SET CURSOR ON
              Cad_Cid()          && Cadastro de Cidades / Fretes
           ELSE
              NADA()
           ENDIF
           KEYB(CHR(13))
      CASE OP2 = 6
           Circulares()        && Visualizacao de Circulares On_line
           KEYB(CHR(13))
      CASE OP2 = 7
           VDNAPROV()          && Orcamentos que Nao passaram
           KEYB(CHR(13))
      CASE OP2 = 8
        /*
           Sele 57
	   Goto Top
	   While !Eof()
	    If ci_autoriz = 224
	       If Bloqreg(0)
	          Repl ci_xav with 1
	       Endif
	    Else
	       If Bloqreg(0)
	          Repl ci_xav with 1
	       Endif
	    Endif
	    Unlock
	    Skip
	   Enddo
           KEYB(CHR(13))
        */
     ENDCASE
    RESTSCREEN(00,00,24,79,TEESTO)
 ELSE
    RESTSCREEN(00,00,24,79,TEESTO)
 ENDIF
Return

//***************
  PROC Circulares                && Visualizacao de Circulares On Line
//***************
Local Vdir:=""
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

	  M_Mes:=month(m_datsi)-1
	  If M_mes = 0
	     m_mes = 12
	  Endif
	  if m_mes=1
	     If Loja = 1
	       !cp /zenir/dirtrans/circ_lidas1/ci_****_**01_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas1/ci*_*01*.*
	     ElseIf loja = 2
	       !cp /zenir/dirtrans/circ_lidas2/ci_****_**01_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas2/ci*_*01*.*
             Else
	       !cp /zenir/dirtrans/circ_lidas/ci_****_**01_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas/ci*_*01*.*
	     Endif
	  Elseif m_mes=2
	     If Loja = 1
	       !cp /zenir/dirtrans/circ_lidas1/ci_****_**02_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas1/ci*_*02*.*
	     ElseIf loja = 2
	       !cp /zenir/dirtrans/circ_lidas2/ci_****_**02_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas2/ci*_*02*.*
             Else
	       !cp /zenir/dirtrans/circ_lidas/ci_****_**02_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas/ci*_*02*.*
	     Endif
	  Elseif m_mes=3
	     If Loja = 1
	       !cp /zenir/dirtrans/circ_lidas1/ci_****_**03_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas1/ci*_*03*.*
	     ElseIf loja = 2
	       !cp /zenir/dirtrans/circ_lidas2/ci_****_**03_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas2/ci*_*03*.*
             Else
	       !cp /zenir/dirtrans/circ_lidas/ci_****_**03_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas/ci*_*03*.*
	     Endif
	  Elseif m_mes=4
	     If Loja = 1
	       !cp /zenir/dirtrans/circ_lidas1/ci_****_**04_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas1/ci*_*04*.*
	     ElseIf loja = 2
	       !cp /zenir/dirtrans/circ_lidas2/ci_****_**04_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas2/ci*_*04*.*
             Else
	       !cp /zenir/dirtrans/circ_lidas/ci_****_**04_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas/ci*_*04*.*
	     Endif
	  Elseif m_mes=5
	     If Loja = 1
	       !cp /zenir/dirtrans/circ_lidas1/ci_****_**05_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas1/ci*_*05*.*
	     ElseIf loja = 2
	       !cp /zenir/dirtrans/circ_lidas2/ci_****_**05_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas2/ci*_*05*.*
             Else
	       !cp /zenir/dirtrans/circ_lidas/ci_****_**05_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas/ci*_*05*.*
	     Endif
	  Elseif m_mes=6
	     If Loja = 1
	       !cp /zenir/dirtrans/circ_lidas1/ci_****_**06_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas1/ci*_*06*.*
	     ElseIf loja = 2
	       !cp /zenir/dirtrans/circ_lidas2/ci_****_**06_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas2/ci*_*06*.*
             Else
	       !cp /zenir/dirtrans/circ_lidas/ci_****_**06_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas/ci*_*06*.*
	     Endif
	  Elseif m_mes=7
	     If Loja = 1
	       !cp /zenir/dirtrans/circ_lidas1/ci_****_**07_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas1/ci*_*07*.*
	     ElseIf loja = 2
	       !cp /zenir/dirtrans/circ_lidas2/ci_****_**07_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas2/ci*_*07*.*
             Else
	       !cp /zenir/dirtrans/circ_lidas/ci_****_**07_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas/ci*_*07*.*
	     Endif
	  Elseif m_mes=8
	     If Loja = 1
	       !cp /zenir/dirtrans/circ_lidas1/ci_****_**08_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas1/ci*_*08*.*
	     ElseIf loja = 2
	       !cp /zenir/dirtrans/circ_lidas2/ci_****_**08_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas2/ci*_*08*.*
             Else
	       !cp /zenir/dirtrans/circ_lidas/ci_****_**08_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas/ci*_*08*.*
	     Endif
	  Elseif m_mes=9
	     If Loja = 1
	       !cp /zenir/dirtrans/circ_lidas1/ci_****_**09_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas1/ci*_*09*.*
	     ElseIf loja = 2
	       !cp /zenir/dirtrans/circ_lidas2/ci_****_**09_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas2/ci*_*09*.*
             Else
	       !cp /zenir/dirtrans/circ_lidas/ci_****_**09_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas/ci*_*09*.*
	     Endif
	  Elseif m_mes=10
	     If Loja = 1
	       !cp /zenir/dirtrans/circ_lidas1/ci_****_**10_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas1/ci*_*10*.*
	     ElseIf loja = 2
	       !cp /zenir/dirtrans/circ_lidas2/ci_****_**10_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas2/ci*_*10*.*
             Else
	       !cp /zenir/dirtrans/circ_lidas/ci_****_**10_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas/ci*_*10*.*
	     Endif
	  Elseif m_mes=11
	     If Loja = 1
	       !cp /zenir/dirtrans/circ_lidas1/ci_****_**11_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas1/ci*_*11*.*
	     ElseIf loja = 2
	       !cp /zenir/dirtrans/circ_lidas2/ci_****_**11_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas2/ci*_*11*.*
             Else
	       !cp /zenir/dirtrans/circ_lidas/ci_****_**11_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas/ci*_*11*.*
	     Endif
	  Elseif m_mes=12
	     If Loja = 1
	       !cp /zenir/dirtrans/circ_lidas1/ci_****_**12_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas1/ci*_*12*.*
	     ElseIf loja = 2
	       !cp /zenir/dirtrans/circ_lidas2/ci_****_**12_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas2/ci*_*12*.*
             Else
	       !cp /zenir/dirtrans/circ_lidas/ci_****_**12_*.* /zenir/dirtrans/backup_circ_lidas
	       !rm -f /zenir/dirtrans/circ_lidas/ci*_*12*.*
	     Endif
          Endif
          Refresh()
While .t.

  LOJAF     = LOJA
  Lojaxx    = LOJAX
  M_LOJA1XX = M_LOJA1
  VDIRX     = pasta

 If Loja = 1
 //   #Cinline
     chdir("/zenir/dirtrans/circ_lidas1")  // inso   && ACIONA O DIRETORIO DE CIRCULARES
 //   #endCinline
 ElseIf Loja = 2
 //   #Cinline
     chdir("/zenir/dirtrans/circ_lidas2")  // inso   && ACIONA O DIRETORIO DE CIRCULARES
 //   #endCinline
 Else
 //   #Cinline
     chdir("/zenir/dirtrans/circ_lidas")  // inso   && ACIONA O DIRETORIO DE CIRCULARES
 //   #endCinline
 Endif

    Set color to N/W
    @ 06,13 clear to 20,38
    @ 07,14,19,38 BOX B_SINGLE
    Set color to W+/W
    @ 06,14 Say "Circulares Recebidas"
    @ 20,14 Say "[Enter]Visualiza"
    @ 07,14 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    @ 08,14 Say "³"
    @ 09,14 Say "³"
    @ 10,14 Say "³"
    @ 11,14 Say "³"
    @ 12,14 Say "³"
    @ 13,14 Say "³"
    @ 14,14 Say "³"
    @ 15,14 Say "³"
    @ 16,14 Say "³"
    @ 17,14 Say "³"
    @ 18,14 Say "³"
    @ 19,14 Say "À"

    SETCOLOR("B+/W, W+/B")
    Private fontes[Adir("*.*")]
    Adir("*.*", fontes)
    Afields(fontes)
    Escolha=achoice(08,16,18,36,fontes)

    If LastKey() = 27 .or. escolha = 0
       Exit
    Endif

    SETCOLOR("B+/W*, W+/B")
    @ ROW(),15 SAY '¯'

    If Lastkey() = 13 .and. escolha >0
       text10=substr(fontes[escolha],1,20)
       SETCOLOR("W/BG+")
       If LastKey() = 27
          Exit
       Endif
       If text10=trim("*")
          Alert("Nome de arquivo Inv lido !")
          Exit
       Endif
       @ 01,00 clear to 20,80
       @ 01,01 say "Cirulares On Line de Pre‡os "+trim(text10)
       @ 02,01 say repl("_",79)
       Edita_arq:=MEMOREAD(text10)
       Edita_arq:=MEMOEDIT(Edita_arq,3,0,23,80)
       Exit
       Release &text10
       Release x,copia,escolha
   Endif
       Exit
Enddo
       LOJA    = LOJAF
       LOJAX   = Lojaxx
       M_LOJA1 = M_LOJA1XX
       VDIR    = VDIRX

      chdir(vdir)

      Close all
      CDABRE()
      CONFIG_EMP()
Return

//*************
  PROC VDNAPROV(wVend,wDat,wProg)                && Vendas nao aprovadas ( Retirar Reservas )
//*************
  wTelaVenda:=Savescreen(,,,)
  SET CURSOR ON
  CORX=SETCOLOR()
  Set Color To b+/W
  SetColor(xcorfundo)
  @ 05,00 clear to 21,78
  Sombra(06,00,23,78)
  @ 06,00,21,78 BOX B_DOUBLE
  SetColor("rg+/b")
  @ 05,01 Say " Vendas Com Reserva N„o Aprovadas do Vendedor:"
  SetColor(xcorfundo)
  @ 06,00 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
  @ 07,00 Say "³"
  @ 08,00 Say "³                                               "
  @ 09,00 Say "³                                               "
  @ 10,00 Say "³                                               "
  @ 11,00 Say "³                                               "
  @ 12,00 Say "³                                               "
  @ 13,00 Say "³                                               "
  @ 14,00 Say "³                                               "
  @ 15,00 Say "³                                               "
  @ 16,00 Say "³                                               "
  @ 17,00 Say "³                                               "
  @ 18,00 Say "³                                               "
  @ 19,00 Say "³                                               "
  @ 20,00 Say "³                                               "
  @ 21,00 Say "À"
  Setcolor("w+/b")
  @ 07,01 Say "³Reserva     ³Or‡amento³C¢digo³Produto         ³Saida Prod³Status/Tempo hh:mm"
  @ 08,01 to 08,77
  SetColor(xcorfundo)
  If wVend = Nil .and. wDat = Nil .and. wProg = Nil
     wProg = "orca"
     wVend = 0
     Setcolor("w+/b")
     Sombra(13,30,16,60,Box)
     @ 14,31 Say "Vendedor:"get wVend pict "999"
     Read
     wDat = M_Datsi
     @ 13,30 clear to 17,65
  Endif
  If Lastkey() = 27
     Restscreen(,,,,wTelaVenda)
     Return
  Endif

  PRIV M_ACHE[5000],wOrcamento[5000],wReserva[5000],wNAprovada[5000]
  V = "0001"

  Sele 16
  Set Order to 1
  Seek Str(wVend,3,0)
  If Eof()
     Alert("Vendedor N„o Cadastrado. Verifique !")
     Restscreen(,,,,wTelaVenda)
     Return
  Endif

  @ 5,50 SAY STRZERO(BA_CODI,3)+"  "+BA_NOME

  CpfVendedor = BA_CPF

  Stor 0 to wItens,wItensReserv,wItensVend,wItensNAprov,wItensCD
  Stor 'n' to wAviso
  Sele 25
  Set Order to 4
  Seek substr(dtoc(wDat),7,4)+substr(dtoc(wDat),4,2)+substr(dtoc(wDat),1,2)+str(wVend,3,0)
  If Eof()
     Alert("N„o Houve Vendas Neste Dia !")
     Restscreen(,,,,wTelaVenda)
     Return
  Endif
  While !Eof() .and. cd_datao = wDat .and. cd_codven = wVend
     m_orca        = CD_CODIOR
     m_reserv      = CD_RESERV
     m_codi        = CD_CODI
     m_prod        = CD_PROD
     M_SaidaOrca   = CD_SAIDA
     m_datao       = CD_DATAO
     whora         = CD_HORA
     wOrcamento[&v]= CD_CODIOR
     wReserva[&v]  = CD_RESERV
     wNAprovada[&v]= ""
     hhmm = Elaptime(wHora,time())
     wItens++
     If cd_reserv >0
        wItensReserv++
     Endif
     Sele 4
     Set Order to 15
     Go Top
     Seek STR(M_ORCA,8,0)+SUBSTR(DTOC(wDat),7,4)+SUBSTR(DTOC(wDat),4,2)+SUBSTR(DTOC(wDat),1,2)
     If Eof()
        M_ACHE[&v]=STRZERO(M_RESERV,13)+"³"+STRZERO(M_ORCA,8)+" ³"+STRZERO(M_CODI,6)+"³"+SUBSTR(M_PROD,1,16)+"³"+SUBSTR(M_SaidaOrca,1,10)+"³"+"N„o Aprovada "+hhmm
        wItensNAprov++
        wNAprovada[&v]= "N"
        If Trim(M_SaidaOrca) <> "LOJA/MOST" .and. M_Reserv >0
           wItensCD++
        Endif
        If hhmm > '01:00' .and. m_reserv >0
           wAviso = "s"
        Endif
     Else
        M_ACHE[&v]= StrZero(M_RESERV,13)+"³"+STRZERO(M_ORCA,8)+" ³"+STRZERO(M_CODI,6)+"³"+SUBSTR(M_PROD,1,16)+"³"+SUBSTR(M_SaidaOrca,1,10)+"³"+"Aprovada as: "+Substr(sd_hora,1,5)
        wItensVend++
        wNAprovada[&v]= "S"
     Endif
     V = STRZERO(Val(v)+1,4,0)
     Sele 25
     Set Order to 4
     Skip
 Enddo
 If wAviso = "s"
    Alert('Existe reserva com mais de uma HORA pendente !')
 Endif
 If Val(v) >1 .and. wItensCD >0
    While .t.
      SetColor("w+/b")
      @ 22,02 Say "Itens "+str(wItens,7)+"³ Reservados "+Str(wItensReserv,7)+"³ Vendidos "+Str(wItensVend,7)+"³ N„o Aprovados "+Str(wItensNAprov,7)
      SetColor(xcorjane)
      M_OPCA = ACHOICE(09,01,20,77,M_ACHE)
      If Lastkey() = 4 .or. Lastkey() = 19
         Loop
      Endif
      Exit
    Enddo
 Else
    *Alert("N„o h  Reserva !")
    Restscreen(,,,,wTelaVenda)
    Release m_opca,m_reg,m_orca,mlj,wlja,w_pora,wcdz,w_imp,m_ssh,x_ip,wcodior,wreserva,wTelaVenda
    Release CpfVendedor,wCpf,wOrca,v,m_dat,m_ache,hhmm,m_ip,M_SaidaOrca,wcdz,wVendedor,m_codigo,wNAprovada
    Release wItens,wItensReserv,wItensVend,wItensNAprov
    Return
 Endif
 If Lastkey() = 27
    Restscreen(,,,,wTelaVenda)
    Release m_opca,m_reg,m_orca,mlj,wlja,w_pora,wcdz,w_imp,m_ssh,x_ip,wcodior,wreserva,wTelaVenda
    Release CpfVendedor,wCpf,wOrca,v,m_dat,m_ache,hhmm,m_ip,M_SaidaOrca,wcdz,wVendedor,m_codigo,wNAprovada
    Release wItens,wItensReserv,wItensVend,wItensNAprov
    Return
 Endif
 If wItens >0
    If wReserva[m_opca] = 0
       Alert("N„o h  Reserva !")
       Restscreen(,,,,wTelaVenda)
       Release m_opca,m_reg,m_orca,mlj,wlja,w_pora,wcdz,w_imp,m_ssh,x_ip,wcodior,wreserva,wTelaVenda
       Release CpfVendedor,wCpf,wOrca,v,m_dat,m_ache,hhmm,m_ip,M_SaidaOrca,wcdz,wVendedor,m_codigo,wNAprovada
       Release wItens,wItensReserv,wItensVend,wItensNAprov
       Return
    Endif
 Endif
 If wItens >0
    If wNAprovada[m_opca] = "S"
       Alert("Opera‡„o Recusada. Esta Venda Foi Aprovada !")
       Restscreen(,,,,wTelaVenda)
       Release m_opca,m_reg,m_orca,mlj,wlja,w_pora,wcdz,w_imp,m_ssh,x_ip,wcodior,wreserva,wTelaVenda
       Release CpfVendedor,wCpf,wOrca,v,m_dat,m_ache,hhmm,m_ip,M_SaidaOrca,wcdz,wVendedor,m_codigo,wNAprovada
       Release wItens,wItensReserv,wItensVend,wItensNAprov
       Return
    Endif
 Endif

 wCpf     = Space(14)
 wOrca    = wOrcamento[m_opca]
 wResOrca = wReserva[m_opca]

 Sombra(13,20,16,70,Box)
 @ 14,31 Say "C.P.F:"get wCpf pict "999.999.999-99"
 @ 15,21 Say "CPF do Vendedor para Excluir Reserva ou [Esc]Sair"
 Read
 If Lastkey() = 27
    Restscreen(,,,,wTelaVenda)
    Release m_opca,m_reg,m_orca,mlj,wlja,w_pora,wcdz,w_imp,m_ssh,x_ip,wcodior,wreserva,wTelaVenda
    Release CpfVendedor,wCpf,wOrca,v,m_dat,m_ache,hhmm,m_ip,M_SaidaOrca,wcdz,wVendedor,m_codigo,wNAprovada
    Release wItens,wItensReserv,wItensVend,wItensNAprov
    Return
 Endif
 If CpfVendedor <> wCpf
    Alert("Este CPF N„o Pertence a Este Vendedor ou esta Incorreto !")
    Restscreen(,,,,wTelaVenda)
    Release m_opca,m_reg,m_orca,mlj,wlja,w_pora,wcdz,w_imp,m_ssh,x_ip,wcodior,wreserva,wTelaVenda
    Release CpfVendedor,wCpf,wOrca,v,m_dat,m_ache,hhmm,m_ip,M_SaidaOrca,wcdz,wVendedor,m_codigo,wNAprovada
    Release wItens,wItensReserv,wItensVend,wItensNAprov
    Return
 Endif

 Sele 25
 Set Order to 1
 Seek Str(wOrca,8,0)
 While !Eof() .and. cd_codior = wOrca
  If wResOrca >0 .and. wResOrca = cd_reserv
     M_SaidaOrca := substr(cd_saida,1,13)
     wCdz   := 0
     Sele 12
     Veriout(setcolor(),23,"saida_outras")
     Go Top
     While !Eof()
       If SubStr(Saida_item,1,7) = SubStr(M_SaidaOrca,1,7)
          If Substr(M_SaidaOrca,1,2) = "CD" .or. Substr(M_SaidaOrca,1,7) = "TIANGUA" .or. Substr(M_SaidaOrca,1,6) = "FEIRAO"
             wCdz = Loja
             Exit
          Endif
       Endif
       Skip
     Enddo
     Use
     If wCdz = 0
        Alert("Cancelamento Automatico So' nos CdZ's !")
        Release M_Orca,wwrst,wCdz
        Restscreen(,,,,wTelaVenda)
        Return
     Endif

     wrr=savescreen(18,10,20,56)
     @ 18,10 to 20,55
     Setcolor("br+/b")
     @ 19,11 say "Excluindo reserva on line com "
     Setcolor("w+/b")
     @ 19,41 say M_SaidaOrca
     inkey(1)
     Restscreen(18,10,20,56,wrr)
     Release wrr

     Sele 12
     Veriout(SETCOLOR(),23,"filiais")
     Go Top
     While !Eof()
       If Val(Fili) = wCdz
          wLJX = M_LOJAD
          x_ip = Trim(Ip_Tunel)
          Exit
       Endif
       Skip
     Enddo
     Use
     W_Porta = ""
     If (Loja=15 .and. wCdz=20)
        w_ip  = "127.0.0.1"
        m_ip  = "127.0.0.1"
     Else
        m_ip := TestaCon("Loja","Exclures")
        If Empty(m_ip)
           Restscreen(,,,,wTelaVenda)
           Return
        Else
           w_ip := TestaCon("Destino","Exclures",x_ip)
           If Empty(w_ip)
              Restscreen(,,,,wTelaVenda)
              Return
           Endif
        Endif
     Endif

     Sele 25
     Set Order to 1
     wCodior  = cd_codior
     wReserva = cd_reserv
     wVendedor= cd_vended
     m_codigo = cd_codi
     wImei    = cd_imei
     wnSerie  = cd_nSerie
     mlj      = Alltrim(strzero(Loja,2))
     wiDoDoo  = Alltrim(str(cd_id))
     wDataRes = cd_datao
     wAcesoCd = "sistema0801reserva"

     m_ssh = 'ssh -C -l '+wAcesoCd+' '+W_ip+' &W_Porta -t -q "/zenir/modulo/excreserv/excreserv "'+mlj+" "+alltrim(str(cd_reserv))+" "+alltrim(str(cd_codi))+" "+alltrim(strzero(cd_codven,3))+" "+alltrim(str(cd_codior))+" "+Alltrim(Strzero(wCdz,2))+" "+"erp"+" "+Dtoc(wDataRes)
     !&m_ssh

     Sele 25
     Set Order to 1
     If Bloqreg(0)
        Delete
     Endif
     Comm
     Unlock
     If !Empty(wIMei)
        wStatImei:=ZeraOrcaImei(wImei,wnSerie,"I")          // funcoes.prg
     ElseIf !Empty(wnSerie)
        wStatImei:=ZeraOrcaImei(wImei,wnSerie,"N")
     Endif
     If !Empty(wIMei) .or. !Empty(wnSerie)
        If wStatImei = .f.
           Alert("Error ao Zerar Or‡amento no Imei ou Imei N„o Encontrado")
        Endif
        Sele 25
        Set Order to 1
     Endif

     // Cancelar, Com Paramentro de Cancelamento oDoo_RPC
      /*
       If (Loja=02 .or. Loja=28 .or. Loja=51) .and. (wCdz=20)
          ConfCancRes(wCodior,wReserva,M_SaidaOrca,m_codigo,"CC")  && funcfat.prg
       Endif
     */

     If Val(wiDoDoo) >0
        Sombra(15,25,17,70,BOX)
        SetColor("BG+/B+")
        @ 16,27 SAY "Aguarde, Cancelando Reserva no oDoo...."
        wEnvia:="python3.6 /opt/odoo_rpc/altera_status_venda.py --id "+wIdoDoo+" --etapa cancelada"
        !&wEnvia
     Endif
     
     Sele 22
     Veriout(SETCOLOR(),23,"lixo")
     If Adireg(0)
        Repl OCORRENCIA WITH "Exclusao de Reserva no CD: "+Trim(wLjx)+" - Orcamento: "+Str(wcodior),CODIGO WITH m_codigo,;
             OPERACAO WITH "PROGRAMA VDNAPROV.PRG",MOTIVO WITH "Vendedor: "+Trim(wVendedor)+" - CPF: "+wCpf+" - Reserva: "+Str(wreserva),;
             USUARIO WITH M_NOMEUSU,DATAI WITH M_DATSI,HORA WITH TIME()
     Endif
     Comm
     Unlock
     Use
  Endif

  Sele 25
  Set Order to 1
  Skip
  wResOrca = cd_reserv
Enddo
Release ALL LIKE M_ACH*
Restscreen(,,,,wTelaVenda)
Release m_opca,m_reg,m_orca,mlj,wlja,w_pora,wcdz,w_imp,m_ssh,x_ip,wLjx,wcodior,wreserva
Release wItens,wItensReserv,wItensVend,wItensNAprov,wResOrca
Release CpfVendedor,wCpf,wOrca,v,m_dat,m_ache,hhmm,m_ip,M_SaidaOrca,wcdz,wVendedor,m_codigo,wTelaVenda
Return

//************
  PROC Cad_Cid                   && Recebto de Prestacoes Outras Filiais
//************
 Set Key 22 to
 Sele 27
 Set Order to 1
 Go Bott

 M_CORA = SETCOLOR()
 TELA100=SAVESCREEN(06,00,22,79)
 SETCOLOR(C_CORG)
 @ 06,01 clear to 22,78
 @ 06,01 to 22,78 double
 @ 12,20 SAY CHR(24)
 @ 15,20 SAY CHR(25)
 @ 18,30 SAY '<PgUp>Sobe'
 @ 18,52 SAY '<PgDn>Desce'
 @ 06,15 SAY 'Cidades e Bairros -- [F2]Consulta Cidades [F3]Consulta Bairros'

 SETCOLOR("W+/BG+, B/RG,X")
 PRIV VETOR1[6],VETOR2[6]
 VETOR1[1] ='CD_CIDADE'
 VETOR1[2] ='CD_BAIRRO'
 VETOR1[3] ='CD_UF'
 VETOR1[4] ='CD_ZONA'
 VETOR1[5] ='CD_VALOR'
 VETOR1[6] ='CD_MONTAG'

 VETOR2[1]='Cidade'
 VETOR2[2]='Bairro'
 VETOR2[3]='UF'
 VETOR2[4]='Zona'
 VETOR2[5]='Valor do Frete'
 VETOR2[6]='Valor de Montagem'

 SETCOLOR("W+/BG+, B/RG,X")
 DBEDIT(07,02,21,77,VETOR1,"FUNCRX",,VETOR2)
 RELEASE VETOR1,VETOR2
 RESTSCREEN(06,00,22,79,TELA100)
**********************
FUNCTION FUNCRX
**********************
PARAMETERS MODO, PONTEIRO
PRIVATE POS_CURSOR, REGISTRO, SALVA_TELA
If Ponteiro=0
   Ponteiro=1
EndIf
POS_CURSOR=VETOR1[PONTEIRO]
DO CASE
   CASE LASTKEY()=27
        RELEASE POS_CURSOR, REGISTRO, SALVA_TELA
        RELEASE VETOR1,VETOR2,NOME,M_CODIP
        RETURN(0)
   CASE LASTKEY()= -1
        wCidade = space(27)
        @ 12,32 say "Cidade:"Get wCidade pict "@!"
        Read
        Set Order to 1
        Seek wCidade
        If Eof()
           Alert("Cidade Nao Encontada !")
        Endif
        RETURN(1)
   CASE LASTKEY()= -2
        wBairro = space(31)
        @ 12,32 say "Bairro:"Get wBairro pict "@!"
        Read
        Set Order to 2
        Seek wBairro
        If Eof()
           Alert("Bairro Nao Encontado !")
           RETURN(0)
        Else
           Dbedit()
           RETURN(0)
        Endif
        RETURN(1)
ENDCASE
RETURN(1)

//*********************
  Procedure Browse_orca
//*********************
Set Key -1 to
Set Key -2 to
Set Key -3 to
Set Key -4 to
Set Key -5 to
Set Key -6 to
Set Key -7 to
Set Key -8 to
Set Key -9 to
SET Key 22 TO
SET Key -40 TO
Sele 25
Set Order to 1
Goto Bott
CXL=SAVESCREEN(00,00,24,79)
KEYB(CHR(8))

Priv VETOR1[21],VETOR2[21]

SET SCOREBOARD OFF
SETCOLOR(C_CORG)
@ 00,00 CLEAR TO 24,80
@ 00,01 SAy "Consuta Autom tica de Or‡amentos de Venda"
@ 00,60 Say "Usu rio "+substr(m_nomeusu,1,15)
@ 22,01 to 22,78
@ 23,02 SAY "[F2]Altera Item [F4]Inclui Item       [F6]Altera Plano    [F8]Busca Or‡amento"
@ 24,02 SAY "[F3]Exclui Item [F5]Exclui Or‡amento  [F7]Altera Cadastro [F9]Altera Data    "
SETCOLOR("W+/BG+, B/RG,X")

VETOR1[1]  ='CD_CODIOR'
VETOR1[2]  ='CD_DATAO'
VETOR1[3]  ='CD_QUANT'
VETOR1[4]  ='CD_CODI'
VETOR1[5]  ='CD_PROD'
VETOR1[6]  ='CD_COR'
VETOR1[7]  ='CD_UNIT'
VETOR1[8]  ='CD_UNIT*CD_QUANT'
VETOR1[9]  ='CD_CODICL'
VETOR1[10] ='CD_NOMECL'
VETOR1[11] ='CD_ENDE'
VETOR1[12] ='CD_BAIR'
VETOR1[13] ='CD_CIDA'
VETOR1[14] ='CD_CPF'
VETOR1[15] ='CD_CGC'
VETOR1[16] ='CD_VENDED'
VETOR1[17] ='CD_RESERV'
VETOR1[18] ='CD_SAIDA'
VETOR1[19] ='CD_ID'
VETOR1[20] ='CD_IMEI'
VETOR1[21] ='CD_HORA'

VETOR2[1]  ='Or‡amento'
VETOR2[2]  ='Dta Or‡to'
VETOR2[3]  ='Quant'
VETOR2[4]  ='C¢digo'
VETOR2[5]  ='Descri‡„o da Mercadoria'
VETOR2[6]  ='Cor....'
VETOR2[7]  ='Valor R$'
VETOR2[8]  ='Total R$'
VETOR2[9]  ='Cod_Clie'
VETOR2[10] ='Nome do Cliente'
VETOR2[11] ='Endere‡o do Cliente'
VETOR2[12] ='Bairro'
VETOR2[13] ='Cidade'
VETOR2[14] ='C.P.F.'
VETOR2[15] ='C.N.P.J'
VETOR2[16] ='Nome do Vendedor'
VETOR2[17] ='Reserva'
VETOR2[18] ='Saida'
VETOR2[19] ='ID_oDoo'
VETOR2[20] ='Imei'
VETOR2[21] ='Hora' 

SETCOLOR("W+/BG+, B/RG,X")
DBEDIT(01,00,21,80,VETOR1,"FUN_CCT",,VETOR2," ")
//****************
  FUNCTION FUN_CCT
//****************
PARAMETERS MODO, PONTEIRO
PRIVATE POS_CURSOR, REGISTRO, SALVA_TELA
 IF PONTEIRO=0
    PONTEIRO=1
 ENDIF
 POS_CURSOR=VETOR1[PONTEIRO]

 M_DATAO   = CD_DATAO
 M_NOTA    = CD_CODIOR
 M_RES     = CD_RESERV
 M_TIPO    = CD_TIPOV
 M_DEBCC   = CD_DEBCC

DO CASE
   CASE LASTKEY()=27
     Release M_DATAO,M_NOTA
     CLEAR GETS
     RESTSCREEN(00,00,24,79,CXL)
     Return(0)
   CASE LASTKEY()= -1    && Altera Item do Orcamento
     If Trim(Lojau) <> "AUDITORIA" .and. VEND3 <> CD_CODVEN
        Alert("Opera‡„o Recusada. Este or‡amento N„o pertence a este usu rio !")
     Else
        ger=savescreen(15,26,20,50)
        SET COLOR TO W+/W
        @ 15,26 clear to 20,50
        @ 15,26,20,50 BOX B_SINGLE
        SET COLOR TO N/W
        m_senhger=space(15)
        @ 15,26 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
        @ 16,26 Say "³ Usu rio "+substr(m_nomeusu,1,10)
        @ 17,26 Say "³"
        @ 18,26 Say "³ Senha"
        @ 19,26 Say "³ "
        @ 20,26 Say "À"
        COR=SETCOLOR()
        SETCOLOR(C_CORS)
        @ 19,28 get m_senhger pict "@!"
        Read
        SETCOLOR(COR)
        RestScreen(15,26,20,50,ger)
        If m_senhger<>m_acesso
           Alert("Senha Errada. Tente Novamente !")
           KEYBOARD"S"
           RETURN(1)
        Else
           If CD_DATAO <> Date()
              Alert("Orcamento N„o Pertence a esta Data !!!")
              KEYBOARD"S"
              RETURN(1)
           Endif
           Sele 4
           Set Order to 15
           Seek str(m_nota,8,0)+substr(dtoc(M_Datao),7,4)+substr(dtoc(M_Datao),4,2)+substr(dtoc(M_Datao),1,2)
           If !Eof()
              Sele 25
              Set order to 1
              Alert("Venda Ja Efetuada !")
              KEYBOARD"S"
              RETURN(1)
           Endif
           w_triang = "N"
           Altera_It(m_nota,m_datao)
           If w_triang = "S"      // Venda de Celular Triangulada da Mesma Operadora CEL + CHIP
              Triang_Cel(m_nota,m_datsi)
           Endif
           Sele 25
           Set Order to 1
           Seek str(m_nota,8,0)
        Endif
    Endif
        KEYBOARD"S"
        RETURN(1)
   CASE LASTKEY()= -2   && Exclui Item do Orcamento
    If VEND3<>CD_CODVEN
        Alert("Opera‡„o Recusada. Este or‡amento N„o pertence a este usu rio !")
    Else
        ger=savescreen(15,26,20,50)
        SET COLOR TO W+/W
        @ 15,26 clear to 20,50
        @ 15,26,20,50 BOX B_SINGLE
        SET COLOR TO N/W
        m_senhger=space(15)
        @ 15,26 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
        @ 16,26 Say "³ Usu rio "+substr(m_nomeusu,1,10)
        @ 17,26 Say "³"
        @ 18,26 Say "³ Senha"
        @ 19,26 Say "³ "
        @ 20,26 Say "À"
        COR=SETCOLOR()
        SETCOLOR(C_CORS)
        @ 19,28 get m_senhger pict "@!"
        Read
        SETCOLOR(COR)
        RestScreen(15,26,20,50,ger)
        If m_senhger<>m_acesso
           Alert("Senha Errada. Tente Novamente !")
           KEYBOARD"S"
           RETURN(1)
        Else
           If CD_DATAO <> Date()
              Alert("Or‡amento N„o Pertence a esta Data !!!")
              KEYBOARD"S"
              RETURN(1)
           Endif
           Sele 4
           Set Order to 15
           Seek str(m_nota,8,0)+substr(dtoc(M_Datao),7,4)+substr(dtoc(M_Datao),4,2)+substr(dtoc(M_Datao),1,2)
           If !Eof()
              Sele 25
              Set order to 1
              Alert("Venda Ja Efetuada !")
              KEYBOARD"S"
              RETURN(1)
           Endif
           Sele 25
           Set Order to 1
           wRegCod := Recno()
           nResp:=0
           nResp:=Alert("Deleta Codigo "+strzero(cd_codi,6)+" do Or‡amento "+strzero(m_nota,8) , {"Sim ","N„o "})
           If nResp = 1
              If cd_reserv > 0
                 Exclures()    // funcoes.prg
              Endif
              wImei   = cd_imei
              wnSerie = cd_nSerie
              Sele 25
              Set Order to 1
              Go wRegCod
              If Bloqreg(0)
                 Delete
              Endif
              Comm
              Unlock
              If !Empty(wIMei)
                 wStatImei:=ZeraOrcaImei(wImei,wnSerie,"I")          // funcoes.prg
              ElseIf !Empty(wnSerie)
                 wStatImei:=ZeraOrcaImei(wImei,wnSerie,"N")
              Endif
              If !Empty(wIMei) .or. !Empty(wnSerie)
                 If wStatImei = .f.
                    Alert("Error ao Zerar Or‡amento no Imei ou Imei N„o Encontrado")
                 Endif
                 Sele 25
                 Set Order to 1
              Endif
           Else
              KEYBOARD"S"
              RETURN(1)
           Endif
           Exclui_it()
           Sele 25
           Set Order to 1
           Seek str(m_nota,8,0)
        Endif
        Release wRegCod
    Endif
    KEYBOARD"S"
    RETURN(1)
   CASE LASTKEY()= -3             && Incluindo Itens
    If VEND3<>CD_CODVEN
       Alert("Opera‡„o Recusada. Este or‡amento N„o pertence a este usu rio !")
    Else
       ger=savescreen(15,26,20,50)
       SET COLOR TO W+/W
       @ 15,26 clear to 20,50
       @ 15,26,20,50 BOX B_SINGLE
       SET COLOR TO N/W
       m_senhger=space(15)
       @ 15,26 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
       @ 16,26 Say "³ Usu rio "+substr(m_nomeusu,1,10)
       @ 17,26 Say "³"
       @ 18,26 Say "³ Senha"
       @ 19,26 Say "³ "
       @ 20,26 Say "À"
       COR=SETCOLOR()
       SETCOLOR(C_CORS)
       @ 19,28 get m_senhger pict "@!"
       Read
       SETCOLOR(COR)
       RestScreen(15,26,20,50,ger)
       If m_senhger<>m_acesso
          Alert("Senha Errada. Tente Novamente !")
          KEYBOARD"S"
          RETURN(1)
       Else
          If CD_DATAO <> Date()
             Alert("Orcamento N„o Pertence a esta Data !!!")
             KEYBOARD"S"
             RETURN(1)
          Endif
          Sele 4
          Set Order to 15
          Seek str(m_nota,8,0)+substr(dtoc(M_Datao),7,4)+substr(dtoc(M_Datao),4,2)+substr(dtoc(M_Datao),1,2)
          If !Eof()
             Sele 25
             Set order to 1
             Alert("Venda Ja Efetuada !")
             KEYBOARD"S"
             RETURN(1)
          Endif
          w_triang = "N"     // Venda de Celular Triangulada da Mesma Operadora CEL + CHIP
          Inclui_it()
          If w_triang = "S"     // Venda de Celular Triangulada da Mesma Operadora CEL + CHIP
             Triang_Cel(m_nota,m_datsi)
          Endif
          Sele 25
          Set Order to 1
          Seek str(m_nota,8,0)
       Endif
    Endif
    KEYBOARD"S"
    RETURN(1)
   CASE LASTKEY()= -4  && EXCLUI ORCAMENTOS
    If VEND3<>CD_CODVEN
       Alert("Opera‡„o Recusada. Este or‡amento N„o pertence a este usu rio !")
       KEYBOARD"S"
       RETURN(1)
    Else
      If CD_DATAO <> Date()
         Alert("Orcamento N„o Pertence a esta Data !!!")
         KEYBOARD"S"
         RETURN(1)
      Endif
      ger=savescreen(15,26,20,50)
      SET COLOR TO W+/W
      @ 15,26 clear to 20,50
      @ 15,26,20,50 BOX B_SINGLE
      SET COLOR TO N/W
      m_senhger=space(15)
      @ 15,26 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
      @ 16,26 Say "³ Usu rio "+substr(m_nomeusu,1,10)
      @ 17,26 Say "³"
      @ 18,26 Say "³ Senha"
      @ 19,26 Say "³ "
      @ 20,26 Say "À"
      COR=SETCOLOR()
      SETCOLOR(C_CORS)
      @ 19,28 get m_senhger pict "@!"
      Read
      SETCOLOR(COR)
      RestScreen(15,26,20,50,ger)
      If m_senhger<>m_acesso
         Alert("Senha Errada. Tente Novamente !")
         KEYBOARD"S"
         RETURN(1)
      Endif
   Endif
   While .t.
     nResp:=0
     nResp:=Alert("Confirma Exclus„o do Or‡amento ? "+strzero(m_nota,8), {"Sim ","N„o "})
     If nResp = 2
        KEYBOARD"S"
        RETURN(1)
        Exit
     EndIf
     Sele 4
     Set Order to 15
     Seek str(m_nota,8,0)+substr(dtoc(M_Datao),7,4)+substr(dtoc(M_Datao),4,2)+substr(dtoc(M_Datao),1,2)
     If !Eof()
        Sele 25
        Set order to 1
        Alert("Venda Ja Efetuada !")
        KEYBOARD"S"
        RETURN(1)
     Endif
     Sele 25
     Set Order to 1
     Seek Str(M_NOTA,8,0)+SUBSTR(DTOC(M_DATAO),7,4)+SUBSTR(DTOC(M_DATAO),4,2)+SUBSTR(DTOC(M_DATAO),1,2)
     While CD_Codior = M_Nota
       wRegCod:=Recno()
       If !Eof() .and. cd_reserv > 0
          Exclures()    // funcoes.prg
       Endif

       Sele 25
       Set Order to 1
       Go wRegCod
       wImei   = cd_imei
       wnSerie = cd_nSerie
       If BloqReg(0)
          Delete
       Endif
       Comm
       Unlock
       If !Empty(wIMei)
          wStatImei:=ZeraOrcaImei(wImei,wnSerie,"I")          // funcoes.prg
       ElseIf !Empty(wnSerie)
          wStatImei:=ZeraOrcaImei(wImei,wnSerie,"N")
       Endif
       If !Empty(wIMei) .or. !Empty(wnSerie)
          If wStatImei = .f.
             Alert("Error ao Zerar Or‡amento no Imei ou Imei N„o Encontrado")
          Endif
          Sele 25
          Set Order to 1
       Endif
       Skip
     Enddo
     Exit
    Enddo
    Release wRegCod
    KEYBOARD"S"
    RETURN(0)
   CASE LASTKEY()= -5        && Alterando plano
    /*
     If m_acesso <> "X"
        Alert("Programa em Desenvolvimento. Desculpe !")
        KEYBOARD"S"
        RETURN(1)
     Endif
    */
    If VEND3<>CD_CODVEN
       Alert("Opera‡„o Recusada. Este or‡amento N„o pertence a este usu rio !")
       KEYBOARD"S"
       RETURN(1)
    Else
       If CD_DATAO <> Date()
          Alert("Orcamento N„o Pertence a esta Data !!!")
          KEYBOARD"S"
          RETURN(1)
       Endif
       ger=savescreen(15,26,20,50)
       SET COLOR TO W+/W
       @ 15,26 clear to 20,50
       @ 15,26,20,50 BOX B_SINGLE
       SET COLOR TO N/W
       m_senhger=space(15)
       @ 15,26 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
       @ 16,26 Say "³ Usu rio "+substr(m_nomeusu,1,10)
       @ 17,26 Say "³"
       @ 18,26 Say "³ Senha"
       @ 19,26 Say "³ "
       @ 20,26 Say "À"
       COR=SETCOLOR()
       SETCOLOR(C_CORS)
       @ 19,28 get m_senhger pict "@!"
       Read
       SETCOLOR(COR)
       RestScreen(15,26,20,50,ger)
       If m_senhger<>m_acesso
          Alert("Senha Errada. Tente Novamente !")
          KEYBOARD"S"
          RETURN(1)
       Else
          Sele 4
          Set Order to 15
          Seek str(m_nota,8,0)+substr(dtoc(M_Datao),7,4)+substr(dtoc(M_Datao),4,2)+substr(dtoc(M_Datao),1,2)
          If !Eof()
             Sele 25
             Set order to 1
             Alert("Venda Ja Efetuada !")
             KEYBOARD"S"
             RETURN(1)
          Endif

          w_triang = "N"     // Venda de Celular Triangulada da Mesma Operadora CEL + CHIP
          m_recno=recno()
          Seek str(m_nota,8,0)

          Altera_Plano()

          If w_triang = "S"     // Venda de Celular Triangulada da Mesma Operadora CEL + CHIP
             Triang_Cel(m_nota,m_datsi)
          Endif
          Sele 25
          Set Order to 1
          Go m_recno
       Endif
    Endif
    KEYBOARD"S"
    RETURN(1)
   CASE LASTKEY()= -6                   && Alterando Cadastro
     If VEND3<>CD_CODVEN
        Alert("Opera‡„o Recusada. Este or‡amento N„o pertence a este usu rio !")
        KEYBOARD"S"
        RETURN(1)
     Else
        If CD_DATAO <> Date()
           Alert("Orcamento N„o Pertence a esta Data !!!")
           KEYBOARD"S"
           RETURN(1)
        Endif
        ger=savescreen(15,26,20,50)
        SET COLOR TO B+/W
        @ 15,26 clear to 20,50
        @ 15,26,20,50 BOX B_SINGLE
        SET COLOR TO N/W
        m_senhger=space(15)
        @ 15,26 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
        @ 16,26 Say "³ Usu rio "+substr(m_nomeusu,1,10)
        @ 17,26 Say "³"
        @ 18,26 Say "³ Senha"
        @ 19,26 Say "³ "
        @ 20,26 Say "À"
        COR=SETCOLOR()
        SETCOLOR(C_CORS)
        @ 19,28 get m_senhger pict "@!"
        Read
        SETCOLOR(COR)
        RestScreen(15,26,20,50,ger)
        If m_senhger<>m_acesso
           Alert("Senha Errada. Tente Novamente !")
           KEYBOARD"S"
           RETURN(1)
        Endif
     Endif
     Stor 0 to m_txe,m_txm
     While .t.
      Sele 25
      Set order to 1
      Seek Str(M_NOTA,8,0)
      M_CLIE    = CD_CODICL
      M_NOME    = CD_NOMECL
      ENDEX     = CD_ENDE
      FON1X     = CD_FONE
      CGCX      = CD_CGC
      CPFX      = CD_CPF
      M_BAICL   = CD_BAIR
      M_CEPCL   = CD_CEP
      M_CIDACL  = CD_CIDA
      M_UFCL    = CD_UF
      M_REFER   = CD_REFER
      M_REFER2  = CD_REFER2
      M_OBSER   = CD_OBSER
      M_SAIDA   = CD_SAIDA
      M_RG      = CD_RG
      M_RESERV  = CD_RESERV
      If CD_TXE >0
         M_TXE  = CD_TXE
      Endif
      If CD_TXM >0
         M_TXM  = CD_TXM
      Endif
      M_IMEI    = CD_IMEI
      M_CEL     = CD_CEL
      M_Datao   = CD_DATAO
      wEndTrega = CD_ENDET
      wCidaTrega= CD_CIDAT
      wBairTrega= CD_BAIRT
      wCepTrega = CD_CEPT
      wIbgeTrega= CD_IBGET
      wUfTrega  = CD_UFT
      wNumero   = CD_NUMERO
      wComple   = CD_COMPLE
      wNumerot  = CD_NUMEROT
      wComplet  = CD_COMPLET

      Sele 4
      Set Order to 15
      Seek str(m_nota,8,0)+substr(dtoc(M_Datao),7,4)+substr(dtoc(M_Datao),4,2)+substr(dtoc(M_Datao),1,2)
      If !Eof()
         Sele 25
         Set order to 1
         Alert("Venda Ja Efetuada !")
         KEYBOARD"S"
         RETURN(1)
      Endif
      SET CURSOR ON
      SET COLOR TO B+/W
      TC=SAVESCREEN(04,20,24,78)
      SOMBRA(10,20,24,77,BOX)
      @ 10,25 SAY "Dados do Cliente p/Emiss„o de Cupom Fiscal"
      @ 11,21 SAY "Nome "GET M_NOME
      @ 12,21 SAY "Endere‡o"GET ENDEX PICT "@!S30"
      @ 12,64 SAY "N§"GET wNumero PICT "@!"
      @ 13,21 SAY "Bairro  "GET M_BAICL  PICT "@!S20"
      @ 13,50 SAY "Cidade "GET M_CIDACL PICT "@!S19"
      @ 14,21 SAY "C.E.P   "GET M_CEPCL PICT '99.999-999'
      @ 14,41 SAY "Fone "GET FON1X PICT "@!S15"
      @ 14,62 SAY "U.F."GET M_UFCL
      @ 15,21 SAY "C.P.F.  "GET CPFX PICT "999.999.999-99"
      @ 15,50 SAY "C.G.C. "GET CGCX PICT '99.999.999/9999-99'
      @ 16,21 SAY "Complemento Enderec"GET wComple PICT "@!S9"
      @ 16,50 SAY "R.G "GET M_RG PICT "@!S15"
      @ 17,21 to 17,76
      @ 18,21 SAY "PONTO DE REF(1)"GET M_REFER  PICT "@!S40"
      @ 19,21 SAY "PONTO DE REF(2)"GET M_REFER2 PICT "@!S40"
      @ 20,21 SAY "N§ Ser/ Quadro "GET M_OBSER
      @ 21,21 SAY "Sa¡da dos Produtos "+substr(M_SAIDA,1,10)
*     @ 21,50 SAY "N§ Reserva : "GET M_RESERV PICT "99999999"
      @ 22,50 SAY "N§ IMEI :"GET M_IMEI
      @ 23,50 SAY "N§ Celular :"GET M_CEL PICT "999-9999999999"
      If xy_cap_int = "CC"
         @ 24,21 SAY "Tx.de Entrega :"get m_txe pict "999.99"
         @ 24,48 SAY "Tx.de Montagem:"get m_txm pict "999.99"
      Endif
      Read
      RESTSCREEN(04,20,24,78,TC)

      wwntr = savescreen(09,05,20,78)
      @ 09,05 clear to 20,78
      cor=setcolor()
      Set color to GR+/B
      @ 11,12 clear to 16,75
      @ 11,12 SAY "Endere‡o de Entrega do Cliente "
      Sombra(12,12,16,75,Box)
      Set color to GR+/B
      While .t.
       @ 13,14 SAY "Endere‡o de Entrega"GET wEndTrega PICT "@!S28"
       @ 13,62 SAY "N§"GET wNumerot PICT "@!"
       @ 14,14 SAY "Complemento Enderec"GET wComplet PICT "@!"
       @ 15,14 SAY "Bairro "GET wBairTrega PICT "@!S20"
       @ 15,43 SAY "Cidade"GET wCidaTrega PICT "@!S17"
       @ 15,69 SAY "UF" GET wUFTrega PICT "@!"
       Read
       If !Empty(wEndTrega)
          If Empty(wBairTrega)
             Alert("Nome do Bairro Em Branco !")
             Loop
          Endif
          If Empty(wCidaTrega)
             Alert("Nome da Cidade Em Branco !")
             Loop
          Endif
          If Empty(wUFTrega)
             Alert("Nome da UF Em Branco !")
             Loop
          Endif
        /*
          z:=At(",",wEndTrega)
          If z = 0
             Alert("Coloque Uma Virgula no Endereco !")
             Alert("Se N„o Tiver o Numero,Coloque Assim:     ,S/N ")
             Loop
          Endif
        */
          Sele 14
          Veriout(setcolor(),23,"cidades")    && cadastro de cidades p/ faturamento COD_IBGE
          Go Top
          Set filter to nome = trim(wCidaTrega) .and. uf= wUFtrega
          Go Top
          PRIV VETOR1[2],VETOR2[2]
          VETOR1[1] ='NOME'
          VETOR1[2] ='UF'
          VETOR2[1] ='CIDADE'
          VETOR2[2] ='UF'
          mssv=savescreen(18,42,24,79)
          @ 18,43 TO 23,79 DOUBLE
          SETCOLOR("W+/BG+, B/RG,X")
          DBEDIT(19,44,22,78,VETOR1,,,VETOR2," ")
          restscreen(18,42,24,79,mssv)
          wIbgeTrega= COD_IBGE
          wCidaTrega= NOME
          wUFtrega  = UF
          wCepTrega = CEP
          If Lastkey() = 27
             Exit
          Endif
          If Empty(wIbgeTrega)
             Alert("Codigo do Municipio Errado. Verifique o nome da Cidade !")
             Set color to GR+/B
             Loop
          Endif
       Endif
       Exit
      Enddo
      RestScreen(09,05,20,78,wwntr)
      nResp:=0
      nResp:=Alert( "Confirma Altera‡„o Cadastro? ", {"Sim ","N„o "})
      If nResp=1
         wReg = 1
         Sele 25
         Set order to 1
         Seek Str(M_NOTA,8,0)
         While !Eof() .and. cd_codior = m_nota .and. cd_datao = m_datao
          If Bloqreg(0)
             Repl CD_RG WITH M_RG,CD_ENDE WITH ENDEX,CD_FONE WITH FON1X,CD_CPF WITH CPFX,CD_BAIR WITH M_BAICL,CD_OBSER WITH M_OBSER, ;
                  CD_CEP WITH M_CEPCL,CD_CIDA WITH M_CIDACL,CD_UF WITH M_UFCL,CD_REFER WITH M_REFER,CD_CODICL WITH M_CLIE, ;
                  CD_CGC WITH CGCX,CD_REFER2 WITH M_REFER2,CD_NOMECL WITH M_NOME, ;
                  CD_IMEI WITH M_IMEI,CD_CEL WITH M_CEL, ;
                  CD_ENDET with wEndtrega,CD_CIDAT with wCidaTrega,CD_BAIRT with wBairtrega, ;
                  CD_CEPT with wCeptrega,CD_IBGET with wIbgetrega,CD_UFT with wUftrega, ;
                  CD_NUMERO with wNumero,CD_NUMEROT with wNumerot,CD_COMPLE with wComple,CD_COMPLET with wComplet
             If wReg = 1
                wReg++
                Repl CD_TXE WITH M_TXE,CD_TXM WITH M_TXM
             Endif
          EndIf
          Comm
          Unlock
          Skip
         Enddo
      EndIf
      Exit
     Enddo
     Release wEndTrega,wCidaTrega,wBairTrega,wCepTrega,wIbgeTrega,wUfTrega,nResp
     Release wEndex,wBaicl,wCidacl,wUfcl,wOrca,wClie,wRecno,wwntr,TC,wReg
     Sele 25
     Set order to 1
     Seek STR(M_NOTA,8,0)
     KEYBOARD"S"
     RETURN(1)
   CASE LASTKEY()= -7
     ccons=savescreen(07,28,12,60)
     While .t.
        SET COLOR TO W+/W
        @ 08,28 clear to 12,59
        @ 08,28,12,59 BOX B_SINGLE
        SET COLOR TO N/W

        @ 08,28 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
        @ 09,28 Say "³"
	@ 10,28 Say "³"
	@ 11,28 Say "³"
        @ 12,28 Say "À"

         SET COLOR TO b+/w
         @ 09,30 PROM "Ordem Or‡amento     "
         @ 10,30 PROM "Por Nome do Cliente "
         @ 11,30 PROM "Por C.P.F do Cliente "
         Menu to op1c
         If Lastkey()=27
            RestScreen(07,28,12,60,ccons)
            KEYBOARD"S"
            RETURN(1)
	 Endif
	 If op1c = 1
	    Stor 0 to m_orca
	    @ 09,29 clear to 11,58
	    @ 10,29 Say "Or‡amento" get m_orca valid m_orca >0 pict "99999999"
	      Read
	      Sele 25
	      Set order to 1
	      Seek str(m_orca,8)
	      If Eof()
	         Alert("Or‡amento N„o Encontrado !")
	         Loop
	      Else
                 RestScreen(07,28,12,60,ccons)
                 KEYBOARD"S"
                 RETURN(1)
	      Endif
	 ElseIf op1c = 2
	    Stor Space(40) to m_nome
	    @ 09,29 clear to 11,58
	    @ 10,29 Say "Nome"get m_nome pict "@!S25" valid m_nome <> space(40)
	    Read
	    Sele 25
	    Set order to 2
	    Seek trim(m_nome)
	    If Eof()
	       Alert("Cliente N„o Encontrado !")
	       Loop
	    Else
               RestScreen(07,28,12,60,ccons)
               KEYBOARD"S"
               RETURN(1)
	    Endif
	 ElseIf op1c = 3
	    Stor Space(14) to m_cpf
	    @ 09,29 clear to 11,58
	    @ 10,29 Say "C.P.F"get m_cpf pict "999.999.999-99" valid m_cpf <> space(14)
	    Read
	    Sele 25
	    Set order to 3
	    Seek m_cpf
	    If Eof()
	       Alert("C.P.F. N„o Encontrado !")
	       Loop
	    Else
               RestScreen(07,28,12,60,ccons)
               KEYBOARD"S"
               RETURN(1)
            Endif
         Endif
     Enddo
   CASE LASTKEY()= -8      // Alterando a Data do Orcamento
    If VEND3<>CD_CODVEN
        Alert("Opera‡„o Recusada. Este or‡amento N„o pertence a este usu rio !")
        KEYBOARD"S"
        RETURN(1)
    Else
        ger=savescreen(15,26,22,50)
        SET COLOR TO W+/W
        @ 15,26 clear to 20,50
        @ 15,26,20,50 BOX B_SINGLE
        SET COLOR TO N/W
        m_senhger=space(15)
        @ 15,26 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
        @ 16,26 Say "³ Usu rio "+substr(m_nomeusu,1,10)
        @ 17,26 Say "³"
        @ 18,26 Say "³ Senha"
        @ 19,26 Say "³ "
        @ 20,26 Say "À"
        COR=SETCOLOR()
        SETCOLOR(C_CORS)
        @ 19,28 get m_senhger pict "@!"
        Read
        SETCOLOR(COR)
        RestScreen(15,26,22,50,ger)
        If m_senhger<>m_acesso
           Alert("Senha Errada. Tente Novamente !")
           KEYBOARD"S"
           RETURN(1)
        Endif
   Endif
     Sele 4
     Set Order to 15
     Seek str(m_nota,8,0)+substr(dtoc(M_Datao),7,4)+substr(dtoc(M_Datao),4,2)+substr(dtoc(M_Datao),1,2)
     If !Eof()
        Sele 25
        Set order to 1
        Alert("Venda Ja Efetuada !")
        KEYBOARD"S"
        RETURN(1)
     Endif
     SET COLOR TO W+/W
     @ 15,26 clear to 22,50
     @ 15,26,22,50 BOX B_SINGLE
     SET COLOR TO N/W
     SET CURSOR ON
     M_Dat =M_datsi
     @ 15,26 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
     @ 16,26 Say "³ Dta do Or‡amento "
     @ 17,26 Say "³ "+Dtoc(m_datao)
     @ 18,26 Say "³ Digite Nova Data "
     @ 19,26 Say "³ "
     @ 20,26 Say "³"
     @ 21,26 Say "³ "
     @ 22,26 Say "À"
     @ 19,28 get M_Dat pict "@!"
     Read
     RestScreen(15,26,22,50,ger)
     If m_dat=m_datao
        Alert("Datas Iguais !")
        SELE 25
        SET ORDER TO 1
        KEYBOARD"S"
        RETURN(1)
     Else
        SELE 25
        SET ORDER TO 1
        m_codior = cd_codior
        While !Eof() .and. cd_codior = m_codior
          If BloqReg(0)
             Repl cd_datao with M_Dat,cd_reserv with 0
          Endif
          Comm
          Unlock
          Skip
        Enddo
     Endif
     KEYBOARD"S"
     RETURN(0)
ENDCASE
RETURN(1)

//*******************
  Procedure Altera_It(m_nota,m_datao)
//*******************
While .t.
 Sele 25
 Set Order to 1
 Set Cursor On
 Cor=SetColor()
 Lin   = 9
 M_Alt = "N"
 Stor 0 to m_tota,t_garant,m_txe,m_txm
 ssb=savescreen(06,00,22,80)
 @ 06,00 clear to 19,79
 @ 06,00 to 19,79
 SetColor(C_Corg)
 @ 07,01 Say "Quant C¢digo Descri‡„o da Mercadoria     Cor       Saida      Unit R$   Total $"
 SetColor(Cor)
 @ 08,01 to 08,78
 While !Eof() .AND. CD_CODIOR = M_NOTA .AND. CD_DATAO = M_DATAO
   M_DATAO = CD_DATAO
   M_ULTIMA= CD_DATAO
   M_CODI  = CD_CODI
   M_CODX  = CD_CODI
   M_TIPO  = CD_TIPOV
   M_COR   = CD_COR
   M_UNIT  = CD_UNIT
   M_VRCIRC= CD_VRCIRC
   M_QUANT = CD_QUANT
   M_ENTRAD= CD_ENTRA
   M_VRP1  = CD_VRPARC1
   M_VRP2  = CD_VRPARC2
   M_VRP3  = CD_VRPARC3
   M_VRP4  = CD_VRPARC4
   M_NUM1  = CD_NUM1
   M_NUM2  = CD_NUM2
   M_NUM3  = CD_NUM3
   M_NUM4  = CD_NUM4
   M_DTA1  = CD_DTA1
   M_DTA2  = CD_DTA2
   M_DTA3  = CD_DTA3
   M_DTA4  = CD_DTA4
   M_DTA5  = CD_DTA5
   M_DTA6  = CD_DTA6
   M_DTA7  = CD_DTA7
   M_DTA8  = CD_DTA8
   M_VRFIN = CD_VRFIN
   M_VRCAR = CD_VRCAR
   M_CLIE  = CD_CODICL
   M_NOME  = CD_NOMECL
   ENDEX   = CD_ENDE
   FON1X   = CD_FONE
   CGCX    = CD_CGC
   CPFX    = CD_CPF
   M_BAICL = CD_BAIR
   M_CEPCL = CD_CEP
   M_CIDACL= CD_CIDA
   M_UFCL  = CD_UF
   M_REFER = CD_REFER
   M_REFER2= CD_REFER2
   M_OBSER = CD_OBSER
   M_SAIDA = CD_SAIDA
   M_RG    = CD_RG
   M_RESERV= CD_RESERV
   If CD_TXE >0
      M_TXE = CD_TXE
   Endif
   If CD_TXM >0
      M_TXM = CD_TXM
   Endif
   M_IMEI  = CD_IMEI
   M_CEL   = CD_CEL
   M_AUTOR = CD_AUTOR
   M_TIPO  = CD_TIPOV
   M_VEZES = CD_VEZES
   M_GR    = CD_GR
   M_PLANO = CD_PLANO
   SetColor(Cor)
   @ LIN,01 SAY M_QUANT pict "99999"
   @ LIN,07 SAY M_CODI PICT "999999"
   Read
   Sele 3
   Set Order to 1
   Goto Top
   Seek M_CODI
   If !Eof()
      @ LIN,14 SAY SUBSTR(CD_PROD,1,27)
   Else
      @ LIN,14 SAY "Erro no arquivo..."
   Endif
     M_Prod   = cd_prod
     M_Corp   = cd_cor
     M_Grupo  = cd_grup
     W_Faixap = cd_faixap
     M_Avista = cd_avista2
     M_Meses  = cd_gr
     M_SBGRUPO= cd_sbgrup
     If m_codi <> m_codx
        m_unit = cd_avista2
     Endif
     Sele 25
     Set Order to 1
     SetColor(Cor)
     If !Empty(m_corp)
        m_cor=m_corp
     Endif
     W_Unit = m_unit
     old_saida = m_saida
     @ LIN,42 GET M_COR   PICT "@!"
     If Empty(M_RESERV)
        @ LIN,52 GET M_SAIDA PICT "@!"
     Else
        @ LIN,52 SAY Substr(M_SAIDA,1,7)
     Endif
     @ LIN,62 GET M_UNIT  PICT "@E 9,999.99" VALID M_UNIT >0
     Read
     If m_autor >0 .and. m_unit < m_vrcirc
        m_autor = 0
        Alert("Este pre‡o estara sujeito a analise !")
     Endif
     If m_autor = 0 .and. m_unit < w_unit .and. m_tipo = 5 .and. m_vezes >1
        Alert("Pre‡o N„o Permitido !")
        Release w_unit
        Loop
     Endif
     If old_saida <> m_saida
        Alert("Informe a Sa¡da dos Produtos !")
        Sele 32
        Veriout(setcolor(),23,"saida_outras")
        Go Top
        M_CORA =SETCOLOR()
        TELA100=SAVESCREEN(05,00,22,79)
        SETCOLOR(C_corg)
        PRIV VETOR1[1]
        VETOR1[1]='SAIDA_ITEM'
        SETCOLOR("n+/w")
        DBEDIT(lin,52,lin+10,64,VETOR1,,,VETOR1)
        M_SAIDA = TRIM(SAIDA_ITEM)
        M_LJX   = LOJA
        RELEASE VETOR1
        RESTSCREEN(05,00,22,79,TELA100)
        SETCOLOR(M_CORA)
        Use
        Sele 25
        Set Order to 1
     Endif
     If (old_saida <> m_saida) .and. (Trim(m_saida) = "LOJA/MOST")
        Stor 0 to M_Res
        If (M_codx >5)
            M_Res := Ret_Res(m_codx)    // Funcoes.prg
            Stor 0 to Cent,m_pendenc,wTransit
            @ 19,15 Say "Aguarde, checando estoque... "
            SD_Fisc(M_Codx,,,@Cent,@M_Pendenc,@wTransit)
            M_SdPendenc := SD_Pend(m_codx)
            M_Pendenc = M_Pendenc + M_SdPendenc
            Sele 30
            Set Order to 1
            M_autoriz = cd_autoriz
            If m_transit <> wTransit
               m_transit = wTransit
            Endif
            CENTX = CENT - (cd_avaria+m_autoriz+m_res+cd_transit+M_PENDENC)
            Release cent
            If Centx <= 0 .or. M_Quant > Centx
               Sele 25
               Set Order to 1
               Alert("Estoque Insuficiente !")
               Release datex,datex1,m_datw,m_res
               Loop
            Endif
            If Trim(M_SAIDa) = "LOJA/MOSTR"
               Sele 4
               Set Order to 2
               Go Top
               Seek Str(M_codx,6,0)+substr(dtoc(m_datsi),7,4)+substr(dtoc(m_datsi),4,2)+substr(dtoc(m_datsi),1,2)
               Stor 0 to wAfaturar
               While !Eof() .and. sd_codi = M_codx .and. sd_data = m_datsi
                 If Trim(sd_saida) = "LOJA/MOSTR"
                    wJaFat := SD_JaFat(sd_codi,sd_nota)
                    If wJafat = 0
                       wAfaturar = wAfaturar + sd_qtde
                    Endif
                 Endif
                 Skip
               Enddo
               If wAfaturar+M_Quant > CENTX                    // Saldo das vendas maior que o fiscal
                  Alert("Estoque Insuficiente ou Venda Ainda N„o Faturada !")
                  Release datex,datex1,m_datw,m_res,wAfaturar,wJafat
                  Sele 25
                  Set Order to 1
                  Loop
               Endif
               Release wAfaturar,wJafat
            Endif
            @ 19,15 Say "                             "
        Endif
     Endif
     Release old_saida

        If (W_Faixap >0 .and. M_MESES > 12) .and. (M_SBGRUPO=8 .or. M_SBGRUPO=304)
           W_faixap = 0   // Colchoes e cama box acima de 12 meses
        Endif
       *W_faixap = 0
        w_plano = 0
        Stor 0 to w_garant_12,w_garant_24,w_garant_36
        Sele 101
        If xy_cap_int = "CC" .and. M_Datsi >= ctod("01/07/2022")
           Veriout(SetColor(24),23,"faixaprtwgcp")
           Set Index to index_faixaprtwgcp
        Else
           Veriout(SetColor(24),23,"faixaprtwg")
           Set Index to index_faixaprtwg
        Endif
        Go Top
        Seek W_faixap
        While !Eof() .and. faixa = W_faixap
          If M_AVISTA >= DE .and. M_AVISTA <= ATE .and. plano = 12
             w_garant_12 = premio_tot
          Endif
          If M_AVISTA >= DE .and. M_AVISTA <= ATE .and. plano = 24
             w_garant_24 = premio_tot
          Endif
          If M_Datsi >= ctod("01/07/2022")
             If m_grupo <> 4 .and. m_grupo <> 6 .and. m_grupo <> 18 .and. m_grupo <> 19
                If M_AVISTA >= DE .and. M_AVISTA <= ATE .and. plano = 36 .and. M_MESES <= 12
                   w_garant_36 = premio_tot
                Endif
             Endif
          Endif
          Skip
        Enddo
        Use

        Sele 25
        Set Order to 1
        If w_faixap = 34 .AND. M_MESES >0 .and. w_faixap >0
           If w_garant_24 >0 .AND. M_MESES < 24
              Alert("Troca Garantida 24 Meses R$ "+str(w_garant_24,6,2)+", Troca Garantida 12 Meses R$ "+str(w_garant_12,6,2))
           Else
              w_garant_36 = 0
              w_garant_24 = 0
              Alert("Troca Garantida 12 Meses R$ "+str(w_garant_12,6,2))
           Endif
        Else
           If W_faixap >0
              If w_garant_24 >0 .AND. M_MESES >0 .AND. M_MESES < 24
                 Alert("Garantia 24 Meses R$ "+str(w_garant_24,6,2)+", Garantia 12 Meses R$ "+str(w_garant_12,6,2))
              ElseIf M_MESES >0
                 w_garant_24 = 0
                 Alert("Garantia 12 Meses R$ "+str(w_garant_12,6,2))
              Else
                 Stor 0 to w_garant_24,w_garant_12,w_garant_36
              Endif
           Endif
        Endif

        Stor 0 to w_plav,w_garant
        mfrt = Savescreen(18,04,24,77)
        cor=setcolor()
        SETCOLOR("W+/BG+, B/RG,X")

        If w_faixap <> 34 .AND. M_MESES >0 .AND. M_MESES < 24 .and. w_faixap >0
           If w_garant_36 >0 .AND. M_MESES <= 12
              @ 18,14 clear to 20,77
              @ 18,14 to 20,77
              @ 19,15 prom "Plano (36)"
              @ 19,26 prom "Plano (24)"
              @ 19,37 prom "Plano (12)"
              @ 19,48 prom "Avulsa (av ou 3x)"
              @ 19,66 prom "S/Garantia"
              Menu to m_grts
              If m_grts = 4
                 @ 20,50 clear to 23,63
                 @ 20,50 to 23,63
                 @ 21,51 prom "Avulsa (24)"
                 @ 22,51 prom "Avulsa (12)"
	         Menu to m_grt_x
		 If m_grt_x = 1
		    w_plav   := w_garant_24
	            w_garant := 0
 	            w_plano  := 2
		 Else
		    w_plav   := w_garant_12
 	            w_garant := 0
 	            w_plano  := 1
		 Endif
		 Release m_grt_x
	      Endif
	      If m_grts = 1
	         w_garant := w_garant_36
                 w_plano  := 3
	      ElseIf m_grts = 2
	         w_garant := w_garant_24
                 w_plano  := 2
	      ElseIf m_grts = 3
	         w_garant := w_garant_12
                 w_plano  := 1
              Endif
           ElseIf w_garant_24 >0
              @ 18,14 clear to 20,76
              @ 18,14 to 20,76
              @ 19,15 prom "C/Garantia(24)"
              @ 19,31 prom "C/Garantia(12)"
              @ 19,47 prom "Avulsa (av ou 3x)"
	      @ 19,66 prom "S/Garantia"
	      Menu to m_grts
	      If m_grts = 3
                 @ 20,50 clear to 23,63
                 @ 20,50 to 23,63
                 @ 21,51 prom "Avulsa (24)"
                 @ 22,51 prom "Avulsa (12)"
	         Menu to m_grt_x
		 If m_grt_x = 1
		    w_plav   := w_garant_24
	            w_garant := 0
 	            w_plano  := 2
		 Else
		    w_plav   := w_garant_12
 	            w_garant := 0
 	            w_plano  := 1
		 Endif
		 Release m_grt_x
	      Endif
	      If m_grts = 1
	         w_garant := w_garant_24
                 w_plano  := 2
	      ElseIf m_grts = 2
	         w_garant := w_garant_12
                 w_plano  := 1
	      ElseIf m_grts = 4
  	         w_garan  := 0
 	         w_plano  := 0
	      Endif
           ElseIf M_MESES >0
              @ 18,20 clear to 20,68
              @ 18,20 to 20,68
              @ 19,21 prom "C/Garantia(12)"
              @ 19,37 prom "Avulsa (av ou 3x)"
	      @ 19,56 prom "S/Garantia"
   	      Menu to m_grts
	      If m_grts = 1
	         w_garant := w_garant_12
                 w_plano  := 1
	      ElseIf m_grts = 2
   	         w_plav   := w_garant_12
 	         w_garant := 0
 	         w_plano  := 1
	      ElseIf m_grts = 3
  	         w_garant := 0
 	         w_plano  := 0
	      Endif
	   Endif
        Else                                         // Troca Garantida
	   If w_garant_24 >0 .and. M_MESES >0 .and. M_MESES < 24 .and. w_faixap >0
              @ 18,04 clear to 20,76
              @ 18,04 to 20,76
              @ 19,05 prom "Troca Garantida(24)"
              @ 19,26 prom "Troca Garantida(12)"
              @ 19,47 prom "Avulsa (av ou 3x)"
	      @ 19,66 prom "S/Garantia"
   	      Menu to m_grts
	      If m_grts = 3
                 @ 20,50 clear to 23,63
                 @ 20,50 to 23,63
                 @ 21,51 prom "Avulsa (24)"
                 @ 22,51 prom "Avulsa (12)"
	         Menu to m_grt_x
		 If m_grt_x = 1
		    w_plav   := w_garant_24
	            w_garant := 0
 	            w_plano  := 2
		 Else
		    w_plav   := w_garant_12
 	            w_garant := 0
 	            w_plano  := 1
		 Endif
		 Release m_grt_x
	      Endif
	      If m_grts = 1
	         w_garant := w_garant_24
                 w_plano  := 2
	      ElseIf m_grts = 2
	         w_garant := w_garant_12
                 w_plano  := 1
	      ElseIf m_grts = 4
  	         w_garant := 0
 	         w_plano  := 0
	      Endif
           ElseIf M_MESES >0
              @ 18,10 clear to 20,63
              @ 18,10 to 20,63
              @ 19,11 prom "Troca Garantida(12)"
              @ 19,32 prom "Avulsa (av ou 3x)"
	      @ 19,51 prom "S/Garantia"
   	      Menu to m_grts
	      If m_grts = 1
	         w_garant := w_garant_12
                 w_plano  := 1
	      ElseIf m_grts = 2
    	         w_plav   := w_garant_12
 	         w_garant := 0
 	         w_plano  := 1
	      ElseIf m_grts = 3
  	         w_garant := 0
 	         w_plano  := 0
	      Endif
	   Endif
        Endif
     If xy_cap_int <> "CC"       &&  Filiais do Interior
        If m_tipo = 1            && A Vista
           m_tx_cc    = 0
  	   m_vezes= 1
        ElseIf m_tipo = 2        && C/Cheque
           m_tx_cc = I_TXCHEQUE
        ElseIf m_tipo = 3        && C/Carne
           m_tx_cc = I_TXCARNE
           m_venda = m_venda + w_garant   // Composicao do pr de partida
        ElseIf m_tipo = 4        && C/Financeira
           m_tx_cc    = 0
  	   m_vezes= 1
        ElseIf m_tipo = 6 .or.  m_tipo = 8        && Convenio
           m_tx_cc    = 0
	   m_vezes= 1
*          m_tx_cc = I_TXCONVEN
        ElseIf m_tipo = 5        && Cartao de Credito
          m_tx_cc = 0
          If m_debcc = 2
	     m_vezes= 1
          ElseIf m_debcc = 3
	     m_vezes= 1
          ElseIf m_debcc = 4
	     m_vezes= 2
          ElseIf m_debcc = 5
             m_vezes= 3
          ElseIf m_debcc = 7
             m_vezes= 5
          Else
             If m_grupo = 1 .or. m_grupo = 2 .or. m_grupo = 3 .or. m_grupo = 6 .or. m_grupo = 9 .or. m_grupo = 15 .or. m_grupo = 16 .or. m_grupo = 17 .or. m_grupo = 18 .or. m_grupo = 19
                m_tx_cc = I_TXELEINT          // Taxa de eletro p/ interior (cartao)
             ElseIf m_grupo = 8
                m_tx_cc = I_TXCELCC           // Taxa de celulares p/ interior (cartao)
             ElseIf m_grupo = 7 .or. m_grupo = 11
                m_tx_cc = I_TXINFCCI          // Taxa de informtica p/ interior (cartao)
             ElseIf m_grupo = 4
                m_tx_cc = I_TXMOVINT          // Taxa de moveis p/ interior (cartao)
             ElseIf m_grupo = 5
                m_tx_cc = I_TXMOTOS           // Taxa de motos
             Endif
          Endif
      Endif
    Else                // Filiais da Capital
      m_venda = m_venda + m_txab + m_frt + m_mon    // Composicao do pr de partida
      If m_tipo = 1            && A Vista
         m_tx_cc = 0
	 m_vezes= 1
      ElseIf m_tipo = 2        && C/Cheque
         m_tx_cc = I_TXCHEQUE
      ElseIf m_tipo = 3        && C/Carne
         m_tx_cc = I_TXCARNE
         m_venda = m_venda + w_garant   // Composicao do pr de partida
      ElseIf m_tipo = 4        && C/Financeira
         m_tx_cc    = 0
	 m_vezes= 1
	 m_venda = m_venda + m_txab + w_garant
      ElseIf m_tipo = 6 .or. m_tipo = 8      && Convenio
         m_tx_cc    = 0
	 m_vezes= 1
*         m_tx_cc = I_TXCONVEN
      ElseIf m_tipo = 5                      && Cartao de Credito
	   m_tx_cc = 0
           m_venda = m_venda + w_garant   // Composicao do pr de partida
        If m_debcc = 2
	   m_vezes= 1
        ElseIf m_debcc = 3
	   m_vezes= 1
        ElseIf m_debcc = 4
	   m_vezes= 2
        ElseIf m_debcc = 5
	   m_vezes= 3
        ElseIf m_debcc = 6
	   m_vezes= 5
	Else
          If m_grupo = 1 .or. m_grupo = 2 .or. m_grupo = 3 .or. m_grupo = 6 .or. m_grupo = 9 .or. m_grupo = 15 .or. m_grupo = 16 .or. m_grupo = 17 .or. m_grupo = 18 .or. m_grupo = 19
             m_tx_cc = I_TXELECAP          // Taxa de eletro p/ interior (cartao)
          ElseIf m_grupo = 8
             m_tx_cc = I_TXCELCC           // Taxa de celulares p/ Capital e Interior (cartao)
          ElseIf m_grupo = 7 .or. m_grupo = 11
             m_tx_cc = I_TXINFCCC          // Taxa de informtica p/ capital (cartao)
          ElseIf m_grupo = 4
             m_tx_cc = I_TXMOVCAP          // Taxa de moveis p/ capital (cartao)
          ElseIf m_grupo = 5
             m_tx_cc = I_TXMOTOS           // Taxa de motos
          Endif
        Endif
      Endif
     Endif

     M_GRFATOR = 0
     If w_garant > 0
        W_gr1 = Str(Parc_Fin(w_garant,m_tx_cc,m_vezes,.f.),10,2)
        M_GRFATOR = round((Val(W_gr1) * m_vezes),1)
        Release w_gr1
     Endif

     T_garant = T_garant + M_GRFATOR

     Restscreen(18,04,24,77,mfrt)

     Release w_faixap,mfrt,m_grts
     @ LIN,52 SAY M_SAIDA
     @ LIN,70 SAY M_UNIT * M_QUANT PICT "@E 99,999.99"
     M_TOTA = M_TOTA + m_grfator + (M_UNIT * M_QUANT)
     @ 19,69 SAY M_TOTA PICT "@E 999,999.99"
     LIN = LIN + 1
     IF LIN > 18
        LIN = 18
	Scroll(09,01,18,78,1)
     ENDIF
     nResp:=0
     nResp:=Alert( "Confirma  Altera‡„o Item ? ", {"Sim ","N„o "})
     If nResp=1
        If Bloqreg(0)
           Repl cd_codi with m_codi,cd_tipov with m_tipo,cd_cor with m_cor,cd_prod with m_prod, ;
   	        cd_unit with m_unit,cd_saida with m_saida,cd_quant with m_quant,cd_autor with m_autor, ;
		cd_plano with w_plano,cd_status with "O",CD_FATORGR WITH M_GRFATOR
		If w_plano > 0
		   Repl cd_vrgr with w_garant,cd_gr with "S",cd_dtgr with m_datsi
                Else
		   Repl cd_vrgr with 0,cd_gr with "N"
		Endif
 	        If w_plav >0              // Venda com Garantia Avulsa
 	           Repl cd_status with "A",cd_vrgr with w_plav,cd_plano with w_plano
                Endif
	        Release w_plav

	   M_Alt="S"
	   Unlock
	   If m_grupo = 8 .and. !Empty(cd_imei) .and. Len(cd_imei) = 15
              w_PROD = TRIM(CD_PROD)
              z:=At("TRIANG",w_PROD)
              If z != 0
	         w_triang = "S"
              Endif
	   Endif
        EndIf
     Endif
     nResp:=0
     nResp:=Alert( "Altera Outro Item ? ", {"Sim ","N„o "})
     If nResp= 2
        Exit
     EndIf
     Skip
   ENDDO
   IF M_TIPO = 4
      SOMBRA(11,05,13,31,BOX)
      @ 12,06 SAY 'VALOR ENTRADA 'Get M_VRFIN PICT "@E 999,999.99"
      READ
    ENDIF
    M_VRCAR = 0
    IF M_TIPO = 5
       SOMBRA(11,05,13,31,BOX)
       @ 12,06 SAY 'VALOR ENTRADA 'Get M_VRCAR PICT "@E 999,999.99"
       READ
    ENDIF
    Stor 0 to M_tota,m_grfator
    Sele 25
    Set Order to 1
    Seek Str(m_nota,8,0)
    While !Eof() .and. cd_codior = m_nota
      If cd_datao = m_datao
         M_tota = M_Tota+ cd_fatorgr + (cd_unit*cd_quant)
         If Bloqreg(0)
            Repl cd_vrcar with m_vrcar,cd_vrfin with m_vrfin,cd_entra with m_vrcar
         Endif
         Unlock
      EndIf
       Skip
    EndDo

    Stor 0 to S_Dia

   IF M_TIPO = 2 .OR. M_TIPO = 3 .OR. M_TIPO = 6 .and. M_Alt="S"
      M_Nott = M_tota
      SETCOLOR(CINZA)
      @ 14,01 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
      @ 15,01 say "³ T.Compra   Entrada  Financiado N§Prest  Vr.Prest         Vencimentos       ³"
      @ 16,01 say "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
      @ 17,01 say "³                                  (  )            Dˆ            A           ³"
      @ 18,01 say "³                                  (  )            Dˆ            A           ³"
      @ 19,01 say "³                                  (  )            Dˆ            A           ³"
      @ 20,01 say "³                                  (  )            Dˆ            A           ³"
      @ 21,01 say "³TOTAL.................................                                      ³"
      @ 22,01 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
      @ 18,02 SAY M_NOTT   PICT "@E 999,999.99"
      @ 18,12 GET M_ENTRAD PICT "@E 99,999.99"
      READ
      IF LASTKEY()=27
         restscreen(06,00,20,80,ssb)
         Return
      ENDIF
      M_VRP1=M_ENTRAD
      @ 18,23 SAY M_NOTT-M_ENTRAD PICT "@E 999,999.99"
      @ 17,37 GET M_NUM1 PICT "99" VALID M_NUM1 >0 .AND. M_NUM1<16
        READ
        M_VRP1=(M_NOTT-M_ENTRAD) / M_NUM1
      @ 17,41 GET M_VRP1 PICT "@E 999,999.99"
        M_DATT=M_ULTIMA
        S_DIA := SOMADIA(m_ultima)
        M_DTA1=M_ULTIMA+S_DIA
        M_DIA1=DTOC(M_DTA1)
      @ 17,55 GET M_DTA1 VALID M_DTA1 >=M_DATAO
      @ 17,68 GET M_DTA2 VALID M_DTA2 >=M_DATAO
      @ 18,37 GET M_NUM2 PICT "99"
      @ 18,41 GET M_VRP2 PICT "@E 999,999.99"
      @ 18,55 GET M_DTA3
      @ 18,68 GET M_DTA4
      @ 19,37 GET M_NUM3 PICT "99"
      @ 19,41 GET M_VRP3 PICT "@E 999,999.99"
      @ 19,55 GET M_DTA5
      @ 19,68 GET M_DTA6
      @ 20,37 GET M_NUM4 PICT "99"
      @ 20,41 GET M_VRP4 PICT "@E 999,999.99"
      @ 20,55 GET M_DTA7
      @ 20,68 GET M_DTA8
      READ
      M_NUM=M_NUM1+M_NUM2+M_NUM3+M_NUM4
      M_TOTT = (M_VRP1*M_NUM1)+(M_VRP2*M_NUM2)+(M_VRP3*M_NUM3)+(M_VRP4*M_NUM4)+M_ENTRAD
      @ 21,41 SAY M_TOTT PICT "@E 999,999.99"
      IF STR(M_TOTT,10,2) >STR(M_NOTT,10,2) .OR. STR(M_TOTT,10,2) < STR(M_NOTT,10,2)
          nResp:=0
          nResp:=Alert("Plano N„o Confere. Abandona Or‡amento ?", {"Sim ","N„o "})
          If nResp=2
             restscreen(06,00,20,80,ssb)
             Return
          ELSE
             CONTINUA = "N"
             M_TOTS   = "N"
             M_AJUST  = "S"
             EXIT
         ENDIF
      ENDIF

    Sele 25
    Set Order to 1
    Seek Str(m_nota,8,0)
    While !eof() .and. cd_codior = m_nota .and. cd_datao = m_datao
     If Bloqreg(0)
        Repl CD_NUMPRE WITH M_NUM,CD_ENTRA WITH M_ENTRAD,CD_NUM1 WITH M_NUM1,CD_NUM2 WITH M_NUM2,CD_NUM3 WITH M_NUM3,CD_NUM4 WITH M_NUM4, ;
             CD_VRPARC1 WITH M_VRP1,CD_VRPARC2 WITH M_VRP2,CD_VRPARC3 WITH M_VRP3,CD_VRPARC4 WITH M_VRP4,CD_DTA1 WITH M_DTA1, ;
             CD_DTA2 WITH M_DTA2,CD_DTA3 WITH M_DTA3,CD_DTA4 WITH M_DTA4,CD_DTA5 WITH M_DTA5,CD_DTA6 WITH M_DTA6,CD_DTA7 WITH M_DTA7,CD_DTA8 WITH M_DTA8
        Unlock
     EndIf
     Skip
    EndDo
  Endif
  Clear Gets
  Release M_DATAO,M_ULTIMA,M_CODI,M_TIPO,M_COR,M_UNIT,M_QUANT,M_ENTRAD,M_VRP1
  Release M_VRP2,M_VRP3,M_VRP4,M_NUM1,M_NUM2,M_NUM3,M_NUM4,M_DTA1,M_DTA2,M_DTA3
  Release M_DTA4,M_DTA5,M_DTA6,M_DTA7,M_DTA8,M_VRFIN,M_VRCAR,M_CLIE,M_NOME,ENDEX
  Release FON1X,CGCX,CPFX,M_BAICL,M_CEPCL,M_CIDACL,M_UFCL,M_REFER,M_REFER2,M_OBSER
  Release M_SAIDA,M_RG,M_RESERV,M_TXE,M_TXM,M_IMEI,M_CEL,M_VRCIRC,M_GR,M_PLANO
  RestScreen(06,00,20,80,ssb)
  Return
Enddo

//*******************
  Procedure Exclui_it
//*******************
While .t.
 Set Cursor On
 Cor=SetColor()
 Lin = 9
 M_Alt = "N"
 ssb=savescreen(06,00,22,80)
 Sombra(06,00,19,79,Box)
 SetColor(C_Corg)
 @ 07,01 Say "Quant C¢digo Descri‡„o da Mercadoria     Cor       Saida      Unit R$   Total $"
 SetColor(Cor)
 @ 08,01 to 08,78
 M_NOTA =cd_codior
 M_DATAO=cd_datao
 Stor 0 to M_tota
 Sele 25
 Set Order to 1
 Seek str(m_nota,8,0)
 WHILE !EOF() .AND. CD_CODIOR = M_NOTA .AND. CD_DATAO = M_DATAO
   M_DATAO = CD_DATAO
   M_ULTIMA= CD_DATAO
   M_CODI  = CD_CODI
   M_CODX  = CD_CODI
   M_PROD  = CD_PROD
   M_TIPO  = CD_TIPOV
   M_ENTRAD= CD_ENTRA
   M_VRP1  = CD_VRPARC1
   M_VRP2  = CD_VRPARC2
   M_VRP3  = CD_VRPARC3
   M_VRP4  = CD_VRPARC4
   M_NUM1  = CD_NUM1
   M_NUM2  = CD_NUM2
   M_NUM3  = CD_NUM3
   M_NUM4  = CD_NUM4
   M_DTA1  = CD_DTA1
   M_DTA2  = CD_DTA2
   M_DTA3  = CD_DTA3
   M_DTA4  = CD_DTA4
   M_DTA5  = CD_DTA5
   M_DTA6  = CD_DTA6
   M_DTA7  = CD_DTA7
   M_DTA8  = CD_DTA8
   M_VRFIN = CD_VRFIN
   M_VRCAR = CD_VRCAR

     @ LIN,01 SAY CD_QUANT pict "99999"
     @ LIN,07 SAY CD_CODI PICT "999999"
     @ LIN,14 SAY SUBSTR(CD_PROD,1,27)
     @ LIN,42 SAY CD_COR PICT "@!"
     @ LIN,52 SAY CD_SAIDA PICT "@!"
     @ LIN,62 SAY CD_UNIT PICT "@E 9,999.99"
     @ LIN,70 SAY CD_UNIT * CD_QUANT PICT "@E 99,999.99"
     M_TOTA = M_TOTA + (CD_UNIT * CD_QUANT)
     @ 19,69 SAY M_TOTA PICT "@E 999,999.99"
     LIN = LIN + 1
     IF LIN > 18
        LIN = 18
	Scroll(09,01,18,78,1)
     ENDIF
     SKIP
   ENDDO

    Stor 0 to S_Dia
    IF M_TIPO = 2 .OR. M_TIPO = 3 .OR. M_TIPO = 6
      M_Nott = M_tota
      SETCOLOR(CINZA)
      @ 14,01 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
      @ 15,01 say "³ T.Compra   Entrada  Financiado N§Prest  Vr.Prest         Vencimentos       ³"
      @ 16,01 say "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
      @ 17,01 say "³                                  (  )            Dˆ            A           ³"
      @ 18,01 say "³                                  (  )            Dˆ            A           ³"
      @ 19,01 say "³                                  (  )            Dˆ            A           ³"
      @ 20,01 say "³                                  (  )            Dˆ            A           ³"
      @ 21,01 say "³TOTAL.................................                                      ³"
      @ 22,01 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
      @ 18,02 SAY M_NOTT   PICT "@E 999,999.99"
      @ 18,12 GET M_ENTRAD PICT "@E 99,999.99"
      READ
      IF LASTKEY()=27
         restscreen(06,00,20,80,ssb)
         Return
      ENDIF
        M_VRP1=M_ENTRAD
      @ 18,23 SAY M_NOTT-M_ENTRAD PICT "@E 999,999.99"
      @ 17,37 GET M_NUM1 PICT "99" VALID M_NUM1 >0 .AND. M_NUM1<16
        READ
        M_VRP1=(M_NOTT-M_ENTRAD) / M_NUM1
      @ 17,41 GET M_VRP1 PICT "@E 999,999.99"
        M_DATT=M_ULTIMA
        S_Dia := SOMADD(m_ultima)
        M_DTA1=M_ULTIMA+S_DIA
        M_DIA1=DTOC(M_DTA1)
      @ 17,55 GET M_DTA1 VALID M_DTA1 >=M_DATAO
      @ 17,68 GET M_DTA2 VALID M_DTA2 >=M_DATAO
      @ 18,37 GET M_NUM2 PICT "99"
      @ 18,41 GET M_VRP2 PICT "@E 999,999.99"
      @ 18,55 GET M_DTA3
      @ 18,68 GET M_DTA4
      @ 19,37 GET M_NUM3 PICT "99"
      @ 19,41 GET M_VRP3 PICT "@E 999,999.99"
      @ 19,55 GET M_DTA5
      @ 19,68 GET M_DTA6
      @ 20,37 GET M_NUM4 PICT "99"
      @ 20,41 GET M_VRP4 PICT "@E 999,999.99"
      @ 20,55 GET M_DTA7
      @ 20,68 GET M_DTA8
      READ
      M_NUM=M_NUM1+M_NUM2+M_NUM3+M_NUM4
      M_TOTT = (M_VRP1*M_NUM1)+(M_VRP2*M_NUM2)+(M_VRP3*M_NUM3)+(M_VRP4*M_NUM4)+M_ENTRAD
      @ 21,41 SAY M_TOTT PICT "@E 999,999.99"
      IF STR(M_TOTT,10,2) >STR(M_NOTT,10,2) .OR. STR(M_TOTT,10,2) < STR(M_NOTT,10,2)
         nResp:=0
         nResp:=Alert("Plano N„o Confere. Abandona Or‡amento ?", {"Sim ","N„o "})
         If nResp=2
            restscreen(06,00,20,80,ssb)
            Return
         ELSE
           CONTINUA = "N"
           M_TOTS   = "N"
           M_AJUST  = "S"
           EXIT
         ENDIF
      ENDIF
      Sele 25
      Set Order to 1
      Seek Str(m_nota,8,0)
      While !eof() .and. cd_codior = m_nota .and. cd_datao = m_datao
       If Bloqreg(0)
          Repl CD_NUMPRE WITH M_NUM,CD_ENTRA WITH M_ENTRAD,CD_NUM1 WITH M_NUM1,CD_NUM2 WITH M_NUM2,CD_NUM3 WITH M_NUM3,CD_NUM4 WITH M_NUM4, ;
               CD_VRPARC1 WITH M_VRP1,CD_VRPARC2 WITH M_VRP2,CD_VRPARC3 WITH M_VRP3,CD_VRPARC4 WITH M_VRP4, ;
               CD_DTA1 WITH M_DTA1,CD_DTA2 WITH M_DTA2,CD_DTA3 WITH M_DTA3,CD_DTA4 WITH M_DTA4, ;
               CD_DTA5 WITH M_DTA5,CD_DTA6 WITH M_DTA6,CD_DTA7 WITH M_DTA7,CD_DTA8 WITH M_DTA8
       EndIf
       Unlock
       Skip
      EndDo
  Endif
  Clear Gets
  Release M_DATAO,M_ULTIMA,M_CODI,M_TIPO,M_ENTRAD,M_VRP1,t_garant
  Release M_VRP2,M_VRP3,M_VRP4,M_NUM1,M_NUM2,M_NUM3,M_NUM4,M_DTA1,M_DTA2,M_DTA3
  Release M_DTA4,M_DTA5,M_DTA6,M_DTA7,M_DTA8,M_VRFIN,M_VRCAR,M_CLIE,M_NOME,ENDEX
  RestScreen(06,00,20,80,ssb)
  Return
Enddo

//*******************
  Procedure Inclui_it          && Incluindo Item
//*******************
  Alert("Opcao suspensa momentaneamente !")
  Return
While .t.
  Set Cursor on
  Stor 0 to m_tota,m_grto,m_totac,m_totd,m_de,m_ac,nResp,m_txe,m_txm
  w_mod = "  "
  Set Color to
  LIN     = 09
  M_TOTS  = "N"
  M_AJUST = "N"             && VARIAVEL DE APOIO
  M_Alt   = "N"
  M_SAIDA = SPACE(18)
  M_AUTOR = 0
  Sele 25
  Set Order to 1
  Seek str(m_nota,8,0)
  M_TIPO  = CD_TIPOV
  M_DATAO = CD_DATAO
  M_ULTIMA= CD_DATAO
  M_CODI  = CD_CODI
  M_CODX  = CD_CODI
  M_COR   = CD_COR
  M_UNIT  = CD_UNIT
  M_QUANT = CD_QUANT
  M_ENTRAD= CD_ENTRA
  M_VRP1  = CD_VRPARC1
  M_VRP2  = CD_VRPARC2
  M_VRP3  = CD_VRPARC3
  M_VRP4  = CD_VRPARC4
  M_NUM1  = CD_NUM1
  M_NUM2  = CD_NUM2
  M_NUM3  = CD_NUM3
  M_NUM4  = CD_NUM4
  M_DTA1  = CD_DTA1
  M_DTA2  = CD_DTA2
  M_DTA3  = CD_DTA3
  M_DTA4  = CD_DTA4
  M_DTA5  = CD_DTA5
  M_DTA6  = CD_DTA6
  M_DTA7  = CD_DTA7
  M_DTA8  = CD_DTA8
  M_VRFIN = CD_VRFIN
  M_VRCAR = CD_VRCAR
  M_CLIE  = CD_CODICL
  M_NOME  = CD_NOMECL
  ENDEX   = CD_ENDE
  FON1X   = CD_FONE
  CGCX    = CD_CGC
  CPFX    = CD_CPF
  M_BAICL = CD_BAIR
  M_CEPCL = CD_CEP
  M_CIDACL= CD_CIDA
  M_UFCL  = CD_UF
  M_REFER = CD_REFER
  M_REFER2= CD_REFER2
  M_OBSER = CD_OBSER
  M_SAIDA = CD_SAIDA
  M_RG    = CD_RG
  If CD_TXE >0
     M_TXE = CD_TXE
  Endif
  If CD_TXM >0
     M_TXM = CD_TXM
  Endif
  M_IMEI  = CD_IMEI
  M_CEL   = CD_CEL
  V_NOME  = CD_VENDED 
  M_VEND  = CD_CODVEN 
  M_DEBCC = CD_DEBCC
  M_VEZES = CD_VEZES
  M_GR    = CD_GR
  M_PLANO = CD_PLANO
  If CD_ENTRA >0
     M_PLM = 2
  Else
     M_PLM = 1
  Endif
  If !Empty(cd_imei) .and. Len(cd_imei) = 15
     w_PROD = TRIM(CD_PROD)
     z:=At("TRIANG",w_PROD)
     If z != 0
        w_triang = "S" 
     Endif
  Endif   

  SSB=savescreen(06,00,22,80)
  Sombra(06,00,19,79,Box)
  SetColor(C_Corg)
  @ 07,01 Say "Quant C¢digo Descri‡„o da Mercadoria     Cor       Saida      Unit R$   Total $"
  SetColor(Cor)
  @ 08,01 to 08,78
  
  Stor 0 to m_txab,m_frt,m_mon,t_garant

  While !Eof() .AND. CD_CODIOR = M_NOTA .AND. CD_DATAO = M_DATAO
    @ LIN,01 SAY CD_QUANT pict "99999"
    @ LIN,07 SAY CD_CODI PICT "999999" 
    @ LIN,14 SAY SUBSTR(CD_PROD,1,27)
    @ LIN,42 SAY CD_COR PICT "@!"
    @ LIN,50 SAY CD_SAIDA PICT "@!"
*    @ LIN,62 SAY CD_UNIT PICT "@E 9,999.99"
    If cd_tipov = 2 .or. cd_tipov = 3
       @ LIN,70 SAY cd_fatorgr + (CD_UNIT * CD_QUANT) PICT "@E 99,999.99"
    Else
       @ LIN,70 SAY CD_UNIT * CD_QUANT PICT "@E 99,999.99"
    Endif        
    T_garant = T_garant + cd_fatorgr
    m_grto   = m_tota
    If cd_tipov = 2 .or. cd_tipov = 3
       M_TOTA = M_TOTA +  cd_fatorgr + (CD_UNIT * CD_QUANT) 
    Else
       M_TOTA = M_TOTA + (CD_UNIT * CD_QUANT)
    Endif
    @ 20,69 SAY M_TOTA PICT "@E 999,999.99"

       LIN = LIN + 1
    If LIN > 18
       LIN = 18
       Scroll(09,01,18,78,1)
    Endif
    If (cd_tipov = 1 .or. cd_tipov = 4 .or. cd_tipov = 5 .or. cd_tipov = 8) .and. (T_Garant >0)
        Cor=Setcolor()
        Setcolor("GR+/B")
        @ 21,59 SAY "Garantia Est"
        Cor=Setcolor(Cor)
        @ 21,69 SAY T_Garant          PICT "@E 999,999.99"
        @ 22,69 SAY M_TOTA + T_Garant PICT "@E 999,999.99"
    Endif
    Skip
  Enddo

 While .T.
     M_Data=M_ULTIMA
     Stor 0 to M_CODX,M_QUANT,M_PE,M_PRE
     @ LIN,01 GET M_QUANT pict "99999" VALID M_QUANT >0
     @ LIN,07 GET M_CODX PICT "999999" VALID M_CODX >0
     Read
     If Lastkey() = 27
        Exit
     Endif
     SELE 3
     SET ORDER TO 1
     GOTO TOP
     SEEK M_CODX
     If !Eof()
        @ LIN,14 SAY SUBSTR(CD_PROD,1,29)
     Else
        @ LIN,14 SAY "Erro no arquivo..."
     Endif
     @ LIN,07 SAY STRZERO(M_CODX,6)
     @ LIN,14 SAY SUBSTR(CD_PROD,1,27)+" "+SUBSTR(CD_COR,1,6)
     M_PROMO = CD_PROMO
     M_CUSTO = CD_CUST
     M_QUANT = M_QUANT
     M_GRUPO = CD_GRUP
     M_COR   = SUBSTR(CD_COR,1,7)
     M_PRD   = CD_PROD
     M_AVISTA= CD_AVISTA2
     M_VENDA = CD_AVISTA2
     W_FAIXAP= CD_FAIXAP
     M_MESES = CD_GR
     M_SBGRUPO=CD_SBGRUP

     COR=SETCOLOR()
     IF CD_TABELA <> "S"
        nResp:=0
        nResp:=Alert( "Produto Fora da Tabela", {"Libera ","Cancela "})
        IF nResp <> 1
           NEGA(23)
           SETCOLOR(COR)
           LOOP
        ENDIF
        COR=SETCOLOR()
	SENHX=SPACE(15)
        SETCOLOR(C_CORG)
	sstv=savescreen(13,13,16,42)
        SOMBRA(13,13,15,40,BOX)
        SETCOLOR("BG+/B+")
        @14,14 SAY 'Digite sua senha:'
        SET COLOR TO W/br, X
        @14,32 GET SENHX  PICT '@!S8'
        READ
        RestScreen(13,13,16,42,sstv)
        IF SENHX<>M_NOMEUSU
           NEGA(23)
           SETCOLOR(COR)
           LOOP
        ELSE
           SETCOLOR(COR)
        ENDIF
     ENDIF
     IF EMPTY(M_COR)
        @ LIN,42 GET M_COR PICT "@!"
        READ
     Endif
        Sele 32
        Veriout(setcolor(),23,"saida_outras")
        Go Top
        M_CORA =SETCOLOR()
        TELA100=SAVESCREEN(05,00,22,79)
        SETCOLOR(C_corg)
        PRIV VETOR1[1]
        VETOR1[1]='SAIDA_ITEM'
        SETCOLOR("n+/w")
        DBEDIT(lin,52,lin+10,64,VETOR1,,.T.,VETOR1)
        M_SAIDA = TRIM(SAIDA_ITEM)
        M_LJX   = LOJA
        RELEASE VETOR1
        RESTSCREEN(05,00,22,79,TELA100)
        SETCOLOR(M_CORA)
        Sele 32
	Use
	/*
        If M_LJX >0
           wStatus := Aut_Reserva(M_LJX)    // Funcoes.prg
           If wStatus = .f.
              Alert("Reserva N„o Permitida !")
              Sele 25
              Set Order to 1
              Loop
           Endif
        Endif
       */
       @ LIN,50 SAY M_SAIDA
       Sele 30
       Set Order to 1
       Seek M_Codx
       If Eof()
          Alert("Produto N„o Cadastrado. Atualize Tabela !")
       Endif

      CENTX  = CD_SALDO -(M_RES+CD_AVARIA+CD_AUTORIZ+CD_TRANSIT)

      Set color to b+/w
      m_passci = "n"
      Sele 57
      Set Order to 1
      Seek Str(m_codx,6,0)
      While !eof() .and. ci_codigo = m_codx
        If ci_datini <= m_datsi .and. ci_datlimi >= m_datsi
           m_passci = "s"
	   Exit
	Endif   
        Skip
      Enddo
      Stor 0 to m_Vrplano
      If m_passci = "s"                        && circcpd.dbf
         m_datcirc = ctod("  /  /    ")
         Stor 0 to m_numcirca,m_vrcirca,m_numcircp,m_vrcircp
         Set Filter to ci_codigo = m_codx .and. m_datsi >= ci_datini .and. m_datsi <= ci_datlimi
         Go Top
         If !Eof()
            ssor=savescreen(13,02,20,77)
            SETCOLOR(MENU)
            PRIV VETOR1[8],VETOR2[8]
            VETOR1[1]='CI_CODIGO'
  	  If ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
  	    VETOR1[2]= "CI_XAV"
	    VETOR1[3]= "CI_AVISTA"
          ElseIf m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 7 .or. m_tipo = 8
            VETOR1[2]='CI_XAV'
            VETOR1[3]='CI_AVISTA'
          Else 
            VETOR1[2]='CI_XAP'
            VETOR1[3]='CI_APRAZO'
          Endif 
            VETOR1[4]='CI_DATINI'
            VETOR1[5]='CI_DATLIMI'
            VETOR1[6]='CI_TIPO'
            VETOR1[7]='CI_AUTORIZ'
            VETOR1[8]='CI_MODALID'
            VETOR2[1]='Codigo'
	  If ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
	    VETOR2[2] = "(x)"
	    VETOR2[3] = "A Vista"
          ElseIf m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 7 .or. m_tipo = 8
            VETOR2[2]='(x)'
            VETOR2[3]='A Vista'
          Else 
            VETOR2[2]='(x)'
            VETOR2[3]='A Prazo'
          Endif 
            VETOR2[4]='Inicio da Promocao'
            VETOR2[5]='Limite da Promocao'
            VETOR2[6]='Tip Circular'
            VETOR2[7]='Nr Autoriz'
            VETOR2[8]='Modalidade'
            SETCOLOR("b+/w")
            @ 13,02 clear to 20,77
            @ 13,02 to 20,77 double
            DBEDIT(14,03,19,76,VETOR1,,.T.,VETOR2)
            RELEASE VETOR1,VETOR2
            restscreen(13,02,20,77,ssor)
            m_datcirc  = ci_datlimi
   	    If ci_modalid = "CC"
	       w_mod = "CC"
            Else	    
  	       w_mod = "  "
	    Endif
         If m_tipo = 5 .and. m_debcc = 1                 && Cartao Parcelado
            m_vezes     = ci_xap
   	    m_vzold     = ci_xap
         ElseIf ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
            m_vezes     = ci_xav
	    m_vzold     = ci_xav
         ElseIf m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 7 .or. m_tipo = 8
            m_vezes     = ci_xav
	    m_vzold     = ci_xav
         Else
            If (m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 4 .or. m_tipo = 5 .or. m_tipo = 6 .or. m_tipo = 8) .and. (m_plm = 2)
	       m_vezes     = ci_xap
	       m_vzold     = ci_xap
            Else
	       m_vezes     = ci_xap
	       m_vzold     = ci_xap
	    Endif
         Endif	
         If m_vezes     = 0
            m_vezes     = 1
 	    m_vzold     = 1
         Endif
         If m_datcirc < m_datsi
            Alert("Produto Fora da Promocao !")
         Else
         m_num_vda   = ci_xav
         m_vrcirca   = ci_avista
         m_num_vdp   = ci_xap
         m_vrcircp   = ci_aprazo
	 m_autor     = ci_autoriz
	 If ci_codigo <> m_codx
	    Alert("Codigo Errado !")
	    Loop
	 Endif
	 If m_vrcirca >0 .and. m_vrcircp >0
	    If m_tipo = 5 .and. m_debcc = 1       && Cartao Parcelado
	       M_VrPlano = m_vrcircp
            ElseIf ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 6 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
	       M_VrPlano = m_vrcirca      
 	    ElseIf m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 7 .or. m_tipo = 8
	       M_VrPlano = m_vrcirca
	    Else
	       M_VrPlano = m_vrcircp
	    Endif
         ElseIf m_vrcirca >0 .and. m_vrcircp <=0
	    If m_tipo = 5 .and. m_debcc = 1         && Cartao parcelado
	       M_VrPlano = m_vrcircp
            ElseIf ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
	      If m_vrcirca >0
	         M_VrPlano = m_vrcirca
	      Else 
	         M_VrPlano = m_vrcircp
	      Endif 
 	    ElseIf m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 7 .or. m_tipo = 8
	       M_VrPlano = m_vrcirca
	    Else     
	       M_VrPlano = 0
	    Endif     
         ElseIf m_vrcirca <=0 .and. m_vrcircp >0   
 	    If m_tipo <> 1
	       M_VrPlano = m_vrcircp
	    Else     
	       M_VrPlano = 0
	    Endif    
         ElseIf m_vrcirca = 0 .or. m_vrcircp = 0   
 	    If m_tipo <> 1
	       M_VrPlano = m_vrcircp
	    Else     
	       M_VrPlano = m_vrcirca
	    Endif    
	 Endif	 
        Endif	
       Endif 
       Set filter to
     Endif
     If m_autor >0     
        nResp:=0
        nResp:=Alert("Vai utilizar esta promocao ?", {"Sim ","N„o"})
        If nResp<>1 .Or. LASTKEY() = 27
           m_passci = "n"
           m_autor  = 0
        Endif
     Endif
     If w_mod <> "  "
        If (m_tipo = 2 .or. m_tipo = 3) .and. W_mod = "CC" 
           Alert("Modalide de Venda Difere da Circular !") 
           m_passci    = "n"
        Endif
     Endif
     If (W_Faixap >0 .and. M_MESES > 12) .and. (M_SBGRUPO=8 .or. M_SBGRUPO=304)
         W_faixap = 0   // Colchoes e cama box acima de 12 meses
     Endif
        *w_faixap = 0
        w_plano = 0
        Stor 0 to w_garant_12,w_garant_24,w_garant_36
        Sele 101
        If xy_cap_int = "CC" .and. M_Datsi >= ctod("01/07/2022")
           Veriout(SetColor(24),23,"faixaprtwgcp")
           Set Index to index_faixaprtwgcp
        Else
           Veriout(SetColor(24),23,"faixaprtwg")
           Set Index to index_faixaprtwg
        Endif
        Go Top
        Seek W_faixap
        While !Eof() .and. faixa = W_faixap
          If M_AVISTA >= DE .and. M_AVISTA <= ATE .and. plano = 12
             w_garant_12 = premio_tot
          Endif
          If M_AVISTA >= DE .and. M_AVISTA <= ATE .and. plano = 24
             w_garant_24 = premio_tot
          Endif
          If M_Datsi >= ctod("01/07/2022")
             If m_grupo <> 4 .and. m_grupo <> 6 .and. m_grupo <> 18 .and. m_grupo <> 19
                If M_AVISTA >= DE .and. M_AVISTA <= ATE .and. plano = 36 .and. M_MESES <= 12
                   w_garant_36 = premio_tot
                Endif
             Endif
          Endif
          Skip
        Enddo
        Use
        Sele 25
        Set Order to 1
        If w_faixap = 34 .AND. M_MESES >0 .and. w_faixap >0
           If w_garant_24 >0 .AND. M_MESES < 24
              Alert("Troca Garantida 24 Meses R$ "+str(w_garant_24,6,2)+", Troca Garantida 12 Meses R$ "+str(w_garant_12,6,2))
           Else
              w_garant_24 = 0
              Alert("Troca Garantida 12 Meses R$ "+str(w_garant_12,6,2))
           Endif
	Else
	   If w_garant_24 >0 .AND. M_MESES >0 .AND. M_MESES < 24 .and. w_faixap >0
	      Alert("Garantia 24 Meses R$ "+str(w_garant_24,6,2)+", Garantia 12 Meses R$ "+str(w_garant_12,6,2))
	   ElseIf M_MESES >0
	      w_garant_24 = 0
	      Alert("Garantia 12 Meses R$ "+str(w_garant_12,6,2))
	   Else
              Stor 0 to w_garant_24,w_garant_12,w_garant_36
	   Endif
	Endif

	Stor 0 to w_plav
        mfrt = Savescreen(18,04,24,77)
 	cor=setcolor()
	SETCOLOR("W+/BG+, B/RG,X")
        If w_faixap <> 34 .AND. M_MESES >0 .AND. M_MESES < 24 .and. w_faixap >0
           If w_garant_36 >0 .AND. M_MESES <= 12
              @ 18,14 clear to 20,77
              @ 18,14 to 20,77
              @ 19,15 prom "Plano (36)"
              @ 19,26 prom "Plano (24)"
              @ 19,37 prom "Plano (12)"
              @ 19,48 prom "Avulsa (av ou 3x)"
              @ 19,66 prom "S/Garantia"
	      Menu to m_grts
	      If m_grts = 4
                 @ 20,50 clear to 23,63
                 @ 20,50 to 23,63
                 @ 21,51 prom "Avulsa (24)"
                 @ 22,51 prom "Avulsa (12)"
	         Menu to m_grt_x
		 If m_grt_x = 1
		    w_plav   := w_garant_24
	            w_garant := 0
 	            w_plano  := 2
		 Else
		    w_plav   := w_garant_12
 	            w_garant := 0
 	            w_plano  := 1
		 Endif
		 Release m_grt_x
	      Endif
	      If m_grts = 1
	         w_garant := w_garant_36
                 w_plano  := 3
	      ElseIf m_grts = 2
	         w_garant := w_garant_24
                 w_plano  := 2
	      ElseIf m_grts = 3
	         w_garant := w_garant_12
                 w_plano  := 1
              Endif
	   ElseIf w_garant_24 >0
              @ 18,14 clear to 20,76
              @ 18,14 to 20,76
              @ 19,15 prom "C/Garantia(24)" 
              @ 19,31 prom "C/Garantia(12)" 
              @ 19,47 prom "Avulsa (av ou 3x)"
	      @ 19,66 prom "S/Garantia" 
	      Menu to m_grts
	      If m_grts = 3
                 @ 20,50 clear to 23,63
                 @ 20,50 to 23,63
                 @ 21,51 prom "Avulsa (24)" 
                 @ 22,51 prom "Avulsa (12)" 
	         Menu to m_grt_x
		 If m_grt_x = 1
		    w_plav   := w_garant_24
	            w_garant := 0
 	            w_plano  := 2
		 Else
		    w_plav   := w_garant_12
 	            w_garant := 0
 	            w_plano  := 1
		 Endif
		 Release m_grt_x
	      Endif
	      If m_grts = 1
	         w_garant := w_garant_24
                 w_plano  := 2
	      ElseIf m_grts = 2
	         w_garant := w_garant_12
                 w_plano  := 1
	      ElseIf m_grts = 4
  	         w_garan  := 0
 	         w_plano  := 0
	      Endif
           ElseIf M_MESES >0
              @ 18,20 clear to 20,68
              @ 18,20 to 20,68
              @ 19,21 prom "C/Garantia(12)" 
              @ 19,37 prom "Avulsa (av ou 3x)"
	      @ 19,56 prom "S/Garantia" 
   	      Menu to m_grts
	      If m_grts = 1
	         w_garant := w_garant_12
                 w_plano  := 1
	      ElseIf m_grts = 2
   	         w_plav   := w_garant_12
 	         w_garant := 0
 	         w_plano  := 1
	      ElseIf m_grts = 3
  	         w_garant := 0
 	         w_plano  := 0
	      Endif
	   Endif
        Else                                         // Troca Garantida
	   If w_garant_24 >0 .and. M_MESES >0 .and. M_MESES < 24 .and. w_faixap >0
              @ 18,04 clear to 20,76
              @ 18,04 to 20,76
              @ 19,05 prom "Troca Garantida(24)" 
              @ 19,26 prom "Troca Garantida(12)" 
              @ 19,47 prom "Avulsa (av ou 3x)"
	      @ 19,66 prom "S/Garantia" 
   	      Menu to m_grts
	      If m_grts = 3
                 @ 20,50 clear to 23,63
                 @ 20,50 to 23,63
                 @ 21,51 prom "Avulsa (24)" 
                 @ 22,51 prom "Avulsa (12)" 
	         Menu to m_grt_x
		 If m_grt_x = 1
		    w_plav   := w_garant_24
	            w_garant := 0
 	            w_plano  := 2
		 Else
		    w_plav   := w_garant_12
 	            w_garant := 0
 	            w_plano  := 1
		 Endif
		 Release m_grt_x
	      Endif
	      If m_grts = 1
	         w_garant := w_garant_24
                 w_plano  := 2
	      ElseIf m_grts = 2
	         w_garant := w_garant_12
                 w_plano  := 1
	      ElseIf m_grts = 4
  	         w_garant := 0
 	         w_plano  := 0
	      Endif
           ElseIf M_MESES >0
              @ 18,10 clear to 20,63
              @ 18,10 to 20,63
              @ 19,11 prom "Troca Garantida(12)" 
              @ 19,32 prom "Avulsa (av ou 3x)"
	      @ 19,51 prom "S/Garantia" 
   	      Menu to m_grts
	      If m_grts = 1
	         w_garant := w_garant_12
                 w_plano  := 1
	      ElseIf m_grts = 2
    	         w_plav   := w_garant_12
 	         w_garant := 0
 	         w_plano  := 1
	      ElseIf m_grts = 3
  	         w_garant := 0
 	         w_plano  := 0
	      Endif
	   Endif
        Endif

        Restscreen(18,20,20,72,mfrt)
        Release w_faixap,mfrt,m_grts

     If ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
        If m_debcc = 2 
           m_vezes = 1
           m_vzold     = 1
        ElseIf m_debcc = 3 
           m_vezes = 1
           m_vzold     = 1
        ElseIf m_debcc = 4
           m_vezes = 2
           m_vzold     = 2
        ElseIf m_debcc = 5
           m_vezes = 3
           m_vzold     = 3
        ElseIf m_debcc = 7
           m_vezes = 5
           m_vzold     = 5
        Endif	
     Endif	
     If nResp = 1 .and. m_tipo = 5 .and. (m_debcc = 6 .or. m_debcc = 7)     && 5x s juros ate dezembro
        m_passci = "n"
	m_autor  = 0
     Endif

     Sele 3
     Set Order to 1
     M_Avista = cd_avista2
     M_Venda  = cd_avista2
     M_PRAUX  = cd_avista2
     M_PRECO  = cd_avista2
     
     If m_passci = "n"
        M_PRE     = cd_avista2
	m_vrplano = 0
     Else
        M_PRE   = m_vrplano
        M_Venda = m_vrplano
     Endif
     Release mfrt
     M_PRCP=M_PRE
     If m_passci = "n"
        If m_tipo = 1  .or. m_tipo = 4 .or. m_tipo = 7 .or. m_tipo = 8  && Financ
           @ LIN,58 SAY STRZERO(M_VEZES,2)
        Else
	  If (m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 5 .or. m_tipo = 6) .and. (m_plm = 2)
             @ LIN,58 SAY STRZERO(M_VEZES,2)
          ElseIf ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
	     @ LIN,58 SAY STRZERO(M_VEZES,2)
	  Else
	     @ LIN,58 GET M_VEZES PICT "99" VALID M_VEZES >0 .AND. M_VEZES <= 24
	  Endif
	  Read
        Endif
        If m_tipo > 1 .and. m_tipo <> 4 .and. m_tipo <> 8
           If m_vezes <= 0 .or. Lastkey() = 27
              Alert("Informa a quantidade de parcelas deste produto !")
	      Loop
           Endif
        Endif
     Else                       // Na Circular Promocional
        @ LIN,58 GET M_VEZES PICT "99" Valid m_vezes <= m_vzold
        Read
        If M_VEZES > M_VZOLD
           Alert("Recusado. Nr de Parcelas Maior que na Promocao !")
  	   Return
        Endif
     Endif  
     If m_tipo = 5 .and. m_debcc = 1 .and. m_vezes < 6
        Alert("Escolha a Modalidade Correta. Cartao "+Strzero(m_vezes,1)+" x s/Juros")
	Loop
     Endif
     If xy_cap_int <> "CC"	  //  Filiais do Interior 
        If m_tipo = 1            && A Vista
           m_tx_cc    = 0
  	   m_vezes= 1
        ElseIf m_tipo = 2        && C/Cheque
           m_tx_cc = I_TXCHEQUE
        ElseIf m_tipo = 3        && C/Carne
           m_tx_cc = I_TXCARNE
	   If m_vezes > 3
              m_venda = m_venda + w_garant   // Composicao do pr de partida
	   Endif      
        ElseIf m_tipo = 4        && C/Financeira
           m_tx_cc    = 0
  	   m_vezes= 1
        ElseIf m_tipo = 6 .or.  m_tipo = 8        && Convenio
           m_tx_cc    = 0
	   m_vezes= 1
*          m_tx_cc = I_TXCONVEN
        ElseIf m_tipo = 5        && Cartao de Credito
          m_tx_cc = 0
          If m_debcc = 2 
	     m_vezes= 1
          ElseIf m_debcc = 3
	     m_vezes= 1
          ElseIf m_debcc = 4
	     m_vezes= 2
          ElseIf m_debcc = 5
             m_vezes= 3
          ElseIf m_debcc = 7
             m_vezes= 5
          Else
             If m_grupo = 1 .or. m_grupo = 2 .or. m_grupo = 3 .or. m_grupo = 6 .or. m_grupo = 9 .or. m_grupo = 15 .or. m_grupo = 16 .or. m_grupo = 17 .or. m_grupo = 18 .or. m_grupo = 19
                m_tx_cc = I_TXELEINT          // Taxa de eletro p/ interior (cartao)
             ElseIf m_grupo = 8       
                m_tx_cc = I_TXCELCC           // Taxa de celulares p/ interior (cartao)
             ElseIf m_grupo = 7 .or. m_grupo = 11
                m_tx_cc = I_TXINFCCI          // Taxa de informtica p/ interior (cartao)
             ElseIf m_grupo = 4
                m_tx_cc = I_TXMOVINT          // Taxa de moveis p/ interior (cartao)
             ElseIf m_grupo = 5
                m_tx_cc = I_TXMOTOS           // Taxa de motos
             Endif
          Endif	
      Endif
    Else                // Filiais da Capital
      m_venda = m_venda + m_txab + m_frt + m_mon    // Composicao do pr de partida
      If m_tipo = 1            && A Vista
         m_tx_cc = 0
	 m_vezes= 1
      ElseIf m_tipo = 2        && C/Cheque
         m_tx_cc = I_TXCHEQUE
      ElseIf m_tipo = 3        && C/Carne
         m_tx_cc = I_TXCARNE
         If m_vezes > 3
            m_venda = m_venda + w_garant            // Composicao do pr de partida
	 Endif    
      ElseIf m_tipo = 4        && C/Financeira
         m_tx_cc    = 0
	 m_vezes= 1
	 m_venda = m_venda + m_txab + w_garant
      ElseIf m_tipo = 6 .or. m_tipo = 8      && Convenio
         m_tx_cc    = 0
	 m_vezes= 1
      ElseIf m_tipo = 5                      && Cartao de Credito
	   m_tx_cc = 0
        If m_debcc = 2
	   m_vezes= 1
        ElseIf m_debcc = 3
	   m_vezes= 1
        ElseIf m_debcc = 4
	   m_vezes= 2
        ElseIf m_debcc = 5
	   m_vezes= 3
        ElseIf m_debcc = 6
	   m_vezes= 5
	Else    
          If m_grupo = 1 .or. m_grupo = 2 .or. m_grupo = 3 .or. m_grupo = 6 .or. m_grupo = 9 .or. m_grupo = 15 .or. m_grupo = 16 .or. m_grupo = 17 .or. m_grupo = 18 .or. m_grupo = 19
             m_tx_cc = I_TXELECAP          // Taxa de eletro p/ interior (cartao)
          ElseIf m_grupo = 8       
             m_tx_cc = I_TXCELCC           // Taxa de celulares p/ Capital e Interior (cartao)
          ElseIf m_grupo = 7 .or. m_grupo = 11
             m_tx_cc = I_TXINFCCC          // Taxa de informtica p/ capital (cartao)
          ElseIf m_grupo = 4
             m_tx_cc = I_TXMOVCAP          // Taxa de moveis p/ capital (cartao)
          ElseIf m_grupo = 5
             m_tx_cc = I_TXMOTOS           // Taxa de motos
          Endif
        Endif	 
      Endif
     Endif

     wValor = M_VrPlano
*aki
     If m_passci = "n"
        WValor = Str(Parc_Fin(m_venda,m_tx_cc,m_vezes,.f.),10,2)
        M_PRE = round((Val(WValor) * m_vezes),1)
         if xy_cap_int = "CC"	  
   	    M_PRE = (M_PRE - (m_txab + m_frt + m_mon))   // Composicao do pr de partida
         Endif
         WValor = M_PRE
     Endif
     M_GRFATOR = 0
     If w_garant > 0 
        W_gr1 = Str(Parc_Fin(w_garant,m_tx_cc,m_vezes,.f.),10,2)
        M_GRFATOR = round((Val(W_gr1) * m_vezes),1)
        Release w_gr1
     Endif
     If (m_tipo = 2 .or. m_tipo = 3) .and. (m_vezes <=3)
        M_PRE = M_PRE + w_garant                             // Composicao do pr de partida
     Endif

     T_garant = T_garant + M_GRFATOR

     M_PRCP = M_PRE
     If m_plm = 1 
        m_num1 = m_vezes
     Endif 
     If m_passci = "n"
        @ LIN,61 GET M_PRE PICT "99,999.99" 
        Read
     Else
        WValor = M_PRE
        @ LIN,61 SAY M_PRE PICT "99,999.99"
     Endif
     Read
     If m_autor = 0 .and. M_PRE < M_PRCP .and. m_tipo = 5 .and. m_vezes >1
	Alert("Pre‡o N„o Permitido !")
	Release w_unit
	Loop
     Endif

     nResp:=0
     nResp:=Alert( " Venda de Produtos", {"Confirma ","Retorna "})
     If nResp<>1 .Or. LASTKEY() = 27
        Loop
     Endif
     @ LIN,60 SAY M_PRE PICT "99,999.99"
   *************************************VER ACRESCIMO OU DESCONTO***********
      IF M_TIPO = 2 .OR. M_TIPO = 3 .OR. M_TIPO = 6
         IF M_PRE<M_VENDA 
            M_DE=M_VENDA-M_PRE    && M_DE = DESCONTOS
            M_LT="D" 
         ELSEIF M_PRE>M_VENDA 
            M_AC=M_PRE-M_VENDA   && M_AC = ACRESCIMO
            M_LT="A" 
         ELSE
            M_LT="-"
         ENDIF
      ELSEIF M_PRE<M_AVISTA
            M_DE=M_AVISTA - M_PRE
            M_LT="D" 
      ELSEIF M_PRE>M_AVISTA
            M_AC=M_PRE-M_AVISTA
            M_LT="A" 
      ELSE
            M_LT="-"
      ENDIF

      M_TOTD =M_TOTD+M_DE
      M_TOTAC=M_TOTAC+M_AC

      IF CD_PROMO<M_DATA
         IF M_TIPO = 2 .OR. M_TIPO = 3 .OR. M_TIPO = 6
            IF M_PRE<M_VENDA 
               M_DESC=M_PRE
            ENDIF
         ENDIF
      ELSEIF CD_PROMO>=M_DATA
         IF M_TIPO = 2 .OR. M_TIPO = 3 .OR. M_TIPO = 6
            IF M_PRE<M_PRECO
               M_DESC=M_PRE
            ENDIF
         ENDIF
      ENDIF
     IF M_PRE<>M_PRCP
      IF M_PRE<M_PRECO
         SN=SAVESCREEN(19,20,20,50)
         M_PE=(M_PRE/M_PRECO)
         M_PE=M_PE*100
         M_PE=100-M_PE
         M_DESC=M_PE
         @ 19,23 SAY "Menor que a Tabela      %"
         @ 19,41 SAY M_PE PICT "999.99"
         nResp:=0
         nResp:=Alert( "Pre‡o N„o Permitido", {"Libera ","Cancela "})
        RESTSCREEN(19,20,20,50,SN)
        Cor=SetColor()
        IF nResp <> 1
           NEGA(23)
           SETCOLOR(COR)
           LOOP
        ENDIF
        SETCOLOR(COR)
      IF CD_PROMO>=M_DATA
         IF M_TIPO<>4 .AND. M_TIPO<>2 .AND. M_PRE<M_PRAUX
            M_AUTO=0
            SETCOLOR(C_CORG)
            AUT=SAVESCREEN(12,13,16,42)
            SOMBRA(12,13,15,40,BOX)
            SETCOLOR("W+/B")
            @ 13,14 SAY 'Vr.Abaixo da Promo‡„o' 
            SETCOLOR("BG+/B")
            @ 14,14 SAY 'Consulte Gerente'
            Inkey(0)
            RESTSCREEN(12,13,16,42,AUT)
            SETCOLOR(COR)   
          ENDIF    
        ELSEIF M_TIPO=4 .AND. M_PRE<M_PRAUX
           M_AUTO=0
           SETCOLOR(C_CORG)
           AUT=SAVESCREEN(12,13,16,42)
           SOMBRA(12,13,15,40,BOX)
           SETCOLOR("W+/B")
           @ 13,14 SAY 'Vr.Abaixo da Promo‡„o' 
           SETCOLOR("BG+/B")
           @ 14,14 SAY 'Consulte Gerente'
           Inkey(0)
           RESTSCREEN(12,13,16,42,AUT)
           SETCOLOR(COR)   
        ENDIF    
       ENDIF
      ENDIF
      IF CD_PROMO<M_DATA
         IF M_GRUPO<>4 .AND. M_PE >20     && 17 E' A PERCENT.ESTOURADA  P/ELETRO
            M_AUTO=0
            SETCOLOR(C_CORG)
            AUT=SAVESCREEN(12,13,16,42)
            SOMBRA(12,13,15,40,BOX)
            SETCOLOR("W+/B")
            @ 13,14 SAY 'Valor Abaixo da Tabela' 
            SETCOLOR("BG+/B")
            @ 14,14 SAY 'Consulte Gerente'
            Inkey(0)
            RESTSCREEN(12,13,16,42,AUT)
            SETCOLOR(COR)   
        ELSEIF M_GRUPO=4 .AND. M_PE >23   && 22 E' A PERC. ESTOURADA P/MOVEIS
            M_AUTO=0
            SETCOLOR(C_CORG)
            AUT=SAVESCREEN(12,13,16,42)
            SOMBRA(12,13,15,40,BOX)
            SETCOLOR("W+/B")
            @ 13,14 SAY 'Valor Abaixo da Tabela' 
            SETCOLOR("BG+/B")
            @ 14,14 SAY 'Consulte Gerente'
            Inkey(0)
            RESTSCREEN(12,13,16,42,AUT)
            SETCOLOR(COR)   
        ENDIF    
       ENDIF  
         M_STO   = M_PRE * M_QUANT
         M_GRTO  = M_GRTO + M_STO
         M_TOTA  = M_GRTO
	 @ LIN,70 SAY M_STO PICT "@E 99,999.99"

         @ 20,60  SAY M_TOTAC-M_TOTD PICT "@E 9,999.99"
         @ 20,69  SAY M_GRTO  PICT "@E 999,999.99"

	 If (m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 5 .or. m_tipo = 8) .and. (T_Garant >0)
            Cor=Setcolor()
            Setcolor("GR+/B")
            @ 21,59 SAY "Garantia Est"
            Cor=Setcolor(Cor)
            @ 21,69 SAY T_Garant          PICT "@E 999,999.99"
            @ 22,69 SAY M_GRTO + T_Garant PICT "@E 999,999.99"
         Endif
         
         SET KEY -9 TO TOTSAI
         SET KEY -7 TO EDIYTOR()

         LIN = LIN + 1
         IF M_TOTS="S"
            CONTINUA="S"
            EXIT
         ENDIF
         IF LIN > 17
            TOTSAI()
         ENDIF

         Sele 25
         Set order to 1
         nResp:=0
         nResp:=Alert( "Confirma Inclus„o do Item ? ", {"Sim ","N„o "})
     If nResp=1
        If Adireg(0)    
           Repl CD_CODIOR WITH M_NOTA,CD_DATAO WITH M_DATAO,CD_CODICL WITH M_CLIE,CD_NOMECL WITH M_NOME,CD_NUM1 WITH M_VEZES, ;
                CD_QUANT WITH M_Quant,CD_CODI WITH M_CODX,CD_PROD WITH M_PRD,CD_UNIT WITH M_PRE,CD_VEZES WITH M_VEZES, ;
  	        CD_VENDED WITH V_NOME,CD_CODVEN WITH M_VEND,cd_tipov with m_tipo,cd_cor with m_cor,cd_saida with m_saida, ;
                CD_ENDE WITH ENDEX,CD_FONE WITH FON1X,CD_CPF WITH CPFX,CD_BAIR WITH M_BAICL,CD_OBSER WITH M_OBSER, ;
                CD_CEP WITH M_CEPCL,CD_CIDA WITH M_CIDACL,CD_UF WITH M_UFCL,CD_REFER WITH M_REFER,CD_CGC WITH CGCX,CD_REFER2 WITH M_REFER2, ;
	        CD_RG WITH M_RG,CD_IMEI WITH M_IMEI,CD_CEL WITH M_CEL, ;
	        CD_AUTOR WITH M_AUTOR,CD_VRCIRC WITH M_VRPLANO,CD_FATORGR WITH M_GRFATOR, ;
		CD_Plano with w_plano,cd_status with "O"
		If w_plano > 0
		   Repl cd_vrgr with w_garant,cd_gr with "S",cd_dtgr with m_datsi
                Else
		   Repl cd_vrgr with 0,cd_gr with "N"
		Endif
  	        
		If w_plav >0              // Venda com Garantia Avulsa
 	           Repl cd_status with "A",cd_vrgr with w_plav,cd_plano with w_plano
                Endif
	        Release w_plav

	        Comm
   	        Unlock
	        If !Empty(cd_imei) .and. Len(cd_imei) = 15
                   w_PROD = TRIM(CD_PROD)
                   z:=At("TRIANG",w_PROD)
                   If z != 0
	              w_triang = "S" 
                   Endif
	        Endif   
      EndIf	
        M_Alt="S"
     Endif      
     Release M_GRFATOR
     nResp:=0
     nResp:=Alert( "Inclui Outro Item ? ", {"Sim ","N„o "})
     If nResp= 2
        Release w_mod
        Exit
     EndIf      
     SKIP
   ENDDO

    IF M_TIPO = 4
       SOMBRA(11,05,13,31,BOX)
       @ 12,06 SAY 'VALOR ENTRADA 'Get M_VRFIN PICT "@E 999,999.99"
       READ
    ENDIF
    M_VRCAR = 0
    IF M_TIPO = 5
       SOMBRA(11,05,13,31,BOX)
       @ 12,06 SAY 'VALOR ENTRADA 'Get M_VRCAR PICT "@E 999,999.99"
       READ
    ENDIF
    Sele 25
    Set Order to 1
    Seek Str(m_nota,8,0)
    While !eof() .and. cd_codior = m_nota .and. cd_datao = m_datao
     If BloqReg(0)
        Repl cd_vrcar with m_vrcar,cd_vrfin with m_vrfin,cd_entra with m_vrcar
     EndIf
     Skip
    Enddo
    Unlock

    Stor 0 to S_Dia
    IF M_TIPO = 2 .OR. M_TIPO = 3 .OR. M_TIPO = 6 .and. M_Alt = "S"
      M_Nott=M_tota
      SETCOLOR("B+/W")
      @ 14,01 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
      @ 15,01 say "³ T.Compra   Entrada  Financiado N§Prest  Vr.Prest         Vencimentos       ³"
      @ 16,01 say "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
      @ 17,01 say "³                                  (  )            Dˆ            A           ³"
      @ 18,01 say "³                                  (  )            Dˆ            A           ³"
      @ 19,01 say "³                                  (  )            Dˆ            A           ³"
      @ 20,01 say "³                                  (  )            Dˆ            A           ³"
      @ 21,01 say "³TOTAL.................................                                      ³"
      @ 22,01 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
      @ 18,02 SAY M_NOTT   PICT "@E 999,999.99"
      @ 18,12 GET M_ENTRAD PICT "@E 99,999.99"
      READ
      IF LASTKEY()=27
         LOOP
      ENDIF
      M_VRP1=M_ENTRAD
      @ 18,23 SAY M_NOTT-M_ENTRAD PICT "@E 999,999.99"
      @ 17,37 GET M_NUM1 PICT "99" VALID M_NUM1 >0 .AND. M_NUM1<21
      READ
      M_VRP1=(M_NOTT-M_ENTRAD) / M_NUM1
      @ 17,41 GET M_VRP1 PICT "@E 999,999.99"

      M_DATT = M_ULTIMA
      S_DIA := SOMADD(M_DATT)
      M_DTA1 = M_ULTIMA+S_DIA
      M_DIA1 = DTOC(M_DTA1)
      M_DAT1 = M_DTA1

      @ 17,55 GET M_DTA1 VALID M_DTA1 >=M_DATAO

      If M_NUM1=1
         M_DATT=M_ULTIMA
         S_DIA :=SOMADD(M_DATT)
         M_DATX = M_ULTIMA+S_DIA
         M_DAT1 = M_DATX
      Endif
      wNum="1"
      For i = 2 to m_num1
         wNum  = Alltrim(str(i))
         wNumx = Alltrim(str(i-1))
         S_Dia := SOMADD(M_DAT&wNumx)
         M_DAT&wNum = M_DAT&wNumx+s_dia
      Next
      M_DATX = M_Dat&wNum

      @ 17,68 GET M_DATX VALID M_DATX >=M_DATAO
      @ 18,37 GET M_NUM2 PICT "99"
      @ 18,41 GET M_VRP2 PICT "@E 999,999.99"
      @ 18,55 GET M_DTA3
      @ 18,68 GET M_DTA4
      @ 19,37 GET M_NUM3 PICT "99"
      @ 19,41 GET M_VRP3 PICT "@E 999,999.99"
      @ 19,55 GET M_DTA5
      @ 19,68 GET M_DTA6
      @ 20,37 GET M_NUM4 PICT "99"
      @ 20,41 GET M_VRP4 PICT "@E 999,999.99"
      @ 20,55 GET M_DTA7
      @ 20,68 GET M_DTA8
      READ
      M_NUM  = M_NUM1+M_NUM2+M_NUM3+M_NUM4
      M_TOTT = (M_VRP1*M_NUM1)+(M_VRP2*M_NUM2)+(M_VRP3*M_NUM3)+(M_VRP4*M_NUM4)+M_ENTRAD
      @ 21,41 SAY M_TOTT PICT "@E 999,999.99"
      IF STR(M_TOTT,10,2) >STR(M_NOTT,10,2) .OR. STR(M_TOTT,10,2) < STR(M_NOTT,10,2)
         nResp:=0
         nResp:=Alert("Plano N„o Confere. Abandona Or‡amento ?", {"Sim ","N„o "})
         If nResp=2
           LOOP
         ELSE
           CONTINUA = "N"
           M_TOTS   = "N"
           M_AJUST  = "S"
           EXIT
         ENDIF
      ENDIF
    Sele 25
    Set Order to 1
    Seek Str(m_nota,8,0)
  While !eof() .and. cd_codior = m_nota .and. cd_datao = m_datao
    If bloqreg(0)
      Repl CD_NUMPRE WITH M_NUM,CD_ENTRA WITH M_ENTRAD,CD_NUM1 WITH M_NUM1,CD_NUM2 WITH M_NUM2,CD_NUM3 WITH M_NUM3,CD_NUM4 WITH M_NUM4, ;
           CD_VRPARC1 WITH M_VRP1,CD_VRPARC2 WITH M_VRP2,CD_VRPARC3 WITH M_VRP3,CD_VRPARC4 WITH M_VRP4,CD_DTA1 WITH M_DTA1,CD_DTA2 WITH M_DATX, ;
           CD_DTA3 WITH M_DTA3,CD_DTA4 WITH M_DTA4,CD_DTA5 WITH M_DTA5,CD_DTA6 WITH M_DTA6,CD_DTA7 WITH M_DTA7,CD_DTA8 WITH M_DTA8
    EndIf
    UNLOCK
    Skip
  EndDo
    Clear Gets
    Release M_DATAO,M_ULTIMA,M_CODI,M_TIPO,M_COR,M_UNIT,M_QUANT,M_ENTRAD,M_VRP1
    Release M_VRP2,M_VRP3,M_VRP4,M_NUM1,M_NUM2,M_NUM3,M_NUM4,M_DTA1,M_DTA2,M_DTA3
    Release M_DTA4,M_DTA5,M_DTA6,M_DTA7,M_DTA8,M_VRFIN,M_VRCAR,M_CLIE,M_NOME,ENDEX 
    Release FON1X,CGCX,CPFX,M_BAICL,M_CEPCL,M_CIDACL,M_UFCL,M_REFER,M_REFER2,M_OBSER
    Release M_SAIDA,M_RG,M_RESERV,M_TXE,M_TXM,M_IMEI,M_CEL,M_VEZES,M_AUTOR,M_PLM,M_VRPLANO
    RestScreen(06,00,20,80,ssb)
  EndIf
  Return
Enddo

//**********************
  Procedure Altera_Plano                  && // Alterando Plano de Pagamento
//**********************
 Sele 48
 Veriout(SetColor(),23,"empresa")
 I_DIAS_M   = ENTR_MOV    // Dias da 1a. Entrada (Moveis)
 I_DIAS_E   = ENTR_ELE    // Dias da 1a. Entrada (Eletro)
 I_TXE      = TXE         // Taxa de Entrega ( Frete )
 I_TXM      = TXM         // Taxa de Montagem
 I_TAC      = TAC         // Tac ( TC Finanaceira )
 I_TXELECAP = TX_ELE_CAP  // Taxa de eletro cartao p/ capital
 I_TXELEINT = TX_ELE_INT  // Taxa de eletro cartao p/ interior
 I_TXMOVCAP = TX_MOV_CAP  // Taxa de moveis cartao p/ capital
 I_TXMOVINT = TX_MOV_INT  // Taxa de moveis cartao p/ interior
 I_TXCELCAR = TX_CEL_CAR  // Taxa de celulares cartao p/ carne
 I_TXCELCC  = TX_CEL_CC   // Taxa de celulares cartao p/ cartao
 I_TXINFCAR = TX_INF_CAR  // Taxa de informatica p/ carne
 I_TXINFCCC = TX_INF_CCC  // Taxa de informatica cartao p/ capital
 I_TXINFCCI = TX_INF_CCI  // Taxa de informatica cartao p/ interior
 I_TXCARNE  = TX_CARNE    // Taxa p/ vendas com carne
 I_TXCHEQUE = TX_CHEQUE   // Taxa p/ vendas com cheque
 I_TXFINANC = TX_FINANC   // Taxa p/ vendas com financeira
 I_TXCONVEN = TX_CONVEN   // Taxa p/ vendas convenio
 I_TXMOTOS  = TX_MOTOS    // Taxa para motos
 I_DESCAVEL = DESC_AV_EL  // Descontos p/ Vda A Vista p/ eletros
 I_DESCAVMO = DESC_AV_MO  // Descontos p/ Vda A Vista p/ moveis
 I_FT_01L   = FT_01L      // FATORES LOSANGO C/ IOF
 I_FT_02L   = FT_02L
 I_FT_03L   = FT_03L
 I_FT_04L   = FT_04L
 I_FT_05L   = FT_05L
 I_FT_06L   = FT_06L
 I_FT_07L   = FT_07L
 I_FT_08L   = FT_08L
 I_FT_09L   = FT_09L
 I_FT_10L   = FT_10L
 I_FT_11L   = FT_11L
 I_FT_12L   = FT_12L
 I_FT_15L   = FT_15L
 I_FT_18L   = FT_18L
 I_FT_24L   = FT_24L
 I_DCELECAP = DC_ELE_CAP  // Desc de eletro cartao p/ capital
 I_DCELEINT = DC_ELE_INT  // Desc de eletro cartao p/ interior
 I_DCMOVCAP = DC_MOV_CAP  // Desc de moveis cartao p/ capital
 I_DCMOVINT = DC_MOV_INT  // Desc de moveis cartao p/ interior
 I_DCCELCAR = DC_CEL_CAR  // Desc de celulares cartao p/ carne
 I_DCCELCC  = DC_CEL_CC   // Desc de celulares cartao p/ cartao
 I_DCINFCAR = DC_INF_CAR  // Desc de informatica p/ carne
 I_DCINFCCC = DC_INF_CCC  // Desc de informatica cartao p/ capital
 I_DCINFCCI = DC_INF_CCI  // Desc de informatica cartao p/ interior
 I_DCCARNE  = DC_CARNE    // Desc p/ vendas com carne
 I_DCCHEQUE = DC_CHEQUE   // Desc p/ vendas com cheque
 Use
 Sele 25
 Set Order to 1
 While .t.

   w_mod      = "  "
   W_Mudou_Pl = "N"
   W_Tipo     = M_TIPO

   CORX=SETCOLOR()
   M_TT=SAVESCREEN(09,14,22,75)
   SETCOLOR("RG/B")
   @ 10,14 CLEAR TO 18,46
   SETCOLOR("G+/R+")
   SOMBRA(10,15,17,42,BOX)
   COR=SETCOLOR()
   @ 10,23 SAY "Tipo Venda"
   SETCOLOR(COR)
   @ 12,18 PROM "1) A VISTA (DINH/CHEQ) "
   @ 13,18 PROM "2) C/CHEQUE PRE-DATADO "
   @ 14,18 PROM "3) A PRAZO NO CARNET   "
   @ 15,18 PROM "4) PROMOTORA           "
   @ 16,18 PROM "5) CARTAO CREDITO      "
   MENU TO M_TIPO
   If Lastkey() = 27
      RESTSCREEN(09,14,22,75,m_tt)
      Return(1)
   Endif
   If W_Tipo <> M_TIPO
      W_Mudou_Pl = "S"
      If xy_cap_int = "CC"
         If m_tipo = 3 .or. m_tipo = 6
            If Loja <> 55
               Alert("Modalidade de Vendas N„o Autorizada !")
               Return(1)
            Endif
         Endif
      Endif
   Endif
   If m_tipo = 5
      If xy_cap_int = "CC"
         @ 12,51 clear to 20,75
         @ 12,51 to 20,75 double
         @ 13,52 prom "Credito (Parc acima 3x)"
         @ 14,52 prom "Debito em Conta        "
         @ 15,52 prom "1 x S/ Juros           "
         @ 16,52 prom "2 x S/ Juros           "
         @ 17,52 prom "3 x S/ Juros           "
         @ 18,52 prom "1+4 S/ Juros           "
         @ 19,52 prom "5 x S/ Juros           "
         Menu to m_debcc
      Else                       // Diferente p o interior CC em 5 x sem juros
         @ 12,51 clear to 19,75
         @ 12,51 to 19,75 double
         @ 13,52 prom "Credito (Parc acima 3x)"
         @ 14,52 prom "Debito em Conta        "
         @ 15,52 prom "1 x S/ Juros           "
         @ 16,52 prom "2 x S/ Juros           "
         @ 17,52 prom "3 x S/ Juros           "
         @ 18,52 prom "1+4 S/ Juros           "
         Menu to m_debcc
      Endif
   Endif
   RESTSCREEN(09,14,22,75,m_tt)
   If Lastkey() = 27
      RESTSCREEN(09,14,22,75,m_tt)
      Return(1)
   Endif
   Lin = 9
   Stor 0 to m_tota,T_garant
   Cor=SetColor()
   M_Alt = "N"
   SSB=savescreen(06,00,22,80)
   @ 06,00 clear to 19,79
   @ 06,00 to 19,79
   SetColor(C_Corg)
   @ 07,01 Say "Quant C¢digo Descri‡„o da Mercadoria     Cor     Saida   (X) Unit R$   Total $"
   SetColor(Cor)
   @ 08,01 to 08,78
   While !Eof() .AND. CD_CODIOR = M_NOTA .AND. CD_DATAO = M_DATAO
      M_ULTIMA  = CD_DATAO
      M_CODX    = CD_CODI
      M_COR     = CD_COR
      M_UNIT    = CD_UNIT
      M_QUANT   = CD_QUANT
      M_ENTRAD  = CD_ENTRA
      M_VRP1    = CD_VRPARC1
      M_VRP2    = CD_VRPARC2
      M_VRP3    = CD_VRPARC3
      M_VRP4    = CD_VRPARC4
      M_NUM1    = CD_NUM1
      M_NUM2    = CD_NUM2
      M_NUM3    = CD_NUM3
      M_NUM4    = CD_NUM4
      M_DTA1    = CD_DTA1
      M_DTA2    = CD_DTA2
      M_DTA3    = CD_DTA3
      M_DTA4    = CD_DTA4
      M_DTA5    = CD_DTA5
      M_DTA6    = CD_DTA6
      M_DTA7    = CD_DTA7
      M_DTA8    = CD_DTA8
      M_VRFIN   = CD_VRFIN
      M_VRCAR   = CD_VRCAR
      M_CLIE    = CD_CODICL
      M_NOME    = CD_NOMECL
      ENDEX     = CD_ENDE
      FON1X     = CD_FONE
      CGCX      = CD_CGC
      CPFX      = CD_CPF
      M_BAICL   = CD_BAIR
      M_CEPCL   = CD_CEP
      M_CIDACL  = CD_CIDA
      M_UFCL    = CD_UF
      M_REFER   = CD_REFER
      M_REFER2  = CD_REFER2
      M_OBSER   = CD_OBSER
      M_SAIDA   = CD_SAIDA
      M_RG      = CD_RG
      M_VEZES   = CD_VEZES
      M_PERCENTR= CD_VALOR
      M_VRENTR  = CD_ENTRA
      M_FRT     = CD_TXE
      M_MON     = CD_TXM
      M_PLM     = CD_VEZES
      M_GR      = CD_GR
      M_PLANO   = CD_PLANO
      M_RESERV  = CD_RESERV
      M_TXAB    = 0

      If CD_ENTRA >0
         M_PLM = 2
      Else
         M_PLM = 1
      Endif

      m_tx_cc = 0
      w_tx_cc = 0
      old_cod = m_codx

      SetColor(Cor)
      @ LIN,01 GET M_QUANT pict "99999"
      @ LIN,07 GET M_CODX PICT "999999"
      Read
      If Lastkey() = 27
         Return
      Endif
      Sele 3
      Set Order to 1
      Seek M_CODX
      If Eof()
         Alert("Produto N„o Cadastrado !")
         Loop
      Else
         m_grupo = cd_grup
      Endif
      W_FAIXAP = CD_FAIXAP
      M_AVISTA = CD_AVISTA2
      M_MESES  = CD_GR
      M_SBGRUPO= CD_SBGRUP

      If m_tipo = 4           // Financeira
         m_vezes = 1
         m_num1  = 1
      Endif
      If m_grupo = 8
         w_PROD = TRIM(CD_PROD)
         z:=At("TRIANG",w_PROD)
         If z != 0
            w_triang = "S"
         Endif
      Endif

      Sele 25
      Set Order to 1
      cor=setcolor()
      Set color to b+/w

      m_autor  = 0
      m_vrcirca= 0
      m_passci = "n"
      Sele 57
      Set Order to 1
      Seek Str(m_codx,6,0)
      While !eof() .and. ci_codigo = m_codx
        If ci_datini <= m_datsi .and. ci_datlimi >= m_datsi
           m_passci = "s"
           Exit
        Endif
        Skip
      Enddo
      m_prcprom = 1
      If m_tipo = 5 .and. m_debcc = 1 .and. m_passci = "s"
         mprcp=savescreen(10,20,14,40)
         SETCOLOR("bg/gr")
         Sombra(10,20,14,38,box)
         @ 11,21 prom "Promocao Vista  "
         @ 12,21 prom "Promocao a Prazo"
         @ 13,21 prom "Fora da Promocao"
         Menu to m_prcprom
         restscreen(10,20,14,40,mprcp)
      Endif
      Stor 0 to m_Vrplano
      w_vai_ut = "s"

      If m_passci = "s"                        && circcpd.dbf
         m_datcirc = ctod("  /  /    ")
         Stor 0 to m_numcirca,m_vrcirca,m_numcircp,m_vrcircp
         Set Filter to ci_codigo = m_codx .and. m_datsi >= ci_datini .and. m_datsi <= ci_datlimi
         Goto Top
         If !Eof()
            SSOR=savescreen(15,02,21,77)
            SETCOLOR(MENU)
            PRIV VETOR1[8],VETOR2[8]
            VETOR1[1]='CI_CODIGO'
	    If ((m_tipo = 5) .and. (m_debcc = 1 .or. m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
               If m_prcprom = 1
  	          VETOR1[2]= "CI_XAV"
	          VETOR1[3]= "CI_AVISTA"
  	       ElseIf m_prcprom = 2
                  VETOR1[2]='CI_XAP'
                  VETOR1[3]='CI_APRAZO'
	       Endif
           ElseIf m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 7 .or. m_tipo = 8
               VETOR1[2]='CI_XAV'
               VETOR1[3]='CI_AVISTA'
           Else
               VETOR1[2]='CI_XAP'
               VETOR1[3]='CI_APRAZO'
           Endif
           VETOR1[4]='CI_DATINI'
           VETOR1[5]='CI_DATLIMI'
           VETOR1[6]='CI_TIPO'
           VETOR1[7]='CI_AUTORIZ'
           VETOR1[8]='CI_MODALID'
           VETOR2[1]='Codigo'
           If ((m_tipo = 5) .and. (m_debcc = 1 .or. m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
              If m_prcprom = 1
                 VETOR2[2] = "(x)"
                 VETOR2[3] = "A Vista"
              ElseIf m_prcprom = 2
                 VETOR2[2]='(x)'
                 VETOR2[3]='A Prazo'
              Endif
           ElseIf m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 7 .or. m_tipo = 8
              VETOR2[2]='(x)'
              VETOR2[3]='A Vista'
           Else
              VETOR2[2]='(x)'
              VETOR2[3]='A Prazo'
           Endif
           VETOR2[4]='Inicio da Promocao'
           VETOR2[5]='Limite da Promocao'
           VETOR2[6]='Tip Circular'
           VETOR2[7]='Nr Autoriz'
           VETOR2[8]='Modalidade'
           SETCOLOR("b+/w")
           @ 15,02 clear to 21,77
           @ 15,02 to 21,77 double
           DBEDIT(16,03,20,76,VETOR1,,,VETOR2)
           RELEASE VETOR1,VETOR2
           RestScreen(15,02,21,77,SSOR)
           m_datcirc  = ci_datlimi
           If ci_modalid = "CC"
              w_mod = "CC"
           Else
              w_mod = "  "
           Endif
           If m_tipo = 5 .and. m_debcc = 1                 && Cartao Parcelado
              If m_prcprom = 1
                 m_vezes  = ci_xav
                 m_vzold  = ci_xav
              ElseIf m_prcprom = 2
                 m_vezes  = ci_xap
                 m_vzold  = ci_xap
              Endif
           ElseIf ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
              m_vezes   = ci_xav
              m_vzold   = ci_xav
           ElseIf m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 7 .or. m_tipo = 8
              m_vezes   = 1
              m_vzold   = 1
           Else
              If (m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 4 .or. m_tipo = 5 .or. m_tipo = 6 .or. m_tipo = 8) .and. (m_plm = 2)
                 m_vezes  = m_vezespl
                 m_vzold  = m_vezespl
              Else
                 m_vezes  = ci_xap
                 m_vzold  = ci_xap
              Endif
           Endif
           If m_vezes  = 0
              m_vezes  = 1
              m_vzold  = 1
           Endif
           If m_datcirc < m_datsi
              Alert("Produto Fora da Promocao !")
           Else
              m_num_vda = ci_xav
              m_vrcirca = ci_avista
              m_num_vdp = ci_xap
              m_vrcircp = ci_aprazo
              m_autor   = ci_autoriz
              If ci_codigo <> m_codx
                 Alert("Codigo Errado !")
                 Set Filter to
                 Loop
              Endif
              If m_vrcirca >0 .and. m_vrcircp >0
                 If m_tipo = 5 .and. m_debcc = 1       && Cartao Parcelado
                    If m_prcprom = 1
                       M_VrPlano = m_vrcirca
                    ElseIf m_prcprom = 2
                       M_VrPlano = m_vrcircp
                    Endif
                 ElseIf ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
                    M_VrPlano  = m_vrcirca
                 ElseIf m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 7 .or. m_tipo = 8
                    M_VrPlano  = m_vrcirca
                 Else
                    M_VrPlano  = m_vrcircp
                 Endif
              ElseIf m_vrcirca >0 .and. m_vrcircp <=0
	         If m_tipo = 5 .and. m_debcc = 1         && Cartao parcelado
                    If m_prcprom = 1
	               M_VrPlano  = m_vrcirca
	            ElseIf m_prcprom = 2
	               M_VrPlano  = m_vrcircp
	            Endif
                 ElseIf ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
	            If m_vrcirca >0
	               M_VrPlano = m_vrcirca
	            Else
	               M_VrPlano = m_vrcircp
	            Endif
 	         ElseIf m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 7 .or. m_tipo = 8
	            M_VrPlano = m_vrcirca
	         Else
	            M_VrPlano = 0
	         Endif
              ElseIf m_vrcirca <=0 .and. m_vrcircp >0
                 If m_tipo <> 1
	            M_VrPlano = m_vrcircp
	         Else
	            M_VrPlano = 0
	         Endif
              ElseIf m_vrcirca = 0 .or. m_vrcircp = 0
 	         If m_tipo <> 1
	            M_VrPlano = m_vrcircp
	         Else
	            M_VrPlano = m_vrcirca
	         Endif
              Endif
           Endif
        Endif
        Set Filter to
        If W_Mudou_Pl = "S"
           M_UNIT = M_VrPlano
        Endif
     Endif

     If m_autor >0
        W_nResp:=0
        W_nResp:=Alert("Vai utilizar esta promocao ?", {"Sim ","N„o"})
        If W_nResp<>1 .or. LASTKEY() = 27
           m_passci = "n"
           m_autor  = 0
        Endif
     Endif
     If w_mod <> "  "
        If (m_tipo = 2 .or. m_tipo = 3) .and. W_mod = "CC"
           Alert("Modalide de Venda Difere da Circular !")
           m_passci = "n"
	   m_autor  = 0
	   W_nResp  = 2
       Endif
     Endif
     If (W_Faixap >0 .and. M_MESES > 12) .and. (M_SBGRUPO=8 .or. M_SBGRUPO=304)
         W_faixap = 0   // Colchoes e cama box acima de 12 meses
     Endif

    *w_faixap = 0
     w_plano = 0
     Stor 0 to w_garant_12,w_garant_24,w_garant_36
     Sele 101
     If xy_cap_int = "CC" .and. M_Datsi >= ctod("01/07/2022")
        Veriout(SetColor(24),23,"faixaprtwgcp")
        Set Index to index_faixaprtwgcp
     Else
        Veriout(SetColor(24),23,"faixaprtwg")
        Set Index to index_faixaprtwg
     Endif
     Go Top
     Seek W_faixap
     While !Eof() .and. faixa = W_faixap
       If M_AVISTA >= DE .and. M_AVISTA <= ATE .and. plano = 12
          w_garant_12 = premio_tot
       Endif
       If M_AVISTA >= DE .and. M_AVISTA <= ATE .and. plano = 24
          w_garant_24 = premio_tot
       Endif
       If M_Datsi >= ctod("01/07/2022")
          If m_grupo <> 4 .and. m_grupo <> 6 .and. m_grupo <> 18 .and. m_grupo <> 19
             If M_AVISTA >= DE .and. M_AVISTA <= ATE .and. plano = 36 .and. M_MESES <= 12
                w_garant_36 = premio_tot
             Endif
          Endif
       Endif
       Skip
     Enddo
     Use
     Sele 25
     Set Order to 1
     If w_faixap = 34 .AND. M_MESES >0 .and. w_faixap >0
        If w_garant_24 >0 .AND. M_MESES < 24
           Alert("Troca Garantida 24 Meses R$ "+str(w_garant_24,6,2)+", Troca Garantida 12 Meses R$ "+str(w_garant_12,6,2))
        Else
           w_garant_24 = 0
           Alert("Troca Garantida 12 Meses R$ "+str(w_garant_12,6,2))
        Endif
     Else
        If w_garant_24 >0 .AND. M_MESES >0 .AND. M_MESES < 24 .and. w_faixap >0
           Alert("Garantia 24 Meses R$ "+str(w_garant_24,6,2)+", Garantia 12 Meses R$ "+str(w_garant_12,6,2))
        ElseIf M_MESES >0
	   w_garant_24 = 0
	   Alert("Garantia 12 Meses R$ "+str(w_garant_12,6,2))
	Else
	   Stor 0 to w_garant_24,w_garant_12,w_garant_36
	Endif
     Endif

     Stor 0 to w_plav,w_garant
     mfrt = Savescreen(18,04,24,77)

     cor=setcolor()
     SETCOLOR("W+/BG+, B/RG,X")
     If w_faixap <> 34 .AND. M_MESES >0 .AND. M_MESES < 24 .and. w_faixap >0
        If w_garant_36 >0 .AND. M_MESES <= 12
           @ 18,14 clear to 20,77
           @ 18,14 to 20,77
           @ 19,15 prom "Plano (36)"
           @ 19,26 prom "Plano (24)"
           @ 19,37 prom "Plano (12)"
           @ 19,48 prom "Avulsa (av ou 3x)"
           @ 19,66 prom "S/Garantia"
           Menu to m_grts
           If m_grts = 4
              @ 20,50 clear to 23,63
              @ 20,50 to 23,63
              @ 21,51 prom "Avulsa (24)"
              @ 22,51 prom "Avulsa (12)"
	      Menu to m_grt_x
	      If m_grt_x = 1
	         w_plav   := w_garant_24
	         w_garant := 0
 	         w_plano  := 2
	      Else
	         w_plav   := w_garant_12
 	         w_garant := 0
 	         w_plano  := 1
	      Endif
	      Release m_grt_x
	   Endif
	   If m_grts = 1
	      w_garant := w_garant_36
              w_plano  := 3
	   ElseIf m_grts = 2
	      w_garant := w_garant_24
              w_plano  := 2
	   ElseIf m_grts = 3
	      w_garant := w_garant_12
              w_plano  := 1
           Endif
        ElseIf w_garant_24 >0
           @ 18,14 clear to 20,76
           @ 18,14 to 20,76
           @ 19,15 prom "C/Garantia(24)"
           @ 19,31 prom "C/Garantia(12)"
           @ 19,47 prom "Avulsa (av ou 3x)"
	   @ 19,66 prom "S/Garantia"
	   Menu to m_grts
	   If m_grts = 3
              @ 20,50 clear to 23,63
              @ 20,50 to 23,63
              @ 21,51 prom "Avulsa (24)"
              @ 22,51 prom "Avulsa (12)"
	      Menu to m_grt_x
	      If m_grt_x = 1
	         w_plav   := w_garant_24
	         w_garant := 0
 	         w_plano  := 2
	      Else
	         w_plav   := w_garant_12
 	         w_garant := 0
 	         w_plano  := 1
	      Endif
	      Release m_grt_x
           Endif
           If m_grts = 1
              w_garant := w_garant_24
              w_plano  := 2
	      ElseIf m_grts = 2
	         w_garant := w_garant_12
                 w_plano  := 1
	      ElseIf m_grts = 4
  	         w_garan  := 0
 	         w_plano  := 0
	      Endif
           ElseIf M_MESES >0
              @ 18,20 clear to 20,68
              @ 18,20 to 20,68
              @ 19,21 prom "C/Garantia(12)"
              @ 19,37 prom "Avulsa (av ou 3x)"
	      @ 19,56 prom "S/Garantia"
   	      Menu to m_grts
	      If m_grts = 1
	         w_garant := w_garant_12
                 w_plano  := 1
	      ElseIf m_grts = 2
   	         w_plav   := w_garant_12
 	         w_garant := 0
 	         w_plano  := 1
	      ElseIf m_grts = 3
  	         w_garant := 0
 	         w_plano  := 0
	      Endif
	   Endif
        Else                                         // Troca Garantida
	   If w_garant_24 >0 .and. M_MESES >0 .and. M_MESES < 24 .and. w_faixap >0
              @ 18,04 clear to 20,76
              @ 18,04 to 20,76
              @ 19,05 prom "Troca Garantida(24)"
              @ 19,26 prom "Troca Garantida(12)"
              @ 19,47 prom "Avulsa (av ou 3x)"
	      @ 19,66 prom "S/Garantia"
   	      Menu to m_grts
	      If m_grts = 3
                 @ 20,50 clear to 23,63
                 @ 20,50 to 23,63
                 @ 21,51 prom "Avulsa (24)"
                 @ 22,51 prom "Avulsa (12)"
	         Menu to m_grt_x
		 If m_grt_x = 1
		    w_plav   := w_garant_24
	            w_garant := 0
 	            w_plano  := 2
		 Else
		    w_plav   := w_garant_12
 	            w_garant := 0
 	            w_plano  := 1
		 Endif
		 Release m_grt_x
	      Endif
	      If m_grts = 1
	         w_garant := w_garant_24
                 w_plano  := 2
	      ElseIf m_grts = 2
	         w_garant := w_garant_12
                 w_plano  := 1
	      ElseIf m_grts = 4
  	         w_garant := 0
 	         w_plano  := 0
	      Endif
           ElseIf M_MESES >0
              @ 18,10 clear to 20,63
              @ 18,10 to 20,63
              @ 19,11 prom "Troca Garantida(12)"
              @ 19,32 prom "Avulsa (av ou 3x)"
	      @ 19,51 prom "S/Garantia"
   	      Menu to m_grts
	      If m_grts = 1
	         w_garant := w_garant_12
                 w_plano  := 1
	      ElseIf m_grts = 2
    	         w_plav   := w_garant_12
 	         w_garant := 0
 	         w_plano  := 1
	      ElseIf m_grts = 3
  	         w_garant := 0
 	         w_plano  := 0
	      Endif
	   Endif
        Endif

        Restscreen(18,04,24,77,mfrt)
        Release w_faixap,mfrt,m_grts

        If ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
           If m_debcc = 2
              m_vezes     = 1
              m_vzold     = 1
           ElseIf m_debcc = 3
              m_vezes     = 1
              m_vzold     = 1
           ElseIf m_debcc = 4
              m_vezes     = 2
              m_vzold     = 2
           ElseIf m_debcc = 5
              m_vezes     = 3
              m_vzold     = 3
           ElseIf m_debcc = 7
              m_vezes     = 5
              m_vzold     = 5
           Endif
        Endif

        M_Tabe = 2       // Usando Tabela 2 ( A Vista )

        Sele 3
        Set Order to 1
        m_avista = cd_avista2
        If m_tipo <> 1
           M_Venda  = cd_avista2
           M_PRAUX  = cd_avista2
           M_PRE    = cd_avista2
        Else
           M_Venda  = m_unit
           M_PRAUX  = m_unit
           M_PRE    = m_unit
        Endif
        If m_passci = "n"
           If m_tipo <> 1
              M_PRE   = cd_avista2
           Endif
        Else
           M_PRE   = m_vrplano
           M_Venda = m_vrplano
           If m_tipo = 5               // cartao menor que preco a vista em 2 ou 3x
              If m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 7
	         If m_venda < m_praux .and. m_grupo <> 8
	            Alert("Preco Somente a Vista. Sujeito a Analize !")
                 Endif
              Endif
           Endif
        Endif
        Setcolor(cor)
        Sele 3
        Set Order to 1
        Goto Top
        Seek M_CODX
        If !Eof()
           @ LIN,14 SAY SUBSTR(CD_PROD,1,27)
           m_prod=cd_prod
        Else
           @ LIN,14 SAY "Erro no arquivo..."
        Endif
        Sele 25
        Set Order to 1
        SetColor(Cor)
        @ LIN,42 GET M_COR   PICT "@!"
        If Empty(M_RESERV)
           @ LIN,50 GET M_SAIDA PICT "@!S7"
        Else
           @ LIN,50 Say Substr(M_SAIDA,1,7)
        Endif
        @ LIN,58 GET M_VEZES PICT "99" Valid M_VEZES >0 .and. M_VEZES < 25
        Read

        If m_codx <> old_cod
           Stor 0 to M_Res
           If (M_codx >5) .and. (Trim(m_saida) = "LOJA/MOST" .or. Trim(m_saida) = "DEP. INT")
              M_Res := Ret_Res(m_codx)    // Funcoes.prg
              Stor 0 to Cent,m_pendenc,wTransit

              @ 19,15 Say "Aguarde, checando estoque... "
              SD_Fisc(M_Codx,,,@Cent,@M_Pendenc,@wTransit)
              M_SdPendenc := SD_Pend(m_codx)
              M_Pendenc = M_Pendenc + M_SdPendenc

              Sele 30
              Set Order to 1
              m_autoriz = cd_autoriz
              If m_transit <> wTransit
                 m_transit = wTransit
              Endif
              CENTX = CENT - (cd_avaria+m_autoriz+m_res+cd_transit+M_PENDENC)
              Release cent
              If Centx <= 0 .or. M_Quant > Centx
                 Sele 25
                 Set Order to 1
                 Alert("Estoque Insuficiente !")
                 Release datex,datex1,m_datw,m_res
                 Loop
              Endif
              If Trim(M_SAIDa) = "LOJA/MOSTR"
                 Sele 4
                 Set Order to 2
                 Go Top
                 Seek Str(M_codx,6,0)+substr(dtoc(m_datsi),7,4)+substr(dtoc(m_datsi),4,2)+substr(dtoc(m_datsi),1,2)
                 Stor 0 to wAfaturar
                 While !Eof() .and. sd_codi = M_codx .and. sd_data = m_datsi
                   If Trim(sd_saida) = "LOJA/MOSTR"
                      wJaFat := SD_JaFat(sd_codi,sd_nota)
                      If wJafat = 0
                         wAfaturar = wAfaturar + sd_qtde
                      Endif
                   Endif
                   Skip
                 Enddo
                 If wAfaturar+M_Quant > CENTX                    // Saldo das vendas maior que o fiscal
                    Alert("Estoque Insuficiente ou Venda Ainda N„o Faturada !")
                    Release datex,datex1,m_datw,m_res,wAfaturar,wJafat
                    Sele 25
                    Set Order to 1
                    Loop
                 Endif
                 Release wAfaturar,wJafat
              Endif
              @ 19,15 Say "                             "
           Endif
        Endif
        If m_tipo = 1 .and. m_vezes >1
           Alert("Tipo de Venda a Vista. So 1 Vez !")
           Loop
        ElseIf m_tipo = 5 .and. m_debcc = 1 .and. (m_vezes < 4 .or. m_vezes > 12)
           Alert("Credito Parcelado. Acima de 3 Vezes !")
           Loop
        ElseIf m_tipo = 5 .and. m_debcc = 2 .and. m_vezes > 1
           Alert("Debito em Conta. So 1 Vez !")
           Loop
        ElseIf m_tipo = 5 .and. m_debcc = 3 .and. m_vezes > 1
           Alert("1 Vez sem Juros !")
           Loop
        ElseIf m_tipo = 5 .and. m_debcc = 4 .and. (m_vezes < 2 .or. m_vezes > 2)
           Alert("2 Vezes sem Juros !")
           Loop
        ElseIf m_tipo = 5 .and. m_debcc = 5 .and. (m_vezes < 3 .or. m_vezes >3)
           Alert("3 Vezes sem Juros !")
           Loop
        Endif
        If xy_cap_int <> "CC"     // Lojas do interior ( filiais.dbf )
           If m_grupo = 5
              m_tx_cc = I_TXCARNE           // Taxa de motos ( Carnet )
           Endif
           If m_tipo = 1            && A Vista
              m_tx_cc    = 0
              m_vezes= 1
           ElseIf m_tipo = 2        && C/Cheque
              m_tx_cc = I_TXCHEQUE
	      m_venda = m_venda + w_garant
           ElseIf m_tipo = 3        && C/Carne
              m_tx_cc = I_TXCARNE
	      m_venda = m_venda + w_garant
           ElseIf m_tipo = 4        && C/Financeira
              m_tx_cc    = 0
	      m_vezes= 1
	      m_venda = m_venda + m_txab
           ElseIf m_tipo = 6 .or. m_tipo = 8        && Convenio
              m_tx_cc    = 0
	      m_vezes= 1
          ElseIf m_tipo = 5        && Cartao de Credito
	      m_tx_cc = 0
              m_venda = m_venda
              If m_debcc = 2
	         m_vezes= 1
              ElseIf m_debcc = 3
	         m_vezes= 1
              ElseIf m_debcc = 4
	         m_vezes= 2
              ElseIf m_debcc = 5
	         m_vezes= 3
              ElseIf m_debcc = 6
	      m_vezes= 4     // Ate Dezembro
              If m_grupo = 1 .or. m_grupo = 2 .or. m_grupo = 3 .or. m_grupo = 6 .or. m_grupo = 9 .or. m_grupo = 12 .or. m_grupo = 15 .or. m_grupo = 16 .or. m_grupo = 17 .or. m_grupo = 18 .or. m_grupo = 19
                 w_tx_cc = I_TXELEINT          // Taxa de eletro p/ interior (cartao)
              ElseIf m_grupo = 8
                 w_tx_cc = I_TXCELCC           // Taxa de celulares p/ Capital e Interior (cartao)
              ElseIf m_grupo = 7 .or. m_grupo = 11
                 w_tx_cc = I_TXINFCCI          // Taxa de informtica p/ Interior (cartao)
              ElseIf m_grupo = 4
                 w_tx_cc = I_TXMOVINT          // Taxa de moveis p/ Interior (cartao)
              ElseIf m_grupo = 5
                 w_tx_cc = I_TXMOTOS           // Taxa de motos ( Cartao )
              Endif
          ElseIf m_debcc = 7
	      m_vezes= 5
           Else
              If m_grupo = 1 .or. m_grupo = 2 .or. m_grupo = 3 .or. m_grupo = 6 .or. m_grupo = 9 .or. m_grupo = 12 .or. m_grupo = 15 .or. m_grupo = 16 .or. m_grupo = 17 .or. m_grupo = 18 .or. m_grupo = 19
                 m_tx_cc = I_TXELEINT          // Taxa de eletro p/ interior (cartao)
              ElseIf m_grupo = 8
                 m_tx_cc = I_TXCELCC           // Taxa de celulares p/ interior (cartao)
              ElseIf m_grupo = 7 .or. m_grupo = 11
                 m_tx_cc = I_TXINFCCI          // Taxa de informtica p/ interior (cartao)
              ElseIf m_grupo = 4
                 m_tx_cc = I_TXMOVINT          // Taxa de moveis p/ interior (cartao)
              ElseIf m_grupo = 5
                 m_tx_cc = I_TXMOTOS            // Taxa de motos ( Carnet )
              Endif
           Endif
        Endif
     Else                 // Lojas da Capital
       If m_prcprom = 1
          If m_tipo <> 1 .and. m_tipo <> 4 .and. m_tipo <> 8
	     If m_tipo = 2 .or. m_tipo = 3
                m_venda = m_venda + m_txab + m_frt + m_mon + w_garant     // Composicao do pr de partida
             Else
	        m_venda = m_venda + m_txab + m_frt + m_mon
             Endif
	  Endif
       ElseIf m_prcprom = 2
          m_venda = m_venda
       Endif
       If m_grupo = 5
          m_tx_cc = I_TXCARNE            // Taxa de motos ( Carnet )
       Endif
       If m_tipo = 1            && A Vista
          m_tx_cc = 0
          m_vezes= 1
       ElseIf m_tipo = 2        && C/Cheque
          m_tx_cc = I_TXCHEQUE
       ElseIf m_tipo = 3        && C/Carne
          m_tx_cc = I_TXCARNE
       ElseIf m_tipo = 4        && C/Financeira
          m_tx_cc    = 0
	  m_vezes= 1
	  m_venda = m_venda + m_txab
       ElseIf m_tipo = 6 .or. m_tipo = 8        && Convenio
          m_tx_cc    = 0
	  m_vezes= 1
       ElseIf m_tipo = 5   && Cartao de Credito
	  m_tx_cc = 0
          If m_debcc = 2
	     m_vezes= 1
          ElseIf m_debcc = 3
	     m_vezes= 1
          ElseIf m_debcc = 4
	     m_vezes= 2
          ElseIf m_debcc = 5
	     m_vezes= 3
          ElseIf m_debcc = 6   // Ate Dezembro
	     m_vezes= 4
             If m_grupo = 1 .or. m_grupo = 2 .or. m_grupo = 3 .or. m_grupo = 6 .or. m_grupo = 9 .or. m_grupo = 12 .or. m_grupo = 15 .or. m_grupo = 16 .or. m_grupo = 17 .or. m_grupo = 18 .or. m_grupo = 19
                w_tx_cc = I_TXELECAP          // Taxa de eletro p/ interior (cartao)
             ElseIf m_grupo = 8
                w_tx_cc = I_TXCELCC           // Taxa de celulares p/ Capital e Interior (cartao)
             ElseIf m_grupo = 7 .or. m_grupo = 11
                w_tx_cc = I_TXINFCCC          // Taxa de informtica p/ capital (cartao)
             ElseIf m_grupo = 4
                w_tx_cc = I_TXMOVCAP          // Taxa de moveis p/ capital (cartao)
             ElseIf m_grupo = 5
                w_tx_cc = I_TXMOTOS           // Taxa de motos ( Cartao )
             Endif
          ElseIf m_debcc = 7
             m_vezes= 5
             If m_grupo = 1 .or. m_grupo = 2 .or. m_grupo = 3 .or. m_grupo = 6 .or. m_grupo = 9 .or. m_grupo = 12 .or. m_grupo = 15 .or. m_grupo = 16 .or. m_grupo = 17 .or. m_grupo = 18 .or. m_grupo = 19
                w_tx_cc = I_TXELECAP          // Taxa de eletro p/ interior (cartao)
             ElseIf m_grupo = 8
                w_tx_cc = I_TXCELCC           // Taxa de celulares p/ Capital e Interior (cartao)
             ElseIf m_grupo = 7 .or. m_grupo = 11
                w_tx_cc = I_TXINFCCC          // Taxa de informtica p/ capital (cartao)
             ElseIf m_grupo = 4
                w_tx_cc = I_TXMOVCAP          // Taxa de moveis p/ capital (cartao)
             ElseIf m_grupo = 5
                w_tx_cc = I_TXMOTOS           // Taxa de motos ( Cartao )
             Endif
	  Else
             If m_grupo = 1 .or. m_grupo = 2 .or. m_grupo = 3 .or. m_grupo = 6 .or. m_grupo = 9 .or. m_grupo = 12 .or. m_grupo = 15 .or. m_grupo = 16 .or. m_grupo = 17 .or. m_grupo = 18 .or. m_grupo = 19
                m_tx_cc = I_TXELECAP          // Taxa de eletro p/ interior (cartao)
             ElseIf m_grupo = 8
                m_tx_cc = I_TXCELCC           // Taxa de celulares p/ Capital e Interior (cartao)
             ElseIf m_grupo = 7 .or. m_grupo = 11
                m_tx_cc = I_TXINFCCC          // Taxa de informtica p/ capital (cartao)
             ElseIf m_grupo = 4
                m_tx_cc = I_TXMOVCAP          // Taxa de moveis p/ capital (cartao)
             ElseIf m_grupo = 5
                m_tx_cc = I_TXMOTOS           // Taxa de motos ( Cartao )
             Endif
          Endif
       Endif
     Endif

     M_GRFATOR = 0
     If w_garant > 0
        If w_tx_cc > 0 .and. m_tx_cc = 0
	   m_tx_cc = w_tx_cc
	Endif
        If m_vezes <= 3
	   m_tx_cc = 0
	Endif
        W_gr1 = Str(Parc_Fin(w_garant,m_tx_cc,m_vezes,.f.),10,2)
        M_GRFATOR = round((Val(W_gr1) * m_vezes),1)
        Release w_gr1
	If w_tx_cc >0
	   m_tx_cc = 0
	Endif
     Endif

     wValor   = M_VrPlano
     w_ult_vr = 0

     If m_passci = "n"
        If m_vrentr >0
           WnValor   = ((m_venda * m_percentr) /100)
           WVrDesc   = m_venda - WnValor
           WValor    = Str(Parc_Fin(wVrDesc,m_tx_cc,m_vezes,.f.),10,2)
           m_pre = round(((val(WValor) * m_vezes) + WnValor),1)
	Else
           If xy_cap_int = "CC"
	      If w_vai_ut = "n"
                 If w_tx_cc >0
		    If m_tipo = 2 .or. m_tipo = 3
                       m_venda = m_venda + (m_txab + m_frt + m_mon + m_grfator)
		    Else
		       If (m_tipo = 5) .and. (m_debcc = 6 .or. m_debcc = 7)  // Sem juros
	                  m_venda = m_venda
		       Else
	                   m_venda = m_venda + (m_txab + m_frt + m_mon)
                       Endif
		    Endif
                 Else
                    If m_tipo = 2 .or. m_tipo = 3
      	               m_venda = m_venda + (m_txab + m_frt + m_mon + w_garant)
       	            Else
		       If (m_tipo = 5) .and. (m_debcc = 6 .or. m_debcc = 7)  // Sem juros
	                  m_venda = m_venda
		       Else
	                   m_venda = m_venda + (m_txab + m_frt + m_mon)
                       Endif
		    Endif
		 Endif
	      Else
	         If (m_tipo = 5 ) .and. (m_debcc= 6 .or. m_debcc =7)
		    m_venda = m_venda + (m_txab + m_frt + m_mon)
		 Endif
	      Endif
           Else
	      If w_tx_cc >0
	         If (m_tipo= 5) .and. (m_debcc =6 .or. m_debcc =7)
	             m_venda = m_venda
		 Endif
	      Endif
	   Endif

	   WValor  = Str(Parc_Fin(m_venda,m_tx_cc,m_vezes,.f.),10,2)
           m_pre = round((val(WValor) * m_vezes),1)

	   If w_vai_ut = "n" .and. m_vrcirca >0 .and. m_prcprom = 3   && n vai utilizar a circ e pega preco da circ
              w_ult_vr = m_pre                                    && para comparar se foi diminuido o valor
           Endif

	Endif
	If xy_cap_int = "CC" .and. m_tipo <> 1 .and. m_tipo <> 4 .and. m_tipo <> 8
           M_PRE = (M_PRE - (m_txab + m_frt + m_mon ))   // Composicao do pr de partida
        ElseIf xy_cap_int = "CC" .and. w_vai_ut = "n"
           M_PRE = (M_PRE - (m_txab + m_frt + m_mon ))   // Composicao do pr de partida
	Endif
        WValor = M_PRE

     ElseIf m_passci <> "n" .and. m_tipo = 5 .and. m_debcc = 1

       If m_prcprom = 1
          m_percentr = ((m_vrentr / (m_vrvenda+m_txab+m_frt+m_mon)) * 100)

          WnValor = ((m_venda * m_percentr) /100)
	  WVrDesc = m_venda - WnValor

	  WValor  = Str(Parc_Fin(WVrDesc,m_tx_cc,m_vezes,.f.),10,2)
          WValor  = round((((Val(WValor) * m_vezes) + WnValor) - (m_txab + m_frt + m_mon )),1)
       ElseIf m_prcprom = 2
          If xy_cap_int = "CC"
             If m_tipo = 2 .or. m_tipo = 3
	        m_venda = m_venda + m_grfator
	     Else
 	        m_venda = m_venda
	     Endif
	     wvalor  = m_venda
	  Else
	     If m_tipo = 2 .or. m_tipo = 3
                m_venda = m_venda - w_garant
                WValor = m_venda + m_grfator
	     Else
	        m_venda = m_venda
                WValor  = m_venda
             Endif
          Endif
       Endif
          M_PRE = WValor     // Composicao do pr de partida
     Else
        If m_tipo = 4
           m_pre = m_pre + m_txab
	ElseIf m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 4 .or. m_tipo = 5
           If m_tipo = 3
              m_pre = m_pre + m_grfator
           Else
	      If w_tx_cc > 0
                 If m_tipo = 2 .or. m_tipo = 3
	            m_pre = m_pre + m_grfator
		 Else
	            m_pre = m_pre
		 Endif
	      Else
                 If m_tipo = 2 .or. m_tipo = 3
   	            m_pre = m_pre + w_garant
		 Else
	            m_pre = m_pre
	         Endif
	      Endif
	   Endif
	Endif
     Endif

     If m_plm = 1
        m_num1 = m_vezes
     Endif
     If m_passci = "n"
        M_UNIT = M_PRE
        @ LIN,61 GET M_PRE PICT "99,999.99"
        Read
        If w_vai_ut = "n" .and. m_vrcirca >0 .and. m_prcprom = 3   && n vai utilizar a circ e pega preco da circ
           If (M_PRE < W_ult_vr-1)
              m_autor = 0
	   Else
	      m_autor = w_autor
           Endif
        Endif
        Release w_autor,w_ult_vr
        If m_tipo = 1
           If (M_unit < M_Avista-1)
              M_PE   = (M_unit/M_Avista)
              M_PE   = M_PE*100
              M_PE   = 100-M_PE
              M_DESC = M_PE
	      If m_grupo <> 4 .and. m_grupo <> 6
	         If M_PE > I_DESCAVEL
	            Alert("Aviso! Este pre‡o estara sujeito a analize !")
                 Endif
	      ElseIf m_grupo = 4 .or. m_grupo = 6
	         If M_PE > I_DESCAVMO
	            Alert("Aviso! Este pre‡o estara sujeito a analize !")
                 Endif
	      Endif
           Endif
        ElseIf m_tipo = 5
           m_num1 = m_vezes
           If M_Unit < WValor-1
              M_PE  = (M_Unit/WValor)
              M_PE  = M_PE*100
              M_PE  = 100-M_PE
              M_DESC= M_PE
              If xy_cap_int = "CC"
       	         If m_grupo <> 4 .and. m_grupo <> 6
               	    If M_PE > I_DCELECAP
 	            Alert("Aviso! Este pre‡o estara sujeito a analize !")
                 Endif
	      ElseIf m_grupo = 4 .or. m_grupo = 6
	         If M_PE > I_DCMOVCAP
	            Alert("Aviso! Este pre‡o estara sujeito a analize !")
                 Endif
	      Endif
           Else
	      If m_grupo <> 4 .and. m_grupo <> 6
	         If M_PE > I_DCELEINT
  	            Alert("Aviso! Este pre‡o estara sujeito a analize !")
                 Endif
	      ElseIf m_grupo = 4 .or. m_grupo = 6
	         If M_PE > I_DCMOVINT
   	            Alert("Aviso! Este pre‡o estara sujeito a analize !")
                 Endif
	      Endif
           Endif
        Endif
    Endif
     Else
        If m_autor >0 .and. W_nResp = 1
           Keyb(chr(13))
        Endif
        WValor = M_UNIT
        @ LIN,61 GET M_UNIT PICT "@E 9,999.99"
	Read
     Endif
     If(Alert( "Altera Saida do Item ? ", {"Sim ","N„o "})) = 1
        Sele 32
        Veriout(setcolor(),23,"saida_outras")
        Go Top
        M_CORA =SETCOLOR()
        TELA100=SAVESCREEN(05,00,22,79)
        SETCOLOR(C_corg)
        PRIV VETOR1[1]
        VETOR1[1]='SAIDA_ITEM'
        SETCOLOR("n+/w")
        DBEDIT(lin,50,lin+5,62,VETOR1,,,VETOR1)
        M_SAIDA = TRIM(SAIDA_ITEM)
        M_LJX   = LOJA
        RELEASE VETOR1
        RESTSCREEN(05,00,22,79,TELA100)
        SETCOLOR(M_CORA)
        Sele 32
        Use
     Endif

     Sele 25
     Set Order to 1
     @ LIN,50 SAY SUBSTR(M_SAIDA,1,7)
     @ LIN,69 SAY M_UNIT * M_QUANT PICT "@E 999,999.99"

     M_TOTA = M_TOTA + (CD_UNIT * CD_QUANT)
     @ 20,69 SAY M_TOTA PICT "@E 999,999.99"

     T_garant = T_garant + w_garant
     m_grto   = m_tota
     If (m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 8) .and. (T_Garant >0)
         Cor=Setcolor()
         Setcolor("GR+/B")
         @ 21,59 SAY "Garantia Est"
         Cor=Setcolor(Cor)
         @ 21,69 SAY T_Garant          PICT "@E 999,999.99"
         @ 22,69 SAY M_GRTO + T_Garant PICT "@E 999,999.99"
     Endif

     LIN = LIN + 1
     IF LIN > 18
        LIN = 18
	Scroll(09,01,18,78,1)
     Endif
     nResp:=0
     nResp:=Alert( "Confirma  Altera‡„o Item ? ", {"Sim ","N„o "})
     If nResp = 1
        Stor 0 to m_de,m_ac
        If M_TIPO = 2 .OR. M_TIPO = 3 .OR. M_TIPO = 6
           If M_Unit < M_AVISTA
              M_DE = M_VENDA-M_Unit     // M_DE = DESCONTOS
           ElseIf M_Unit > M_AVISTA
              M_AC = M_Unit-M_Avista    // M_AC = ACRESCIMO
           Endif
        ElseIf M_Unit < M_AVISTA
              M_DE = M_AVISTA - M_Unit
        ElseIf M_Unit > M_AVISTA
              M_AC = M_Unit - M_AVISTA
        Endif
        If m_tipo = 5 .and. m_debcc = 2
	   m_vezes = 0
	Endif
        If Bloqreg(0)
           Repl cd_codi with m_codx,cd_tipov with m_tipo,cd_cor with m_cor, ;
                cd_unit with m_unit,cd_saida with m_saida,cd_quant with m_quant, ;
   	        cd_prod with m_prod,cd_vezes with m_vezes,cd_num1 with m_num1, ;
		cd_acres with m_ac,cd_desco with m_de,CD_Plano with w_plano,cd_status with "O"
		If w_plano > 0
		   Repl cd_vrgr with w_garant,cd_gr with "S",cd_dtgr with m_datsi,cd_fatorgr with M_GRFATOR
                Else
		   Repl cd_vrgr with 0,cd_gr with "N",cd_vrgr with 0,;
           cd_dtgr with ctod("  /  /    "),cd_fatorgr with M_GRFATOR
		Endif
		If w_plav >0              // Venda com Garantia Avulsa
 	          Repl cd_status with "A",cd_vrgr with w_plav,cd_plano with w_plano
                Endif
	        Release w_plav

		If m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 6
		   Repl cd_numpre with m_vezes
		Else
		   Repl cd_vrparc1 with 0,cd_numpre with 0,cd_dta1 with ctod(""),cd_dta2 with ctod("")
		Endif
                If m_tipo = 1
                   Repl cd_vrcar with 0,cd_vrfin with 0,cd_entra with 0
                Endif
		If m_autor >0
                   Repl cd_autor with m_autor
		Else
                   Repl cd_autor with 0
		Endif
		M_Alt="S"
		Unlock
        EndIf
     Endif
            nResp:=0
            nResp:=Alert( "Altera Outro Item ? ", {"Sim ","N„o "})
	   If nResp= 2
	      Exit
	   EndIf
       SKIP
   ENDDO
    Stor 0 to M_tota
    Sele 25
    Set Order to 1
    Seek Str(m_nota,8,0)
   While !eof() .and. cd_codior = m_nota
     If cd_datao = m_datao
        M_tota=M_Tota+(cd_unit*cd_quant)
     EndIf
      Skip
   EndDo
      IF M_TIPO = 4
         SOMBRA(11,05,13,31,BOX)
         @ 12,06 SAY 'VALOR ENTRADA 'Get M_VRFIN PICT "@E 999,999.99"
         READ
      ENDIF
      M_VRCAR = 0
      IF M_TIPO = 5
         SOMBRA(11,05,13,31,BOX)
         @ 12,06 SAY 'VALOR ENTRADA 'Get M_VRCAR PICT "@E 999,999.99"
         READ
      ENDIF
    Sele 25
    Set Order to 1
    Seek Str(m_nota,8,0)
   While !eof() .and. cd_codior = m_nota
    If cd_datao = m_datao
       If Bloqreg(0)
          Repl cd_vrcar with m_vrcar,cd_vrfin with m_vrfin,cd_entra with m_vrcar
          Comm
	  Unlock
       EndIf
    Endif
    Skip
   EndDo
    Stor 0 to S_Dia

    IF M_TIPO = 2 .OR. M_TIPO = 3 .OR. M_TIPO = 6 .and. M_Alt = "S"
      M_Nott=M_tota
      SETCOLOR("B+/W")
      @ 14,01 say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
      @ 15,01 say "³ T.Compra   Entrada  Financiado N§Prest  Vr.Prest         Vencimentos       ³"
      @ 16,01 say "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
      @ 17,01 say "³                                  (  )            Dˆ            A           ³"
      @ 18,01 say "³                                  (  )            Dˆ            A           ³"
      @ 19,01 say "³                                  (  )            Dˆ            A           ³"
      @ 20,01 say "³                                  (  )            Dˆ            A           ³"
      @ 21,01 say "³TOTAL.................................                                      ³"
      @ 22,01 say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
      @ 18,02 SAY M_NOTT   PICT "@E 999,999.99"
      @ 18,12 GET M_ENTRAD PICT "@E 99,999.99"
      READ
      IF LASTKEY()=27
         LOOP
      ENDIF
      M_VRP1=M_ENTRAD
      @ 18,23 SAY M_NOTT-M_ENTRAD PICT "@E 999,999.99"
      @ 17,37 GET M_NUM1 PICT "99" VALID M_NUM1 >0 .AND. M_NUM1<21
      READ
      M_VRP1=(M_NOTT-M_ENTRAD) / M_NUM1
      @ 17,41 GET M_VRP1 PICT "@E 999,999.99"

      M_DATT = M_ULTIMA
      S_DIA := SOMADD(M_DATT)
      M_DTA1 = M_ULTIMA+S_DIA
      M_DIA1 = DTOC(M_DTA1)
      M_DAT1 = M_DTA1

      @ 17,55 GET M_DTA1 VALID M_DTA1 >=M_DATAO

      If M_NUM1=1
         M_DATT=M_ULTIMA
         S_DIA :=SOMADD(M_DATT)
         M_DATX = M_ULTIMA+S_DIA
         M_DAT1 = M_DATX
      Endif
      wNum="1"
      For i = 2 to m_num1
         wNum  = Alltrim(str(i))
         wNumx = Alltrim(str(i-1))
         S_Dia := SOMADD(M_DAT&wNumx)
         M_DAT&wNum = M_DAT&wNumx+s_dia
      Next
      M_DATX = M_Dat&wNum

      @ 17,68 GET M_DATX VALID M_DATX >=M_DATAO
      @ 18,37 GET M_NUM2 PICT "99"
      @ 18,41 GET M_VRP2 PICT "@E 999,999.99"
      @ 18,55 GET M_DTA3
      @ 18,68 GET M_DTA4
      @ 19,37 GET M_NUM3 PICT "99"
      @ 19,41 GET M_VRP3 PICT "@E 999,999.99"
      @ 19,55 GET M_DTA5
      @ 19,68 GET M_DTA6
      @ 20,37 GET M_NUM4 PICT "99"
      @ 20,41 GET M_VRP4 PICT "@E 999,999.99"
      @ 20,55 GET M_DTA7
      @ 20,68 GET M_DTA8
      READ
      M_NUM  = M_NUM1+M_NUM2+M_NUM3+M_NUM4
      M_TOTT = (M_VRP1*M_NUM1)+(M_VRP2*M_NUM2)+(M_VRP3*M_NUM3)+(M_VRP4*M_NUM4)+M_ENTRAD
      @ 21,41 SAY M_TOTT PICT "@E 999,999.99"
      IF STR(M_TOTT,10,2) >STR(M_NOTT,10,2) .OR. STR(M_TOTT,10,2) < STR(M_NOTT,10,2)
         nResp:=0
         nResp:=Alert("Plano N„o Confere. Abandona Or‡amento ?", {"Sim ","N„o "})
         If nResp=2
           LOOP
         ELSE
           CONTINUA = "N"
           M_TOTS   = "N"
           M_AJUST  = "S"
           EXIT
         ENDIF
      ENDIF
    Sele 25
    Set Order to 1
    Seek Str(m_nota,8,0)
    While !eof() .and. cd_codior = m_nota
     If cd_datao = m_datao
        If bloqreg(0)
           Repl CD_NUMPRE WITH M_NUM,CD_ENTRA WITH M_ENTRAD,CD_NUM1 WITH M_NUM1,CD_NUM2 WITH M_NUM2,CD_NUM3 WITH M_NUM3,CD_NUM4 WITH M_NUM4, ;
                CD_VRPARC1 WITH M_VRP1,CD_VRPARC2 WITH M_VRP2,CD_VRPARC3 WITH M_VRP3,CD_VRPARC4 WITH M_VRP4,CD_DTA1 WITH M_DTA1,CD_DTA2 WITH M_DATX, ;
	        CD_DTA3 WITH M_DTA3,CD_DTA4 WITH M_DTA4,CD_DTA5 WITH M_DTA5,CD_DTA6 WITH M_DTA6,CD_DTA7 WITH M_DTA7,CD_DTA8 WITH M_DTA8
         EndIf
         Comm
         Unlock
     Endif
     Skip
    EndDo
  ENDIF
 Exit
Enddo
  RestScreen(06,00,22,80,ssb)
  Clear Gets
  Release M_DATAO,M_ULTIMA,M_CODI,M_TIPO,M_ENTRAD,M_VRP1
  Release M_VRP2,M_VRP3,M_VRP4,M_NUM1,M_NUM2,M_NUM3,M_NUM4,M_DTA1,M_DTA2,M_DTA3
  Release M_DTA4,M_DTA5,M_DTA6,M_DTA7,M_DTA8,M_VRFIN,M_VRCAR,M_CLIE,M_NOME,ENDEX
  RestScreen(06,00,20,80,ssb)
Return

//********************
  Function Triang_Cel(w_nota,w_dat)
//********************
 If Loja = 03 .or. Loja = 29 .or. Loja = 30 .or. Loja = 34 .or. Loja = 35 .or. Loja = 37
    Keyb(chr(27))
    Return
 Endif

 W_Oper = space(5)
 Sele 25
 Set Order to 1
 Seek STR(w_NOTA,8,0)+SUBSTR(DTOC(w_DAT),7,4)+SUBSTR(DTOC(w_DAT),4,2)+SUBSTR(DTOC(w_DAT),1,2)
 w_recno=recno()
 While !Eof() .and. CD_CODIOR = w_NOTA .AND. CD_DATAO = w_DAT
  @ Lin,02 Say STRZERO(CD_QUANT,4)+" - "+STRZERO(CD_CODI,6)+"  "+SUBSTR(CD_PROD,1,40)
  If !Empty(cd_imei) .and. Len(cd_imei) = 15
     w_PROD = TRIM(CD_PROD)
     z:=At("TRIANG",w_PROD)
     If z != 0
        z:=At("VIVO",w_PROD)
        If z != 0
	   w_oper = "VIVO"
	Else
           z:=At("CLARO",w_PROD)
           If z != 0
  	      w_oper = "CLARO"
	   Else
              z:=At("TIM",w_PROD)
              If z != 0
  	         w_oper = "TIM"
	      Else
                 z:=At(" OI ",w_PROD)
                 If z != 0
  	            w_oper = " OI "
	         Else
                    z:=At(".OI",w_PROD)
                    If z != 0
     	               w_oper = " OI "
		    Else
                       z:=At(".OI ",w_PROD)
                       If z != 0
     	                  w_oper = " OI "
		       Else
                          z:=At("OI",w_PROD)
                          If z != 0
     	                     w_oper = " OI "
			  Endif
	               Endif
		    Endif
                 Endif
	      Endif
	   Endif
	Endif
     Endif
  Endif
  Lin=lin+1
  Skip
 Enddo
 Comm
 Unlock
 W_delet = "n"
 If W_Oper <> Space(05)
    Go w_recno
    While !Eof() .and. CD_CODIOR = M_NOTA .AND. CD_DATAO = M_DATSI
     If Substr(CD_PROD,1,4) = "CHIP"
        w_PROD = TRIM(CD_PROD)
        z:= At("&W_Oper",w_PROD)
        If z != 0
           W_delet = "n"
        Else
           W_delet = "s"
	   Exit
	Endif
     Endif
     Skip
    Enddo
    If W_Delet = "s"
       Go w_recno
       While !Eof() .and. CD_CODIOR = M_NOTA .AND. CD_DATAO = M_DATSI
         wImei   = cd_imei
         wnSerie = cd_nSerie
         If Bloqreg(0)
            Delete
         Endif
         Comm
         Unlock
         If !Empty(wIMei)
            wStatImei:=ZeraOrcaImei(wImei,wnSerie,"I")          // funcoes.prg
         ElseIf !Empty(wnSerie)
            wStatImei:=ZeraOrcaImei(wImei,wnSerie,"N")
         Endif
         If !Empty(wIMei) .or. !Empty(wnSerie)
            If wStatImei = .f.
               Alert("Error ao Zerar Or‡amento no Imei ou Imei N„o Encontrado")
            Endif
            Sele 25
            Set Order to 1
         Endif
         Skip
       Enddo
       Alert("Seu Orcamento de Venda foi Recusado. Operadoras Diferentes !")
       Alert("Or‡amento Deletado !")
    Endif
 Endif
 Release w_delet,z,w_prod,w_oper,w_recno
 Keyb(chr(27))
 Return

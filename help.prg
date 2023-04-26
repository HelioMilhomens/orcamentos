*******************************************************
/*
   FILE NAME : HELP.PRG
   BY        : HELIO-SP
   DATE      : RUSSAS, 17 DE JANEIRO DE 1995
   DESC      : PROGRAMA DE "AJUDAS"
*/
********************************************************
#include "box.ch"
#include "migracao.ch"
#include "inkey.ch"
#include "dbedit.ch"

Procedure Help()

PARAMETERS PROG,LIN,VAR

IF PROG = 'HELP'
   RETURN
ENDIF
    HL=SAVESCREEN(23,00,23,78)
DO CASE
   CASE VAR = 'M_GRUPO'
        M_CORA = SETCOLOR()
        TELA100=SAVESCREEN(05,00,22,79)
        SELE 33
        SET ORDER TO 1
        SET FILTER TO
        GOTO TOP
        CLEAR GETS

        SETCOLOR(MENU)
        PRIV VETOR1[2],VETOR2[2]
        VETOR1[1]='G_GRUPO'
        VETOR1[2]='G_NOMEG'
        VETOR2[1]='Grupo '
        VETOR2[2]='Descri‡„o'
        SETCOLOR("n+/w")
        DBEDIT(14,02,21,30,VETOR1,,,VETOR2)
        KEYB(CHR(8))
        M_GRUPO=G_GRUPO
        REGX    = "S"
        SET FILTER TO
        GOTO TOP
        RELEASE VETOR1,VETOR2
        RESTSCREEN(05,00,22,79,TELA100)
        SETCOLOR(M_CORA)

   CASE VAR = 'M_SBGRUPO'
        M_CORA = SETCOLOR()
        TELA100=SAVESCREEN(05,00,22,79)
        SELE 34
        SET ORDER TO 1
        SET FILTER TO
        GOTO TOP
        CLEAR GETS

        SETCOLOR(MENU)
        PRIV VETOR1[3],VETOR2[3]
        VETOR1[1]='SB_GRUPO'
        VETOR1[2]='SB_NOMEG'
        VETOR1[3]='SB_GR'
        VETOR2[1]='Sub_Grupo '
        VETOR2[2]='Descri‡„o'
        VETOR2[3]='Grupo'

        SETCOLOR("n+/w")
        DBEDIT(14,02,21,40,VETOR1,,,VETOR2)
        KEYB(CHR(8))
        M_SBGRUPO=SB_GRUPO
        REGX    = "S"
        SET FILTER TO
        GOTO TOP
        RELEASE VETOR1,VETOR2
        RESTSCREEN(05,00,22,79,TELA100)
        SETCOLOR(M_CORA)
   CASE (PROG = "CONSULTA" .AND. VAR = 'M_CODX') .or. (PROG = "SMV09" .AND. VAR = 'WCODIGO') .or. PROG = "SMV09" .AND. VAR = "M_CO" 
        wCod := RETCODCDSIE()
        m_codx  = wCod
        m_co    = wCod
        wCodigo = alltrim(str(wCod))
   CASE VAR = "M_CLIEE" .OR. VAR = 'CODIX' .OR. VAR = "M_CLIE" .OR. VAR = "VAIL"
        LetraaLetra()
   CASE PROG = 'SMV06'
        M_CORA = SETCOLOR()
        TELA100=SAVESCREEN(05,00,22,79)
        SETCOLOR(C_CORGX)
        @ 05,00 clear to 20,78
        @ 05,00 to 20,78
        @ 12,00 SAY CHR(24)
        @ 15,00 SAY CHR(25)
        @ 20,30 SAY '<PgUp>Sobe'
        @ 20,52 SAY '<PgDn>Desce'
        @ 09,35 SAY 'Help Solicitado...'
        SELE 4
        SET ORDER TO 16
        SET FILTER TO
        GOTO TOP
        CLEAR GETS
        M_NOM=SPACE(20)
        @ 13,25 SAY 'Cliente :'get M_NOM PICT "@!"
        READ
        SEEK TRIM(M_NOM)
        IF EOF()
           Alert("Final de Arquivo, Registro n„o Encontrado !")
           GOTO BOTT
        ENDIF
        SETCOLOR(MENU)
        PRIV VETOR1[10],VETOR2[10]
        VETOR1[1]='SD_NOMECL'
        VETOR1[2]='SD_ENDE'
        VETOR1[3]='SD_BAIR'
        VETOR1[4]='SD_FONE'
        VETOR1[5]='SD_NOTA'
        VETOR1[6]='SD_SERI'
        VETOR1[7]='SD_DATA'
        VETOR1[8]='SD_CODI'
        VETOR1[9]='SD_PROD'
        VETOR1[10]='SD_NOME'
        VETOR2[1]='Nome do Cliente'
        VETOR2[2]='Endere‡o do Cliente'
        VETOR2[3]='Bairro'
        VETOR2[4]='Telefone'
        VETOR2[5]='Minuta'
        VETOR2[6]='S‚rie'
        VETOR2[7]='Data da Compra'
        VETOR2[8]='C¢digo '
        VETOR2[9]='Descri‡„o da Mercadoria'
        VETOR2[10]='Vendedor'
        SETCOLOR("W+/BG+, B/RG,X")
        DBEDIT(06,01,19,77,VETOR1,,,VETOR2)
        KEYB(CHR(8))
        M_NOTA  = SD_NOTA
        M_SERI  = SD_SERI
        REGX    = "S"
        RELEASE VETOR1,VETOR2
        RESTSCREEN(05,00,22,79,TELA100)

        SETCOLOR(M_CORA)
   CASE prog <> "achoice" .and. (PROG = "SMV09_CO" .OR. PROG = "GRCAD" .OR. VAR = "M_NOTA" .OR. VAR = "M_NOME")
        M_CORA = SETCOLOR()
        TELA100=SAVESCREEN(05,00,22,79)
        IF VAR = "M_NOME"
           @ 10,20 clear to 22,77
           Sombra(13,20,16,60,box)
           @ 14,22 prom " Nome  "
           @ 15,22 prom " C.P.F "
           Menu to M_orcf
           If Lastkey()=27
              Return
           Endif
           wEsc = 0
           If M_Orcf = 1
              Clear Gets
              M_NOM=SPACE(30)
              @ 14,28 get M_NOM PICT "@!"
              Read
              If LastKey() = 27
                 Sele 25
                 SET ORDER TO 2
                 Go Bott
              EndIf
              Sele 25
              SET ORDER TO 2
              SET FILTER TO
              GO TOP
              Seek TRIM(M_NOM)
              IF Eof()
                 Sele 1
                 SET ORDER TO 2
                 SET FILTER TO
                 GO TOP
                 Seek TRIM(M_NOM)
                 If !Eof()
                    wEsc=1
                 Else
                    Alert("Cliente Nao Encontrado !")
                    Return
                 Endif
              Else
                 wEsc=0
              Endif
           Else
              Clear Gets
              M_NOM=SPACE(14)
              @ 15,30 get M_NOM PICT "999.999.999-99"
              READ
              If LastKey() = 27
                 Sele 25
                 SET ORDER TO 3
                 Goto Bott
              EndIf
              acpf := Ret_Num(M_Nom)
              Ver_Cpf(acpf)
              If Res_Cpf = "EOF"
                 wCpfError  = .t.
                 wReg       = "n"
                 M_PASSOUCL = 1
                 Return
              Endif
              Sele 25
              SET ORDER TO 3
              SET FILTER TO
              GO TOP
              Seek TRIM(M_NOM)
              IF Eof()
                 Sele 1
                 Set order to 4      && Procura por CPF
                 SET FILTER TO
                 GO TOP
                 Seek TRIM(M_NOM)
                 If !Eof()
                    wEsc=1
                 Else
                    Alert("CPF Nao Encontrado !")
                    Return
                 Endif
              Else
                 wEsc=0
              Endif
           EndIf
        Else
           SELE 25
           SET ORDER TO 1
           GO BOTT
           Clear Gets
           wEsc = 0
        Endif
        SETCOLOR(C_CORGX)
        @ 05,00 clear to 20,78
        @ 05,00 to 20,78
        @ 12,00 SAY CHR(24)
        @ 15,00 SAY CHR(25)
        @ 20,30 SAY '<PgUp>Sobe'
        @ 20,52 SAY '<PgDn>Desce'
        @ 09,35 SAY 'Help Solicitado...'
        If wEsc=1
           SETCOLOR(MENU)
           PRIV VETOR1[9],VETOR2[9]
           VETOR1[1] ='CL_NOME'
           VETOR1[2] ='CL_CODI'
           VETOR1[3] ='CL_CPF'
           VETOR1[4] ='CL_ENDE'
           VETOR1[5] ='CL_CIDA'
           VETOR1[6] ='CL_BAIR'
           VETOR1[7] ='CL_CEP'
           VETOR1[8] ='CL_UF'
           VETOR1[9] ='CL_FON1'

           VETOR2[1] ='Nome do Cliente'
           VETOR2[2] ='C¢digo'
           VETOR2[3] ='C.P.F.'
           VETOR2[4] ='Endere‡o do Cliente'
           VETOR2[5] ='Cidade'
           VETOR2[6] ='Bairro'
           VETOR2[7] ='C.E.P.'
           VETOR2[8] ='U.F.'
           VETOR2[9] ='Tel Fixo'
           SETCOLOR("W+/BG+, B/RG,X")
           DBEDIT(06,01,19,77,VETOR1,,,VETOR2)
           KEYB(CHR(8))
           M_NOME  =CL_NOME
           ENDEX   =CL_ENDE
           M_BAICL =CL_BAIR
           M_CIDACL=CL_CIDA
           M_CEPCL =CL_CEP
           FON1X   =CL_FON1
           FONECEL =Space(11)
           If !Empty(CL_OI)
              FONECEL = CL_OI
           ElseIf !Empty(CL_TIM)
              FONECEL = CL_TIM
           ElseIf !Empty(CL_CLARO)
              FONECEL = CL_CLARO
           ElseIf !Empty(CL_VIVO)
              FONECEL = CL_VIVO
           Endif
           M_UFCL  =CL_UF
           CPFX    =CL_CPF
           CGCX    =CL_CGC
           M_CGF   =CL_INSC
           M_RG    =CL_RG
           M_REFER =CL_LOCE
           M_CLIE  =CL_CODI
           M_NUMERO=CL_NUMERO
           M_COMPLE=CL_COMPLE
           M_REFER2=SPACE(60)
           M_OBSER =SPACE(40)
           M_SAIDA =SPACE(18)
           M_ORCA  =0
           M_NOTA  =0
           wHelp   ="S"
        Else
           SETCOLOR(MENU)
           PRIV VETOR1[17],VETOR2[17]
           VETOR1[1] ='CD_CODIOR'
           VETOR1[2] ='CD_NOMECL'
           VETOR1[3] ='CD_TIPOV'
           VETOR1[4] ='CD_CODICL'
           VETOR1[5] ='CD_ENDE'
           VETOR1[6] ='CD_BAIR'
           VETOR1[7] ='CD_CIDA'
           VETOR1[8] ='CD_CEP'
           VETOR1[9] ='CD_FIXO'
           VETOR1[10]='CD_FONE'
           VETOR1[11]='CD_CPF'
           VETOR1[12]='CD_CGC'
	   VETOR1[13]='CD_DATAO'
	   VETOR1[14]='CD_CODI'
	   VETOR1[15]='CD_PROD'
	   VETOR1[16]='CD_VENDED'
	   VETOR1[17]='CD_SAIDA'

           VETOR2[1] ='Or‡to '
           VETOR2[2] ='Nome do Cliente'
           VETOR2[3] ='TP'
           VETOR2[4] ='Cod_Cli'
           VETOR2[5] ='Endere‡o do Cliente'
           VETOR2[6] ='Bairro'
           VETOR2[7] ='Cidade'
           VETOR2[8] ='CEP.'
           VETOR2[9] ='Tel fixo'
           VETOR2[10]='Tel Cel'
           VETOR2[11]='C.P.F. '
           VETOR2[12]='C.G.C'
           VETOR2[13]='DATA ORCTO'
           VETOR2[14]='CODIGO PROD'
           VETOR2[15]='DESCRI€AO DO PRODUTO'
           VETOR2[16]='VENDEDOR'
           VETOR2[17]='SAIDA'
           SETCOLOR("W+/BG+, B/RG,X")
           DBEDIT(06,01,19,77,VETOR1,,,VETOR2)
           M_NOME   =CD_NOMECL
           ENDEX    =CD_ENDE
           M_BAICL  =CD_BAIR
           M_CIDACL =CD_CIDA
           M_CEPCL  =CD_CEP
           FON1X    =CD_FIXO
           FONECEL  =CD_FONE
	   M_UFCL   =CD_UF
	   CPFX     =CD_CPF
	   CGCX     =CD_CGC
	   M_CGF    =CD_CGF
	   M_RG     =CD_RG
	   M_REFER  =CD_REFER
	   M_REFER2 =CD_REFER2
           M_OBSER  =CD_OBSER
	   M_SAIDA  =CD_SAIDA
           M_ORCA   =CD_CODIOR
           M_NOTA   =CD_CODIOR
           M_CLIE   =CD_CODICL
           M_NUMERO =CD_NUMERO
           M_COMPLE =CD_COMPLE
           M_NUMEROT=CD_NUMEROT
           M_COMPLET=CD_COMPLET
           wHelp   ="S"
        Endif
        REGX = "S"
        RELEASE VETOR1,VETOR2
        RESTSCREEN(05,00,22,79,TELA100)
        SETCOLOR(M_CORA)
        If !Empty(M_NOME)
           Keyb(chr(13))
        Endif
        Return
   CASE PROG = 'CAD_CID'
        M_CORA = SETCOLOR()
        TELA100=SAVESCREEN(05,00,22,79)
        TONE(900,1)
        SETCOLOR(C_CORGX)
        @ 05,00 clear to 20,78
        @ 05,00 to 20,78
        @ 12,00 SAY CHR(24)
        @ 15,00 SAY CHR(25)
        @ 20,30 SAY '<PgUp>Sobe'
        @ 20,52 SAY '<PgDn>Desce'
        @ 09,35 SAY 'Help Solicitado...'
        SELE 27
        SET FILTER TO
        GOTO TOP
        CLEAR GETS
        Set Cursor On
        M_NOM=SPACE(27)
        @ 13,25 SAY 'Bairro :'get M_NOM pict "@!"
        READ
        LOCATE FOR ALLTRIM(M_NOM)$CD_BAIRRO
        IF EOF()
           Alert('Final de Arquivo, Registro n„o Encontrado')
           GOTO BOTT
        ENDIF
        SETCOLOR("W+/BG+, B/RG,X")
        PRIV VETOR1[5],VETOR2[5]
        VETOR1[1] ='CD_CIDADE'
        VETOR1[2] ='CD_BAIRRO'
        VETOR1[3] ='CD_UF'
        VETOR1[4] ='CD_ZONA'
        VETOR1[5] ='CD_VALOR'

        VETOR2[1]='Cidade'
        VETOR2[2]='Bairro'
        VETOR2[3]='UF'
        VETOR2[4]='Zona'
        VETOR2[5]='Valor do Frete'

        SETCOLOR("W+/BG+, B/RG,X")
        DBEDIT(07,02,21,77,VETOR1,,,VETOR2)
        RELEASE VETOR1,VETOR2
        RESTSCREEN(05,00,22,79,TELA100)
        Return(0)
   CASE VAR = "M_VEND" .OR. VAR = "M_VENDF" .OR. VAR = "M_BALC"
        Clear Gets
        M_CORA = SETCOLOR()
        TELA100=SAVESCREEN(9,29,22,74)
        TONE(900,1)
        SETCOLOR(C_CORG)
        SOMBRA(09,29,20,72,BOX)
        @ 12,29 SAY CHR(24)
        @ 15,29 SAY CHR(25)
        @ 20,35 SAY '<PgUp>Sobe'
        @ 20,52 SAY '<PgDn>Desce'
        @ 09,35 SAY 'Help Solicitado...'
        SELE 16
        SET ORDER TO 1
        SET FILTER TO
        GOTO TOP
	Set Cursor On
	m_nomev=space(15)
	@ 10,30 say "Vendedor " get m_nomev pict "@!"
	Read
	If !Empty(m_nomev)
	   While !eof()
	     If ba_nome=trim(m_nomev)
	        exit
             Endif
	     Skip
	   Enddo
	Endif

        SETCOLOR("W+/BG+, B/RG,X")
        PRIV VETOR1[3],VETOR2[3]
        VETOR1[1]='BA_CODI'
        VETOR1[2]='BA_NOME'
        VETOR1[3]='BA_CPF'
        VETOR2[1]='C¢digo'
        VETOR2[2]='Nome Vendedor'
        VETOR2[3]='CPF'
        DBEDIT(10,30,19,71,VETOR1,,,VETOR2)
        M_VEND = BA_CODI
        M_VENDF= BA_CODI
        M_BALC = BA_CODI
        RELEASE VETOR1,VETOR2
        RESTSCREEN(9,29,22,74,TELA100)
        SETCOLOR(M_CORA)
   CASE PROG= "SMV09" .OR. PROG="FICHAE" .OR. VAR = "M_CODX" .OR. VAR = "M_CODIG" .OR. VAR ="M_DESCRIC"
        LetraalP()
   OTHE
        TLDESC = SAVESCREEN(22,22,24,58)
        @ 22,22 TO 24,58
        @ 23,23 SAY 'Desculpe... n„o h  help dispon¡vel.'
        TONE(450,1)
        INKEY(2)
        RESTSCREEN(22,22,24,58,TLDESC)

ENDCASE
RETURN

PROCEDURE SCRCANC
*****************
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

//*************
  FUNC LETRAALP
//*************
 LOCAL ar_dbf:=ALIAS(), nCol:=20, nKey, v_tel_p, cor_ant:=SETCOLOR()
 v_tel_p:=SAVESCREEN(0,0,MAXROW(),79)
 nVar="000000"
 IF !EMPTY(ar_dbf)                        // sava situacao atual
    ultreg =RECNO()                       // registro e
    ord_ind=INDEXORD()                    // indice utilizado
 ENDI

 Sele 3
 Set Order to 2
 Go Top
 KEYBOARD CHR(27)

aColunas:={'CD_CODI','CD_PROD','CD_COR','CD_GRUP','CD_FORN','CD_AVISTA2','CD_NCM' }
SETCOLOR(C_CORG)
@ 03, 02, 21, 78 BOX "ÚÄ¿³ÙÄÀ³ "
@ 05,03 SAY REPLIC('Ä',75)
DBEDIT(6,3,20,77,aColunas)
@ 04, 05 SAY "Produto :"
@ 04, 20 SAY SPAC(40) COLOR "N/W"
nCol=20
@ 04, 20 SAY "" COLOR "N/W"
cNome=SPAC(00)
DO While .T.
 IF LASTKEY()=13
    IF !EMPTY(ar_dbf)
       SELE (ar_dbf)
       DBSETORDER(ord_ind)
       GO ultreg
    ENDI
    SETCOLOR(cor_ant)
    RESTSCREEN(0,0,MAXROW(),79,v_tel_p)
    KEYBOARD nVar
    RETURN (.t.)
 ELSE
    nKey=INKEY(0)
    IF nKey=27
       EXIT
    ENDIF
    IF nKey=13
       IF !EMPTY(ar_dbf)
          SELE (ar_dbf)
          DBSETORDER(ord_ind)
          GO ultreg
       ENDI
       SETCOLOR(cor_ant)
       RESTSCREEN(0,0,MAXROW(),79,v_tel_p)
       KEYBOARD nVar
       RETURN (.t.)
    ENDIF
 ENDIF
 IF nKey=8 .or. nKey=19
    nCol=nCol-1
    IF nCol < 20
       nCol=20
    ENDIF
    cNome=SUBS(cNome,1,LEN(cNome)-1)
    @ 04, 20 SAY cNome+"  " COLOR "N/W"
 ELSEIF (nKey>=32 .and. nKey<=165)
    nCol=nCol+1
    IF nCol>=50
       nCol=50
       cNome=SUBS(cNome,1,LEN(cNome)-1)
    ENDIF
    cNome=UPPER(cNome+CHR(nKey))
    @ 04,20 SAY cNome COLOR "N/W"
 ENDIF

 IF !PESQ_DBEDP(cNome)
    nCol=nCol - 1
    IF nCol <20
       nCol=20
    ENDIF
    cNome=SUBS(cNome,1,LEN(cNome)-1)
    @ 04,20 SAY cNome COLOR "N/W"
 ENDIF
 @ 04,20 SAY cNome COLOR "N/W"

ENDDO
IF !EMPTY(ar_dbf)
   SELE (ar_dbf)
   DBSETORDER(ord_ind)
   GO ultreg
ENDI
SETCOLOR(cor_ant)
RESTSCREEN(0,0,MAXROW(),79,v_tel_p)
Set Filter to
Go Top
RETURN

//*************
 FUNC PESQ_DBEDP(cNome)
//*************
IF DBSEEK(cNome,.T.)
   M_CODX   = CD_CODI
   M_CO     = CD_CODI
   P_SEEC   = CD_CODI
   M_CODIG  = CD_CODI
   M_DESCRIC= CD_PROD
   M_FABRX  = SUBSTR(CD_FABR,1,10)
   nVar     = CD_CODI
   IF LASTKEY() <> 5 .AND. LASTKEY() <> 24
      KEYBOARD CHR(27)
   ENDIF
   DBEDIT(6,3,20,77,aColunas,"CONTROLP")
ELSE
   RETURN (.F.)
ENDIF
RETURN (.T.)

FUNC CONTROLP(nMod)
Local nReturn := DE_CONT
Do Case
    CASE LastKey() == K_ESC
        nReturn := DE_ABORT
    CASE LastKey() == K_ENTER
        M_CODX   = CD_CODI
        M_CO     = CD_CODI
        P_SEEC   = CD_CODI
        M_CODIG  = CD_CODI
        M_DESCRIC= CD_PROD
        M_FABRX  = SUBSTR(CD_FABR,1,10)
        nVar     = CD_CODI
        nReturn := DE_ABORT
ENDCase
RETURN nReturn

******************
FUNC LETRAALETRA()
******************
 LOCAL ar_dbf:=ALIAS(), nCol:=20, nKey, v_tel_p, cor_ant:=SETCOLOR()
 v_tel_p:=SAVESCREEN(0,0,MAXROW(),79)
 nVar="0000"
 IF !EMPTY(ar_dbf)                       // sava situacao atual
    ultreg =RECNO()                       // registro e
    ord_ind=INDEXORD()                    // indice utilizado
 ENDI
 Sele 1
 Set Order to 2
 Goto top
 KEYBOARD CHR(27)

aColunas:={'CL_CODI','CL_NOME','CL_CPF','CL_ENDE','CL_CIDA','CL_BAIR'}
SETCOLOR("GR+/B")
@ 03, 02, 21, 78 BOX "ÚÄ¿³ÙÄÀ³ "
@ 05,03 SAY REPLIC('Ä',75)
DBEDIT(6,3,20,77,aColunas)
@ 04, 05 SAY "Digite o Nome:"
@ 04, 20 SAY SPAC(40) COLOR "N/W"
nCol=20
@ 04, 20 SAY "" COLOR "N/W"
cNome=SPAC(00)
DO WHILE .T.
 IF LASTKEY()=13
    IF !EMPTY(ar_dbf)
       SELE (ar_dbf)
       DBSETORDER(ord_ind)
       GO ultreg
    ENDI
    SETCOLOR(cor_ant)
    RESTSCREEN(0,0,MAXROW(),79,v_tel_p)
    KEYBOARD nVar
    RETURN (.t.)
 ELSE
    nKey=INKEY(0)
    IF nKey=27
       EXIT
    ENDIF
    IF nKey=13
       IF !EMPTY(ar_dbf)
          SELE (ar_dbf)
          DBSETORDER(ord_ind)
          GO ultreg
       ENDI
       SETCOLOR(cor_ant)
       RESTSCREEN(0,0,MAXROW(),79,v_tel_p)
       KEYBOARD nVar
       RETURN (.t.)
    ENDIF
 ENDIF
 IF nKey=8 .or. nKey=19
    nCol=nCol-1
    IF nCol < 20
       nCol=20
    ENDIF
    cNome=SUBS(cNome,1,LEN(cNome)-1)
    @ 04, 20 SAY cNome+"  " COLOR "N/W"
 ELSEIF (nKey>=32 .and. nKey<=165)
    nCol=nCol+1
    IF nCol>=50
       nCol=50
       cNome=SUBS(cNome,1,LEN(cNome)-1)
    ENDIF
    cNome=UPPER(cNome+CHR(nKey))
    @ 04,20 SAY cNome COLOR "N/W"
 ENDIF
 IF !PESQ_DBEDIT(cNome)
    nCol=nCol - 1
    IF nCol <20
       nCol=20
    ENDIF
    cNome=SUBS(cNome,1,LEN(cNome)-1)
    @ 04,20 SAY cNome COLOR "N/W"
 ENDIF
 @ 04,20 SAY cNome COLOR "N/W"
ENDDO
IF !EMPTY(ar_dbf)
   SELE (ar_dbf)
   DBSETORDER(ord_ind)
   GO ultreg
ENDI
SETCOLOR(cor_ant)
RESTSCREEN(0,0,MAXROW(),79,v_tel_p)
RETURN

FUNC PESQ_DBEDIT(cNome)
IF DBSEEK(cNome,.T.)
           nVar=  cl_codi
           codix= cl_codi
        M_CLIEE = CL_CODI
        M_CLIE  = CL_CODI
        CODIX   = CL_CODI
        VAIL    = CL_CODI
        M_NOMCL = CL_NOME
        ENDEF   = CL_ENDE
        BAIRF   = CL_BAIR
        CEPF    = CL_CEP
        MUNF    = CL_CIDA
        UFF     = CL_UF
        CGCF    = CL_CGC
        CPF     = CL_CPF

 IF LASTKEY() <> 5 .AND. LASTKEY() <> 24
    KEYBOARD CHR(27)
 ENDIF
 DBEDIT(6,3,20,77,aColunas,"CONTROLE")
ELSE
 RETURN (.F.)
ENDIF
RETURN (.T.)

FUNC CONTROLE(nMod)
Local nReturn := DE_CONT
Do Case
    CASE LastKey() == K_ESC
         nReturn := DE_ABORT
    CASE LastKey() == K_ENTER
           nVar =  cl_codi
           codix= cl_codi
        M_CLIEE = CL_CODI
        M_CLIE  = CL_CODI
        CODIX   = CL_CODI
        VAIL    = CL_CODI
        M_NOMCL = CL_NOME
        ENDEF   = CL_ENDE
        BAIRF   = CL_BAIR
        CEPF    = CL_CEP
        MUNF    = CL_CIDA
        UFF     = CL_UF
        CGCF    = CL_CGC
        CPF     = CL_CPF
        nReturn := DE_ABORT
EndCase
RETURN nReturn

//*************
  FUNC LETRASUB()
//*************
 LOCAL ar_dbf:=ALIAS(), nCol:=20, nKey, v_tel_p, cor_ant:=SETCOLOR()
 v_tel_p:=SAVESCREEN(0,0,MAXROW(),79)
 nVar="000000"
 IF !EMPTY(ar_dbf)                       // sava situacao atual
    ultreg =RECNO()                       // registro e
    ord_ind=INDEXORD()                    // indice utilizado
 ENDI
 Sele 43
 Set Order to 2
 Go top
 KEYBOARD CHR(27)

aColunas:={'GR_CODI','GR_NOME' }
SETCOLOR("GR+/B")
@ 03, 02, 21, 78 BOX "ÚÄ¿³ÙÄÀ³ "
@ 05,03 SAY REPLIC('Ä',75)
DBEDIT(6,3,20,77,aColunas)
@ 04, 05 SAY "Sub_Grupo :"
@ 04, 20 SAY SPAC(40) COLOR "N/W"
nCol=20
@ 04, 20 SAY "" COLOR "N/W"
cNome=SPAC(00)
DO WHILE .T.
 IF LASTKEY()=13
    IF !EMPTY(ar_dbf)
       SELE (ar_dbf)
       DBSETORDER(ord_ind)
       GO ultreg
    ENDI
    SETCOLOR(cor_ant)
    RESTSCREEN(0,0,MAXROW(),79,v_tel_p)
    KEYBOARD nVar
    RETURN (.t.)
 ELSE
  nKey=INKEY(0)
  IF nKey=27
     EXIT
  ENDIF
  IF nKey=13
     IF !EMPTY(ar_dbf)
        SELE (ar_dbf)
        DBSETORDER(ord_ind)
        GO ultreg
     ENDI
     SETCOLOR(cor_ant)
     RESTSCREEN(0,0,MAXROW(),79,v_tel_p)
     KEYBOARD nVar
     RETURN (.t.)
  ENDIF
 ENDIF
 IF nKey=8 .or. nKey=19
    nCol=nCol-1
    IF nCol < 20
       nCol=20
    ENDIF
    cNome=SUBS(cNome,1,LEN(cNome)-1)
    @ 04, 20 SAY cNome+"  " COLOR "N/W"
 ELSEIF (nKey>=32 .and. nKey<=165)
    nCol=nCol+1
    IF nCol>=50
       nCol=50
       cNome=SUBS(cNome,1,LEN(cNome)-1)
    ENDIF
    cNome=UPPER(cNome+CHR(nKey))
    @ 04,20 SAY cNome COLOR "N/W"
 ENDIF
 IF !PESQ_DBESUB(cNome)
    nCol=nCol - 1
    IF nCol <20
       nCol=20
    ENDIF
    cNome=SUBS(cNome,1,LEN(cNome)-1)
    @ 04,20 SAY cNome COLOR "N/W"
 ENDIF
 @ 04,20 SAY cNome COLOR "N/W"
ENDDO
IF !EMPTY(ar_dbf)
   SELE (ar_dbf)
   DBSETORDER(ord_ind)
   GO ultreg
ENDI
SETCOLOR(cor_ant)
RESTSCREEN(0,0,MAXROW(),79,v_tel_p)
RETURN

FUNC PESQ_DBESUB(cNome)
IF DBSEEK(cNome,.T.)
   M_CODX = GR_CODI
   nVar   = GR_CODI

   IF LASTKEY() <> 5 .AND. LASTKEY() <> 24
      KEYBOARD CHR(27)
   ENDIF
   DBEDIT(6,3,20,77,aColunas,"CONTROLSB")
ELSE
   RETURN (.F.)
ENDIF
RETURN (.T.)

FUNC CONTROlSB(nMod)
Local nReturn := DE_CONT
Do Case
    CASE LastKey() == K_ESC
        nReturn := DE_ABORT
    CASE LastKey() == K_ENTER

    M_CODX = GR_CODI
    nVar   = GR_CODI
    busca_sub(nVar)

    Sele 3
    Set Order to 1
    M_CODX = CD_CODI
    nVar  = CD_CODI
   nReturn := DE_ABORT
EndCase
Return nReturn

//**************
  FUNC BUSCA_SUB(nVar)
//**************
 LOCAL ar_dbf:=ALIAS(), nCol:=20, nKey, v_tel_p, cor_ant:=SETCOLOR()
 v_tel_p:=SAVESCREEN(0,0,MAXROW(),79)
 IF !EMPTY(ar_dbf)                       // sava situacao atual
    ultreg =RECNO()                       // registro e
    ord_ind=INDEXORD()                    // indice utilizado
 ENDI
 Sele 3
 Set Order to 12
 Seek str(nVar,3,0)
 *KEYBOARD CHR(13)
aColunas:={'CD_CODI','CD_PROD','CD_COR','CD_GRUP','CD_FORN','CD_AVISTA2','CD_NCM' }
SETCOLOR("GR+/B")
@ 03, 02, 21, 78 BOX "ÚÄ¿³ÙÄÀ³ "
@ 05,03 SAY REPLIC('Ä',75)
DBEDIT(6,3,20,77,aColunas)
*@ 04, 05 SAY "Sub_Grupo :"
*@ 04, 20 SAY SPAC(40) COLOR "N/W"
nCol=20
@ 04, 20 SAY "" COLOR "N/W"
cNome=SPAC(00)
DO WHILE .T.
 IF LASTKEY()=13
    IF !EMPTY(ar_dbf)
       SELE (ar_dbf)
       DBSETORDER(ord_ind)
       GO ultreg
    ENDI
    SETCOLOR(cor_ant)
    RESTSCREEN(0,0,MAXROW(),79,v_tel_p)
    KEYBOARD nVar
    RETURN (.t.)
 ELSE
  nKey=INKEY(0)
  IF nKey=27
     EXIT
  ENDIF
  IF nKey=13
     IF !EMPTY(ar_dbf)
        SELE (ar_dbf)
        DBSETORDER(ord_ind)
        GO ultreg
     ENDI
     SETCOLOR(cor_ant)
     RESTSCREEN(0,0,MAXROW(),79,v_tel_p)
     KEYBOARD nVar
     RETURN (.t.)
  ENDIF
 ENDIF
 IF !PESQ_BUSCA()
    nCol=nCol - 1
    IF nCol <20
       nCol=20
    ENDIF
 ENDIF
ENDDO
IF !EMPTY(ar_dbf)
   SELE (ar_dbf)
   DBSETORDER(ord_ind)
   GO ultreg
ENDI
SETCOLOR(cor_ant)
RESTSCREEN(0,0,MAXROW(),79,v_tel_p)
RETURN

FUNC PESQ_BUSCA()
        M_CODX   = CD_CODI
        M_CO     = CD_CODI
        P_SEEC   = CD_CODI
        M_CODIG  = CD_CODI
        M_DESCRIC= CD_PROD
        M_FABRX  = SUBSTR(CD_FABR,1,10)
	nVar     = CD_CODI

 IF LASTKEY() <> 5 .AND. LASTKEY() <> 24
    KEYBOARD CHR(27)
 ENDIF
 DBEDIT(6,3,20,77,aColunas,"CONTBUSCA")
RETURN (.T.)

FUNC CONTBUSCA(nMod)
Local nReturn := DE_CONT
Do Case
    CASE LastKey() == K_ESC
        nReturn := DE_ABORT
    CASE LastKey() == K_ENTER
        M_CODX   = CD_CODI
        M_CO     = CD_CODI
        P_SEEC   = CD_CODI
        M_CODIG  = CD_CODI
        M_DESCRIC= CD_PROD
        M_FABRX  = SUBSTR(CD_FABR,1,10)
	    nVar     = CD_CODI
        nReturn := DE_ABORT
ENDCase
RETURN nReturn

//*****************
  Procedure grafset        // Grafico de Vendas de Vendedores por setor
//*****************
sst=savescreen(00,00,24,78)
Set color to w/w
    @ 00,00 clear to 24,80
Set color to n/w
    @ 01,00,24,79 BOX B_SINGLE
Set color to W+/W
    @ 01,00 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    @ 02,00 Say "³"
    @ 03,00 Say "³"
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
    @ 24,01 clear to 24,80
    @ 02,10 to 24,10
    @ 02,10 say chr(194)
    @ 23,13 to 23,15
    @ 23,10 to 23,77
    @ 23,10 say chr(197)

    ssv=savescreen(08,38,16,75)
    Set color to N/W
    @ 08,40,14,62 BOX B_SINGLE
      Set color to W+/W
    @ 08,40 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    @ 09,40 Say "³"
    @ 10,40 Say "³"
    @ 11,40 Say "³"
    @ 12,40 Say "³"
    @ 13,40 Say "³"
    @ 14,40 Say "À"

   Set color to B/W
   @ 09,42 Say " Conectiva Linux  "
   @ 10,41 Say "Gr fico Demonstrativo"

   Set color to n/w
   @ 23,78 say chr(16)

   Set color to gr+/w
*aki
    @ 02,01 Say " 315.000"
    @ 03,01 Say " 300.000"
    @ 04,01 Say " 285.000"
    @ 05,01 Say " 270.000"
    @ 06,01 Say " 255.000"
    @ 07,01 Say " 240.000"
    @ 08,01 Say " 225.000"
    @ 09,01 Say " 210.000"
    @ 10,01 Say " 195.000"
    @ 11,01 Say " 180.000"
    @ 12,01 Say " 165.000"
    @ 13,01 Say " 150.000"
    @ 14,01 Say " 135.000"
    @ 15,01 Say " 120.000"
    @ 16,01 Say " 105.000"
    @ 17,01 Say "  90.000"
    @ 18,01 Say "  75.000"
    @ 19,01 Say "  60.000"
    @ 20,01 Say "  45.000"
    @ 21,01 Say "  30.000"
    @ 22,01 Say "  15.000"
    @ 23,01 Say "   0.000"

    @ 24,67 Say "Vendedores"
    Set color to w+/w

    @ 03,10 Say chr(180)
    @ 04,10 Say chr(180)
    @ 05,10 Say chr(180)
    @ 06,10 Say chr(180)
    @ 07,10 Say chr(180)
    @ 08,10 Say chr(180)
    @ 09,10 Say chr(180)
    @ 10,10 Say chr(180)
    @ 11,10 Say chr(180)
    @ 12,10 Say chr(180)
    @ 13,10 Say chr(180)
    @ 14,10 Say chr(180)
    @ 15,10 Say chr(180)
    @ 16,10 Say chr(180)
    @ 17,10 Say chr(180)
    @ 18,10 Say chr(180)
    @ 19,10 Say chr(180)
    @ 20,10 Say chr(180)
    @ 21,10 Say chr(180)
    @ 22,10 Say chr(180)

    @ 23,14 say chr(194)
    @ 23,17 say chr(194)
    @ 23,20 say chr(194)
    @ 23,23 say chr(194)
    @ 23,26 say chr(194)
    @ 23,29 say chr(194)
    @ 23,32 say chr(194)
    @ 23,35 say chr(194)
    @ 23,38 say chr(194)
    @ 23,41 say chr(194)
    @ 23,44 say chr(194)
    @ 23,47 say chr(194)
    @ 23,50 say chr(194)
    @ 23,53 say chr(194)
    @ 23,56 say chr(194)
    @ 23,59 say chr(194)
    @ 23,62 say chr(194)
    @ 23,65 say chr(194)
    @ 23,68 say chr(194)
    @ 23,71 say chr(194)
    @ 23,74 say chr(194)

    ANO=SUBSTR(dtoc(m_datsi),7,4)
    m_vend=0
    COR=SETCOLOR()
    SETCOLOR("B/W")
    @ 11,41 SAY "Defina o Ano"
    @ 12,41 SAY 'ANO'GET ANO PICT "9999"
      Read
      x=month(m_datsi)
    SETCOLOR("B+/W, W+/B")
    @ 13,41 SAY 'MES'
    @ 13,55 SAY CHR(24)+""+CHR(25)
    @ 13,45 PROM "Janeiro  "
    @ 13,45 PROM "Fevereiro"
    @ 13,45 PROM "Mar‡o    "
    @ 13,45 PROM "Abril    "
    @ 13,45 PROM "Maio     "
    @ 13,45 PROM "Junho    "
    @ 13,45 PROM "Julho    "
    @ 13,45 PROM "Agosto   "
    @ 13,45 PROM "Setembro "
    @ 13,45 PROM "Outubro  "
    @ 13,45 PROM "Novembro "
    @ 13,45 PROM "Dezembro "
      Menu to m_m
    SetColor(Cor)
   IF LASTKEY() = 27
       restscreen(,,,,sst)
       Return
   ENDIF
    SetColor(Cor)
   IF LASTKEY() = 27
       restscreen(,,,,sst)
       Return
   ENDIF
    SETCOLOR("B+/W, W+/B")
    @ 11,55 PROM "M¢veis "
    @ 12,55 PROM "Celular"
    @ 13,55 PROM "Eletros"
      Menu to m_ven
       If m_ven = 1
          m_set ="MOV"
       ElseIf m_ven = 2
          m_set ="CEL"
       Else
          m_set ="ELE"
       Endif

    SetColor(Cor)
   IF LASTKEY() = 27
       restscreen(,,,,sst)
       Return
   ENDIF

    SetColor(Cor)
   IF LASTKEY() = 27
       restscreen(,,,,sst)
       Return
   ENDIF

     Set color to n/w
     @ 00,00 Say "                 Gr fico Demonstrativo de Vendas Vendedor p/ Depto/Setor "

Stor 0 to m_l01,m_l02,m_l03,m_l04,m_l05,m_l06,m_l07,m_l08,m_l09,m_l10,m_l11,m_l12,m_l13,m_l14,m_l15,m_l16,m_l17,m_l18,m_l19,m_l20,m_l21
Stor 23 to m_col1,m_col2,m_col3,m_col4,m_col5,m_col6,m_col7,m_col8,m_col9,m_col10,m_col11,m_col12,m_col13,m_col14
Stor 23 to m_col15,m_col16,m_col17,m_col18,m_col19,m_col20,m_col21

Cor=SetColor()
setcolor( "W/GR+" )
@ 16,40 clear to 16,50
SetColor(cor)
Col=39

     IF m_m = 1
       M_DT1=CTOD("01/01/&ANO")
       M_DT2=CTOD("31/01/&ANO")
       M_MES="JANEIRO/&ANO"
     ELSEIF m_m=2
       M_DT1=CTOD("01/02/&ANO")
       If year(m_dt1) = 2012 .or. year(m_dt1) = 2016.or. year(m_dt1) = 2020
        M_DT2=CTOD("29/02/&ANO")
       Else
        M_DT2=CTOD("28/02/&ANO")
       Endif
       M_MES="FEVEREIRO/&ANO"
     ELSEIF m_m=3
       M_DT1=CTOD("01/03/&ANO")
       M_DT2=CTOD("31/03/&ANO")
       M_MES="MARCO/&ANO    "
     ELSEIF m_m=4
       M_DT1=CTOD("01/04/&ANO")
       M_DT2=CTOD("30/04/&ANO")
       M_MES="ABRIL/&ANO    "
     ELSEIF m_m=5
       M_DT1=CTOD("01/05/&ANO")
       M_DT2=CTOD("31/05/&ANO")
       M_MES="MAIO/&ANO    "
     ELSEIF m_m=6
       M_DT1=CTOD("01/06/&ANO")
       M_DT2=CTOD("30/06/&ANO")
       M_MES="JUNHO/&ANO    "
     ELSEIF m_m=7
       M_DT1=CTOD("01/07/&ANO")
       M_DT2=CTOD("31/07/&ANO")
       M_MES="JULHO/&ANO    "
     ELSEIF m_m=8
       M_DT1=CTOD("01/08/&ANO")
       M_DT2=CTOD("31/08/&ANO")
       M_MES="AGOSTO/&ANO  "
     ELSEIF m_m=9
       M_DT1=CTOD("01/09/&ANO")
       M_DT2=CTOD("30/09/&ANO")
       M_MES="SETEMBRO/&ANO  "
     ELSEIF m_m=10
       M_DT1=CTOD("01/10/&ANO")
       M_DT2=CTOD("31/10/&ANO")
       M_MES="OUTUBRO/&ANO  "
     ELSEIF m_m=11
       M_DT1=CTOD("01/11/&ANO")
       M_DT2=CTOD("30/11/&ANO")
       M_MES="NOVEMBRO/&ANO  "
     ELSEIF m_m=12
       M_DT1=CTOD("01/12/&ANO")
       M_DT2=CTOD("31/12/&ANO")
       M_MES="DEZEMBRO/&ANO  "
     ENDIF
       m_dat=m_dt1

     @ 15,40 SAY M_MES

  Sele 16
  Set order to 1
  goto top
  m_vend=ba_codi
  goto bott
  m_vendf=ba_codi
  goto top
  x=1
  Stor space(01) to m_nomv,m_nome1,m_nome2,m_nome3,m_nome4,m_nome5,m_nome6,m_nome7,m_nome8,m_nome9,m_nome10,m_nome11,m_nome12,m_nome13,m_nome14
  Stor space(01) to m_nome15,m_nome16,m_nome17,m_nome18,m_nome19,m_nome20,m_nome21
  Stor 0 to m_cd1,m_cd2,m_cd3,m_cd4,m_cd5,m_cd6,m_cd7,m_cd8,m_cd9,m_cd10,m_cd11,m_cd12,m_cd13,m_cd14,m_cd15,m_cd16,m_cd17,m_cd18,m_cd19,m_cd20,m_cd21

 While m_vend <= m_vendf
       seek str(m_vend,3,0)
       m_pass="n"
       If !eof()
             m_nomv = ba_nome
          If ba_ativ="S" .and. substr(ba_setor,1,3) = m_set
             m_pass="s"
	  Endif
      Endif

 If m_pass = "s"
         SELE 4
         SET ORDER TO 5
         GOTO TOP
         STOR 0 TO M_V
	 m_dt1=m_dat
         TONE(200,1)
         WHILE .T.
          SEEK STR(M_VEND,3,0)+SUBSTR(DTOC(M_DT1),7,4)+SUBSTR(DTOC(M_DT1),4,2)+SUBSTR(DTOC(M_DT1),1,2)
               IF EOF()
                  M_DT1=M_DT1+1
                  IF M_DT1 >M_DT2
                       EXIT
                  ENDIF
               ELSE
                  EXIT
               ENDIF
          ENDDO
          WHILE !EOF() .AND. SD_VEND=M_VEND .AND. SD_DATA<=M_DT2
              M_V  = M_V + (SD_QTDE * SD_PREC)    && QUANTIDADE x UNITARIO VENDA
              SKIP
          ENDDO
   If x=1
      m_l01=round(m_v,0)
      m_nome1=m_nomv
      m_cd1  =strzero(m_vend,2)
   ElseIf x=2
      m_l02=round(m_v,0)
      m_nome2=m_nomv
      m_cd2  =strzero(m_vend,2)
   ElseIf x=3
      m_l03=round(m_v,0)
      m_nome3=m_nomv
      m_cd3  =strzero(m_vend,2)
   ElseIf x=4
      m_l04=round(m_v,0)
      m_nome4=m_nomv
      m_cd4  =strzero(m_vend,2)
   ElseIf x=5
      m_l05=round(m_v,0)
      m_nome5=m_nomv
      m_cd5  =strzero(m_vend,2)
   ElseIf x=6
      m_l06=round(m_v,0)
      m_nome6=m_nomv
      m_cd6  =strzero(m_vend,2)
   ElseIf x=7
      m_l07=round(m_v,0)
      m_nome7=m_nomv
      m_cd7  =strzero(m_vend,2)
   ElseIf x=8
      m_l08=round(m_v,0)
      m_nome8=m_nomv
      m_cd8  =strzero(m_vend,2)
   ElseIf x=9
      m_l09=round(m_v,0)
      m_nome9=m_nomv
      m_cd9  =strzero(m_vend,2)
   ElseIf x=10
      m_l10=round(m_v,0)
      m_nome10=m_nomv
      m_cd10 =strzero(m_vend,2)
   ElseIf x=11
      m_l11=round(m_v,0)
      m_nome11=m_nomv
      m_cd11 =strzero(m_vend,2)
   ElseIf x=12
      m_l12=round(m_v,0)
      m_nome12=m_nomv
      m_cd12 =strzero(m_vend,2)
   ElseIf x=13
      m_l13=round(m_v,0)
      m_nome13=m_nomv
      m_cd13 =strzero(m_vend,2)
   ElseIf x=14
      m_l14=round(m_v,0)
      m_nome14=m_nomv
      m_cd14 =strzero(m_vend,2)
   ElseIf x=15
      m_l15=round(m_v,0)
      m_nome15=m_nomv
      m_cd15 =strzero(m_vend,2)
   ElseIf x=16
      m_l16=round(m_v,0)
      m_nome16=m_nomv
      m_cd16 =strzero(m_vend,2)
   ElseIf x=17
      m_l17=round(m_v,0)
      m_nome17=m_nomv
      m_cd17 =strzero(m_vend,2)
   ElseIf x=18
      m_l18=round(m_v,0)
      m_nome18=m_nomv
      m_cd18 =strzero(m_vend,2)
   ElseIf x=19
      m_l19=round(m_v,0)
      m_nome19=m_nomv
      m_cd19 =strzero(m_vend,2)
   ElseIf x=20
      m_l20=round(m_v,0)
      m_nome20=m_nomv
      m_cd20 =strzero(m_vend,2)
   ElseIf x=21
      m_l21=round(m_v,0)
      m_nome21=m_nomv
      m_cd21 =strzero(m_vend,2)
   Endif
    Cor=Setcolor()
    setcolor( "GR+/W" )
    col=col+1
  @ 16,col say chr(219)
    SetColor(Cor)
    X++
 Endif
    Sele 16
    Set order to 1
    m_vend++
ENDDO

 restscreen(08,38,16,75,ssv)

If m_l01 >0 .and. m_l01 <15000
   m_col1 =23
ElseIf m_l01 >=15000 .and. m_l01 <30000
   m_col1 =22
ElseIf m_l01 >=30000 .and. m_l01 <45000
   m_col1 =21
ElseIf m_l01 >=45000 .and. m_l01 <60000
   m_col1 =20
ElseIf m_l01 >=60000 .and. m_l01 <75000
   m_col1 =19
ElseIf m_l01 >=75000 .and. m_l01 <90000
   m_col1 =18
ElseIf m_l01 >=90000 .and. m_l01<105000
   m_col1 =17
ElseIf m_l01 >=105000 .and. m_l01<120000
   m_col1 =16
ElseIf m_l01 >=120000 .and. m_l01<135000
   m_col1 =15
ElseIf m_l01 >=135000 .and. m_l01<150000
   m_col1 =14
ElseIf m_l01 >=150000 .and. m_l01<165000
   m_col1 =13
ElseIf m_l01 >=165000 .and. m_l01<180000
   m_col1 =12
ElseIf m_l01 >=180000 .and. m_l01<195000
   m_col1 =11
ElseIf m_l01 >=195000 .and. m_l01<210000
   m_col1 =10
ElseIf m_l01 >=210000 .and. m_l01<225000
   m_col1 =09
ElseIf m_l01 >=225000 .and. m_l01<240000
   m_col1 =08
ElseIf m_l01 >=240000 .and. m_l01<255000
   m_col1 =07
ElseIf m_l01 >=255000 .and. m_l01<270000
   m_col1 =06
ElseIf m_l01 >=270000 .and. m_l01<285000
   m_col1 =05
ElseIf m_l01 >=285000 .and. m_l01<300000
   m_col1 =04
ElseIf m_l01 >=300000 .and. m_l01<315000
   m_col1 =03
ElseIf m_l01 >=315000
   m_col1 =02
Endif
If m_l02 >0 .and. m_l02 <15000
   m_col2 =23
ElseIf m_l02 >=15000 .and. m_l02 <30000
   m_col2 =22
ElseIf m_l02 >=30000 .and. m_l02 <45000
   m_col2 =21
ElseIf m_l02 >=45000 .and. m_l02 <60000
   m_col2 =20
ElseIf m_l02 >=60000 .and. m_l02 <75000
   m_col2 =19
ElseIf m_l02 >=75000 .and. m_l02 <90000
   m_col2 =18
ElseIf m_l02 >=90000 .and. m_l02<105000
   m_col2 =17
ElseIf m_l02 >=105000 .and. m_l02<120000
   m_col2 =16
ElseIf m_l02 >=120000 .and. m_l02<135000
   m_col2 =15
ElseIf m_l02 >=135000 .and. m_l02<150000
   m_col2 =14
ElseIf m_l02 >=150000 .and. m_l02<165000
   m_col2 =13
ElseIf m_l02 >=165000 .and. m_l02<180000
   m_col2 =12
ElseIf m_l02 >=180000 .and. m_l02<195000
   m_col2 =11
ElseIf m_l02 >=195000 .and. m_l02<210000
   m_col2 =10
ElseIf m_l02 >=210000 .and. m_l02<225000
   m_col2 =09
ElseIf m_l02 >=225000 .and. m_l02<240000
   m_col2 =08
ElseIf m_l02 >=240000 .and. m_l02<255000
   m_col2 =07
ElseIf m_l02 >=255000 .and. m_l02<270000
   m_col2 =06
ElseIf m_l02 >=270000 .and. m_l02<285000
   m_col2 =05
ElseIf m_l02 >=285000 .and. m_l02<300000
   m_col2 =04
ElseIf m_l02 >=300000 .and. m_l02<315000
   m_col2 =03
ElseIf m_l02 >=315000
   m_col2 =02
Endif
If m_l03 >0 .and. m_l03 <15000
   m_col3 =23
ElseIf m_l03 >=15000 .and. m_l03 <30000
   m_col3 =22
ElseIf m_l03 >=30000 .and. m_l03 <45000
   m_col3 =21
ElseIf m_l03 >=45000 .and. m_l03 <60000
   m_col3 =20
ElseIf m_l03 >=60000 .and. m_l03 <75000
   m_col3 =19
ElseIf m_l03 >=75000 .and. m_l03 <90000
   m_col3 =18
ElseIf m_l03 >=90000 .and. m_l03<105000
   m_col3 =17
ElseIf m_l03 >=105000 .and. m_l03<120000
   m_col3 =16
ElseIf m_l03 >=120000 .and. m_l03<135000
   m_col3 =15
ElseIf m_l03 >=135000 .and. m_l03<150000
   m_col3 =14
ElseIf m_l03 >=150000 .and. m_l03<165000
   m_col3 =13
ElseIf m_l03 >=165000 .and. m_l03<180000
   m_col3 =12
ElseIf m_l03 >=180000 .and. m_l03<195000
   m_col3 =11
ElseIf m_l03 >=195000 .and. m_l03<210000
   m_col3 =10
ElseIf m_l03 >=210000 .and. m_l03<225000
   m_col3 =09
ElseIf m_l03 >=225000 .and. m_l03<240000
   m_col3 =08
ElseIf m_l03 >=240000 .and. m_l03<255000
   m_col3 =07
ElseIf m_l03 >=255000 .and. m_l03<270000
   m_col3 =06
ElseIf m_l03 >=270000 .and. m_l03<285000
   m_col3 =05
ElseIf m_l03 >=285000 .and. m_l03<300000
   m_col3 =04
ElseIf m_l03 >=300000 .and. m_l03<315000
   m_col3 =03
ElseIf m_l03 >=315000
   m_col3 =02
Endif
If m_l04 >0 .and. m_l04 <15000
   m_col4 =23
ElseIf m_l04 >=15000 .and. m_l04 <30000
   m_col4 =22
ElseIf m_l04 >=30000 .and. m_l04 <45000
   m_col4 =21
ElseIf m_l04 >=45000 .and. m_l04 <60000
   m_col4 =20
ElseIf m_l04 >=60000 .and. m_l04 <75000
   m_col4 =19
ElseIf m_l04 >=75000 .and. m_l04 <90000
   m_col4 =18
ElseIf m_l04 >=90000 .and. m_l04<105000
   m_col4 =17
ElseIf m_l04 >=105000 .and. m_l04<120000
   m_col4 =16
ElseIf m_l04 >=120000 .and. m_l04<135000
   m_col4 =15
ElseIf m_l04 >=135000 .and. m_l04<150000
   m_col4 =14
ElseIf m_l04 >=150000 .and. m_l04<165000
   m_col4 =13
ElseIf m_l04 >=165000 .and. m_l04<180000
   m_col4 =12
ElseIf m_l04 >=180000 .and. m_l04<195000
   m_col4 =11
ElseIf m_l04 >=195000 .and. m_l04<210000
   m_col4 =10
ElseIf m_l04 >=210000 .and. m_l04<225000
   m_col4 =09
ElseIf m_l04 >=225000 .and. m_l04<240000
   m_col4 =08
ElseIf m_l04 >=240000 .and. m_l04<255000
   m_col4 =07
ElseIf m_l04 >=255000 .and. m_l04<270000
   m_col4 =06
ElseIf m_l04 >=270000 .and. m_l04<285000
   m_col4 =05
ElseIf m_l04 >=285000 .and. m_l04<300000
   m_col4 =04
ElseIf m_l04 >=300000 .and. m_l04<315000
   m_col4 =03
ElseIf m_l04 >=315000
   m_col4 =02
Endif
If m_l05 >0 .and. m_l05 <15000
   m_col5 =23
ElseIf m_l05 >=15000 .and. m_l05 <30000
   m_col5 =22
ElseIf m_l05 >=30000 .and. m_l05 <45000
   m_col5 =21
ElseIf m_l05 >=45000 .and. m_l05 <60000
   m_col5 =20
ElseIf m_l05 >=60000 .and. m_l05 <75000
   m_col5 =19
ElseIf m_l05 >=75000 .and. m_l05 <90000
   m_col5 =18
ElseIf m_l05 >=90000 .and. m_l05<105000
   m_col5 =17
ElseIf m_l05 >=105000 .and. m_l05<120000
   m_col5 =16
ElseIf m_l05 >=120000 .and. m_l05<135000
   m_col5 =15
ElseIf m_l05 >=135000 .and. m_l05<150000
   m_col5 =14
ElseIf m_l05 >=150000 .and. m_l05<165000
   m_col5 =13
ElseIf m_l05 >=165000 .and. m_l05<180000
   m_col5 =12
ElseIf m_l05 >=180000 .and. m_l05<195000
   m_col5 =11
ElseIf m_l05 >=195000 .and. m_l05<210000
   m_col5 =10
ElseIf m_l05 >=210000 .and. m_l05<225000
   m_col5 =09
ElseIf m_l05 >=225000 .and. m_l05<240000
   m_col5 =08
ElseIf m_l05 >=240000 .and. m_l05<255000
   m_col5 =07
ElseIf m_l05 >=255000 .and. m_l05<270000
   m_col5 =06
ElseIf m_l05 >=270000 .and. m_l05<285000
   m_col5 =05
ElseIf m_l05 >=285000 .and. m_l05<300000
   m_col5 =04
ElseIf m_l05 >=300000 .and. m_l05<315000
   m_col5 =03
ElseIf m_l05 >=315000
   m_col5 =02
Endif
If m_l06 >0 .and. m_l06 <15000
   m_col6 =23
ElseIf m_l06 >=15000 .and. m_l06 <30000
   m_col6 =22
ElseIf m_l06 >=30000 .and. m_l06 <45000
   m_col6 =21
ElseIf m_l06 >=45000 .and. m_l06 <60000
   m_col6 =20
ElseIf m_l06 >=60000 .and. m_l06 <75000
   m_col6 =19
ElseIf m_l06 >=75000 .and. m_l06 <90000
   m_col6 =18
ElseIf m_l06 >=90000 .and. m_l06<105000
   m_col6 =17
ElseIf m_l06 >=105000 .and. m_l06<120000
   m_col6 =16
ElseIf m_l06 >=120000 .and. m_l06<135000
   m_col6 =15
ElseIf m_l06 >=135000 .and. m_l06<150000
   m_col6 =14
ElseIf m_l06 >=150000 .and. m_l06<165000
   m_col6 =13
ElseIf m_l06 >=165000 .and. m_l06<180000
   m_col6 =12
ElseIf m_l06 >=180000 .and. m_l06<195000
   m_col6 =11
ElseIf m_l06 >=195000 .and. m_l06<210000
   m_col6 =10
ElseIf m_l06 >=210000 .and. m_l06<225000
   m_col6 =09
ElseIf m_l06 >=225000 .and. m_l06<240000
   m_col6 =08
ElseIf m_l06 >=240000 .and. m_l06<255000
   m_col6 =07
ElseIf m_l06 >=255000 .and. m_l06<270000
   m_col6 =06
ElseIf m_l06 >=270000 .and. m_l06<285000
   m_col6 =05
ElseIf m_l06 >=285000 .and. m_l06<300000
   m_col6 =04
ElseIf m_l06 >=300000 .and. m_l06<315000
   m_col6 =03
ElseIf m_l06 >=315000
   m_col6 =02
Endif
If m_l07 >0 .and. m_l07 <15000
   m_col7 =23
ElseIf m_l07 >=15000 .and. m_l07 <30000
   m_col7 =22
ElseIf m_l07 >=30000 .and. m_l07 <45000
   m_col7 =21
ElseIf m_l07 >=45000 .and. m_l07 <60000
   m_col7 =20
ElseIf m_l07 >=60000 .and. m_l07 <75000
   m_col7 =19
ElseIf m_l07 >=75000 .and. m_l07 <90000
   m_col7 =18
ElseIf m_l07 >=90000 .and. m_l07<105000
   m_col7 =17
ElseIf m_l07 >=105000 .and. m_l07<120000
   m_col7 =16
ElseIf m_l07 >=120000 .and. m_l07<135000
   m_col7 =15
ElseIf m_l07 >=135000 .and. m_l07<150000
   m_col7 =14
ElseIf m_l07 >=150000 .and. m_l07<165000
   m_col7 =13
ElseIf m_l07 >=165000 .and. m_l07<180000
   m_col7 =12
ElseIf m_l07 >=180000 .and. m_l07<195000
   m_col7 =11
ElseIf m_l07 >=195000 .and. m_l07<210000
   m_col7 =10
ElseIf m_l07 >=210000 .and. m_l07<225000
   m_col7 =09
ElseIf m_l07 >=225000 .and. m_l07<240000
   m_col7 =08
ElseIf m_l07 >=240000 .and. m_l07<255000
   m_col7 =07
ElseIf m_l07 >=255000 .and. m_l07<270000
   m_col7 =06
ElseIf m_l07 >=270000 .and. m_l07<285000
   m_col7 =05
ElseIf m_l07 >=285000 .and. m_l07<300000
   m_col7 =04
ElseIf m_l07 >=300000 .and. m_l07<315000
   m_col7 =03
ElseIf m_l07 >=315000
   m_col7 =02
Endif
If m_l08 >0 .and. m_l08 <15000
   m_col8 =23
ElseIf m_l08 >=15000 .and. m_l08 <30000
   m_col8 =22
ElseIf m_l08 >=30000 .and. m_l08 <45000
   m_col8 =21
ElseIf m_l08 >=45000 .and. m_l08 <60000
   m_col8 =20
ElseIf m_l08 >=60000 .and. m_l08 <75000
   m_col8 =19
ElseIf m_l08 >=75000 .and. m_l08 <90000
   m_col8 =18
ElseIf m_l08 >=90000 .and. m_l08<105000
   m_col8 =17
ElseIf m_l08 >=105000 .and. m_l08<120000
   m_col8 =16
ElseIf m_l08 >=120000 .and. m_l08<135000
   m_col8 =15
ElseIf m_l08 >=135000 .and. m_l08<150000
   m_col8 =14
ElseIf m_l08 >=150000 .and. m_l08<165000
   m_col8 =13
ElseIf m_l08 >=165000 .and. m_l08<180000
   m_col8 =12
ElseIf m_l08 >=180000 .and. m_l08<195000
   m_col8 =11
ElseIf m_l08 >=195000 .and. m_l08<210000
   m_col8 =10
ElseIf m_l08 >=210000 .and. m_l08<225000
   m_col8 =09
ElseIf m_l08 >=225000 .and. m_l08<240000
   m_col8 =08
ElseIf m_l08 >=240000 .and. m_l08<255000
   m_col8 =07
ElseIf m_l08 >=255000 .and. m_l08<270000
   m_col8 =06
ElseIf m_l08 >=270000 .and. m_l08<285000
   m_col8 =05
ElseIf m_l08 >=285000 .and. m_l08<300000
   m_col8 =04
ElseIf m_l08 >=300000 .and. m_l08<315000
   m_col8 =03
ElseIf m_l08 >=315000
   m_col8 =02
Endif
If m_l09 >0 .and. m_l09 <15000
   m_col9 =23
ElseIf m_l09 >=15000 .and. m_l09 <30000
   m_col9 =22
ElseIf m_l09 >=30000 .and. m_l09 <45000
   m_col9 =21
ElseIf m_l09 >=45000 .and. m_l09 <60000
   m_col9 =20
ElseIf m_l09 >=60000 .and. m_l09 <75000
   m_col9 =19
ElseIf m_l09 >=75000 .and. m_l09 <90000
   m_col9 =18
ElseIf m_l09 >=90000 .and. m_l09<105000
   m_col9 =17
ElseIf m_l09 >=105000 .and. m_l09<120000
   m_col9 =16
ElseIf m_l09 >=120000 .and. m_l09<135000
   m_col9 =15
ElseIf m_l09 >=135000 .and. m_l09<150000
   m_col9 =14
ElseIf m_l09 >=150000 .and. m_l09<165000
   m_col9 =13
ElseIf m_l09 >=165000 .and. m_l09<180000
   m_col9 =12
ElseIf m_l09 >=180000 .and. m_l09<195000
   m_col9 =11
ElseIf m_l09 >=195000 .and. m_l09<210000
   m_col9 =10
ElseIf m_l09 >=210000 .and. m_l09<225000
   m_col9 =09
ElseIf m_l09 >=225000 .and. m_l09<240000
   m_col9 =08
ElseIf m_l09 >=240000 .and. m_l09<255000
   m_col9 =07
ElseIf m_l09 >=255000 .and. m_l09<270000
   m_col9 =06
ElseIf m_l09 >=270000 .and. m_l09<285000
   m_col9 =05
ElseIf m_l09 >=285000 .and. m_l09<300000
   m_col9 =04
ElseIf m_l09 >=300000 .and. m_l09<315000
   m_col9 =03
ElseIf m_l09 >=315000
   m_col9 =02
Endif
If m_l10 >0 .and. m_l10 <15000
   m_col10 =23
ElseIf m_l10 >=15000 .and. m_l10 <30000
   m_col10 =22
ElseIf m_l10 >=30000 .and. m_l10 <45000
   m_col10 =21
ElseIf m_l10 >=45000 .and. m_l10 <60000
   m_col10 =20
ElseIf m_l10 >=60000 .and. m_l10 <75000
   m_col10 =19
ElseIf m_l10 >=75000 .and. m_l10 <90000
   m_col10 =18
ElseIf m_l10 >=90000 .and. m_l10<105000
   m_col10 =17
ElseIf m_l10 >=105000 .and. m_l10<120000
   m_col10 =16
ElseIf m_l10 >=120000 .and. m_l10<135000
   m_col10 =15
ElseIf m_l10 >=135000 .and. m_l10<150000
   m_col10 =14
ElseIf m_l10 >=150000 .and. m_l10<165000
   m_col10 =13
ElseIf m_l10 >=165000 .and. m_l10<180000
   m_col10 =12
ElseIf m_l10 >=180000 .and. m_l10<195000
   m_col10 =11
ElseIf m_l10 >=195000 .and. m_l10<210000
   m_col10 =10
ElseIf m_l10 >=210000 .and. m_l10<225000
   m_col10 =09
ElseIf m_l10 >=225000 .and. m_l10<240000
   m_col10 =08
ElseIf m_l10 >=240000 .and. m_l10<255000
   m_col10 =07
ElseIf m_l10 >=255000 .and. m_l10<270000
   m_col10 =06
ElseIf m_l10 >=270000 .and. m_l10<285000
   m_col10 =05
ElseIf m_l10 >=285000 .and. m_l10<300000
   m_col10 =04
ElseIf m_l10 >=300000 .and. m_l10<315000
   m_col10 =03
ElseIf m_l10 >=315000
   m_col10 =02
Endif
If m_l11 >0 .and. m_l11 <15000
   m_col11 =23
ElseIf m_l11 >=15000 .and. m_l11 <30000
   m_col11 =22
ElseIf m_l11 >=30000 .and. m_l11 <45000
   m_col11 =21
ElseIf m_l11 >=45000 .and. m_l11 <60000
   m_col11 =20
ElseIf m_l11 >=60000 .and. m_l11 <75000
   m_col11 =19
ElseIf m_l11 >=75000 .and. m_l11 <90000
   m_col11 =18
ElseIf m_l11 >=90000 .and. m_l11<105000
   m_col11 =17
ElseIf m_l11 >=105000 .and. m_l11<120000
   m_col11 =16
ElseIf m_l11 >=120000 .and. m_l11<135000
   m_col11 =15
ElseIf m_l11 >=135000 .and. m_l11<150000
   m_col11 =14
ElseIf m_l11 >=150000 .and. m_l11<165000
   m_col11 =13
ElseIf m_l11 >=165000 .and. m_l11<180000
   m_col11 =12
ElseIf m_l11 >=180000 .and. m_l11<195000
   m_col11 =11
ElseIf m_l11 >=195000 .and. m_l11<210000
   m_col11 =10
ElseIf m_l11 >=210000 .and. m_l11<225000
   m_col11 =09
ElseIf m_l11 >=225000 .and. m_l11<240000
   m_col11 =08
ElseIf m_l11 >=240000 .and. m_l11<255000
   m_col11 =07
ElseIf m_l11 >=255000 .and. m_l11<270000
   m_col11 =06
ElseIf m_l11 >=270000 .and. m_l11<285000
   m_col11 =05
ElseIf m_l11 >=285000 .and. m_l11<300000
   m_col11 =04
ElseIf m_l11 >=300000 .and. m_l11<315000
   m_col11 =03
ElseIf m_l11 >=315000
   m_col11 =02
Endif
If m_l12 >0 .and. m_l12 <15000
   m_col12 =23
ElseIf m_l12 >=15000 .and. m_l12 <30000
   m_col12 =22
ElseIf m_l12 >=30000 .and. m_l12 <45000
   m_col12 =21
ElseIf m_l12 >=45000 .and. m_l12 <60000
   m_col12 =20
ElseIf m_l12 >=60000 .and. m_l12 <75000
   m_col12 =19
ElseIf m_l12 >=75000 .and. m_l12 <90000
   m_col12 =18
ElseIf m_l12 >=90000 .and. m_l12<105000
   m_col12 =17
ElseIf m_l12 >=105000 .and. m_l12<120000
   m_col12 =16
ElseIf m_l12 >=120000 .and. m_l12<135000
   m_col12 =15
ElseIf m_l12 >=135000 .and. m_l12<150000
   m_col12 =14
ElseIf m_l12 >=150000 .and. m_l12<165000
   m_col12 =13
ElseIf m_l12 >=165000 .and. m_l12<180000
   m_col12 =12
ElseIf m_l12 >=180000 .and. m_l12<195000
   m_col12 =11
ElseIf m_l12 >=195000 .and. m_l12<210000
   m_col12 =10
ElseIf m_l12 >=210000 .and. m_l12<225000
   m_col12 =09
ElseIf m_l12 >=225000 .and. m_l12<240000
   m_col12 =08
ElseIf m_l12 >=240000 .and. m_l12<255000
   m_col12 =07
ElseIf m_l12 >=255000 .and. m_l12<270000
   m_col12 =06
ElseIf m_l12 >=270000 .and. m_l12<285000
   m_col12 =05
ElseIf m_l12 >=285000 .and. m_l12<300000
   m_col12 =04
ElseIf m_l12 >=300000 .and. m_l12<315000
   m_col12 =03
ElseIf m_l12 >=315000
   m_col12 =02
Endif
If m_l13 >0 .and. m_l13 <15000
   m_col13 =23
ElseIf m_l13 >=15000 .and. m_l13 <30000
   m_col13 =22
ElseIf m_l13 >=30000 .and. m_l13 <45000
   m_col13 =21
ElseIf m_l13 >=45000 .and. m_l13 <60000
   m_col13 =20
ElseIf m_l13 >=60000 .and. m_l13 <75000
   m_col13 =19
ElseIf m_l13 >=75000 .and. m_l13 <90000
   m_col13 =18
ElseIf m_l13 >=90000 .and. m_l13<105000
   m_col13 =17
ElseIf m_l13 >=105000 .and. m_l13<120000
   m_col13 =16
ElseIf m_l13 >=120000 .and. m_l13<135000
   m_col13 =15
ElseIf m_l13 >=135000 .and. m_l13<150000
   m_col13 =14
ElseIf m_l13 >=150000 .and. m_l13<165000
   m_col13 =13
ElseIf m_l13 >=165000 .and. m_l13<180000
   m_col13 =12
ElseIf m_l13 >=180000 .and. m_l13<195000
   m_col13 =11
ElseIf m_l13 >=195000 .and. m_l13<210000
   m_col13 =10
ElseIf m_l13 >=210000 .and. m_l13<225000
   m_col13 =09
ElseIf m_l13 >=225000 .and. m_l13<240000
   m_col13 =08
ElseIf m_l13 >=240000 .and. m_l13<255000
   m_col13 =07
ElseIf m_l13 >=255000 .and. m_l13<270000
   m_col13 =06
ElseIf m_l13 >=270000 .and. m_l13<285000
   m_col13 =05
ElseIf m_l13 >=285000 .and. m_l13<300000
   m_col13 =04
ElseIf m_l13 >=300000 .and. m_l13<315000
   m_col13 =03
ElseIf m_l13 >=315000
   m_col13 =02
Endif
If m_l14 >0 .and. m_l14 <15000
   m_col14 =23
ElseIf m_l14 >=15000 .and. m_l14 <30000
   m_col14 =22
ElseIf m_l14 >=30000 .and. m_l14 <45000
   m_col14 =21
ElseIf m_l14 >=45000 .and. m_l14 <60000
   m_col14 =20
ElseIf m_l14 >=60000 .and. m_l14 <75000
   m_col14 =19
ElseIf m_l14 >=75000 .and. m_l14 <90000
   m_col14 =18
ElseIf m_l14 >=90000 .and. m_l14<105000
   m_col14 =17
ElseIf m_l14 >=105000 .and. m_l14<120000
   m_col14 =16
ElseIf m_l14 >=120000 .and. m_l14<135000
   m_col14 =15
ElseIf m_l14 >=135000 .and. m_l14<150000
   m_col14 =14
ElseIf m_l14 >=150000 .and. m_l14<165000
   m_col14 =13
ElseIf m_l14 >=165000 .and. m_l14<180000
   m_col14 =12
ElseIf m_l14 >=180000 .and. m_l14<195000
   m_col14 =11
ElseIf m_l14 >=195000 .and. m_l14<210000
   m_col14 =10
ElseIf m_l14 >=210000 .and. m_l14<225000
   m_col14 =09
ElseIf m_l14 >=225000 .and. m_l14<240000
   m_col14 =08
ElseIf m_l14 >=240000 .and. m_l14<255000
   m_col14 =07
ElseIf m_l14 >=255000 .and. m_l14<270000
   m_col14 =06
ElseIf m_l14 >=270000 .and. m_l14<285000
   m_col14 =05
ElseIf m_l14 >=285000 .and. m_l14<300000
   m_col14 =04
ElseIf m_l14 >=300000 .and. m_l14<315000
   m_col14 =03
ElseIf m_l14 >=315000
   m_col14 =02
Endif
If m_l15 >0 .and. m_l15 <15000
   m_col15 =23
ElseIf m_l15 >=15000 .and. m_l15 <30000
   m_col15 =22
ElseIf m_l15 >=30000 .and. m_l15 <45000
   m_col15 =21
ElseIf m_l15 >=45000 .and. m_l15 <60000
   m_col15 =20
ElseIf m_l15 >=60000 .and. m_l15 <75000
   m_col15 =19
ElseIf m_l15 >=75000 .and. m_l15 <90000
   m_col15 =18
ElseIf m_l15 >=90000 .and. m_l15<105000
   m_col15 =17
ElseIf m_l15 >=105000 .and. m_l15<120000
   m_col15 =16
ElseIf m_l15 >=120000 .and. m_l15<135000
   m_col15 =15
ElseIf m_l15 >=135000 .and. m_l15<150000
   m_col15 =14
ElseIf m_l15 >=150000 .and. m_l15<165000
   m_col15 =13
ElseIf m_l15 >=165000 .and. m_l15<180000
   m_col15 =12
ElseIf m_l15 >=180000 .and. m_l15<195000
   m_col15 =11
ElseIf m_l15 >=195000 .and. m_l15<210000
   m_col15 =10
ElseIf m_l15 >=210000 .and. m_l15<225000
   m_col15 =09
ElseIf m_l15 >=225000 .and. m_l15<240000
   m_col15 =08
ElseIf m_l15 >=240000 .and. m_l15<255000
   m_col15 =07
ElseIf m_l15 >=255000 .and. m_l15<270000
   m_col15 =06
ElseIf m_l15 >=270000 .and. m_l15<285000
   m_col15 =05
ElseIf m_l15 >=285000 .and. m_l15<300000
   m_col15 =04
ElseIf m_l15 >=300000 .and. m_l15<315000
   m_col15 =03
ElseIf m_l15 >=315000
   m_col15 =02
Endif
If m_l16 >0 .and. m_l16 <15000
   m_col16 =23
ElseIf m_l16 >=15000 .and. m_l16 <30000
   m_col16 =22
ElseIf m_l16 >=30000 .and. m_l16 <45000
   m_col16 =21
ElseIf m_l16 >=45000 .and. m_l16 <60000
   m_col16 =20
ElseIf m_l16 >=60000 .and. m_l16 <75000
   m_col16 =19
ElseIf m_l16 >=75000 .and. m_l16 <90000
   m_col16 =18
ElseIf m_l16 >=90000 .and. m_l16<105000
   m_col16 =17
ElseIf m_l16 >=105000 .and. m_l16<120000
   m_col16 =16
ElseIf m_l16 >=120000 .and. m_l16<135000
   m_col16 =15
ElseIf m_l16 >=135000 .and. m_l16<150000
   m_col16 =14
ElseIf m_l16 >=150000 .and. m_l16<165000
   m_col16 =13
ElseIf m_l16 >=165000 .and. m_l16<180000
   m_col16 =12
ElseIf m_l16 >=180000 .and. m_l16<195000
   m_col16 =11
ElseIf m_l16 >=195000 .and. m_l16<210000
   m_col16 =10
ElseIf m_l16 >=210000 .and. m_l16<225000
   m_col16 =09
ElseIf m_l16 >=225000 .and. m_l16<240000
   m_col16 =08
ElseIf m_l16 >=240000 .and. m_l16<255000
   m_col16 =07
ElseIf m_l16 >=255000 .and. m_l16<270000
   m_col16 =06
ElseIf m_l16 >=270000 .and. m_l16<285000
   m_col16 =05
ElseIf m_l16 >=285000 .and. m_l16<300000
   m_col16 =04
ElseIf m_l16 >=300000 .and. m_l16<315000
   m_col16 =03
ElseIf m_l16 >=315000
   m_col16 =02
Endif
If m_l17 >0 .and. m_l17 <15000
   m_col17 =23
ElseIf m_l17 >=15000 .and. m_l17 <30000
   m_col17 =22
ElseIf m_l17 >=30000 .and. m_l17 <45000
   m_col17 =21
ElseIf m_l17 >=45000 .and. m_l17 <60000
   m_col17 =20
ElseIf m_l17 >=60000 .and. m_l17 <75000
   m_col17 =19
ElseIf m_l17 >=75000 .and. m_l17 <90000
   m_col17 =18
ElseIf m_l17 >=90000 .and. m_l17<105000
   m_col17 =17
ElseIf m_l17 >=105000 .and. m_l17<120000
   m_col17 =16
ElseIf m_l17 >=120000 .and. m_l17<135000
   m_col17 =15
ElseIf m_l17 >=135000 .and. m_l17<150000
   m_col17 =14
ElseIf m_l17 >=150000 .and. m_l17<165000
   m_col17 =13
ElseIf m_l17 >=165000 .and. m_l17<180000
   m_col17 =12
ElseIf m_l17 >=180000 .and. m_l17<195000
   m_col17 =11
ElseIf m_l17 >=195000 .and. m_l17<210000
   m_col17 =10
ElseIf m_l17 >=210000 .and. m_l17<225000
   m_col17 =09
ElseIf m_l17 >=225000 .and. m_l17<240000
   m_col17 =08
ElseIf m_l17 >=240000 .and. m_l17<255000
   m_col17 =07
ElseIf m_l17 >=255000 .and. m_l17<270000
   m_col17 =06
ElseIf m_l17 >=270000 .and. m_l17<285000
   m_col17 =05
ElseIf m_l17 >=285000 .and. m_l17<300000
   m_col17 =04
ElseIf m_l17 >=300000 .and. m_l17<315000
   m_col17 =03
ElseIf m_l17 >=315000
   m_col17 =02
Endif
If m_l18 >0 .and. m_l18 <15000
   m_col18 =23
ElseIf m_l18 >=15000 .and. m_l18 <30000
   m_col18 =22
ElseIf m_l18 >=30000 .and. m_l18 <45000
   m_col18 =21
ElseIf m_l18 >=45000 .and. m_l18 <60000
   m_col18 =20
ElseIf m_l18 >=60000 .and. m_l18 <75000
   m_col18 =19
ElseIf m_l18 >=75000 .and. m_l18 <90000
   m_col18 =18
ElseIf m_l18 >=90000 .and. m_l18<105000
   m_col18 =17
ElseIf m_l18 >=105000 .and. m_l18<120000
   m_col18 =16
ElseIf m_l18 >=120000 .and. m_l18<135000
   m_col18 =15
ElseIf m_l18 >=135000 .and. m_l18<150000
   m_col18 =14
ElseIf m_l18 >=150000 .and. m_l18<165000
   m_col18 =13
ElseIf m_l18 >=165000 .and. m_l18<180000
   m_col18 =12
ElseIf m_l18 >=180000 .and. m_l18<195000
   m_col18 =11
ElseIf m_l18 >=195000 .and. m_l18<210000
   m_col18 =10
ElseIf m_l18 >=210000 .and. m_l18<225000
   m_col18 =09
ElseIf m_l18 >=225000 .and. m_l18<240000
   m_col18 =08
ElseIf m_l18 >=240000 .and. m_l18<255000
   m_col18 =07
ElseIf m_l18 >=255000 .and. m_l18<270000
   m_col18 =06
ElseIf m_l18 >=270000 .and. m_l18<285000
   m_col18 =05
ElseIf m_l18 >=285000 .and. m_l18<300000
   m_col18 =04
ElseIf m_l18 >=300000 .and. m_l18<315000
   m_col18 =03
ElseIf m_l18 >=315000
   m_col18 =02
Endif
If m_l19 >0 .and. m_l19 <15000
   m_col19 =23
ElseIf m_l19 >=15000 .and. m_l19 <30000
   m_col19 =22
ElseIf m_l19 >=30000 .and. m_l19 <45000
   m_col19 =21
ElseIf m_l19 >=45000 .and. m_l19 <60000
   m_col19 =20
ElseIf m_l19 >=60000 .and. m_l19 <75000
   m_col19 =19
ElseIf m_l19 >=75000 .and. m_l19 <90000
   m_col19 =18
ElseIf m_l19 >=90000 .and. m_l19<105000
   m_col19 =17
ElseIf m_l19 >=105000 .and. m_l19<120000
   m_col19 =16
ElseIf m_l19 >=120000 .and. m_l19<135000
   m_col19 =15
ElseIf m_l19 >=135000 .and. m_l19<150000
   m_col19 =14
ElseIf m_l19 >=150000 .and. m_l19<165000
   m_col19 =13
ElseIf m_l19 >=165000 .and. m_l19<180000
   m_col19 =12
ElseIf m_l19 >=180000 .and. m_l19<195000
   m_col19 =11
ElseIf m_l19 >=195000 .and. m_l19<210000
   m_col19 =10
ElseIf m_l19 >=210000 .and. m_l19<225000
   m_col19 =09
ElseIf m_l19 >=225000 .and. m_l19<240000
   m_col19 =08
ElseIf m_l19 >=240000 .and. m_l19<255000
   m_col19 =07
ElseIf m_l19 >=255000 .and. m_l19<270000
   m_col19 =06
ElseIf m_l19 >=270000 .and. m_l19<285000
   m_col19 =05
ElseIf m_l19 >=285000 .and. m_l19<300000
   m_col19 =04
ElseIf m_l19 >=300000 .and. m_l19<315000
   m_col19 =03
ElseIf m_l19 >=315000
   m_col19 =02
Endif
If m_l21 >0 .and. m_l21 <15000
   m_col21 =23
ElseIf m_l21 >=15000 .and. m_l21 <30000
   m_col21 =22
ElseIf m_l21 >=30000 .and. m_l21 <45000
   m_col21 =21
ElseIf m_l21 >=45000 .and. m_l21 <60000
   m_col21 =20
ElseIf m_l21 >=60000 .and. m_l21 <75000
   m_col21 =19
ElseIf m_l21 >=75000 .and. m_l21 <90000
   m_col21 =18
ElseIf m_l21 >=90000 .and. m_l21<105000
   m_col21 =17
ElseIf m_l21 >=105000 .and. m_l21<120000
   m_col21 =16
ElseIf m_l21 >=120000 .and. m_l21<135000
   m_col21 =15
ElseIf m_l21 >=135000 .and. m_l21<150000
   m_col21 =14
ElseIf m_l21 >=150000 .and. m_l21<165000
   m_col21 =13
ElseIf m_l21 >=165000 .and. m_l21<180000
   m_col21 =12
ElseIf m_l21 >=180000 .and. m_l21<195000
   m_col21 =11
ElseIf m_l21 >=195000 .and. m_l21<210000
   m_col21 =10
ElseIf m_l21 >=210000 .and. m_l21<225000
   m_col21 =09
ElseIf m_l21 >=225000 .and. m_l21<240000
   m_col21 =08
ElseIf m_l21 >=240000 .and. m_l21<255000
   m_col21 =07
ElseIf m_l21 >=255000 .and. m_l21<270000
   m_col21 =06
ElseIf m_l21 >=270000 .and. m_l21<285000
   m_col21 =05
ElseIf m_l21 >=285000 .and. m_l21<300000
   m_col21 =04
ElseIf m_l21 >=300000 .and. m_l21<315000
   m_col21 =03
ElseIf m_l21 >=315000
   m_col21 =02
Endif

setcolor( "GR/W" )  ; @ m_col1-1, 13 say substr(m_nome1,1,2)
setcolor( "GR/GR+" )  ; @ m_col1, 13 clear to 22,14
setcolor( "GR/W" )
    @ 24,13 say m_cd1
setcolor( "GR/W" )  ; @ m_col1-2, 16 say substr(m_nome2,1,2)
setcolor( "GR/GR+" ) ; @ m_col2, 16 clear to 22,17
setcolor( "GR/W" )
    @ 24,16 say m_cd2
setcolor( "N/W" )    ; @ m_col3-1, 19 say substr(m_nome3,1,2)
setcolor( "W+/N" )    ; @ m_col3, 19 clear to 22,20
setcolor( "N/W" )
    @ 24,19 say m_cd3
setcolor( "R/W" )     ; @ m_col4-1, 22 say substr(m_nome4,1,2)
setcolor( "W/R" )     ; @ m_col4, 22 clear to 22,23
setcolor( "R/W" )
    @ 24,22 say m_cd4
setcolor( "RB/W" )  ; @ m_col5-1, 25 say substr(m_nome5,1,2)
setcolor( "RB/RB+" )  ; @ m_col5, 25 clear to 22,26
setcolor( "RB/W" )
    @ 24,25 say m_cd5
setcolor( "G/W" )   ; @ m_col6-1, 28 say substr(m_nome6,1,2)
setcolor( "G+/G+" )   ; @ m_col6, 28 clear to 22,29
setcolor( "G/W" )
    @ 24,28 say m_cd6
setcolor( "BG+/W" )  ; @ m_col7-1, 31 say substr(m_nome7,1,2)
setcolor( "BG/BG+" )  ; @ m_col7, 31 clear to 22,32
setcolor( "BG+/W" )
    @ 24,31 say m_cd7
setcolor( "B/W" )   ; @ m_col8-1, 34 say substr(m_nome8,1,2)
setcolor( "B+/B+" )   ; @ m_col8, 34 clear to 22,35
setcolor( "B/W" )
    @ 24,34 say m_cd8
setcolor( "GR+/W" )   ; @ m_col9-1, 37 say substr(m_nome9,1,2)
setcolor( "W/GR+" )   ; @ m_col9, 37 clear to 22,38
setcolor( "GR+/W" )
    @ 24,37 say m_cd9
setcolor( "R+/W+" )   ; @ m_col10-1, 40 say substr(m_nome10,1,2)
setcolor( "BG/R" )   ; @ m_col10, 40 clear to 22,41
setcolor( "R+/W" )
    @ 24,40 say m_cd10
setcolor( "GR/W" )  ; @ m_col11-1, 43 say substr(m_nome11,1,2)
setcolor( "GR/GR+" )  ; @ m_col11, 43 clear to 22,44
setcolor( "GR/W" )
    @ 24,43 say m_cd11
setcolor( "N/W" )    ; @ m_col12-1, 46 say substr(m_nome12,1,2)
setcolor( "W+/N" )    ; @ m_col12, 46 clear to 22,47
setcolor( "N/W" )
    @ 24,46 say m_cd12
setcolor( "R/W" )    ; @ m_col13-1, 49 say substr(m_nome13,1,2)
setcolor( "W/R+" )    ; @ m_col13, 49 clear to 22,50
setcolor( "R/W" )
    @ 24,49 say m_cd13
setcolor( "RB/W" )   ; @ m_col14-1, 52 say substr(m_nome14,1,2)
setcolor( "RB/RB" )   ; @ m_col14, 52 clear to 22,53
setcolor( "RB/W" )
    @ 24,52 say m_cd14
setcolor( "G/W" )   ; @ m_col15-1, 55 say substr(m_nome15,1,2)
setcolor( "G+/G+" )   ; @ m_col15, 55 clear to 22,56
setcolor( "G/W" )
    @ 24,55 say m_cd15
setcolor( "R/W" )   ; @ m_col16-1, 58 say substr(m_nome16,1,2)
setcolor( "W/R+")   ; @ m_col16, 58 clear to 22,59
setcolor( "R/W" )
    @ 24,58 say m_cd16
setcolor( "RB/W" )  ; @ m_col17-1, 61 say substr(m_nome17,1,2)
setcolor( "RB/RB")  ; @ m_col17, 61 clear to 22,62
setcolor( "RB/W" )
    @ 24,61 say m_cd17
setcolor( "RB/W" )  ; @ m_col18-1, 64 say substr(m_nome18,1,2)
setcolor( "RB/RB")  ; @ m_col18, 64 clear to 22,65
setcolor( "RB/W" )
    @ 24,64 say m_cd18
setcolor( "RB/W" )  ; @ m_col19-1, 67 say substr(m_nome19,1,2)
setcolor( "RB/RB")  ; @ m_col19, 67 clear to 22,68
setcolor( "RB/W" )
    @ 24,67 say m_cd19
setcolor( "RB/W" )  ; @ m_col20-1, 70 say substr(m_nome20,1,2)
setcolor( "RB/RB")  ; @ m_col20, 70 clear to 22,71
setcolor( "RB/W" )
    @ 24,70 say m_cd20
setcolor( "RB/W" )  ; @ m_col21-1, 73 say substr(m_nome21,1,2)
setcolor( "RB/RB")  ; @ m_col21, 73 clear to 22,74
setcolor( "RB/W" )
    @ 24,73 say m_cd21
Inkey(0)
  Release m_l01,m_l02,m_l03,m_l04,m_l05,m_l06,m_l07,m_l08,m_l09,m_l10,m_l11,m_l12,X,m_dat1,m_dat2,m_l13,m_l14,m_nome13,m_nome14
  Release m_col1,m_col2,m_col3,m_col4,m_col5,m_col6,m_col7,m_col8,m_col9,m_col10,m_col11,m_col12,m_col13,m_col14,m_nome15,m_nome16
  Release m_col17,m_col18,m_col19,m_col20,m_col21,m_nome17,m_nome18,m_nome19,m_nome20,m_nome21,m_l21
  Release m_vend,m_vendf,x,m_nomv,m_nome2,m_nome3,m_nome4,m_nome5,m_nome6,m_nome7,m_nome8,m_nome9,m_nome10,m_nome11,m_nome12
  Release m_cd1,m_cd2,m_cd3,m_cd4,m_cd5,m_cd6,m_cd7,m_cd8,m_cd9,m_cd10,m_cd11,m_cd12,m_cd13,m_cd14,m_cd15,m_cd16,m_cd17,m_cd18,m_cd19,m_cd20,m_cd21

restscreen(,,,,sst)
********************
Procedure graficovd        // Grafico de Vendas de Vendedores
********************
sst=savescreen(00,00,24,78)
Set color to w/w
    @ 00,00 clear to 24,80
Set color to n/w
    @ 01,00,24,79 BOX B_SINGLE
Set color to W+/W
    @ 01,00 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    @ 02,00 Say "³"
    @ 03,00 Say "³"
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
    @ 24,01 clear to 24,80
    @ 02,13 to 24,13
    @ 02,13 say chr(194)
    @ 23,13 to 23,15
    @ 23,10 to 23,77
    @ 23,13 say chr(197)

    ssv=savescreen(08,38,16,75)
    Set color to N/W
    @ 08,40,14,62 BOX B_SINGLE
      Set color to W+/W
    @ 08,40 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    @ 09,40 Say "³"
    @ 10,40 Say "³"
    @ 11,40 Say "³"
    @ 12,40 Say "³"
    @ 13,40 Say "³"
    @ 14,40 Say "À"

   Set color to B/W
   @ 09,42 Say " Conectiva Linux  "
   @ 10,41 Say "Gr fico Demonstrativo"

   Set color to n/w
   @ 23,78 say chr(16)

   Set color to gr+/w
    @ 02,04 Say " 315.000"
    @ 03,04 Say " 300.000"
    @ 04,04 Say " 285.000"
    @ 05,04 Say " 270.000"
    @ 06,04 Say " 255.000"
    @ 07,04 Say " 240.000"
    @ 08,04 Say " 225.000"
    @ 09,04 Say " 210.000"
    @ 10,04 Say " 195.000"
    @ 11,04 Say " 180.000"
    @ 12,04 Say " 165.000"
    @ 13,04 Say " 150.000"
    @ 14,04 Say " 135.000"
    @ 15,04 Say " 120.000"
    @ 16,04 Say " 105.000"
    @ 17,04 Say "  90.000"
    @ 18,04 Say "  75.000"
    @ 19,04 Say "  60.000"
    @ 20,04 Say "  45.000"
    @ 21,04 Say "  30.000"
    @ 22,04 Say "  15.000"
    @ 23,04 Say "   0.000"
    @ 22,67 Say "Meses"
    Set color to w+/w

    @ 03,13 Say chr(180)
    @ 04,13 Say chr(180)
    @ 05,13 Say chr(180)
    @ 06,13 Say chr(180)
    @ 07,13 Say chr(180)
    @ 08,13 Say chr(180)
    @ 09,13 Say chr(180)
    @ 10,13 Say chr(180)
    @ 11,13 Say chr(180)
    @ 12,13 Say chr(180)
    @ 13,13 Say chr(180)
    @ 14,13 Say chr(180)
    @ 15,13 Say chr(180)
    @ 16,13 Say chr(180)
    @ 17,13 Say chr(180)
    @ 18,13 Say chr(180)
    @ 19,13 Say chr(180)
    @ 20,13 Say chr(180)
    @ 21,13 Say chr(180)
    @ 22,13 Say chr(180)

    @ 23,17 say chr(194)
    @ 23,21 say chr(194)
    @ 23,25 say chr(194)
    @ 23,29 say chr(194)
    @ 23,33 say chr(194)
    @ 23,37 say chr(194)
    @ 23,41 say chr(194)
    @ 23,45 say chr(194)
    @ 23,49 say chr(194)
    @ 23,53 say chr(194)
    @ 23,57 say chr(194)
    @ 23,61 say chr(194)

    ANO=SUBSTR(dtoc(m_datsi),7,4)
    COR=SETCOLOR()
    SETCOLOR("B/W")
    @ 11,41 SAY "Defina o Ano"
    @ 12,41 SAY 'ANO :' GET ANO PICT "9999"
      read
    @ 13,41 SAY "Vendedor: "+Str(vend3,2)

         Sele 16
	 Set Order to 1
	     Seek str(vend3,3,0)
	        If eof()
		   Alert("Vendedor N„o Cadastrado !")
                   restscreen(,,,,sst)
		   Return
		Endif
		M_Nomv=BA_NOME
    SetColor(Cor)
   IF LASTKEY() = 27
   * .OR. EMPTY(M_DT1) .OR. EMPTY(M_DT2)
       restscreen(00,00,24,78,sst)
       Return
   ENDIF

     Set color to n/w
     @ 00,00 Say "                 Gr fico Demonstrativo de Vendas p/Vendedor: "+M_Nomv
     @ 24,67 Say m_nomv

Stor 0 to m_l01,m_l02,m_l03,m_l04,m_l05,m_l06,m_l07,m_l08,m_l09,m_l10,m_l11,m_l12
Stor 23 to m_col1,m_col2,m_col3,m_col4,m_col5,m_col6,m_col7,m_col8,m_col9,m_col10,m_col11,m_col12

Cor=SetColor()
setcolor( "W/GR+" )
@ 16,40 clear to 16,50
SetColor(cor)
Col=39
       X=1
 WHILE X<=12
     IF X = 1
       M_DT1=CTOD("01/01/&ANO")
       M_DT2=CTOD("31/01/&ANO")
       M_MES="JANEIRO/&ANO"
     ELSEIF X=2
       M_DT1=CTOD("01/02/&ANO")
       If year(m_dt1) = 2012 .or. year(m_dt1) = 2016.or. year(m_dt1) = 2020
        M_DT2=CTOD("29/02/&ANO")
       Else
        M_DT2=CTOD("28/02/&ANO")
       Endif
       M_MES="FEVEREIRO/&ANO"
     ELSEIF X=3
       M_DT1=CTOD("01/03/&ANO")
       M_DT2=CTOD("31/03/&ANO")
       M_MES="MARCO/&ANO    "
     ELSEIF X=4
       M_DT1=CTOD("01/04/&ANO")
       M_DT2=CTOD("30/04/&ANO")
       M_MES="ABRIL/&ANO    "
     ELSEIF X=5
       M_DT1=CTOD("01/05/&ANO")
       M_DT2=CTOD("31/05/&ANO")
       M_MES="MAIO/&ANO    "
     ELSEIF X=6
       M_DT1=CTOD("01/06/&ANO")
       M_DT2=CTOD("30/06/&ANO")
       M_MES="JUNHO/&ANO    "
     ELSEIF X=7
       M_DT1=CTOD("01/07/&ANO")
       M_DT2=CTOD("31/07/&ANO")
       M_MES="JULHO/&ANO    "
     ELSEIF X=8
       M_DT1=CTOD("01/08/&ANO")
       M_DT2=CTOD("31/08/&ANO")
       M_MES="AGOSTO/&ANO  "
     ELSEIF X=9
       M_DT1=CTOD("01/09/&ANO")
       M_DT2=CTOD("30/09/&ANO")
       M_MES="SETEMBRO/&ANO  "
     ELSEIF X=10
       M_DT1=CTOD("01/10/&ANO")
       M_DT2=CTOD("31/10/&ANO")
       M_MES="OUTUBRO/&ANO  "
     ELSEIF X=11
       M_DT1=CTOD("01/11/&ANO")
       M_DT2=CTOD("30/11/&ANO")
       M_MES="NOVEMBRO/&ANO  "
     ELSEIF X=12
       M_DT1=CTOD("01/12/&ANO")
       M_DT2=CTOD("31/12/&ANO")
       M_MES="DEZEMBRO/&ANO  "
     ENDIF

     @ 15,40 SAY M_MES

         SELE 4
         SET ORDER TO 5
         GOTO TOP
         STOR 0 TO M_V
         TONE(200,1)
         WHILE .T.
          SEEK STR(VEND3,3,0)+SUBSTR(DTOC(M_DT1),7,4)+SUBSTR(DTOC(M_DT1),4,2)+SUBSTR(DTOC(M_DT1),1,2)
               IF EOF()
                  M_DT1=M_DT1+1
                  IF M_DT1 >M_DT2
                       EXIT
                  ENDIF
               ELSE
                  EXIT
               ENDIF
          ENDDO
          WHILE !EOF() .AND. SD_VEND=VEND3 .AND. SD_DATA<=M_DT2
              M_V  = M_V + (SD_QTDE * SD_PREC)    && QUANTIDADE x UNITARIO VENDA
              SKIP
          ENDDO
   If x=1
      m_l01=round(m_v,0)
   ElseIf x=2
      m_l02=round(m_v,0)
   ElseIf x=3
      m_l03=round(m_v,0)
   ElseIf x=4
      m_l04=round(m_v,0)
   ElseIf x=5
      m_l05=round(m_v,0)
   ElseIf x=6
      m_l06=round(m_v,0)
   ElseIf x=7
      m_l07=round(m_v,0)
   ElseIf x=8
      m_l08=round(m_v,0)
   ElseIf x=9
      m_l09=round(m_v,0)
   ElseIf x=10
      m_l10=round(m_v,0)
   ElseIf x=11
      m_l11=round(m_v,0)
   ElseIf x=12
      m_l12=round(m_v,0)
   Endif
 Cor=Setcolor()
 setcolor( "GR+/W" )
  col=col+1
 @ 16,col say chr(219)
 SetColor(Cor)
    X++
ENDDO

 restscreen(08,38,16,75,ssv)

If m_l01 >0 .and. m_l01 <15000
   m_col1 =23
ElseIf m_l01 >=15000 .and. m_l01 <30000
   m_col1 =22
ElseIf m_l01 >=30000 .and. m_l01 <45000
   m_col1 =21
ElseIf m_l01 >=45000 .and. m_l01 <60000
   m_col1 =20
ElseIf m_l01 >=60000 .and. m_l01 <75000
   m_col1 =19
ElseIf m_l01 >=75000 .and. m_l01 <90000
   m_col1 =18
ElseIf m_l01 >=90000 .and. m_l01<105000
   m_col1 =17
ElseIf m_l01 >=105000 .and. m_l01<120000
   m_col1 =16
ElseIf m_l01 >=120000 .and. m_l01<135000
   m_col1 =15
ElseIf m_l01 >=135000 .and. m_l01<150000
   m_col1 =14
ElseIf m_l01 >=150000 .and. m_l01<165000
   m_col1 =13
ElseIf m_l01 >=165000 .and. m_l01<180000
   m_col1 =12
ElseIf m_l01 >=180000 .and. m_l01<195000
   m_col1 =11
ElseIf m_l01 >=195000 .and. m_l01<210000
   m_col1 =10
ElseIf m_l01 >=210000 .and. m_l01<225000
   m_col1 =09
ElseIf m_l01 >=225000 .and. m_l01<240000
   m_col1 =08
ElseIf m_l01 >=240000 .and. m_l01<255000
   m_col1 =07
ElseIf m_l01 >=255000 .and. m_l01<270000
   m_col1 =06
ElseIf m_l01 >=270000 .and. m_l01<285000
   m_col1 =05
ElseIf m_l01 >=285000 .and. m_l01<300000
   m_col1 =04
ElseIf m_l01 >=300000 .and. m_l01<315000
   m_col1 =03
ElseIf m_l01 >=315000
   m_col1 =02
Endif
If m_l02 >0 .and. m_l02 <15000
   m_col2 =23
ElseIf m_l02 >=15000 .and. m_l02 <30000
   m_col2 =22
ElseIf m_l02 >=30000 .and. m_l02 <45000
   m_col2 =21
ElseIf m_l02 >=45000 .and. m_l02 <60000
   m_col2 =20
ElseIf m_l02 >=60000 .and. m_l02 <75000
   m_col2 =19
ElseIf m_l02 >=75000 .and. m_l02 <90000
   m_col2 =18
ElseIf m_l02 >=90000 .and. m_l02<105000
   m_col2 =17
ElseIf m_l02 >=105000 .and. m_l02<120000
   m_col2 =16
ElseIf m_l02 >=120000 .and. m_l02<135000
   m_col2 =15
ElseIf m_l02 >=135000 .and. m_l02<150000
   m_col2 =14
ElseIf m_l02 >=150000 .and. m_l02<165000
   m_col2 =13
ElseIf m_l02 >=165000 .and. m_l02<180000
   m_col2 =12
ElseIf m_l02 >=180000 .and. m_l02<195000
   m_col2 =11
ElseIf m_l02 >=195000 .and. m_l02<210000
   m_col2 =10
ElseIf m_l02 >=210000 .and. m_l02<225000
   m_col2 =09
ElseIf m_l02 >=225000 .and. m_l02<240000
   m_col2 =08
ElseIf m_l02 >=240000 .and. m_l02<255000
   m_col2 =07
ElseIf m_l02 >=255000 .and. m_l02<270000
   m_col2 =06
ElseIf m_l02 >=270000 .and. m_l02<285000
   m_col2 =05
ElseIf m_l02 >=285000 .and. m_l02<300000
   m_col2 =04
ElseIf m_l02 >=300000 .and. m_l02<315000
   m_col2 =03
ElseIf m_l02 >=315000
   m_col2 =02
Endif
If m_l03 >0 .and. m_l03 <15000
   m_col3 =23
ElseIf m_l03 >=15000 .and. m_l03 <30000
   m_col3 =22
ElseIf m_l03 >=30000 .and. m_l03 <45000
   m_col3 =21
ElseIf m_l03 >=45000 .and. m_l03 <60000
   m_col3 =20
ElseIf m_l03 >=60000 .and. m_l03 <75000
   m_col3 =19
ElseIf m_l03 >=75000 .and. m_l03 <90000
   m_col3 =18
ElseIf m_l03 >=90000 .and. m_l03<105000
   m_col3 =17
ElseIf m_l03 >=105000 .and. m_l03<120000
   m_col3 =16
ElseIf m_l03 >=120000 .and. m_l03<135000
   m_col3 =15
ElseIf m_l03 >=135000 .and. m_l03<150000
   m_col3 =14
ElseIf m_l03 >=150000 .and. m_l03<165000
   m_col3 =13
ElseIf m_l03 >=165000 .and. m_l03<180000
   m_col3 =12
ElseIf m_l03 >=180000 .and. m_l03<195000
   m_col3 =11
ElseIf m_l03 >=195000 .and. m_l03<210000
   m_col3 =10
ElseIf m_l03 >=210000 .and. m_l03<225000
   m_col3 =09
ElseIf m_l03 >=225000 .and. m_l03<240000
   m_col3 =08
ElseIf m_l03 >=240000 .and. m_l03<255000
   m_col3 =07
ElseIf m_l03 >=255000 .and. m_l03<270000
   m_col3 =06
ElseIf m_l03 >=270000 .and. m_l03<285000
   m_col3 =05
ElseIf m_l03 >=285000 .and. m_l03<300000
   m_col3 =04
ElseIf m_l03 >=300000 .and. m_l03<315000
   m_col3 =03
ElseIf m_l03 >=315000
   m_col3 =02
Endif
If m_l04 >0 .and. m_l04 <15000
   m_col4 =23
ElseIf m_l04 >=15000 .and. m_l04 <30000
   m_col4 =22
ElseIf m_l04 >=30000 .and. m_l04 <45000
   m_col4 =21
ElseIf m_l04 >=45000 .and. m_l04 <60000
   m_col4 =20
ElseIf m_l04 >=60000 .and. m_l04 <75000
   m_col4 =19
ElseIf m_l04 >=75000 .and. m_l04 <90000
   m_col4 =18
ElseIf m_l04 >=90000 .and. m_l04<105000
   m_col4 =17
ElseIf m_l04 >=105000 .and. m_l04<120000
   m_col4 =16
ElseIf m_l04 >=120000 .and. m_l04<135000
   m_col4 =15
ElseIf m_l04 >=135000 .and. m_l04<150000
   m_col4 =14
ElseIf m_l04 >=150000 .and. m_l04<165000
   m_col4 =13
ElseIf m_l04 >=165000 .and. m_l04<180000
   m_col4 =12
ElseIf m_l04 >=180000 .and. m_l04<195000
   m_col4 =11
ElseIf m_l04 >=195000 .and. m_l04<210000
   m_col4 =10
ElseIf m_l04 >=210000 .and. m_l04<225000
   m_col4 =09
ElseIf m_l04 >=225000 .and. m_l04<240000
   m_col4 =08
ElseIf m_l04 >=240000 .and. m_l04<255000
   m_col4 =07
ElseIf m_l04 >=255000 .and. m_l04<270000
   m_col4 =06
ElseIf m_l04 >=270000 .and. m_l04<285000
   m_col4 =05
ElseIf m_l04 >=285000 .and. m_l04<300000
   m_col4 =04
ElseIf m_l04 >=300000 .and. m_l04<315000
   m_col4 =03
ElseIf m_l04 >=315000
   m_col4 =02
Endif
If m_l05 >0 .and. m_l05 <15000
   m_col5 =23
ElseIf m_l05 >=15000 .and. m_l05 <30000
   m_col5 =22
ElseIf m_l05 >=30000 .and. m_l05 <45000
   m_col5 =21
ElseIf m_l05 >=45000 .and. m_l05 <60000
   m_col5 =20
ElseIf m_l05 >=60000 .and. m_l05 <75000
   m_col5 =19
ElseIf m_l05 >=75000 .and. m_l05 <90000
   m_col5 =18
ElseIf m_l05 >=90000 .and. m_l05<105000
   m_col5 =17
ElseIf m_l05 >=105000 .and. m_l05<120000
   m_col5 =16
ElseIf m_l05 >=120000 .and. m_l05<135000
   m_col5 =15
ElseIf m_l05 >=135000 .and. m_l05<150000
   m_col5 =14
ElseIf m_l05 >=150000 .and. m_l05<165000
   m_col5 =13
ElseIf m_l05 >=165000 .and. m_l05<180000
   m_col5 =12
ElseIf m_l05 >=180000 .and. m_l05<195000
   m_col5 =11
ElseIf m_l05 >=195000 .and. m_l05<210000
   m_col5 =10
ElseIf m_l05 >=210000 .and. m_l05<225000
   m_col5 =09
ElseIf m_l05 >=225000 .and. m_l05<240000
   m_col5 =08
ElseIf m_l05 >=240000 .and. m_l05<255000
   m_col5 =07
ElseIf m_l05 >=255000 .and. m_l05<270000
   m_col5 =06
ElseIf m_l05 >=270000 .and. m_l05<285000
   m_col5 =05
ElseIf m_l05 >=285000 .and. m_l05<300000
   m_col5 =04
ElseIf m_l05 >=300000 .and. m_l05<315000
   m_col5 =03
ElseIf m_l05 >=315000
   m_col5 =02
Endif
If m_l06 >0 .and. m_l06 <15000
   m_col6 =23
ElseIf m_l06 >=15000 .and. m_l06 <30000
   m_col6 =22
ElseIf m_l06 >=30000 .and. m_l06 <45000
   m_col6 =21
ElseIf m_l06 >=45000 .and. m_l06 <60000
   m_col6 =20
ElseIf m_l06 >=60000 .and. m_l06 <75000
   m_col6 =19
ElseIf m_l06 >=75000 .and. m_l06 <90000
   m_col6 =18
ElseIf m_l06 >=90000 .and. m_l06<105000
   m_col6 =17
ElseIf m_l06 >=105000 .and. m_l06<120000
   m_col6 =16
ElseIf m_l06 >=120000 .and. m_l06<135000
   m_col6 =15
ElseIf m_l06 >=135000 .and. m_l06<150000
   m_col6 =14
ElseIf m_l06 >=150000 .and. m_l06<165000
   m_col6 =13
ElseIf m_l06 >=165000 .and. m_l06<180000
   m_col6 =12
ElseIf m_l06 >=180000 .and. m_l06<195000
   m_col6 =11
ElseIf m_l06 >=195000 .and. m_l06<210000
   m_col6 =10
ElseIf m_l06 >=210000 .and. m_l06<225000
   m_col6 =09
ElseIf m_l06 >=225000 .and. m_l06<240000
   m_col6 =08
ElseIf m_l06 >=240000 .and. m_l06<255000
   m_col6 =07
ElseIf m_l06 >=255000 .and. m_l06<270000
   m_col6 =06
ElseIf m_l06 >=270000 .and. m_l06<285000
   m_col6 =05
ElseIf m_l06 >=285000 .and. m_l06<300000
   m_col6 =04
ElseIf m_l06 >=300000 .and. m_l06<315000
   m_col6 =03
ElseIf m_l06 >=315000
   m_col6 =02
Endif
If m_l07 >0 .and. m_l07 <15000
   m_col7 =23
ElseIf m_l07 >=15000 .and. m_l07 <30000
   m_col7 =22
ElseIf m_l07 >=30000 .and. m_l07 <45000
   m_col7 =21
ElseIf m_l07 >=45000 .and. m_l07 <60000
   m_col7 =20
ElseIf m_l07 >=60000 .and. m_l07 <75000
   m_col7 =19
ElseIf m_l07 >=75000 .and. m_l07 <90000
   m_col7 =18
ElseIf m_l07 >=90000 .and. m_l07<105000
   m_col7 =17
ElseIf m_l07 >=105000 .and. m_l07<120000
   m_col7 =16
ElseIf m_l07 >=120000 .and. m_l07<135000
   m_col7 =15
ElseIf m_l07 >=135000 .and. m_l07<150000
   m_col7 =14
ElseIf m_l07 >=150000 .and. m_l07<165000
   m_col7 =13
ElseIf m_l07 >=165000 .and. m_l07<180000
   m_col7 =12
ElseIf m_l07 >=180000 .and. m_l07<195000
   m_col7 =11
ElseIf m_l07 >=195000 .and. m_l07<210000
   m_col7 =10
ElseIf m_l07 >=210000 .and. m_l07<225000
   m_col7 =09
ElseIf m_l07 >=225000 .and. m_l07<240000
   m_col7 =08
ElseIf m_l07 >=240000 .and. m_l07<255000
   m_col7 =07
ElseIf m_l07 >=255000 .and. m_l07<270000
   m_col7 =06
ElseIf m_l07 >=270000 .and. m_l07<285000
   m_col7 =05
ElseIf m_l07 >=285000 .and. m_l07<300000
   m_col7 =04
ElseIf m_l07 >=300000 .and. m_l07<315000
   m_col7 =03
ElseIf m_l07 >=315000
   m_col7 =02
Endif
If m_l08 >0 .and. m_l08 <15000
   m_col8 =23
ElseIf m_l08 >=15000 .and. m_l08 <30000
   m_col8 =22
ElseIf m_l08 >=30000 .and. m_l08 <45000
   m_col8 =21
ElseIf m_l08 >=45000 .and. m_l08 <60000
   m_col8 =20
ElseIf m_l08 >=60000 .and. m_l08 <75000
   m_col8 =19
ElseIf m_l08 >=75000 .and. m_l08 <90000
   m_col8 =18
ElseIf m_l08 >=90000 .and. m_l08<105000
   m_col8 =17
ElseIf m_l08 >=105000 .and. m_l08<120000
   m_col8 =16
ElseIf m_l08 >=120000 .and. m_l08<135000
   m_col8 =15
ElseIf m_l08 >=135000 .and. m_l08<150000
   m_col8 =14
ElseIf m_l08 >=150000 .and. m_l08<165000
   m_col8 =13
ElseIf m_l08 >=165000 .and. m_l08<180000
   m_col8 =12
ElseIf m_l08 >=180000 .and. m_l08<195000
   m_col8 =11
ElseIf m_l08 >=195000 .and. m_l08<210000
   m_col8 =10
ElseIf m_l08 >=210000 .and. m_l08<225000
   m_col8 =09
ElseIf m_l08 >=225000 .and. m_l08<240000
   m_col8 =08
ElseIf m_l08 >=240000 .and. m_l08<255000
   m_col8 =07
ElseIf m_l08 >=255000 .and. m_l08<270000
   m_col8 =06
ElseIf m_l08 >=270000 .and. m_l08<285000
   m_col8 =05
ElseIf m_l08 >=285000 .and. m_l08<300000
   m_col8 =04
ElseIf m_l08 >=300000 .and. m_l08<315000
   m_col8 =03
ElseIf m_l08 >=315000
   m_col8 =02
Endif
If m_l09 >0 .and. m_l09 <15000
   m_col9 =23
ElseIf m_l09 >=15000 .and. m_l09 <30000
   m_col9 =22
ElseIf m_l09 >=30000 .and. m_l09 <45000
   m_col9 =21
ElseIf m_l09 >=45000 .and. m_l09 <60000
   m_col9 =20
ElseIf m_l09 >=60000 .and. m_l09 <75000
   m_col9 =19
ElseIf m_l09 >=75000 .and. m_l09 <90000
   m_col9 =18
ElseIf m_l09 >=90000 .and. m_l09<105000
   m_col9 =17
ElseIf m_l09 >=105000 .and. m_l09<120000
   m_col9 =16
ElseIf m_l09 >=120000 .and. m_l09<135000
   m_col9 =15
ElseIf m_l09 >=135000 .and. m_l09<150000
   m_col9 =14
ElseIf m_l09 >=150000 .and. m_l09<165000
   m_col9 =13
ElseIf m_l09 >=165000 .and. m_l09<180000
   m_col9 =12
ElseIf m_l09 >=180000 .and. m_l09<195000
   m_col9 =11
ElseIf m_l09 >=195000 .and. m_l09<210000
   m_col9 =10
ElseIf m_l09 >=210000 .and. m_l09<225000
   m_col9 =09
ElseIf m_l09 >=225000 .and. m_l09<240000
   m_col9 =08
ElseIf m_l09 >=240000 .and. m_l09<255000
   m_col9 =07
ElseIf m_l09 >=255000 .and. m_l09<270000
   m_col9 =06
ElseIf m_l09 >=270000 .and. m_l09<285000
   m_col9 =05
ElseIf m_l09 >=285000 .and. m_l09<300000
   m_col9 =04
ElseIf m_l09 >=300000 .and. m_l09<315000
   m_col9 =03
ElseIf m_l09 >=315000
   m_col9 =02
Endif
If m_l10 >0 .and. m_l10 <15000
   m_col10 =23
ElseIf m_l10 >=15000 .and. m_l10 <30000
   m_col10 =22
ElseIf m_l10 >=30000 .and. m_l10 <45000
   m_col10 =21
ElseIf m_l10 >=45000 .and. m_l10 <60000
   m_col10 =20
ElseIf m_l10 >=60000 .and. m_l10 <75000
   m_col10 =19
ElseIf m_l10 >=75000 .and. m_l10 <90000
   m_col10 =18
ElseIf m_l10 >=90000 .and. m_l10<105000
   m_col10 =17
ElseIf m_l10 >=105000 .and. m_l10<120000
   m_col10 =16
ElseIf m_l10 >=120000 .and. m_l10<135000
   m_col10 =15
ElseIf m_l10 >=135000 .and. m_l10<150000
   m_col10 =14
ElseIf m_l10 >=150000 .and. m_l10<165000
   m_col10 =13
ElseIf m_l10 >=165000 .and. m_l10<180000
   m_col10 =12
ElseIf m_l10 >=180000 .and. m_l10<195000
   m_col10 =11
ElseIf m_l10 >=195000 .and. m_l10<210000
   m_col10 =10
ElseIf m_l10 >=210000 .and. m_l10<225000
   m_col10 =09
ElseIf m_l10 >=225000 .and. m_l10<240000
   m_col10 =08
ElseIf m_l10 >=240000 .and. m_l10<255000
   m_col10 =07
ElseIf m_l10 >=255000 .and. m_l10<270000
   m_col10 =06
ElseIf m_l10 >=270000 .and. m_l10<285000
   m_col10 =05
ElseIf m_l10 >=285000 .and. m_l10<300000
   m_col10 =04
ElseIf m_l10 >=300000 .and. m_l10<315000
   m_col10 =03
ElseIf m_l10 >=315000
   m_col10 =02
Endif
If m_l11 >0 .and. m_l11 <15000
   m_col11 =23
ElseIf m_l11 >=15000 .and. m_l11 <30000
   m_col11 =22
ElseIf m_l11 >=30000 .and. m_l11 <45000
   m_col11 =21
ElseIf m_l11 >=45000 .and. m_l11 <60000
   m_col11 =20
ElseIf m_l11 >=60000 .and. m_l11 <75000
   m_col11 =19
ElseIf m_l11 >=75000 .and. m_l11 <90000
   m_col11 =18
ElseIf m_l11 >=90000 .and. m_l11<105000
   m_col11 =17
ElseIf m_l11 >=105000 .and. m_l11<120000
   m_col11 =16
ElseIf m_l11 >=120000 .and. m_l11<135000
   m_col11 =15
ElseIf m_l11 >=135000 .and. m_l11<150000
   m_col11 =14
ElseIf m_l11 >=150000 .and. m_l11<165000
   m_col11 =13
ElseIf m_l11 >=165000 .and. m_l11<180000
   m_col11 =12
ElseIf m_l11 >=180000 .and. m_l11<195000
   m_col11 =11
ElseIf m_l11 >=195000 .and. m_l11<210000
   m_col11 =10
ElseIf m_l11 >=210000 .and. m_l11<225000
   m_col11 =09
ElseIf m_l11 >=225000 .and. m_l11<240000
   m_col11 =08
ElseIf m_l11 >=240000 .and. m_l11<255000
   m_col11 =07
ElseIf m_l11 >=255000 .and. m_l11<270000
   m_col11 =06
ElseIf m_l11 >=270000 .and. m_l11<285000
   m_col11 =05
ElseIf m_l11 >=285000 .and. m_l11<300000
   m_col11 =04
ElseIf m_l11 >=300000 .and. m_l11<315000
   m_col11 =03
ElseIf m_l11 >=315000
   m_col11 =02
Endif
If m_l12 >0 .and. m_l12 <15000
   m_col12 =23
ElseIf m_l12 >=15000 .and. m_l12 <30000
   m_col12 =22
ElseIf m_l12 >=30000 .and. m_l12 <45000
   m_col12 =21
ElseIf m_l12 >=45000 .and. m_l12 <60000
   m_col12 =20
ElseIf m_l12 >=60000 .and. m_l12 <75000
   m_col12 =19
ElseIf m_l12 >=75000 .and. m_l12 <90000
   m_col12 =18
ElseIf m_l12 >=90000 .and. m_l12<105000
   m_col12 =17
ElseIf m_l12 >=105000 .and. m_l12<120000
   m_col12 =16
ElseIf m_l12 >=120000 .and. m_l12<135000
   m_col12 =15
ElseIf m_l12 >=135000 .and. m_l12<150000
   m_col12 =14
ElseIf m_l12 >=150000 .and. m_l12<165000
   m_col12 =13
ElseIf m_l12 >=165000 .and. m_l12<180000
   m_col12 =12
ElseIf m_l12 >=180000 .and. m_l12<195000
   m_col12 =11
ElseIf m_l12 >=195000 .and. m_l12<210000
   m_col12 =10
ElseIf m_l12 >=210000 .and. m_l12<225000
   m_col12 =09
ElseIf m_l12 >=225000 .and. m_l12<240000
   m_col12 =08
ElseIf m_l12 >=240000 .and. m_l12<255000
   m_col12 =07
ElseIf m_l12 >=255000 .and. m_l12<270000
   m_col12 =06
ElseIf m_l12 >=270000 .and. m_l12<285000
   m_col12 =05
ElseIf m_l12 >=285000 .and. m_l12<300000
   m_col12 =04
ElseIf m_l12 >=300000 .and. m_l12<315000
   m_col12 =03
ElseIf m_l12 >=315000
   m_col12 =02
Endif


setcolor( "GR/W" )  ; @ m_col1-1, 16 say "Jan"
setcolor( "GR/GR+" )  ; @ m_col1, 16 clear to 22,18
setcolor( "GR/W" )
    @ 24,17 say "1"
setcolor( "N/W" )    ; @ m_col2-1, 20 say "Fev"
setcolor( "W+/N" )    ; @ m_col2, 20 clear to 22,22
setcolor( "N/W" )
    @ 24,21 say "2"
setcolor( "R/W" )     ; @ m_col3-1, 24 say "Mar"
setcolor( "W/R" )     ; @ m_col3, 24 clear to 22,26
setcolor( "R/W" )
    @ 24,25 say "3"
setcolor( "RB/W" )  ; @ m_col4-1, 28 say "Abr"
setcolor( "RB/RB+" )  ; @ m_col4, 28 clear to 22,30
setcolor( "RB/W" )
    @ 24,29 say "4"
setcolor( "G/W" )   ; @ m_col5-1, 32 say "Mai"
setcolor( "G+/G+" )   ; @ m_col5, 32 clear to 22,34
setcolor( "G/W" )
    @ 24,33 say "5"
setcolor( "BG+/W" )  ; @ m_col6-1, 36 say "Jun"
setcolor( "BG/BG+" )  ; @ m_col6, 36 clear to 22,38
setcolor( "BG+/W" )
    @ 24,37 say "6"
setcolor( "B/W" )   ; @ m_col7-1, 40 say "Jul"
setcolor( "B+/B+" )   ; @ m_col7, 40 clear to 22,42
setcolor( "B/W" )
    @ 24,41 say "7"
setcolor( "GR+/W" )   ; @ m_col8-1, 44 say "Ago"
setcolor( "W/GR+" )   ; @ m_col8, 44 clear to 22,46
setcolor( "GR+/W" )
    @ 24,45 say "8"
setcolor( "R+/W+" )   ; @ m_col9-1, 48 say "Set"
setcolor( "BG/R" )   ; @ m_col9, 48 clear to 22,50
setcolor( "R+/W" )
    @ 24,49 say "9"
setcolor( "GR/W" )  ; @ m_col10-1, 52 say "Out"
setcolor( "GR/GR+" )  ; @ m_col10, 52 clear to 22,54
setcolor( "GR/W" )
    @ 24,53 say "10"
setcolor( "N/W" )    ; @ m_col11-1, 56 say "Nov"
setcolor( "W+/N" )    ; @ m_col11, 56 clear to 22,58
setcolor( "N/W" )
    @ 24,57 say "11"
setcolor( "R/W" )    ; @ m_col12-1, 60 say "Dez"
setcolor( "W/R+" )    ; @ m_col12, 60 clear to 22,62
setcolor( "R/W" )
    @ 24,61 say "12"

Inkey(0)
	  Release m_l01,m_l02,m_l03,m_l04,m_l05,m_l06,m_l07,m_l08,m_l09,m_l10,m_l11,m_l12,X,m_dat1,m_dat2
	  Release m_col1,m_col2,m_col3,m_col4,m_col5,m_col6,m_col7,m_col8,m_col9,m_col10,m_col11,m_col12

restscreen(,,,,sst)

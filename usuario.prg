#include "box.ch"
#include "migracao.ch"

Procedure Usuario()

SET CURSOR ON
SSU=SAVESCREEN(00,00,24,79)
WHILE .T.
DO CASE
   CASE LASTKEY() = 27
        clear
	CLOSE ALL
	QUIT
   CASE OPC = 4
	SEN()
      IF SE = "N"
	 ALERT("Acesso N„o Autorizado")
	 OKSENH = "N"
	 LOOP
      ENDIF
 WHILE .T.
  SC = SAVESCREEN(12,50,16,77)
   SETCOLOR("W+/R+")
   SOMBRA(12,50,15,76,BOX)
   M_NOMEUSU = SPACE(15)
   M_ACESSO  = SPACE(15)
   @ 13,51 SAY "Usu rio :"GET M_NOMEUSU VALID M_NOMEUSU <> SPACE(15)
   COR=SETCOLOR()
   SETCOLOR(C_CORS)
   @ 14,51 SAY "ACESSO  :"GET M_ACESSO PICT "@!"
   READ
   SETCOLOR(COR)
   IF LASTKEY() = 27
  RESTSCREEN(12,50,16,77,SC)
      EXIT
   ENDIF
     SEEK M_NOMEUSU
	  IF EOF()
	     S=SAVESCREEN(23,00,23,80)
	     @ 23,00 CLEAR TO 23,79
	     @ 23,01 SAY "Usu rio N„o Cadastrado... Verifique !"
	     INKEY(3)
	     @ 23,00 CLEAR TO 23,79
	     RESTSCREEN(23,00,23,80,S)
	     LOOP
	  ENDIF
	  IF ACESSO <> M_ACESSO
	     S=SAVESCREEN(23,00,23,80)
	     @ 23,00 CLEAR TO 23,79
	     @ 23,01 SAY "Senha N„o Cadastrada... Verifique !"
	     INKEY(3)
	     M_CONT = M_CONT +1
	     @ 23,00 CLEAR TO 23,79
	     RESTSCREEN(23,00,23,80,S)
	     LOOP
	  ENDIF
       CONFIRMA()
     IF LASTKEY() = 13
        IF BLOQREG(0)
	  DELETE
	  COMM
	  UNLOCK
        ENDIF
     ENDIF
  RESTSCREEN(12,50,16,77,SC)
     EXIT
 ENDDO
   CASE OPC = 2 .OR. OPC = 3
	SEN()
      IF SE = "N"
	ALERT("Acesso N„o Autorizado")
	 OKSENH = "N"
	 LOOP
      ENDIF
  IF OPC = 2
  SC = SAVESCREEN(12,50,16,77)
    SETCOLOR("W+/R+")
    SOMBRA(12,50,15,76,BOX)
    M_NOMEUSU = SPACE(15)
    M_ACESSO  = SPACE(15)
    @ 13,51 SAY "Usu rio :"GET M_NOMEUSU VALID M_NOMEUSU <> SPACE(15)
    COR=SETCOLOR()
    SETCOLOR(C_CORS)
    @ 14,51 SAY "ACESSO  :"GET M_ACESSO PICT "@!"
      READ
    SETCOLOR(COR)
   IF LASTKEY() = 27
  RESTSCREEN(12,50,16,77,SC)
      EXIT
   ENDIF
     SEEK M_NOMEUSU
	  IF !EOF()
	     tone(90,5)
	     S=SAVESCREEN(23,00,23,80)
	     @ 23,00 CLEAR TO 23,79
	     @ 23,01 SAY "Usu rio J  Cadastrado... Verifique !"
	     INKEY(3)
	     @ 23,00 CLEAR TO 23,79
	     RESTSCREEN(23,00,23,80,S)
	     LOOP
	  ENDIF
  ELSE
  SC = SAVESCREEN(12,50,16,77)
    SETCOLOR("W+/R+")
    SOMBRA(12,50,15,76,BOX)
    M_NOMEUSU = SPACE(15)
    M_ACESSO  = SPACE(15)
    @ 13,51 SAY "Usu rio :"GET M_NOMEUSU VALID M_NOMEUSU <> SPACE(15)
    COR=SETCOLOR()
    SETCOLOR(C_CORS)
    @ 14,51 SAY "ACESSO  :"GET M_ACESSO PICT "@!"
    READ
    SETCOLOR(COR)
    IF LASTKEY() = 27
       RESTSCREEN(12,50,16,77,SC)
       EXIT
    ENDIF
    SEEK M_NOMEUSU
	  IF EOF()
	     tone(90,5)
	     S=SAVESCREEN(23,00,23,80)
	     @ 23,00 CLEAR TO 23,79
	     @ 23,01 SAY "Usu rio N„o Cadastrado... Verifique !"
	     INKEY(3)
	     @ 23,00 CLEAR TO 23,79
	     RESTSCREEN(23,00,23,80,S)
	     LOOP
	  ENDIF
	  IF ACESSO <> M_ACESSO
	     tone(90,5)
	     S=SAVESCREEN(23,00,23,80)
	     @ 23,00 CLEAR TO 23,79
	     @ 23,01 SAY "Acesso Incorreto... Verifique !"
	     INKEY(3)
	     @ 23,00 CLEAR TO 23,79
	     RESTSCREEN(23,00,23,80,S)
	     LOOP
	  ENDIF

    SETCOLOR("W+/R+")
    SOMBRA(12,50,15,76,BOX)
    M_NOMEUSU = SPACE(15)
    M_ACESSO  = SPACE(15)
    @ 13,51 SAY "Novo Usu:"GET M_NOMEUSU VALID M_NOMEUSU <> SPACE(15)
    COR=SETCOLOR()
    SETCOLOR(C_CORS)
    @ 14,51 SAY "Novo Acs:"GET M_ACESSO PICT "@!"
    READ
    SETCOLOR(COR)
    IF LASTKEY() = 27
       EXIT
    ENDIF
  ENDIF

   IF OPC = 2
      CLIE1 ="N"
      CLIE2 ="N"
      CLIE3 ="N"
      FORN1 ="N"
      FORN2 ="N"
      FORN3 ="N"
      FORN4 ="N"
      FORN5 ="N"
      ESTO1 ="N"
      ESTO2 ="N"
      ESTO3 ="N"
      ESTO4 ="N"
      ESTO5 ="N"
      ESTO6 ="N"
      ESTO7 ="N"
      ESTO9 ="N"
      CUST7 ="N"
      MOVD1 ="N"
      MOVD2 ="N"
      MOVD3 ="N"
      MOVD4 ="N"
      MOVD5 ="N"
      MOVD6 ="N"
      MOVD7 ="N"
      MOVD8 ="N"
      MOVD9 ="N"
      MOVD10="N"
      MOVD11="N"
      MOVD12="N"
      MOVD13="N"
      MOVD14="N"
      MOVD15="N"
      MOVD16="N"
      RELE1 ="N"
      RELE2 ="N"
      RELE3 ="N"
      RELE4 ="N"
      RELE5 ="N"
      RELE6 ="N"
      RELE7 ="N"
      RELE8 ="N"
      RELE9 ="N"
      RELE10="N"
      RELE11="N"
      RELE12="N"
      RELE13="N"
      RELE14="N"
      PAGA1 ="N"
      PAGA2 ="N"
      RECE1 ="N"
      RECE2 ="N"
      CHEQ1 ="N"
      CHEQ2 ="N"
      UTIL1 ="N"
      VEND1 ="N"
      VEND2 ="N"
      VEND3 =0
   ELSE
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
   ENDIF
SSS=SAVESCREEN(05,10,23,45)
SETCOLOR("BG/B")
SOMBRA(05,10,09,31,BOX)
@ 06,11 SAY "Cadastra Clientes "GET CLIE1 PICT "@!"
@ 07,11 SAY "Consulta Clientes "GET CLIE2 PICT "@!"
@ 08,11 SAY "Emite Rel.Cliente "GET CLIE3 PICT "@!"
READ
tone(100,2)
SOMBRA(05,10,11,31,BOX)
@ 06,11 SAY "Cadastra Forneced "GET FORN1 PICT "@!"
@ 07,11 SAY "Consulta Forneced "GET FORN2 PICT "@!"
@ 08,11 SAY "Emite Rel.Fornec. "GET FORN3 PICT "@!"
@ 09,11 SAY "Cadastra Pedidos  "GET FORN4 PICT "@!"
@ 10,11 SAY "Consulta/Impr.Ped "GET FORN5 PICT "@!"
READ
tone(100,2)
SOMBRA(05,10,16,31,BOX)
@ 06,11 SAY "Cadastra Estoques "GET ESTO1 PICT "@!"
@ 07,11 SAY "Consulta Estoques "GET ESTO2 PICT "@!"
@ 08,11 SAY "Emite Rel.Estoques"GET ESTO3 PICT "@!"
@ 09,11 SAY "Altera Pre‡os     "GET ESTO4 PICT "@!"
@ 10,11 SAY "Cadastra Grupos   "GET ESTO5 PICT "@!"
@ 11,11 SAY "Ver Totaliza‡”es  "GET ESTO6 PICT "@!"
@ 12,11 SAY "Custos/Vda a Vista"GET CUST7 PICT "@!"  && Sà PARA ORCAMENTOS (VENDA A VISTA)
@ 13,11 SAY "S¢ p/Orcamentos Vda a Vista"
@ 14,11 SAY "Faz Reserva de Est"GET ESTO7 PICT "@!"
@ 15,11 SAY "Efetua Transfer..."GET ESTO9 PICT "@!"
READ
tone(100,2)
SOMBRA(05,10,19,31,BOX)
@ 06,11 SAY "Relat¢rio Estoques"GET RELE1  PICT "@!"
@ 07,11 SAY "Tabela de Pre‡os  "GET RELE2  PICT "@!"
@ 08,11 SAY "Rel.Vendas        "GET RELE3  PICT "@!"
@ 09,11 SAY "Rel.Faltas        "GET RELE4  PICT "@!"
@ 10,11 SAY "Rel.Excessos      "GET RELE5  PICT "@!"
@ 11,11 SAY "Rel.Prods.a Repor "GET RELE6  PICT "@!"
@ 12,11 SAY "Rel.Proje‡ƒo de Pr"GET RELE7  PICT "@!"
@ 13,11 SAY "Rel.Curva ABC     "GET RELE8  PICT "@!"
@ 14,11 SAY "Rel.Rotatividade  "GET RELE9  PICT "@!"
@ 15,11 SAY "Rel.Compras Client"GET RELE10 PICT "@!"
@ 16,11 SAY "Rel.Invent rio    "GET RELE12 PICT "@!"
@ 17,11 SAY "Rel.Invent/Custos "GET RELE13 PICT "@!"
@ 18,11 SAY "Rel.Entradas      "GET RELE14 PICT "@!"
READ
tone(100,2)
SOMBRA(05,10,19,31,BOX)
@ 06,11 SAY "Movimento Di rio  "GET MOVD1  PICT "@!"
@ 07,11 SAY "Efetua Vendas     "GET MOVD2  PICT "@!"
@ 08,11 SAY "Consulta Vendas   "GET MOVD3  PICT "@!"
@ 09,11 SAY "Cancela Vendas    "GET MOVD4  PICT "@!"
/*
@ 10,11 SAY "Efetua Compras    "GET MOVD5  PICT "@!"
@ 11,11 SAY "Consulta Compras  "GET MOVD6  PICT "@!"
@ 12,11 SAY "Cancela Compras   "GET MOVD7  PICT "@!"
*/
@ 10,11 SAY "Entradas/Compras  "GET MOVD8  PICT "@!"
@ 11,11 SAY "Sa¡das Estoque    "GET MOVD9  PICT "@!"
@ 12,11 SAY "Ver Impostos      "GET MOVD10 PICT "@!"
@ 13,11 SAY "Caixa Di rio      "GET MOVD11 PICT "@!"
@ 14,11 SAY "Modifica La‡to.Cx."GET MOVD16 PICT "@!"
@ 15,11 SAY "Emite Rel.Cx.Di ri"GET MOVD12 PICT "@!"
@ 16,11 SAY "Despesas/Plano Ct."GET MOVD13 PICT "@!"
@ 17,11 SAY "Emite Rel.Despesas"GET MOVD14 PICT "@!"
@ 18,11 SAY "Ver Demonstrativos"GET MOVD15 PICT "@!"
READ
tone(100,2)
SOMBRA(05,10,16,32,BOX)
@ 06,11 SAY "Contas a Pagar    "GET PAGA1 PICT "@!"
@ 07,11 SAY "Cheques a Pagar   "GET PAGA2 PICT "@!"
@ 08,11 SAY "Ctas a Rec./Cheque"GET RECE1 PICT "@!"
@ 09,11 SAY "Ver.Rel.Ctas.a Rec"GET RECE2 PICT "@!"
@ 10,11 SAY "Cheques a Rec/Bcos"GET CHEQ1 PICT "@!"
@ 11,11 SAY "Contas Correntes  "GET CHEQ2 PICT "@!"
@ 12,11 SAY "Utilit rios       "GET UTIL1 PICT "@!"
@ 13,11 SAY "Cadastra Vendedor "GET VEND1 PICT "@!"
@ 14,11 SAY "Ver Comiss”es     "GET VEND2 PICT "@!"
@ 15,11 SAY "Vendedor N£mero   "GET VEND3 PICT "99"
READ
tone(100,2)
RESTSCREEN(05,10,23,45,SSS)
CONFIRMA()
 IF LASTKEY() = 13
   IF OPC = 2
     IF ADIREG(0)
     ENDIF
   ENDIF
    IF BLOQREG(0)
      REPLACE U_CLIE1 WITH CLIE1
      REPLACE U_CLIE2 WITH CLIE2
      REPLACE U_CLIE3 WITH CLIE3
      REPLACE U_FORN1 WITH FORN1
      REPLACE U_FORN2 WITH FORN2
      REPLACE U_FORN3 WITH FORN3
      REPLACE U_FORN4 WITH FORN4
      REPLACE U_FORN5 WITH FORN5
      REPLACE U_ESTO1 WITH ESTO1
      REPLACE U_ESTO2 WITH ESTO2
      REPLACE U_ESTO3 WITH ESTO3
      REPLACE U_ESTO4 WITH ESTO4
      REPLACE U_ESTO5 WITH ESTO5
      REPLACE U_ESTO6 WITH ESTO6
      REPLACE U_CUSTO WITH CUST7
      REPLACE U_MOVD1 WITH MOVD1
      REPLACE U_MOVD2 WITH MOVD2
      REPLACE U_MOVD3 WITH MOVD3
      REPLACE U_MOVD4 WITH MOVD4
      REPLACE U_MOVD5 WITH MOVD5
      REPLACE U_MOVD6 WITH MOVD6
      REPLACE U_MOVD7 WITH MOVD7
      REPLACE U_MOVD8 WITH MOVD8
      REPLACE U_MOVD9 WITH MOVD9
      REPLACE U_MOVD10 WITH MOVD10
      REPLACE U_MOVD11 WITH MOVD11
      REPLACE U_MOVD12 WITH MOVD12
      REPLACE U_MOVD13 WITH MOVD13
      REPLACE U_MOVD14 WITH MOVD14
      REPLACE U_MOVD15 WITH MOVD15
      REPLACE U_MOVD16 WITH MOVD16
      REPLACE U_RELE1 WITH RELE1
      REPLACE U_RELE2 WITH RELE2
      REPLACE U_RELE3 WITH RELE3
      REPLACE U_RELE4 WITH RELE4
      REPLACE U_RELE5 WITH RELE5
      REPLACE U_RELE6 WITH RELE6
      REPLACE U_RELE7 WITH RELE7
      REPLACE U_RELE8 WITH RELE8
      REPLACE U_RELE9 WITH RELE9
      REPLACE U_RELE10 WITH RELE10
      REPLACE U_RELE11 WITH RELE11
      REPLACE U_RELE12 WITH RELE12
      REPLACE U_RELE13 WITH RELE13
      REPLACE U_RELE14 WITH RELE14
      REPLACE NOMEUSU  WITH M_NOMEUSU
      REPLACE ACESSO   WITH M_ACESSO
      REPLACE U_PAGA1  WITH PAGA1
      REPLACE U_PAGA2  WITH PAGA2
      REPLACE U_RECE1  WITH RECE1
      REPLACE U_RECE2  WITH RECE2
      REPLACE U_CHEQ1  WITH CHEQ1
      REPLACE U_CHEQ2  WITH CHEQ2
      REPLACE U_UTIL1  WITH UTIL1
      REPLACE U_VEND1  WITH VEND1
      REPLACE U_VEND2  WITH VEND2
      REPLACE U_ESTO7 WITH ESTO7
      REPLACE U_ESTO9 WITH ESTO9
      REPLACE U_VEND3 WITH VEND3
      COMM
      UNLOCK
    ENDIF
   ENDIF
ENDCASE
ENDDO
**************
PROCEDURE SEN
**************
S=SAVESCREEN(18,30,21,51)
SETCOLOR("W+/R+")
SOMBRA(18,30,20,50,BOX)
ACESS = "       "
@ 19,31 SAY "Acesso "
COR=SETCOLOR()
SETCOLOR(C_CORS)
@19,38 GET ACESS PICT "@!"
READ
SETCOLOR(COR)
  IF ACESS = "PROGSEN"
     SE = "S"
  ELSE
     SE = "N"
  ENDIF
RESTSCREEN(18,30,21,51,S)
RETURN
//****************
  PROCEDURE NAOALT
//****************
  COR=SETCOLOR()
  SETCOLOR(VERMEL)
  ALERT("Acesso N„o Autorizado")
  OKSENH = "N"
  SETCOLOR(COR)
RETURN
//************
  PROC MUDAUSU
//************
   SET KEY 22 TO
   SSU=SAVESCREEN(00,00,24,79)
   SET CURSOR ON
   M_CONT = 1
  WHILE M_CONT < 4
   SETCOLOR("W+/R+")
   SHE=SAVESCREEN(10,15,14,43)
   SOMBRA(10,15,13,42,BOX)
   M_NOMEUS = SPACE(15)
   @ 11,16 SAY "Usu rio :"GET M_NOMEUS PICT "@!" VALID M_NOMEUS <> SPACE(15)
   @ 12,16 Say "Acesso:"
   READ
   IF LASTKEY() = 27
      RESTSCREEN(00,00,24,79,SSU)
      RETURN
   ENDIF
 SELE 2
 USE
 SELE 2
 VERIOUT(SETCOLOR(),23,"usuario")
 *SET INDEX TO m_usu
 SET INDEX TO index_usuario
 SELE 2
 SET ORDER TO 1
     SEEK M_NOMEUS
	  IF EOF()
	     Alert("Usu rio N„o Cadastrado... Verifique Usu rio !")
	     M_CONT = M_CONT +1
	     RESTSCREEN(10,15,14,43,SHE)
	     RETURN
	  ENDIF
	    M_NOMEUSU=M_NOMEUS
	    M_ACESSO=ACESSO
	    SENHA(M_ACESSO)
	  IF ACESSO <> M_ACESSO
             Alert("Senha N„o Cadastrada... Verifique !")
	     M_CONT = M_CONT +1
	     LOOP
	  ELSE
	     OKSENH = "S"
	     EXIT
	  ENDIF
   ENDDO
        IF M_CONT >=3
	   SET COLOR TO
	   TONE(500,4)
           CLEAR
	   @ 12,28 SAY "Acesso N„o Autorizado"
	   INKEY(2)
	   CLOSE ALL
           CLEAR
 	   QUIT
	ENDIF
      CLIE1=U_CLIE1
      CLIE2=U_CLIE2
      CLIE3=U_CLIE3
      FORN1=U_FORN1
      FORN2=U_FORN2
      FORN3=U_FORN3
      FORN4=U_FORN4
      FORN5=U_FORN5
      ESTO1=U_ESTO1
      ESTO2=U_ESTO2
      ESTO3=U_ESTO3
      ESTO4=U_ESTO4
      ESTO5=U_ESTO5
      ESTO6=U_ESTO6
      ESTO7=U_ESTO7
      ESTO9=U_ESTO9
      CUST7=U_CUSTO
      MOVD1=U_MOVD1
      MOVD2=U_MOVD2
      MOVD3=U_MOVD3
      MOVD4=U_MOVD4
      MOVD5=U_MOVD5
      MOVD6=U_MOVD6
      MOVD7=U_MOVD7
      MOVD8=U_MOVD8
      MOVD9=U_MOVD9
      MOVD10=U_MOVD10
      MOVD11=U_MOVD11
      MOVD12=U_MOVD12
      MOVD13=U_MOVD13
      MOVD14=U_MOVD14
      MOVD15=U_MOVD15
      MOVD16=U_MOVD16
      RELE1=U_RELE1
      RELE2=U_RELE2
      RELE3=U_RELE3
      RELE4=U_RELE4
      RELE5=U_RELE5
      RELE6=U_RELE6
      RELE7=U_RELE7
      RELE8=U_RELE8
      RELE9=U_RELE9
      RELE10=U_RELE10
      RELE11=U_RELE11
      RELE12=U_RELE12
      RELE13=U_RELE13
      RELE14=U_RELE14
      PAGA1=U_PAGA1
      PAGA2=U_PAGA2
      RECE1=U_RECE1
      RECE2=U_RECE2
      CHEQ1=U_CHEQ1
      CHEQ2=U_CHEQ2
      UTIL1=U_UTIL1
      VEND1=U_VEND1
      VEND2=U_VEND2
      VEND3=U_VEND3
      CX12 =U_CX12
      LOJAU=U_LOJA
      NRLOJA=U_NRLOJA

      RESTSCREEN(00,00,24,79,SSU)
      SETCOLOR(C_CORGX)
      SOMBRA(18,01,20,27,BOX)
      @19,02 SAY "Usu rio : "+M_NOMEUSU
      SETCOLOR(C_CORG)
Close all
CDabre()
Return
*************************
*FUNCTION SENHA(M_SENHACES)
*************************
/*
   chave=M_ACESSO
   lin1=17
   col1=61
   lin2:=lin1+1
   col2:=col1+10
   clear gets
   Priv sen:=savescreen(lin1-1,col1-21,lin2+1,col2+4)
   vez:=0
   clear typeahead
   do while (.t.)
      set cursor on
      senha20:=space(10) ; cont:=vr:=k:=0 ; col:=col1 ; c:=1
	SETCOLOR("W+/R+")
	SOMBRA(16,49,18,76,BOX)
	@ 17,51 say "Acesso :"
      do while (cont<=10)
	@ lin1, col - 1 say " "
	if (col==col1) ; k:=0 ; endif
	if (k!=0) ; @ lin1, col - 1 say "*" ; endif
	t:=inkey(0)
	if (t==13) ; exit ; endif
	if (t=5.or.t=4.or.t=24.or.t=9.or.t=22.or.t=1.or.t=18.or.t=7.or.t=6.or.t=3)
	   loop
	elseif (t=-1.or.t=-2.or.t=-3.or.t=-4.or.t=-5.or.t=-6.or.t=-7.or.t=-8.or.t=-9)
	   loop
	endif
	if (t==27) ; exit ; endif
	if (t=8.or.t=19)
	   vr++
	   if (k==0) ; loop ; endif
	   set color to w+/b
	   @ lin1 , col - 1 say " "
	   col--
	   cont--
	   if (vr==1)
	      c:=c-2
	   else
	      c:=c-1
	   endif
	   senha20:=substr(senha20,1,c)
	   loop
	endif
	@ lin1, col say "*"
	k:=1
	col++
	cont++
	c++
	senha20:=senha20+chr(t)
	vr:=0
      enddo
      if (upper(alltrim(senha20)))==(upper(alltrim(chave)))
	exit
      else
	vez++
	if Chave<>trim(senha20)
	   set cursor off
	   tone(388,4)
	   tone(388,4)
	   SOMBRA(16,49,18,76,BOX)
	   @ 17,57 say "Senha Inv lida"
	endif
	inkey(1)
	if (vez==3)
	   alert("Acesso negado !")
	   CLOSE ALL
	   SET COLOR TO
	   CLS
	   QUIT
	endif
	loop
      endif
   enddo
   M_SENHACES=SENHA20
   restscreen(lin1-1,col1-21,lin2+1,col2+4,sen)
return(M_SENHACES)
*/

//******************
  Procedure TrocaSen(wUsu,wAcess,wRecno)
//******************
 Sele 22
 VERIOUT(SETCOLOR(),23,"usuario")
 SET INDEX TO index_usuario
 SC = SAVESCREEN(12,50,18,78)
 While .t.
  COR=SETCOLOR()
  SETCOLOR("W+/R+")
  Quadro(12,50,16,77,1)
  M_ACESSO  = SPACE(12)
  @ 13,51 SAY "Usu rio  : "+Trim(wUsu)
  @ 14,51 SAY "Nova Senha   :"
  @ 15,51 SAY "Repita Senha :"
  Read
  IF LASTKEY() = 27
     Exit
  Endif
  M_ACESSO = SPACE(12)
  M_ACESS1 = SPACE(12)

  @ 14,65 GET M_ACESSO PICT "@!" Valid M_ACESSO <> SPACE(12)
  @ 15,65 GET M_ACESS1 PICT "@!" Valid M_ACESS1 <> SPACE(12)
  Read
  SETCOLOR(COR)
  IF LASTKEY() = 27 .or. Empty(M_ACESSO) .or. Empty(M_ACESS1)
     Exit
  Endif
  If AllTrim(M_ACESSO) = AllTrim(wAcess)
     Alert("Mesma Senha que a Anterior. Atualizacao Recusada !")
     RestScreen(12,50,18,78,SC)
     Loop
  Endif
  If AllTrim(M_ACESS1) = AllTrim(wAcess)
     Alert("Mesma Senha que a Anterior. Atualizacao Recusada !")
     RestScreen(12,50,18,78,SC)
     Loop
  Endif
  If Alltrim(M_ACESSO) <> Alltrim(M_ACESS1)
     Alert("Senha Recusada !")
     RestScreen(12,50,18,78,SC)
     Loop
  Endif
  Go wRecno
  If BloqReg(0)
     Repl U_DATAI WITH M_DATSI,U_DATAF WITH M_DATSI+180,ACESSO WITH M_ACESS1
  Endif
  Comm
  Unlock
  Exit
Enddo
RESTSCREEN(12,50,18,78,SC)
Release M_USU,M_ACS,SC,New_Acess,wUsu,wRecno
Sele 22
Use
Return

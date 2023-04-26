********************************************************
/* FILE NAME : FUNCOES.PRG
   BY        : HELIO-SP
   DESC      : Funcoes Gerais de Sistema
   */
********************************************************
#include "box.ch"
#include "migracao.ch"
#include "sqlrdd.ch"

FUNCTION TEMPINHO(TEMPO)
************************
IF TEMPO = NIL
   TEMPO = 30
ENDIF
TT = 0
WHILE TT < TEMPO
  TT = TT + 1
ENDDO
RETURN TEMPO
**************************************
FUNCTION QUADRO(LN1,CL1,LN2,CL2,TP,LD) // Abre uma janela
**************************************
IF TP = NIL
   TP = 30
ENDIF
IF LD = NIL
   LD = 2
ENDIF
TRT = CL1
DO WHILE TRT <= CL2
   @ LN1,CL1 CLEAR TO LN2,TRT
   IF LD = 2
      @ LN1,CL1       TO LN2,TRT DOUBLE
   ELSE
      @ LN1,CL1       TO LN2,TRT
   ENDIF
   TRT = TRT + 1
   TEMPINHO(TP)
ENDDO
RETURN 0
*/
PROCEDURE Abrejan()
/*
Sintaxe...: Abrejan(expressao numerica)
Objetivo..: abre a janela de dados do sistema, formada pelo retangulo com
	    as seguintes coordenadas: canto superior esquerdo linha 6 coluna
	    0 e canto inferior direito linha 23 coluna 79.
Parametros: expressao numerica indicando o numero da moldura a ser utiliza-
	    da de acordo com o vetor publico de molduras frame[].
*/
******************************************************************************
//declara as variaveis locais
LOCAL i:=j:=k:=w:=x:=0
SETCOLOR(C_CORN)
i:=13;j:=40;k:=11;w:=39
DO WHILE i>=2
	x+=3
	// retarda um decimo de segundo
	INKEY(.01)
	IF i=2
	// constroi moldura final
        @ 02,00,23,79 BOX frame[1]
	EXIT
ELSE
	//constroi as molduras, alterando sua posicao
	@ --i,j-x,++k,w+x BOX frame[1]
ENDIF
ENDDO
SETCOLOR(C_CORN)
RETURN
//****************
  FUNCTION DESLOCA(LIN1,LIN2,COL1,TEXTO)
//****************
COR=SETCOLOR()
*ssde=savescreen(22,00,22,78)
SETCOLOR(C_CORG)
CUSTAT=SETCURSOR()
SETCURSOR(0)
IF LIN1=NIL
   LIN1=20
   LIN2=23
ENDIF
  IF COL1=NIL
     COL1=20
  ENDIF
IF TEXTO=NIL
   TEXTO = TRIM(XY_EMPRESA)+" è "+XY_SLOGAN+" "+TRIM(XY_ENDEREC)+" "+TRIM(XY_CIDADE)+" "
ENDIF
*@ LIN1-1,COL1-1 TO LIN1+1,COL1+LEN(TEXTO)
PARADA=0
@ 23,01 clear to 23,77
SETCOLOR("g/b")

While PARADA=0
 PARADA=INKEY(.1) && CONTROLA A VELOCIDADE
 @ LIN1,COL1 SAY SUBSTR(TEXTO,1,Len(Texto))
 TEXTO=SUBSTR(TEXTO,2,Len(Texto))+SUBSTR(TEXTO,1,1)
 *@ LIN2,COL1 SAY SUBSTR(TEXTO,1,77)
 *TEXTO=SUBSTR(TEXTO,2,77)+SUBSTR(TEXTO,1,1)
Enddo
Clear
SETCURSOR(CUSTAT)
*restscreen(22,00,22,78,ssde)
Setcolor(cor)
release ssde
RETURN NIL

*************************************
*PROCEDURE SOMBRA(ls,cs,li,ci,moldura)
/*
 Objetivo..: Desenha uma caixa com sombra nas coordenadas e com a
	     moldura especificada
 Parƒmetros:
   ls, cs  -> coordenadas do cando superior direito
   li, ci  -> coordenadas do canto inferior esquerdo
   moldura -> cadeia de caracteres a ser utilizada pelo comando BOX para desenhar
	      uma moldura na caixa
*/
*******************************************************************************
/*
LOCAL vtela
vtela:=SAVESCREEN(ls+1,cs+2,li+1,ci+2)
IF LEN(vtela)>2048
   vtela:=TRANSFORM(SUBSTR(vtela,1,2048),REPLICATE("X"+CHR(8),1000))+;
	  TRANSFORM(SUBSTR(vtela,2049),REPLICATE("X"+CHR(8),1000))
ELSE       // O caractere CHR(8) e o responsavel pela sombra
   vtela:=TRANSFORM(vtela,REPLICATE("X"+CHR(8),LEN(vtela)/2))
ENDIF
RESTSCREEN(ls+1,cs+2,li+1,ci+2,vtela)
@ ls,cs,li,ci BOX moldura
RETURN
*/

//*************************************
  Function SOMBRA(ls,cs,li,ci,moldura)
//*************************************
  @ ls,cs clear to li,ci 
  @ ls,cs to li,ci Double
  DbgShadow(ls,cs,li,ci)
Return

***********************************************************
FUNCTION JAN(LI,CO,LIN,COL,LINHA)
PONTO = COL-CO
PONTO = PONTO /2
PONTO = PONTO+CO
PONTO1= PONTO

DO WHILE PONTO >=CO
IF LINHA=NIL
   LINHA=1
ENDIF
@ LI,PONTO CLEAR TO LIN,PONTO1
IF LINHA = 1
@ LI,PONTO TO LIN,PONTO1
ELSE
@ LI,PONTO TO LIN,PONTO1 DOUBLE
ENDIF
IF PONTO <> CO
  PONTO=PONTO-1
  PONTO1=PONTO1+1
ELSE
   EXIT
ENDIF
   TP = 20
X=1
DO WHILE X < TP
   X=X+1
ENDDO
LOOP
ENDDO

FUNCTION LIMPJAN(LI,CO,LIN,COL)
PONTO = COL-CO
PONTO = PONTO /2
PONTO = PONTO+CO
PONTO1= PONTO

DO WHILE PONTO >=CO
@ LI,PONTO CLEAR TO LIN,PONTO1
IF PONTO <> CO
  PONTO=PONTO-1
  PONTO1=PONTO1+1
ELSE
   EXIT
ENDIF
   TP = 20
X=1
DO WHILE X < TP
   X=X+1
ENDDO
LOOP
ENDDO
******************
PROCEDURE EMPRESA
******************
SAYDATA(0,67)
@ 01,02 Say CurDir()
@ 01,30 SAY TRIM(XY_EMPRESA)
RETURN

//**************
  Function visor
//**************
local nValor:=0
public win_visor, m_visor := {}

setblink( .f. )
 nValor = m_nota
 Set Color to w+/n
/*
 @ 11,15 clear to 17,55
 @ 11,15 to 17,55
 @ 11,35 Say "O R € A M E N T O"
*/
 visor_22( visor_monta( transf( nValor, '@E #######' ) ), 10, 28 )
 SETCOLOR("GR+/B")
 @ 19,08 Say "O R € A M E N T O"
/*
 @ 11,15 clear to 17,55
 @ 11,15 to 17,55
 @ 11,35 Say "O R € A M E N T O"
 visor_22( visor_monta( transf( nValor, '@E #######' ) ), 15, 19 )
*/
 Inkey(60)
 @ 22,00 clear to 24,80
Release win_visor,m_visor,nValor
return nil

* -----------------------------------------------------------------------------
function visor_22(arg1,arg2,arg3,arg4,arg5)
* -----------------------------------------------------------------------------
local m,j,e1,e2,d1,d2
win_visor:=savescreen( 22, 26, 24, 79 )
* arg1 : linha a ser impressa (matriz 3x1)
* arg2 : linha
* arg3 : coluna
 arg4 := 'gr+/b'
 arg5 := 'b+/gr'

*SETCOLOR("G+/b+")
SETCOLOR("w/n+")

arg2 := 17
arg3 := arg3 - 3
/*
arg2 := 12
arg3 := arg3 - 3
*/
for m=1 to len(arg1)
   for j=1 to len(arg1[m])
      if subs(arg1[m],j,1)=chr(219)
         @ arg2+m,j+arg3 say ' ' color "n/w"
      elseif subs(arg1[m],j,1)=chr(220)
         @ arg2+m,j+arg3 say chr(223) color "w+/n"
      else
         @ arg2+m,j+arg3 say subs(arg1[m],j,1) color "w+/n"
      endi
   next
next
return NIL

* -----------------------------------------------------------------------------
func visor_monta(arg1)  // Û 219 / 235
* -----------------------------------------------------------------------------
* parametros passados :
*     arg1 = valor no formato a ser impresso
*
m_visor := {}
declare g1[3],g2[3],g3[3],g4[3],g5[3],g6[3],g7[3],g8[3],g9[3],g0[3],ga[3],gb[3]
g1[1] = 'ÜÛ   '
g1[2] = ' Û   '
g1[3] = 'ßßß  '
g2[1] = 'ßßßÛ '
g2[2] = 'Ûßßß '
g2[3] = 'ßßßß '
g3[1] = 'ßßßÛ '
g3[2] = ' ßßÛ '
g3[3] = 'ßßßß '
g4[1] = 'Û  Û '
g4[2] = 'ßßßÛ '
g4[3] = '   ß '
g5[1] = 'Ûßßß '
g5[2] = 'ßßßÛ '
g5[3] = 'ßßßß '
g6[1] = 'Ûßßß '
g6[2] = 'ÛßßÛ '
g6[3] = 'ßßßß '
g7[1] = 'ßßßÛ '
g7[2] = ' Üß  '
g7[3] = ' ß   '
g8[1] = 'ÛßßÛ '
g8[2] = 'ÛßßÛ '
g8[3] = 'ßßßß '
g9[1] = 'ÛßßÛ '
g9[2] = 'ßßßÛ '
g9[3] = 'ßßßß '
g0[1] = 'ÛßßÛ '
g0[2] = 'Û  Û '
g0[3] = 'ßßßß '
stor '' to l1,l2,l3
for _y = 1 to len(arg1)
   _yi = subs(arg1,_y,1)
   for _z = 1 to 3
      _ya = str(_z,1)
      l0=''
      do case
      case _yi = ' '
         l0 = l0 + '     '
      case _yi = ','
         l0 = iif(_z=3,l0+' Ï ','   ')
      case _yi = '.'
         l0 = iif(_z=3,l0+' Ï ','   ')
      case _yi = '}'
         l0 = iif(_z=3,l0+' Ï ','   ')
      case _yi = '/'
         l0 = iif(_z=3,l0+' Ï ','   ')
      case _yi = '1'
         l0 = l0+g1[_z]
      case _yi = '2'
         l0 = l0+g2[_z]
      case _yi = '3'
         l0 = l0+g3[_z]
      case _yi = '4'
         l0 = l0+g4[_z]
      case _yi = '5'
         l0 = l0+g5[_z]
      case _yi = '6'
         l0 = l0+g6[_z]
      case _yi = '7'
         l0 = l0+g7[_z]
      case _yi = '8'
         l0 = l0+g8[_z]
      case _yi = '9'
         l0 = l0+g9[_z]
      case _yi = '0'
         l0 = l0+g0[_z]
      endcase
      l&_ya = l&_ya + l0
   next
next
aadd(m_visor,l1)
aadd(m_visor,l2)
aadd(m_visor,l3)
return( m_visor)

********************
PROCEDURE BOX
******************
BOX = "ÉÍ»º¼ÍÈº "
******************

*************************
function ver_cpf(Ccpf)         // Validador de C.P.F.
*************************
  Public Res_Cpf
  Res_Cpf = "  "
  nNumero = ((val(substr(cCpf,1,1))*10)+;
            (val(substr(cCpf,2,1))*9)+;
            (val(substr(cCpf,3,1))*8)+;
            (val(substr(cCpf,4,1))*7)+;
            (val(substr(cCpf,5,1))*6)+;
            (val(substr(cCpf,6,1))*5)+;
            (val(substr(cCpf,7,1))*4)+;
            (val(substr(cCpf,8,1))*3)+;
            (val(substr(cCpf,9,1))*2))
  nDig1:=If((nNumero%11)=0 .or. (nNumero%11)=1,0,11-(nNumero%11))  // 1o. Digito
  nNumero = ((val(substr(cCpf,1,1))*11)+;
            (val(substr(cCpf,2,1))*10)+;
            (val(substr(cCpf,3,1))*9)+;
            (val(substr(cCpf,4,1))*8)+;
            (val(substr(cCpf,5,1))*7)+;
            (val(substr(cCpf,6,1))*6)+;
            (val(substr(cCpf,7,1))*5)+;
            (val(substr(cCpf,8,1))*4)+;
            (val(substr(cCpf,9,1))*3)+;
            nDig1*2)
  nDig2:=If((nNumero%11)=0 .or. (nNumero%11)=1,0,11-(nNumero%11))  // 2o.Digito
  If nDig1 !=val(substr(cCpf,10,1)) .or. nDig2 != val(substr(cCpf,11,1))
     Res_Cpf = "EOF"
     Alert("C.P.F. Inv lido. Por Favor Verifique !")
  Else
     Res_Cpf = "OK"
  Endif
Return

//***********************************************************
Function AlertNew(cMsg,aOptions,nBeginOption,lMsg,nTimeOut)
//***********************************************************
   Local nTop,  nLeft, nBottom, nRight
   Local nRows, nCols
   Local aRow,  aCol
   Local nCtr,  nLenOpt, nMaxText, cPart, cTextTmp

   Local aText := {}, nCursor := SetCursor(0)

   Private cCorNormal  := "W/B"
   Private cCorMsg     := "W+/B"
   Private cCorInverso := "w+/r"

   Private nOutTime := If(nTimeOut==Nil,nTimeOut:=0,nTimeOut)

   SaveScreen()

   if lMsg==nil
      lMsg:=.f.
   end

   If aOptions == Nil
      aOptions := {" Ok "}
   Else
      For nCtr:=1 To Len(aOptions)
          If Left(aOptions[nCtr],1)  != " " .And. ;
             Right(aOptions[nCtr],1) != " "
             aOptions[nCtr]=" "+aOptions[nCtr]+" "
          End
      Next nCtr
   End

   nLenOpt:=0

   For nCtr:=1 To Len(aOptions)
       nLenOpt+=Len(aOptions[nCtr])
   Next nCtr

   If !Empty(cMsg)
      cMsg+=";"+If(!lMsg,";","")
   End
   cTextTmp:=""

   nMaxText := 0

   For nCtr:=1 To Len(cMsg)

       cPart:=SubStr(cMsg,nCtr,1)

       If cPart==";"
          aAdd(aText,cTextTmp)
          If Len(cTextTmp) > nMaxText
             nMaxText:=Len(cTextTmp)
          End
          cTextTmp:=""
       Else
          cTextTmp+=cPart
       End

   Next nCtr

   if !lMsg
      aAdd(aText,cTextTmp)
   end

   aCol:={(MaxCol()-nLenOpt)/2}
   For nCtr:=2 To Len(aOptions)
       aAdd(aCol,aCol[nCtr-1]+Len(aOptions[nCtr-1]))
   Next nCtr

   nMaxText:=Max(nMaxText,nLenOpt)
   nMaxText+=If(nMaxText/2==Int(nMaxText/2),0,1)


   nRows   :=Len(aText)+if(lMsg,2,2)
   nCols   :=nMaxText+4

   nTop    :=(24-nRows)/2+if(lMsg,1,0)
   nLeft   :=(80-nCols)/2-2
   nBottom :=(24-nRows)/2+nRows-1+if(lMsg,1,0)
   nRight  :=(80-nCols)/2+nCols-1

   @ nTop,nLeft,nBottom+1,nRight Box frame[1] Color cCorNormal    && Box da Mensagem

   For nCtr:=1 To Len(aText)
       @ nTop+nCtr,nLeft+2 Say PadC(aText[nCtr],nMaxText+2) Color cCorMsg   && A Mesagem
   Next nCtr

   nBeginOption := If( ValType(nBeginOption) != "N", 1, nBeginOption )
   nBeginOption := If( nBeginOption<1 .Or. nBeginOption>Len(aOptions), 1, nBeginOption )

   nopt:=0

   if !lMsg
      nOpt := Opcoes(nBottom-1,aCol,aOptions,nBeginOption)   && Botao do Ok da Msg
   end

   if !lMsg ; restore screen ; end

   SetCursor(nCursor)

   Return nOpt

Static Function Opcoes(nRow, aCol, aOptions, nBeginOption)

   Local nCtr,lKeyValid,cLetter,nLastOption

   Local nOption     := nBeginOption,  ;
         nKeyPress   := 0,             ;
         nOptions    := Len(aOptions), ;
         cIniLets    := ""

   *nRow--

   For nCtr := 1 To nOptions
       cIniLets=cIniLets+Upper(Left(Ltrim(aOptions[nCtr]),1))
       @ nRow, aCol[nCtr] Say aOptions[nCtr] Color cCorNormal
   Next nCtr

   @ nRow, aCol[nOption] Say aOptions[nOption] Color cCorInverso

   nLastOption := nOption

   While .T.

      lKeyValid := .F.

      While !lKeyValid

         cLetter := Upper( Chr(nKeyPress) )

         If cLetter $ cIniLets

            nOption := At(cLetter, cIniLets)

            @ nRow, aCol[nLastOption] Say aOptions[nLastOption] Color cCorNormal
            @ nRow, aCol[nOption]     Say aOptions[nOption]     Color cCorInverso

            nLastOption := nOption

            KeyBoard Chr(13)

         End

         nKeyPress := InKey(nOutTime)

         IF nKEYPRESS == 0
            KEYBOARD CHR(K_ESC)
         END

         lKeyValid := ( nKeyPress == K_HOME  .Or. nKeyPress == K_END   .Or. ;
                        nKeyPress == K_LEFT  .Or. nKeyPress == K_RIGHT .Or. ;
                        nKeyPress == K_ENTER .Or. nKeyPress == K_ESC )

      End

      If nKeyPress == K_ESC

         nOption := 0

         Exit

      ElseIf nKeyPress == K_ENTER

         Exit

      ElseIf nKeyPress == K_LEFT

         If nOption > 1
            nOption --
         Else
            *nOption := nOptions
            nOption := 1
         End

      ElseIf nKeyPress == K_RIGHT

         If nOption < nOptions
            nOption ++
         Else
            *nOption := 1
            nOption := nOptions
         End

      ElseIf nKeyPress == K_HOME

         nOption := 1

      ElseIf nKeyPress == K_END

         nOption := nOptions

      End

      @ nRow, aCol[nLastOption] Say aOptions[nLastOption] Color cCorNormal

      @ nRow, aCol[nOption] Say aOptions[nOption] Color cCorInverso

      nLastOption := nOption

   End

   Return nOption

//*********
FUNC CNPJ(FCGC)
//********
  Public Res_CNPJ
  Res_CNPJ = "  "
  public vObsCGC:=SPACE(25)

	T :=  TT :=  TTT :=  0
	CCNPJ = SPACE(18)

	PARTEA1 = SUBS(FCGC,1,2)  //   Divide a
	PARTEA2 = SUBS(FCGC,3,3)  //   variavel
	PARTEA3 = SUBS(FCGC,6,3)  //     em 5
	PARTEA4 = SUBS(FCGC,9,4) //    partes
	PARTEA5 = SUBS(FCGC,13,2) //    partes
	CCNPJ = PARTEa1+PARTEa2+PARTEa3+PARTEa4 // Junta as 4 partes

	FOR TT =  12 TO 5 STEP -1                         //
	        T = T + VAL(SUBS(CCNPJ,TT,1)) * (14 - TT) //
	NEXT TT                                           //
	FOR TT =  4 TO 1 STEP -1                          //
	        T = T + VAL(SUBS(CCNPJ,TT,1)) * (6 - TT)   //   Processa
	NEXT TT                                           //  os calculos
	TT :=  T - (INT(T/11)*11)                         //     para
	IF TT < 2                                         //   verificar
	        TT :=  0                                  //   o primeiro
	ELSE                                              //    digito
	        TT :=  11 - TT                            //
	ENDIF                                             //
	CCNPJ =  CCNPJ + STR(TT,1) // Junta o primeiro digito com as 4 primeiras partes

	T= 0 // Zera a variavel para inicio do novo calculo
	FOR TT =  13 TO 6 STEP -1                         //
	        T = T + VAL(SUBS(CCNPJ,TT,1)) * (15 - TT)  //
	NEXT TT                                           //
	FOR TT =  5 TO 1 STEP -1                          //
	        T = T + VAL(SUBS(CCNPJ,TT,1)) * (7 - TT)   //    Processa
	NEXT TT                                           //    o calculo
	TT :=  T - (INT(T/11)*11)                         //  para verificar
	IF TT < 2                                         //    o segundo
	        TT :=  0                                  //     digito
	ELSE                                              //
	        TT :=  11 - TT                            //
	ENDIF                                             //
	CCNPJ =  CCNPJ + STR(TT,1) // Junta o segundo digito ao restante inicial

	PARTE1 = SUBS(CCNPJ,1,2)  //
	PARTE2 = SUBS(CCNPJ,3,3)  //  Divide novamente
	PARTE3 = SUBS(CCNPJ,6,3)  //     a variavel
	PARTE4 = SUBS(CCNPJ,9,4)  //  agora em 5 partes
	PARTE5 = SUBS(CCNPJ,13,2) //
	CCNPJ = PARTE1+PARTE2+PARTE3+PARTE4+PARTE5               // Monta a variavel conforme um CCNPJ verdadeiro
	DO WHILE .T.
	   IF CCNPJ != PARTEa1+PARTEa2+PARTEa3+PARTEa4+PARTEa5
	      Alert("N§ do CNPJ informado est  errado!")
              Res_Cnpj = "EOF"
	      vObsCGC="CNPJ Incorreto"
	      FCGC=SPACE(18)
	      CCNPJ=space(18)
	   ELSE
              Res_Cnpj = "OK"
	      vObsCGC="CNPJ Correto"
	   Endif
	   FCGC=CCNPJ
	   Exit
	Enddo
Return .T.
*************************************************
* IeOk(p1,p2)   : Validacao de Inscricao Estadual
* Parametros    : p1 : string,2 caracteres,maiusculo,unidade federal
*                 p2 : string,tam.variavel,alfanumerico maiusculo,insc.estadual
* Retorno       : Logico
* Linguagem     : Clipper 5.2d
* Linkedicao    : Normal, nao sao utilizadas bibliotecas externas.
* Desenvolvedor : Machado, Paulo H.S. - phmach@terra.com.br
*************************************************
procedure ieok(puf,pie)
   local ok:=.f.,base,vpos,valg,vsom,vres,vdig1,vdig2,vpro,p,d,n,vbase2,origem
   Public Res_IE
   vbase2:=base:=origem:=""
   if alltrim(pie)=="ISENTO";return .t.;endif
   for vpos:=1 to len(alltrim(pie))
       if substr(pie,vpos,1)$"0123456789P"
          origem+=substr(pie,vpos,1)
       endif
   next
   mascara:="99999999999999"
   if     puf=="AC"
      mascara:="99,99,9999-9"
      base   :=padr(origem,9,"0")
      if left(base,2)=="01" .and. substr(base,3,2)<>"00"
         vsom:=0
         for vpos:=1 to 8
             valg:=val(substr(base,vpos,1))
             valg:=valg*(10-vpos)
             vsom+=valg
         next
         vres  :=vsom%11
         vdig1 :=str(if(vres<2,0,11-vres),1,0)
         vbase2:=left(base,8)+vdig1
         ok    :=(vbase2==origem)
      endif
   elseif puf=="AL"
      mascara:="999999999"
      base   :=padr(origem,9,"0")
      if left(base,2)=="24"
         vsom:=0
         for vpos:=1 to 8
             valg:=val(substr(base,vpos,1))
             valg:=valg*(10-vpos)
             vsom+=valg
         next
         vpro  :=vsom*10
         vres  :=vpro%11
         vdig1 :=if(vres==10,"0",str(vres,1,0))
         vbase2:=left(base,8)+vdig1
         ok    :=(vbase2==origem)
      endif
   elseif puf=="AM"
      mascara:="99,999,999-9"
      base   :=padr(origem,9,"0")
      vsom   :=0
      for vpos:=1 to 8
          valg:=val(substr(base,vpos,1))
          valg:=valg*(10-vpos)
          vsom+=valg
      next
      if vsom<11
         vdig1:=str(11-vsom,1,0)
      else
         vres :=vsom%11
         vdig1:=if(vres<2,"0",str(11-vres,1,0))
      endif
      vbase2:=left(base,8)+vdig1
      ok    :=(vbase2==origem)
   elseif puf=="AP"
      mascara:="999999999"
      base   :=padr(origem,9,"0")
      if left(base,2)=="03"
         n:=val(left(base,8))
         if     n>=3000001 .and. n<=3017000
            p:=5
            d:=0
         elseif n>=3017001 .and. n<=3019022
            p:=9
            d:=1
         elseif n>=3019023
            p:=0
            d:=0
         endif
         vsom:=p
         for vpos:=1 to 8
             valg:=val(substr(base,vpos,1))
             valg:=valg*(10-vpos)
             vsom+=valg
         next
         vres :=vsom%11
         vdig1:=11-vres
         if vdig1==10
            vdig1:=0
         elseif vdig1==11
            vdig1:=d
         endif
         vdig1 :=str(vdig1,1,0)
         vbase2:=left(base,8)+vdig1
         ok    :=(vbase2==origem)
      endif
   elseif puf=="BA"
      mascara:="999999-99"
      base   :=padr(origem,8,"0")
      if left(base,1)$"0123458"
         vsom:=0
         for vpos:=1 to 6
             valg:=val(substr(base,vpos,1))
             valg:=valg*(8-vpos)
             vsom+=valg
         next
         vres  :=vsom%10
         vdig2 :=str(if(vres==0,0,10-vres),1,0)
         vbase2:=left(base,6)+vdig2
         vsom  :=0
         for vpos:=1 to 7
             valg:=val(substr(vbase2,vpos,1))
             valg:=valg*(9-vpos)
             vsom+=valg
         next
         vres :=vsom%10
         vdig1:=str(if(vres==0,0,10-vres),1,0)
      else
         vsom:=0
         for vpos:=1 to 6
             valg:=val(substr(base,vpos,1))
             valg:=valg*(8-vpos)
             vsom+=valg
         next
         vres  :=vsom%11
         vdig2 :=str(if(vres<2,0,11-vres),1,0)
         vbase2:=left(base,6)+vdig2
         vsom  :=0
         for vpos:=1 to 7
             valg:=val(substr(vbase2,vpos,1))
             valg:=valg*(9-vpos)
             vsom+=valg
         next
         vres :=vsom%11
         vdig1:=str(if(vres<2,0,11-vres),1,0)
      endif
      vbase2:=left(base,6)+vdig1+vdig2
      ok:=(vbase2==origem)
   elseif puf=="CE"
      mascara:="99999999-9"
      base   :=padr(origem,9,"0")
      vsom   :=0
      for vpos:=1 to 8
          valg:=val(substr(base,vpos,1))
          valg:=valg*(10-vpos)
          vsom+=valg
      next
      vres :=vsom%11
      vdig1:=11-vres
      if vdig1>9;vdig1:=0;endif
      vbase2:=left(base,8)+str(vdig1,1,0)
      ok    :=(vbase2==origem)
   elseif puf=="DF"
      mascara:="999,99999,999-99"
      base   :=padr(origem,13,"0")
      if left(base,3)=="073"
         vsom:=0
         vmul:={4,3,2,9,8,7,6,5,4,3,2}
         for vpos:=1 to 11
             valg:=val(substr(base,vpos,1))
             valg:=valg*vmul[vpos]
             vsom+=valg
         next
         vres  :=vsom%11
         vdig1 :=if(vres<2,0,11-vres)
         vbase2:=left(base,11)+str(vdig1,1,0)
         vsom  :=0
         vmul  :={5,4,3,2,9,8,7,6,5,4,3,2}
         for vpos:=1 to 12
             valg:=val(substr(vbase2,vpos,1))
             valg:=valg*vmul[vpos]
             vsom+=valg
         next
         vres  :=vsom%11
         vdig2 :=if(vres<2,0,11-vres)
         vbase2+=str(vdig2,1,0)
         ok    :=(vbase2==origem)
      endif
   elseif puf=="ES"
      mascara:="999999999"
      base   :=padr(origem,9,"0")
      vsom   :=0
      for vpos:=1 to 8
          valg:=val(substr(base,vpos,1))
          valg:=valg*(10-vpos)
          vsom+=valg
      next
      vres  :=vsom%11
      vdig1 :=str(if(vres<2,0,11-vres),1,0)
      vbase2:=left(base,8)+vdig1
      ok    :=(vbase2==origem)
   elseif puf=="GO"
      mascara:="99,999,999-9"
      base   :=padr(origem,9,"0")
      if left(base,2)$"10,11,15"
         vsom:=0
         for vpos:=1 to 8
             valg:=val(substr(base,vpos,1))
             valg:=valg*(10-vpos)
             vsom+=valg
         next
         vres:=vsom%11
         if vres==0
            vdig1:="0"
         elseif vres==1
            n    :=val(left(base,8))
            vdig1:=if(n>=10103105 .and. n<=10119997,"1","0")
         else
            vdig1:=str(11-vres,1,0)
         endif
         vbase2:=left(base,8)+vdig1
         ok    :=(vbase2==origem)
      endif
   elseif puf=="MA"
      mascara:="999999999"
      base   :=padr(origem,9,"0")
      if left(base,2)=="12"
         vsom:=0
         for vpos:=1 to 8
             valg:=val(substr(base,vpos,1))
             valg:=valg*(10-vpos)
             vsom+=valg
         next
         vres  :=vsom%11
         vdig1 :=str(if(vres<2,0,11-vres),1,0)
         vbase2:=left(base,8)+vdig1
         ok    :=(vbase2==origem)
      endif
   elseif puf=="MT"
      mascara:="9999999999-9"
      vmul   :={3,2,9,8,7,6,5,4,3,2}
      vsom:=0
      for vpos:=1 to 10
          valg:=val(substr(base,vpos,1))
          valg:=valg*vmul[vpos]
          vsom+=valg
      next
      vres  :=vsom%11
      vdig1 :=if(vres<2,0,11-vres)
      vbase2:=left(base,10)+str(vdig1,1,0)
      ok    :=(vbase2==origem)
   elseif puf=="MS"
      mascara:="999999999"
      base   :=padr(origem,9,"0")
      if left(base,2)=="28"
         vsom:=0
         for vpos:=1 to 8
             valg:=val(substr(base,vpos,1))
             valg:=valg*(10-vpos)
             vsom+=valg
         next
         vres  :=vsom%11
         vdig1 :=str(if(vres<2,0,11-vres),1,0)
         vbase2:=left(base,8)+vdig1
         ok    :=(vbase2==origem)
      endif
   elseif puf=="MG"
      mascara:="999,999,999/9999"
      base   :=padr(origem,13,"0")
      vbase2 :=left(base,3)+"0"+substr(base,4,8)
      n      :=2
      vsom   :=""
      for vpos:=1 to 12
          valg:=val(substr(vbase2,vpos,1))
          n   :=if(n==2,1,2)
          valg:=alltrim(str(valg*n,2,0))
          vsom+=valg
      next
      n     :=0
      for vpos:=1 to len(vsom);n+=val(substr(vsom,vpos,1));next
      vsom  :=n
      do while right(str(n,3,0),1)<>"0";n++;enddo
      vdig1 :=str(n-vsom,1,0)
      vbase2:=left(base,11)+vdig1
      vsom  :=0
      vmul  :={3,2,11,10,9,8,7,6,5,4,3,2}
      for vpos:=1 to 12
          valg:=val(substr(vbase2,vpos,1))
          valg:=valg*vmul[vpos]
          vsom+=valg
      next
      vres  :=vsom%11
      vdig2 :=if(vres<2,0,11-vres)
      vbase2+=str(vdig2,1,0)
      ok    :=(vbase2==origem)
   elseif puf=="PA"
      mascara:="99-999999-9"
      base   :=padr(origem,9,"0")
      if left(base,2)=="15"
         vsom:=0
         for vpos:=1 to 8
             valg:=val(substr(base,vpos,1))
             valg:=valg*(10-vpos)
             vsom+=valg
         next
         vres  :=vsom%11
         vdig1 :=str(if(vres<2,0,11-vres),1,0)
         vbase2:=left(base,8)+vdig1
         ok    :=(vbase2==origem)
      endif
   elseif puf=="PB"
      mascara:="99,999,999-9"
      base   :=padr(origem,9,"0")
      vsom   :=0
      for vpos:=1 to 8
          valg:=val(substr(base,vpos,1))
          valg:=valg*(10-vpos)
          vsom+=valg
      next
      vres  :=vsom%11
      vdig1 :=11-vres
      if vdig1>9;vdig1:=0;endif
      vbase2:=left(base,8)+str(vdig1,1,0)
      ok    :=(vbase2==origem)
   elseif puf=="PE"
      mascara:="999,999,999"
      base   :=padr(origem,9,"0")
      vsom   :=0
      for vpos:=1 to 8
           valg:=val(substr(base,vpos,1))
           valg:=valg*(10-vpos)
           vsom+=valg
      next
      vres  :=vsom%11
      vdig1 :=if(vres<2,"0",str(11-vres,1,0))
      vbase2:=left(base,8)+vdig1
      ok    :=(vbase2==origem)
   elseif puf=="PI"
      mascara:="999999999"
      base   :=padr(origem,9,"0")
      vsom   :=0
      for vpos:=1 to 8
          valg:=val(substr(base,vpos,1))
          valg:=valg*(10-vpos)
          vsom+=valg
      next
      vres  :=vsom%11
      vdig1 :=str(if(vres<2,0,11-vres),1,0)
      vbase2:=left(base,8)+vdig1
      ok    :=(vbase2==origem)
   elseif puf=="PR"
      mascara:="999,99999-99"
      base   :=padr(origem,10,"0")
      vsom   :=0
      vmul   :={3,2,7,6,5,4,3,2}
      for vpos:=1 to 8
          valg:=val(substr(base,vpos,1))
          valg:=valg*vmul[vpos]
          vsom+=valg
      next
      vres  :=vsom%11
      vdig1 :=str(if(vres<2,0,11-vres),1,0)
      vbase2:=left(base,8)+vdig1
      vsom  :=0
      vmul  :={4,3,2,7,6,5,4,3,2}
      for vpos:=1 to 9
          valg:=val(substr(vbase2,vpos,1))
          valg:=valg*vmul[vpos]
          vsom+=valg
      next
      vres  :=vsom%11
      vdig2 :=str(if(vres<2,0,11-vres),1,0)
      vbase2+=vdig2
      ok    :=(vbase2==origem)
   elseif puf=="RJ"
      mascara:="99,999,99-9"
      base   :=padr(origem,8,"0")
      vsom   :=0
      vmul   :={2,7,6,5,4,3,2}
      for vpos:=1 to 7
          valg:=val(substr(base,vpos,1))
          valg:=valg*vmul[vpos]
          vsom+=valg
      next
      vres  :=vsom%11
      vdig1 :=str(if(vres<2,0,11-vres),1,0)
      vbase2:=left(base,7)+vdig1
      ok    :=(vbase2==origem)
   elseif puf=="RN"
      mascara:="99,999,999-9"
      base   :=padr(origem,9,"0")
      if left(base,2)=="20"
         vsom:=0
         for vpos:=1 to 8
             valg:=val(substr(base,vpos,1))
             valg:=valg*(10-vpos)
             vsom+=valg
         next
         vpro  :=vsom*10
         vres  :=vpro%11
         vdig1 :=str(if(vres>9,0,vres),1,0)
         vbase2:=left(base,8)+vdig1
         ok    :=(vbase2==origem)
      endif
   elseif puf=="RO"
      mascara:="999999999"
      base   :=padr(origem,9,"0")
      vbase2 :=substr(base,4,5)
      vsom   :=0
      for vpos:=1 to 5
          valg:=val(substr(vbase2,vpos,1))
          valg:=valg*(7-vpos)
          vsom+=valg
      next
      vres  :=vsom%11
      vdig1 :=11-vres
      if vdig1>9;vdig1-=10;endif
      vbase2:=left(base,8)+str(vdig1,1,0)
      ok    :=(vbase2==origem)
   elseif puf=="RR"
      mascara:="99999999-9"
      base   :=padr(origem,9,"0")
      if left(base,2)=="24"
         vsom:=0
         for vpos:=1 to 8
             valg:=val(substr(base,vpos,1))
             valg:=valg*vpos
             vsom+=valg
         next
         vres  :=vsom%9
         vdig1 :=str(vres,1,0)
         vbase2:=left(base,8)+vdig1
         ok    :=(vbase2==origem)
      endif
   elseif puf=="RS"
      mascara:="999/999999-9"
      base   :=padr(origem,10,"0")
      n      :=val(left(base,3))
      if n>0 .and. n<468
         vsom:=0
         vmul:={2,9,8,7,6,5,4,3,2}
         for vpos:=1 to 9
             valg:=val(substr(base,vpos,1))
             valg:=valg*vmul[vpos]
             vsom+=valg
         next
         vres  :=vsom%11
         vdig1 :=11-vres
         if vdig1>9;vdig1:=0;endif
         vbase2:=left(base,9)+str(vdig1,1,0)
         ok    :=(vbase2==origem)
      endif
   elseif puf=="SC"
      mascara:="999,999,999"
      base   :=padr(origem,9,"0")
      vsom   :=0
      for vpos:=1 to 8
          valg:=val(substr(base,vpos,1))
          valg:=valg*(10-vpos)
          vsom+=valg
      next
      vres  :=vsom%11
      vdig1 :=if(vres<2,"0",str(11-vres,1,0))
      vbase2:=left(base,8)+vdig1
      ok    :=(vbase2==origem)
   elseif puf=="SE"
      mascara:="99999999-9"
      base   :=padr(origem,9,"0")
      vsom   :=0
      for vpos:=1 to 8
          valg:=val(substr(base,vpos,1))
          valg:=valg*(10-vpos)
          vsom+=valg
      next
      vres  :=vsom%11
      vdig1 :=11-vres
      if vdig1>9;vdig1:=0;endif
      vbase2:=left(base,8)+str(vdig1,1,0)
      ok    :=(vbase2==origem)
   elseif puf=="SP"
      if left(base,1)=="P"
         mascara:="P-99999999,9/999"
         base   :=padr(origem,13,"0")
         vbase2 :=substr(base,2,8)
         vsom   :=0
         vmul   :={1,3,4,5,6,7,8,10}
         for vpos:=1 to 8
             valg:=val(substr(vbase2,vpos,1))
             valg:=valg*vmul[vpos]
             vsom+=valg
         next
         vres  :=vsom%11
         vdig1 :=right(str(vres,2,0),1)
         vbase2:=left(base,9)+vdig1+substr(base,11,3)
      else
         mascara:="999,999,999,999"
         base   :=padr(origem,12,"0")
         vsom   :=0
         vmul   :={1,3,4,5,6,7,8,10}
         for vpos:=1 to 8
             valg:=val(substr(base,vpos,1))
             valg:=valg*vmul[vpos]
             vsom+=valg
         next
         vres  :=vsom%11
         vdig1 :=right(str(vres,2,0),1)
         vbase2:=left(base,8)+vdig1+substr(base,10,2)
         vsom  :=0
         vmul  :={3,2,10,9,8,7,6,5,4,3,2}
         for vpos:=1 to 11
             valg:=val(substr(vbase2,vpos,1))
             valg:=valg*vmul[vpos]
             vsom+=valg
         next
         vres  :=vsom%11
         vdig2 :=right(str(vres,2,0),1)
         vbase2+=vdig2
      endif
      ok:=(vbase2==origem)
   elseif puf=="TO"
      mascara:="99,99,999999-9"
      base   :=padr(origem,11,"0")
      if substr(base,3,2)$"01,02,03,99"
         vbase2:=left(base,2)+substr(base,5,6)
         vsom  :=0
         for vpos:=1 to 8
             valg:=val(substr(vbase2,vpos,1))
             valg:=valg*(10-vpos)
             vsom+=valg
         next
         vres  :=vsom%11
         vdig1 :=str(if(vres<2,0,11-vres),1,0)
         vbase2:=left(base,10)+vdig1
         ok    :=(vbase2==origem)
      endif
   else
      alert("Unidade Federal Invalida !")
   endif
   if puf = "TO"         // Funcao invalida para tocantis
      Res_IE = "OK"
   Else
     if !ok
           Res_IE = "EOF"
        if empty(vbase2)
           alert("Os D¡gitos Identificadores de Cidade e/ou Estado N„o Conferem !")
        else
           vbase2:=strtran(transform(val(vbase2),mascara)," ","0")
           vbase2:=strtran(vbase2,",",".")
           alert("Inscri‡„o Inv lida !;O Correto Seria;"+vbase2)
        endif
     else
        Res_IE = "OK"
     endif
   Endif
return .t.

//****************
  Function Ret_Num(wValor)
//****************
Priv Wret
  wRet = ""
  For i = 1 to len(wValor)
      If type(substr(wValor,i,1)) = "N" .and. substr(wValor,i,1) <> "I" .and. substr(wValor,i,1) <> "X"
         wRet = wRet + substr(wValor,i,1)
      Endif
  Next
Return(wret)

//*****************
  Function Parc_Fin
//*****************
  Parameters WVal, WTax, WQtd, WAntec
  private WValor, WStaAnt

  WStaAnt = 0
  If WAntec
     WStaAnt = 1
  Endif
  If Wtax > 0
     WTax = WTax / 100
     WValor = 0
     WValor = Round((WTax / (1 - (1 + WTax)^(-WQtd))) * (1 / (1 + WTax * WStaAnt)),4)
     WValor = WValor * WVal
  Else
     WValor = WVal / WQtd
  Endif
Return WValor

//********************
  Function Resto_Div(m_divisor,m_dividen)
//*******************
 m_vr=str((mod(m_divisor,m_dividen) / 100),10,2)
 Public m_divp,m_divp1,m_divp2,m_divp3
 Stor 0 to m_divp,m_divp1,m_divp2,m_divp3
 if val(m_vr) >0
    m_div1 = str(((m_divisor / m_dividen) + (mod(m_divisor,m_dividen) / 100)),10,2)
    m_div = (m_divisor - ((m_divisor / m_dividen) + (mod(m_divisor,m_dividen) / 100)))
    m_div2 = (m_div / (m_dividen-1))
 Else
    m_div2 = m_divisor / m_dividen
 Endif
 If val(m_vr) >0
    m_divp  = 1
    m_divp1 = m_div1
    m_divp2 = m_dividen-1
 Else
    m_divp2 = m_dividen
 Endif
 m_divp3 = m_div2
Return

//***************
  Function Ver_Uf(F_uf)
//***************
  Public Res_uf
  Res_uf = "  "
  If F_UF = "RO"
  ElseIf F_UF = "AC"
  ElseIf F_UF = "AM"
  ElseIf F_UF = "RR"
  ElseIf F_UF = "PA"
  ElseIf F_UF = "AP"
  ElseIf F_UF = "TO"
  ElseIf F_UF = "MA"
  ElseIf F_UF = "PI"
  ElseIf F_UF = "CE"
  ElseIf F_UF = "RN"
  ElseIf F_UF = "PB"
  ElseIf F_UF = "PE"
  ElseIf F_UF = "AL"
  ElseIf F_UF = "SE"
  ElseIf F_UF = "BA"
  ElseIf F_UF = "MG"
  ElseIf F_UF = "ES"
  ElseIf F_UF = "RJ"
  ElseIf F_UF = "SP"
  ElseIf F_UF = "PR"
  ElseIf F_UF = "SC"
  ElseIf F_UF = "RS"
  ElseIf F_UF = "MS"
  ElseIf F_UF = "MT"
  ElseIf F_UF = "GO"
  ElseIf F_UF = "DF"
  Else
    Alert("UF Invalida. Corrija !")
    Res_uf = "EOF"
  Endif
 Return Res_uf

//****************
  Function Testa_Ip(w_ip)
//****************
 Local W_ret := .T.
 If !file("/bin/teste_ip")
    Alert("Arquivo de Teste de IP N„o Encontrado. Informe ao Programador !")
    W_ret = .F.
    Return(w_ret)
 Endif
 If !Empty(W_ip)
    If file("/home/tmp/&pid")
       !rm /home/tmp/&pid
    Endif
    m_var = '/bin/teste_ip '+w_ip+" "+pid
    !&m_var
    Release m_var
    If file("/home/tmp/&pid")
       W_ret = .F.
       !rm /home/tmp/&pid
    Endif
 Else
    W_ret = .F.
    If file("/home/tmp/&pid")
       !rm /home/tmp/&pid
    Endif
 Endif
Return(w_ret)

//**********
  PROC CBC
//**********
SetColor("gr+/w")
m_nomeu = substr(m_nomeusu,1,10)
ano=substr(dtoc(m_datsi),7,4)
If m_datsi >= ctod("20/12/&ano") .and. m_datsi <= ctod("25/12/&ano")
   FUNDO_Tela("&m_nomeu  Feliz Natal",6,17)
ElseIf m_datsi >= ctod("26/12/&ano") .and. m_datsi <= ctod("31/12/&ano")
   FUNDO_Tela("&m_nomeu  Feliz Ano Novo",6,17)
Else
  If m_datsi >= ctod("09/05/&ano") .AND. m_datsi <= ctod("15/05/&ano")
     FUNDO_Tela("Feliz Dia    das M„es",6,17)
  ElseIf m_datsi >= ctod("05/05/2017") .AND. m_datsi <= ctod("09/05/2017")
     FUNDO_Tela("25 Anos    Parabens !!!",7,18)
  ElseIf m_datsi >= ctod("28/11/&ano") .AND. m_datsi <= ctod("01/12/&ano")
     FUNDO_Tela("Black Friday       Zenir",7,18)
  Else
     FUNDO_Tela("Zenir    M¢veis e Eletros",7,17)
  Endif
Endif
Return
*************************************************
FUNC FUNDO_Tela(cTexto,nLini,nLinf)
LOCAL tf:=ARRAY(25),fundo,FUN_DO
*
*  Monta papel de parede
IF PCOUNT()=1
   nLini:=0
   nLinf:=24
ELSEIF PCOUNT()=3
   nLinf=IF(nLinf>24,24,nLinf)
ELSE
   cTexto=IF(VALTYPE(cTexto)="U",1,cTexto)
   nLini  =IF(VALTYPE(nLini)="U",0,nLini)
   nLinf  =IF(VALTYPE(nLinf)="U",24,nLinf)
ENDIF
IF VALTYPE(cTexto)="N"
   cTexto=IF(cTexto>25,25,cTexto)
ENDIF
tf[1]="°°°°°°°°°°±±±±±±±±±²²²²²²²²²²±±±±±±±±±±"
tf[2]="°°°°°°°°°°±±±±±±±±±°°°°°°°°°°²²²²²²²²²²"
tf[3]="²²²²²²²²²²°°°°°°°°°²²²²²²²²²²±±±±±±±±±±"
tf[4]="²²²²²²²²²²         °°°°°°°°°°±±±±±±±±±±"
tf[5]="°"
tf[6]="±"
tf[7]="²"
tf[8]=" "
tf[9]=" "
tf[10]=" "
tf[11]=" "
tf[12]=" "
tf[13]=""
tf[14]="Ä"
tf[15]=" "
tf[16]="ð"
tf[17]="Å"
tf[18]="Î"
tf[19]="Þ"
tf[20]="* "
tf[21]="À¿À¿"
tf[22]="ÊËËÊ"
tf[23]="ÁÂÂÁ"
tf[24]="Ã´´Ã"
tf[25]="¹ÌÌ¹"
IF VALTYPE(cTexto)="C"
   FUN_DO=SUBST(cTexto+REPLIC(" ",50),1,50)    //50 caracteres
   fundo=1
ELSE
   FUN_DO=tf[cTexto]
   fundo=cTexto
ENDIF
IF fundo<21
   FUN_DO=SUBS(FUN_DO+REPL(FUN_DO,(80*nLinf)/LEN(FUN_DO)),1,(80*nLinf))
ENDIF
FOR F=nLini TO nLinf
   IF fundo<21
      @ F,05 SAY SUBS(FUN_DO,F*65-79,65)
   ELSE
      @ F,05 SAY REPL(SUBS(FUN_DO,1,2),40)
      FUN_DO=SUBS(FUN_DO,3)+SUBS(FUN_DO,1,2)
   ENDIF
NEXT
RETURN .T.

//****************
  Function Sd_Reserv(wCod)          // Reserva
//****************
 db_use    := Alias()
 ord_index := INDEXORD()            // Ultimo indice utilizado
 wrecnoex  := Recno()

 Priv wSaldo
 Stor 0 to wSaldo

 Sele 29
 Set Order to 1
 Seek Str(wCod,6,0)
 While !Eof() .and. Re_codi=wCod
   If Empty(RE_Baixa)
      wSaldo = wSaldo + Re_Quant
   Endif
   Skip
 Enddo
 Sele (db_use)
 DBSetOrder(ord_index)
 Go wRecnoex
 Release ord_index,db_use,wrecnoex
Return(wSaldo)

//********************
  Function ConfCancRes(wOrca,wReserva,wSaida,wCodPres,wTipo) && Confirma Reserva no oDoo atraves de oDoo_RPC
//********************
  wCdz := 0
  Sele 12
  Veriout(setcolor(),23,"saida_item")
  Go Top
  While !Eof()
    If SubStr(Saida_item,1,7) = SubStr(wSaida,1,7)
       wCdz = Loja
       Exit
    Endif
    Skip
  Enddo
  Use
  Sele 12
  Veriout(SETCOLOR(),23,"filiais")
  Go Top
  While !Eof()
    If Val(Fili) = wCdz
       wCnpjCD   = Ret_Num(cgc)
       Exit
    Endif
    Skip
  Enddo
  Use
  @ 16,13 Say "Conectando Atraves de : oDoo_RPC"
  If wTipo = "CF"
     wEnvia:="/opt/odoo_rpc/reserva_odoo.py confirmar -o "+Ret_num(xy_cgc)+" -d "+wCnpjCD+" -p "+alltrim(Str(wCodPres))+" -m "+Alltrim(str(wReserva))
  ElseIf wTipo = "CC"
     wEnvia:="/opt/odoo_rpc/reserva_odoo.py cancelar -o "+Ret_num(xy_cgc)+" -d "+wCnpjCD+" -p "+alltrim(Str(wCodPres))+" -m "+Alltrim(str(wReserva))
  Endif
  !&wEnvia
  Release wEnvia,wCnpjCD
Return

//*******************
  Function ConfigLoja(wFilial,wCds)
//*******************
  Local wLista,wRet
  wRet = .f.
  If wCds <> 20
     Return(wRet)
  Endif
 *ListFil={"02" , "28", "24" , "29" ,"51"}
  ListFil={"02"}
  for k = 1 to len(ListFil)
      If ListFil[k] = wFilial
         wRet = .t.
      Endif
  next
Return(wRet)

//*****************
  Function LimpaStr(wTexto)
//*****************  
Local n,wret
 Wret := wTexto
 for n := 1 to len(wTexto) 
    if substr(wTexto, n, 1) = 'ç'
       wret = STRTRAN(wTexto, "ç", "c")     
    endif
    if substr(wTexto, n, 1) = 'Ç'
       wret = STRTRAN(wTexto, "Ç", "C")     
    endif   
    if substr(wTexto, n, 1) = '€'
       wret = STRTRAN(wTexto, "€", "C")     
    endif   
    if substr(wTexto, n, 1) = '‡'
       wret = STRTRAN(wTexto, "‡", "c")     
    endif   
    if substr(wTexto, n, 1) = "`"
       wret = STRTRAN(wTexto, "`", " ")     
    endif       
    if substr(wTexto, n, 1) = "'"
       wret = STRTRAN(wTexto, "'", " ")     
    endif       
    if substr(wTexto, n, 1) = '´'
       wret = STRTRAN(wTexto, "´", " ")     
    endif   
    if substr(wTexto, n, 1) = '"'
       wret = STRTRAN(wTexto, '"', " ")     
    endif       
    if substr(wTexto, n, 1) = "É"
       wret = STRTRAN(wTexto, "É", "E")     
    endif       
    if substr(wTexto, n, 1) = "é"
       wret = STRTRAN(wTexto, "é", "e")     	  
    endif       
    if substr(wTexto, n, 1) = "Á"
       wret = STRTRAN(wTexto, "Á", "A")     	  
    endif       
    if substr(wTexto, n, 1) = "á"
       wret = STRTRAN(wTexto, "á", "a")     	  
    endif       
    if substr(wTexto, n, 1) = "Í"
       wret = STRTRAN(wTexto, "Í", "I")     	  
    endif       
    if substr(wTexto, n, 1) = "í"
       wret = STRTRAN(wTexto, "í", "i")     	  
    endif       
    if substr(wTexto, n, 1) = "Ü"
       wret = STRTRAN(wTexto, "Ü", "U")     	  
    endif       
    if substr(wTexto, n, 1) = "Ú"
       wret = STRTRAN(wTexto, "Ú", "U")     	  
    endif       
    if substr(wTexto, n, 1) = "ú"
       wret = STRTRAN(wTexto, "ú", "u")     	  
    endif       
    if substr(wTexto, n, 1) = "ü"
       wret = STRTRAN(wTexto, "ü", "u")     	  
    endif       	
    if substr(wTexto, n, 1) = "Ó"
       wret = STRTRAN(wTexto, "Ó", "O")     	  
    endif       
    if substr(wTexto, n, 1) = "ó"
       wret = STRTRAN(wTexto, "ó", "o")     	  
    endif       	
    if substr(wTexto, n, 1) = "§"
       wret = STRTRAN(wTexto, "§", " ")     	  
    endif       	
    if substr(wTexto, n, 1) = "ª"
       wret = STRTRAN(wTexto, "ª", "a.")     	  
    endif       	
    if substr(wTexto, n, 1) = "°"
       wret = STRTRAN(wTexto, "°", "o.")     	  
    endif       	
    if substr(wTexto, n, 1) = "¦"
       wret = STRTRAN(wTexto, "¦", " ")     	  
    endif
  Next
return(Wret)
//******************  
  Function Remove_Ac( cTexto )
//******************

   // acento agudo
   cTexto := StrTran( cTexto, "á", "a" )
   cTexto := StrTran( cTexto, "é", "e" )
   cTexto := StrTran( cTexto, "í", "i" )
   cTexto := StrTran( cTexto, "ó", "o" )
   cTexto := StrTran( cTexto, "ú", "u" )
   cTexto := StrTran( cTexto, "Á", "A" )
   cTexto := StrTran( cTexto, "É", "E" )
   cTexto := StrTran( cTexto, "Í", "I" )
   cTexto := StrTran( cTexto, "Ó", "O" )
   cTexto := StrTran( cTexto, "Ú", "U" )
   cTexto := StrTran( cTexto, "°", "." )
   cTexto := StrTran( cTexto, "°", "." )
 
   // acento circunflexo
   cTexto := StrTran( cTexto, "â", "a" )
   cTexto := StrTran( cTexto, "ê", "e" )
   cTexto := StrTran( cTexto, "î", "i" )
   cTexto := StrTran( cTexto, "ô", "o" )
   cTexto := StrTran( cTexto, "û", "u" )
   cTexto := StrTran( cTexto, "Â", "A" )
   cTexto := StrTran( cTexto, "Ê", "E" )
   cTexto := StrTran( cTexto, "Î", "I" )
   cTexto := StrTran( cTexto, "Ô", "O" )
   cTexto := StrTran( cTexto, "Û", "U" )

   // til
   cTexto := StrTran( cTexto, "ã", "a" )
   cTexto := StrTran( cTexto, "õ", "o" )
   cTexto := StrTran( cTexto, "Ã", "A" )
   cTexto := StrTran( cTexto, "Õ", "O" )

   // ce-cedilha
   cTexto := StrTran( cTexto, "ç", "c" )
   cTexto := StrTran( cTexto, "Ç", "C" )

   // trema
   cTexto := StrTran( cTexto, "ü", "u" )
   cTexto := StrTran( cTexto, "Ü", "U" )

   // crase
   cTexto := StrTran( cTexto, "à", "a" )
   cTexto := StrTran( cTexto, "è", "e" )
   cTexto := StrTran( cTexto, "ì", "i" )
   cTexto := StrTran( cTexto, "ò", "o" )
   cTexto := StrTran( cTexto, "ù", "u" )
   cTexto := StrTran( cTexto, "À", "A" )
   cTexto := StrTran( cTexto, "È", "E" )
   cTexto := StrTran( cTexto, "Ì", "I" )
   cTexto := StrTran( cTexto, "Ò", "O" )
   cTexto := StrTran( cTexto, "Ù", "U" )
   cTexto := StrTran( cTexto, "'", " " )

   For i = 164 to 254
       w_asc := chr(i)
       For ii = 1 to len(ctexto)
           If Substr(cTexto,ii,1) = "&w_asc"
              cTexto := Stuff(cTexto,ii,1," ")      // Troca o Caracter na posicao
	   Endif
       Next ii
   Next i
   w_asc := chr(128)
   For ii = 1 to len(ctexto)
       If Substr(cTexto,ii,1) = "&w_asc"
          cTexto := Stuff(cTexto,ii,1,"C")      // Troca o Caracter na posicao
       Endif
   Next ii
   Release w_asc,i,ii

Return(cTexto)

//****************
  Function SD_Fisc(wCod,wDat,wAlias,wCent,wPendenc,wTransit)     // Saldo Atualizado do Fiscal
//****************
 db_use    := Alias()
 ord_index := INDEXORD()          // Ultimo indice utilizado
 wrecnoex  := Recno()

 Priv wRet
 M_Dati = M_DATSI -365
 If wDat <> NIL
    M_Dati = wDat                 // Data do Dia do movimento
 Endif
 M_Datf = DATE()                  // Data do Servidor

 Sele 3
 Set Order to 1
 Seek wCod
 If cd_compob >0                // Verifica se tem Componentes
    wCod = cd_compob
 Endif
 If wAlias = NIl
    Sele 20
    Veriout(setcolor(),23,"cdfisc")
    Set index to index_cdfisc
    wAlias = 20
 Endif

 Sele &wAlias
 Set Order to 1
 Goto Top
 While .T.
  Seek Str(wCod,6,0)+SUBSTR(DTOC(M_DATi),7,4)+SUBSTR(DTOC(M_DATi),4,2)+SUBSTR(DTOC(M_DATi),1,2)
  If Eof()
     M_DATi = M_DATi+1
     If M_DATi > M_DATf
        Exit
     Endif
  Else
     Exit
  Endif
 Enddo
 Stor 0 to wSaldo,wTransit
 If !Eof()
    Skip -1
    If f_codigo = wcod
       wSaldo = f_saldo
    Endif
    Skip
 Endif
 While !Eof() .and. F_CODIGO = wCod .and. F_DATA <= M_DATf
  If F_Data < ctod("01/01/2017")   // Status "R"
     If F_Status <> "D" .and. F_Status <> "R" .and. F_Status <> "P" .and. F_Status <> "F" .and. F_Status <> "V"    //Devolucoes,patrimonio e Remessas para conserto de entregas futuras
        If F_Status = "M" .and. Substr(f_cfop,3,3) = "922" .and. !Empty(F_Futura)
           wSaldo = wSaldo + (F_Entra-F_Saida)
        ElseIf Empty(F_Trans) .and. (Substr(f_cfop,3,3) <> "922" .and. Substr(f_cfop,3,3) <> "929" .and. Substr(f_cfop,3,3) <> "117" .and. Substr(f_cfop,3,3) <> "923")
           wSaldo = wSaldo + (F_Entra-F_Saida)
        ElseIf !Empty(F_Trans) .and. F_Status = "N" .and. Substr(f_cfop,3,3) <> "922" .and. (Substr(f_cfop,3,3) <> "929" .and. Substr(f_cfop,3,3) <> "117" .and. Substr(f_cfop,3,3) <> "923")
           wSaldo = wSaldo + (F_Entra-F_Saida)
        Endif
        If F_Status = "M" .and. Substr(f_cfop,3,3) = "922" .and. Empty(F_Futura)
           wPendenc = wPendenc + F_Saida
        Endif
     Endif
  Else
     If F_Status <> "D" .and. F_Status <> "P" .and. F_Status <> "F" .and. F_Status <> "V"    //Devolucoes,patrimonio e Validacoes
        If F_Status = "M" .and. Substr(f_cfop,3,3) = "922" .and. !Empty(F_Futura)
           wSaldo = wSaldo + (F_Entra-F_Saida)
        ElseIf Empty(F_Trans) .and. (Substr(f_cfop,3,3) <> "922" .and. Substr(f_cfop,3,3) <> "929" .and. Substr(f_cfop,3,3) <> "117" .and. Substr(f_cfop,3,3) <> "923")
           wSaldo = wSaldo + (F_Entra-F_Saida)
        ElseIf !Empty(F_Trans) .and. F_Status = "N" .and. Substr(f_cfop,3,3) <> "922" .and. (Substr(f_cfop,3,3) <> "929" .and. Substr(f_cfop,3,3) <> "117" .and. Substr(f_cfop,3,3) <> "923")
           wSaldo = wSaldo + (F_Entra-F_Saida)
        Endif
        If F_Status = "M" .and. Substr(f_cfop,3,3) = "922" .and. Empty(F_Futura)
           wPendenc = wPendenc + F_Saida
        Endif
     Endif
  Endif
  If F_Status = "N" .and. F_Trans = "T"
     wTransit = wTransit + F_Entra
  Endif
  Skip
 Enddo
 If wSaldo <= 0
    Stor 0 to wSaldo,wPendenc,wTransit
    Seek Str(wCod,6,0)
    While !Eof() .and. F_CODIGO = wCod
     If F_Data < ctod("01/01/2017")   // Status "R"
        If F_Status <> "D" .and. F_Status <> "R" .and. F_Status <> "P" .and. F_Status <> "F" .and. F_Status <> "V"    //Devolucoes,patrimonio e Remessas para conserto de entregas futuras
           If F_Status = "M" .and. Substr(f_cfop,3,3) = "922" .and. !Empty(F_Futura)
              wSaldo = wSaldo + (F_Entra-F_Saida)
           ElseIf Empty(F_Trans) .and. (Substr(f_cfop,3,3) <> "922" .and. Substr(f_cfop,3,3) <> "929" .and. Substr(f_cfop,3,3) <> "117" .and. Substr(f_cfop,3,3) <> "923")
              wSaldo = wSaldo + (F_Entra-F_Saida)
           ElseIf !Empty(F_Trans) .and. F_Status = "N" .and. Substr(f_cfop,3,3) <> "922" .and. (Substr(f_cfop,3,3) <> "929" .and. Substr(f_cfop,3,3) <> "117" .and. Substr(f_cfop,3,3) <> "923")
              wSaldo = wSaldo + (F_Entra-F_Saida)
           Endif
           If F_Status = "M" .and. Substr(f_cfop,3,3) = "922" .and. Empty(F_Futura)
              wPendenc = wPendenc + F_Saida
           Endif
        Endif
     Else
        If F_Status <> "D" .and. F_Status <> "P" .and. F_Status <> "F" .and. F_Status <> "V"    //Devolucoes,patrimonio e Validacoes
           If F_Status = "M" .and. Substr(f_cfop,3,3) = "922" .and. !Empty(F_Futura)
              wSaldo = wSaldo + (F_Entra-F_Saida)
           ElseIf Empty(F_Trans) .and. (Substr(f_cfop,3,3) <> "922" .and. Substr(f_cfop,3,3) <> "929" .and. Substr(f_cfop,3,3) <> "117" .and. Substr(f_cfop,3,3) <> "923")
              wSaldo = wSaldo + (F_Entra-F_Saida)
           ElseIf !Empty(F_Trans) .and. F_Status = "N" .and. Substr(f_cfop,3,3) <> "922" .and. (Substr(f_cfop,3,3) <> "929" .and. Substr(f_cfop,3,3) <> "117" .and. Substr(f_cfop,3,3) <> "923")
              wSaldo = wSaldo + (F_Entra-F_Saida)
           Endif
           If F_Status = "M" .and. Substr(f_cfop,3,3) = "922" .and. Empty(F_Futura)
              wPendenc = wPendenc + F_Saida
           Endif
        Endif
     Endif
     If F_Status = "N" .and. F_Trans = "T"
        wTransit = wTransit + F_Entra
     Endif
     Skip
    Enddo
 Endif
 wCENT = wSaldo
 Sele 20
 USe
 Sele (db_use)
 DBSetOrder(ord_index)
 Go wrecnoex
 Release m_dati,m_datf,ord_index,db_use,wrecnoex,wDat,wPrecoCompo
Return

//****************
  Function Sd_Pend(wCod,wMin,wSeri)    // Saldo Das Pendencias de Faturamento
//****************
 db_use    := Alias()
 ord_index := INDEXORD()            // Ultimo indice utilizado
 wrecnoex  := Recno()

 Stor 0 to wSaldoPend
 Sele 54
 If wMin <> NIL
    If wMin > 0
       Set Order to 1
       Seek Str(wMin,8,0)+substr(wseri,1,3)
    Endif
 Else
    Set Order to 2
    Seek wCod
 Endif
 While !Eof()
  If wMin <> NIL
     If Minuta = wMin .and. Serie = wSeri
        If Empty(Data_Fat) .and. Data_Venda <= ctod("03/09/2018")
           wSaldoPend = wSaldoPend + Quant
        Endif
     Endif
  Else
     If CODIGO = wCod
        If Empty(Data_Fat) .and. Data_Venda <= ctod("03/09/2018")
           wSaldoPend = wSaldoPend + Quant
        Endif
     Endif
  Endif
  Skip
 Enddo
 Sele (db_use)
 DBSetOrder(ord_index)
 Go wrecnoex
 Release ord_index,db_use,wrecnoex
Return(wSaldoPend)

//*****************
  Function SD_Jafat(wCod,wMin)      // Saldo Atualizado do Fiscal
//*****************
 db_use    := Alias()
 ord_index := INDEXORD()         // Ultimo indice utilizado
 wrecnoex  := Recno()

 Priv wSaldo

 Sele 20
 Veriout(setcolor(),23,"cdfisc")
 Set index to index_cdfisc

 Sele 3
 Set Order to 1
 Seek wCod
 If cd_compob >0                    // Verifica se tem Componentes
    wCod = cd_compob
 Endif

 Sele 20
 Set Order to 1
 Goto Top
 Seek Str(wCod,6,0)+SUBSTR(DTOC(M_DATSI),7,4)+SUBSTR(DTOC(M_DATSI),4,2)+SUBSTR(DTOC(M_DATSI),1,2)
 Stor 0 to wSaldo
 While !Eof() .and. F_CODIGO = wCod .and. F_DATA = M_DATSI
  If F_Minuta = wMin
     If F_Data < ctod("01/01/2017")
        If F_Status <> "D" .and. F_Status <> "F" .and. F_Status <> "V" .and. F_Status <> "R" .and. F_Status <> "P"    //Devolucoes,patrimonio e Remessas para conserto de entregas futuras
           If F_Status = "M" .and. Substr(f_cfop,3,3) = "922"
              wSaldo = wSaldo + F_saida
           ElseIf Empty(F_Trans) .and. (Substr(f_cfop,3,3) <> "922" .and. Substr(f_cfop,3,3) <> "929" .and. Substr(f_cfop,3,3) <> "117")
              wSaldo = wSaldo + F_saida
           ElseIf !Empty(F_Trans) .and. F_Status = "N" .and. Substr(f_cfop,3,3) <> "922" .and. (Substr(f_cfop,3,3) <> "929" .and. Substr(f_cfop,3,3) <> "117")
              wSaldo = wSaldo + F_saida
           Endif
        Endif
     Else
        If F_Status <> "D" .and. F_Status <> "F" .and. F_Status <> "V" .and. F_Status <> "P"    //Devolucoes,patrimonio e Remessas para conserto de entregas futuras
           If F_Status = "M" .and. Substr(f_cfop,3,3) = "922"
              wSaldo = wSaldo + F_saida
           ElseIf Empty(F_Trans) .and. (Substr(f_cfop,3,3) <> "922" .and. Substr(f_cfop,3,3) <> "929" .and. Substr(f_cfop,3,3) <> "117")
              wSaldo = wSaldo + F_saida
           ElseIf !Empty(F_Trans) .and. F_Status = "N" .and. Substr(f_cfop,3,3) <> "922" .and. (Substr(f_cfop,3,3) <> "929" .and. Substr(f_cfop,3,3) <> "117")
              wSaldo = wSaldo + F_saida
           Endif
        Endif
     Endif
  Endif
  Skip
 Enddo
 Use

 Sele (db_use)
 DBSetOrder(ord_index)
 Go wrecnoex
 Release ord_index,db_use,wrecnoex
Return(wSaldo)

//*******************
  Function RetornaNFe(wCod,wMin,wNFe)      // Saldo Atualizado do Fiscal
//*******************
 db_use    := Alias()
 ord_index := INDEXORD()         // Ultimo indice utilizado
 wrecnoex  := Recno()

 Priv wRet
 wRet = .f.

 Sele 20
 Veriout(setcolor(),23,"cdfisc")
 Set index to index_cdfisc

 Sele 3
 Set Order to 1
 Seek wCod
 If cd_compob >0                    // Verifica se tem Componentes
    wCod = cd_compob
 Endif

 Sele 20
 Set Order to 1
 Goto Top
 Seek Str(wCod,6,0)
 While !Eof() .and. F_CODIGO = wCod
   If F_Minuta = wMin
      If Trim(F_tran) = "NF1 DEVOL/C" .and. val(f_nota) = Val(wNFe)
         wRet = .t.
         Exit
      Endif
   Endif
   Skip
 Enddo
 Use

 Sele (db_use)
 DBSetOrder(ord_index)
 Go wrecnoex
 Release ord_index,db_use,wrecnoex
Return(wRet)

//******************
  Function Testa_Fil(ww_ip)  //  Verifica se o Link da Filial destino esta ativo
//******************
Priv wRet
 wRet := .f.
 For i = 1 to 2
     wRet := Testa_Ip(ww_ip)
     If wRet = .t.
        Exit
     Endif
 Next
Return(wRet)

//******************
  Function Lnk_OiVia
//******************
Priv wRet,ww_ip,y_ip,w_arq,Handle,cBuffer,wTeste
wRet := "Oi"

  #include "fileio.ch"
  Stor "" to y_ip
  Handle = 0
  ww_ip  = space(30)
  w_arq  = "/tmp/ipvalido"          // Arquivo enviado pelo Gateway
  If File("&w_arq")                   // Verifica se o Arquivo existe e qual eh !
     Handle = FOPEN("&w_arq",FO_READ)
     cBuffer:= 30
     If FERROR() = 0
        FREAD(Handle,@ww_ip,cBuffer)
        For i = 1 to len(ww_ip)
            If lower(substr(ww_ip,i,1)) $ "0123456789.-abcdefghijklmnopqrstuvxyz"
               y_ip = y_ip + substr(ww_ip,i,1)
            Endif
        Next
     Endif
     If !Empty(y_ip)
        If Val(Ret_Num(xy_ip)) <> Val(Ret_Num(y_ip))
           wRet = "Via Cast"
        Else
           wRet = "Oi"
        Endif
        wTeste := Testa_Ip("&y_ip")         //  Testa o IP
        If wTeste = .f.
           wRet = "Sem Internet ou N„o Est  Setado Para ("+wRet+")"
        Endif
     Else
        If Loja <> 20                     // Nao Tem No-IP
           wRet = "Arquivo: IpValido Vazio !"
        Else
           wRet = "Oi"
        Endif
     Endif
  Else
     If Loja <> 20                     // Nao Tem No-IP
        wRet = "Arquivo: IpValido Vazio !"
     Else
        wRet = "Oi"
     Endif
  Endif
Return(wRet)

//***************
  Function SOMADD(wDt)
//***************
Local wDia
IF MONTH(wDt) = 1 .AND. DAY(wDt) = 30
   wDia = 29
ELSEIF MONTH(wDt) = 1 .AND. DAY(wDt) = 31
   wDia = 30
ELSEIF MONTH(wDt) = 1 .AND. DAY(wDt) = 28
   wDia = 31
ELSEIF MONTH(wDt) = 1 .AND. DAY(wDt) = 29
   wDia = 30
ELSEIF MONTH(wDt) = 1 .AND. DAY(wDt) < 28
   wDia = 31
ELSEIF MONTH(wDt) = 1 .AND. DAY(wDt) > 29
   wDia = 31
ELSEIF MONTH(wDt) = 2 .AND. DAY(wDt) <=28
 If Year(wDt) = 2012 .or. Year(wDt) = 2016 .or. Year(wDt) = 2020 .or. Year(wDt) = 2024
    wDia = 29
 Else
    wDia = 28
 Endif
ELSEIF MONTH(wDt) = 2 .AND. DAY(wDt) = 29
   wDia = 30
ELSEIF MONTH(wDt) = 3 .AND. DAY(wDt)<= 30
   wDia = 31
ELSEIF MONTH(wDt) = 3 .AND. DAY(wDt) = 31
   wDia = 30
ELSEIF MONTH(wDt) = 4
   wDia = 30
ELSEIF MONTH(wDt) = 5 .AND. DAY(wDt)<= 30
   wDia = 31
ELSEIF MONTH(wDt) = 5 .AND. DAY(wDt) = 31
   wDia = 30
ELSEIF MONTH(wDt) = 6
   wDia = 30
ELSEIF MONTH(wDt) = 7
   wDia = 31
ELSEIF MONTH(wDt) = 8 .AND. DAY(wDt)<= 30
   wDia = 31
ELSEIF MONTH(wDt) = 8 .AND. DAY(wDt) = 31
   wDia = 30
ELSEIF MONTH(wDt) = 9
   wDia = 30
ELSEIF MONTH(wDt) = 10 .AND. DAY(wDt)<= 30
   wDia = 31
ELSEIF MONTH(wDt) = 10 .AND. DAY(wDt) = 31
   wDia = 30
ELSEIF MONTH(wDt) = 11
   wDia = 30
ELSEIF MONTH(wDt) = 12
   wDia = 31
ELSE
   wDia = 31
ENDIF
Return(wDia)

//*********************
  Function Add_Field(wField,wtipoc,wTam,wDec,wDbf)
//*********************
    Priv stru,OldLen,wRet
    // para empresa.dbf , utilizar outro, trocar
    Veriout(setcolor(),23,wdbf)

    stru   := DBSTRUCT()
    oldLen := LastRec()
    !cp empresa.dbf empresa.old
    !mv empresa.dbf xteste.old
   /*
    If doserror() >0
       Release stru,OldLen
       Alert("Error ao Renomear DBF")
       Clear
       Quit
    Endif
  */
    wRet := isfield(wField)
    If wRet = .F.
       AADD(stru,{wField,wTipoc,wTam,wDec})
    Endif
    DBCREATE("empresa",Stru)
    use empresa
    Append from xteste.old
    If LastRec() != oldLen
       Release stru,OldLen
       Alert("Error, Modificacao Falhou !")
       Clear
       Quit
    Endif
    use

    !sudo chmod 777 &wDbf
    !rm -f xteste.old
    Release stru,OldLen,mDir,wDdir,wField,wtipoc,wTam,wDec
 Return

//********************
  Function Aut_Reserva(wLjs)
//********************
  Local wRet
  wRet = .f.
  Sele 12
  Veriout(setcolor(),23,"cdresdep")
  Go Top
  While !Eof()
    If Filial = Loja .and. reserva = wLjs
       wRet = .t.
       Exit
    Endif
    Skip
  Enddo
  Use
Return(wRet)

//****************
  Function isField(cField)
//****************
 Return(fieldpos(cField) <> 0)

//********************
  Function RetDiaSem(wDt)
//********************
Priv wDiaSem
If dow(wDt) = 7
   wDiaSem = "Sabado"
Elseif dow(wDt) = 1
   wDiaSem = "Domingo"
Elseif dow(wDt) = 2
   wDiaSem = "Segunda-Feira"
Elseif dow(wDt) = 3
   wDiaSem = "Terca-Feira"
Elseif dow(wDt) = 4
   wDiaSem = "Quarta-Feira"
Elseif dow(wDt) = 5
   wDiaSem = "Quinta-Feira"
Elseif dow(wDt) = 6
   wDiaSem = "Sexta-Feira"
Endif
Return(wDiasem)

//******************
  Procedure Efic_Vnd(wVend)
//******************
  Local wRet,m_efici,m_grvd
  Stor 0 to wRet,m_efici,m_grvd
  Sele 4                               // cdsaid.dbf
  Set Order to 5
  Seek Str(wVend,3,0)+SUBSTR(DTOC(M_Datsi),7,4)+SUBSTR(DTOC(M_Datsi),4,2)+SUBSTR(DTOC(M_Datsi),1,2)
  While !Eof() .and. SD_VEND = wVend .and. SD_DATA = M_Datsi
   If sd_cpf <> "   .   .   -  "  .and. sd_cpf <> space(14)   // P.F.
      wCodi     = Sd_Codi
      wMinuta   = Sd_Nota
      m_vendaef = Sd_Prec*Sd_Qtde
      w_vdgr    = sd_vdgr
      Sele 3                   // cdsie.dbf
      Set Order to 1
      Seek wCodi
      If !Eof() .and. cd_faixap >0
         m_efici = m_efici + m_vendaef
      Endif
      Sele 35                 // garantia.dbf
      Set Order to 3
      Seek Substr(dtoc(m_datsi),7,4)+Substr(dtoc(m_datsi),4,2)+Substr(dtoc(m_datsi),1,2)+Str(wVend,3,0)
      While !Eof() .and. gr_data = m_datsi .and. gr_vende = wVend
       If GR_Status = "V" .and. Gr_produto = wCodi .and. Gr_Minuta = wMinuta 
          m_grvd = m_grvd + w_vdgr
       Endif
       Skip
      Enddo
   Endif
   Sele 4
   Set Order to 5
   Skip
  Enddo
  wRet = (m_grvd / m_efici)*100
Return(wRet)

//*****************
  Function TestaCon(wVar,wAcesso,wIp,wCdz)
//*****************
  Priv wTestaIpLoja,wIpDestino,wIpRet
  wIpRet = ""
  If wVar = "Loja"
     wTestaIpLoja := Testa_Fil(xy_ipTunel)
     If wTestaIpLoja = .f.
        Alert("Link da Filial Fora do Ar !")
     Else
        wIpRet = xy_IpTunel
     Endif
  Else
     If wAcesso = "51" .and. wCdz = "20"               // Quixelo
        If xy_ipIbm <> "168.190.30.200"                // Acesso ao CDZ
           xy_ipIbm = "168.190.30.200"
        Endif
        wIpDestino := Testa_Fil(xy_ipIbm)
        wIpRet = xy_ipIbm
     Else
        wIpDestino := Testa_Fil(wIp)
        wIpRet = wIp
     Endif
     If wIpDestino = .f.
        Alert("Link da Filial de Destino Fora do Ar; IP: "+wIp)
        wIpRet = ""
     Endif
  Endif
  Release wTestaIpLoja,wIpDestino,wVar,wIp
  *Alert(wIpRet)
Return(wIpRet)

//******************
  PROCEDURE EXCLURES             // Excluindo Reserva on Line nos CDs
//******************
  Sele 25
  Set Order to 1
  wSaida  = substr(cd_Saida,1,13)
  wDataRes= cd_datao
  wCdz    = 0

  Sele 12
  Veriout(setcolor(),23,"saida_item")
  Go Top
  While !Eof()
    If SubStr(Saida_item,1,4) = SubStr(wSaida,1,4)
       If Substr(wSaida,1,2) = "CD" .or. Substr(wSaida,1,7) = "TIANGUA" .or. Substr(wSaida,1,6) = "FEIRAO"
          wCdz = Loja
          Exit
       Endif
    Endif
    Skip
  Enddo
  Use
  If wCdz = 0 // Cancelamento Automatico So' nos CdZ's !
     Return
  Endif

  wrr=savescreen(18,10,20,56)
  @ 18,10 to 20,55
  Setcolor("br+/b")
  @ 19,11 say "Excluindo reserva on line com "
  Setcolor("w+/b")
  @ 19,41 say wSaida
  inkey(1)
  Restscreen(18,10,20,56,wrr)
  Release wrr

  Sele 12
  Veriout(SETCOLOR(),23,"filiais")
  Go Top
  While !Eof()
    If Val(Fili) = wCdz
       M_LJX = M_LOJAD
       x_ip  = Trim(Ip_Tunel)
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
        Return
     Else
        w_ip := TestaCon("Destino","Exclures",x_ip)
        If Empty(w_ip)
           Return
        Endif
     Endif
  Endif

  Sele 25
  Set Order to 1

  mlj  = Alltrim(strzero(Loja,2))
  wlja = "sistema0801reserva"

  m_ssh = 'ssh -C -l '+wlja+' '+W_ip+' &W_Porta -t -q "/zenir/modulo/excreserv/excreserv "'+mlj+" "+alltrim(str(cd_reserv))+" "+alltrim(str(cd_codi))+" "+alltrim(strzero(cd_codven,3))+" "+alltrim(str(cd_codior))+" "+Alltrim(Strzero(wCdz,2))+" "+"erp"+" "+Dtoc(wDataRes)
  !&m_ssh

  // Cancelar, Com Paramentro de Cancelamento oDoo_RPC
  /*
    stFil:=ConfigLoja(I_FilOrigem,wCdz)   // funcoes.prg
    If stFil = .T.
       ConfCancRes(cd_codior,cd_reserv,substr(cd_saida,1,13),cd_codi,"CC")  && funcfat.prg
    Endif
  */

Release mlj,wlja,w_pora,wcdz,wRecno
Return

//***************
  Function Ret_Res(wCodigo)  // Retorna Reservas
//***************
  Priv wRet
  wRet = 0
  Sele 29
  Set order to 1
  Seek Str(wCodigo,6,0)
  While !Eof() .and. Re_codi = wCodigo
    If Re_data >= ctod("18/04/2016")
       If Empty(RE_Baixa)
          wRet = wRet + Re_Quant
       Endif
    Endif
    Skip
  Enddo
Return(wRet)

//*******************
  Function StrDireita(wVar)       // Colocando uma string a direita
//*******************
 Priv wRet
 wRet := ""
 wEsquerda = ltrim(alltrim(wVar))
 wSpace    = len(wVar) - len(wEsquerda)
 wRet      = space(wSpace)+wEsquerda
 Release wEsquerda,wVar,wSpace
Return(wRet)

//*******************
  Function Ret_Space(wVar,wSpace)       // Completa espacos na variavel
//*******************
 Priv wRet,varcl,y,z,w
 wRet := ""
 varcl=space(wSpace)       //  Brancos a Direita
 y=len(varcl)
 z=Len(Trim(wVar))
 w = y-z
 wRet = Trim(wVar)+space(w)
Return(wRet)

//********************
  Function Ret_Numeros(wCampo,Spacos)
//********************
  Local wRet,wRet1
  wRet := CharOnly("0123456789",wCampo)  // Funcao da LIB
  If Spacos >0
     wRet1:= Ret_Space(wRet,Spacos)      //  Adicionao o Spaco total da variavel
  Else
     wRet1:= wRet
  Endif
Return(wRet1)

//**********************
  Function RetornaCompo(wCd)            // Retorna o Componente do Codigo
//**********************
  Local wRet,wrecnoex,db_use,ord_index
  wRet = wCd
/*
  db_use    := Alias()
  ord_index := INDEXORD()
  wrecnoex  := Recno()
*/
  Sele 3
  Set Order to 10
  Seek wCd
  If !Eof()
     wRet = cd_codi
  Endif
  /*
  Sele (db_use)
  DBSetOrder(ord_index)
  Go wrecnoex
  */
Return(wRet)

//*********************
  Function RetornaEletr(wSbgrupo,wCom,m_nomg)            // Retorna eletrinho
//*********************
 Sele 43             // SubGrupos de Produtos ( Comissoes ) Se tiver ....
 Set Order to 1
 If Empty(ordsetfocus())                && refere-se ao indice aberto 
    Sele 43
    Veriout(setcolor(),23,"sgrupo")     && Sub_Grupos de Produtos
    Set index to index_sgrupo
    Sele 43
    Set Order to 1
 Endif
 Seek wSbgrupo
 If !Eof()
    If gr_comi >0
       wCom = GR_COMI
    Endif
    m_Nomg  = GR_NOME
 Else
    wCom   = 0
    m_Nomg = ""
 Endif
Return

//********************
  Function RetornaTaxa(wDepto,wMod,wParcela)            // Retorna Taxa para os Fatores
//********************
 db_use    := Alias()
 ord_index := INDEXORD()
 wrecnoex  := Recno()

 Sele 24
 Veriout(setcolor(),23,"fator")     && Sub_Grupos de Produtos
 Go Top
 While !Eof()
   If Depto = wDepto
      If wMod = 2                        // Cheque
         If PromoIN_CH >= m_datsi .and. PromoFN_CH <= m_datsi
            If wParcelas = NIL
               wParcelas = Vezes_CH
            Endif
            If (Vezes_CH >0) .and. (Vezes_CH <= wParcelas)
               m_tx_cc = taxap_cheq      // Taxa Promocional
            Else
               m_tx_cc = taxa_cheq       // taxa Normal
            Endif
         Else
            If wParcelas = NIL
               wParcelas = Vezes_CH
            Endif
            If (Zera_tx_ch >0) .and. (Zera_tx_ch <= wParcela)
               m_tx_cc = 0               // Zera taxa conforme parcela
            Else
               m_tx_cc = taxa_cheq
            Endif
         Endif
      ElseIf wMod = 3             // Carne
         If PromoIN_CA >= m_datsi .and. PromoFN_CA <= m_datsi
            If wParcelas = NIL
               wParcelas = Vezes_CA
            Endif
            If (Vezes_CA >0) .and. (Vezes_CA <= wParcelas)
               m_tx_cc = taxap_carn
            Else
               m_tx_cc = taxa_carne
            Endif
         Else
            If wParcelas = NIL
               wParcelas = Vezes_CA
            Endif
            If (Zera_tx_ca >0) .and. (Zera_tx_ca <= wParcela)
               m_tx_cc = 0
            Else
               m_tx_cc = taxa_carne
            Endif
         Endif
      ElseIf wMod = 4             // Financeira
         If PromoIN_FN >= m_datsi .and. PromoFN_FN <= m_datsi
            If wParcelas = NIL
               wParcelas = Vezes_FN
            Endif
            If (Vezes_FN >0) .and. (Vezes_FN <= wParcelas)
               m_tx_cc = taxap_fina
            Else
               m_tx_cc = taxa_finan
            Endif
         Else
            If wParcelas = NIL
               wParcelas = Vezes_FN
            Endif
            If (Zera_tx_fn >0) .and. (Zera_tx_fn <= wParcela)
               m_tx_cc = 0
            Else
               m_tx_cc = taxa_finan
            Endif
         Endif
      ElseIf wMod = 5             // Cartao
         If PromoIN_CC >= m_datsi .and. PromoFN_CC <= m_datsi
            If wParcelas = NIL
               wParcelas = Vezes_CC
            Endif
            If (Vezes_CC >0) .and. (Vezes_CC <= wParcelas)
                m_tx_cc = taxap_cart
            Else
                m_tx_cc = taxa_cart
            Endif
         Else
            If wParcelas = NIL
               wParcelas = Vezes_CC
            Endif
            If (Zera_tx_cc >0) .and. (Zera_tx_cc <= wParcela)
               m_tx_cc = 0
            Else
               m_tx_cc = taxa_cart
            Endif
         Endif
      ElseIf wMod = 6             // Carne/Convenio
         If PromoIN_CA >= m_datsi .and. PromoFN_CA <= m_datsi
            If wParcelas = NIL
               wParcelas = Vezes_CA
            Endif
            If (Vezes_CA >0) .and. (Vezes_CA <= wParcelas)
                m_tx_cc = taxap_carn
            Else
                m_tx_cc = taxa_carne
            Endif
         Else
            If wParcelas = NIL
               wParcelas = Vezes_CA
            Endif
            If (Zera_tx_ca >0) .and. (Zera_tx_ca <= wParcela)
               m_tx_cc = 0
            Else
               m_tx_cc = taxa_carne
            Endif
         Endif
      ElseIf wMod = 7             // Boleto
         If PromoIN_BL >= m_datsi .and. PromoFN_BL <= m_datsi
            If wParcelas = NIL
               wParcelas = Vezes_BL
            Endif
            If (Vezes_BL >0) .and. (Vezes_BL <= wParcelas)
                m_tx_cc = taxap_bole
            Else
                m_tx_cc = taxa_bolet
            Endif
         Else
            If wParcelas = NIL
               wParcelas = Vezes_BL
            Endif
            If (Zera_tx_bl >0) .and. (Zera_tx_bl <= wParcela)
               m_tx_cc = 0
            Else
               m_tx_cc = taxa_bolet
            Endif
         Endif
      Endif
      Exit
   Endif
   Skip
 Enddo
 Use
 Sele (db_use)
 DBSetOrder(ord_index)
 Go wrecnoex
 Release wMod
Return(m_tx_cc)

//*****************
  PROCEDURE Retimei(wCodigo)
//*****************
 Local i,telaimei,cont
 wInicioIMei = ""

 Priv lista :={},wImeiLista[99999]
 i = "00001"

 Sele 44
 Set Order to 2
 Go Top
 Clear Gets
 Seek Str(wCodigo,6,0)
 If !BoF()                                 // A funcao nao reconhece no inicio do arquivo
    If Vendido_lj = 0
       wImp = "s"
       If(At("Mostr",Motivo)) >0
          wMotivo = "S"
       Else
          wMotivo = "N"
       Endif
       If(At("Roubado",Motivo)) >0
          wRoubado = "S"
          wImp = "n"
       Else
          wRoubado = "N"
       Endif
       If cel_transf >0
          wTransf = "S"
          wImp = "n"
       Else
          wTransf = "N"
       Endif
       wBipado = Bipado
       If Empty(Bipado)
          wBipado = "N"
       Endif
       If wImp = "s"
          aadd(lista,Str(field->cel_codi,6)+" "+(cel_imei)+"     "+wBipado+"   "+Str(orcamento)+"         "+wMotivo+"             "+wTransf+"             "+wRoubado)
          wImeiLista[&i] = cel_imei
          i = Str(Val(i)+1)
       Endif
    Endif
 Endif                                     // Verificando o Restante
 wCodCel = alltrim(str(wCodigo))
 While ordWildSeek("*&wCodCel*",.t.)
   If Vendido_lj = 0 .and. cel_codi = &wCodCel
      wImp = "s"
      If(At("Mostr",Motivo)) >0
         wMotivo = "S"
      Else
         wMotivo = "N"
      Endif
      If(At("Roubado",Motivo)) >0
         wRoubado = "S"
         wImp = "n"
      Else
         wRoubado = "N"
      Endif
      If cel_transf >0
         wTransf = "S"
         wImp = "n"
      Else
         wTransf = "N"
      Endif
      wBipado = Bipado
      If Empty(Bipado)
         wBipado = "N"
      Endif
      If wImp = "s"
         aadd(lista,Str(field->cel_codi,6)+" "+(cel_imei)+"     "+wBipado+"   "+Str(orcamento)+"         "+wMotivo+"             "+wTransf+"             "+wRoubado)
         wImeiLista[&i] = cel_imei
         i = Str(Val(i)+1)
      Endif
   Endif
 Enddo

 *KEYB(CHR(13))
 *wait len(lista)
 cont = .t.
 While cont = .t.
  telaimei=savescreen(12,01,23,78)
  SETCOLOR("w+/b")
  @ 12,01 Say "Codigo Imei           Bipado  Or‡amento   Mostru rio   Transferido     Roubado"
  SETCOLOR("g/b")
  @ 13,01 to 13,78
  m_opca = achoice(14,01,22,78,lista,.t.,,)
  Setcolor(cor)
  restscreen(12,01,23,78,telaimei)
  If Lastkey() = 4 .or. Lastkey() = 19
     M_IMEI[&M] = ""
  Endif
  If Val(i) >1
     If lastkey() <> 27
        M_IMEI[&M] := wImeiLista[M_OPCA]
        cont = .f.
     Else
        M_IMEI[&M] = ""
     Endif
  Else
     M_IMEI[&M] = ""        // Nova Verificacao pelo indice caso a anterior falhe
     Seek Str(wCodigo,6,0)
     While !Eof() .and. cel_codi = wCodigo
       If Vendido_lj = 0
          wImp = "s"
          If(At("Mostr",Motivo)) >0
             wMotivo = "S"
          Else
             wMotivo = "N"
          Endif
          If(At("Roubado",Motivo)) >0
             wRoubado = "S"
             wImp = "n"
          Else
             wRoubado = "N"
          Endif
          If cel_transf >0
             wTransf = "S"
             wImp = "n"
          Else
             wTransf = "N"
          Endif
          If wImp = "s"
             aadd(lista,Str(field->cel_codi,6)+" "+(cel_imei)+"     "+bipado+"   "+Str(orcamento)+"         "+wMotivo+"             "+wTransf+"             "+wRoubado)
             wImeiLista[&i] = cel_imei
             i = Str(Val(i)+1)
          Endif
          Exit
       Endif
       Skip
     Enddo 
     If Val(i) >1
        cont = .t.
        Loop
     Endif
  Endif
  cont = .f.
Enddo
Release lista,wImeiLista
Return(M_IMEI[&M])

//********************
  Function ValidarImei(wCodCel,wImei)      // Retorna Imei
//********************
 Local wRet,wBusca
 wRet = .t.

 db_use    := Alias()
 ord_index := INDEXORD()
 wrecnoex  := Recno()

 Sele 44
 Set Order to 2
 Seek Str(wCodCel,6,0)+Substr(wImei,1,15)
 If !Eof()
    /*
    Telbip=savescreen(16,01,23,79)
    M_CORA =SETCOLOR()
    SETCOLOR("gb+/b")
    PRIV VETOR1[7]
    VETOR1[1]='CEL_CODI'
    VETOR1[2]='CEL_IMEI'
    VETOR1[3]='BIPADO'
    VETOR1[4]='ORCAMENTO'
    VETOR1[5]='MINUTA'
    VETOR1[6]='VENDIDO_LJ'
    VETOR1[7]='CEL_DATAS'
    DBEDIT(16,01,22,78,VETOR1,,,VETOR1)
    Restscreen(16,01,23,79,Telbip)
    Release Telbip
    wImei = CEL_IMEI
    */
    IF orcamento >0
       Alert("Imei Indisponivel, est  em Or‡amento !")
       wRet = .f.
    Endif
    IF Bipado = "T"
       Alert("Imei Indisponivel, est  em Transito !")
       wRet = .f.
    Endif
    IF wCodCel >0 .and. cel_codi <> wCodCel
       Alert("Esse Imei N„o Pertence a este Celular !")
       wRet = .f.
    Endif
    IF wCodCel >0 .and. cel_transf >0
       Alert("Esse Imei Foi Transferido! "+trim(cel_para)+" "+dtoc(cel_datatr))
       wRet = .f.
    Endif
    If(At("Roubado",Motivo)) >0
       Alert("Celular N„o Est  Disponivel, Motivo : Roubo/Furto")
       wRet = .f.
    Endif
    IF !Empty(devolucao)
       Alert("Celular Devolvido em "+dtoc(devolucao))
       wRet = .f.
    Endif
    IF !Empty(cel_datas)
       Alert("Celular Vendido em "+dtoc(cel_datas))
       wRet = .f.
    Endif
    IF !Empty(cel_para_2)
       Alert("Celular Transferido p/ "+trim(cel_para_2))
       wRet = .f.
    Endif
    IF !Empty(cel_para_3)
       Alert("Celular Transferido p/ "+trim(cel_para_3))
       wRet = .f.
    Endif
    IF !Empty(cel_para_4)
       Alert("Celular Transferido p/ "+trim(cel_para_4))
       wRet = .f.
    Endif
    IF !Empty(cel_para_5)
       Alert("Celular Transferido p/ "+trim(cel_para_5))
       wRet = .f.
    Endif
    IF Empty(bipado)
       Alert("Imei N„o Conferido; Favor Bipar a Entrada desse IMEI")
       wRet = .f.
    Endif
 Else
    Alert("Imei N„o Encontrado para Este Codigo ! ")
    wRet = .f.
 Endif
 If !Empty(wImei)
    m_imps = "s"
    If(At(".",wImei)) >0
       m_imps = "n"
    Endif
    If(At("+",wImei)) >0
       m_imps = "n"
    Endif
    If(At(",",wImei)) >0
       m_imps = "n"
    Endif
    If(At("*",wImei)) >0
       m_imps = "n"
    Endif
    If(At("/",wImei)) >0
       m_imps = "n"
    Endif
    If(At(",",wImei)) >0
       m_imps = "n"
    Endif
    If(At("@",wImei)) >0
       m_imps = "n"
    Endif
    If(At("&",wImei)) >0
       m_imps = "n"
    Endif
    If(At("#",wImei)) >0
       m_imps = "n"
    Endif
    If(At("^",wImei)) >0
      m_imps = "n"
    Endif
    If(At("%",wImei)) >0
       m_imps = "n"
    Endif
    If(At("-",wImei)) >0
       m_imps = "n"
    Endif
    If(At("_",wImei)) >0
      m_imps = "n"
    Endif
    If wImei="000000000000000"
       m_imps = "n"
    ElseIf wImei="111111111111111"
       m_imps = "n"
    ElseIf wImei="222222222222222"
       m_imps = "n"
    ElseIf wImei="333333333333333"
       m_imps = "n"
    ElseIf wImei="444444444444444"
       m_imps = "n"
    ElseIf wImei="555555555555555"
       m_imps = "n"
    ElseIf wImei="666666666666666"
       m_imps = "n"
    ElseIf wImei="777777777777777"
       m_imps = "n"
    ElseIf wImei="888888888888888"
       m_imps = "n"
    ElseIf wImei="AAAAAAAAAAAAAAA"
       m_imps = "n"
    ElseIf wImei="BBBBBBBBBBBBBBB"
       m_imps = "n"
    ElseIf wImei="CCCCCCCCCCCCCCC"
       m_imps = "n"
    ElseIf wImei="DDDDDDDDDDDDDDD"
       m_imps = "n"
    ElseIf wImei="EEEEEEEEEEEEEEE"
       m_imps = "n"
    ElseIf wImei="FFFFFFFFFFFFFFF"
       m_imps = "n"
    ElseIf wImei="GGGGGGGGGGGGGGG"
       m_imps = "n"
    ElseIf wImei="HHHHHHHHHHHHHHH"
       m_imps = "n"
    ElseIf wImei="XXXXXXXXXXXXXXX"
       m_imps = "n"
    ElseIf wImei="yyyyyyyyyyyyyyy"
       m_imps = "n"
    ElseIf wImei="ZZZZZZZZZZZZZZZ"
       m_imps = "n"
    Endif
    If m_imps = "n"
       Alert("Imei N„o Permitido ! ")
       wRet = .f.
    Endif
 Endif
 If Len(alltrim(wImei)) < 15
    Alert("Numero de Imei Incompleto !")
    wRet = .f.
 Endif

 Sele (db_use)
 DBSetOrder(ord_index)
 Go wrecnoex
Return(wRet)

//*********************
  Function ZeraOrcaIMei(wIMei)      // Zerando nr de Orcamento em IMei
//*********************
 Local wRet
 wRet = .f.
 Sele 44
 Set order to 1
 Seek wImei
 If !Eof()
    If Bloqreg(0)
       Repl orcamento with 0
    Endif
    Unlock
    wRet = .t.
 Endif
Return(wRet)

//**********************
  Function VCampoCPFCNPJ(cgcx,cpfx,m_cgf)
//**********************
 Local wRet
 wRet = .f.
 If cgcx="00.000.000/0000-00"
    wRet = .t.
 ElseIf cgcx="11.111.111/1111-11"
    wRet = .t.
 ElseIf cgcx="22.222.222/2222-22"
    wRet = .t.
 ElseIf cgcx="33.333.333/3333-33"
    wRet = .t.
 ElseIf cgcx="44.444.444/4444-44"
    wRet = .t.
 ElseIf cgcx="55.555.555/5555-55"
    wRet = .t.
 ElseIf cgcx="66.666.666/6666-66"
    wRet = .t.
 ElseIf cgcx="77.777.777/7777-77"
    wRet = .t.
 ElseIf cgcx="88.888.888/8888-88"
    wRet = .t.
 ElseIf cgcx="99.999.999/9999-99"
    wRet = .t.
 Endif
 If m_cgf="000000000000000000"
    wRet = .t.
 ElseIf m_cgf="111111111111111111"
    wRet = .t.
 ElseIf m_cgf="222222222222222222"
    wRet = .t.
 ElseIf m_cgf="333333333333333333"
    wRet = .t.
 ElseIf m_cgf="444444444444444444"
    wRet = .t.
 ElseIf m_cgf="555555555555555555"
    wRet = .t.
 ElseIf m_cgf="666666666666666666"
    wRet = .t.
 ElseIf m_cgf="777777777777777777"
    wRet = .t.
 ElseIf m_cgf="888888888888888888"
    wRet = .t.
 ElseIf m_cgf="999999999999999999"
    wRet = .t.
 Endif
 If cpfx="000.000.000-00"
    wRet = .t.
 ElseIf cpfx="111.111.111-11"
    wRet = .t.
 ElseIf cpfx="222.222.222-22"
    wRet = .t.
 ElseIf cpfx="333.333.333-33"
    wRet = .t.
 ElseIf cpfx="444.444.444-44"
    wRet = .t.
 ElseIf cpfx="555.555.555-55"
    wRet = .t.
 ElseIf cpfx="666.666.666-66"
    wRet = .t.
 ElseIf cpfx="777.777.777-77"
    wRet = .t.
 ElseIf cpfx="888.888.888-88"
    wRet = .t.
 ElseIf cpfx="999.999.999-99"
    wRet = .t.
 Endif
Return(wRet)

//********************
  Function RetCodCDSie
//********************
priv lista :={},wCod[99999]
Priv wTotx,wAvar,wAutor,wTotal,wSaldoLj,m,ssTela

Sele 3
Set Order to 2
Go Top
clear gets
Set cursor on
ssTela=SaveScreen(02,01,24,78)
wProd = SPACE(20)
cor=setcolor()
SETCOLOR("g/b")
sombra(02,02,04,49,Box)
@ 03,03 SAY "Produto ou palavra chave"get wProd pict "@!"
Read
If Empty(wProd)
   RestScreen(02,01,24,78,ssTela)
   Return(0)
Endif
@ 02,01 clear to 22,77
@ 02,01 to 02,77
SETCOLOR("w+/b")
@ 03,02 Say "Descri‡„o do Produto                Codigo Cor/Marca      A Vista Loja CDZ's"
SETCOLOR("g/b")
@ 04,01 to 20,77
@ 11,20 SAY "Verificando Estoques Disponiveis..."

wProd = alltrim(wProd)

m = "00001"
*? time()
while ordWildSeek("*&wProd*",.t.)

  wTotx = cd_centl11+cd_centl19+cd_centl20+cd_centl99+cd_centl10
  wAvar = CD_AVAR11+CD_AVAR19+CD_AVAR20+CD_AVAR99+CD_AVAR10
  wAutor= CD_AUTOR11+CD_AUTOR19+CD_AUTOR20+CD_AUTOR99+CD_AUTOR10
  *wSaldoLj = 0

  wSaldoLj:=RetSaldoCod(cd_codi)
  *wTotal = (wTotx+wSaldoLj) - (wAvar+wAutor)
  wTotal  = (wTotx) - (wAvar+wAutor)
  Sele 3
  Set Order to 2
  If wTotal >0 .or. wSaldoLj >0
     aadd(lista,Substr(field->cd_prod,1,35)+Str(cd_codi)+" "+Substr(cd_cor,1,7)+"/"+Substr(cd_fabr,1,6)+""+Str(cd_avista2,9,2)+""+Str(wSaldoLJ,5)+""+Str(wTotal,5))
     wCod[&m] = cd_codi
     M = Str(Val(M)+1)
  Endif
Enddo

*? time()
KEYB(CHR(13))
wait len(lista)
@ 11,20 clear to 11,50
m_opca = achoice(05,02,19,76,lista,.t.,,)
setcolor(cor)
RestScreen(02,01,24,78,ssTela)
If Lastkey() = 4 .or. Lastkey() = 19
   Return(0)
Endif
If Val(M) >1
   If lastkey() <> 27
      Return(wcod[M_OPCA])
   Else
      Return(0)
   Endif
Else
   Return(0)
Endif

//********************
  Function RetSaldoCod(wCd)
//********************
  Sele 30
  Set Order to 1
  Seek wCd
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
     Return(0)
  Endif
  If I_Fiscal = "S"
     /*
     CENTX     := SD_Fisc(wCd)
     M_Pendenc := SD_Pend(wCd)
    */ 
     Stor 0 to Centx,m_pendenc
     SD_Fisc(wCd,,,@Centx,@M_Pendenc)
     M_SdPendenc := SD_Pend(wCd)
     M_Pendenc = M_Pendenc + M_SdPendenc
     
  Endif
  M_Res := Ret_Res(wCd)    // Funcoes.prg
  CENTX = CENTX - (M_RES+M_AVARIA+M_AUTORIZ+M_TRANSIT+M_PENDENC)
Return(CENTX)

//**********************
  Function VerificaCodRelac(wPara)   // Verificando a existencia do Cod Relacionado no orcamento
//**********************
 Local wRet
 wRet = .f.
 Sele 25
 Set Order to 1
 Seek STR(M_NOTA,8,0)+SUBSTR(DTOC(M_DATSI),7,4)+SUBSTR(DTOC(M_DATSI),4,2)+SUBSTR(DTOC(M_DATSI),1,2)
 While !Eof() .and. CD_CODIOR = M_NOTA .AND. CD_DATAO = M_DATSI
   If cd_codi = wPara
      wRet = .t.
      Exit
   Endif
   Skip
 Enddo
Return(wRet)

//**********************
  Function RetDeparaComp(wDe)   // Retorna Codigo para venda com relacionamento
//**********************
 Local wRet
 wRet = 0
 Sele 95
 Veriout(SETCOLOR(),23,"relacdepara")
 Go Top
 While !Eof()
   If De = wDe
      wRet = Para
      Exit
   Endif
   Skip
 Enddo
 Sele 95
 Use
Return(wRet)

//***************
  Function CadCpf(wCodigovd)
//***************
  Local wCpf,wNome,wPs,wtelasw
  wtelasw = savescreen(07,05,12,72)
  Sele 16
  Set Order to 1
  Go Top
  Seek Str(wCodigovd,3,0)
  If !Eof() .and. (Empty(ba_partic) .or. Len(Alltrim(ba_partic)) <= 10)
     If Len(Alltrim(ba_partic))<= 10
        Alert(Trim(ba_partic)+", Por Favor Digite seu Nome Completo")
     Endif
     wPs = "n"
     While .t.
       wCpf = space(14)
       wNome= space(50)
       Setcolor("gr+/b")
       Sombra(06,05,11,71,Box)
       @ 07,06 Say "Informa‡”es para o E-Social"
       @ 08,06 to 08,70
       @ 09,55 Say M_Nomeusu
       @ 09,06 Say "CPF........  :"get wCpf  pict "999.999.999-99"
       @ 10,06 Say "Nome Completo:"get wNome pict "@!" valid !Empty(wNome)
       Read
       If Empty(wNome)
          Alert("Dados Incompletos !")
          Loop
       Endif
       If Len(Alltrim(wNome))<= 10
          If(Alert(Trim(wNome)+", Este e' seu Nome Completo ?" , {"Sim" , "N„o"} )) = 2
            Loop
          Endif
       Endif
       If val(wCpf) >0
          wwCpf := Ret_Numeros(wCpf,0)
          If len(alltrim(wwCpf)) < 11
             Alert("C.P.F. Incompleto !")
             Loop
          Endif
          Ver_Cpf(wwCpf)
          If Res_Cpf = "EOF"
             Loop
          Endif
       Else
          Alert("Digite o CPF !")
          Loop
       Endif
       wPs = "s"
       Exit
     Enddo
  Endif
  If wPs = "s"
     While !Eof() .and. ba_codi = wCodigovd
       If Bloqreg(0)
          Repl ba_cpf with wCpf,ba_partic with wNome,ba_data with m_datsi
       Endif
       Unlock
       Skip
     Enddo
  Endif
  Restscreen(07,05,12,72,wtelasw)
Return

//****************
  Function Ret_StFone(wFone,wUf,FixoCel)   // Retorna Status do Numero de Telefone
//****************
  Local wRet
  wRet = .t.
  If !Empty(wFone)
     If FixoCel = "F"
        If len(alltrim(wFone)) < 10
           Alert("Faltam Digitos no Tel Fixo !")
           wRet = .f.
        Endif
     Else
        If len(alltrim(wFone)) < 11
           Alert("Faltam Digitos no Tel Celular!")
           wRet = .f.
        Endif
     Endif
  Endif
  Release wFone,wUf,FixoCel
Return(wRet)

//****************
  Function VerSAldo(wCod)   // Retorna Saldo Disponivel
//****************
   Local wRet
   wRet = 0
   M_Res := Ret_Res(wCod)    // Funcoes.prg
   Stor 0 to Cent,M_Pendenc,wTransit
   SD_Fisc(wCod,,,@Cent,@M_Pendenc,@wTransit)
   M_SdPendenc := SD_Pend(wCod)
   M_Pendenc = M_Pendenc + M_SdPendenc
   Sele 30
   Set Order to 1
   If cd_transit < 0
      If Bloqreg(0)
         Repl cd_transit With 0
      Endif
      Comm
      Unlock
   Endif
   m_transit = cd_transit
   If m_transit <> wTransit
      m_transit = wTransit
   Endif

   CENTX = CENT - (cd_avaria+m_res+m_transit+M_PENDENC)

   Sele 4
   Set Order to 2
   Go Top
   Seek Str(wCod,6,0)+substr(dtoc(m_datsi),7,4)+substr(dtoc(m_datsi),4,2)+substr(dtoc(m_datsi),1,2)
   Stor 0 to wAfaturar
   While !Eof() .and. sd_codi = wCod .and. sd_data = m_datsi
    If Trim(sd_saida) = "LOJA/MOSTR"
       wJaFat := SD_JaFat(sd_codi,sd_nota)
       If wJafat = 0
          wAfaturar = wAfaturar + sd_qtde
       Endif
    Endif
    Sele 4
    Set Order to 2
    Skip
   Enddo
Return(CENTX-wAfaturar)

//**********************
  Function Ret_TipoVenda(m_tpf,m_tipo,m_vezes,m_texto,m_tpfin)
//**********************
  IF M_TPF >0 .and. M_Tipo = 4
     If M_tpf = 1
        M_TPFIN = "Losango   "
     ElseIf M_tpf = 2
      * M_TPFIN = "Fininvest "
        M_TPFIN = "Omni "
     ElseIf M_tpf = 3
        M_TPFIN = "Finasa    "
     ElseIf M_tpf = 5
        M_TPFIN = "Cetelem"
     Endif
  ElseIf M_TPF >0 .and. M_Tipo = 5
     If M_tpf = 1
        M_TPFIN = "Visa      "
     Elseif M_tpf = 2
        M_TPFIN = "MasterCard"
     Elseif M_tpf = 3
        M_TPFIN = "HiperCard "
     Elseif M_tpf = 4
        M_TPFIN = "Diners"
     Elseif M_tpf = 5
        M_TPFIN = "Outras"
     Elseif M_tpf = 6
        M_TPFIN = "FortBrasil"
     Elseif M_tpf = 7
        M_TPFIN = "American Exp"
     Elseif M_tpf = 8
        M_TPFIN = "Elo"
     Elseif M_tpf = 10
        M_TPFIN = "American Exp"
     ElseIf M_tpf = 11
        M_TPFIN = "Cielo/FortBR"
     ElseIf M_tpf = 12
        M_TPFIN = "Cielo/Outras"
     ElseIf M_tpf = 13
        M_TPFIN = "Rede/CredSystem"
     ElseIf M_tpf = 14
        M_TPFIN = "Rede/SoroC"
     ElseIf M_tpf = 15
        M_TPFIN = "Rede/Cabal"
     ElseIf M_tpf = 16
        M_TPFIN = "Rede/CredZ"
     Endif
  ElseIf M_Tipo = 6
     M_TPFIN=""
  Endif
  IF M_TIPO = 1
     m_texto = " Venda a Vista    "
  ELSEIF M_TIPO = 2
     m_texto = " Venda Com Cheque "+" Em "+Strzero(m_vezes,2)+" Vezes"
  ELSEIF M_TIPO = 3
     m_texto = " Venda Com Carnˆ  "+" Em "+Strzero(m_vezes,2)+" Vezes"
  ELSEIF M_TIPO = 4
     m_texto = " Venda Financeira - "+m_tpfin
  ELSEIF M_TIPO = 5
     m_texto = " Venda Com C/Cr‚d.- "+m_tpfin+" Em "+Strzero(m_vezes,2)+" Vezes"
  ELSEIF M_TIPO = 6
     m_texto = " Venda Convˆnio - "+m_tpfin
  ELSEIF M_TIPO = 7
     m_texto = " Venda BMG (Consignada) "
  ELSEIF M_TIPO = 8
     m_texto = " Caixa / Convenio "
  ELSEIF M_TIPO = 9
     m_texto = " Caixa / Financ   "
  ELSEIF M_TIPO = 10
     m_texto = " Boleto Bancario  "
  ENDIF
Return

//**************
  PROC BuscaCNPJ(m_nomef,m_forn,wCnpj)    // Busca fornecedor por CNPJ
//**************
 Sele 2
 Set Order to 1
 Go top
 While !Eof()
   If fn_cgc = wCnpj
      m_nomef = fn_nome
      m_forn  = fn_codi
      Exit
   Endif
   Skip
 Enddo
Return

//******************
  PROC PegaSaidaItem(wOpcao,NRCD,wTentatita,wFilOrigem,wRegional)   // Retorna a saida do produto conforme sua regional
//******************
 Local sdp
 M_SAIDA = ""
 M_ROTAX = 0
 While .t.
    If wTentatita = 0
       telentr=savescreen(10,10,21,72)
       Sombra(10,11,20,62)
       Padrao()  //cores
       MOV_LINHA := 10; MOV_COLUNA := 11
       JANELA( MOV_LINHA, MOV_COLUNA, MOV_LINHA + 10, MOV_COLUNA + 51, "Defina Em Qual Regional Ser  a Entrega" )
       SETCOLOR( CONTECOR[ 11 ] + "," + CONTECOR[ 9 ] + ",,," + CONTECOR[ 8 ] )
       @ 12,16 Prom "       Saida Loja/Mostru rio               "
       @ 14,16 Prom "       Entregar pelo CD da sua Regional    "
       @ 16,16 Prom "   Entregar pelo CD Fora da sua Regional   "
       @ 18,16 Prom "       O U T R A S                         "
       Menu to wOpcao
       restscreen(10,10,21,72,telentr)
    Endif
    If Lastkey() = 27
       Exit
    Endif
    If wTentatita = 1 .and. wOpcao = 3        // Tentativa >0 , Buscando no cd mais proximo qdo o cd da regional estiver zerado
       wOpcaoCD = 1
    ElseIf wTentatita = 2 .and. wOpcao = 3    // Tentativa >0 , Buscando no cd mais proximo qdo o cd da regional estiver zerado
       wOpcaoCD = 2
    ElseIf wTentatita = 3 .and. wOpcao = 3    // Tentativa >0 , Buscando no cd mais proximo qdo o cd da regional estiver zerado
       wOpcaoCD = 3
    ElseIf wTentatita = 4 .and. wOpcao = 3    // Tentativa >0 , Buscando no cd mais proximo qdo o cd da regional estiver zerado
       wOpcaoCD = 4
    Endif
    If wOpcao = 1
       M_SAIDA = "LOJA/MOSTR"
       M_NRCD  = 0
    ElseIf wOpcao = 2                   // Entregar na regional
       If I_Priorid = 10
          M_SAIDA = "CD TAUA"
          M_NRCD  = 10
       ElseIf I_Priorid = 11
          M_SAIDA = "CD SOBRAL"
          M_NRCD  = 11
       ElseIf I_Priorid = 19
          M_SAIDA = "CD FORT"
          M_NRCD  = 19
       ElseIf I_Priorid = 20
          M_SAIDA = "CD IGUATU"
          M_NRCD  = 20
       ElseIf I_Priorid = 99
          M_SAIDA = "CD JUAZE"
          M_NRCD  = 99
       /*
       ElseIf I_Priorid = 44
          M_SAIDA = "TIANGUA"
          M_NRCD  = 44
       */
       Endif
    ElseIf wOpcao = 3                 // Entregar fora da regional
       If I_Priorid = 10              // CD Taua
          If wTentatita = 0
             wtelcd=savescreen(10,63,15,77)
             Sombra(10,63,15,76)
             @ 11,65 Prom "CD Iguatu "
             @ 12,65 Prom "CD Fort   "
             @ 13,65 Prom "CD Juaz   "
             @ 14,65 Prom "CD Sobral "
             Menu to wOpcaoCD
             Restscreen(10,63,15,77,wtelcd)
          Endif
          If wOpcaoCD = 1
             If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                M_SAIDA = "CD IGUATU"
             Else
                M_SAIDA = "CD IGUATU/"+wFilOrigem
             Endif
             M_NRCD  = 20
          ElseIf wOpcaoCD = 2
             If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                M_SAIDA = "CD FORT"
             Else
                M_SAIDA = "CD FORT/"+wFilOrigem
             Endif
             M_NRCD  = 19
          ElseIf wOpcaoCD = 3
             If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                M_SAIDA = "CD JUAZE"
             Else
                M_SAIDA = "CD JUAZE/"+wFilOrigem
             Endif
             M_NRCD  = 99
          ElseIf wOpcaoCD = 4
             If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                M_SAIDA = "CD SOBRAL"
             Else
                M_SAIDA = "CD SOBRAL/"+wFilOrigem
             Endif
             M_NRCD  = 11
          Endif
       ElseIf I_Priorid = 11                     // CD SOBRAL
          If wTentatita = 0
             wtelcd=savescreen(10,63,15,77)
             Sombra(10,63,14,76)
             @ 11,65 Prom "CD Iguatu "
             @ 12,65 Prom "CD Fort   "
             @ 13,65 Prom "CD Juaz   "
             /*                             Modificado por Tharles em 30/04/2021
             @ 11,65 Prom "CD Fort   "
             @ 12,65 Prom "CD Iguatu "
             @ 13,65 Prom "CD Juaz   "
             */
             Menu to wOpcaoCD
             Restscreen(10,63,15,77,wtelcd)
          Endif
          If wOpcaoCD = 1
             If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                M_SAIDA = "CD IGUATU"
             Else
                M_SAIDA = "CD IGUATU/"+wFilOrigem
             Endif
             M_NRCD  = 20
          ElseIf wOpcaoCD = 2
             If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                M_SAIDA = "CD FORT"
             Else
                M_SAIDA = "CD FORT/"+wFilOrigem
             Endif
             M_NRCD  = 19
          ElseIf wOpcaoCD = 3
             If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                M_SAIDA = "CD JUAZE"
             Else
                M_SAIDA = "CD JUAZE/"+wFilOrigem
             Endif
             M_NRCD  = 99
          Endif
         
          /*                                Modificado por Tharles em 30/04/2021
          If wOpcaoCD = 1
             If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                M_SAIDA = "CD FORT"
             Else
                M_SAIDA = "CD FORT/"+wFilOrigem
             Endif
             M_NRCD  = 19
          ElseIf wOpcaoCD = 2
             If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                M_SAIDA = "CD IGUATU"
             Else
                M_SAIDA = "CD IGUATU/"+wFilOrigem
             Endif
             M_NRCD  = 20
          ElseIf wOpcaoCD = 3
             If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                M_SAIDA = "CD JUAZE"
             Else
                M_SAIDA = "CD JUAZE/"+wFilOrigem
             Endif
             M_NRCD  = 99
          Endif
         */
       ElseIf I_Priorid = 19                     // CD FORTALEZA
          If wTentatita = 0
             wtelcd=savescreen(10,63,15,77)
             Sombra(10,63,14,76)
             @ 11,65 Prom "CD Iguatu"
             @ 12,65 Prom "CD Juaz"
             @ 13,65 Prom "CD Sobral"
             Menu to wOpcaoCD
             Restscreen(10,63,15,77,wtelcd)
          Endif
          If wOpcaoCD = 1
             If wOpcao = 3 .and. wRegional = .t.   // Primeira vez e entregar fora da regional
                M_SAIDA = "CD IGUATU"
             Else
                M_SAIDA = "CD IGUATU/"+wFilOrigem  // Primeira vez e retonar para o CD 19
             Endif
             M_NRCD  = 20
          ElseIf wOpcaoCD = 2
             If wOpcao = 3 .and. wRegional = .t.
                M_SAIDA = "CD JUAZE"
             Else
                M_SAIDA = "CD JUAZE/"+wFilOrigem
             Endif
             M_NRCD  = 99
          ElseIf wOpcaoCD = 3
             If wOpcao = 3 .and. wRegional = .t.
                M_SAIDA = "CD SOBRAL"
             Else
                M_SAIDA = "CD SOBRAL/"+wFilOrigem
             Endif
             M_NRCD  = 11
          Endif
       ElseIf I_Priorid = 20                          // CD IGUATU
          If wTentatita = 0
             If wFilOrigem <> "37"
                wtelcd=savescreen(10,63,15,77)
                Sombra(10,63,14,76)
                @ 11,65 Prom "CD Fort   "
                @ 12,65 Prom "CD Juaz   "
                @ 13,65 Prom "CD Sobral "
                *@ 14,65 Prom "CD Taua   "
                Menu to wOpcaoCD
                Restscreen(10,63,15,77,wtelcd)
             Else
                wtelcd=savescreen(10,63,15,77)
                Sombra(10,63,15,76)
                @ 11,65 Prom "CD Taua   "
                @ 12,65 Prom "CD Fort   "
                @ 13,65 Prom "CD Juaz   "
                @ 14,65 Prom "CD Sobral "
                Menu to wOpcaoCD
                Restscreen(10,63,15,77,wtelcd)
             Endif
          Endif
          If wFilOrigem <> "37"                                // Se Nao for de CD Taua
             If wOpcaoCD = 1
                If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                   M_SAIDA = "CD FORT"
                Else
                   M_SAIDA = "CD FORT/"+wFilOrigem
                Endif
                M_NRCD  = 19
             ElseIf wOpcaoCD = 2
                If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                   M_SAIDA = "CD JUAZE"
                Else
                   M_SAIDA = "CD JUAZE/"+wFilOrigem
                Endif
                M_NRCD  = 99
             ElseIf wOpcaoCD = 3
                If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                   M_SAIDA = "CD SOBRAL"
                Else
                   M_SAIDA = "CD SOBRAL/"+wFilOrigem
                Endif
                M_NRCD  = 11
             Endif
          Else                           // Se for CD taua
             If wOpcaoCD = 1
                If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                   M_SAIDA = "CD TAUA"
                Else
                   M_SAIDA = "CD TAUA/"+wFilOrigem
                Endif
                M_NRCD  = 10
             ElseIf wOpcaoCD = 2
                If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                   M_SAIDA = "CD FORT"
                Else
                   M_SAIDA = "CD FORT/"+wFilOrigem
                Endif
                M_NRCD  = 19
             ElseIf wOpcaoCD = 3
                If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                   M_SAIDA = "CD JUAZE"
                Else
                   M_SAIDA = "CD JUAZE/"+wFilOrigem
                Endif
                M_NRCD  = 99
             ElseIf wOpcaoCD = 4
                If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                   M_SAIDA = "CD SOBRAL"
                Else
                   M_SAIDA = "CD SOBRAL/"+wFilOrigem
                Endif
                M_NRCD  = 11
             Endif
          Endif
       ElseIf I_Priorid = 99                   // CD JUAZEIRO
          If wTentatita = 0
             wtelcd=savescreen(10,63,15,77)
             Sombra(10,63,14,76)
             @ 11,65 Prom "CD Iguatu"
             @ 12,65 Prom "CD Fort  "
             @ 13,65 Prom "CD Sobral "
             Menu to wOpcaoCD
             Restscreen(10,63,15,77,wtelcd)
          Endif
          If wOpcaoCD = 1
             If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                M_SAIDA = "CD IGUATU"
             Else
                M_SAIDA = "CD IGUATU/"+wFilOrigem
             Endif
             M_NRCD  = 20
          ElseIf wOpcaoCD = 2
             If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                M_SAIDA = "CD FORT"
             Else
                M_SAIDA = "CD FORT/"+wFilOrigem
             Endif
             M_NRCD  = 19
          ElseIf wOpcaoCD = 3
             If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                M_SAIDA = "CD SOBRAL"
             Else
                M_SAIDA = "CD SOBRAL/"+wFilOrigem
             Endif
             M_NRCD  = 11
          Endif
      /*
       ElseIf I_Priorid = 44                      // TIANGUA
          If wTentatita = 0
             wtelcd=savescreen(10,63,16,77)
             Sombra(10,63,15,76)
             @ 11,65 Prom "CD Iguatu "
             @ 12,65 Prom "CD Fort   "
             @ 13,65 Prom "CD Juaz   "
             @ 14,65 Prom "CD Sobral "
             Menu to wOpcaoCD
             Restscreen(10,63,16,77,wtelcd)
          Endif
          If wOpcaoCD = 1
             If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                M_SAIDA = "CD IGUATU"
             Else
                M_SAIDA = "CD IGUATU/"+wFilOrigem
             Endif
             M_NRCD  = 20
          ElseIf wOpcaoCD = 2
             If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                M_SAIDA = "CD FORT"
             Else
                M_SAIDA = "CD FORT/"+wFilOrigem
             Endif
             M_NRCD  = 19
          ElseIf wOpcaoCD = 3
             If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                M_SAIDA = "CD JUAZE"
             Else
                M_SAIDA = "CD JUAZE/"+wFilOrigem
             Endif
             M_NRCD  = 99
          ElseIf wOpcaoCD = 4
             If wOpcao = 3 .and. wRegional = .t.            // Primeira vez e entregar fora da regional
                M_SAIDA = "CD SOBRAL"
             Else
                M_SAIDA = "CD SOBRAL/"+wFilOrigem
             Endif
             M_NRCD  = 11
          Endif
       */
       Endif
    Else
       sdp=savescreen(09,58,20,78)
       Sele 12
       Veriout(setcolor(),23,"saida_outras")
       Go Top
       M_CORA =SETCOLOR()
       PRIV VETOR1[1]
       VETOR1[1]='SAIDA_ITEM'
       DBEDIT(09,59,20,77,VETOR1,,,VETOR1)
       /*
       If Destino = Lojas
          Alert("Escolha invalida, Mesma Loja de Destino !")
          restscreen(09,58,20,78,sdp)
          Loop
       Endif
       */
       M_SAIDA = TRIM(SAIDA_ITEM)
       M_NRCD  = LOJA
       RELEASE VETOR1
       SETCOLOR(M_CORA)
       Use
       If M_NRCD = 01 .or. M_NRCD = 12 .or. M_NRCD = 13 .or. M_NRCD = 18 .or. M_NRCD = 22
          Alert("Filial Desativada !")
          restscreen(09,58,20,78,sdp)
          Loop
       Endif
       restscreen(09,58,20,78,sdp)
    Endif
    If Empty(m_saida)
       Alert("Vocˆ Esqueceu de Escolher a Sa¡da dos Produtos")
       Loop
    Endif
    Exit
  Enddo
Return(m_saida)

//*************************
  Procedure InsereOrcamento(wOrcamento,wCpfVendedor,SaidaCdIguatu)
//*************************

 VerificaProdutos(wOrcamento)    // Verificando se os produtos existem no 9.2

 Priv w_vezesgr[10],w_garant[10],w_plano[10],m_grfator[10],wStatus[10],M_Pre[10]
 Priv m_gr[10],M_QTD[10],M_COD[10],M_PRD[10],M_COR[10],M_DE[10],M_AC[10],M_SAID[10]
 Priv M_RESERV[10],M_PERCENTR[10],M_AUTOR[10],M_VRCIRC[10],M_Vezesci[10],M_VEZES
 Priv M_VEND[10],M_NOMEV[10],M_IMEI[10],M_TXE[10],M_TXM[10],TEMGARANTIA

 M = "001"
 TEMGARANTIA   = "N"
 TEMSAIDACD    = "N"
 SaidaCdIguatu = "N"

 Sele 25
 Set Order to 1
 Seek STR(wOrcamento,8,0)+SUBSTR(DTOC(M_DATSI),7,4)+SUBSTR(DTOC(M_DATSI),4,2)+SUBSTR(DTOC(M_DATSI),1,2)
 While !Eof() .and. CD_CODIOR = wOrcamento .and. CD_DATAO = M_DATSI
   M_CGF     = CD_CGF
   FON1X     = CD_FIXO
   M_CLIE    = CD_CODICL
   M_NOME    = CD_NOMECL
   M_ENDEX   = CD_ENDE
   M_NUMERO  = CD_NUMERO
   If Empty(M_NUMERO)
      M_NUMERO = "SN"
   Endif
   M_COMPLE  = CD_COMPLE
   FONECEL   = CD_FONE
   If !Empty(CD_CPF)
      CPFX      = CD_CPF
   Else
      CPFX      = CD_CGC
   Endif
   M_RG      = CD_RG
   CGCX      = CD_CGC
   M_BAICL   = CD_BAIR
   M_CEPCL   = CD_CEP
   M_Ibge    = CD_IBGE
   M_CIDACL  = CD_CIDA
   M_UFCL    = CD_UF
   M_CEL     = CD_CEL
   wEndTrega = CD_ENDET
   wNumero   = CD_NUMEROT
   If Empty(wNumero)
      wNumero = "SN"
   Endif
   wCOMPLE   = CD_COMPLET
   wIBgeTrega= CD_IBGET
   wCidaTrega= CD_CIDAT
   wBairTrega= CD_BAIRT
   wCepTrega = CD_CEPT
   wUFtrega  = CD_UFT
   M_NUM     = CD_NUMPRE
   M_TIPO    = CD_TIPOV
   M_ENTRAD  = CD_ENTRA
   M_NUM1    = CD_NUM1
   M_NUM2    = CD_NUM2
   M_NUM3    = CD_NUM3
   M_NUM4    = CD_NUM4
   M_VRP1    = CD_VRPARC1
   M_VRP2    = CD_VRPARC2
   M_VRP3    = CD_VRPARC3
   M_VRP4    = CD_VRPARC4
   M_DTA1    = CD_DTA1
   M_DTA2    = CD_DTA2
   M_DTA3    = CD_DTA3
   M_DTA4    = CD_DTA4
   M_DTA5    = CD_DTA5
   M_DTA6    = CD_DTA6
   M_DTA7    = CD_DTA7
   M_DTA8    = CD_DTA8
   M_DEBCC   = CD_DEBCC
   M_REFER   = CD_REFER
   M_REFER2  = CD_REFER2
   M_OBSER   = CD_OBSER
   M_VRFIN   = CD_VRFIN
   M_VRCAR   = CD_VRCAR
   M_eMAIL   = ""
   If M_TIPO = 10
      M_TIPO = 8    // Boleto
   Endif
   wPrestacoes = M_NUM1+M_NUM2+M_NUM3+M_NUM4
   If wPrestacoes = 0
      wPrestacoes = 1
   ElseIf wPrestacoes > 15
      wPrestacoes = 12
   Endif
   If Trim(CD_SAIDA) <> "LOJA/MOST"
      TEMSAIDACD  = "S"
   Endif
   If Trim(CD_SAIDA) = "CD IG" .or. Trim(CD_SAIDA) = "CDZ IG"
      SaidaCdIguatu = "S"
   Endif
   //Itens
   If CD_VRGR >0
      TEMGARANTIA = "S"
   Endif
   M_VEZES       = CD_VEZES
   w_vezesgr[&m] = CD_QTDEGR
   w_garant[&m]  = CD_VRGR
   w_plano[&m]   = CD_PLANO
   m_grfator[&m] = CD_FATORGR
   wStatus[&m]   = CD_STATUS
   m_GR[&m]      = CD_GR
   M_QTD[&m]     = CD_QUANT
   M_COD[&m]     = CD_CODI
   M_Pre[&m]     = CD_UNIT

   If M_Pre[&m] = 0
     Sele 3
     Set Order to 1
     Seek M_COD[&m]
     M_Pre[&m] = CD_AVISTA2
     Sele 25
     Set Order to 1
   Endif

   M_PRD[&m]     = CD_PROD
   M_COR[&m]     = CD_COR
   M_DE[&m]      = CD_DESCO
   M_AC[&m]      = CD_ACRES
   M_SAID[&m]    = CD_SAIDA
   M_RESERV[&m]  = CD_RESERV
   M_PERCENTR[&m]= CD_VALOR
   M_AUTOR[&m]   = CD_AUTOR
   M_VRCIRC[&m]  = CD_VRCIRC
   M_Vezesci[&m] = CD_VEZESCI
   M_VEND[&m]    = CD_CODVEN
   M_NOMEV[&m]   = CD_VENDED
   M_IMEI[&m]    = CD_IMEI
   M_TXE[&m]     = CD_TXE
   M_TXm[&m]     = CD_TXM
   M = Str(Val(m)+1)
   Skip
 Enddo

  wtesteOrcam = alltrim(str(wOrcamento))
  wFasePostgres = "Verificando Se Existe Participante no 9.2"
  !echo &wFasePostgres  >> /tmp/orca_&wtesteOrcam

  wIdPart:= RetPartic(m_Clie,m_Nome,m_Endex,m_Numero,m_Comple,m_CepCl,m_Baicl,m_IBge,m_UFCL,m_CIDACL,CPFx,m_CGF,FoneCel,m_eMAIL)

  If wIdPart >0
     wFasePostgres = "Participante Ok "
     !echo &wFasePostgres  >> /tmp/orca_&wtesteOrcam
  Else
     wFasePostgres = "Participante Nao Cadastrado"
     !echo &wFasePostgres  >> /tmp/orca_&wtesteOrcam
  Endif

 // Abertura do banco

     wFasePostgres = "Inicio de Insercao do Orcamento"
     !echo &wFasePostgres  >> /tmp/orca_&wtesteOrcam

   cRdd:=RddSetDefault("DBFCDX")
   nCodFuncio:=999999
   ConfiguraAmbienteDb()           // Abrindo Postgres

   oOrcamento:=TOrcamento():init()
   Select Orcamentos
   Priv cFields:="", cValues:="", aParam:={}, hFields:= hash()
   hfields['FUNCIONARIOS_ID'] = nCodFuncio
   hFields['FUNCIONARIO_ALTERACAO_ID'] := nCodFuncio
   hFields['FUNCIONARIO_INCLUSAO_ID'] := nCodFuncio
   hFields['PARTICIPANTES_ID'] := wIdPart
   hFields['LOJAS_ID']         := I_FilOrigem
   hFields['DATA_DO_ORCAMENTO']:= M_Datsi
   hFields['TIPO_DE_VENDA']    := M_TIPO
   hFields['PLANO_DE_PAGAMENTO_ID']:= M_TIPO
   hFields['ENTRADA']          := M_ENTRAD
   hFields['QUANTIDADE_VEZES'] := M_VEZES
   hFields['CONDICAO_NUMERO1'] := M_NUM1
   hFields['CONDICAO_NUMERO2'] := M_NUM2
   hFields['CONDICAO_NUMERO3'] := M_NUM3
   hFields['CONDICAO_NUMERO4'] := M_NUM4
   hFields["VALOR_PARCELA_CONDICAO1"] := M_VRP1
   hFields["VALOR_PARCELA_CONDICAO2"] := M_VRP2
   hFields["VALOR_PARCELA_CONDICAO3"] := M_VRP3
   hFields["VALOR_PARCELA_CONDICAO4"] := M_VRP4
   hFields["DATA_INICIAL_CONDICAO1"]  := M_DTA1
   hFields["DATA_FINAL_CONDICAO1"]    := M_DTA2
   hFields["DATA_INICIAL_CONDICAO2"]  := M_DTA3
   hFields["DATA_FINAL_CONDICAO2"]    := M_DTA4
   hFields["DATA_INICIAL_CONDICAO3"]  := M_DTA5
   hFields["DATA_FINAL_CONDICAO3"]    := M_DTA6
   hFields["DATA_INICIAL_CONDICAO4"]  := M_DTA7
   hFields["DATA_FINAL_CONDICAO4"]    := M_DTA8
   hFields["QUANTIDADE_DE_PRESTACOES"]:= wPrestacoes
   hFields["TEM_GARANTIA"]:= TEMGARANTIA
   hFields["DEBITO_EM_CARTAO_CREDITO"] := M_DEBCC
   hFields['PONTO_DE_REFERENCIA']      := M_refer
   hFields['PONTO_DE_REFERENCIA2']     := M_refer2
   hFields['OBSERVACAO']               := M_obser
   hFields["CPF_VENDEDOR"]             := Ret_Num(wCpfVendedor)
   hFields["CODIGO_ORCAMENTO"]         := Alltrim(Str(wOrcamento))
   hFields["ID"]                       := oOrcamento:PegaUltimoCodigo()
   wIdOrcamento                        := hFields["ID"]

   If TEMSAIDACD  = "S"
      hFields["LOJA_DE_SAIDA"]         := "deposito"
   Else
      hFields["LOJA_DE_SAIDA"]         := "mostruario"
   Endif
 //-> Atualiza Dados no Banco
   Select Orcamentos
   aStruct := Orcamentos->(DbStruct())
   For nCont = 1 to len(aStruct)
      cNomedoCampo := aStruct[nCont,1]
      if hGetPos(hFields,cNomeDoCampo) > 0
         uValor := hFields[cNomedoCampo]
         cFields += cNomeDoCampo + " ,"
         cValues += "?,"
         aadd(aParam,uValor)
      endif
   Next

   cFields:=substr(cFields,1,len(cFields)-1 )
   cValues:=substr(cValues,1,len(cValues)-1 )

   //alert(cFields)
   //alert(cValues)
   //alert(sr_showVector(aParam))

   cInfolog:="Modulo ORCA"+"|"+"Insercao De Orcamentos: "+;
   alltrim(str(wOrcamento))

   //SR_StartLog(SR_GetActiveConnection())
   //SR_StartTrace(SR_GetActiveConnection())

   If !oOrcamento:insert(cFields,cValues,aParam)

      wFasePostgres = "Orcamento Nao Inserido "
      !echo &wFasePostgres  >> /tmp/orca_&wtesteOrcam

      Alert("Erro ao Cadastrar Orcamento no BANCO DE DADOS!;Verifique! ")
      wOrcamento = 0
      oOrcamento:destroi()
      sr_end()
      Return(wOrcamento)
   Else
      wFasePostgres = "Orcamento Inserido Com Sucesso"
      !echo &wFasePostgres  >> /tmp/orca_&wtesteOrcam
      *Alert("Orcamento Inserido")
   Endif

   oOrcamento:destroi()
   sr_end()

 // Itens do Orcamento
   ConfiguraAmbienteDb()           // Abrindo Postgres
   oItens_de_Orcamento:=TItensdeOrcamento():init()
   SELE Itens_de_Orcamentos

   wFasePostgres = "Inicio de Insercao do Itens de Orcamento"
   !echo &wFasePostgres  >> /tmp/orca_&wtesteOrcam

   M_CT = 1
   While M_CT <= Val(m) - 1

     Private cFields:="",cValues:="",aParam:={},hFields:=hash()

    //Itens_de_Orcamentos->Orcamentos_id == val(nOrcamentoId)
     If w_garant[m_ct] > 0
        hFields["VALOR_GARANTIA"]    := w_garant[m_ct]
        hFields["FATOR_GARANTIA"]    := m_grfator[m_ct]
        hFields["PLANO_DA_GARANTIA"] := w_plano[m_ct]
     Else
        hFields["FATOR_GARANTIA"]    := 0
        hFields["PLANO_DE_GARANTIA"] := 0
     Endif
     hFields["ORCAMENTOS_ID"]        := wIdOrcamento
     hFields["PRODUTOS_ID"]          := M_COD[M_CT]
     hFields["QUANTIDADE"]           := M_QTD[M_CT]
     hFields["VALOR_UNITARIO"]       := M_PRE[M_CT]
     hFields["VALOR_DO_DESCONTO"]    := M_DE[M_CT]
     hFields["VALOR_DO_ACRESCIMO"]   := M_AC[M_CT]
     hFields["LOJAS_id"]             := I_FilOrigem
     hFields["LOJA_DE_SAIDA"]        := M_SAID[M_CT]
     hFields["CODIGO_DE_AUTORIZACAO"]:= M_AUTOR[m_ct]
     hFields["NUMERO_DO_ITEM"]       := m_ct
     If M_AUTOR[m_ct] >0
        hFields["VALOR_NA_CIRCULAR"] := M_VRCIRC[m_ct]
     Else
        hFields["VALOR_NA_CIRCULAR"] := 0
     Endif
     hFields["TAXA_DE_ENTREGA"]          := M_TXE[m_ct]
     hFields["TAXA_DE_MONTAGEM"]         := M_TXM[m_ct]
     hFields["QUANTIDADE_PARCELAS_NA_CI"]:= M_Vezesci[m_ct]
     hFields["NUMERO_DA_RESERVA"]        := M_RESERV[m_ct]
     hFields["IMEI"] := M_IMEI[M_CT]

    //aFields := HGetKeys( hFields )
    //aParam := HGetValues( hFields )
    //oCdOrca:Insert(aFields, aParam)

    //-> Atualiza Dados no Banco
    Select Itens_de_Orcamentos
    aStruct := Itens_de_Orcamentos->(DbStruct())
    For nCont = 1 to len(aStruct)
        cNomedoCampo := aStruct[nCont,1]
        if hGetPos(hFields,cNomeDoCampo) > 0
           uValor := hFields[cNomedoCampo]
           cFields += cNomeDoCampo + " ,"
           cValues += "?,"
           aadd(aParam,uValor)
        endif
    Next
    cFields:=substr(cFields,1,len(cFields)-1 )
    cValues:=substr(cValues,1,len(cValues)-1 )

    //alert(cFields)
    //alert(cValues)
    //alert(sr_showVector(aParam))

    cInfolog:="Modulo ORCA"+"|"+"Insercao De Itens_De_Orcamento: "+alltrim(str(wOrcamento))
    *SR_StartLog(SR_GetActiveConnection())
    *SR_StartTrace(SR_GetActiveConnection())

     If !oItens_de_Orcamento:insert(cFields,cValues,aParam)
        Alert("Erro ao Cadastrar Itens_De_Orcamento no BANCO DE DADOS!;Verifique! ")
        wIdOrcamento = 0
        wFasePostgres = "Itens de Orcamento Nao Inserido "
        !echo &wFasePostgres  >> /tmp/orca_&wtesteOrcam
     Else
        wFasePostgres = "Itens de Orcamento Inserido Com Sucesso"
        !echo &wFasePostgres  >> /tmp/orca_&wtesteOrcam
     Endif
     M_Ct++
 Enddo

 oItens_de_Orcamento:destroi()
 RddSetDefault(cRdd)
 sr_end()
Return(wIdOrcamento)

//*******************
  Procedure RetPartic(wCliente,wNomeDBf,wEndeDbf,wNumeDbf,wCompDbf,wCepDbf,wBaiDbf,wCodmDbf,wUfDbf,wCidaDbf,CnpJ_Cpf,wInscDbf,wFoneDbf,wEmailDbf)
//*******************

 wClieDbf = wCliente

 If Len(Alltrim(CnpJ_Cpf)) = 14
    wCpfDbf  = CnpJ_Cpf
    wCnpjDbf = ""
    wPessoa  = "F"
    wBusca_CPF_CNPJ=CnpJ_Cpf
 ElseIf Len(Alltrim(CnpJ_Cpf)) = 18
    wCpfDbf  = ""
    wCnpjDbf = CnpJ_Cpf
    wPessoa  = "J"
    wBusca_CPF_CNPJ= CnpJ_Cpf
 Else
    Stor "" to wCpfDbf,wCnpjDbf,wPessoa,wBusca_CPF_CNPJ
 Endif

 wCpfCnpj = CnpJ_Cpf
 wIdPar = 0

// Consultando e Inserindo Clientes
 If !Empty(wBusca_CPF_CNPJ)    // Busca CPF / Nome Participante
    Stor "" to wVarCep,wVarIbge,wVarInsc
    wIdPar := Busca_Clientes(wBusca_CPF_CNPJ,wNomeDbf,wPessoa,@wVarCep,@wVarIbge,@wVarInsc)
    If wiDPar = 0
       // Inserindo Participante
       wIdPar:=InsertClie(wClieDBf,wNomeDbf,wEndeDbf,wNumeDbf,wCompDbf,wCepDbf,wBaiDbf,wCodmDbf,wUfDbf,wCpfCnpj,wInscDbf,wCidaDbf)
       If wIdPar = 0
          Alert("Error ao Inserir Cliente no Banco !")
          Return
       Else
          If Empty(wVarInsc) .and. !Empty(wInscDbf)
             UpDate_InscPart(wInscDbf,wiDPar)          // Atualiza Participantes antes de faturar
          Endif
          UpDate_CepPart(wCepDbf,wCodmDbf,wiDPar)   // Atualiza Participantes antes de faturar
          wClieDbf = Alltrim(Str(wIdPar))
       Endif
    Else
       // Verificando Insc Estadual do Participante
       If !Empty(wVarInsc) .and. !Empty(wInscDbf)
          wClieDbf = Alltrim(Str(wIdPar))
       Else
          If !Empty(wInscDbf) .and. Empty(wVarInsc)
             UpDate_InscPart(wInscDbf,wiDPar)          // Atualiza Participantes antes de faturar
          Endif
          wClieDbf = Alltrim(Str(wIdPar))
       Endif

       // Verificando CEP e Codigo_IBGE do Participante
       UpDate_CepPart(wCepDbf,wCodmDbf,wiDPar)   // Atualiza Participantes antes de faturar
       wClieDbf = Alltrim(Str(wIdPar))

       // Atualizando Endereco do Participante
       UpDate_EnderecoPart(wEndeDbf,wNumeDbf,wCompDbf,wCepDbf,wBaiDbf,wFoneDbf,wEmailDbf,wIdPar)   // Atualiza Participantes antes de faturar

    Endif
 Endif
Return(wIdPar)

//************************
  Function UpDate_InscPart(wVarInsc,idPart)   // Atualiza Inscricao Estadual do Participantes antes de faturar
//************************
 // Abertura do banco
    cRdd:=RddSetDefault("DBFCDX")
    ConfiguraAmbienteDb()           // Abrindo Postgres

    NCODFUNCIO = 999999
    CINFOLOG   = ""
    // Trecho para da Consulta

    oParticipantes:=TParticipantes():init()
    Select participantes
    Private cFields:="",cValues:="",aParam:={}, hFields:=hash()

    //-> Atualiza Dados no Banco

    cFields = 'inscricao_estadual = ?'

    aadd(aParam,wVarInsc)
    aadd(aParam,IdPart)

    //
    cInfolog:= "Modulo FatoDoo"+"|"+"Atualizacao de Participantes para Faturamento: "+;
            Alltrim(Str(idPart))

    If !oParticipantes:update(cFields,aParam)
        Alert("Erro ao Atualizar Participantes no BANCO DE DADOS!;Verifique! ")
    Endif

    oParticipantes:destroi()
    RddSetDefault(cRdd)
    sr_end()
Return

//***********************
  Function UpDate_CepPart(CepP,Cod_MunicP,idPart)   // Atualiza Participantes antes de faturar
//***********************
 // Abertura do banco
    cRdd:=RddSetDefault("DBFCDX")
    ConfiguraAmbienteDb()           // Abrindo Postgres

    NCODFUNCIO = 999999
    CINFOLOG   = ""
    // Trecho para da Consulta

    oParticipantes:=TParticipantes():init()
    Select participantes
    Private cFields:="",cValues:="",aParam:={}, hFields:=hash()

    //-> Atualiza Dados no Banco

    cFields = 'cep = ?,'
    cFields += 'codigo_ibge = ?'

    CepP:=Ret_Num(CepP)
    aadd(aParam,CepP)
    aadd(aParam,Cod_municP)
    aadd(aParam,IdPart)

    //
    cInfolog:= "Modulo FatoDoo"+"|"+"Atualizacao de Participantes para Faturamento: "+;
            Alltrim(Str(idPart))

    If !oParticipantes:update(cFields,aParam)
        Alert("Erro ao Atualizar Participantes no BANCO DE DADOS!;Verifique! ")
    Endif

    oParticipantes:destroi()
    RddSetDefault(cRdd)
    sr_end()
Return

//***********************
  Function UpDate_EnderecoPart(wEndeDbf,wNumeDbf,wCompDbf,wCepDbf,wBaiDbf,wFoneDbf,wEmailDbf,IdPart)   // Atualiza Participantes antes de faturar
//***********************
 // Abertura do banco
    cRdd:=RddSetDefault("DBFCDX")
    ConfiguraAmbienteDb()           // Abrindo Postgres

    NCODFUNCIO = 999999
    CINFOLOG   = ""
    // Trecho para da Consulta

    oParticipantes:=TParticipantes():init()
    Select participantes
    Private cFields:="",cValues:="",aParam:={}, hFields:=hash()

    //-> Atualiza Dados no Banco

    wCepDbf:=Ret_Num(wCepDbf)
    If Len(wFoneDbf) >10
       wFoneDbf = Substr(wFoneDbf,3,10)
    Endif

    cFields = 'logradouro = ?,'
    cFields += 'numero = ?,'
    cFields += 'complemento = ?,'
    cFields += 'cep = ?,'
    cFields += 'bairro = ?,'
    cFields += 'fone = ?,'
    cFields += 'email = ?'

    aadd(aParam,wEndeDbf)
    aadd(aParam,wNumeDbf)
    aadd(aParam,wCompDbf)
    aadd(aParam,wCepDbf)
    aadd(aParam,wBaiDbf)
    aadd(aParam,wFoneDbf)
    aadd(aParam,wEmailDbf)
    aadd(aParam,IdPart)

    //
    cInfolog:= "Modulo FatoDoo"+"|"+"Atualizacao de Participantes para Faturamento: "+;
            Alltrim(Str(idPart))

    If !oParticipantes:update(cFields,aParam)
        Alert("Erro ao Atualizar Participantes no BANCO DE DADOS!;Verifique! ")
    Endif

    oParticipantes:destroi()
    RddSetDefault(cRdd)
    sr_end()
Return

//***********************
  Function Busca_Clientes(wCpfDbf,wNomeDbf,wPessoa,wVarCep,wVarIbge,wVarInsc)
//***********************
  Local wRet,wEof
  wRet = 0
  // Trecho para da Consulta
  cRdd:=RddSetDefault("DBFCDX")
  ConfiguraAmbienteDb()
  oParticipantes:=TParticipantes():init()

  try
      lRet:=oParticipantes:BuscaParticipanteComoDbf(wCpfDbf,(wPessoa))
  catch oErro
      cHeader1:="==============================================="
      cHeader2:="-ERRO Exportando Participantes do Banco de Dados: "+wCpfDbf

      cError+=oErro:ProcName+"-"+strzero(oErro:ProcLine,6)+";"
      cError+=oErro:Operation+"-"+oErro:SubSystem+";"
      cError+=oErro:ModuleName+"-"+oErro:FileName+";"
      cError+=strzero(oErro:GenCode,3)+"-"
      cError+=oErro:Description
      GravaLogImportacao(cError)
  End
  If cBrowseParticipantes->(Reccount()) <= 0 .or. lRet==.F.
     *cMensagem:="Nao ha registros a exibir!"
     *Alert(cMensagem)
     cBrowseParticipantes->(dbCloseArea())
     oParticipantes:Destroi()
     RddSetDefault(cRdd)
     sr_end()
     Return(wRet)
  Endif
  cBrowseParticipantes->(dbSelectArea())
  cBrowseParticipantes->(dbGoTop())
  RddSetDefault(cRdd)

  //browse()
  //cBrowseParticipantes->(dbCloseArea())
  /*
    If eof()
       Alert("eof")
    Else
       ? nome
       ? cpf
       Alert("ok")
    Endif
  */
  wEof = .f.
  While !Eof()
    If Substr(nome,1,10) = Substr(wNomeDbf,1,10)
       wRet = id
       If !Empty(Cep)
          wVarCep = cep
       Endif
       If !Empty(codigo_ibge)
          wVarIbge = codigo_ibge
       Endif
       If !Empty(inscricao_estadual)
          wVarInsc = inscricao_estadual
       Endif
       wEof = .t.
       Exit
    Endif
    Skip
  Enddo
  If wEof = .F.
     Go Top
     While !Eof()
       If Trim(cpf) = Trim(wCpfDbf)
          wRet = id
          If !Empty(Cep)
             wVarCep = cep
          Endif
          If !Empty(codigo_ibge)
             wVarIbge = codigo_ibge
          Endif
          If !Empty(inscricao_estadual)
             wVarInsc = inscricao_estadual
          Endif
          Exit
       Endif
       Skip
     Enddo
  Endif
  // Fecha o cursor
  cBrowseParticipantes->(dbCloseArea())
  oParticipantes:Destroi()
  RddSetDefault(cRdd)
  sr_end()
Return(wRet)

//*******************
  Function InsertClie(wClieDBf,wNomeDbf,wEndeDbf,wNumeDbf,wCompDbf,wCepDbf,wBaiDbf,wCodmDbf,wUfDbf,wCpf_Cnpj,wInsC,wCidDbf)
//*******************
  wCliente = wClieDBf

  Sele 1
  Set Order to 1
  Seek wCliente
  If !Eof() .and. wCliente > 0 .and. !Empty(CL_NOME)

     M_ENDEX   = wEndeDbf
     M_COMPLE  = wCompDbf
     M_NUMERO  = wNumeDbf
     M_BAICL   = wBaiDbf
     M_CEPCL   = wCepDbf
     M_UFCL    = wUfDbf
     M_CIDACL  = wCidDbf

     CODIX     = CL_CODI
     M_FUNC    = CL_FUNC
     M_DTRN    = CL_DTRN
     DDATX     = CL_DDAT
     NomeCli   = CL_NOME
     FON1X     = CL_FON1
     CPFX      = CL_CPF
     INSCX     = CL_INSC
     TRAB1     = CL_TRAB1
     TRAB2     = CL_TRAB2
     RAMOX     = CL_RAMO
     ANIVX     = CL_ANIV
     M_AVAL    = CL_AVAL
     M_ENDAV   = CL_ENDAV
     M_DOC     = CL_DOC
     M_MAE     = CL_MAE
     M_TEL     = CL_TEL
     M_NASC    = CL_NASCTO
     M_APELIDO = CL_APELIDO
     M_PAI     = CL_PAI
     M_FILI    = CL_FILI
     M_RG      = CL_RG
     M_CIVIL   = CL_CIVIL
     M_CONJU   = CL_CONJU
     M_LOCAL   = CL_LOCALF
     M_LIMI    = CL_LIMI
     M_CGC     = CL_CGC
     M_BLOQ    = CL_BLOQ
     M_BLO1    = CL_BLO1
     M_BLO2    = CL_BLO2
     M_BLO3    = CL_BLO3
     M_BLO4    = CL_BLO4
     M_BLO5    = CL_BLO5
     M_BLO6    = CL_BLO6
     M_LIBCP   = CL_LIBCP
     M_RES1    = CL_RES1
     M_SPC     = CL_SPC
     M_CPFA    = CL_CPFA
     M_LOCE    = CL_LOCE
     M_LOCT    = CL_LOCT
     M_RES2    = CL_RES2
     M_INFOA   = CL_INFOA
     M_INFOA1  = CL_INFOA1
     M_INFOA2  = CL_INFOA2
     M_INFOP1  = CL_INFOP1
     M_INFOP2  = CL_INFOP2
     M_RENDA   = CL_RENDA
     M_SITIO   = CL_SITIO
     M_BENEF   = CL_BENEF
     M_TIPOF   = CL_TIPOF
     M_COMPROV = CL_COMPROV
     M_TIPOZM  = CL_TIPOZM
     M_NATUR   = CL_NATUR
     M_ENDEPA  = CL_ENDEPA
     M_ENDEANT = CL_ENDEANT
     M_DIGITADO= CL_CADA
     M_COB     = CL_COB
     M_BAIAV   = CL_BAIAV
     M_PESQ    = CL_PESQ
     M_TEMPO   = CL_TEMPO     // Variavel Desativada (nomes das radios)
     M_EMAIL   = CL_EMAIL
     M_OI      = CL_OI
     M_TIM     = CL_TIM
     M_CLARO   = CL_CLARO
     M_VIVO    = CL_VIVO
     M_SEXO    = CL_SEXO
     M_MOTCOB  = CL_MOTCOB
     M_IBGE    = CL_IBGE
     OBSERVACJ = OBSERVA
  Else
     Stor "" to M_MOTCOB
     Stor "S" to M_COB
     Stor Space(01)  to M_TIPOZM,M_SEXO
     Stor Space(14)  to M_CPFA
     Stor Space(10)  to M_OI,M_TIM,M_CLARO,M_VIVO
     Stor Space(15)  to M_LIBCP,M_DIGITADO,M_COMPROV
     Stor Space(16)  to M_TEL
     Stor Space(18)  to M_DOC,M_CGC
     Stor Space(26)  to M_RG
     Stor Space(27)  to M_CIVIL,M_RES1,M_RES2,RAMOX,M_SPC
     Stor Space(30)  to FON1X,M_EMAIL,M_NATUR
     Stor Space(31)  to M_APELIDO
     Stor Space(34)  to M_BLO1,M_BLO2,M_BLO3,M_BLO4,M_BLO5,M_BLO6
     Stor Space(40)  to M_AVAL,M_BAIAV,M_CONJU,M_LOCT,M_LOCAL,M_BENEF
     Stor Space(50)  to M_PAI
     Stor Space(60)  to M_ENDAV,M_FILI,M_ENDEPA,M_ENDEANT,M_LOCE,M_INFOA
     Stor Space(80)  to M_INFOA1,M_INFOA2,M_INFOP1,M_INFOP2,M_MAE,TRAB1,TRAB2
     Stor Space(120) to OBSERVACJ
     Stor Space(20)  to M_COMPLE
     Stor Space(10)  to M_NUMERO
     Stor Ctod("  /  /    ") to M_NASC,ANIVX
     Stor M_Datsi to M_DTRN,DDATX
     Stor 0 to M_TIPOF,M_RENDA,M_LIMI,M_PESQ
     Stor "N" to M_FUNC,M_SITIO,M_BLOQ
     Codix   = wCliente
     NomeCli = Trim(wNomeDbf)
     M_Endex = Trim(wEndeDbf)
     M_NUMERO= Trim(wNumeDbf)
     M_COMPLE= Trim(wCompDbf)
     M_CEPCL = Trim(wCepDbf)
     M_BAICL = Trim(wBaiDbf)
     M_IBGE  = Trim(wCodmDbf)
     M_UFCL  = Trim(wUfDbf)
     M_CIDACL= Trim(wCidDbf)
     INSCX   = Trim(wInsC)
   Endif
   If Len(Alltrim(wCpf_Cnpj)) = 14
      CPFX  = wCpf_Cnpj
      Stor Space(18) to M_CGC
   ElseIf Len(Alltrim(wCpf_Cnpj)) = 18
      CPFX  = ""
      M_CGC = wCpf_Cnpj
   Else
      CPFX  = ""
      Stor Space(18) to M_CGC
   Endif
   If Empty(M_CEPCL)
      M_CEPCL = XY_CEP
   Endif
   If Empty(M_CIDACL)
      M_CIDACL = XY_CIDADE
   Endif
   If Empty(M_BAICL)
      M_BAICL = XY_BAIRRO
   Endif
   If Empty(M_UFCL)
      M_UFCL = XY_UF
   Endif
   If Empty(M_IBGE)
      M_IBGE = wCodmDbf
   Endif

  // Abertura do banco
  cRdd:=RddSetDefault("DBFCDX")
  ConfiguraAmbienteDb()           // Abrindo Postgres

  oParticipantes:=TParticipantes():init()
  nCodFuncio:=999999
  Select Participantes

  // Busca no Banco
  If !Empty(CpfX)
     nIdCliente:=oParticipantes:BuscaIdDoCpf(RemoveChar(Cpfx))
  Else
     nIdCliente:=oParticipantes:BuscaIdDoCnpj(RemoveChar(M_Cgc))
  Endif

  If nIdCliente <= 0

    //Atualiza Participante
    Private cFields:="",cValues:="",aParam:={}, hFields:=hash()
    //

    hFields['id'] := oParticipantes:PegaUltimoCodigo()
    nIdCliente    := hFields['id']
    hFields['lojas_id']       := Val(I_FilOrigem)
    hFields['tipo_de_pessoa'] := iif(!empty(CpfX),[F],[J])
    hFields['nome'] := Padr(alltrim(NomeCli),50," ")
    hFields['nome_completo']  := Padr(alltrim(NomeCli),50," ")
    hFields['sexo']           := M_SEXO
    hFields['cnpj']           := RemoveChar(M_CGC)
    hFields['cpf']            := RemoveChar(CPFX)
    hFields['rg']             := left(M_RG,20)
    hFields['nome_do_pai']    := left(RemoveChar(alltrim(M_PAI)),50)
    hFields['nome_da_mae']    := left(RemoveChar(alltrim(M_FILI)),50)
    If M_Sitio = "N"
       hFields['tipo_de_logradouro_tipo'] := 35
    Else
       hFields['tipo_de_logradouro_tipo'] := 37
    Endif
    hFields['logradouro']          := left(alltrim(M_ENDEX),40)
    If Empty(M_NUMERO)
       M_NUMERO = "SN"
    Endif
    hFields['numero']              := left(M_NUMERO,10)
    hFields['tipo_de_bairro_tipo'] := 1
    hFields['bairro']              := padr(alltrim(M_BAICL),30," ")
    hFields['complemento']         := left(M_COMPLE,50)
    hFields['codigo_ibge']         := M_IBGE
    hFields['cep'] := RemoveChar(M_CEPCL)
    hFields['ponto_de_referencia'] := left(alltrim(M_LOCE),30)
    hFields['ddd'] :=;
        padr(subst(RemoveChar(FON1X),1,2),3," ")
    hFields['fone']  := FormataFoneDbf(FON1X)
    hFields['email'] := left(M_EMAIL,60)
    hFields['codigo_ibge_entrega']  := M_IBGE
    hFields['data_de_cadastro']     := DDATX
    hFields['data_de_nascimento']   := ANIVX
    hFields['desativado']           := M_BLOQ
    hFields['codigo_anterior']      := CODIX                       //Codigo Dbf
    hFields['informacoes_pessoais'] := alltrim(M_INFOP1)+"|"+;
        alltrim(M_InfoP2)
    hFields['informacoes_comerciais']:= alltrim(TRAB1)+"|"+;
        alltrim(TRAB2)
    hFields['renda'] := M_LIMI
    hFields['naturalidade']       := left(M_NATUR,30)
    hFields['e_funcionario']      := iif(M_FUNC = "S",[T],[F])
    hFields['atualizacao_de_cadastro'] := dataToDatetime()
    hFields['funcionario_cadastro']    := nCodFuncio
    hFields['inscricao_estadual']      := left(INSCX,20)
    hFields['funcionario_atualizacao'] := nCodFuncio
    hFields['apelido'] := M_APELIDO
    hFields['estado_civil']    := left(M_CIVIL,15)
    hFields['nome_do_conjuge'] := left(M_CONJU,60)
    hFields['informacoes_conjuge'] := alltrim(OBSERVACJ)
        hFields['ddd_oi'] :=;
        padr(subst(RemoveChar(M_OI),1,2),3," ")
    hFields['celular_oi'] :=;
        padr(subst(RemoveChar(M_OI),3,10),10," ")
    hFields['ddd_tim'] :=;
        padr(subst(RemoveChar(M_TIM),1,2),3," ")
    hFields['celular_tim'] :=;
        padr(subst(RemoveChar(M_TIM),3,10),10," ")
    hFields['ddd_claro'] :=;
        padr(subst(RemoveChar(M_CLARO),1,2),3," ")
    hFields['celular_claro'] :=;
        padr(subst(RemoveChar(M_CLARO),3,10),10," ")
    hFields['ddd_vivo'] :=;
        padr(subst(RemoveChar(M_VIVO),1,2),3," ")
    hFields['celular_vivo'] :=;
        padr(subst(RemoveChar(M_VIVO),3,10),10," ")
    hFields['local_de_trabalho']   := alltrim(M_LOCAL)
    hFields['residencia_propria']  := left(alltrim(M_RES1),30)
    hFields['informacao_spc']      := left(alltrim(M_SPC),30)
    hFields['numero_do_beneficio'] := left(alltrim(M_BENEF),30)
    hFields['digitado_por']        := left(alltrim(M_DIGITADO),15)
    hFields['endereco_dos_pais']   := left(alltrim(M_ENDEPA),60)
    hFields['endereco_anterior']   := left(alltrim(M_ENDEANT),60)
    hFields['tipo_de_cliente']     := alltrim(M_TIPOZM)
    hFields['pesquisa_cliente']    := alltrim(Str(M_PESQ))
    hFields['informacoes_do_avalista'] := alltrim(M_INFOA1)+"|"+;
        alltrim(M_InfoA2)
    hFields['carta_de_cobranca']   := alltrim(M_COB)
    hFields['motivo_da_cobranca']  := left(M_MOTCOB,30)
    hFields['profissao']           := M_TIPOF
    hFields['cargo_funcao']        := alltrim(RAMOX)
        // Modificado hFields['e_funcionario'] := M_FUNC

    //-> Atualiza Dados no Banco
    Select Participantes
    aStruct := Participantes->(DbStruct())
    For nCont = 1 to len(aStruct)
        cNomedoCampo := lower(aStruct[nCont,1])
        if hGetPos(hFields,cNomeDoCampo) > 0
            uValor := hFields[cNomedoCampo]
            cFields += cNomeDoCampo + " ,"
            cValues += "?,"
            aadd(aParam,uValor)
        endif
    Next
    cFields:=substr(cFields,1,len(cFields)-1 )
    cValues:=substr(cValues,1,len(cValues)-1 )

    /*
     alert(cFields)
     alert(cValues)
     alert(sr_showVector(aParam))
    */

    //
    cInfolog:="Modulo CREDI"+"|"+"Insercao De CLiente: "+;
            alltrim(str(nIdCliente))

    //SR_StartLog(SR_GetActiveConnection())
    //SR_StartTrace(SR_GetActiveConnection())

    If !oParticipantes:insert(cFields,cValues,aParam)
        Alert("Erro ao Cadastrar Cliente no BANCO DE DADOS!;Verifique! ")
    Endif
  endif

  oParticipantes:destroi()
  RddSetDefault(cRdd)
  sr_end()
Return(nIdCliente)

//*******************
  Procedure VerificaProdutos(wOrcamento)
//*******************

  wtesteOrcam = alltrim(str(wOrcamento))
  wFasePostgres = "Verificando Se Existe Produtos no 9.2"
  !echo &wFasePostgres  >> /tmp/orca_&wtesteOrcam

 Sele 25
 Set Order to 1
 Seek STR(wOrcamento,8,0)+SUBSTR(DTOC(M_DATSI),7,4)+SUBSTR(DTOC(M_DATSI),4,2)+SUBSTR(DTOC(M_DATSI),1,2)
 While !Eof() .and. CD_CODIOR = wOrcamento .and. CD_DATAO = M_DATSI
   wProdID = cd_codi

   Sele 3
   Set Order to 1
   Seek wProdID

   wCodForn = Alltrim(Str(cd_forn))
   wOrgID   = cd_Origem      // Origem DBF
   wOrgDb   = ""             // Origem do Banco
   wncmID   = cd_ncm         // NCM DBF
   wncmDb   = ""             // NCM do Banco
   wCestID  = cd_cest        // Cest DBF
   wCestDb  = ""             // Cest do Banco
   wSubGID  = cd_SBGrup      // SubGrupo DBF
   wSubGDb  = ""             // SubGrupo do Banco
   wGrupprd = cd_Grup        // Grupo de Produtos
   If Empty(cd_ean)
      wEanID  = "SEM GTIN"  // GTIN
   Else
      wEanID  = cd_ean
   Endif
   wEanDb  = ""             // GTIN do Banco
   wDescFID= Trim(cd_prodf) // Descricao Fiscal
   wDescFDb= ""             // Descricao Fiscal do Banco

   wStatus = .f.
   ConsultaSUBG(wSubGID,@wStatus)  // Pesquisa de SubGrupos
   If wStatus = .f.
      InsereSubGrupo(wSubGID,wGrupprd)
   Endif

   wStatus:=ConsultaProd(wProdID,@wCestDb,@wOrgDb,@wncmDb,@wSubGDb,@wEanDb,@wDescFDb,@wStatus)  // Pesquisa de Produtos
   If wStatus = .f.
     //Consultando e Inserindo Fornecedores em Tabela de Participantes antes de Inserir Produtos
       Sele 2
       Set Order to 1
       Seek Val(wCodForn)
       wNomeFor = Fn_nome
       wEndeFor = Fn_ende
       wNumFor  = Ret_Num(Fn_Ende)
       wInsc    = Ret_Num(fn_ie)
       wCompFor = ""
       wBaiFor  = Fn_bair
       If Empty(Fn_bair)
          wBaiFor = xy_bairro
       Endif
       wCidaFor = Fn_Cida
       If Empty(Fn_Cida)
          wCidaFor = xy_cidade
       Endif
       wCepFor  = Fn_Cep
       If Empty(Fn_Cep)
          wCepFor = xy_cep
       Endif
       wCodmFor = Fn_IBge
       If Empty(Fn_IBge)
          wCodmFor = xy_ibge
       Endif
       wUfFor  = Fn_UF
       If Empty(Fn_UF)
          wUfFor = xy_uf
       Endif
       wCpfCnpjFor = fn_cgc
       If Empty(fn_cgc)
          Alert("CNPJ do Fornecedor Vazio, Fornecedor: "+wCodForn)
          M_NT = ""
          Return(M_NT)
       Endif
       wRetClie:=Busca_Nomes(fn_cgc,Trim(fn_nome),"J",fn_cep,fn_ibge,wInsc)  // Participangtes
       If wRetClie = 0
          wRetClie:=InsertFor(wCodForn,wNomeFor,wEndeFor,wNumFor,wCompFor,wCepFor,wBaiFor,wCodmFor,wUfFor,wCpfCnpjFor,wInsc,wCidaFor)
          If wRetClie = 0
             Alert("Error ao Inserir Fornecedor no Banco de Participantes !")
             Return
          Endif
      Endif

      wFasePostgres = "Iniciando Insercao de Produtos no 9.2"
      !echo &wFasePostgres  >> /tmp/orca_&wtesteOrcam

      wInsert:=InsereProduto(wProdID,wRetClie)
      If wInsert = .f.
         wFasePostgres = "Falha ao Inserir Produtos no 9.2"
         !echo &wFasePostgres  >> /tmp/orca_&wtesteOrcam
         Return
      Else
         wFasePostgres = "Produto Inserido Com Sucesso no 9.2"
        !echo &wFasePostgres  >> /tmp/orca_&wtesteOrcam
      Endif
   Endif
   Sele 25
   Set Order to 1
   Skip
 Enddo
 Release wProdID,wCestID,wCestDb,wStatus,wSubGID,wSubGDb,wGrupprd
Return

//***********************
  Function InsereProduto(nProduto,wIdFabricante)
//***********************
  Local nArea:=select() //,;
  Local aStruct,cNomedoCampo,uValor,nRecno,lErro:=.f.,wRet:=.f.
  Local cFields:="",cValues:="",aParam:={}, hProduto:=hash()
  cNomeUsuario = ""
  cRdd:=RddSetDefault("DBFCDX")
  nCodFuncio:=999999

  ConfiguraAmbienteDb()
  oProdutos:=TProdutos():init()

  Sele 3
  Set Order to 1
  Seek nProduto
  If found()
    //
        hProduto['id'] := CD_CODI
        hProduto['codigo_dbf'] := CD_CODI
        hProduto['lojas_id'] := Val(I_FilOrigem)
        hProduto['descricao'] := CD_PROD
        hProduto['descricao_fiscal'] := CD_PRODF
        hProduto['unidade_de_medida_id'] := 8
        hProduto['cor'] := CD_COR
        hProduto['subgrupo_de_produtos_id'] := CD_SBGRUP
        hProduto['ncm'] := CD_NCM
        hProduto['codigo_de_barras'] := CD_EAN
        hProduto['fabricante'] := wIdFabricante
        hProduto['marca_referencia'] := CD_FABR
        hProduto['valor_da_guelta'] := CD_GUELTA
        hProduto['valor_da_montagem'] := CD_MONTAG
        hProduto['perfil'] := CD_PERFIL
        hProduto['tabela_de_precos'] :=CD_TABELA
        hProduto['codigo_origem'] :=CD_ORIGEM
        hProduto['observacoes'] := CD_OBS
        hProduto['modelo'] := CD_MODELO
        hProduto['valor_a_vista'] := CD_AVISTA2
        hProduto['valor_promocional'] := CD_VRPROMO
        hProduto['preco_de_custo'] := CD_CUST
        hProduto['preco_custo_anterior'] := CD_CUSTA
        hProduto['estoque_minimo'] := CD_MINI
        hProduto['estoque_maximo'] := CD_MAXI
        hProduto['cest'] := CD_CEST
        hProduto['codigo_do_ac_fiscal'] := CD_CODI
        hProduto['indice'] := "0"
        hProduto['percentual_reducao'] := CD_ALIQ
        hProduto['reservado'] := CD_RESERVA
        hProduto['fora_de_linha'] := CD_FL
        hProduto['fora_de_linha'] := iif(CD_FL = "FL",[S],[N])
        hProduto['faixa_de_precos'] := CD_FaixaP
        hProduto['funcionarios_id'] := nCodFuncio
        hProduto['data_do_cadastro'] := CD_ENTR
        hProduto['data_ultima_alteracao'] := CD_ENTR
        hProduto['situacao_tributaria_do_icms_tipo'] := "0"
        hProduto['situacao_tributaria_do_ipi_tipo'] := "0"
        hProduto['situacao_tributaria_pis_cofins_tipo'] := 1
        hProduto['garantia'] := CD_GR
        hProduto['fci'] := CD_FCI
        hProduto['peso_liquido'] := CD_PESO

        //-> Insere Dados no Banco
        Select Produtos
        aStruct := Produtos->(DbStruct())
        For nCont = 1 to len(aStruct)
            cNomedoCampo := lower(aStruct[nCont,1])
                if hGetPos(hProduto,cNomeDoCampo) > 0
                    uValor := hProduto[cNomedoCampo]
                else
                    uValor:=Nil
                endif
                cFields += cNomeDoCampo + ","
                cValues += "?,"
                aadd(aParam,uValor)
        Next
        cFields:=substr(cFields,1,len(cFields)-1 )
        cValues:=substr(cValues,1,len(cValues)-1 )
        //
        cInfolog:=alltrim(cNomeUsuario)+"|"+"Importacao de Produto: "+;
                alltrim(str(codigo_dbf))
        if !oProdutos:insert(cFields,cValues,aParam)
            alert("Erro ao Importar Produto do Dbf do Erp Anterior!;Verifique! ")
            wRet := .f.
        else
            wRet := .t.
        endif
    endif
    oProdutos:Destroi()
    RddSetDefault(cRdd)
    sr_end()
Return(wRet)

//********************
  Function Busca_Nomes(wCpfDbf,wNomeDbf,wPessoa,wVarCep,wVarIbge,wVarInsc)
//********************
  Local wRet,wEof
  wRet = 0
  // Trecho para da Consulta
  cRdd:=RddSetDefault("DBFCDX")
  ConfiguraAmbienteDb()
  oParticipantes:=TParticipantes():init()

  try
      lRet:=oParticipantes:BuscaParticipanteComoDbf(wCpfDbf,(wPessoa))
  catch oErro
      cHeader1:="==============================================="
      cHeader2:="-ERRO Exportando Participantes do Banco de Dados: "+wCpfDbf

      cError+=oErro:ProcName+"-"+strzero(oErro:ProcLine,6)+";"
      cError+=oErro:Operation+"-"+oErro:SubSystem+";"
      cError+=oErro:ModuleName+"-"+oErro:FileName+";"
      cError+=strzero(oErro:GenCode,3)+"-"
      cError+=oErro:Description
      GravaLogImportacao(cError)
  End
  If cBrowseParticipantes->(Reccount()) <= 0 .or. lRet==.F.
     *cMensagem:="Nao ha registros a exibir!"
     *Alert(cMensagem)
     cBrowseParticipantes->(dbCloseArea())
     oParticipantes:Destroi()
     RddSetDefault(cRdd)
     sr_end()
     Return(wRet)
  Endif
  cBrowseParticipantes->(dbSelectArea())
  cBrowseParticipantes->(dbGoTop())
  RddSetDefault(cRdd)

  //browse()
  //cBrowseParticipantes->(dbCloseArea())
  /*
    If eof()
       Alert("eof")
    Else
       ? nome
       ? cpf
       Alert("ok")
    Endif
  */
  wEof = .f.
  While !Eof()
    If Substr(nome,1,10) = Substr(wNomeDbf,1,10)
       wRet = id
       If !Empty(Cep)
          wVarCep = cep
       Endif
       If !Empty(codigo_ibge)
          wVarIbge = codigo_ibge
       Endif
       If !Empty(inscricao_estadual)
          wVarInsc = inscricao_estadual
       Endif
       wEof = .t.
       Exit
    Endif
    Skip
  Enddo
  If wEof = .F.
     Go Top
     While !Eof()
       If Trim(cpf) = Trim(wCpfDbf)
          wRet = id
          If !Empty(Cep)
             wVarCep = cep
          Endif
          If !Empty(codigo_ibge)
             wVarIbge = codigo_ibge
          Endif
          If !Empty(inscricao_estadual)
             wVarInsc = inscricao_estadual
          Endif
          Exit
       Endif
       Skip
     Enddo
  Endif
  // Fecha o cursor
  cBrowseParticipantes->(dbCloseArea())
  oParticipantes:Destroi()
  RddSetDefault(cRdd)
  sr_end()
Return(wRet)


//******************
  Function ConsultaProd(wCodProd,wCestDB,wOrgDB,wncmDb,wSubGDb,wEanDB,wDescFDb,wStatus)  // Pesquisa de Produtos
//******************
  // Abertura do banco
  cRdd:=RddSetDefault("DBFCDX")
  ConfiguraAmbienteDb()           // Abrindo Postgres

  oProdutos:=TProdutos():init()
  Select Produtos
  Private cFields:="",cValues:="",aParam:={}, hFields:=hash()
  If oProdutos:search(wCodProd)
     wCestDB := oProdutos:GETVAL("cest")
     wOrgDB  := oProdutos:GETVAL("codigo_origem")
     wncmDb  := oProdutos:GETVAL("ncm")
     wSubGDb := oProdutos:GETVAL("subgrupo_de_produtos_id")
     wEanDb  := oProdutos:GETVAL("codigo_de_barras")
     wDescFDb:= oProdutos:GETVAL("descricao_fiscal")
     wStatus :=  .t.
  Else
     wOrgDB  := ""
     wCestDB := ""
     wncmDb  := ""
     wSubGDb := ""
     wEanDb  := ""
     wDescFDb:= ""
     wStatus := .f.
  Endif
  oProdutos:destroi()
  RddSetDefault(cRdd)
  sr_end()
Return(wStatus)

//******************
  Function ConsultaSUBG(wSubGDb,wStatus)  // Pesquisa de SubGrupos
//******************
  // Abertura do banco
  cRdd:=RddSetDefault("DBFCDX")
  ConfiguraAmbienteDb()           // Abrindo Postgres

  oSubgrupos:=TSubgrupodeProdutos():init()

  Select Subgrupo_de_produtos
  Private cFields:="",cValues:="",aParam:={}, hFields:=hash()
  If oSubgrupos:search(wSubGDb)
     wSubGDb := oSubgrupos:GETVAL("id")
     wStatus :=  .t.
  Else
     wSubGDb  := 0
     wStatus := .f.
  Endif
  oSubgrupos:destroi()
  RddSetDefault(cRdd)
  sr_end()
Return

//***********************
  Function InsereSubGrupo(nSubGrupo,nGrupprd)
//***********************
  Local nArea:=select() //,;
  Local aStruct,cNomedoCampo,uValor,nRecno,lErro:=.f.,wRet:=.f.
  Local cFields:="",cValues:="",aParam:={}, hProduto:=hash()
  cNomeUsuario = ""
  cRdd:=RddSetDefault("DBFCDX")
  nCodFuncio:=999999

  ConfiguraAmbienteDb()
  oSubgrupos:=TSubgrupodeProdutos():init()

  Sele 43
  Set Order to 1
  Seek nSubGrupo
  If found()
    //
        hProduto['id']                   := GR_CODI
        hProduto['grupo_de_produtos_id'] := nGrupprd
        hProduto['descricao']            := GR_NOME
        hProduto['comissao_do_subgrupo'] := GR_COMI

        //-> Insere Dados no Banco
        Select Subgrupo_de_produtos
        aStruct := Subgrupo_de_produtos->(DbStruct())
        For nCont = 1 to len(aStruct)
            cNomedoCampo := lower(aStruct[nCont,1])
                if hGetPos(hProduto,cNomeDoCampo) > 0
                    uValor := hProduto[cNomedoCampo]
                else
                    uValor:=Nil
                endif
                cFields += cNomeDoCampo + ","
                cValues += "?,"
                aadd(aParam,uValor)
        Next
        cFields:=substr(cFields,1,len(cFields)-1 )
        cValues:=substr(cValues,1,len(cValues)-1 )
        //
        cInfolog:=alltrim(cNomeUsuario)+"|"+"Importacao de SubGrupos: "+;
                alltrim(str(nSubGrupo))
        if !oSubgrupos:insert(cFields,cValues,aParam)
            alert("Erro ao Importar SubGrupo do Dbf do Erp Anterior!;Verifique! ")
            wRet := .f.
        else
            wRet := .t.
        endif
    endif
    oSubgrupos:Destroi()
    RddSetDefault(cRdd)
    sr_end()
Return(wRet)

//*******************
  Function InsertFor(wClieDBf,wNomeDbf,wEndeDbf,wNumeDbf,wCompDbf,wCepDbf,wBaiDbf,wCodmDbf,wUfDbf,wCnpj,wInsC,wCidDbf)
//*******************
  // Abertura do banco
  cRdd:=RddSetDefault("DBFCDX")
  ConfiguraAmbienteDb()           // Abrindo Postgres

  oParticipantes:=TParticipantes():init()
  nCodFuncio:=999999
  Select Participantes

  nIdCliente:=oParticipantes:BuscaIdDoCnpj(RemoveChar(wCnpj))
  If nIdCliente <= 0
     Stor "" to M_MOTCOB
     Stor "S" to M_COB
     Stor Space(01)  to M_TIPOZM,M_SEXO
     Stor Space(14)  to M_CPFA
     Stor Space(10)  to M_OI,M_TIM,M_CLARO,M_VIVO
     Stor Space(15)  to M_LIBCP,M_DIGITADO,M_COMPROV
     Stor Space(16)  to M_TEL
     Stor Space(18)  to M_DOC,M_CGC
     Stor Space(26)  to M_RG
     Stor Space(27)  to M_CIVIL,M_RES1,M_RES2,RAMOX,M_SPC
     Stor Space(30)  to FON1X,M_EMAIL,M_NATUR
     Stor Space(31)  to M_APELIDO
     Stor Space(34)  to M_BLO1,M_BLO2,M_BLO3,M_BLO4,M_BLO5,M_BLO6
     Stor Space(40)  to M_AVAL,M_BAIAV,M_CONJU,M_LOCT,M_LOCAL,M_BENEF
     Stor Space(50)  to M_PAI
     Stor Space(60)  to M_ENDAV,M_FILI,M_ENDEPA,M_ENDEANT,M_LOCE,M_INFOA
     Stor Space(80)  to M_INFOA1,M_INFOA2,M_INFOP1,M_INFOP2,M_MAE,TRAB1,TRAB2
     Stor Space(120) to OBSERVACJ
     Stor Space(20)  to M_COMPLE
     Stor Space(10)  to M_NUMERO
     Stor Ctod("  /  /    ") to M_NASC,ANIVX
     Stor M_Datsi to M_DTRN,DDATX
     Stor 0 to M_TIPOF,M_RENDA,M_LIMI,M_PESQ
     Stor "N" to M_FUNC,M_SITIO,M_BLOQ
     wCliente = Val(wClieDBf)

     NomeCli = Trim(wNomeDbf)
     Endex   = Trim(wEndeDbf)
     M_NUMERO= Trim(wNumeDbf)
     M_COMPLE= Trim(wCompDbf)
     M_CEPCL = Trim(wCepDbf)
     M_BAICL = Trim(wBaiDbf)
     M_IBGE  = Trim(wCodmDbf)
     M_UFCL  = Trim(wUfDbf)
     M_CIDACL= Trim(wCidDbf)
     M_CGC   = Trim(wCnpj)
     INSCX   = Trim(wInsC)
     CPFX    = ""
     If Empty(M_CEPCL)
        M_CEPCL = XY_CEP
     Endif
     If Empty(M_CIDACL)
        M_CIDACL = XY_CIDADE
     Endif
     If Empty(M_BAICL)
        M_BAICL = XY_BAIRRO
     Endif
     If Empty(M_UFCL)
        M_UFCL = XY_UF
     Endif
     If Empty(M_IBGE)
        M_IBGE = wCodmDbf
      Endif

    //Atualiza Participante
    Private cFields:="",cValues:="",aParam:={}, hFields:=hash()
    //

    hFields['id'] := oParticipantes:PegaUltimoCodigo()
    nIdCliente    := hFields['id']
    hFields['lojas_id']       := Val(I_FilOrigem)
    hFields['tipo_de_pessoa'] := iif(!empty(CpfX),[F],[J])
    hFields['nome'] := Padr(alltrim(NomeCli),50," ")
    hFields['nome_completo']  := Padr(alltrim(NomeCli),50," ")
    hFields['sexo']           := M_SEXO
    hFields['cnpj']           := RemoveChar(M_CGC)
    hFields['cpf']            := RemoveChar(CPFX)
    hFields['rg']             := left(M_RG,20)
    hFields['nome_do_pai']    := left(RemoveChar(alltrim(M_PAI)),50)
    hFields['nome_da_mae']    := left(RemoveChar(alltrim(M_FILI)),50)
    If M_Sitio = "N"
       hFields['tipo_de_logradouro_tipo'] := 35
    Else
       hFields['tipo_de_logradouro_tipo'] := 37
    Endif
    hFields['logradouro']          := left(alltrim(ENDEX),40)
    hFields['numero']              := left(M_NUMERO,10)
    hFields['tipo_de_bairro_tipo'] := 1
    hFields['bairro']              := padr(alltrim(M_BAICL),30," ")
    hFields['complemento']         := left(M_COMPLE,50)
    hFields['codigo_ibge']         := M_IBGE
    hFields['cep'] := RemoveChar(M_CEPCL)
    hFields['ponto_de_referencia'] := left(alltrim(M_LOCE),30)
    hFields['ddd'] :=;
        padr(subst(RemoveChar(FON1X),1,2),3," ")
    hFields['fone']  := FormataFoneDbf(FON1X)
    hFields['email'] := left(M_EMAIL,60)
    hFields['codigo_ibge_entrega']  := M_IBGE
    hFields['data_de_cadastro']     := DDATX
    hFields['data_de_nascimento']   := ANIVX
    hFields['desativado']           := M_BLOQ
    hFields['codigo_anterior']      := wCliente                       //Codigo Dbf
    hFields['informacoes_pessoais'] := alltrim(M_INFOP1)+"|"+;
        alltrim(M_InfoP2)
    hFields['informacoes_comerciais']:= alltrim(TRAB1)+"|"+;
        alltrim(TRAB2)
    hFields['renda'] := M_LIMI
    hFields['naturalidade']       := left(M_NATUR,30)
    hFields['e_funcionario']      := iif(M_FUNC = "S",[T],[F])
    hFields['atualizacao_de_cadastro'] := dataToDatetime()
    hFields['funcionario_cadastro']    := nCodFuncio
    hFields['inscricao_estadual']      := left(INSCX,20)
    hFields['funcionario_atualizacao'] := nCodFuncio
    hFields['apelido'] := M_APELIDO
    hFields['estado_civil']    := left(M_CIVIL,15)
    hFields['nome_do_conjuge'] := left(M_CONJU,60)
    hFields['informacoes_conjuge'] := alltrim(OBSERVACJ)
        hFields['ddd_oi'] :=;
        padr(subst(RemoveChar(M_OI),1,2),3," ")
    hFields['celular_oi'] :=;
        padr(subst(RemoveChar(M_OI),3,10),10," ")
    hFields['ddd_tim'] :=;
        padr(subst(RemoveChar(M_TIM),1,2),3," ")
    hFields['celular_tim'] :=;
        padr(subst(RemoveChar(M_TIM),3,10),10," ")
    hFields['ddd_claro'] :=;
        padr(subst(RemoveChar(M_CLARO),1,2),3," ")
    hFields['celular_claro'] :=;
        padr(subst(RemoveChar(M_CLARO),3,10),10," ")
    hFields['ddd_vivo'] :=;
        padr(subst(RemoveChar(M_VIVO),1,2),3," ")
    hFields['celular_vivo'] :=;
        padr(subst(RemoveChar(M_VIVO),3,10),10," ")
    hFields['local_de_trabalho']   := alltrim(M_LOCAL)
    hFields['residencia_propria']  := left(alltrim(M_RES1),30)
    hFields['informacao_spc']      := left(alltrim(M_SPC),30)
    hFields['numero_do_beneficio'] := left(alltrim(M_BENEF),30)
    hFields['digitado_por']        := left(alltrim(M_DIGITADO),15)
    hFields['endereco_dos_pais']   := left(alltrim(M_ENDEPA),60)
    hFields['endereco_anterior']   := left(alltrim(M_ENDEANT),60)
    hFields['tipo_de_cliente']     := alltrim(M_TIPOZM)
    hFields['pesquisa_cliente']    := alltrim(Str(M_PESQ))
    hFields['informacoes_do_avalista'] := alltrim(M_INFOA1)+"|"+;
        alltrim(M_InfoA2)
    hFields['carta_de_cobranca']   := alltrim(M_COB)
    hFields['motivo_da_cobranca']  := left(M_MOTCOB,30)
    hFields['profissao']           := M_TIPOF
    hFields['cargo_funcao']        := alltrim(RAMOX)
        // Modificado hFields['e_funcionario'] := M_FUNC

    //-> Atualiza Dados no Banco
    Select Participantes
    aStruct := Participantes->(DbStruct())
    For nCont = 1 to len(aStruct)
        cNomedoCampo := lower(aStruct[nCont,1])
        if hGetPos(hFields,cNomeDoCampo) > 0
            uValor := hFields[cNomedoCampo]
            cFields += cNomeDoCampo + " ,"
            cValues += "?,"
            aadd(aParam,uValor)
        endif
    Next
    cFields:=substr(cFields,1,len(cFields)-1 )
    cValues:=substr(cValues,1,len(cValues)-1 )

    /*
     alert(cFields)
     alert(cValues)
     alert(sr_showVector(aParam))
    */

    //
    cInfolog:="Modulo CREDI"+"|"+"Insercao De CLiente: "+;
            alltrim(str(nIdCliente))

    //SR_StartLog(SR_GetActiveConnection())
    //SR_StartTrace(SR_GetActiveConnection())

    If !oParticipantes:insert(cFields,cValues,aParam)
        Alert("Erro ao Cadastrar Cliente no BANCO DE DADOS!;Verifique! ")
    Endif
  endif

  oParticipantes:destroi()
  RddSetDefault(cRdd)
  sr_end()
Return(nIdCliente)

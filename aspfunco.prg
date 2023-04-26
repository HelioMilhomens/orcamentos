#include "inkey.ch"
#include "box.ch"
#include "migracao.ch"


**-----------------------------------------------------------------**
Function MOVEBOX(LINU_, COLL_, LIND_, COLR_) && Movimentar uma janela
**-----------------------------------------------------------------**
Local TELA_, RODAPE_, LIN_, COL_, BLOCOESC_
Private LIN1_, COL1_, LIN2_, COL2_

LIN1_ := LINU_
COL1_ := COLL_
LIN2_ := LIND_
COL2_ := COLR_

TELA_   := savescreen(0, 0, 23, 79)
RODAPE_ := savescreen(24, 0, 24, 79)
LIN_    := row()
COL_    := col()

@ 24,0 say " <ESC>                   º <CTRL>  -             º <SHIFT>  -             "

setkey(K_CTRL_RIGHT,{|| co_right()})
setkey(K_CTRL_LEFT, {|| co_left()})
setkey(K_CTRL_UP,   {|| co_up()})
setkey(K_CTRL_DOWN, {|| co_down()})

setkey(K_SHIFT_RIGHT,{|| ex_right()})
setkey(K_SHIFT_LEFT, {|| ex_left()})
setkey(K_SHIFT_UP,   {|| ex_up()})
setkey(K_SHIFT_DOWN, {|| ex_down()})

setkey(K_RIGHT,{|| ex_right()})
setkey(K_LEFT, {|| ex_left()})
setkey(K_UP,   {|| ex_up()})
setkey(K_DOWN, {|| ex_down()})

BLOCOESC_ = setkey(K_ESC,{})
do while .t.
   @ LIN1_, COL1_, LIN2_, COL2_ box "ÜÜÜÞßßßÝ"
   @ 0,79
   wait ""
   if lastkey() = K_ESC
      exit
   endif
   restscreen(TELA_)
enddo
setkey(K_ESC,BLOCOESC_)
@ LIN_, COL_
restscreen(TELA_)
restscreen(RODAPE_)

setkey(K_CTRL_RIGHT,{})
setkey(K_CTRL_LEFT,{})
setkey(K_CTRL_UP,{})
setkey(K_CTRL_DOWN,{})

setkey(K_SHIFT_RIGHT,{})
setkey(K_SHIFT_LEFT,{})
setkey(K_SHIFT_UP,{})
setkey(K_SHIFT_DOWN,{})

setkey(K_RIGHT,{})
setkey(K_LEFT,{})
setkey(K_UP,{})
setkey(K_DOWN,{})

LINU_ := LIN1_
COLL_ := COL1_
LIND_ := LIN2_
COLR_ := COL2_
release LIN1_, COL1_, LIN2_ , COL2_
return (NIL)

**-------------------------------------------**
Function co_right()   && Contrai para a direita
**-------------------------------------------**
memvar COL1_

if COL1_ < 78
   COL1_ = COL1_ + 1
endif
keyboard chr(K_ENTER)
return (NIL)

**-------------------------------------------**
Function co_left()   && Contrai para a esquerda
**-------------------------------------------**
memvar COL2_

if COL2_ > 1
   COL2_ = COL2_ - 1
endif
keyboard chr(K_ENTER)
return (NIL)

**---------------------------------------**
Function co_up()       && Contrai para cima
**---------------------------------------**
memvar LIN2_

if LIN2_ > 1
   LIN2_ = LIN2_ - 1
endif
keyboard chr(K_ENTER)
return (NIL)

**-----------------------------------------**
Function co_down()      && Contrai para baixo
**-----------------------------------------**
memvar LIN1_

if LIN1_ < 22
   LIN1_ = LIN1_ + 1
endif
keyboard chr(K_ENTER)
return (NIL)

**-------------------------------------------**
Function ex_right()   && Expande para a direita
**-------------------------------------------**
memvar COL2_

if COL2_ < 79
   COL2_ = COL2_ + 1
endif
keyboard chr(K_ENTER)
return (NIL)

**--------------------------------------------**
Function ex_left()    && Expande para a esquerda
**--------------------------------------------**
memvar COL1_

if COL1_ > 0
   COL1_ = COL1_ - 1
endif
keyboard chr(K_ENTER)
return (NIL)

**-------------------------------------------**
Function ex_up()           && Expande para cima
**-------------------------------------------**
memvar LIN1_

if LIN1_ > 0
   LIN1_ = LIN1_ - 1
endif
keyboard chr(K_ENTER)
return (NIL)

**-------------------------------------------**
Function ex_down()        && Expande para baixo
**-------------------------------------------**
memvar LIN2_

if LIN2_ < 23
   LIN2_ = LIN2_ + 1
endif
keyboard chr(K_ENTER)
return (NIL)



* ASPXXATN.PRG
* Gaspar
* Janeiro/91
* Objetivo: Indicar a proxima ocoorencia de um caracter num string
*
*
*    atnext(C,STRNG,N
*
*       C      : obrigatorio - string que se deseja procurar no string,
*       STRNG  : obrigatorio - string no qual se deseja procurar o primeiro string
*       N      : obrigatorio - valor da ocorrencia ate onde se deve
*                              fazer a pesquisa
*
**-----------------------**
Function atnext(C,STRNG_,N)
**-----------------------**
local M := len(STRNG_), K := len(C), J := 0, I

for I = 1 to M
    if substr(STRNG_,I,K) = C
      J = J + 1
      if J = N
         return (I)
      endif
   endif
next
return (0)


* ASPXXRST
* Gaspar
* Setembro/92
* Restaurar uma tela

*
*     rst(TELA_)
*
*       TELA_: tela salva com a funcao box() - contem as coordenadas e a tela
*
**--------------------------**
Function SAVEARRAY(Arg1, Arg2)
**--------------------------**
local Local1, Local2
Local1:= .F.
if ((Local2:= fcreate(Arg2), ValType(Arg1) = "A" .AND. ;
      ValType(Arg2) = "C" .AND. Local2 > 4))
   if (writearray(Local2, Arg1) .AND. Empty(ferror()))
      Local1:= .T.
   endif
   fclose(Local2)
endif
return Local1

**---------------------------**
Function WRITEARRAY(Arg1, Arg2)
**---------------------------**
local Local1, Local2, Local3, Local4
Local1:= .F.
Local2:= ValType(Arg2)
fwrite(Arg1, Local2, 1)
if (Empty(ferror()))
   do case
   case Local2 == "A"
      Local3:= Len(Arg2)
      fwrite(Arg1, l2bin(Local3), 4)
      aeval(Arg2, {|_1| writearray(Arg1, _1)})
   case Local2 == "C"
      fwrite(Arg1, l2bin(Len(Arg2)), 4)
      fwrite(Arg1, Arg2, Len(Arg2))
   case Local2 == "D"
      fwrite(Arg1, l2bin(8), 4)
      fwrite(Arg1, DToC(Arg2), 8)
   case Local2 == "L"
      fwrite(Arg1, l2bin(1), 4)
      fwrite(Arg1, iif(Arg2, "T", "F"))
   case Local2 == "N"
      Local3:= Len(Local4:= Str(Arg2))
      fwrite(Arg1, l2bin(Local3), 4)
      fwrite(Arg1, Local4, Local3)
   otherwise
      fwrite(Arg1, l2bin(3), 4)
      fwrite(Arg1, "NIL")
   endcase
   Local1:= Empty(ferror())
endif
return Local1

**---------------------**
Function RESTOREARR(Arg1)
**---------------------**
local Local1, Local2
Local2:= {}
if ((Local1:= fopen(Arg1), ValType(Arg1) = "C" .AND. file(Arg1) ;
      .AND. Local1 > 4))
   Local2:= readarray(Local1)
endif
return Local2

**--------------------**
Function READARRAY(Arg1)
**--------------------**
local Local1, Local2, Local3, Local4, Local5, Local6
Local1:= "    "
Local2:= " "
fread(Arg1, @Local2, 1)
fread(Arg1, @Local1, 4)
Local3:= bin2l(Local1)
if (Local2 == "A")
   Local4:= {}
   for Local5:= 1 to Local3
      AAdd(Local4, readarray(Arg1))
   next
else
   Local6:= Space(Local3)
   fread(Arg1, @Local6, Local3)
   do case
   case Local2 == "C"
      Local4:= Local6
   case Local2 == "D"
      Local4:= CToD(Local6)
      case Local2 == "L"
      Local4:= Local6 == "T"
   case Local2 == "B"
      Local4:= Nil
   case Local2 == "N"
      Local4:= Val(Local6)
   otherwise
      Local4:= Nil
   endcase
endif
return Local4

**-------------------**
Function menuedit(modo)
**-------------------**
If modo == 1
   keyboard chr(30)
Elseif modo == 2
   keyboard chr(31)
Endif
If lastkey()==13
   return(1)
Elseif lastkey()==27
   return(0)
Endif
return(2)

**-----------------**
Function Seila(M,L,C)
**-----------------**
If M == 0
   @ 00,00 Say "Linha.:" + str(L,3) + "   Coluna.:"  + strzero(C,2) Color P_COR1
Endif
If Lastkey() == K_F2  .or. Lastkey() == K_F3 .or. Lastkey() == K_F5 .or. Lastkey() == K_ESC
   PosLinha  := L
   PosColuna := C
   Return(23)
Endif
Return(0)


************************************************************
* Programa: SAVLICGC.PRG
* Objetivo: Biblioteca de fun‡oes de valida‡ao de CGC / CPF
* Autor:    Alex
* Data:     Abril / 94
************************************************************

Function ChecaCgc(PCgc)    // Valida CGC/CPF na forma 999.999.999/9999-99
*                                                     (sem m scara)

Private Cgc1,;
        Cgc2,;
        Cgc3,;
        RETORNO_

Cgc1 := Left(pCgc, 9)
Cgc2 := Substr(pCgc, 10, 4)
Cgc3 := Right(pCgc, 2)

If Cgc3 = '99'
   RETORNO_ := .t.
Else
   RETORNO_ := iif(Cgc2 = '0000', ValCpf(Cgc1 + Cgc3), ValCgc(Right(Cgc1, 8) + Cgc2 + Cgc3))
EndIf

Return(RETORNO_)


************************************************************
Function ValCgc(mCgc)                          // Valida CGC
************************************************************

private Ac,;
        I,;
        J,;
        d1,;
        d2
        //RETORNO_

If LastKey() = 5    // K_UP
   Return(.t.)
EndIf

If Len(alltrim(mCgc)) = 8 .and. Val(mCgc) > 0
   Ac := 0                          // Valida o £nico d¡gito
   J  := 0
   d1 := 0
   For I  := 1 to 7
       Ac := iif(I % 2 > 0, Val(Substr(mCgc, I, 1)) * 2, Val(Substr(mCgc, I, 1)))
       J  += iif(Ac > 9, Int(Ac / 10) + (Ac % 10), Ac)
   Next
   d1 := iif( (J % 10) > 0 ,  10 - (J % 10), 0)
   RETORNO_ := iif(d1 = Val(Right(mCgc, 1)), .t., .f.)

ElseIf Len(alltrim(mCgc)) = 14 .and. Val(mCgc) > 0
   Ac := 0                             // Valida o 1§ d¡gito
   J  := 5
   d1 := 0
   d2 := 0
   For I := 1 to 12
       Ac += Val(Substr(mCgc, I, 1)) * J
       J := iif(J > 2, J - 1, 9)
   Next
   Ac %= 11
   d1 := iif(Ac > 1, 11 - Ac, 0)

   Ac := 0                             // Valida o 2§ d¡gito
   I  := 0
   J  := 6
   For I := 1 to 13
       Ac += Val(Substr(mCgc, I, 1)) * J
       J  := iif(J > 2 , J - 1, 9)
   Next
   Ac %= 11
   d2 := iif(Ac > 1, 11 - Ac, 0)

   RETORNO_ := iif(d1 = Val(Substr(mCgc, 13, 1)) .and. d2 = Val(Right(mCgc, 1)), .t., .f.)
Else
   RETORNO_ := .f.
EndIf
If len(alltrim(mcgc)) < 14
   retorno = .f.
Endif
If retorno_ = .f.
   Alert("CGC;Inv lido!")
Endif
Return(RETORNO_)

**----------------**
Function seleciona()
**----------------**
P_REFRESH := 0
return(.t.)

************************************************************
Function ValCpf(mCpf)                          // Valida CPF
************************************************************

Private Ac,;
        I,;
        d1,;
        d2
        //RETORNO_ := .f.

If LastKey() = 5    // K_UP
   Return(.t.)
EndIf

If Len(alltrim(mCpf)) = 11 .and. Val(mCpf) > 0
   Ac  := 0                             // Valida o 1§ d¡gito
   d1 := 0
   d2 := 0

   For I := 1 to 9
       Ac += Val(Substr(mCpf, I, 1)) * (11 - I)
   Next
   Ac %= 11
   d1 := iif(Ac > 1, 11 - Ac, 0)

   Ac := 0                             // Valida o 2§ d¡gito
   For I := 1 to 10
       Ac += Val(Substr(mCpf, I, 1)) * (12 - I)
   Next
   Ac %= 11
   d2 := iif(Ac > 1, 11 - Ac, 0)

   RETORNO_ := iif(d1 = Val(Substr(mCpf, 10, 1)) .and. d2 = Val(Right(mCpf, 1)), .t., .f.)
EndIf
If len(alltrim(mcpf)) < 11
   retorno_ = .f.
Endif
If retorno_ = .f.
   alert("CPF;Inv lido!")
Endif
Return(RETORNO_)


**--------------**
Function protege()
**--------------**
local x, trava := {}, arquivo
dbselectarea("ASASSFL") ; ASASSFL->(dbgotop())
For x = 1 to ASASSFL->(reccount())
   AADD(trava,&(fieldname(1)))
   ASASSFL->(dbskip())
Next x
dbcloseall()
For x = 1 to len(trava)
   arquivo = Fopen(trava[x] + ".DBF" ,2)
   Fseek(arquivo,0,0)
   FWrite(arquivo,"")
   Fclose(arquivo)
Next
return(nil)
**------------------------**
Function desprotege(arquivo)
**------------------------**
Local destrava := Fopen(arquivo + ".DBF" ,2)
   Fseek(destrava,0,0)
   FWrite(destrava,"")
   Fclose(destrava)
Return(nil)


**--------------**
Function mes(wmes)
**--------------**
return(wmes:={"janeiro","fevereiro","marco","abril","maio","junho","julho","agosto","setembro","outubro","novembro","dezembro"}[wmes])


**--------------------**
Function semana(wsemana)
**--------------------**
return(wsemana:={"domingo","segunda-feira","terca-feira","quarta-feira","quinta-feira","sexta-feira","sabado"}[wsemana])


**------------------------------**
Function CALCULA(Arg1, Arg2, Arg3)
**------------------------------**
   local Local1, Local2, Local3, Local4, Local5, Local6, Local7, ;
      Local8, Local9, Local10, Local11, Local12, Local13, Local14, ;
      Local15, Local16

   If Arg1 == Nil
      Arg1 := "B+/W,n/w,,,B+/W"
   Endif
   Local1:= "0"
   Local2:= "0"
   Local3:= "0"
   Local4:= 0
   Local5:= 0
   Local6:= "0"
   Local7:= "0"
   Local8:= setcursor(1)
   Local9:= 9
   Local10:= 53
   Local11:= .T.
   Local12:= Row()
   Local13:= Col()
   Local14:= cpantacalc(Local9, Local10, Arg1, Arg2)
   Local15:= Set(_SET_DECIMALS, 2)
   Local16:= {padr("Calculadora", 21), padr("Ligada", 21), Space(21)}
   Local7:= Upper(Chr(Local5:= InKey()))
   do while (Local5 != 27 .AND. Local5 != -9)
      do case
      case Local5 == 18
         Local11:= .T.
         RestScreen(Local9, Local10, Local9 + 15, Local10 + 26, ;
            Local14)
         Local9:= 0
         Local10:= 0
         Local14:= cpantacalc(Local9, Local10, Arg1, Arg2)
      case Local5 == 3
         Local11:= .T.
         RestScreen(Local9, Local10, Local9 + 15, Local10 + 26, ;
            Local14)
         Local9:= 10
         Local10:= 55
         Local14:= cpantacalc(Local9, Local10, Arg1, Arg2)
      case Local5 == 5
         if (Local9 > 0)
            Local11:= .T.
            RestScreen(Local9, Local10, Local9 + 15, Local10 + 26, ;
               Local14)
            Local9--
            Local14:= cpantacalc(Local9, Local10, Arg1, Arg2)
         endif
      case Local5 == 24
         if (Local9 < MaxRow() - 14)
            Local11:= .T.
            RestScreen(Local9, Local10, Local9 + 15, Local10 + 26, ;
               Local14)
            Local9++
            Local14:= cpantacalc(Local9, Local10, Arg1, Arg2)
         endif
      case Local5 == 19
         if (Local10 > 0)
            Local11:= .T.
            RestScreen(Local9, Local10, Local9 + 15, Local10 + 26, ;
               Local14)
            Local10--
            Local14:= cpantacalc(Local9, Local10, Arg1, Arg2)
         endif
      case Local5 == 4
         if (Local10 < MaxCol() - 24)
            Local11:= .T.
            RestScreen(Local9, Local10, Local9 + 15, Local10 + 26, ;
               Local14)
            Local10++
            Local14:= cpantacalc(Local9, Local10, Arg1, Arg2)
         endif
      case Local7 == "A"
         Local5:= FAST2INK(0)
         Local7:= Upper(Chr(Local5))
         if (Local7 == "C")
            Local11:= .T.
            if (Local4 == 0)
               Local1:= "0"
            else
               Local2:= "0"
            endif
         else
            keyboard Local7
         endif
      case Local7 == "C"
         Local11:= .T.
         Local16[1]:= ""
         Local16[2]:= ""
         Local16[3]:= ""
         Local1:= Local2:= "0"
         Local4:= 0
         keyboard Chr(13)
      case Local7 == "M"
         Local5:= FAST2INK(0)
         Local7:= Upper(Chr(Local5))
         do case
         case Local7 == "+"
            Local11:= .T.
            if (Local4 == 0)
               Local3:= alltrim(Str(Val(Local3) + Val(Local1)))
            else
               Local3:= alltrim(Str(Val(Local3) + Val(Local2)))
            endif
         case Local7 == "-"
            Local11:= .T.
            if (Local4 == 0)
               Local3:= alltrim(Str(Val(Local3) - Val(Local1)))
            else
               Local3:= alltrim(Str(Val(Local3) - Val(Local2)))
            endif
         case Local7 == "*"
            Local11:= .T.
            if (Local4 == 0)
               Local3:= alltrim(Str(Val(Local3) * Val(Local1)))
            else
               Local3:= alltrim(Str(Val(Local3) * Val(Local2)))
            endif
         case Local7 == "/"
            if (Local4 == 0)
               if (Val(Local1) != 0)
                  Local11:= .T.
                  Local3:= alltrim(Str(Val(Local3) / Val(Local1)))
               endif
            elseif (Val(Local2) != 0)
               Local11:= .T.
               Local3:= alltrim(Str(Val(Local3) / Val(Local2)))
            endif
         case Local7 == "R"
            Local11:= .T.
            if (Local4 == 0)
               Local1:= Local3
            else
               Local2:= Local3
            endif
         case Local7 == "C"
            Local11:= .T.
            Local3:= "0"
         otherwise
            keyboard Local7
         endcase
      case Local7 == "+"
         if (Local4 != 0)
            keyboard Chr(13) + Local7
         else
            Local11:= .T.
            Local4:= 1
            Local16[1]:= Local16[3]
            Local16[2]:= padr("+", 21)
         endif
      case Local7 == "-"
         if (Local4 != 0)
            keyboard Chr(13) + Local7
         else
            Local11:= .T.
            Local4:= 2
            Local16[1]:= Local16[3]
            Local16[2]:= padr("-", 21)
         endif
      case Local7 == "*"
         if (Local4 != 0)
            keyboard Chr(13) + Local7
         else
            Local11:= .T.
            Local4:= 3
            Local16[1]:= Local16[3]
            Local16[2]:= padr("*", 21)
         endif
      case Local7 == "/"
         if (Local4 != 0)
            keyboard Chr(13) + Local7
         else
            Local11:= .T.
            Local4:= 4
            Local16[1]:= Local16[3]
            Local16[2]:= padr("/", 21)
         endif
      case Local7 == "%"
         if (Local4 != 0)
            keyboard Chr(13) + Local7
         else
            Local11:= .T.
            Local4:= 5
            Local16[1]:= Local16[3]
            Local16[2]:= padr("%", 21)
         endif
      case Local5 == 8
         if (Local4 == 0)
            Local11:= .T.
            Local1:= SubStr(Local1, 1, Len(Local1) - 1)
            if (Len(Local1) == 0)
               Local1:= "0"
            endif
         else
            Local11:= .T.
            Local2:= SubStr(Local2, 1, Len(Local2) - 1)
            if (Len(Local2) == 0)
               Local2:= "0"
            endif
         endif
      case Local7 == "."
         if (Local4 == 0)
            if (At(".", Local1) == 0)
               Local11:= .T.
               Local1:= Local1 + Local7
            endif
         elseif (At(".", Local2) == 0)
            Local11:= .T.
            Local2:= Local2 + Local7
         endif
      case Local7 >= "0" .AND. Local7 <= "9"
         if (Local4 == 0)
            if (Val(Local1) == 0 .AND. Len(Local1) == 1)
               if (Local7 != "0")
                  Local11:= .T.
                  Local1:= Local7
               endif
            elseif (Len(Local1) < 14)
               Local11:= .T.
               Local1:= Local1 + Local7
            endif
         elseif (Val(Local2) == 0 .AND. Len(Local2) == 1)
            if (Local7 != "0")
               Local11:= .T.
               Local2:= Local7
            endif
         elseif (Len(Local2) < 14)
            Local11:= .T.
            Local2:= Local2 + Local7
         endif
      case Local5 == 13 .AND. !Empty(Local2)
         Local11:= .T.
         do case
         case Local4 == 1
            Local1:= Str(Val(Local1) + Val(Local2))
         case Local4 == 2
            Local1:= Str(Val(Local1) - Val(Local2))
         case Local4 == 3
            Local1:= Str(Val(Local1) * Val(Local2))
         case Local4 == 4
            Local1:= Str(Val(Local1) / Val(Local2))
         case Local4 == 5
            Local1:= Str(Val(Local1) * Val(Local2) / 100)
         endcase
         Local16[1]:= Local16[3]
         Local16[2]:= padr("=", 21)
         Local4:= 0
         Local2:= "0"
      endcase
      Local1:= alltrim(Local1)
      Local2:= alltrim(Local2)
      if (Local4 == 0)
         if (Len(Local1) > 15)
            Local6:= padl("Error", 21)
         else
            Local6:= padl(Local1, 21)
         endif
      else
         Local6:= padl(Local2, 21)
      endif
      if (Local11 == .T.)
         Local16[3]:= Local6
         @ Local9 + 1, Local10 + 2 say Local16[1] color Arg2
         @ Local9 + 2, Local10 + 2 say Local16[2] color Arg2
         @ Local9 + 3, Local10 + 2 say Local16[3] color Arg2
         if (Val(Local3) != 0)
            @ Local9 + 3, Local10 + 2 say "M" color Arg3
         else
            @ Local9 + 3, Local10 + 2 say " " color Arg3
         endif
         Local11:= .F.
      endif
      if (Local6 == padl("Error", 21))
         Local6:= Local1:= Local2:= "0"
         Local4:= 0
      endif
      SetPos(Local9 + 3, Local10 + 22)
      Local5:= FAST2INK(0)
      Local7:= Upper(Chr(Local5))
   enddo
   set decimals to
   RestScreen(Local9, Local10, Local9 + 15, Local10 + 26, Local14)
   setcursor(Local8)
   SetPos(Local12, Local13)
   return iif(LastKey() == K_ESC, Nil, Val(Local6))


static function CPANTACALC(Arg1, Arg2, Arg3, Arg4)

   local Local1
   dispbegin()
   Local1:= SaveScreen(Arg1, Arg2, Arg1 + 15, Arg2 + 26)
   @ Arg1, Arg2 say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»" color Arg3
   @ Arg1 + 1, Arg2 say "º                       º" color Arg3
   @ Arg1 + 2, Arg2 say "º                       º" color Arg3
   @ Arg1 + 3, Arg2 say "º                       º" color Arg3
   @ Arg1 + 4, Arg2 say "ÌÍÍÍÑÍÍÍÑÍÍÍÑÍÍÍÑÍÍÍÑÍÍÍ¹" color Arg3
   @ Arg1 + 5, Arg2 say "º % ³ / ³ * ³ - ³ C ³ ACº" color Arg3
   @ Arg1 + 6, Arg2 say "ÇÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ¶" color Arg3
   @ Arg1 + 7, Arg2 say "º 7 ³ 8 ³ 9 ³   ³ M+³ MRº" color Arg3
   @ Arg1 + 8, Arg2 say "ÇÄÄÄÅÄÄÄÅÄÄÄ´ + ÃÄÄÄÅÄÄÄ¶" color Arg3
   @ Arg1 + 9, Arg2 say "º 4 ³ 5 ³ 6 ³   ³ M-³ MCº" color Arg3
   @ Arg1 + 10, Arg2 say "ÇÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ¶" color Arg3
   @ Arg1 + 11, Arg2 say "º 1 ³ 2 ³ 3 ³   ³ M*³Escº" color Arg3
   @ Arg1 + 12, Arg2 say "ÇÄÄÄÁÄÄÄÅÄÄÄ´ <ÙÃÄÄÄÅÄÄÄ¶" color Arg3
   @ Arg1 + 13, Arg2 say "º   0   ³ . ³   ³ M/³F10º" color Arg3
   @ Arg1 + 14, Arg2 say "ÈÍÍÍÍÍÍÍÏÍÍÍÏÍÍÍÏÍÍÍÏÍÍÍ¼" color Arg3
   @ Arg1 + 1, Arg2 + 1 say "                       " color Arg4
   @ Arg1 + 2, Arg2 + 1 say "                       " color Arg4
   @ Arg1 + 3, Arg2 + 1 say "                       " color Arg4
   dispend()
   return Local1

function FAST2INK(Arg1, Arg2)

   local Local1, Local2, Local3
   Local1:= 0
   Local2:= givetime()
   Arg2:= iif(isnil2(Arg2), .F., Arg2)
   Arg1:= iif(isnil2(Arg1), 0.01, Arg1)
   do while (iif(Arg1 == 0, .T., Arg1 + Local2 >= givetime()) .AND. ;
         Local1 == 0)
      Local1:= iif(Arg2, RINKEY2(0.02), InKey(0.02))
      if ((Local3:= SetKey(Local1)) != Nil)
         eval(Local3, procname(2), procline(2))
         Local1:= 0
      endif
   enddo
   return Local1

Function isnil2(Arg1)
Return(If(Arg1 == Nil,.t.,.f.))


********************************
function RINKEY2(Arg1)

   local Local1, Local2
   Local1:= 0
   Arg1:= iif(isnil2(Arg1), 0.01, Arg1)
   Local2:= Seconds() + Arg1
   do while (iif(Arg1 == 0, .T., Local2 >= Seconds()) .AND. Local1 ;
         == 0)
      Local1:= InKey(0.1)
   enddo
   return Local1

static function GIVETIME

   local Local1
   Local1:= {1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335}
   return (Local1[Month(Date())] + Day(Date()) - 1) * 86400.0 + ;
      Seconds()


**--------------**
Function CALENDA()
**--------------**
PRIVATE flag,dat1,tecla,tela,dia1,c1,c2
STORE 0 TO C1,C2
SALVACOR(@C1,@C2)
normal =setcolor()
TEA =savescreen(00,00,24,79)
flag =.t.
dat1 =m_datsi
dia1 =day(dat1)
do while flag
   exibecal()
   inkey(0)
   mes =month(dat1)
   ano =year(dat1)
   anual =year(m_datsi)-1900
   do case
      case lastkey() = 27
           setcolor(normal)
           flag =.f.
      case lastkey()=18
           ano =m->ano+iIf(m->ano<2000,1,0)
      case lastkey()=03
           ano =m->ano-iif(m->ano>1980,1,0)
      case lastkey()=01
           mes =m->mes+iif(m->mes<12,1,-11)
      case lastkey()=06
           mes =m->mes-iif(m->mes>1,1,-11)
   endcase
   dat1 =ctod("01."+strzero(m->mes,2)+"."+strzero(m->ano-1900,2))
enddo
restscreen(0,00,24,79,tea)
voltacor(c1,c2)
return
**-------------------------------
procedure exibecal
**-------------------------------
private ndias,c1,l1,laco,ano,mes,dat2,normal,video_rev
normal =setcolor()
video_rev ="n+/bg"
ano =year(dat1)-1900
anual =year(m_datsi)-1900
mes =month(dat1)
ndias =caldia(m->mes,m->ano)
l1 =11
c1 =dow(ctod("01."+strzero(m->mes,2)+"."+strzero(m->ano,2)))
@ 06,26 say'ÚÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¿'
@ 07,26 say'³                           ³'
@ 08,26 say'ÃÍÍÍÑÍÍÍÑÍÍÍÑÍÍÍÑÍÍÍÑÍÍÍÑÍÍÍ´'
@ 09,26 say'³Dom³Seg³Ter³Qua³Qui³Sex³Sab³'
@ 10,26 say'ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´'
@ 11,26 say'³   ³   ³   ³   ³   ³   ³   ³'
@ 12,26 say'ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´'
@ 13,26 say'³   ³   ³   ³   ³   ³   ³   ³'
@ 14,26 say'ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´'
@ 15,26 say'³   ³   ³   ³   ³   ³   ³   ³'
@ 16,26 say'ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´'
@ 17,26 say'³   ³   ³   ³   ³   ³   ³   ³'
@ 18,26 say'ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´'
@ 19,26 say'³   ³   ³   ³   ³   ³   ³   ³'
@ 20,26 say'ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´'
@ 21,26 say'³   ³   ³   ³   ³   ³   ³   ³'
@ 22,26 SAY'ÀÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÙ'
set color to w+/r
@ 07,27 say space(27)
@ 07,27 say "Mes: " + me(mes)
@ 07,44 say " Ano: "+ str(year(m_datsi))
T = savescreen(00,00,24,79)
setcolor(normal)
restscreen(00,00,24,79,t)
for laco= 1 to ndias
   If laco=day(m_datsi)
      set color to w+*/N
   Endif
   @ l1,25+c1*4-1 say strzero(laco,2)
   SETCOLOR(normal)
   c1 =c1+1
   If c1>7
      c1 =1
      l1 =l1+2
   Endif
next
return
**-------------------------------
Function caldia
**-------------------------------
parameters mes,ano
return(30+(m->mes+iif(m->mes>7,1,0))%2-iif(m->mes=2,1,0)*(2-(iif((m->ano-92)%4=0,1,0))))

**-------------------------------
Function me
**-------------------------------
parameters vmes
     do case
        case vmes = 1
        mes = "Janeiro "
        case vmes = 2
        mes = "Fevereiro "
        case vmes = 3
        mes = "Marco "
        case vmes = 4
        mes = "Abril "
        case vmes = 5
        mes = "Maio "
        case vmes = 6
        mes = "Junho "
        case vmes = 7
        mes = "Julho "
        case vmes = 8
        mes = "Agosto "
        case vmes = 9
        mes = "Setembro "
        Case vmes = 10
        mes = "Outubro "
        case vmes = 11
        mes = "Novembro "
        case vmes = 12
        mes = "Dezembro "
       endcase
        return(mes)

**-------------------------------
Function Salvacor
**-------------------------------
parameters x,y
y =row()
x =col()
return .t.

**-------------------------------
Function Voltacor
**-------------------------------
parameters y,x
@ y,x say ""
return .t.
**-------------------------------



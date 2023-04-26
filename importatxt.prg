#include "fileio.ch"
#include "migracao.ch"

procedure importatxt()

Local x,warq,cArq,clinha
*Public cHelp:={}

wArq := "CFOP.txt"
cArq  := Memoread(wArq)
use cfop
Zap
nlinha:= 543
cTexto := Memoline(cArq,60,x)
w_asc  := "|"

for x = 1 to nlinha
    wPos   :=""
    linha = 0
    For ii = 1 to Len(Alltrim(cTexto))
      if substr(cTexto,ii,1)$"||"
          wPos+=substr(cTexto,ii,1)
          *? "Posicao "+Str(ii)
          If wPos = "|"
             *alert(wpos)
             Texto = Alltrim(ctexto)
             wText = Substr(Texto,2,ii-3)
             wCfop = Substr(Texto,ii+3,4)
             Append Blank 
             Repl cfop with wCfop,descricao with wText
             *Alert(wText)
             *Alert(wCfop)
          Endif
          *? wPos
          *? cTexto
       endif
    Next ii
    *? "Linha "+Str(x)
    *AaDd(cHelp,nLinha)
Next
Use
Return

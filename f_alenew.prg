#Include "Inkey.Ch"

Function AlertNew(cMsg,aOptions,nBeginOption,lMsg,nTimeOut)

   Local nTop,  nLeft, nBottom, nRight
   Local nRows, nCols
   Local aRow,  aCol
   Local nCtr,  nLenOpt, nMaxText, cPart, cTextTmp

   Local aText := {}, nCursor := SetCursor(0)

   Private cCorNormal  := "W/B"
   Private cCorMsg     := "W+/B"
   Private cCorInverso := "w+/r"

   Private nOutTime := If(nTimeOut==Nil,nTimeOut:=0,nTimeOut)

   Save Screen

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

   altd()

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

   @ nTop,nLeft,nBottom,nRight Box "лплллмлл " Color cCorNormal

   For nCtr:=1 To Len(aText)
       @ nTop+nCtr,nLeft+2 Say PadC(aText[nCtr],nMaxText+2) Color cCorMsg
   Next nCtr

   nBeginOption := If( ValType(nBeginOption) != "N", 1, nBeginOption )
   nBeginOption := If( nBeginOption<1 .Or. nBeginOption>Len(aOptions), 1, nBeginOption )
     
   nopt:=0
      
   if !lMsg
      nOpt := Opcoes(nBottom-1,aCol,aOptions,nBeginOption)
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

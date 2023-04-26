// ***********************************
/*
   FILE NAME : ExportavendasoDoo.prg
   DESC      : Insere Orcamentos para o oDoo pelos Orcamentos
*/
// ***********************************
 #include "migracao.ch"
 #include "inkey.ch"
 #include "sipa.ch"
 #include "fileio.ch"
 #include "box.ch"

 Procedure ExportavendasoDoo(wOrcto,M_Vendedor,wMinuta,wPrestacoes)

 wOpcao = 1
 w = "001"

 If wOrcto = Nil
    Priv wOrctoNew[500],V_CPFNew[500],wMinutaNew[500],M_VendedorNew[500],wPrestacoesNew[500]
    wData  = m_datsi
    Sombra(13,30,17,50,box)
    @ 14,31 prom "Por Or‡amento"
    @ 15,31 prom "Por Data Movimento"
    @ 16,31 prom "Por Minuta"
    Menu to wOpcao
    If wOpcao = 3
       wMinuta = 0
       Sombra(17,31,19,51,box)
       @ 18,32 Say "Minuta:"get wMinuta pict "99999999"
       Read
       If Lastkey() = 27 .or. wMinuta = 0
          Return
       Endif
       ExportaminutaoDoo(wMinuta)
       Return
    ElseIf wOpcao = 2
       Sombra(17,31,19,61,box)
       @ 18,32 Say "Data Or‡amento:"get wData
       Read
       If Lastkey() = 27
          Return
       Endif
       Sele 4
       Set Order to 8
       Seek substr(dtoc(wData),7,4)+substr(dtoc(wData),4,2)+substr(dtoc(wData),1,2)
       While !Eof() .and. sd_data = wdata
         wPass = .f.
         wmin     = sd_nota
         wVend    = sd_vend
         wOrct    = sd_orca
         wVezesVd = sd_vezes
         While !Eof() .and. sd_nota = wMin .and. sd_vend = wVend
           If Trim(SD_SAIDA) = "CD IG" .or. Trim(SD_SAIDA) = "CDZ IG"
              wPass = .t.
           Endif
           Skip
         Enddo
         If wPass = .t.
            wMinutaNew[&w]     = wMin
            wOrctoNew[&w]      = wOrct
            M_VendedorNew[&w]  = wVend
            wPrestacoesNew[&w] = wVezesVd
            Sele 16
            Set Order to 1
            Seek Str(M_VendedorNew[&w],3,0)
            If !Eof()
               If Trim(Ba_Nome) = "ATACADO"
                  V_CPFNew[&w] = XY_CGC
               Else
                  V_CPFNew[&w] = BA_CPF
               Endif
            Endif
            w = STRZERO(Val(w)+1,3,0)
         Endif
         Sele 4
         Set Order to 8
       Enddo
    Else
       wOrcto = 0
       Sombra(17,31,19,51,box)
       @ 18,32 Say "Or‡amento:"get wOrcto pict "99999999"
       Read
       If Lastkey() = 27 .or. wOrcto = 0
          Return
       Endif
       Sele 28
       Set Order to 1
       Seek Str(wOrcto,8,0)
       If !Eof()
          M_Vendedor = cd_codven
       Else
          Alert("Or‡amento N„o Encontrado !")
          Return
       Endif
       Sele 4
       Set Order to 15
       Seek str(wOrcto,8,0)
       If !Eof()
          wMinuta     = sd_nota
          wPrestacoes = sd_vezes
       Else
          Alert("Minuta de Venda N„o Encontrada")
          Return
       Endif
    Endif
    Sele 16
    Set Order to 1
    Seek Str(M_Vendedor,3,0)
    If !Eof()
       If Trim(Ba_Nome) = "ATACADO"
          V_CPF = XY_CGC
       Else
          V_CPF = BA_CPF
       Endif
    Else
       Alert("Vendedor Sem Cadastro !")
       Return
    Endif
 Else
    Sele 16
    Set Order to 1
    Seek Str(M_Vendedor,3,0)
    If !Eof()
       If Trim(Ba_Nome) = "ATACADO"
          V_CPF = XY_CGC
       Else
          V_CPF = BA_CPF
       Endif
    Else
       Alert("Vendedor Sem Cadastro !")
       Return
    Endif
 Endif

 If wOpcao = 1

    wtesteOrcam = alltrim(str(wOrcto))
    !touch /tmp/orca_&wtesteOrcam

    wFase = "inicio de Orcamento, enviando ao Postgres "+wtesteOrcam
    !echo &wFase >> /tmp/orca_&wtesteOrcam

    @ 23,27 Say "Acessando Banco De Dodos PostGres"
    Stor "" to wSaidaCDs,wFilial
    SaidaCdSN  = "N"
    wIdoDoo:=InsereOrcaPostgres(wOrcto,V_CPF,w@SaidaCds,@SaidaCdSN,wMinuta,wPrestacoes,@wFilial)     // nesse prg

    wFase = "Orcamento enviado ao Postgres "
    !echo &wFase >> /tmp/orca_&wtesteOrcam

    If !Empty(wSaidaCds) .and. !Empty(wFilial)
       If SaidaCDSN = "N"
          wFase = "Orcamento sem Saida CD "+Trim(wSaidaCDs)
          !echo &wFase >> /tmp/orca_&wtesteOrcam
       ElseIf SaidaCDSN = "S"
          wFase = "Orcamento com Saida CD "+Trim(wSaidaCDs)
          !echo &wFase >> /tmp/orca_&wtesteOrcam
       Endif
       If wIdoDoo >0 .and. SaidaCDSN = "S"
          wFase = "Saida CD "+Trim(wSaidaCds)+" Com iDoDoo"
          !echo &wFase >> /tmp/orca_&wtesteOrcam
       ElseIf wIdoDoo =0 .and. SaidaCDSN = "S"
          wFase = "Saida CD "+Trim(wSaidaCds)+" Sem iDoDoo"
          !echo &wFase >> /tmp/orca_&wtesteOrcam
       Endif
    Else
       wFase = "Sem Retorno da IPI ou CD nao Migrado"
       !echo &wFase >> /tmp/orca_&wtesteOrcam
    Endif

    If wIdoDoo >0 .and. wSaidaCdSN = "S"

       wCnpjFilial:=Ret_NUm(xy_cgc)

       wTempo = 0
       wVez   = 0
       Pega_IdOdoo := ""
       While .t.
         wVez++
         If wVez > 2
            Exit
         Endif
         // Envia Orcamento para o oDoo
         If wVez = 1
            wFase = "Enviando Orcamento para o oDoo com ID: "+Alltrim(str(wIdoDoo))
            !echo &wFase >> /tmp/orca_&wtesteOrcam
            w_arq := "/tmp/orcamento_"+Alltrim(Str(wIdoDoo))+".txt"
         Endif

         @ 23,27 Say "Enviando Dados para o oDoo...... Tentativa  "+Str(wVez)
         wEnvia:="python3.6 /opt/odoo_rpc/envia_orcamento_filial.py criar -o "+Str(wIdoDoo)+" -e "+wCnpjFilial
         !&wEnvia

         wFase = "Lendo Arquivo gerado pelo RPC no /tmp  Tentativa "+Str(wVez)
         !echo &wFase >> /tmp/orca_&wtesteOrcam

         // Grava ID do oDoo no ERP
         If File("&w_arq")
            resPid  := MemoRead("&w_arq")
            wLen    := Len(resPid)
            Pega_IdOdoo := Substr(resPid,1,wLen)

            wFase = "Gravando IDoDoo no DBF: "+Pega_IdOdoo
            !echo &wFase >> /tmp/orca_&wtesteOrcam

            Sele 28
            Set Order to 1
            Seek Str(wOrcto,8,0)
            While !Eof() .and. cd_codior = wOrcto
              If Bloqreg(0)
                 Repl cd_iD with Val(Pega_IdOdoo)
              Endif
              Unlock
              Skip
            Enddo
            Sele 4
            Set Order to 1
            Seek str(wMinuta,8,0)
            While !Eof() .and. sd_nota = wMinuta
              If Bloqreg(0)
                 Repl sd_iD with Val(Pega_IdOdoo)
              Endif
              Unlock
              Skip
            Enddo
            
            // Confirmando venda no oDoo
            
            SetColor("BG+/B+")
            Sombra(15,25,17,70,BOX)
            @ 16,27 SAY "Aguarde, Confirmando Venda no oDoo...."
            @ 18,27 SAY ""
            wEnvia:="python3.6 /opt/odoo_rpc/altera_status_venda.py --id "+alltrim(Pega_IdOdoo)+" --etapa confirmada --minuta "+Alltrim(str(wMinuta))
            !&wEnvia

            Exit
         Else
            Loop
         Endif

         Inkey(1)
         wTempo++
         If wTempo > 119
             Exit
         Endif
       Enddo
       If !File("&w_arq")
          wFase = "Arquivo N„o Encontrado: "+w_arq
          !echo &wFase >> /tmp/orca_&wtesteOrcam
       Endif
       /*
       If Empty(Pega_IdOdoo)
          Alert("Arquivo de Retorno do oDoo N„o Encontrado ou Saida Nao e' CD Iguatu !")
       Endif
       */
       *DeleteFile("&w_arq")
    ElseIf wIdoDoo = 0 .and. wSaidaCdSN = "S"
        Alert("Sem Retorno de Numero de Or‡amento no Banco de Dados !")
    Endif

 Else

   wCt = 1
   While wCt <= Val(w) - 1
     wtesteOrcam = alltrim(str(wOrctoNew[wct]))
     !touch /tmp/orca_&wtesteOrcam

     wFase = "inicio de Orcamento, enviando ao Postgres "+wtesteOrcam
     !echo &wFase >> /tmp/orca_&wtesteOrcam

     @ 23,27 Say "Acessando Banco De Dodos PostGres"
     Stor "" to wSaidaCDs,wFilial
     SaidaCdSN  = "N"
     wIdoDoo:=InsereOrcaPostgres(wOrctoNew[wct],V_CPFNew[wct],@SaidaCds,@SaidaCDSN,wMinutaNew[wct],wPrestacoesNew[wct]@,wFilial)     // nesse prg


     wFase = "Orcamento enviado ao Postgres "
     !echo &wFase >> /tmp/orca_&wtesteOrcam

     If !Empty(wSaidaCds) .and. !Empty(wFilial)
        If SaidaCDSN = "N"
           wFase = "Orcamento sem Saida CD "+Trim(wSaidaCDs)
           !echo &wFase >> /tmp/orca_&wtesteOrcam
        ElseIf SaidaCDSN = "S"
           wFase = "Orcamento com Saida CD "+Trim(wSaidaCDs)
           !echo &wFase >> /tmp/orca_&wtesteOrcam
        Endif
        If wIdoDoo >0 .and. SaidaCDSN = "S"
           wFase = "Saida CD "+Trim(wSaidaCds)+" Com iDoDoo"
           !echo &wFase >> /tmp/orca_&wtesteOrcam
        ElseIf wIdoDoo =0 .and. SaidaCDSN = "S"
           wFase = "Saida CD "+Trim(wSaidaCds)+" Sem iDoDoo"
           !echo &wFase >> /tmp/orca_&wtesteOrcam
        Endif
     Else
        wFase = "Sem Retorno da IPI ou CD nao Migrado"
        !echo &wFase >> /tmp/orca_&wtesteOrcam
     Endif

     If wIdoDoo >0 .and. wSaidaCdSN = "S"

        wCnpjFilial:=Ret_NUm(xy_cgc)

        wTempo = 0
        wVez   = 0
        Pega_IdOdoo := ""
        While .t.
          wVez++
          If wVez > 2
             Exit
          Endif
          // Envia Orcamento para o oDoo
          If wVez = 1
             wFase = "Enviando Orcamento para o oDoo com ID: "+Alltrim(str(wIdoDoo))
             !echo &wFase >> /tmp/orca_&wtesteOrcam
             w_arq := "/tmp/orcamento_"+Alltrim(Str(wIdoDoo))+".txt"
          Endif

          @ 23,27 Say "Enviando Dados para o oDoo...... Tentativa  "+Str(wVez)
          wEnvia:="python3.6 /opt/odoo_rpc/envia_orcamento_filial.py criar -o "+Str(wIdoDoo)+" -e "+wCnpjFilial
          !&wEnvia

          wFase = "Lendo Arquivo gerado pelo RPC no /tmp  Tentativa "+Str(wVez)
          !echo &wFase >> /tmp/orca_&wtesteOrcam

          // Grava ID do oDoo no ERP
          If File("&w_arq")
             resPid  := MemoRead("&w_arq")
             wLen    := Len(resPid)
             Pega_IdOdoo := Substr(resPid,1,wLen)

             wFase = "Gravando IDoDoo no DBF: "+Pega_IdOdoo
             !echo &wFase >> /tmp/orca_&wtesteOrcam

             Sele 28
             Set Order to 1
             Seek Str(wOrctoNew[wct],8,0)
             While !Eof() .and. cd_codior = wOrctoNew[wct]
               If Trim(cd_saida) = "CD"
                  If Bloqreg(0)
                     Repl cd_iD with Val(Pega_IdOdoo)
                  Endif
                  Unlock
               Endif
               Skip
             Enddo
             Sele 4
             Set Order to 1
             Seek str(wMinutaNew[wct],8,0)
             While !Eof() .and. sd_nota = wMinutaNew[wct]
               If Trim(sd_saida) = "CD"
                  If Bloqreg(0)
                     Repl sd_iD with Val(Pega_IdOdoo)
                  Endif
                  Unlock
               Endif
               Skip
             Enddo

             Exit
          Else
             Loop
          Endif

          Inkey(1)
          wTempo++
          If wTempo > 119
              Exit
          Endif
       Enddo
       If !File("&w_arq")
          wFase = "Arquivo N„o Encontrado: "+w_arq
          !echo &wFase >> /tmp/orca_&wtesteOrcam
       Endif
    ElseIf wIdoDoo = 0 .and. wSaidaCdSN = "S"
        Alert("Sem Retorno de Numero de Or‡amento no Banco de Dados !")
    Endif
    wCt ++
 Enddo
Endif
 Release wPass,wmin,wVend,wOrct,wVezesVd,wPrestacoes
 Release all like m_prd*
 Release all like m_cod*
 Release flag,m_dias,wFase
 Keyb(chr(27))
 Return

//***************************
  Procedure InsereOrcaPostgres(wOrcamento,wCpfVendedor,wSaidaCds,SaidaCdSN,wMinuta,wPrestacoes,wFilial)
//***************************
  VerificaProdutos(wOrcamento)    // Verificando se os produtos existem no 9.2

  Priv w_garant[10],w_plano[10],m_grfator[10],M_Pre[10]
  Priv M_QTD[10],M_CODPRD[10],M_DE[10],M_AC[10],M_SAID[10]
  Priv M_RESERV[10],M_AUTOR[10],M_VRCIRC[10],M_Vezesci[10],M_VEZES
  Priv M_IMEIPRD[10],M_TXE[10],M_TXM[10],TEMGARANTIA

  M = "001"
  TEMGARANTIA     = "N"
  TEMSAIDACD      = "N"

  Sele 28
  Set Order to 1
  Seek STR(wOrcamento,8,0)
  If Eof()
     Alert("Or‡amento N„o Encontrado !")
     Return
  Endif
  While !Eof() .and. CD_CODIOR = wOrcamento
    M_CGF     = CD_CGF
    FON1X     = CD_FIXO
    M_CLIE    = CD_CODICL
    M_NOME    = CD_NOMECL
    If !Empty(CD_ENDET)
       M_ENDEX = CD_ENDET
    Else
       M_ENDEX = CD_ENDE
    Endif
    If !Empty(CD_NUMEROT)
       M_NUMERO = CD_NUMEROT
    Else
       M_NUMERO = CD_NUMERO
    Endif
    If Empty(M_NUMERO)
       M_NUMERO = "SN"
    Endif
    If !Empty(CD_COMPLET)
       M_COMPLE = CD_COMPLET
    Else
       M_COMPLE = CD_COMPLE
    Endif
    If !Empty(CD_BAIRT)
       M_BAICL = CD_BAIRT
    Else
       M_BAICL = CD_BAIR
    Endif
    If !Empty(CD_CEPT)
       M_CEPCL = CD_CEPT
    Else
       M_CEPCL = CD_CEP
    Endif
    If !Empty(CD_IBGET)
       M_Ibge  = CD_IBGET
    Else
       M_Ibge  = CD_IBGE
    Endif
    If !Empty(CD_CIDAT)
       M_CIDACL = CD_CIDAT
    Else
       M_CIDACL = CD_CIDA
    Endif
    If !Empty(CD_UFT)
       M_UFCL  = CD_UFT
    Else
       M_UFCL  = CD_UF
    Endif
    FONECEL   = CD_FONE
    If !Empty(CD_CPF)
       CPFX   = CD_CPF
    Else
       CPFX   = CD_CGC
    Endif
    M_RG      = CD_RG
    CGCX      = CD_CGC
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
       M_TIPO = 8     // Boleto
    Endif
    If Trim(CD_SAIDA) <> "LOJA/MOST"
       TEMSAIDACD  = "S"
    Endif
    wFil = ""
    If Trim(CD_SAIDA) = "CD IG" .or. Trim(CD_SAIDA) = "CDZ IG"
       wSaidaCds = "Iguatu"
       wFil = "20"
    Endif
    If Trim(CD_SAIDA) = "CD JUA" .or. Trim(CD_SAIDA) = "CDZ JUA"
       wSaidaCds = "Juaze"
       wFil = "99"
    Endif
    If Trim(CD_SAIDA) = "CD SOB" .or. Trim(CD_SAIDA) = "CDZ SOB" .or. Trim(CD_SAIDA) = "DEP SOB" .or. Trim(CD_SAIDA) = "DEP. SOB" .or. Trim(CD_SAIDA) = "DEP.SOB"
       wSaidaCds = "Sobral"
       wFil = "11"
    Endif
    If Trim(CD_SAIDA) = "CD FOR" .or. Trim(CD_SAIDA) = "CDZ FOR"
       wSaidaCds = "Fort"
       wFil = "19"
    Endif
    If Trim(CD_SAIDA) = "CD TAUA" .or. Trim(CD_SAIDA) = "CDZ TAUA"
       wSaidaCds = "Taua"
       wFil = "10"
    Endif

    If !Empty(wFil)
       Sele 58
       Veriout(SETCOLOR(),23,"filiais")
       Go Top
       While !Eof()
         If Fili = wFil .and. ESTOQODOO = "S"
            wFilial = Fili
            SaidaCDSN = "S"
            Exit
         Endif
         Skip
       Enddo
       Use
       Sele 4
       Set Order to 1
    Endif

    //Itens
    If CD_VRGR >0
       TEMGARANTIA = "S"
    Endif
    M_VEZES       = CD_VEZES
    w_garant[&m]  = CD_VRGR
    w_plano[&m]   = CD_PLANO
    m_grfator[&m] = CD_FATORGR
    M_QTD[&m]     = CD_QUANT
    M_CODPRD[&m]  = CD_CODI
    M_Pre[&m]     = CD_UNIT

    If M_Pre[&m] = 0
      Sele 3
      Set Order to 1
      Seek M_CODPRD[&m]
      M_Pre[&m] = CD_AVISTA2
      Sele 28
      Set Order to 1
    Endif

    M_DE[&m]      = CD_DESCO
    M_AC[&m]      = CD_ACRES
    M_SAID[&m]    = CD_SAIDA
    M_RESERV[&m]  = CD_RESERV
    M_AUTOR[&m]   = CD_AUTOR
    M_VRCIRC[&m]  = CD_VRCIRC
    M_Vezesci[&m] = CD_VEZESCI
    M_IMEIPRD[&m] = CD_IMEI
    M_TXE[&m]     = CD_TXE
    M_TXm[&m]     = CD_TXM
    M = Str(Val(m)+1)
    Skip
  Enddo

  wtesteOrcam = alltrim(str(wOrcamento))
  wFasePostgres = "Verificando Se Existe Participante no 9.2"
  !echo &wFasePostgres  >> /tmp/orca_&wtesteOrcam

  wIdPart:= RetPartic(m_Clie,m_Nome,m_Endex,m_Numero,m_Comple,m_CepCl,m_Baicl,m_IBge,m_UFCL,m_CIDACL,CPFx,m_CGF,FoneCel,m_eMAIL)
  @ 21,32 say "ID Participante: "+Alltrim(Str(wIdPart))
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
   hFields['PONTO_DE_REFERENCIA']      := M_Refer
   hFields['PONTO_DE_REFERENCIA2']     := M_Refer2
   hFields['OBSERVACAO']               := M_obser
   hFields["CPF_VENDEDOR"]             := Ret_Num(wCpfVendedor)
  *hFields["CODIGO_ORCAMENTO"]         := Alltrim(Str(wOrcamento))
   hFields["CODIGO_ORCAMENTO"]         := Alltrim(Str(wMinuta))
   hFields["MINUTA"]                   := Alltrim(Str(wMinuta))
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
     hFields["PRODUTOS_ID"]          := M_CODPRD[M_CT]
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
     hFields["IMEI"] := M_IMEIPRD[M_CT]

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

 @ 22,32 say "ID Ppostgres9.2: "+Alltrim(Str(wIdOrcamento))

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
       wIdPar:=InsertClientes(wClieDBf,wNomeDbf,wEndeDbf,wNumeDbf,wCompDbf,wCepDbf,wBaiDbf,wCodmDbf,wUfDbf,wCpfCnpj,wInscDbf,wCidaDbf)
       If wIdPar = 0
          Alert("Error ao Inserir Cliente no Banco !")
          Return
       Else
          If Empty(wVarInsc) .and. !Empty(wInscDbf)
             UpDate_InscPartClie(wInscDbf,wiDPar)          // Atualiza Participantes antes de faturar
          Endif
          UpDate_CepPartClie(wCepDbf,wCodmDbf,wiDPar)   // Atualiza Participantes antes de faturar
          wClieDbf = Alltrim(Str(wIdPar))
       Endif
    Else
       // Verificando Insc Estadual do Participante
       If !Empty(wVarInsc) .and. !Empty(wInscDbf)
          wClieDbf = Alltrim(Str(wIdPar))
       Else
          If !Empty(wInscDbf) .and. Empty(wVarInsc)
             UpDate_InscPartClie(wInscDbf,wiDPar)          // Atualiza Participantes antes de faturar
          Endif
          wClieDbf = Alltrim(Str(wIdPar))
       Endif

       // Verificando CEP e Codigo_IBGE do Participante
       UpDate_CepPartClie(wCepDbf,wCodmDbf,wiDPar)   // Atualiza Participantes antes de faturar
       wClieDbf = Alltrim(Str(wIdPar))

       // Atualizando Endereco do Participante
       UpDate_EnderecoPartClie(wEndeDbf,wNumeDbf,wCompDbf,wCepDbf,wBaiDbf,wFoneDbf,wEmailDbf,wIdPar)   // Atualiza Participantes antes de faturar

    Endif
 Endif
Return(wIdPar)

//****************************
  Function UpDate_InscPartClie(wVarInsc,idPart)   // Atualiza Inscricao Estadual do Participantes antes de faturar
//****************************
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

//***************************
  Function UpDate_CepPartClie(CepP,Cod_MunicP,idPart)   // Atualiza Participantes antes de faturar
//***************************
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

//********************************
  Function UpDate_EnderecoPartClie(wEndeDbf,wNumeDbf,wCompDbf,wCepDbf,wBaiDbf,wFoneDbf,wEmailDbf,IdPart)   // Atualiza Participantes antes de faturar
//********************************
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

//***********************
  Function InsertClientes(wClieDBf,wNomeDbf,wEndeDbf,wNumeDbf,wCompDbf,wCepDbf,wBaiDbf,wCodmDbf,wUfDbf,wCpf_Cnpj,wInsC,wCidDbf)
//***********************
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

 Sele 28
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
   ConsultaSUBGPRD(wSubGID,@wStatus)  // Pesquisa de SubGrupos
   If wStatus = .f.
      InsereSubGrupoPRD(wSubGID,wGrupprd)
   Endif

   wStatus:=ConsultaProdutos(wProdID,@wCestDb,@wOrgDb,@wncmDb,@wSubGDb,@wEanDb,@wDescFDb,@wStatus)  // Pesquisa de Produtos
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
       wRetClie:=Busca_NomesCli(fn_cgc,Trim(fn_nome),"J",fn_cep,fn_ibge,wInsc)  // Participangtes
       If wRetClie = 0
          wRetClie:=InsertFornec(wCodForn,wNomeFor,wEndeFor,wNumFor,wCompFor,wCepFor,wBaiFor,wCodmFor,wUfFor,wCpfCnpjFor,wInsc,wCidaFor)
          If wRetClie = 0
             Alert("Error ao Inserir Fornecedor no Banco de Participantes !")
             Return
          Endif
      Endif

      wFasePostgres = "Iniciando Insercao de Produtos no 9.2"
      !echo &wFasePostgres  >> /tmp/orca_&wtesteOrcam

      wInsert:=InsereProdutos(wProdID,wRetClie)
      If wInsert = .f.
         wFasePostgres = "Falha ao Inserir Produtos no 9.2"
         !echo &wFasePostgres  >> /tmp/orca_&wtesteOrcam
         Return
      Else
         wFasePostgres = "Produto Inserido Com Sucesso no 9.2"
        !echo &wFasePostgres  >> /tmp/orca_&wtesteOrcam
      Endif
   Endif
   Sele 28
   Set Order to 1
   Skip
 Enddo
 Release wProdID,wCestID,wCestDb,wStatus,wSubGID,wSubGDb,wGrupprd
Return

//***********************
  Function InsereProdutos(nProduto,wIdFabricante)
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

//***********************
  Function Busca_NomesCli(wCpfDbf,wNomeDbf,wPessoa,wVarCep,wVarIbge,wVarInsc)
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

//******************
  Function ConsultaProdutos(wCodProd,wCestDB,wOrgDB,wncmDb,wSubGDb,wEanDB,wDescFDb,wStatus)  // Pesquisa de Produtos
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
  Function ConsultaSUBGPRD(wSubGDb,wStatus)  // Pesquisa de SubGrupos
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
  Function InsereSubGrupoPRD(nSubGrupo,nGrupprd)
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

//*********************
  Function InsertFornec(wClieDBf,wNomeDbf,wEndeDbf,wNumeDbf,wCompDbf,wCepDbf,wBaiDbf,wCodmDbf,wUfDbf,wCnpj,wInsC,wCidDbf)
//*********************
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

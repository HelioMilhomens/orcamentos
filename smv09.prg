//**********************************************
/*
  FILE NAME : SMV09.PRG
  BY        : HELIO
  DESC      : ORCAMENTOS DE MERCADORIAS (VENDAS)
*/
//***********************************************

#include "migracao.ch"
#include "box.ch"
#include "inkey.ch"

Procedure Smv09()

 SET KEY -2 TO
 SET KEY -3 TO
 SET KEY -6 TO
 SET KEY -7 TO
 SET KEY -8 TO
 SET KEY -9 TO
 SET KEY 22 TO
 SET KEY -40 TO

 Sele 10
 Veriout(setcolor(),23,"cdcash")     && caixa diario
 Set index to index_cdcash
 Sele 10
 Set Order to 1
 Seek M_DATSI
 If CX_ENCE="S"
    Alert( "Process.Inv lido.Movto Encerrado.Opera‡„o Recusada !")
    Return
 Endif
 Use
 Sele 48
 Veriout(SETCOLOR(),23,"empresa")
 If Indice = "S"
    Alert("Arquivos Sendo Indexados, Tente Mais Tarde !")
    Close All
    Cls
    Quit
 Endif

 // Tabela Promocional por tempo limitado e por Depto
 I_DataIniCC_01 = DtIniCC_01
 I_DataFimCC_01 = DtFimCC_01
 I_DataIniCC_02 = DtIniCC_02
 I_DataFimCC_02 = DtFimCC_02
 I_DataIniCC_03 = DtIniCC_03
 I_DataFimCC_03 = DtFimCC_03
 I_DataIniCC_04 = DtIniCC_04
 I_DataFimCC_04 = DtFimCC_04
 I_DataIniCC_06 = DtIniCC_06
 I_DataFimCC_06 = DtFimCC_06
 I_DataIniCC_07 = DtIniCC_07
 I_DataFimCC_07 = DtFimCC_07
 I_DataIniCC_08 = DtIniCC_08
 I_DataFimCC_08 = DtFimCC_08
 I_DataIniCC_16 = DtIniCC_16
 I_DataFimCC_16 = DtFimCC_16
 I_DataIniCC_17 = DtIniCC_17
 I_DataFimCC_17 = DtFimCC_17
 I_DataIniCC_18 = DtIniCC_18
 I_DataFimCC_18 = DtFimCC_18
 I_DataIniCC_19 = DtIniCC_19
 I_DataFimCC_19 = DtFimCC_19

 I_DataIniCa_01 = DtIniCa_01
 I_DataFimCa_01 = DtFimCa_01
 I_DataIniCa_02 = DtIniCa_02
 I_DataFimCa_02 = DtFimCa_02
 I_DataIniCa_03 = DtIniCa_03
 I_DataFimCa_03 = DtFimCa_03
 I_DataIniCa_04 = DtIniCa_04
 I_DataFimCa_04 = DtFimCa_04
 I_DataIniCa_06 = DtIniCa_06
 I_DataFimCa_06 = DtFimCa_06
 I_DataIniCa_07 = DtIniCa_07
 I_DataFimCa_07 = DtFimCa_07
 I_DataIniCa_08 = DtIniCa_08
 I_DataFimCa_08 = DtFimCa_08
 I_DataIniCa_16 = DtIniCa_16
 I_DataFimCa_16 = DtFimCa_16
 I_DataIniCa_17 = DtIniCa_17
 I_DataFimCa_17 = DtFimCa_17
 I_DataIniCa_18 = DtIniCa_18
 I_DataFimCa_18 = DtFimCa_18
 I_DataIniCa_19 = DtIniCa_19
 I_DataFimCa_19 = DtFimCa_19

 I_TaxaCC_01 = TaxaCC_01
 I_TaxaCC_02 = TaxaCC_02
 I_TaxaCC_03 = TaxaCC_03
 I_TaxaCC_04 = TaxaCC_04
 I_TaxaCC_06 = TaxaCC_06
 I_TaxaCC_07 = TaxaCC_07
 I_TaxaCC_08 = TaxaCC_08
 I_TaxaCC_16 = TaxaCC_16
 I_TaxaCC_17 = TaxaCC_17
 I_TaxaCC_18 = TaxaCC_18
 I_TaxaCC_19 = TaxaCC_19

 I_TaxaCa_01 = TaxaCa_01
 I_TaxaCa_02 = TaxaCa_02
 I_TaxaCa_03 = TaxaCa_03
 I_TaxaCa_04 = TaxaCa_04
 I_TaxaCa_06 = TaxaCa_06
 I_TaxaCa_07 = TaxaCa_07
 I_TaxaCa_08 = TaxaCa_08
 I_TaxaCa_16 = TaxaCa_16
 I_TaxaCa_17 = TaxaCa_17
 I_TaxaCa_18 = TaxaCa_18
 I_TaxaCa_19 = TaxaCa_19

 I_VezesCC_01= VezesCC_01
 I_VezesCC_02= VezesCC_02
 I_VezesCC_03= VezesCC_03
 I_VezesCC_04= VezesCC_04
 I_VezesCC_06= VezesCC_06
 I_VezesCC_07= VezesCC_07
 I_VezesCC_08= VezesCC_08
 I_VezesCC_16= VezesCC_16
 I_VezesCC_17= VezesCC_17
 I_VezesCC_18= VezesCC_18
 I_VezesCC_19= VezesCC_19

 I_VezesCa_01= VezesCa_01
 I_VezesCa_02= VezesCa_02
 I_VezesCa_03= VezesCa_03
 I_VezesCa_04= VezesCa_04
 I_VezesCa_06= VezesCa_06
 I_VezesCa_07= VezesCa_07
 I_VezesCa_08= VezesCa_08
 I_VezesCa_16= VezesCa_16
 I_VezesCa_17= VezesCa_17
 I_VezesCa_18= VezesCa_18
 I_VezesCa_19= VezesCa_19
 wPercentPromo=PERCPROMOS    && Parametros de Promocao por Supervisao
 Use

While .T.
 STOR SPACE(1) TO M_NOME,ENDEX,FON1X,CPFX,CGCX,M_BAICL,M_CEPCL,M_CIDACL,FONECEL
 STOR SPACE(1) TO M_BLO,M_REFER,M_REFER2,M_OBSER,M_SAIDA,M_RG,M_UFCL,M_CGF
 STOR 0 TO m_vrvenda,m_vrentr,m_num1,m_tx_cc

 Stor Space(14) to M_CEL
 M_ANIV   = CTOD("  /  /    ")
 M_DAT    = M_DATSI
 M_ULTIMA = M_DATSI

 *Verifcx(m_dat)              && Aceita o F7 se inibir essa opcao

  TelVen()                 && SMV06.PRG

  Set key 28 to help
  Set Key -40 TO

  PRIV M_QTD[30],M_COD[30],M_PRD[30],M_STO[30],M_PRE[30],M_COM[30],M_AUTOR[30],w_garant[30],m_grfator[30],m_vezesci[30],wnSerie[30],wEntrega[30]
  PRIV M_ACH[30],M_AC[30],M_DE[30],M_COR[30],M_SAID[30],M_VEZES[30],m_Vrplano[30],M_IMEI[30],w_plano[30],w_plav[30],w_vezesgr[30]

  STOR 0 TO M_CO,M_PE,CENTX,M_NUM,M_AUTO,M_TOTAC,S_DIA,M_ENTRAD,M_PERCENTR,M_VRCAR,M_PASSOUCL
  STOR 0 TO M_NOTA,M_T,M_CLIE,M_NOME,M_GRTO,M,M_CONT,M_VRFIN,M_TOTD,M_TXM,TXM,M_CODIMEI,M_TXE

  STOR 12 TO m_vezespl
  STOR SPACE(10) TO M_NUMERO,wNUMERO
  M_DATA    = M_Ultima
  ACGC      = ""
  M_T       = " "
  W_IMEI    = " "
  M_TOTS    = "N"
  M_AJUST   = "N"   && VARIAVEL DE APOIO
  M         = "01"
  STOR "" to wEndTrega,wCidaTrega,wBairTrega,wCepTrega,wUFTrega,wIbgeTrega,wComple,wSaida,M_COMPLE

  STOR Space(15) to M_IMEI[&M]
  STOR 1 TO VEZES,M_PLM
  SET COLOR TO
  SETCOLOR("W+/b")
  @ 5,12 SAY M_DATA
  IF M_TIPO = 1
     @ 1,62 SAY "A Vista"
  ELSEIF M_TIPO = 2
     @ 1,62 SAY "Com Cheque"
  ELSEIF M_TIPO = 3
     @ 1,62 SAY "A Prazo no Carnet"
  ELSEIF M_TIPO = 4
     @ 1,62 SAY "Promotora"
  ELSEIF M_TIPO = 5
     @ 1,62 SAY "Cart„o de Cr‚dito"
  ELSEIF M_TIPO = 10
     @ 1,62 SAY "Boleto Banc rio"
  ELSEIF M_TIPO = 11
     @ 1,62 SAY "E-Commerce"
  /*
    ELSEIF M_TIPO = 6
       @ 1,62 SAY "Caixa /Financ"
       M_TIPO = 9
    ELSEIF M_TIPO = 6
       @ 1,62 SAY "Carnˆ /Convˆnio"
    ELSEIF M_TIPO = 7
       @ 1,62 SAY "BMG (Consignada)"
    ELSEIF M_TIPO = 8
       @ 1,62 SAY "CAIXA /CONVENIO"
  */
    Endif
    If m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 4 .or. m_tipo = 5 .or. m_tipo = 6 .or. m_tipo = 8 .or. m_tipo = 9 .or. m_tipo = 10
       infp=savescreen(11,30,19,47)
       Sombra(11,30,14,44,Box)
       @ 12,31 prom "Sem Entrada "
       @ 13,31 prom "Com Entrada "
       Menu to m_plm
       If m_plm = 2
          If ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 6 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
             If m_debcc = 2
                m_vezespl= 1
             ElseIf m_debcc = 3
                m_vezespl= 1
             ElseIf m_debcc = 4
                m_vezespl= 2
             ElseIf m_debcc = 5
                m_vezespl= 3
             ElseIf m_debcc = 6
                m_vezespl= 4
             ElseIf m_debcc = 7
                m_vezespl= 5
             Endif
          Endif
          Stor 0 to m_vrvenda,m_vrentr
          Set Color To N/W
          @ 12,30 clear to 18,46
          @ 12,30,18,46 BOX B_DOUBLE
          Set color to B/W
          @ 11,30 Say "Parametros       "
          @ 12,30 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
          @ 13,31 Say " Total da venda"
          @ 15,31 Say " Vr.da Entrada "
          @ 17,31 Say "Em      Vezes  "
          @ 18,30 Say "À"
          SETCOLOR("B+/W, W+/B")
          @ 14,32 get m_vrvenda pict "@e 999,999.99" valid m_vrvenda >0
          @ 16,32 get m_vrentr  pict "@e 999,999.99" valid m_vrentr <= m_vrvenda
          If ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 6 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
             @ 17,35 say m_vezespl pict "99"
          Else
             @ 17,35 get m_vezespl pict "99" valid m_vezespl > 0 .and. m_vezespl < 25
          Endif
          Read

          m_percentr = m_vrentr / m_vrvenda * 100
          m_entrad   = m_vrentr
          m_num1     = m_vezespl

          If ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 6 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
             m_vrcar = m_entrad
          Endif
       Endif
       Restscreen(11,30,19,47,infp)
    Endif

    m_passoucl := PROCCPF()
    SetColor("w+/b")
    @ 5,32 GET M_CLIE PICT "999999"
    Read
    SET KEY -41 TO
    SET KEY -2  TO
    If Lastkey() = 27
       Return
    Endif
    IF M_PASSOUCL = 0             // Nao Houve Conexao
       SELE 1
       SET ORDER TO 1
       SEEK M_CLIE
       IF Eof()
          Alert("Cliente N„o Cadastrado. Verifique !")
          M_NOME  = SPACE(45)
          ENDEX   = SPACE(40)
          FON1X   = SPACE(15)
          CPFX    = SPACE(14)
          CGCX    = SPACE(18)
          M_BAICL = SPACE(20)
          M_CEPCL = XY_CEP
          M_CIDACL= XY_CIDADE

          var_1=space(27)       //  Brancos a Direita
          var_1=len(var_1)
          var_2=Len(trim(m_cidacl))
          spce = var_1 - var_2
          m_cidacl=trim(m_cidacl)+space(spce)

          M_UFCL  = XY_UF
          M_BLO   = "N"
          M_RG    = SPACE(26)
          M_REFER = SPACE(60)
          M_REFER2= SPACE(60)
          M_OBSER = SPACE(40)
          M_SAIDA = SPACE(18)
          M_CGF   = SPACE(18)
          M_COMPLE= SPACE(20)
          M_NUMERO= SPACE(10)
       Else
          M_NOME  = CL_NOME
          M_BLO   = CL_BLOQ
          ENDEX   = CL_ENDE
          M_Numero:= Ret_Numeros(CL_NUMERO,10)
          M_COMPLE= CL_COMPLE
          CGCX    = CL_CGC
          CPFX    = CL_CPF
          M_BAICL = CL_BAIR
          M_CEPCL = CL_CEP
          M_CIDACL= CL_CIDA
          M_UFCL  = CL_UF
          M_REFER = CL_LOCE
          M_REFER2= Space(60)
          M_OBSER = Space(40)
          M_SAIDA = Space(18)
          M_RG    = CL_RG
          M_ANIV  = CL_ANIV
          If !Empty(CL_CGC)
             M_CGF  = CL_INSC
          Else
             M_CGF  = SPACE(18)
          Endif
       Endif
    Endif
    If !Empty(M_NOME)
       wReg = "s"
    Else
       wReg = "n"
    Endif
    TC=SAVESCREEN(04,15,24,79)
    While .t.
      SETCOLOR("w+/b")
      M_IBGE = Space(07)
      @ 10,20 to 22,79
      @ 11,21 clear to 21,78
      Set color to GR+/B
      @ 09,21 SAY "Dados do Cliente p/Emiss„o de Cupom Fiscal [F1]Help"
      @ 19,21 to 19,78
      Cor=setcolor()
      Setcolor("gr+/b")
      wHelp = "N"
      If wReg = "n"
         @ 11,21 SAY "Cliente "GET M_NOME PICT "@!S48"
         If M_PASSOUCL = 0    //  Nao Houve Conexao com a Matriz
            Read
         Endif
      Else
         @ 11,21 SAY "Cliente "+Substr(M_NOME,1,48)
      Endif
      If Lastkey() = 27
         Return
      Endif
      wSemIdentificacao = .f.
      If Empty(m_nome)
         If m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 4
            Alert("Por favor insira o nome do Cliente")
            Loop
         Else
            m_nome = "Consumidor final n„o identificado"
            wSemIdentificacao = .t.
            RESTSCREEN(04,15,24,79,TC)
         Endif
      Endif
      If wSemIdentificacao = .t.
         If m_tipo <> 1 .and. m_tipo <> 5
            Alert("Venda com Cliente sem Identifica‡„o so' a Vista !")
            Return
         Endif
      Endif

      @ 5,32 SAY STRZERO(M_CLIE,6) + " " + TRIM(M_NOME)

      wCpfError = .f.
      If Len(m_comple) = 0
         m_comple = Space(20)
      Endif
      If wSemIdentificacao = .f.
         While .t.
           @ 12,21 SAY "Endere‡o"GET ENDEX  PICT "@!S38"
           @ 12,68 SAY "Nr"GET M_NUMERO PICT "99999999"
           @ 13,21 SAY "Complemento de Endere‡o"GET M_COMPLE PICT "@!"
           @ 14,21 SAY "Bairro  "GET M_BAICL PICT "@!S20"
           @ 14,50 SAY "Cidade"GET M_CIDACL PICT "@!S17"
           @ 14,74 SAY "UF"GET M_UFCL PICT "@!"
           Read
           If Lastkey() = 27
              Return
           Endif
           If Empty(M_BAICL)
              M_BAICL = xy_Bairro
              @ 14,30 Say Trim(M_BAICL)
           Endif

           M_Numero:= Ret_Numeros(M_Numero,10)
           If !Empty(M_Comple)
              Alert("Obs: Utilize o Campo Complemento de Endere‡o para: APTO,BLOCO,CASA, etc !")
           Endif
           If !Empty(M_Nome) .and. (m_tipo <> 3)
               If Empty(m_ufcl)
                  Alert("Campo UF Vazio !")
                  Loop
               Endif
               If Empty(m_baicl)
                  Alert("Campo Bairro Vazio !")
                  Loop
               Endif
               If Empty(m_cidacl)
                  Alert("Campo Cidade Vazio !")
                  Loop
               Endif
           Endif
           Sele 14
           Veriout(setcolor(),23,"cidades")     && cadastro de cidades p/ fat COD_IBGE
           Go Top
           Set filter to nome = trim(m_cidacl) .and. uf=m_ufcl
           Go Top
           If Eof()
              Alert("Cidade N„o Encontrada: "+Trim(m_cidacl))
              Loop
           Endif

           PRIV VETOR1[2],VETOR2[2]
           VETOR1[1] ='NOME'
           VETOR1[2] ='UF'
           VETOR2[1] ='CIDADE'
           VETOR2[2] ='UF'
           mssv=savescreen(16,39,23,77)
           @ 16,39 TO 21,76 DOUBLE
           SETCOLOR("W+/BG+, B/RG,X")
           DBEDIT(17,40,20,75,VETOR1,,,VETOR2," ")
           Restscreen(16,39,23,77,mssv)
           M_IBGE  = COD_IBGE
           M_CIDACL= NOME
           M_UFCL  = UF
           If Lastkey() = 27
              Exit
           Endif
           If !Empty(CEP)
              M_CEPCL = CEP
           Endif
           setcolor(Cor)
           @ 14,57 SAY Substr(M_CIDACL,1,17)
           If m_tipo <> 3 .and. m_tipo <> 6
              If M_IBGE=SPACE(7)
                 Loop
              Else
                 Exit
              Endif
           Else
              Exit
           Endif
         Enddo

         Set Filter to
         If Empty(M_IBGE)
            Alert("Codigo do Municipio Errado !")
            Loop
         Endif
         If Len(alltrim(Fon1x)) < 2
            Fon1x = Space(15)
         Endif
         wOld_Cpf = CPFX
         If wHelp = "N"       // Nao Houve Consulta ao F1-Help da Loja
            If !Empty(CPFX)
                Sele 1           // Pega Telefones do Cadastro ,se tiver....
                Set Order to 4
                Seek CPFX
                If !Eof()
                   If !Empty(CL_FON1)
                      FON1X = CL_FON1
                   Endif
                   If !Empty(CL_OI)
                      FONECEL = CL_OI
                   ElseIf !Empty(CL_TIM)
                      FONECEL = CL_TIM
                   ElseIf !Empty(CL_CLARO)
                      FONECEL = CL_CLARO
                   ElseIf !Empty(CL_VIVO)
                      FONECEL = CL_VIVO
                   Endif
                Endif
            Endif
            If Empty(FONECEL)
               FONECEL = Space(11)
            Endif
            fon1x = Space(10)
          Endif

          Setcolor("gr+/b")
          @ 14,77 SAY M_UFCL
          @ 15,21 SAY "C.E.P   "   GET M_CEPCL PICT "99.999-999"
          @ 15,50 SAY "Fone (Fixo)"GET FON1X   PICT "@R (99)9999-9999"
          @ 16,50 SAY "Fone (Cel) "GET FONECEL PICT "@R (99)99999-9999"
          If wCpfError = .f.
             If M_PASSOUCL = 0 .and. !Empty(m_nome) .and. !Empty(wOld_Cpf)
                wReg = "s"
             Else
                wCpfError = .t.
             Endif
          Endif
          If wReg = "n" .and. wCpfError = .t.
             @ 17,21 SAY "C.P.F   "GET CPFX PICT "999.999.999-99"
             @ 18,21 SAY "R.G     "GET M_RG PICT "@!S14"
             @ 17,50 SAY "C.N.P.J "GET CGCX PICT "99.999.999/9999-99"
             @ 18,50 SAY "I.EST"GET M_CGF   PICT "@!"
          Else
             @ 17,21 SAY "C.P.F: "+Trim(CPFX)+" R.G: "+Trim(M_RG)
             @ 18,21 SAY "C.N.P.J: "+Trim(CGCX)+" I.EST: "+Trim(M_CGF)
          Endif
          *@ 20,21 SAY "N§ S‚rie"GET M_OBSER PICT "@!S35"
          *@ 21,21 SAY "N§ de IMEI Celular "GET M_IMEI[&M]
          Read

          wNumerosCpf  := Ret_Numeros(cpfx,0)
          wNumerosCnpJ := Ret_Numeros(cgcx,0)
          If ((m_tipo = 3 .and. !Empty(m_nome)) .and. (Empty(wNumerosCpf) .and.  Empty(wNumerosCnpJ)))
             Alert("Favor inserir CPF ou CNPJ")
             Loop
          Endif
          Release wNumerosCpf,wNumerosCnpJ

          wNumCep :=CharOnly("0123456789",m_cepcl)
          If Len(wNumCep) < 8
             Alert("Cep Errado, Favor Corrigir")
             Release wNumCep
             Loop
          Endif
          Release wNumCep

          If Empty(wOld_Cpf) .and. !Empty(CPFX)   // Novo Cliente
             Sele 25
             Set Order to 3
             Seek cpfx
             If !Eof()
                 Alert("********   Cliente Ja Consta no Cadastro    ******* "+"Cliente : "+Trim(cd_nomecl)+"               Endereco: "+Trim(cd_ende)+", "+Trim(cd_numero)+" "+;
                 "Cidade: "+Trim(cd_cida)+" UF: "+Trim(cd_uf))
             Endif
          Endif
          If wReg = "n" .and. (M_Tipo <> 2 .and. M_Tipo <> 3 .and. M_Tipo <> 6)
             If (Empty(CGCX) .or. CGCX = "  .   .   /    -  ") .and. (!Empty(Cpfx))
                Sele 1
                Set Order to 4
                Seek Cpfx
                If !Eof()
                    Alert("CPF Ja Cadastrado, Cliente : "+StrZero(cl_codi,6))
                    M_CLIE  = CL_CODI
                    M_NOME  = CL_NOME
                    M_BLO   = CL_BLOQ
                    ENDEX   = CL_ENDE
                    M_Numero:= Ret_Numeros(CL_NUMERO,10)
                    M_COMPLE= CL_COMPLE
                    CGCX    = CL_CGC
                    CPFX    = CL_CPF
                    M_BAICL = CL_BAIR
                    M_CEPCL = CL_CEP
                    M_CIDACL= CL_CIDA
                    M_UFCL  = CL_UF
                    M_REFER = CL_LOCE
                    CGCX    = CL_CGC
                    M_RG    = CL_RG
                    If !Empty(CL_CGC)
                       M_CGF  = CL_INSC
                    Endif
                    Setcolor("w+/b")
                    @ 11,30 Say Substr(M_NOME,1,38)
                    @ 12,30 Say Substr(ENDEX,1,38)
                    @ 12,71 SaY M_NUMERO PICT "99999999"
                    @ 13,45 Say M_COMPLE PICT "@!"
                    @ 14,30 Say Substr(M_BAICL,1,20)
                    @ 14,57 Say Substr(M_CIDACL,1,16)
                    @ 14,77 Say M_UFCL PICT "@!"
                    @ 18,30 Say M_RG
                    @ 17,59 Say CGCX PICT "99.999.999/9999-99"
                    @ 18,56 Say M_CGF PICT "@!"
                    Inkey(0)
                   *Loop
                Endif
             Endif
          Endif

          cor=setcolor()
          fon1x := Ret_Numeros(fon1x,0)
          If !Empty(fon1x)
             wSt := Ret_StFone(fon1x,"F")     // Funcoes.prg
             If wSt = .f.
                Alert("Telefone Incorreto. Favor Corrigir !")
                Loop
             Endif
          Endif
          If !Empty(fonecel)
             wSt := Ret_StFone(fonecel,"C")     // Funcoes.prg
             If wSt = .f.
                Alert("Telefone Incorreto. Favor Corrigir !")
                Loop
             Endif
             If Substr(FONECEL,3,1) <> "9"
                Alert("Este N§ N„o ‚ de Celular; Verifique ! ")
                Loop
             Endif
          Endif

          var_1=space(40)       //  Brancos a Direita
          var_1=len(var_1)
          var_2=Len(trim(endex))
          spce = var_1 - var_2
          wEndTrega=trim(endex)+space(spce)

          wNumero  = m_numero
          wComple  = m_comple

          var_1=space(27)
          var_1=len(var_1)
          var_2=Len(trim(m_cidacl))
          spce = var_1 - var_2
          wCidaTrega=trim(m_cidacl)+space(spce)

          var_1=space(20)
          var_1=len(var_1)
          var_2=Len(trim(m_baicl))
          spce = var_1 - var_2
          wBairTrega=trim(m_baicl)+space(spce)

          wCepTrega = M_CEPCL
          wUFTrega  = M_UFCL
          Release var_1,var_2,spce
          RestScreen(04,15,24,79,TC)
          If Lastkey()=27
             Return
          Endif

          acgc = SUBS(CGCX,1,2)+SUBS(CGCX,4,3)+SUBS(CGCX,8,3)+SUBS(CGCX,12,4)+SUBS(CGCX,17,2)
          acpf = substr(cpfx,1,3)+substr(cpfx,5,3)+substr(cpfx,9,3)+substr(cpfx,13,2)

          If Val(acgc) > 0 .and. Val(acpf) > 0
             Alert("Registro Recusado. Use CGC ou CPF ou Nenhum !")
             Loop
          Endif

          If Val(acgc) >0
             If Len(alltrim(acgc)) < 14
                Alert("C.N.P.J Incompleto !")
                wCpfError = .t.
                wReg      = "n"
                M_PASSOUCL = 1
                Loop
             Else
                wCpfError = .f.
             Endif
             CNPJ(acgc)
             If Res_CNPJ = "EOF"
                wCpfError = .t.
                wReg      = "n"
                M_PASSOUCL = 1
                Loop
             Else
                wCpfError = .f.
             Endif
          Else
             If m_tipo = 10
                Alert("Venda com Boleto somente para Pessoa Juridica !")
                Loop
             Endif
          Endif

          If val(acpf) >0
             If Len(alltrim(acpf)) < 11
                Alert("C.P.F. Incompleto !")
                wCpfError = .t.
                wReg      = "n"
                M_PASSOUCL = 1
                Loop
             Else
                wCpfError = .f.
             Endif

             Ver_Cpf(acpf)
             If Res_Cpf = "EOF"
                wCpfError = .t.
                wReg      = "n"
                M_PASSOUCL = 1
                Loop
             Else
                wCpfError = .f.
             Endif
          Endif

          If m_tipo <> 3 .and. m_tipo <> 6
             If M_UFCL <> XY_UF
                 Alert("Aviso! Unidade Federal de Outro Estado. Confirma ? ")
             Endif
             If Empty(M_NOME)
                 Alert("Registro Recusado. Campo Nome Vazio !")
                 Loop
             Endif
             If Empty(ENDEX)
               *Alert("Registro Recusado. Campo Endereco Vazio !")
               *Loop
             Endif
          Endif

          m_nome  = remove_ac(m_nome)
          endex   = remove_ac(endex)
          m_baicl = remove_ac(m_baicl)
          m_refer = remove_ac(m_refer)
          m_refer2= remove_ac(m_refer2)

          If Month(M_ANIV) = Month(M_DATSI)
             If SUBSTR(DTOC(M_ANIV),1,5) = SUBSTR(DTOC(M_DATSI),1,5)
                Alert("Feliz Anivers rio, "+Trim(m_nome)+" !")
             Else
                If SUBSTR(DTOC(M_ANIV),1,5) > SUBSTR(DTOC(M_DATSI),1,5)
                    Alert(Trim(m_nome)+"; Seu Anivers rio Est  Chegando: "+SUBSTR(DTOC(M_ANIV),1,5))
                Endif
             Endif
          Endif

          wRetCampo:= VCampoCPFCNPJ(cgcx,cpfx,m_cgf)
          If wRetCampo = .t.
             Alert("Campo CPF/CNPJ/CGF Inv lido !")
             Loop
          Endif
          If !Empty(M_IMEI[&M])
             Sele 44
             Set Order to 1
             Seek m_imei[&M]
             If Eof()
                Alert("Imei N„o Cadastrado !")
                Loop
             Else
                M_COD[&M] = CEL_CODI
                wSt := ValidarImei(M_COD[&M],M_IMEI[&M])
                If wSt = .f.
                   Release wSt
                   Loop
                Endif
                Release wSt
             Endif
             M_CODIMEI=CEL_CODI
          Endif
          If m_imei[&M]="999999999999999"
             UCOR=SETCOLOR()
             TELA_S1=SAVESCREEN(6,1,23,78)
             SET CURSOR ON
             ger=savescreen(17,26,22,50)
             SET COLOR TO W+/W
             @ 17,26 clear to 22,50
             @ 17,26,22,50 BOX B_SINGLE
             SET COLOR TO N/W
             m_senhger=space(15)
             @ 17,26 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
             @ 18,26 Say "³ Auditoria"
             @ 19,26 Say "³"
             @ 20,26 Say "³ Senha de Acesso"
             @ 21,26 Say "³ "
             @ 22,26 Say "À"
             COR=SETCOLOR()
             SETCOLOR(C_CORS)
             @ 21,28 get m_senhger pict "@!"
             Read
             SETCOLOR(COR)
             If Trim(M_Nomeusu) <> "AUDITORIA" .or. Trim(Lojau) <> "AUDITORIA" .or. M_SENHGER <> Trim(m_Acesso)
                 Alert("Acesso Recusado !")
                 Return
             Endif
          Endif
       Endif
       W_IMEI = M_IMEI[&m]
       Exit
    Enddo

    If wSemIdentificacao = .f.

       If m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 5 .or. m_tipo = 10
          If Empty(M_IBGE)
             Alert("Codigo do Municipio Errado. Verifique o nome da Cidade !")
             Loop
          Endif
       Endif
       RestScreen(04,15,24,79,TC)
       Release tc

       wwEntr=savescreen(10,01,18,78)
       cor=setcolor()
       Set color to GR+/B
       @ 10,15 SAY "Endere‡o de Entrega do Cliente"
       @ 11,01 clear to 18,78
       @ 11,01 to 18,78
       Set color to GR+/B
       @ 15,02 to 15,77
       SETCOLOR("w+/b")
       While .t.
          @ 12,02 SAY "Endere‡o de Entrega    "GET wEndTrega PICT "@!"
          @ 12,67 SAY "Nr"GET wNumero PICT "99999999"
          @ 13,02 SAY "Complemento de Endere‡o"GET wComple PICT "@!"
          @ 13,47 SAY "Bairro"GET wBairTrega PICT "@!"
          @ 14,02 SAY "Cidade                 "GET wCidaTrega PICT "@!S17"
          @ 14,47 SAY "UF    "GET wUFTrega PICT "@!"
          @ 16,02 SAY "Ponto Ref(1)"GET M_REFER  PICT "@!S47"
          @ 17,02 SAY "Ponto Ref(2)"GET M_REFER2 PICT "@!S47"
          Read
          wNumero := Ret_Numeros(wNumero,10)
          If !Empty(wComple)
             Alert("Obs: Utilize o Campo Complemento de Endere‡o para: APTO,BLOCO,CASA, etc !")
          Endif
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
             Sele 14
             Go Top
             Set filter to nome = Trim(wCidaTrega) .and. uf= wUFtrega
             Go Top
             PRIV VETOR1[2],VETOR2[2]
             VETOR1[1] ='NOME'
             VETOR1[2] ='UF'
             VETOR2[1] ='CIDADE'
             VETOR2[2] ='UF'
             mssv=savescreen(18,42,24,79)
             @ 18,42 TO 23,78 DOUBLE
             SETCOLOR("W+/BG+, B/RG,X")
             DBEDIT(19,43,22,77,VETOR1,,,VETOR2," ")
             restscreen(18,42,24,79,mssv)
             wIbgeTrega= COD_IBGE
             wCidaTrega= NOME
             wUFtrega  = UF
             If Empty(wCepTrega)
                wCepTrega = CEP
             Endif
 
             SETCOLOR("w+/b")
             @ 14,59 SAY "C.E.P   "GET wCepTrega PICT "99.999-999"
             Read
             wNumCep :=CharOnly("0123456789",wCepTrega)
             If Len(wNumCep) < 8
                Alert("Cep Errado, Favor Corrigir")
                Release wNumCep
                Loop
             Endif
             Release wNumCep
 
             If Lastkey() = 27
                Exit
             Endif
             Setcolor(Cor)
             If Empty(wIbgeTrega)
                Alert("Codigo do Municipio Errado. Verifique o nome da Cidade !")
                Loop
             Endif
          Endif
          wModif = "n"
          If Substr(wEndTrega,1,40) <> Substr(Endex,1,40)
             wModif = "s"
          Endif
          If Substr(wBairTrega,1,20) <> Substr(m_baicl,1,20)
             wModif = "s"
          Endif
          If Substr(wCidaTrega,1,27) <> Substr(m_cidacl,1,27)
              wModif = "s"
          Endif
          If Substr(wUFTrega,1,2) <> Substr(m_ufcl,1,2)
             wModif = "s"
          Endif
          If wModif = "s"
             nResp = 1
             Set color to GR+/B
             @ 18,20 Say "O Endere‡o de Entrega Foi Modificado ! "
             setcolor(cor)
             @ 19,30 prom "Confirma"
             @ 19,41 prom "Retorna"
             Menu to nResp
             @ 18,20 clear to 19,60
             If nResp = 2
                Loop
             Else
                Exit
             Endif
          Else
             nResp = 1
             Set color to GR+/B
             @ 18,20 Say "O Endere‡o de Entrega Ser  o Mesmo ? "
             setcolor(cor)
             @ 19,30 prom "Confirma"
             @ 19,41 prom "Retorna"
             Menu to nResp
             @ 18,20 clear to 19,60
             If nResp = 2
                Loop
             Else
                Exit
             Endif
          Endif
          Release wModif,nResp
          Exit
       Enddo
       Setcolor(cor)
       Restscreen(10,01,18,78,wwEntr)
       Release wwentr

       Setcolor("gr+/b")
       @ 5,32 SAY STRZERO(M_CLIE,6) + " " + TRIM(M_NOME)
       If M_TIPO = 3 .or. M_TIPO = 6
          If M_Clie >0 .and. M_Blo <> "N"
             M_X = SAVESCREEN(09,00,14,69)
             COR=SETCOLOR()
             SETCOLOR("W+/R+")
             SOMBRA(10,20,13,62,BOX)
             @ 11,22 SAY 'Venda Bloqueada P/ Este Cliente !'
             @ 12,22 SAY " Por Favor Consulte o Credi rio"
    
             SETCOLOR(COR)
             TEC = INKEY()
             While TEC <> 13
               TEC = INKEY(0)
             Enddo
             IF TEC = 13
                Restscreen(09,00,14,69,M_X)
                Loop
             Endif
          Endif
       Endif
    Endif

  // Inicio das Vendas  //
  While .t.
    M_VEND = 0
    SetColor("gr+/b")
    @ 6,12 clear to 06,77
    @ 6,12 GET M_VEND PICT "999" VALID M_VEND > 0
    READ
    IF LASTKEY()=27
       Return
    Endif
    Sele 16
    Set Order to 1
    Seek Str(M_VEND,3,0)
    IF Eof()
       Alert("Vendedor N„o Cadastrado. Verifique !")
       Loop
    Else
       If Ba_Ativ<>"S"
          Alert("Vendedor Desativado! Verifque.")
          Loop
       Endif
       If Trim(Ba_Setor) = "GERENT"
          Alert("Vendedor N„o Autorizado ! Verifque.")
          Loop
       Endif
       If Trim(Ba_Nome) = "ATACADO"
          V_CPF  = XY_CGC
       ElseIf Trim(Ba_Nome) <> "ATACADO" .and. Empty(ba_cpf)
          Alert("Vendedor Sem CPF ! Verifque.")
          Loop
       Endif
       V_NOME = BA_NOME
       V_CPF  = BA_CPF
       @ 6,12 SAY STRZERO(BA_CODI,3) + "  " + BA_NOME
       Exit
    Endif
  Enddo

  VdNaprov(m_vend,m_datsi,"smv09")    // Orca.prg

  If Trim(V_NOME) <> "ATACADO"
     Efc := Efic_Vnd(m_vend)
     Alert("Eficiˆncia de Venda, Gar Estendida "+Str(Efc,6,2)+"%")
     If efc < 3
        Alert("Eficiˆncia Baixa !!!")
     Endif
     Release Efc
  Endif

  SetColor("w+/b")
  CONTINUA = "S"
  LIN      = 9
  PROCES   = 2
  M_CONT   = "S"
  m_passcel= "N"
  Priv Vetor := {}

  Stor 0 to M_SQTD,M_TCOM,M_SPRD,M_T,T_Garant,w_ttgaran,t_plav
  Stor 0 to M_NOTA,M_CONTR,B_CONTR,C_CONTR,FLAG,wOpcao

  @ 22,01 clear to 22,78
  @ 22,16 SAY "Comiss„o R$"
  While M_CONT = "S"
    Stor 0 to M_PRCP,M_PRECO,M_DESC,M_PE,M_COD[&M],M_DE[&M],M_AC[&M],M_AUTOR[&M],M_VEZES[&M],m_vezesci[&m]
    Stor 0 to m_frt,m_mon,m_txab,w_garant[&m],w_plano[&m],M_GRFATOR[&m],w_tx_cc,w_plav[&m]
    W_GR = "N"
    Stor 1 to M_QTD[&M],M_COM[&M]
    Stor space(1) to M_COR[&M],M_PRD[&M]

    Cor=SETCOLOR()
    SETCOLOR("W+/BG+, B/RG,X")
    @ 08,07 Say "C¢digo´"
    SETCOLOR(Cor)

    If (m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 4 .or. m_tipo = 5 .or. m_tipo = 6 .or. m_tipo = 8 .or. m_tipo = 9 .or. m_tipo = 10) .and. (m_plm = 2)
       m_vezes[&m] = m_vezespl
    Endif
    If m_codimei <> 0
       keyb(chr(13))
    Endif
    @ LIN,1 GET M_QTD[&M] PICT "99999" VALID M_QTD[&M] > 0
    Read
    If LASTKEY() = 27
       IF PROCES=1
          nResp:=Alert( "Processa Or‡amento ?", {"Sim ","N„o "})
       Else
          nResp:=Alert( "Abandona Opera‡„o ?", {"Sim ","N„o "})
       Endif
       If nResp = 1
          If PROCES = 1
             CONTINUA = "S"
             M_TOTS   = "S"
             EXIT
          Endif
          CONTINUA = "N"
          M_TOTS   = "N"
          M_AJUST  = "S"
          EXIT
       Else
          If PROCES  = 1
             M_CONT  ="S"
             M_TOTS  ="S"
             CONTINUA="S"
             PROCES  = 2
          Endif
          Loop
       Endif
     Endif
     IF M_QTD[&M] = 0
        M_TOTS   = "N"
        CONTINUA = "N"
        EXIT
     Endif
      If m_codimei <> 0
         M_CO = M_CODIMEI
         *keyb(chr(13))
      Else
         M_CO = 0
      Endif

      stelcod=savescreen(lin,7,lin,70)
      M_EAN = Space(13)
      wCodigo = Space(13)

      @ LIN,7 GET wCodigo PICT "9999999999999"
      Read
      If Len(Alltrim(wCodigo)) > 6
         M_CO = 0
         M_EAN = wCodigo
      Else
         M_CO = Val(wCodigo)
      Endif

      M_COD[&M] = M_CO
      If Lastkey() = 27
         m_codimei = 0
         Loop
      Endif
      Sele 3
      If M_COD[&M] > 0
         Set Order to 1
         Go Top
         Seek M_COD[&M]
      Else
         Set Order to 13
         Go Top
         Seek M_EAN
         Cor=SETCOLOR()
         SETCOLOR("W+/BG+, B/RG,X")
         @ 08,07 Say "C¢digo´"
         SETCOLOR(Cor)
      Endif
      IF Eof()
         Alert("Produto N„o Cadastrado. Verifique !")
         Restscreen(lin,7,lin,70,stelcod)
         Release stelcod
         Loop
      Else
         If M_COD[&M] = 0
            If !Empty(M_EAN)
               M_COD[&M] = CD_CODI
            Else
               Restscreen(lin,7,lin,70,stelcod)
               Loop
            Endif
         Endif
      Endif
      wComponente = 0
      If cd_compob >0                // Verifica se tem Componentes
         wComponente= cd_compob
      Endif

      If M_COD[&M] <= 4
         Alert("Venda de Cursos On Line Suspensa !")
         Restscreen(lin,7,lin,70,stelcod)
         Loop
      Endif
      If Empty(cd_prodf)
         Alert("Venda Recusada. Nome Fiscal do Produto Vazio !")
         Restscreen(lin,7,lin,70,stelcod)
         Loop
      Endif
      If cd_compo >0
         Alert("Venda Recusada. Componente !")
         Restscreen(lin,7,lin,70,stelcod)
         Loop
      Endif
      If cd_cust <=0
         Alert("Produto Com Custo Zerado. Comunique CPD !")
         Restscreen(lin,7,lin,70,stelcod)
         Loop
      Endif
      If M_COD[&M] >0 .and. M_COD[&M] <= 5 .and. M_QTD[&M] >1
         M_QTD[&M] = 1
         @ LIN,1 Say M_QTD[&M] PICT "99999"
      Endif

      M_PRD[&M] = CD_PROD
      M_MESES   = CD_GR

      SETCOLOR("W+/B")
      @ LIN,07 SAY STRZERO(M_COD[&M],6)+" "+SUBSTR(CD_PROD,1,24)+" "+SUBSTR(CD_COR,1,5)

      M_QUANT   = M_QTD[&M]
      M_PROMO   = CD_PROMO
      M_PROD    = CD_PROD
      M_CUSTO   = CD_CUST
      M_GRUPO   = CD_GRUP
      M_GRUP    = CD_GRUP
      M_SBGRUPO = CD_SBGRUP
      M_COR[&M] = SUBSTR(CD_COR,1,7)
      TXM       = CD_TXM                // Taxa de Montagem
      M_PRZ     = CD_VEND
      M_VRZ     = CD_VEZES
      W_faixap  = CD_FAIXAP
      M_AVISTA  = CD_AVISTA2
      M_VENDA   = CD_AVISTA2
      M_PRAUX   = CD_AVISTA2
      M_PRECO   = CD_AVISTA2
      M_FL      = CD_FL

      If CD_TABELA <> "S"
         nResp:=0
         nResp:=Alert( "Produto Fora da Tabela", {"Libera ","Cancela "})
         If nResp <> 1
            Nega(23)
            SetColor(COR)
            Restscreen(lin,7,lin,70,stelcod)
            Loop
         Endif
         COR=SETCOLOR()
         SENHX=SPACE(15)
         SETCOLOR(C_CORG)
         SOMBRA(13,13,15,40,BOX)
         SETCOLOR("BG+/B+")
         @14,14 SAY 'Digite sua senha:'
         SET COLOR TO W/br, X
         @14,32 GET SENHX  PICT '@!S8'
         READ
         If SENHX<>M_NOMEUSU
            Nega(23)
            SetColor(COR)
            Restscreen(lin,7,lin,70,stelcod)
            Loop
         Else
            SetColor(COR)
         Endif
      Endif

      // Seguro Roubo e Furto
      wSeguro = .f.
      If(At("NOTEBOOK",M_PROD)) > 0
         wSeguro = .t.
      Endif
      If(At("CEL.",M_PROD)) > 0
         If m_grup = 8
            wSeguro = .t.
         Endif
      Endif
      If(At("CELULAR",M_PROD)) > 0
         If m_grup = 8
            wSeguro = .t.
         Endif
      Endif

      // Promocao de 5% para as Lojas por Supervisor Joaozinho em 23/08/2022
      // Em siste.prg empresa.dbf config_emp()
      If wDescontoFilialSup = .T.
         M_AVISTA = M_AVISTA - ((CD_AVISTA2 * wPercentPromo)/ 100)
         M_VENDA  = M_AVISTA
         M_PRAUX  = M_AVISTA
         M_PRECO  = M_AVISTA
         Stor wPercentPromo to I_DESCAVEL,I_DESCAVMO,I_DCELECAP,I_DCELEINT
         Stor wPercentPromo to I_DCMOVINT,I_DCELECAP,I_DCCARNE,I_DCMOVCAP,I_DCCHEQUE
      ElseIf wDescontoFilialSup = .F.
         If Loja = 9 .and. m_datsi >= ctod("23/01/2023") .and. m_datsi <= ctod("31/03/2023")
            If m_grupo = 1 .or. m_grupo = 2 .or. m_grupo = 3 .or. m_grupo = 4 .or. m_grupo = 16
               M_AVISTA = M_AVISTA - ((CD_AVISTA2 * 5)/ 100)
               M_VENDA  = M_AVISTA
               M_PRAUX  = M_AVISTA
               M_PRECO  = M_AVISTA
               Stor 5 to I_DESCAVEL,I_DESCAVMO,I_DCELECAP,I_DCELEINT,I_DCCHEQUE
               Stor 5 to I_DCMOVINT,I_DCELECAP,I_DCCARNE,I_DCMOVCAP
            Endif
            // joaozinho para re-inauguracao da Loja em 23/01/2023
         Endif
      Endif

      If wSemIdentificacao = .T.      // Nao Permitir outros Deptos sem cadastro de cliente
         If m_grupo <> 6 .and. m_grupo <> 15 .and. m_grupo <> 18 .and. m_grupo <> 19
            Alert("Para esse Produto,se faz necess rio o Pr‚-Cadastro do Cliente")
            Loop
         Endif
      Endif
      If W_faixap = 32 .or. w_faixap = 33     // Linha Infantil, Nao Vender mais (Michelle 27/10/2022)
         W_faixap = 0
      Endif

      If Val(acgc) >0    // Garantia Estendida so para P.Fisica
         W_faixap = 0
      Endif
      If Trim(V_NOME) = "ATACADO"
         W_faixap = 0
      Endif
      If (W_Faixap >0 .and. M_MESES > 12) .and. (M_SBGRUPO=8 .or. M_SBGRUPO=304)
         W_faixap = 0                   // Colchoes e cama box acima de 12 meses
      Endif
      If wSemIdentificacao = .T.        // Garantia Precisa do Cadastro
         W_faixap = 0
      Endif
      Stor 0 to w_garant_12,w_garant_24,w_garant_36
      If W_Faixap >0 .and. M_MESES > 0
         W_Gr = "S"
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
              If m_grup <> 4 .and. m_grup <> 6 .and. m_grup <> 18 .and. m_grup <> 19
                 If M_AVISTA >= DE .and. M_AVISTA <= ATE .and. plano = 36 .and. M_MESES <= 12
                    w_garant_36 = premio_tot
                 Endif
              Endif
           Endif
           Skip
         Enddo
         Use
         If w_faixap = 34
            If w_garant_24 >0 .and. M_AVISTA <= xy_vrtroca .AND. M_MESES < 24
               cor=setcolor()
               grsbs=savescreen(11,30,17,67)
               setcolor("w+/b")
               @ 11,30 Say "Garantia Estendida"
               setcolor("gr+/b")
               Sombra(12,30,15,65,Box)
               @ 13,31 Say "Troca Garantida 24 Meses: "+str(w_garant_24,7,2)
               @ 14,31 Say "                12 Meses: "+str(w_garant_12,7,2)
               Inkey(0)
               setcolor(cor)
               Restscreen(11,30,17,67,grsbs)
               Release grsbs
            ElseIf w_garant_24 >0 .AND. M_MESES < 24
               cor=setcolor()
               grsbs=savescreen(11,30,17,57)
               setcolor("w+/b")
               @ 11,30 Say "Garantia Estendida"
               setcolor("gr+/b")
               Sombra(12,30,15,55,Box)
               @ 13,31 Say "      24 Meses: "+str(w_garant_24,7,2)
               @ 14,31 Say "      12 Meses: "+str(w_garant_12,7,2)
               Inkey(0)
               setcolor(cor)
               Restscreen(11,30,17,57,grsbs)
               Release grsbs
            Else
               If M_AVISTA <= xy_vrtroca
                  cor=setcolor()
                  grsbs=savescreen(11,30,13,67)
                  setcolor("w+/b")
                  @ 11,30 Say "Garantia Estendida"
                  setcolor("gr+/b")
                  Sombra(12,30,14,65,Box)
                  @ 13,31 Say "Troca Garantida 12 Meses: "+str(w_garant_12,7,2)
                  Inkey(0)
                  setcolor(cor)
                  Restscreen(11,30,17,67,grsbs)
                  Release grsbs
               Endif
            Endif
         Else
            If w_garant_36 >0 .AND. M_MESES <= 12
               cor=setcolor()
               grsbs=savescreen(11,30,17,57)
               setcolor("w+/b")
               @ 11,30 Say "Garantia Estendida"
               setcolor("gr+/b")
               Sombra(12,30,16,55,Box)
               @ 13,31 Say "Plano 36 Meses: "+str(w_garant_36,7,2)
               @ 14,31 Say "      24 Meses: "+str(w_garant_24,7,2)
               @ 15,31 Say "      12 Meses: "+str(w_garant_12,7,2)
               Inkey(0)
               setcolor(cor)
               Restscreen(11,30,17,57,grsbs)
               Release grsbs
            ElseIf w_garant_24 >0 .AND. M_MESES < 24
               cor=setcolor()
               grsbs=savescreen(11,30,17,57)
               setcolor("w+/b")
               @ 11,30 Say "Garantia Estendida"
               setcolor("gr+/b")
               Sombra(12,30,15,55,Box)
               @ 13,31 Say "      24 Meses: "+str(w_garant_24,7,2)
               @ 14,31 Say "      12 Meses: "+str(w_garant_12,7,2)
               Inkey(0)
               setcolor(cor)
               Restscreen(11,30,17,57,grsbs)
               Release grsbs
            ElseIf M_MESES >0
               w_garant_24 = 0
               w_garant_36 = 0
               cor=setcolor()
               grsbs=savescreen(11,30,17,57)
               setcolor("w+/b")
               @ 11,30 Say "Garantia Estendida"
               setcolor("gr+/b")
               Sombra(12,30,14,55,Box)
               @ 13,31 Say "Plano 12 Meses: "+str(w_garant_12,7,2)
               Inkey(0)
               setcolor(cor)
               Restscreen(11,30,17,57,grsbs)
               Release grsbs
            Else
               Stor 0 to w_garant_12,w_garant_24,w_garant_36
            Endif
         Endif
      Endif

      Sele 3
      Set Order to 1
      If (Substr(M_PROD,1,6) = "TABLET") .or. (M_Grupo = 8 .and. substr(M_PROD,1,4) <> "CHIP" .and. substr(M_PROD,1,4) <> "CART")    // Celulares
         If Empty(M_IMEI[&M])
            If substr(M_PROD,1,4) <> "CHIP" .and. substr(M_PROD,1,4) <> "CART"
               M_IMEI[&M] := retIMei(M_COD[&M])                   // funcoes.prg
               If !Empty(M_IMEI[&M])
                  wSt := ValidarImei(M_COD[&M],M_IMEI[&M])
                  If wSt = .f.
                     M_IMEI[&M] = Space(15)
                     Release wSt,telimei
                     Loop
                  Endif
                  Release wSt,telimei
               Else
                  If m_grupo = 8
                     Alert("Produto sem IMEI. Verifique !")
                     Loop
                  Endif
               Endif
            Endif
         Else
            If m = "01" .and. !Empty(w_imei)
               wConsultaimei = .f.
            Else
               wConsultaimei = .t.
            Endif
            If wConsultaimei = .t.
               M_IMEI[&M] := retIMei(M_COD[&M])                   // funcoes.prg
               If !Empty(M_IMEI[&M])
                  wSt := ValidarImei(M_COD[&M],M_IMEI[&M])
                  If wSt = .f.
                     M_IMEI[&M] = Space(15)
                     Release wSt,telimei
                     Loop
                  Endif
                  Release wSt,telimei
               Else
                  Loop
               Endif
            Endif
         Endif
         Sele 3
         Set Order to 1
      Endif

      //  Verificando Numero de Serie dos Produtos
      wnSerie[&M] := retnSerie(M_COD[&M])                   // funcoes.prg
      If !Empty(wnSerie[&M])
         wSt := ValidarnSerie(M_COD[&M],wnSerie[&M])
         If wSt = .f.
            wnSerie[&M] = Space(20)
            Release wSt
            Loop
         Endif
         Release wSt
      Else
         If m_grupo = 7
            If Empty(M_IMEI[&M])
               Alert("Produto sem N§ S‚rie. Verifique !")
            Endif
         Endif
      Endif

      W_Chip = "N"
      If M_Grupo = 8 .and. substr(M_PROD,1,4) = "CHIP"
         W_Chip = "S"
         Stor 0 to w_garant_12,w_garant_24,w_garant_36
      Endif

      M_COM[&M] = 0
      Sele 26
      Veriout(setcolor(),23,"comissoes")       // Comissoes de Vendas Por Grupo
      Go Top
      While !Eof()
        If GR_CODI = M_Grupo .and. GR_COMI >0
           M_COM[&M] = GR_COMI
           Exit
        Endif
        Skip
      Enddo
      Use

      wEletri = .f.
      wCom = 0
      RetornaEletr(M_SBGRUPO,@wCom,"")   // Retorna eletrinho
      If wCom > 0
         wEletri = .t.
         If M_MESES > 12
            Alert("Venda de Garantia p/ Eletrinhos ate 12 Meses do Fabricante !")
            Stor 0 to w_garant_12,w_garant_24,w_garant_36,w_faixap
         Endif
         M_COM[&M] = wCom
      Endif
      If Substr(m_prod,1,6) = "E-BOOK"
         M_COM[&M] = 5                    // 5% Comissoes separada !
      Else
         // Comissoes Dobradas para FL
         If M_Datsi >= XY_IniFLinha .and. M_Datsi <= XY_FimFLinha
            If m_FL = "FL"
               m_com[&m] = m_com[&m] * 2
            Endif
         Endif
      Endif
      If M_COM[&M] <= 0
         Alert("Comissao Zerada. Favor Informar ao T.I.")
         Restscreen(lin,7,lin,70,stelcod)
         Loop
      Endif

     Set color to b+/w
     w_passci = "n"
     m_passci = "n"

     Sele 57
     Set Order to 1
     If Empty(ordsetfocus())                && refere-se ao indice aberto
        Sele 57
        Veriout(setcolor(),23,"circcpd")    && Circulares do CPD
        Set index to index_circcpd
        Sele 57
        Set Order to 1
     Endif
     Seek Str(m_cod[&m],6,0)
     While !Eof() .and. ci_codigo = m_cod[&m]
       If ci_datini <= m_datsi .and. ci_datlimi >= m_datsi
          m_passci = "s"
          w_passci = "s"
          Exit
       Endif
       Skip
     Enddo
     m_prcprom = 1
     If ((m_tipo = 5 .and. m_debcc = 1) .and. (m_passci = "s"))
        mprcp=savescreen(10,20,14,40)
        SETCOLOR("bg/gr")
        Sombra(10,20,14,38,box)
        @ 11,21 prom "Promo‡„o a Vista"
        @ 12,21 prom "Promo‡„o a Prazo"
        @ 13,21 prom "Fora da Promo‡„o"
        Menu to m_prcprom
        restscreen(10,20,14,40,mprcp)
        If Lastkey()= 27
           Loop
        Endif
     Endif
     Stor 0 to m_Vrplano[&m]

     wPromocaoAvistaCMB = .f.
     If m_passci = "s"                        && circcpd.dbf
        m_datcirc = ctod("  /  /    ")
        Stor 0 to m_numcirca,m_vrcirca,m_numcircp,m_vrcircp
        Set Filter to ci_codigo = m_cod[&m] .and. m_datsi >= ci_datini .and. m_datsi <= ci_datlimi
        Go Top
        If !Eof()
           ssor=savescreen(13,02,21,77)
           SETCOLOR(MENU)
           PRIV VETOR1[8],VETOR2[8]
           VETOR1[1]='CI_CODIGO'
           w_psdeb = "n"

           If ((m_tipo = 3) .and. (m_grupo = 18 .or. m_grupo = 19))
              VETOR1[2]= "CI_XAV"
              VETOR1[3]= "CI_AVISTA"
              m_vezesci[&m] = ci_xav
              m_prcprom = 1
              If CI_AVISTA >0
                 wPromocaoAvistaCMB = .t.
              Endif
           Endif

           If (m_tipo = 5 .and. (m_debcc <>1 .and. m_debcc <> 2 ))   // Em ate 5 vzs s/juros
              If m_debcc = 3            //  1 vz
                 If CI_XAV = 1
                    VETOR1[2]= "CI_XAV"
                    VETOR1[3]= "CI_AVISTA"
                    w_psdeb = "s"
                    m_vezesci[&m] = ci_xav
                    m_prcprom = 1
                 Endif
              ElseIf m_debcc = 4                 // 2 vzs
                 If CI_XAP = 2
                    VETOR1[2]='CI_XAP'
                    VETOR1[3]='CI_APRAZO'
                    w_psdeb = "s"
                    m_vezesci[&m] = ci_xap
                    m_prcprom = 2
                 Endif
              ElseIf m_debcc = 5                 // 3 vzs
                 If CI_XAP = 3
                    VETOR1[2]='CI_XAP'
                    VETOR1[3]='CI_APRAZO'
                    w_psdeb = "s"
                    m_vezesci[&m] = ci_xap
                    m_prcprom = 2
                 Endif
              ElseIf m_debcc = 6                 // 4 vzs
                 If CI_XAP = 4
                    VETOR1[2]='CI_XAP'
                    VETOR1[3]='CI_APRAZO'
                    w_psdeb = "s"
                    m_vezesci[&m] = ci_xap
                    m_prcprom = 2
                 Endif
              ElseIf m_debcc = 7                 // 5 vzs
                 If CI_XAP = 5
                    VETOR1[2]='CI_XAP'
                    VETOR1[3]='CI_APRAZO'
                    w_psdeb = "s"
                    m_vezesci[&m] = ci_xap
                    m_prcprom = 2
                 Endif
              Endif
              If w_psdeb = "n"
                 VETOR1[2]= "CI_XAV"
                 VETOR1[3]= "CI_AVISTA"
                 m_vezesci[&m] = ci_xav
                 m_prcprom = 1
              Endif
           Endif
           If (m_tipo = 5 .and. (m_debcc = 1 .or. m_debcc = 2 ))   //  Cartao Debito ou em ate 3x
              If m_prcprom = 1
                 VETOR1[2]= "CI_XAV"
                 VETOR1[3]= "CI_AVISTA"
              ElseIf m_prcprom = 2
                 VETOR1[2]='CI_XAP'
                 VETOR1[3]='CI_APRAZO'
              Endif
           ElseIf m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 7 .or. m_tipo = 8 .or. m_tipo = 9 .or. m_tipo = 10
              VETOR1[2]='CI_XAV'
              VETOR1[3]='CI_AVISTA'
           ElseIf m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 6
              If wPromocaoAvistaCMB = .t.
                 VETOR1[2]='CI_XAV'
                 VETOR1[3]='CI_AVISTA'
              Else
                 VETOR1[2]='CI_XAP'
                 VETOR1[3]='CI_APRAZO'
              Endif
           Endif
           VETOR1[4]='CI_DATINI'
           VETOR1[5]='CI_DATLIMI'
           VETOR1[6]='CI_TIPO'
           VETOR1[7]='CI_AUTORIZ'
           VETOR1[8]='CI_MODALID'
           VETOR2[1]='Codigo'
           If m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 7 .or. m_tipo = 8 .or. m_tipo = 9 .or. m_tipo = 10
              VETOR2[2]='(x)'
              VETOR2[3]='A Vista'
           Else
              If wPromocaoAvistaCMB = .t.
                 VETOR2[2]='(x)'
                 VETOR2[3]='A Vista'
              Else
                 VETOR2[2]='(x)'
                 VETOR2[3]='A Prazo'
              Endif
           Endif
           VETOR2[4]='Inicio da Promo‡„o'
           VETOR2[5]='Limite da Promo‡„o'
           VETOR2[6]='Tip Circular'
           VETOR2[7]='Nr Autoriz'
           VETOR2[8]='Modalidade'
           SETCOLOR("b+/w")
           DBEDIT(18,03,21,76,VETOR1,,,VETOR2)
           RELEASE VETOR1,VETOR2
           Restscreen(13,02,21,77,ssor)
           m_datcirc  = ci_datlimi
           If m_prcprom = 1
              m_vezesci[&m] = ci_xav
           ElseIf m_prcprom = 2
              m_vezesci[&m] = ci_xap
           Endif
           If ci_modalid = "CC"
              w_mod = "CC"
           ElseIf ci_modalid = "ZL"
              w_mod = "ZL"
           Else
              w_mod = "  "
           Endif
           If m_tipo = 5 .and. m_debcc = 1                 && Cartao Parcelado
              If m_prcprom = 1
                 m_vezes[&m] = ci_xav
                 m_vzold     = ci_xav
              ElseIf m_prcprom = 2
                 m_vezes[&m] = ci_xap
                 m_vzold     = ci_xap
              Endif
           ElseIf ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 6 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
              m_vezes[&m] = ci_xav
              m_vzold     = ci_xav
           ElseIf m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 7 .or. m_tipo = 8 .or. m_tipo = 9
              m_vezes[&m] = 1
              m_vzold     = 1
           Else
              If (m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 4 .or. m_tipo = 5 .or. m_tipo = 6 .or. m_tipo = 8 .or. m_tipo = 9 .or. m_tipo = 10) .and. (m_plm = 2)
                 m_vezes[&m] = m_vezespl
                 m_vzold     = m_vezespl
              Else
                 If wPromocaoAvistaCMB = .t.
                    m_vezes[&m] = ci_xav
                    m_vzold     = ci_xav
                 Else
                    m_vezes[&m] = ci_xap
                    m_vzold     = ci_xap
                 Endif
              Endif
           Endif
           If m_vezes[&m] = 0
              m_vezes[&m] = 1
              m_vzold     = 1
           Endif
           If m_datcirc < m_datsi
              Alert("Produto Fora da Promo‡„o !")
           Else
              m_num_vda   = ci_xav
              m_vrcirca   = ci_avista
              m_num_vdp   = ci_xap
              m_vrcircp   = ci_aprazo
              m_autor[&m] = ci_autoriz
              If ci_codigo <> m_cod[&m]
                 Alert("Codigo Errado !")
                 Set Filter to
                 Loop
              Endif
              If m_vrcirca >0 .and. m_vrcircp >0
	         If m_tipo = 5 .and. m_debcc = 1       && Cartao Parcelado
                    If m_prcprom = 1
	               M_VrPlano[&m] = m_vrcirca
	            ElseIf m_prcprom = 2
	               M_VrPlano[&m] = m_vrcircp
	            Endif
                 ElseIf ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 6 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
	            M_VrPlano[&m] = m_vrcirca
 	         ElseIf m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 7 .or. m_tipo = 8 .or. m_tipo = 9 .or. m_tipo = 10
	            M_VrPlano[&m] = m_vrcirca
	         Else
                    If wPromocaoAvistaCMB = .t.
                       M_VrPlano[&m] = m_vrcirca
                    Else
                       M_VrPlano[&m] = m_vrcircp
                    Endif
	         Endif
              ElseIf m_vrcirca >0 .and. m_vrcircp <=0
	         If m_tipo = 5 .and. m_debcc = 1         && Cartao parcelado
                    If m_prcprom = 1
	               M_VrPlano[&m] = m_vrcirca
	            ElseIf m_prcprom = 2
	               M_VrPlano[&m] = m_vrcircp
	            Endif
                 ElseIf ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 6 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
	            If m_vrcirca >0
	               M_VrPlano[&m] = m_vrcirca
	            Else
	               M_VrPlano[&m] = m_vrcircp
	            Endif
 	         ElseIf m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 7 .or. m_tipo = 8 .or. m_tipo = 9 .or. m_tipo = 10
	            M_VrPlano[&m] = m_vrcirca
	         Else
                    If wPromocaoAvistaCMB = .t.
                       M_VrPlano[&m] = m_vrcirca
                    Else
                       M_VrPlano[&m] = 0
                    Endif
                 Endif
              ElseIf m_vrcirca <=0 .and. m_vrcircp >0
                 If m_tipo <> 1
	            M_VrPlano[&m] = m_vrcircp
	         Else
	            M_VrPlano[&m] = 0
	         Endif
              ElseIf m_vrcirca = 0 .or. m_vrcircp = 0
                 If m_tipo <> 1
	            M_VrPlano[&m] = m_vrcircp
                 Else
	            M_VrPlano[&m] = m_vrcirca
	         Endif
	      Endif
           Endif
        Endif
       Set filter to
     Endif

     w_vai_ut = "s"
     w_autor  = 0

     If m_prcprom =  3
        nResp = 2
     Else
        nResp = 0
     Endif

     If m_autor[&m] >0
        If m_prcprom <> 3
           nResp:=Alert("Vai utilizar esta promo‡„o ?", {"Sim ","N„o"})
        Endif
        If nResp <> 1 .or. LASTKEY() = 27
           m_passci    = "n"
           w_vai_ut    = "n"
           w_autor     = m_autor[&m]
           m_autor[&m] = 0
        Endif
        If (m_tipo = 2 .or. m_tipo = 3) .and. (W_Chip = "N" .and. M_VrPlano[&m] <= 0)
           If nResp <> 1
              m_passci    = "n"
              w_vai_ut    = "n"
              w_autor     = m_autor[&m]
              m_autor[&m] = 0
           Else
              m_passci    = "s"
              w_vai_ut    = "s"
              w_autor     = m_autor[&m]
              m_autor[&m] = m_autor[&m]
           Endif
        Endif
        Release W_chip
        If nResp = 1 .and. m_tipo = 5 .and. m_debcc = 7     && 5x s/juros ate dezembro
           m_passci    ="n"
           w_vai_ut    ="n"
           w_autor     = 0
           m_autor[&m] = 0
        Endif
        If w_mod <> "  "
           If (m_tipo = 2 .or. m_tipo = 3) .and. (W_mod = "CC" .or. W_mod = "ZL")
              Alert("Modalide de Venda Difere da Circular !")
              m_passci    = "n"
              w_vai_ut    = "n"
              w_autor     = m_autor[&m]
              m_autor[&m] = 0
           Endif
        Endif
     Endif
     If ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 6 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
        If m_debcc = 2
           m_vezes[&m] = 1
           m_vzold     = 1
        ElseIf m_debcc = 3
           m_vezes[&m] = 1
           m_vzold     = 1
        ElseIf m_debcc = 4
           m_vezes[&m] = 2
           m_vzold     = 2
        ElseIf m_debcc = 5
           m_vezes[&m] = 3
           m_vzold     = 3
        ElseIf m_debcc = 6
           m_vezes[&m] = 4
           m_vzold     = 4
        ElseIf m_debcc = 7
           m_vezes[&m] = 5
           m_vzold     = 5
        Endif
     Endif

     M_Tabe = 2       // Usando Tabela 2 ( A Vista )

     If m_grupo = 8 .and. Substr(m_prod,1,4)<>"CHIP" .and. Substr(m_prod,1,6)<>"CARTAO"   //  Celulares
        m_passcel= "S"
     Endif
     If Substr(m_prod,1,4) = "TABLET"
        m_passcel = "S"
     Endif

     If m_grupo = 4 .or. m_grupo = 6 .or. M_SBGRUPO = 21
        flag = 1        // Moveis
     Else
        flag = 2        // Eletros
     Endif

     If m_passci = "n"
        M_PRE[&M] = M_AVISTA
     Else
        M_PRE[&M] = m_vrplano[&m]
        M_Venda   = m_vrplano[&m]
     Endif

     If EMPTY(M_COR[&M])
        @ LIN,38 GET M_COR[&M] PICT "@!"
        Read
     Endif

     Stor 0 to M_NRCD,wTentantiva
     wCnpJ = ""
     m_said[&M] := PegaSaidaItem(@wOpcao,@M_NRCD,wTentantiva,I_FilOrigem,@wCnpJ,.t.)  // Funcoes.prg
     OldOpcao = wOpcao

     wCont = .f.
     If (wOpcao = 2 .or. wOpcao = 3 .or. wOpcao = 4) .and. (M_NRCD = 10 .or. M_NRCD = 11 .or. M_NRCD = 19 .or. M_NRCD = 20 .or. M_NRCD = 99)
        wCont = .t.
     Endif

     If wOpcao = 4 .and. M_NRCD = 44    //  (Loja desativada)
        wCont = .f.
     Endif

     telprior=savescreen(16,08,21,73)
     Setcolor(c_corg)

     @ LIN,45 SAY Substr(M_SAID[&M],1,12)

     If Empty(m_said[&M])
        Alert("Or‡amento Recusado, Informe Sa¡da dos Produtos")
        Restscreen(lin,7,lin,70,stelcod)
        Loop
     Endif

     Stor 0 to M_Res

     Sele 30
     Set Order to 1
     Seek M_cod[&m]
     If Eof()
        Alert("Produto N„o Cadastrado. Atualize Tabela !")
        Restscreen(lin,7,lin,70,stelcod)
        Loop
     Endif

     If Trim(m_said[&M]) <> "CD"
        Stor 0 to Cent,m_pendenc,wTransit

        wQtdeVenda = 0

        AADD(vetor,{m_co,m_qtd[&m]})    // Controlando Qtdes com Vetores
        For i = 1 to len(vetor)
           wcodiVet = vetor[i,1]
           wqtdeVet = vetor[i,2]
           If wcodiVet = m_co
              wQtdeVenda = wQtdeVenda + wqtdeVet
           Endif
        Next

        If wComponente >0
           Centx:=Cons_Saldo_oDoo(wComponente,Pid,wCnpj)
        Else
           Centx:=Cons_Saldo_oDoo(M_cod[&m],Pid,wCnpj)
        Endif

        If(wQtdeVenda > CENTX) .or. (Centx <= 0)  // Saldo das vendas maior que o fiscal
           Alert("Estoque Insuficiente !")
           Restscreen(lin,7,lin,70,stelcod)
           For i = 1 to len(vetor)
             ADEL(Vetor,1)
           Next
           Priv Vetor := {}
           Loop
        Endif

        Sele 4
        Set Order to 2
        Go Top
        Seek Str(M_cod[&m],6,0)+substr(dtoc(m_datsi),7,4)+substr(dtoc(m_datsi),4,2)+substr(dtoc(m_datsi),1,2)
        Stor 0 to wAfaturar,wNota
        While !Eof() .and. sd_codi = m_cod[&m] .and. sd_data = m_datsi
          If Trim(sd_saida) = "LOJA/MOSTR"
             wNota = SD_Nota
             wJaFat := SD_JaFat(sd_codi,sd_nota)
             If wJafat = 0
                *wAfaturar = wAfaturar + sd_qtde
                If M_PENDENC >0
                   Stor 0 to wSaldo
                   Sele 54
                   Set Order to 2
                   Seek M_cod[&m]
                   While !Eof() .and. CODIGO = M_cod[&m]
                     If Empty(Data_Fat) .and. Minuta = wNota
                        *wAfaturar = wAfaturar - Quant
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
        If wAfaturar+M_QTD[&M] > CENTX                    // Saldo das vendas maior que o fiscal
           Alert("Estoque Insuficiente ou Venda Ainda N„o Faturada. Minuta "+Str(wNota))
           Release datex,datex1,m_datw,m_res,wAfaturar,wJafat
           Restscreen(lin,7,lin,70,stelcod)
           Loop
        Endif
        Release wAfaturar,wJafat
        @ 20,15 Say "                             "
     ElseIf M_cod[&m] <= 5 .and. Trim(m_said[&M]) <> "LOJA/MOST"
        m_said[&M] = "LOJA/MOSTR"
     Endif
     Release datex,datex1,m_datw,m_res,M_PENDENC

     OldSaida = M_Said[&M]

     If Trim(m_said[&M]) = "CD"
        // Bloqueando Reserva nesse periodo para o CD 11, Migrando p/ o oDoo
        If m_datsi = ctod("07/08/2022")
           If I_Priorid = 11
              I_Priorid = 19
              M_NRCD     =19
              M_Said[&M] ="CD FORT"
           Endif
        Endif
        //
        If !Empty(m_said[&M]) .and. wCont = .t.
           wConsultaCD = I_Priorid
           If I_Priorid <> M_NRCD
              wConsultaCD = M_NRCD
           Endif

           Stor 0 to wSaldo_oDoo
           @ 18,15 say "Aguarde a Consulta de Saldo no CD: "+Strzero(wConsultaCD,2)
           If wComponente >0
             *wSt := ConsultaSaldoCD(wComponente,M_QTD[&M],M_VEND,V_NOME,m_said[&M],wConsultaCD)   && Neste Prg
              wSaldo_oDoo := Cons_Saldo_oDoo(wComponente,Pid,wCnPJ)
           Else
             *wSt := ConsultaSaldoCD(M_cod[&m],M_QTD[&M],M_VEND,V_NOME,m_said[&M],wConsultaCD)
              wSaldo_oDoo := Cons_Saldo_oDoo(M_cod[&m],Pid,wCnPJ)
           Endif
           If wSaldo_oDoo <= 0
              @ 20,15 say "Produto Sem Saldo no CD: "+Strzero(wConsultaCD,2)
              inkey(2)
              @ 20,15 clear to 20,50
              If wOpcao <> 2
                 restscreen(16,08,21,73,telprior)
                 Loop
              Endif

              // Consultando em outro CD Quando Nao tem no CD de prioridade e saida for na regional
              If I_Priorid = M_NRCD
                 Stor 0 to M_NRCD
                 Stor 3 to wOpcao
                 Stor 1 to wTentantiva
                 m_said[&M] := PegaSaidaItem(@wOpcao,@M_NRCD,wTentantiva,I_FilOrigem,@wCnpJ,.f.)     // Funcoes.prg
                 @ 18,15 clear to 18,71
                 @ 18,15 say "Aguarde a Consulta de Saldo no CD: "+Strzero(M_NRCD,2)
                 If wComponente >0
                   *wSt := ConsultaSaldoCD(wComponente,M_QTD[&M],M_VEND,V_NOME,m_said[&M],M_NRCD)
                    wSaldo_oDoo := Cons_Saldo_oDoo(wComponente,Pid,wCnPJ)
                 Else
                   *wSt := ConsultaSaldoCD(M_cod[&m],M_QTD[&M],M_VEND,V_NOME,m_said[&M],M_NRCD)
                    wSaldo_oDoo := Cons_Saldo_oDoo(M_cod[&m],Pid,wCnPJ)
                 Endif
                 If wSaldo_oDoo <= 0
                    @ 20,15 say "Produto Sem Saldo no CD: "+Strzero(M_NRCD,2)
                    inkey(2)
                    @ 20,15 clear to 20,50
                    Stor 0 to M_NRCD
                    Stor 3 to wOpcao
                    Stor 2 to wTentantiva
                    m_said[&M] := PegaSaidaItem(@wOpcao,@M_NRCD,wTentantiva,I_FilOrigem,@wCnpJ,.f.)     // Funcoes.prg
                    @ 18,15 say "Aguarde a Consulta de Saldo no CD: "+Strzero(M_NRCD,2)
                    If wComponente >0
                      *wSt := ConsultaSaldoCD(wComponente,M_QTD[&M],M_VEND,V_NOME,m_said[&M],M_NRCD)   && Neste Prg
                       wSaldo_oDoo := Cons_Saldo_oDoo(wComponente,Pid,wCnPJ)
                    Else
                      *wSt := ConsultaSaldoCD(M_cod[&m],M_QTD[&M],M_VEND,V_NOME,m_said[&M],M_NRCD)   && Neste Prg
                       wSaldo_oDoo := Cons_Saldo_oDoo(M_cod[&m],Pid,wCnPJ)
                    Endif
                    If wSaldo_oDoo <= 0
                       @ 20,15 say "Produto Sem Saldo no CD: "+Strzero(M_NRCD,2)
                       inkey(2)
                       @ 20,15 clear to 20,50
                       Stor 0 to M_NRCD
                       Stor 3 to wOpcao
                       Stor 3 to wTentantiva
                       m_said[&M] := PegaSaidaItem(@wOpcao,@M_NRCD,wTentantiva,I_FilOrigem,@wCnpJ,.f.)     // Funcoes.prg
                       @ 18,15 clear to 18,71
                       @ 18,15 say "Aguarde a Consulta de Saldo no CD: "+Strzero(M_NRCD,2)
                       inkey(1)
                       If wComponente >0
                         *wSt := ConsultaSaldoCD(wComponente,M_QTD[&M],M_VEND,V_NOME,m_said[&M],M_NRCD)   && Neste Prg
                          wSaldo_oDoo := Cons_Saldo_oDoo(wComponente,Pid,wCnPJ)
                       Else
                         *wSt := ConsultaSaldoCD(M_cod[&m],M_QTD[&M],M_VEND,V_NOME,m_said[&M],M_NRCD)   && Neste Prg
                          wSaldo_oDoo := Cons_Saldo_oDoo(M_cod[&m],Pid,wCnPJ)
                       Endif
                       If I_priorid = 44 .or. I_filOrigem = "37"
                          If wSaldo_oDoo <= 0
                             @ 20,15 say "Produto Sem Saldo no CD: "+Strzero(M_NRCD,2)
                             inkey(2)
                             @ 20,15 clear to 20,50
                             Stor 0 to M_NRCD
                             Stor 3 to wOpcao
                             Stor 4 to wTentantiva
                             m_said[&M] := PegaSaidaItem(@wOpcao,@M_NRCD,wTentantiva,I_FilOrigem,@wCnpJ,.f.)     // Funcoes.prg
                             @ 18,15 say "Aguarde a Consulta de Saldo no CD: "+Strzero(M_NRCD,2)
                             If wComponente >0
                               *wSt := ConsultaSaldoCD(wComponente,M_QTD[&M],M_VEND,V_NOME,m_said[&M],M_NRCD)   && Neste Prg
                                wSaldo_oDoo := Cons_Saldo_oDoo(wComponente,Pid,wCnPJ)
                             Else
                               *wSt := ConsultaSaldoCD(M_cod[&m],M_QTD[&M],M_VEND,V_NOME,m_said[&M],M_NRCD)   && Neste Prg
                                wSaldo_oDoo := Cons_Saldo_oDoo(M_cod[&m],Pid,wCnPJ)
                             Endif
                          Endif
                       Endif
                       If wSaldo_oDoo <= 0
                          @ 20,15 say "Produto Sem Saldo no CD: "+Strzero(M_NRCD,2)
                          inkey(2)
                          @ 20,15 clear to 20,50
                          restscreen(16,08,21,73,telprior)
                          Loop
                       Else
                          @ 20,15 say "Produto Com Saldo no CD: "+Strzero(M_NRCD,2)
                          inkey(1)
                       Endif
                    Else
                       @ 20,15 say "Produto Com Saldo no CD: "+Strzero(M_NRCD,2)
                       inkey(1)
                    Endif
                 Else
                    @ 20,15 say "Produto Com Saldo no CD: "+Strzero(M_NRCD,2)
                    inkey(1)
                 Endif
              Endif
           Else
              @ 20,15 say "Produto Com Saldo no CD: "+Strzero(wConsultaCD,2)
              inkey(1)
           Endif
        Endif
        restscreen(16,08,21,73,telprior)
        wOpcao = OldOpcao               // Opcao inicial
     Endif

     @ LIN,45 SAY Substr(M_SAID[&M],1,12)

     If m_grupo = 6 .or. m_grupo = 7 .or. m_grupo = 8 .or. m_grupo = 18 .or. m_grupo = 19 .or. wEletri = .t.
        wOpcaoSaida = 2
     Endif

     ssltela=savescreen(lin+1,45,lin+5,68)
     cor=setcolor()
     setcolor("gr+/b")
     Sombra(lin+1,45,lin+4,66,Box)
     @ lin+2,46 prom "Para entrega"

     If Trim(m_said[&M]) = "CD"
        @ lin+3,46 prom "Cliente vai retirar"
     Else
        @ lin+3,46 prom "Cliente vai levar"
     Endif
     Menu to wOpcaoSaida
     If wOpcaoSaida = 1
        wEntrega[&m] = "Para entrega"
     Else
        wEntrega[&m] = "Cliente vai retirar"
     Endif
     setcolor(cor)
     Restscreen(lin+1,45,lin+5,68,ssltela)

     mfrt  = Savescreen(18,20,20,72)
     m_grts= 1

     If m_prcprom = 3
        Inkey(0)                // pode deixar eh necessario !
     Endif

     wAvul = "n"
     If w_gr = "S"
        mfrt = Savescreen(18,04,24,77)
        cor=setcolor()
        SETCOLOR("W+/BG+, B/RG,X")
        If w_faixap <> 34 .AND. M_MESES >0 .AND. M_MESES < 24
           If w_garant_36 >0 .AND. M_MESES <= 12
              @ 18,14 clear to 20,77
              @ 18,14 to 20,77
              @ 19,15 prom "Plano (36)"
              @ 19,26 prom "Plano (24)"
              @ 19,37 prom "Plano (12)"
              @ 19,48 prom "Avulsa (av ou 3x)"
              @ 19,66 prom "S/Garantia"
              Menu to m_grts
              If m_grts = 1
                 w_garant[&m] = w_garant_36
                 w_plano[&m]  = 3
              ElseIf m_grts = 2
                 w_garant[&m] = w_garant_24
                 w_plano[&m]  = 2
              ElseIf m_grts = 3
                 w_garant[&m] = w_garant_12
                 w_plano[&m]  = 1
              ElseIf m_grts = 4
                 @ 19,50 clear to 23,63
                 @ 19,50 to 23,63
                 @ 20,51 prom "Avulsa (36)"
                 @ 21,51 prom "Avulsa (24)"
                 @ 22,51 prom "Avulsa (12)"
                 Menu to m_grt_x
                 wAvul = "s"
                 If m_grt_x = 1
                    w_plav[&m]   = w_garant_36
                    w_garant[&m] = 0
                    w_plano[&m]  = 3
                 ElseIf m_grt_x = 2
                    w_plav[&m]   = w_garant_24
                    w_garant[&m] = 0
                    w_plano[&m]  = 2
                 ElseIf m_grt_x = 3
                    w_plav[&m]   = w_garant_12
                    w_garant[&m] = 0
                    w_plano[&m]  = 1
                 Else
                    w_plav[&m]   = 0
                    w_garant[&m] = 0
                    w_plano[&m]  = 0
                 Endif
                 Release m_grt_x
              Else
                 w_garant[&m] = 0
                 w_plano[&m]  = 0
              Endif
           ElseIf w_garant_24 >0
              @ 18,14 clear to 20,70
              @ 18,14 to 20,70
              @ 19,15 prom "Plano (24)"
              @ 19,27 prom "Plano (12)"
              @ 19,39 prom "Avulsa (av ou 3x)"
              @ 19,58 prom "S/Garantia"
              Menu to m_grts
              If m_grts = 1
                 w_garant[&m] = w_garant_24
                 w_plano[&m]  = 2
              ElseIf m_grts = 2
                 w_garant[&m] = w_garant_12
                 w_plano[&m]  = 1
              ElseIf m_grts = 3
                 @ 19,50 clear to 22,63
                 @ 19,50 to 22,63
                 @ 20,51 prom "Avulsa (24)"
                 @ 21,51 prom "Avulsa (12)"
                 Menu to m_grt_x
                 wAvul = "s"
                 If m_grt_x = 1
                    w_plav[&m]   = w_garant_24
                    w_garant[&m] = 0
                    w_plano[&m]  = 2
                 ElseIf m_grt_x = 2
                    w_plav[&m]   = w_garant_12
                    w_garant[&m] = 0
                    w_plano[&m]  = 1
                 Else
                    w_plav[&m]   = 0
                    w_garant[&m] = 0
                    w_plano[&m]  = 0
                 Endif
                 Release m_grt_x
              Endif
           ElseIf M_MESES >0
              @ 18,20 clear to 20,68
              @ 18,20 to 20,68
              @ 19,21 prom "Plano (12)Meses"
              @ 19,38 prom "Avulsa (av ou 3x)"
	      @ 19,57 prom "S/Garantia"
   	      Menu to m_grts
	      If m_grts = 1
	         w_garant[&m] = w_garant_12
                 w_plano[&m]  = 1
	      ElseIf m_grts = 2
   	         w_plav[&m]   = w_garant_12
 	         w_garant[&m] = 0
 	         w_plano[&m]  = 1
                 wAvul = "s"
	      ElseIf m_grts = 3
  	         w_garant[&m] = 0
 	         w_plano[&m]  = 0
	      Endif
	   Endif
        ElseIf w_faixap = 34 .AND. M_MESES >0 .AND. M_MESES < 24
           If w_garant_24 >0
              @ 18,14 clear to 20,69
              @ 18,14 to 20,69
              @ 19,15 prom "Plano (24)"
              @ 19,27 prom "Plano (12)"
              @ 19,39 prom "Avulsa (av ou 3x)"
              @ 19,58 prom "S/Garantia"
              Menu to m_grts
              If m_grts = 1
                 w_garant[&m] = w_garant_24
                 w_plano[&m]  = 2
              ElseIf m_grts = 2
                 w_garant[&m] = w_garant_12
                 w_plano[&m]  = 1
              ElseIf m_grts = 3
                 @ 20,50 clear to 23,63
                 @ 20,50 to 23,63
                 @ 21,51 prom "Avulsa (24)"
                 @ 22,51 prom "Avulsa (12)"
                 Menu to m_grt_x
                 wAvul = "s"
                 If m_grt_x = 1
                    w_plav[&m]   = w_garant_24
                    w_garant[&m] = 0
                    w_plano[&m]  = 2
                 Else
                    w_plav[&m]   = w_garant_12
                    w_garant[&m] = 0
                    w_plano[&m]  = 1
                 Endif
                 Release m_grt_x
              Endif
           Endif
        Else                                         // Troca Garantida
           If w_garant_24 >0 .and. M_AVISTA <= xy_vrtroca .and. M_MESES >0 .and. M_MESES < 24
              @ 18,04 clear to 20,76
              @ 18,04 to 20,76
              @ 19,05 prom "Troca Garantida(24)"
              @ 19,26 prom "Troca Garantida(12)"
              @ 19,47 prom "Avulsa (av ou 3x)"
              @ 19,66 prom "S/Garantia"
              Menu to m_grts
              If m_grts = 1
                 w_garant[&m] := w_garant_24
                 w_plano[&m]  := 2
              ElseIf m_grts = 2
                 w_garant[&m] := w_garant_12
                 w_plano[&m]  := 1
              ElseIf m_grts = 3
                 wAvul = "s"
                 @ 20,50 clear to 23,63
                 @ 20,50 to 23,63
                 @ 21,51 prom "Avulsa (24)"
                 @ 22,51 prom "Avulsa (12)"
                 Menu to m_grt_x
                 If m_grt_x = 1
                    w_plav[&m]   = w_garant_24
                    w_garant[&m] = 0
                    w_plano[&m]  = 2
                 Else
                    w_plav[&m]   = w_garant_12
                    w_garant[&m] = 0
                    w_plano[&m]  = 1
                 Endif
                 Release m_grt_x
              Endif
           ElseIf M_MESES >0
              @ 18,10 clear to 20,63
              @ 18,10 to 20,63
              @ 19,11 prom "Troca Garantida(12)"
              @ 19,32 prom "Avulsa (av ou 3x)"
	      @ 19,51 prom "S/Garantia"
   	      Menu to m_grts
	      If m_grts = 1
	         w_garant[&m] := w_garant_12
                 w_plano[&m]  := 1
	      ElseIf m_grts = 2
    	         w_plav[&m]   := w_garant_12
 	         w_garant[&m] := 0
 	         w_plano[&m]  := 1
                 wAvul = "s"
	      ElseIf m_grts = 3
  	         w_garant[&m] := 0
 	         w_plano[&m]  := 0
	      Endif
	   Endif
	Endif
        setcolor(cor)
        Restscreen(18,04,24,77,mfrt)
        Release w_faixap,mfrt
    Endif
    If val(acgc) >0 .and. w_garant[&m] >0
       Alert("Garantia Estendida So' P/ Pessoa Fisica !")
       Stor 0 to w_plav[&m],w_garant[&m],w_plano[&m]
       Loop
    Endif

    If xy_cap_int = "CC"
       If m="01" .and. m_grupo <> 8
          mfrt = savescreen(18,20,19,50)
          @ 19,21 prom "C/Frete"
          @ 19,30 prom "S/Frete"
 	  Menu to m_frts
	  If m_frts = 1
	     @ 19,30 clear to 19,49
	     @ 19,29 say "R$"get m_frt pict "@e 999.99"
	     Read
	  Endif
          restscreen(18,20,19,50,mfrt)
       Endif
       If m_grupo = 4
          mfrt = savescreen(18,20,19,50)
          @ 19,21 prom "C/Montagem"
          @ 19,32 prom "S/Montagem"
	  Menu to m_frts
	  If m_frts = 1
	     @ 19,32 clear to 19,49
  	     @ 19,33 say "R$"get m_mon pict "@e 999.99"
	     Read
	  Endif
          restscreen(18,20,19,50,mfrt)
       Endif
    Endif

    If m_tipo <> 3 .and. wAvul = "s"
       Alert("Avulso so' para Modalidade Carnet !")
       Loop
    Endif
    Release wAvul

    If m = "01" .and. m_tipo = 4          && Financeira
       mfrt = savescreen(18,20,19,50)
       @ 19,21 Say "T C  R$" get m_txab pict "@e 999.99"
       Read
       restscreen(18,20,19,50,mfrt)
    Endif
    Release mfrt

     M_PRCP = M_PRE[&M]

     If m_prcprom = 3
        Clear Gets
     Endif
     If m_tipo = 5 .and. m_debcc = 1 .and. m_plm = 2
        M_VEZES[&M] = m_vezespl
     Endif
     If m_passci = "n"
        If m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 7 .or. m_tipo = 8 .or. m_tipo = 9   && Financ
           @ LIN,58 SAY STRZERO(M_VEZES[&M],2)
        Else
          If (m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 5 .or. m_tipo = 6) .and. (m_plm = 2)
             @ LIN,58 SAY STRZERO(M_VEZES[&M],2)
          ElseIf ((m_tipo = 5) .and. (m_debcc = 2 .or. m_debcc = 3 .or. m_debcc = 4 .or. m_debcc = 5 .or. m_debcc = 6 .or. m_debcc = 7))   &&  Cartao Debito ou em ate 3x
             @ LIN,58 SAY STRZERO(M_VEZES[&m],2)
          Else
             @ LIN,58 GET M_VEZES[&M] PICT "99" VALID M_VEZES[&M] >0 .AND. M_VEZES[&M] <= 24
          Endif
          Read
        Endif
        If m_tipo > 1 .and. m_tipo <> 4 .and. m_tipo <> 8 .and. m_tipo <> 9
           If m_vezes[&m] <= 0 .or. Lastkey() = 27
              Alert("Informar a quantidade de parcelas deste produto !")
              Loop
           Endif
        Endif
     Else                       // Na Circular Promocional
        If (m_tipo = 3 .or. m_tipo = 5) .and. (m_vzold <= 5)   // Circular em 1 vez, liberar em 5 vezes sem juros (nataniel em 23/12/2022)
           If m_grupo = 6 .or. m_grupo = 18 .or. m_grupo = 19
              m_vzold = 5
           Endif
        Endif

        @ LIN,58 GET M_VEZES[&M] PICT "99" Valid m_vezes[&m] <= m_vzold
        Read
        If M_VEZES[&M] > M_VZOLD
           Alert("Recusado. Nr de Parcelas Maior que na Promo‡„o !")
           Return
        Endif
     Endif

     If xy_cap_int <> "CC"     // Lojas do interior ( filiais.dbf )
        If wEletri = .t.
           *m_tx_cc:=RetornaTaxa(99,m_tipo,M_VEZES[&M])   // Retorna Taxa para os Fatores funcoes.prg
        Else
           *m_tx_cc:=RetornaTaxa(m_grupo,m_tipo,M_VEZES[&M])   // Retorna Taxa para os Fatores funcoes.prg
        Endif
        If m_grupo = 5
           m_tx_cc = I_TXCARNE           // Taxa de motos ( Carnet )
        Endif
        If m_tipo = 1            && A Vista
           m_tx_cc    = 0
           m_vezes[&m]= 1
        ElseIf m_tipo = 2        && C/Cheque
           m_tx_cc = I_TXCHEQUE
           If M_VEZES[&M] > 3
              If m_vrentr = 0
                 m_venda = m_venda
              Endif
           Endif
        ElseIf m_tipo = 3        && C/Carne
           m_tx_cc = I_TXCARNE
           If M_VEZES[&M] > 3
              If m_vrentr = 0
                 m_venda = m_venda
              Endif
           Endif
           If m_grupo = 7 .or. m_grupo = 11
              m_tx_cc = I_TXINFCAR              // Taxa de informtica carne
           Endif
        ElseIf m_tipo = 4                        && C/Financeira e Boleto
           m_tx_cc    = 0
           m_vezes[&m]= 1
           m_venda = m_venda + m_txab
        ElseIf m_tipo = 9                        && CAIXA /FINANC
           m_tx_cc    = 0
           m_vezes[&m]= 1
        ElseIf m_tipo = 6 .or. m_tipo = 8        && Convenio
           m_tx_cc    = 0
           m_vezes[&m]= 1
        ElseIf m_tipo = 5                        && Cartao de Credito
           m_tx_cc = 0
           m_venda = m_venda
           If m_debcc = 2
              m_vezes[&m]= 1
           ElseIf m_debcc = 3
              m_vezes[&m]= 1
           ElseIf m_debcc = 4
              m_vezes[&m]= 2
           ElseIf m_debcc = 5
              m_vezes[&m]= 3
           ElseIf m_debcc = 6
              m_vezes[&m]= 4     // Ate Dezembro
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
              m_vezes[&m]= 5
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
           m_venda = m_venda + m_txab + m_frt + m_mon
        Endif
        If wEletri = .t.
           *m_tx_cc:=RetornaTaxa(99,m_tipo,M_VEZES[&M])   // Retorna Taxa para os Fatores funcoes.prg
        Else
           *m_tx_cc:=RetornaTaxa(m_grupo,m_tipo,M_VEZES[&M])   // Retorna Taxa para os Fatores funcoes.prg
        Endif
        If m_grupo = 5
           m_tx_cc = I_TXCARNE            // Taxa de motos ( Carnet )
        Endif
        If m_tipo = 1            && A Vista
           m_tx_cc = 0
           m_vezes[&m]= 1
        ElseIf m_tipo = 2        && C/Cheque
           m_tx_cc = I_TXCHEQUE
        ElseIf m_tipo = 3        && C/Carne
           m_tx_cc = I_TXCARNE
           If m_grupo = 7 .or. m_grupo = 11
              m_tx_cc = I_TXINFCAR              // Taxa de informatica carne
           Endif
        ElseIf m_tipo = 4        && C/Financeira
           m_tx_cc    = 0
           m_vezes[&m]= 1
           m_venda = m_venda + m_txab
        ElseIf m_tipo = 9        && CAIXA /FINANC
           m_tx_cc    = 0
           m_vezes[&m]= 1
        ElseIf m_tipo = 6 .or. m_tipo = 8        && Convenio
           m_tx_cc    = 0
	   m_vezes[&m]= 1
        ElseIf m_tipo = 5        && Cartao de Credito
	   m_tx_cc = 0
           If m_debcc = 2
	      m_vezes[&m]= 1
           ElseIf m_debcc = 3
	      m_vezes[&m]= 1
           ElseIf m_debcc = 4
	      m_vezes[&m]= 2
           ElseIf m_debcc = 5
	      m_vezes[&m]= 3
           ElseIf m_debcc = 6   // Ate Dezembro
	      m_vezes[&m]= 4
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
              m_vezes[&m]= 5
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

     // Solicitado por Allan Kardec em 31/03/2021 Fortaleza e Regiao
     If xy_cap_int = "CC" .and. m_datsi >= ctod("01/01/2023") .and. m_datsi <= ctod("31/12/2023")
        If m_grupo = 7 .or. m_grupo = 8
           If m_vezes[&m] <= 10 .and. m_tipo = 5
              m_tx_cc = 0  // Sem Juros
           Endif
        Endif
     Endif

     // Todas as Filiais do interior (joaozinho em 27/12/2022) taxa 2.92 ou 0.00
     If xy_cap_int = "IN" .and. m_datsi >= ctod("01/01/2023") .and. m_tipo = 5     // Cartao de Credito
        If m_grupo = 1 .or. m_grupo = 2 .or. m_grupo = 3 .or. m_grupo = 4 .or. m_grupo = 15 .or. m_grupo = 16
           If m_vezes[&m] >5
              m_tx_cc = 2.92
           Endif
        ElseIf ((m_grupo = 7 .or. m_grupo = 8) .and. (m_vezes[&m] <= 10))
           m_tx_cc = 0
        Endif
     Endif

     // Sendo Que muda conforme o Depto abaixo
     If xy_cap_int = "IN" .and. m_datsi >= ctod("01/01/2023") .and. m_datsi >= ctod("31/12/2023")
        If m_grupo = 3 .and. m_vezes[&m] <= 5 // Portateis
           m_tx_cc = 0
        Endif
     Endif
     // Todas as Filiais do interior (joaozinho em 29/11/2021)
     // Sendo que muda conforme as parcelas
     If xy_cap_int = "IN" .and. m_datsi >= ctod("01/12/2021") .and. m_datsi <= ctod("31/12/2023")
        If m_grupo = 1 .or. m_grupo = 2 .or. m_grupo = 3 .or. m_grupo = 4 .or. m_grupo = 15 .or. m_grupo = 16 .or. m_grupo = 17 .or. m_grupo = 18 .or. m_grupo = 19
           If m_vezes[&m] <= 5 .and. m_tipo = 5       //  ate 5x sem juros cartao
              m_tx_cc = 0
           ElseIf m_vezes[&m] <= 5 .and. m_tipo = 3   //  ate 5 sem juros carne zenir
              m_tx_cc = 0
           Endif
        Endif
     Endif

     i_tx    = m_tx_cc // Variavel de Apoio para vendas carne em ate 3 parcelas
     m_tx_gr = m_tx_cc

     // Taxas promocionais com tempo limitado   funcoes.prg
     TemTaxa = .f.
     i_tx_cc = 0
     If m_vezes[&m] >5
        TaxaPromo(m_vezes[&m],@i_tx_cc,@TemTaxa,m_grupo,m_tipo)
     Endif
     If TemTaxa = .t.
        m_tx_cc = i_tx_cc
        m_tx_gr = i_tx_cc
     Endif

     If w_garant[&m] > 0
        If w_tx_cc > 0 .and. m_tx_cc = 0
           m_tx_cc = w_tx_cc
        Endif
        w_vezesgr[&m] = m_vezes[&m]
        If (m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 6) .and. w_garant[&m] > 0 .and. m_vezes[&m] <= 3
           m_tx_gr = 0
        ElseIf m_tipo = 5 .and. w_garant[&m] > 0 .and. m_vezes[&m] <= 5 .and. XY_Cap_Int = "IN"
           m_tx_cc = 0
           m_tx_gr = 0
        ElseIf m_tipo = 5 .and. w_garant[&m] > 0
           sscg=SaveScreen(lin+1,41,lin+3,73)
           w_vezesgr[&m] = m_vezes[&m]
           @ LIN+1,41 Say "Qtde de Vezes da Garantia"Get w_vezesgr[&m] pict "99"
           Read
           If XY_Cap_Int = "IN" .and. w_vezesgr[&m] <= 5
              m_tx_cc = 0
              m_tx_gr = 0
           ElseIf XY_Cap_Int = "CC" .and. w_vezesgr[&m] <= 10 // Utilizando tabela de garantia da Capital sem Juros na Capital
              m_tx_cc = 0
              m_tx_gr = 0
           Endif
           RestScreen(lin+1,41,lin+3,73,sscg)
           Release sscg
        Endif

        If m_tx_gr > 0
           W_gr1 = Str(Parc_Fin(w_garant[&m],m_tx_gr,w_vezesgr[&m],.f.),10,2)
           M_GRFATOR[&m] = (Val(W_gr1) * w_vezesgr[&m])
        Else
           W_gr1 = w_garant[&m]
           M_GRFATOR[&m] = w_garant[&m]
        Endif
        If w_tx_cc >0
           m_tx_cc = 0
        Endif
        If (m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 5)
            m_tx_cc = i_tx
        Endif
     Endif
     Release i_tx

     wValor   = M_VrPlano[&m]
     w_ult_vr = 0

     z:=At("E-BOOK",m_PROD)
     If z != 0 .and. m_vezes[&m] <= 3
        m_tx_cc = 0
     Endif

     If m_passci = "n"
        If m_vrentr >0
           If xy_cap_int = "CC"
              If (m_tipo = 5 )
                 m_venda = m_venda + (m_txab + m_frt + m_mon)
              Endif
           Endif

           WnValor   = ((m_venda * m_percentr) /100)
           WVrDesc   = m_venda - WnValor

           // Solicitado por Allan Kardec em 31/03/2021 Fortaleza e Regiao
           If xy_cap_int = "CC" .and. m_datsi >= ctod("01/01/2023") .and. m_datsi <= ctod("31/12/2023")
              If m_grupo = 7 .or. m_grupo = 8
                 If m_vezes[&m] <= 10 .and. m_tipo = 5
                    m_tx_cc = 0  // Sem Juros
                 Endif
              Endif
           Endif

           // Todas as Filiais do interior (joaozinho em 27/12/2022) taxa 2.92 ou 0.00
           If xy_cap_int = "IN" .and. m_datsi >= ctod("01/01/2023") .and. m_tipo = 5     // Cartao de Credito
              If m_grupo = 1 .or. m_grupo = 2 .or. m_grupo = 3 .or. m_grupo = 4 .or. m_grupo = 15 .or. m_grupo = 16
                 If m_vezes[&m] >5
                    m_tx_cc = 2.92
                 Endif
              ElseIf ((m_grupo = 7 .or. m_grupo = 8) .and. (m_vezes[&m] <= 10))
                 m_tx_cc = 0
              Endif
           Endif
           // Sendo Que muda conforme o Depto abaixo
           If xy_cap_int = "IN" .and. m_datsi >= ctod("01/01/2023") .and. m_datsi >= ctod("31/12/2023")
              If m_grupo = 3 .and. m_vezes[&m] <= 5 // Portateis
                 m_tx_cc = 0
              Endif
           Endif

           // Todas as Filiais do interior (joaozinho em 29/11/2021)
           // Sendo que muda conforme as parcelas
           If xy_cap_int = "IN" .and. m_datsi >= ctod("01/12/2021") .and. m_datsi <= ctod("31/12/2023")
              If m_grupo = 1 .or. m_grupo = 2 .or. m_grupo = 3 .or. m_grupo = 4 .or. m_grupo = 15 .or. m_grupo = 16 .or. m_grupo = 17 .or. m_grupo = 18 .or. m_grupo = 19
                 If m_vezes[&m] <= 5 .and. m_tipo = 5       //  ate 5x sem juros cartao
                    m_tx_cc = 0
                 ElseIf m_vezes[&m] <= 5 .and. m_tipo = 3   //  ate 5 sem juros carne zenir
                    m_tx_cc = 0
                 Endif
              Endif
           Endif

           // Taxas promocionais com tempo limitado   funcoes.prg
           TemTaxa = .f.
           i_tx_cc = 0
           If m_vezes[&m] >5
              TaxaPromo(m_vezes[&m],@i_tx_cc,@TemTaxa,m_grupo,m_tipo)
           Endif
           If TemTaxa = .t.
              m_tx_cc = i_tx_cc
           Endif

           WValor    = Str(Parc_Fin(wVrDesc,m_tx_cc,m_vezes[&m],.f.),10,2)
           m_pre[&m] = ((Val(WValor) * m_vezes[&m]) + WnValor)
        Else
           If xy_cap_int = "CC"
              If w_vai_ut = "n"
                 If w_tx_cc >0
                    If m_tipo = 2 .or. m_tipo = 3
                       If m_vezes[&m] >3
                          m_venda = m_venda + (m_txab + m_frt + m_mon)
		       Else
                          m_venda = m_venda + (m_txab + m_frt + m_mon)
		       Endif
		    Else
		       If (m_tipo = 5) .and. (m_debcc = 6 .or. m_debcc = 7)  // Sem juros
	                  m_venda = m_venda
		       Else
	                  m_venda = m_venda + (m_txab + m_frt + m_mon)
                       Endif
		    Endif
                 Else
                    If m_tipo = 2 .or. m_tipo = 3
		       If m_vezes[&m] >3
         	          m_venda = m_venda + (m_txab + m_frt + m_mon)
		       Else
         	          m_venda = m_venda + (m_txab + m_frt + m_mon)
		       Endif
       	            Else
                       // dia 24/01/2021
                       If (m_tipo = 5 )
                          m_venda = m_venda + (m_txab + m_frt + m_mon)
                       Endif
		    Endif
		 Endif
	      Else
	      // dia 24/01/2021
	         If (m_tipo = 5 )
		    m_venda = m_venda + (m_txab + m_frt + m_mon)
		 Endif
	      Endif
           Else                  && Lojas do Interior
              If w_tx_cc >0
                 If (m_tipo = 5) .and. (m_debcc = 6 .or. m_debcc = 7)
                    m_venda = m_venda
                 Endif
              Endif
           Endif

           // Tem a Circular mas vai pagar em menas parcelas, entao puxa o valor a vista da circular

           // Solicitado por Allan Kardec em 31/03/2021 Fortaleza e Regiao
           If xy_cap_int = "CC" .and. m_datsi >= ctod("01/01/2023") .and. m_datsi <= ctod("31/12/2023")
              If m_grupo = 7 .or. m_grupo = 8
                 If m_vezes[&m] <= 10 .and. m_tipo = 5
                    m_tx_cc = 0  // Sem Juros
                 Endif
              Endif
           Endif

           // Todas as Filiais do interior (joaozinho em 27/12/2022) taxa 2.92 ou 0.00
           If xy_cap_int = "IN" .and. m_datsi >= ctod("01/01/2023") .and. m_tipo = 5     // Cartao de Credito
              If m_grupo = 1 .or. m_grupo = 2 .or. m_grupo = 3 .or. m_grupo = 4 .or. m_grupo = 15 .or. m_grupo = 16
                 If m_vezes[&m] >5
                    m_tx_cc = 2.92
                 Endif
              ElseIf ((m_grupo = 7 .or. m_grupo = 8) .and. (m_vezes[&m] <= 10))
                 m_tx_cc = 0
              Endif
           Endif
           // Sendo Que muda conforme o Depto abaixo
           If xy_cap_int = "IN" .and. m_datsi >= ctod("01/01/2023") .and. m_datsi >= ctod("31/12/2023")
              If m_grupo = 3 .and. m_vezes[&m] <= 5 // Portateis
                 m_tx_cc = 0
              Endif
           Endif

           // Todas as Filiais do interior (joaozinho em 29/11/2021)
           // Sendo que muda conforme as parcelas
           If xy_cap_int = "IN" .and. m_datsi >= ctod("01/12/2021") .and. m_datsi <= ctod("31/12/2023")
              If m_grupo = 1 .or. m_grupo = 2 .or. m_grupo = 3 .or. m_grupo = 4 .or. m_grupo = 15 .or. m_grupo = 16 .or. m_grupo = 17 .or. m_grupo = 18 .or. m_grupo = 19
                 If m_vezes[&m] <= 5 .and. m_tipo = 5       //  ate 5x sem juros cartao
                    m_tx_cc = 0
                 ElseIf m_vezes[&m] <= 5 .and. m_tipo = 3   //  ate 5 sem juros carne zenir
                    m_tx_cc = 0
                 Endif
              Endif
           Endif

           // Taxas promocionais com tempo limitado   funcoes.prg

           TemTaxa = .f.
           i_tx_cc = 0
           If m_vezes[&m] >5
              TaxaPromo(m_vezes[&m],@i_tx_cc,@TemTaxa,m_grupo,m_tipo)
           Endif
           If TemTaxa = .t.
              m_tx_cc = i_tx_cc
           Endif

           If m_tx_cc > 0
              WValor  = Str(Parc_Fin(m_venda,m_tx_cc,m_vezes[&m],.f.),10,2)
              m_pre[&m] = (val(WValor) * m_vezes[&m])
           Else
              m_pre[&m] = m_venda
           Endif

           If (m_tipo = 2 .or. m_tipo = 3) .and. m_vezes[&m] <= 3
               m_pre[&m] = m_pre[&m]
           Endif

           If w_vai_ut = "n" .and. m_vrcirca >0 .and. m_prcprom = 3   && n vai utilizar a circ e pega preco da circ
              w_ult_vr = m_pre[&m]                                    && para comparar se foi diminuido o valor
           Endif

        Endif

        If xy_cap_int = "CC" .and. m_tipo <> 1 .and. m_tipo <> 4 .and. m_tipo <> 8 .and. m_tipo <> 10
           M_PRE[&M] = (M_PRE[&M] - (m_txab + m_frt + m_mon ))   // Composicao do pr de partida
        ElseIf xy_cap_int = "CC" .and. w_vai_ut = "n"
           M_PRE[&M] = (M_PRE[&M] - (m_txab + m_frt + m_mon ))   // Composicao do pr de partida
        Endif

        WValor = M_PRE[&M]

     ElseIf m_passci <> "n" .and. m_tipo = 5 .and. m_debcc = 1

       If m_prcprom = 1
          m_percentr = ((m_vrentr / (m_vrvenda+m_txab+m_frt+m_mon)) * 100)

          wnValor = ((m_venda * m_percentr) /100)
          wVrDesc = m_venda - WnValor

          OldVezes = m_vezes[&m]  // Parametro para qdo tiver circular em 1 vez, vender em ate 5x sem juros (nataniel em 23/11/2022)
          If m_tx_cc = 0
             m_vezes[&m] = 1      // Para Nao Afetar o valor da venda qdo for parcelar
          Endif

          wValor := Str(Parc_Fin(WVrDesc,m_tx_cc,m_vezes[&m],.f.),10,2)
          wValor = (((Val(wValor) * m_vezes[&m]) + WnValor) - (m_txab + m_frt + m_mon))

          If m_tx_cc = 0
             m_vezes[&m] = OldVezes    // Voltando o parcelamento normal
          Endif
          Release OldVezes

       ElseIf m_prcprom = 2
          If xy_cap_int = "CC"
             If m_tipo = 2 .or. m_tipo = 3
	        m_venda = m_venda + m_grfator[&m]
	     Else
 	        m_venda = m_venda
	     Endif
	     wvalor  = m_venda
	  Else
	     If m_tipo = 2 .or. m_tipo = 3
                m_venda = m_venda - w_garant[&m]
                WValor = m_venda + m_grfator[&m]
	     Else
	        m_venda = m_venda
                WValor  = m_venda
             Endif
          Endif
       Endif
       M_PRE[&M] = WValor     // Composicao do pr de partida
     Else
        If m_tipo = 4 .or. m_tipo = 9
           m_pre[&m] = m_pre[&m] + m_txab
        ElseIf m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 5
           If m_tipo = 3
              *m_pre[&m] = m_pre[&m] + m_grfator[&m]
              m_pre[&m] = m_pre[&m]
           Else
	      If w_tx_cc > 0
                 If m_tipo = 2 .or. m_tipo = 3
	            *m_pre[&m] = m_pre[&m] + m_grfator[&m]
	            m_pre[&m] = m_pre[&m]
		 Else
	            m_pre[&m] = m_pre[&m]
		 Endif
	      Else
                 If m_tipo = 2 .or. m_tipo = 3
   	            *m_pre[&m] = m_pre[&m] + w_garant[&m]
   	            m_pre[&m] = m_pre[&m]
	         Else
	            m_pre[&m] = m_pre[&m]
	         Endif
	      Endif
	   Endif
	Endif
     Endif

     If m_plm = 1
        m_num1 = m_vezes[&m]
     Endif

     If m_passci = "n"
        @ LIN,61 GET M_PRE[&M] PICT "99,999.99"
        Read
        If w_vai_ut = "n" .and. m_vrcirca >0 .and. m_prcprom = 3   && n vai utilizar a circ e pega preco da circ
           If (M_PRE[&M] < W_ult_vr-1)
              m_autor[&m] = 0
           Else
              m_autor[&m] = w_autor
           Endif
        Endif
     Else
        WValor = M_PRE[&M]
        If M_PRE[&M] = 0
           @ LIN,61 SAY M_PRE[&M] PICT "99,999.99"
        Else
           @ LIN,61 GET M_PRE[&M] PICT "99,999.99"
           Read
        Endif
     Endif
     Release w_autor,w_ult_vr

     If m_grup <> 8
        If M_pre[&M] < M_Avista .and. m_passci = "s" .and. m_debcc = 5
           If m_passci = "n"
              M_Autor[&m] = 0
              Alert("Pre‡os da Circular em 3x sem juros utilizara' codigo de Autorizacao !")
           Endif
        ElseIf M_pre[&M] < M_Avista .and. m_passci = "s" .and. m_debcc = 4
           If m_passci = "n"
              M_Autor[&m] = 0
              Alert("Pre‡os da Circular em 2x sem juros utilizara' codigo de Autorizacao !")
           Endif
        ElseIf M_pre[&M] < M_Avista .and. m_passci = "s" .and. m_debcc = 5
           If m_passci = "n"
              M_Autor[&m] = 0
              Alert("Pre‡os da Circular em 3x sem juros utilizara' codigo de Autorizacao !")
           Endif
        ElseIf M_pre[&M] < M_Avista .and. m_passci = "s" .and. m_debcc = 6
           If m_passci = "n"
              M_Autor[&m] = 0
              Alert("Pre‡os da Circular em 4x sem juros utilizara' codigo de Autorizacao !")
           Endif
        ElseIf M_pre[&M] < M_Avista .and. m_passci = "s" .and. m_debcc = 7
           If m_passci = "n"
              M_Autor[&m] = 0
              Alert("Pre‡os da Circular em 5x sem juros utilizara' codigo de Autorizacao !")
           Endif
        Endif
     Endif
     If nResp = 1 .and. (m_tipo = 3 .or. m_tipo = 6) .and. m_autor[&m] = 0 .and. m_vezes[&m] = 4    && 4x s juros ate dezembro
        If m_pre[&m] < m_avista
           m_passci    = "n"
           w_vai_ut    = "n"
           w_autor     = m_autor[&m]
           m_autor[&m] = 0
        Endif
     Endif
     If nResp = 1 .and. m_passci = "n" .and. (m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 6)
        If m_pre[&m] < m_avista
           Stor "n" to m_passci,w_vai_ut
           Stor 0   to m_autor[&m],w_autor
        Endif
     ElseIf nResp = 1 .and. m_passci = "s" .and. (m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 6)
        w_dif = m_vrcirca - m_vrentr
        If m_pre[&m] < m_vrcircp
           Stor "n" to m_passci,w_vai_ut
           Stor 0   to m_autor[&m],w_autor
        Endif
        Release w_dif
     Endif
     If m_tipo = 1
        SN=SAVESCREEN(19,14,20,78)
        If m_grupo = 8
           If (Str(M_PRE[&M],10,2) < Str((WValor-10),10,2))
              @ 19,14 SAY "Desconto N„o Permitido !"
              Alert("Aviso! Este pre‡o estara sujeito a analize !")
              m_autor[&m] = 0
           Else
              If m_autor[&m] = 0
                 m_autor[&m] = 1
              Endif
           Endif
        Else
           If (M_PRE[&M] < WValor-1)
              M_PE   = (M_PRE[&M]/WValor)
              M_PE   = M_PE*100
              M_PE   = 100-M_PE
              M_DESC = M_PE
	      If m_grupo <> 4 .and. m_grupo <> 6
	         If M_PE > I_DESCAVEL
                    @ 19,14 SAY "Desconto de [      %] N„o Permitido. Maior que"+Str(I_DESCAVEL,6,2)+"% Em Eletros"
                    @ 19,27 SAY M_PE PICT "999.99"
	            Alert("Aviso! Este pre‡o estara sujeito a analize !")
                    m_autor[&m] = 0
                 Endif
	      ElseIf m_grupo = 4 .or. m_grupo = 6
	         If M_PE > I_DESCAVMO
                    @ 19,14 SAY "Desconto de [      %] N„o Permitido. Maior que"+str(I_DESCAVMO,6,2)+"% Em Moveis"
                    @ 19,27 SAY M_PE PICT "999.99"
	            Alert("Aviso! Este pre‡o estara sujeito a analize !")
                    m_autor[&m] = 0
                 Endif
              Endif
           Endif
        Endif
        RESTSCREEN(19,14,20,78,SN)
        SETCOLOR(COR)
     ElseIf m_tipo = 2     && Cheque
        SN=SAVESCREEN(19,14,20,78)
        If m_grupo = 8
           If str(M_PRE[&M],10,2) < Str((WValor-10),10,2)
              @ 19,14 SAY "Desconto N„o Permitido !"
              Alert("Aviso! Este pre‡o estara sujeito a analize !")
              m_autor[&m] = 0
           Else
              If m_autor[&m] = 0
                 m_autor[&m] = 1
              Endif
           Endif
        Else
           If (M_PRE[&M] < WValor-1)
              M_PE   = (M_PRE[&M]/WValor)
              M_PE   = M_PE*100
              M_PE   = 100-M_PE
              M_DESC = M_PE
              If M_PE > I_DCCHEQUE
                 @ 19,14 SAY "Desconto de [      %] N„o Permitido !"
                 @ 19,27 SAY M_PE PICT "999.99"
                 Alert("Aviso! Este pre‡o estara sujeito a analize !")
                 m_autor[&m] = 0
              Endif
           Endif
           If M_PE > I_DESCAVEL
              @ 19,14 SAY "Desconto de [      %] N„o Permitido. Maior que"+Str(I_DESCAVEL,6,2)+"% Em Eletros"
              @ 19,27 SAY M_PE PICT "999.99"
              Alert("Aviso! Este pre‡o estara sujeito a analize !")
              m_autor[&m] = 0
           Endif
           RESTSCREEN(19,14,20,78,SN)
           SETCOLOR(COR)
        Endif
     ElseIf (m_tipo = 3 .or. m_tipo = 6) .and. m_autor[&m] = 0
          SN=SAVESCREEN(19,14,20,78)
          If m_grupo = 8
             If str(M_PRE[&M],10,2) < Str((WValor-10),10,2)
                @ 19,14 SAY "Desconto N„o Permitido !"
                Alert("Aviso! Este pre‡o estara sujeito a analize !")
                m_autor[&m] = 0
             Else
                If m_autor[&m] = 0
                   m_autor[&m] = 1
                Endif
             Endif
          Else
             If M_PRE[&M] < WValor-1
                M_PE   = (M_PRE[&M]/WValor)
                M_PE   = M_PE*100
                M_PE   = 100-M_PE
                M_DESC = M_PE
                If M_PE > I_DCCARNE
                   @ 19,14 SAY "Desconto de [      %] N„o Permitido !"
                   @ 19,27 SAY M_PE PICT "999.99"
                   Alert("Aviso! Este pre‡o estara sujeito a analize !")
                   m_autor[&m] = 0
                Endif
             Endif
          Endif
          RESTSCREEN(19,14,20,78,SN)
          SETCOLOR(COR)
     ElseIf (m_tipo = 4 .or. m_tipo = 7 .or. m_tipo = 8 .or. m_tipo = 9 .or. m_tipo = 10 )
       SN=SAVESCREEN(19,14,20,78)
       If M_PRE[&M] < WValor-1
          M_PE  = (M_PRE[&M]/WValor)
          M_PE  = M_PE*100
          M_PE  = 100-M_PE
          M_DESC= M_PE
          If m_vezes[&m] = 06
             If m_grupo = 8
                If str(M_PRE[&M],10,2) < Str((WValor-10),10,2)
                   @ 19,14 SAY "Desconto N„o Permitido !"
                   Alert("Aviso! Este pre‡o estara sujeito a analize !")
                   m_autor[&m] = 0
                Else
                   If m_autor[&m] = 0
                      m_autor[&m] = 1
                   Endif
                Endif
             Else
                If M_PE > I_FT_01L                   && Fator Losango C/ IOF
                   @ 19,14 SAY "Desconto de [      %] N„o Permitido."
                   @ 19,27 SAY M_PE PICT "999.99"
                   Alert("Aviso! Este pre‡o estara sujeito a analize !")
                   m_autor[&m] = 0
                Endif
             Endif
          ElseIf m_vezes[&m] = 10
             If m_grupo = 8
                If str(M_PRE[&M],10,2) < Str((WValor-10),10,2)
                   @ 19,14 SAY "Desconto N„o Permitido !"
                   Alert("Aviso! Este pre‡o estara sujeito a analize !")
                   m_autor[&m] = 0
                Else
                   If m_autor[&m] = 0
                      m_autor[&m] = 1
                   Endif
                Endif
             Else
                If M_PE > I_FT_02L                   && Fator Losango C/ IOF
                   @ 19,14 SAY "Desconto de [      %] N„o Permitido."
                   @ 19,27 SAY M_PE PICT "999.99"
                   Alert("Aviso! Este pre‡o estara sujeito a analize !")
                   m_autor[&m] = 0
                Endif
             Endif
          ElseIf m_vezes[&m] = 12
             If m_grupo = 8
                If str(M_PRE[&M],10,2) < Str((WValor-10),10,2)
                   @ 19,14 SAY "Desconto N„o Permitido !"
                   Alert("Aviso! Este pre‡o estara sujeito a analize !")
                   m_autor[&m] = 0
                Else
                   If m_autor[&m] = 0
                      m_autor[&m] = 1
                   Endif
                Endif
             Else
                If M_PE > I_FT_03L                   && Fator Losango C/ IOF
                   @ 19,14 SAY "Desconto de [      %] N„o Permitido."
                   @ 19,27 SAY M_PE PICT "999.99"
                   Alert("Aviso! Este pre‡o estara sujeito a analize !")
                   m_autor[&m] = 0
                Endif
             Endif
          ElseIf m_vezes[&m] = 15
             If m_grupo = 8
                If str(M_PRE[&M],10,2) < Str((WValor-10),10,2)
                   @ 19,14 SAY "Desconto N„o Permitido !"
                   Alert("Aviso! Este pre‡o estara sujeito a analize !")
                   m_autor[&m] = 0
                Else
                   If m_autor[&m] = 0
                      m_autor[&m] = 1
                   Endif
                Endif
             Else
                If M_PE > I_FT_04L                   && Fator Losango C/ IOF
                   @ 19,14 SAY "Desconto de [      %] N„o Permitido."
                   @ 19,27 SAY M_PE PICT "999.99"
                   Alert("Aviso! Este pre‡o estara sujeito a analize !")
                   m_autor[&m] = 0
                Endif
             Endif
          Else
             If m_grupo = 8
                If str(M_PRE[&M],10,2) < Str((WValor-10),10,2)
                   @ 19,14 SAY "Desconto N„o Permitido !"
                   Alert("Aviso! Este pre‡o estara sujeito a analize !")
                   m_autor[&m] = 0
                Else
                   If m_autor[&m] = 0
                      m_autor[&m] = 1
                   Endif
                Endif
             Else
                @ 19,14 SAY "Desconto de [      %] N„o Permitido."
                @ 19,27 SAY M_PE PICT "999.99"
                Alert("Aviso! Este pre‡o estara sujeito a analize !")
                m_autor[&m] = 0
             Endif
          Endif
       Endif
       RESTSCREEN(19,14,20,78,SN)
       SETCOLOR(COR)
     ElseIf (m_tipo = 5)
      SN = SAVESCREEN(19,14,20,78)
      If M_PRE[&M] < WValor-1
         M_PE  = (M_PRE[&M]/WValor)
         M_PE  = M_PE*100
         M_PE  = 100-M_PE
         M_DESC= M_PE
         If xy_cap_int = "CC"
            If m_grupo <> 4 .and. m_grupo <> 6
               If m_grupo = 8
                  If str(M_PRE[&M],10,2) < Str((WValor-10),10,2)
                     @ 19,14 SAY "Desconto N„o Permitido !"
                     Alert("Aviso! Este pre‡o estara sujeito a analize !")
                     m_autor[&m] = 0
                  Else
                     If m_autor[&m] = 0
                        m_autor[&m] = 1
                     Endif
                  Endif
               Else
                  If M_PE > I_DCELECAP
                     @ 19,14 SAY "Desconto de [      %] N„o Permitido. Maior que"+Str(I_DCELECAP,6,2)+"% Em Eletros"
                     @ 19,27 SAY M_PE PICT "999.99"
                     Alert("Aviso! Este pre‡o estara sujeito a analize !")
                     m_autor[&m] = 0
                  Endif
               Endif
            ElseIf m_grupo = 4 .or. m_grupo = 6
               If M_PE > I_DCMOVCAP
                  @ 19,14 SAY "Desconto de [      %] N„o Permitido. Maior que"+str(I_DCMOVCAP,6,2)+"% Em Moveis"
                  @ 19,27 SAY M_PE PICT "999.99"
                  Alert("Aviso! Este pre‡o estara sujeito a analize !")
                  m_autor[&m] = 0
               Endif
            Endif
         Else
            If m_grupo <> 4 .and. m_grupo <> 6
               If m_grupo = 8
                  If str(M_PRE[&M],10,2) < Str((WValor-10),10,2)
                     @ 19,14 SAY "Desconto N„o Permitido !"
                     Alert("Aviso! Este pre‡o estara sujeito a analize !")
                     m_autor[&m] = 0
                  Else
                     If m_autor[&m] = 0
                        m_autor[&m] = 1
                     Endif
                  Endif
               Else                // Celulares
                  If M_PE > I_DCELEINT
                     @ 19,14 SAY "Desconto de [      %] N„o Permitido. Maior que"+Str(I_DCELECAP,6,2)+"% Em Eletros"
                     @ 19,27 SAY M_PE PICT "999.99"
                     Alert("Aviso! Este pre‡o estara sujeito a analize !")
                     m_autor[&m] = 0
                  Endif
               Endif
            ElseIf m_grupo = 4 .or. m_grupo = 6
               If M_PE > I_DCMOVINT
                  @ 19,14 SAY "Desconto de [      %] N„o Permitido. Maior que"+str(I_DCMOVCAP,6,2)+"% Em Moveis"
                  @ 19,27 SAY M_PE PICT "999.99"
                  Alert("Aviso! Este pre‡o estara sujeito a analize !")
                  m_autor[&m] = 0
               Endif
            Endif
       Endif
           RESTSCREEN(19,14,20,78,SN)
      Endif
           SETCOLOR(COR)
     Endif

     nResp:=0
     nResp:=Alert( " Venda de Produtos", {"Confirma ","Retorna "})
     IF nResp<>1 .Or. LASTKEY() = 27
        Loop
     Endif

     If M = "01"
        If Trim(M_SAID[&M]) <> "LOJA/M"
           wSaida = Trim(M_SAID[&M])
        Endif
     Else
        If M_SAID[&M] <> "LOJA/M"
           If !Empty(wSaida)
              If M_SAID[&M] <> wSaida
                 Alert("Saida Recusada. Somente 2 Destinos !")
                 Loop
              Endif
           Else
              wSaida = Trim(M_SAID[&M])
           Endif
        Endif
     Endif
     @ LIN,61 SAY M_PRE[&M] PICT "99,999.99"

     //***************ACRESCIMO OU DESCONTO***********
     IF M_TIPO = 2 .OR. M_TIPO = 3 .OR. M_TIPO = 6
        IF M_PRE[&M] < M_VENDA
           M_DE[&M] = M_VENDA-M_PRE[&M]    && M_DE = DESCONTOS
        ELSEIF M_PRE[&M] > M_VENDA
           M_AC[&M] = M_PRE[&M]-M_VENDA   && M_AC = ACRESCIMO
        ENDIF
     ELSEIF M_PRE[&M]<M_AVISTA
        M_DE[&M]=M_AVISTA - M_PRE[&M]
     ELSEIF M_PRE[&M]>M_AVISTA
        M_AC[&M]=M_PRE[&M]-M_AVISTA
     ENDIF

     M_TOTD  = M_TOTD  + M_DE[&M]
     M_TOTAC = M_TOTAC + M_AC[&M]

     Sele 3
     Set Order to 1
     If CD_PROMO < M_DATA
        If M_TIPO = 2 .OR. M_TIPO = 3 .OR. M_TIPO = 6
           If M_PRE[&M]<M_VENDA
              M_DESC=M_PRE[&M]
           Endif
        Endif
     ElseIf CD_PROMO>=M_DATA .AND. M_GRUPO=8                && Celulares
         If M_TIPO = 2 .OR. M_TIPO = 3 .OR. M_TIPO = 6
            If M_PRE[&M]<M_PRECO
               M_DESC=M_PRE[&M]
            Endif
         Endif
     Endif

      If m_passci = "n" .and. m_autor[&m] <= 0
         If M_PRE[&M] > 1 .and. M_PRE[&M] < m_custo
            Alert('Valor Abaixo do Custo. Sujeito a Analize !')
            m_autor[&m] = 0
         Endif
      Endif

      T_GARANT  = T_GARANT  +(w_garant[&m]*M_QTD[&M])
      M_STO[&M] = M_PRE[&M] * M_QTD[&M]
      M_T       = M_PRE[&M] * M_QTD[&M]
      M_GRTO    = M_GRTO + M_STO[&M]

      If w_plav[&m] >0
         t_plav = t_plav + w_plav[&m]
         m_grfator[&m] = w_plav[&m]
      Endif

      w_ttgaran  = w_ttgaran + (m_grfator[&m]*M_QTD[&M])

      @ LIN,70 SAY M_STO[&M]      PICT "@E 99,999.99"
      @ 18,69  SAY M_GRTO         PICT "@E 999,999.99"

      // Venda de Seguro (Furto e Roubo, Quebra Acidental)
      wSeguroTotal = 0
     /*
      If wSeguro = .t.
         telentr=savescreen(10,01,22,72)
         wTotv = M_QTD[&M] * M_PRE[&M]
         wTotalSeg25  = (wTotv*25)/100
         wTotalVenda25= wTotv+wTotalSeg25
         wTotalSeg20  = (wTotv*20)/100
         wTotalVenda20= wTotv+wTotalSeg20
         wTotalSeg18  = (wTotv*18)/100
         wTotalVenda18= wTotv+wTotalSeg18
         Set Message to 22 Center
         Sombra(11,11,21,62,box)
         Padrao()  //cores
         @ 22,01 clear to 22,58
         MOV_LINHA := 11; MOV_COLUNA := 11
         JANELA( MOV_LINHA, MOV_COLUNA, MOV_LINHA + 10, MOV_COLUNA + 51, "Seguro " )
         SETCOLOR( CONTECOR[ 11 ] + "," + CONTECOR[ 9 ] + ",,," + CONTECOR[ 8 ] )
         @ 13,14 Prom " Roubo, Furto e Quebra Acidental   R$ "+Str(wTotalSeg25,6,2) mess "Valor Total com Seguro "+Str(wTotalVenda25,9,2)
         @ 15,14 Prom " Roubo e Furto                     R$ "+Str(wTotalSeg20,6,2) mess "Valor Total com Seguro "+Str(wTotalVenda20,9,2)
         @ 17,14 Prom " Quebra Acidental                  R$ "+Str(wTotalSeg18,6,2) mess "Valor Total com Seguro "+Str(wTotalVenda18,9,2)
         @ 19,14 Prom " N„o Quero                            "                      mess "Valor Total com Seguro "+Str(wTotV,9,2)
         Menu to wOpcaoSeg
         If wOpcaoSeg = 1
            wSeguroTotal = wTotalSeg25
         ElseIf wOpcaoSeg = 2
            wSeguroTotal = wTotalSeg20
         ElseIf wOpcaoSeg = 3
            wSeguroTotal = wTotalSeg18
         Endif
         restscreen(10,01,22,72,telentr)
      Endif
    */
      If (m_tipo = 1 .or. m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 4 .or. m_tipo = 8 .or. m_tipo = 9 .or. m_tipo = 10 ) .and. (t_garant >0)
         If (m_tipo = 2 .or. m_tipo = 3) .and. (m_grfator[&m] >0)
            w_GRTO = M_GRTO
            @ 18,69 SAY w_GRTO PICT "@E 999,999.99"
            Cor=Setcolor()
            Setcolor("GR+/B")
            @ 19,59 SAY "Garantia E"
            Cor=Setcolor(Cor)
            @ 19,69 SAY T_Garant        PICT "@E 999,999.99"
            @ 20,69 SAY W_GRTO+T_Garant PICT "@E 999,999.99"
            If wSeguroTotal >0
               Cor=Setcolor()
               Setcolor("GR+/B")
               @ 21,59 SAY "Seguro    "
               Cor=Setcolor(Cor)
               @ 21,69 SAY wSeguroTotal                 PICT "@E 999,999.99"
               @ 22,69 SAY W_GRTO+T_Garant+wSeguroTotal PICT "@E 999,999.99"
            Endif
            Release w_grto
         ElseIf (m_tipo = 2 .or. m_tipo = 3) .and. (m_grfator[&m] = 0 .and. T_Garant >0)
            Cor=Setcolor()
            Setcolor("GR+/B")
            @ 19,59 SAY "Garantia E"
            Cor=Setcolor(Cor)
            @ 19,69 SAY T_Garant        PICT "@E 999,999.99"
            @ 20,69 SAY M_GRTO PICT "@E 999,999.99"
            If wSeguroTotal >0
               Cor=Setcolor()
               Setcolor("GR+/B")
               @ 21,59 SAY "Seguro    "
               Cor=Setcolor(Cor)
               @ 21,69 SAY wSeguroTotal                 PICT "@E 999,999.99"
               @ 22,69 SAY W_GRTO+wSeguroTotal PICT "@E 999,999.99"
            Endif
         Else
            Cor=Setcolor()
            Setcolor("GR+/B")
            @ 19,59 SAY "Garantia E"
            Cor=Setcolor(Cor)
            @ 19,69 SAY T_Garant        PICT "@E 999,999.99"
            @ 20,69 SAY M_GRTO+T_Garant PICT "@E 999,999.99"
         Endif
            Cor=Setcolor()
            Setcolor("GR+/B")
            @ 19,59 SAY "Garantia E"
            Cor=Setcolor(Cor)
            @ 19,69 SAY T_Garant        PICT "@E 999,999.99"
            @ 20,69 SAY M_GRTO+T_Garant PICT "@E 999,999.99"
            If wSeguroTotal >0
               Cor=Setcolor()
               Setcolor("GR+/B")
               @ 21,59 SAY "Seguro    "
               Cor=Setcolor(Cor)
               @ 21,69 SAY wSeguroTotal                 PICT "@E 999,999.99"
               @ 22,69 SAY W_GRTO+T_Garant+wSeguroTotal PICT "@E 999,999.99"
            Endif
      ElseIf m_tipo = 5
         Cor=Setcolor()
         Setcolor("GR+/B")
         @ 19,59 SAY "Garantia E"
         Cor=Setcolor(Cor)
         @ 19,69 SAY w_ttgaran        PICT "@E 999,999.99"
         @ 20,69 SAY M_GRTO+w_ttgaran PICT "@E 999,999.99"
         If T_plav >0
            Cor=Setcolor()
            Setcolor("GR+/B")
            @ 21,59 SAY "G Avulsa"
            Cor=Setcolor(Cor)
            @ 21,69 SAY t_plav                  PICT "@E 999,999.99"
            @ 22,69 SAY M_GRTO+w_ttgaran+t_plav PICT "@E 999,999.99"
         Endif
      Endif
      If (m_datsi >= ctod("02/05/2016")) .and. (m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 6)
         Cor=Setcolor()
         Setcolor("GR+/B")
         @ 19,59 SAY "Garantia E"
         Cor=Setcolor(Cor)
         @ 19,69 SAY w_ttgaran        PICT "@E 999,999.99"
         @ 20,69 SAY M_GRTO+w_ttgaran PICT "@E 999,999.99"
      Endif

      SET KEY -9 TO TOTSAI
      M_ACH[&M] = STRZERO(M_QTD[&M],5)+"³"+STRZERO(M_COD[&M],6,0)+"³"+SUBSTR(CD_PROD,1,30)+" "+SUBSTR(M_COR[&M],1,6)+"  "+SUBSTR(M_SAID[&M],1,8)+" "+STR(M_PRE[&M],11,2)

      LIN = LIN + 1
      IF M_TOTS="S"
         CONTINUA="S"
         Exit
      ENDIF

      IF LIN > 16
         SCRSAID()
         LIN = LIN - 1
      Endif

      Sele 3
      Set Order to 1
      If xy_cap_int = "CC"         // Lojas da Capital ( filiais.dbf )
         M_TXE = M_TXE + M_FRT
         If (m_co <> 10086) .and. (m_co <> 10765)  // Antena Parabolica nao cobra montagem na Capital
            M_TXM = M_TXM + M_MON
         Endif                     // Taxa de Montagem P/ Capital
      Endif

      M_TCOM = M_TCOM +((M_T*M_COM[&M])/100)
      M_SQTD = M_SQTD +M_QUANT    // Somatorio de quantidade
      M_SPRD = M_SPRD +1          // Somatorio de Produtos

      @ 22,01 SAY STRZERO(M_SQTD,5)
      @ 22,07 SAY STRZERO(M_SPRD,5)
      @ 22,30 SAY M_TCOM PICT "@E 999,999.99"
      @ 22,43 SAY M_COM[&M] PICT "999.99"+"%"


      wCodigoC = M_COD[&M]
      M = STRZERO(VAL(M)+1,2,0)

      M_CODIMEI  = 0
      M_Imei[&m] = space(15)

      wCodigoComp:=RetDeparaComp(wCodigoC)   // Retorna Codigo para venda com relacionamento
      If wCodigoComp >0
         Alert("Aten‡„o!; Este Codigo Precisa do Seu Componente: "+Str(wCodigoComp))
      Endif

      IF M_SPRD > 28     // quantidade de itens por venda 29
         TOTSAI()
      ENDIF

      Sele 3
      Set Order to 1
  ENDDO
  SET KEY -9 TO
  IF M_AJUST = "N"
     M_TOTS = "S"
  ENDIF

  M_MINANT=0
  IF M_TOTS = "S"
     CONTINUA="S"
     While CONTINUA = "S"
       IF M_TIPO = 3 .or. M_TIPO = 6
          If M_GRTO > 2500     && SE A VENDA FOR EM CARNET E MAIOR QUE 2500
             M_AUTO=0
             SETCOLOR(C_CORG)
             AUT=SAVESCREEN(12,13,16,42)
             SOMBRA(12,13,15,40,BOX)
             SETCOLOR("W+/B+")
             @ 13,14 SAY " Venda Acima do Valor "
             SETCOLOR("BG+/B")
             @ 14,14 SAY 'Consulte Gerente'
             Inkey(0)
             RESTSCREEN(12,13,16,42,AUT)
             SETCOLOR(COR)
          Endif
       ELSEIF M_TIPO = 2 .AND. M_GRTO > 2500     && SE A VENDA FOR EM CHEQUE E MAIOR QUE 2500
          M_AUTO=0
          SETCOLOR(C_CORG)
          AUT=SAVESCREEN(12,13,16,42)
          SOMBRA(12,13,15,40,BOX)
          SETCOLOR("W+/B+")
          @ 13,14 SAY " Venda Acima do Valor "
          SETCOLOR("BG+/B")
          @ 14,14 SAY 'Consulte Gerente'
          Inkey(0)
          RESTSCREEN(12,13,16,42,AUT)
          SETCOLOR(COR)
       ENDIF

       M_TEX   = SAVESCREEN(00,00,24,79)
       M_TELAX = SAVESCREEN(16,01,21,50)
       M_NOTT  = M_GRTO                       // TOTAL DA NOTA

       @ 20,65 SAY M_NOTT+w_ttgaran PICT "@E 999,999,999.99"

       Stor 0 to M_VRFIN
       If M_TIPO = 4 .OR. M_TIPO = 8 .or. m_tipo = 9 .or. m_tipo = 10
          M_VRFIN = m_vrentr
          m_entcc=SaveScreen(11,05,14,40)
          SOMBRA(11,05,13,31,BOX)
          @ 12,06 SAY 'VALOR ENTRADA 'Get M_VRFIN PICT "@E 999,999.99" valid M_VRFIN <= M_NOTT+w_ttgaran
          READ
          RestScreen(11,05,14,40,m_entcc)
       Endif

       STOR 0 TO M_VRP1,M_VRP2,M_VRP3,M_VRP4,M_NUM2,M_NUM3,M_NUM4
       STOR CTOD("  /  /    ") TO M_DTA1,M_DTA2,M_DTA3,M_DTA4,M_DTA5,M_DTA6,M_DTA7,M_DTA8,M_DATX

       wValorSeguro = 0
       If M_TIPO = 2 .or. M_TIPO = 3 .or. M_TIPO = 6 .or. M_TIPO = 10
          wProssegue:=ResumoCarne(M_NOTT,wValorSeguro)
          If wProssegue = .f.
             Exit
          Endif
       Endif

       ** FIM
       If(Alert( "Confirma Opera‡„o. ", {"Sim ","N„o "})) = 1
          PROCESS2OR()
          R_ReleaseOrca()
          Exit
       Else
          nResp:=0
          If(Alert( "Continua ?", {"Sim ","N„o "})) = 1
             Loop
          Else
             Exit
          Endif
       Endif
     Enddo
  Endif
Enddo
Return

//*********************
  Procedure ResumoCarne(M_NOTT,wValorSeguro)  // Fechamento da Venda no Carne Zenir
//*********************
Local wRet
wRet = .t.

While .t.
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
  If wValorSeguro > 0
     cor=setcolor()
     @ 17,02 say M_NOTT Pict "@E 999,999.99"
     setcolor("GR+/W")
     @ 18,02 say "Seguro"
     setcolor(cor)
     @ 19,02 say wValorSeguro Pict "@E 999,999.99"
     setcolor("GR+/W")
     @ 20,02 say "SubTotal"
     setcolor(cor)
     M_NOTT = M_NOTT + wValorSeguro
     @ 21,02 say M_NOTT Pict "@E 999,999.99"
     setcolor(cor)
  Else
     @ 17,02 say M_NOTT Pict "@E 999,999.99"
  Endif

  @ 17,12 say M_ENTRAD Pict "@E 99,999.99"
  M_VRP1=M_ENTRAD
  @ 17,23 SAY M_NOTT-M_ENTRAD PICT "@E 999,999.99"
  If w_ttgaran > 0
     cor=setcolor()
     setcolor("GR+/W")
     @ 19,15 SAY "G Estend"
     setcolor(cor)
     @ 19,23 SAY w_ttgaran PICT "@E 999,999.99"
  Endif
  @ 17,37 GET M_NUM1 PICT "99" VALID M_NUM1 > 0 .AND. M_NUM1 < 25
  Read
  M_VRP1 = Round(((M_NOTT-M_ENTRAD) / M_NUM1),4)
  If m_plm = 1
     @ 17,41 GET M_VRP1 PICT "@E 999,999.99"
  Else
     @ 17,41 SAY M_VRP1 PICT "@E 999,999.99"
  Endif
  M_DATT   = M_Ultima
  S_DIA   := SOMADD(M_Ultima)
  M_DTA1   = M_ULTIMA + S_DIA
  M_DAT1   = M_DTA1
  M_DIA1   = DTOC(M_DTA1)
  M_DATLIM = M_DATA + 125      // margem de seguranca
  @ 17,55 GET M_DTA1 VALID M_DTA1 >= M_DATA .AND. M_DTA1 < M_DATLIM
  If M_NUM1=1
     M_DATT = M_ULTIMA
     S_DIA := SOMADD(M_DATT)
     M_DATX = M_ULTIMA+S_DIA
     M_DAT1 = M_DATX
  Endif

  wNum ="1"
  For i = 2 to m_num1
     wNum   = Alltrim(str(i))
     wNumx  = Alltrim(str(i-1))
     S_Dia := SOMADD(M_DAT&wNumx)
     M_DAT&wNum = M_DAT&wNumx+s_dia
  Next

  M_DATX = M_Dat&wNum
  @ 17,68 GET M_DATX VALID M_DATX >=M_DATA
  @ 18,37 GET M_NUM2 PICT "99"
  @ 18,41 GET M_VRP2 PICT "@E 999,999.99"
  @ 18,55 GET M_DTA3
  @ 18,68 GET M_DTA4
  @ 19,37 GET M_NUM3 PICT "99"
  @ 19,41 GET M_VRP3 PICT "@E 999,999.99"
  @ 19,55 GET M_DTA5
  @ 19,68 GET M_DTA6
  If w_ttgaran >0
     If t_plav > 0
        If M_NUM1 >= 3
           m_vezesgr = 3
        Else
           m_vezesgr = M_NUM1
        Endif
     Else
        m_vezesgr = M_NUM1
     Endif
     m_num4 = m_vezesgr
     m_vrp4 = w_ttgaran / m_vezesgr
     m_dta7 = m_dta1
     m_dta8 = m_dta1+60
     @ 20,37 GET M_NUM4 PICT "99" valid m_num4 < 13
     @ 20,41 GET M_VRP4 PICT "@E 999,999.99"
     @ 20,55 GET M_DTA7
     @ 20,68 GET M_DTA8
  Else
     @ 20,37 GET M_NUM4 PICT "99"
     @ 20,41 GET M_VRP4 PICT "@E 999,999.99"
     @ 20,55 GET M_DTA7
     @ 20,68 GET M_DTA8
  Endif
  Read
  m_dta2 = m_datx
  Release M_DATLIM
  If Flag = 1
     m_dias = m_dta1 - m_datsi
     If m_dias > I_DIAS_M + 10
        Alert("Prazo de Venda Fora das Normas p/ Moveis")
     Endif
  Else
     m_dias = m_dta1 - m_datsi
     If m_dias > I_DIAS_E + 10
        Alert("Prazo de Venda Fora das Normas p/ Eletro")
     Endif
  Endif

  M_TOTT = Round(((M_VRP1*M_NUM1)+(M_VRP2*M_NUM2)+(M_VRP3*M_NUM3)+(M_VRP4*M_NUM4)+M_ENTRAD),4)
  @ 21,41 SAY M_TOTT  PICT "@E 999,999.99"

  If STR(M_TOTT,10,2) > STR(M_NOTT+w_ttgaran+1,10,2) .OR. STR(M_TOTT+1,10,2) < STR(M_NOTT+w_ttgaran,10,2)
     nResp:=0
     nResp:=Alert("Plano N„o Confere. Abandona Or‡amento ?", {"Sim ","N„o "})
     If nResp=2
        Loop
     Else
        CONTINUA = "N"
        M_TOTS   = "N"
        M_AJUST  = "S"
        wRet     = .F.
        Exit
     Endif
  Endif
  M_NUM=M_NUM1+M_NUM2+M_NUM3+M_NUM4
  Exit
Enddo
Return(wRet)

//***************
  PROC PROCESS2OR            && PROCESSAMENTO DO ORCAMENTO DE VENDA
//***************
 STOR 0 TO M_TOTCOMP,M_RESERV
 SETCOLOR("BG+/B+")
 Stor 0 to m_grs,m_plano
 If m_tipo = 2 .or. m_tipo = 3 .or. m_tipo = 6
    @ 17,02 clear to 21,77
 Endif
 @ 18,26 to 21,26
 @ 18,54 to 21,54
 /*
  @ 17,28 SAY "N§ da Reserva"
  @ 18,28 GET M_RESERV PICT "9999999999999999"
 */
 If xy_cap_int = "CC"      // Lojas da Capital ( filiais.dbf )
    @ 19,28 SAY "Taxa de Entrega    "Get m_txe    pict "@E 999.99"
    @ 20,28 SAY "Taxa de Montagem   "Get m_txm    pict "@E 999.99"
    Read
 Else
    Stor 0 to m_txm
 Endif
 Read
 If CPFX = "   .   .   -  "
    CPFX = SPACE(14)
 Endif

 Stor 0 to wValorPrest

/*
 If M_Tipo = 3                        // Seguro PrestaMista
    M_CT = 1
    While M_CT <= VAL(m) - 1
      If m_ct = 1
         wVezes = M_VEZES[M_CT]
      Endif
      M_CT++
    Enddo

    telentr=savescreen(10,01,22,72)
    wTotalVenda = (m_nott+m_txe+m_txm+w_ttgaran) - M_ENTRAD
    If wTotalVenda < 5000
       wValorSeguro = (wTotalVenda * 6) / 100
    Else
       wValorSeguro = 300
    Endif
    wValorPrest = wValorSeguro / wVezes

    Set Message to 22 Center
    Sombra(11,12,20,62,box)
    Padrao()  //cores
    @ 22,01 clear to 21,58
    MOV_LINHA := 11; MOV_COLUNA := 12
    JANELA( MOV_LINHA, MOV_COLUNA, MOV_LINHA + 9, MOV_COLUNA + 51, "Seguro PrestaMista" )
    SETCOLOR( CONTECOR[ 11 ] + "," + CONTECOR[ 9 ] + ",,," + CONTECOR[ 8 ] )
    @ 13,14 Say  " Valor do Seguro PrestaMista       R$ "+Str(wValorSeguro,9,2)
    @ 14,14 Say  " Valor Acrescido em cada Presta‡„o R$ "+Str(wValorPrest,9,2)
    @ 15,14 Say  "                                      ---------"
    @ 16,14 Say  " Valor Total com Seguro            R$ "
    @ 16,col() Say  wTotalVenda+wValorSeguro pict "@E 99,999.99"
    @ 18,20 Prom " Quero o Seguro"
    @ 18,39 Prom " N„o Quero "
    Menu to wOpcaoSeg
    Restscreen(10,01,22,72,telentr)
    If wOpcaoSeg = 1
       wProssegue:=ResumoCarne(M_NOTT,wValorSeguro)
       If wProssegue = .f.
          R_ReleaseOrca()
          Return
       Endif
    Else
       wValorSeguro = 0
    Endif
 Endif
*/

 Sele 25
 Set Order to 1
 If BloqReg(0)
    Go Bott
    M_NOTA = CD_CODIOR + 1
    If AdiReg(0)
       Repl CD_CODIOR With M_NOTA
    Endif
    m_recno=recno()
 Endif
 Comm
 Unlock

 M_CT = 1
 While M_CT <= VAL(m) - 1
   If m_ct = 1
      Go m_recno
      If BloqReg(0)
      Endif
   Else
      If AdiReg(0)
      Endif
   Endif
   Repl CD_CODIOR WITH M_NOTA,CD_DATAO WITH M_ULTIMA,CD_CODICL WITH M_CLIE,CD_NOMECL WITH M_NOME,CD_CGF WITH M_CGF,CD_NSERIE WITH wnSerie[M_CT],;
        CD_QUANT WITH M_QTD[M_CT],CD_CODI WITH M_COD[M_CT],CD_PROD WITH M_PRD[M_CT],CD_UNIT WITH M_PRE[M_CT],CD_PMISTA WITH wValorSeguro,;
        CD_VENDED WITH V_NOME,CD_CODVEN WITH M_VEND,CD_NUMPRE WITH M_NUM,CD_TIPOV WITH M_TIPO,CD_VEZES WITH M_VEZES[M_CT],CD_RETIRA WITH wEntrega[M_CT],;
        CD_ENTRA WITH M_ENTRAD,CD_NUM1 WITH M_NUM1,CD_NUM2 WITH M_NUM2,CD_NUM3 WITH M_NUM3,CD_NUM4 WITH M_NUM4,CD_FONE WITH Substr(FONECEL,1,11), ;
        CD_VRPARC1 WITH M_VRP1,CD_VRPARC2 WITH M_VRP2,CD_VRPARC3 WITH M_VRP3,CD_VRPARC4 WITH M_VRP4,CD_IBGE WITH M_Ibge, ;
        CD_DTA1 WITH M_DTA1,CD_DTA2 WITH M_DATX,CD_DTA3 WITH M_DTA3,CD_DTA4 WITH M_DTA4,CD_DTA5 WITH M_DTA5,CD_DTA6 WITH M_DTA6, ;
        CD_DTA7 WITH M_DTA7,CD_DTA8 WITH M_DTA8,CD_DESCO WITH M_DE[M_CT],CD_ACRES WITH M_AC[M_CT],CD_COR WITH M_COR[M_CT], ;
        CD_RG WITH M_RG,CD_ENDE WITH ENDEX,CD_CPF WITH CPFX,CD_BAIR WITH Substr(M_BAICL,1,30),CD_OBSER WITH M_OBSER,CD_FIXO WITH FON1X, ;
        CD_CEP WITH M_CEPCL,CD_CIDA WITH M_CIDACL,CD_UF WITH M_UFCL,CD_REFER WITH M_REFER,CD_SAIDA WITH M_SAID[M_CT], ;
        CD_VRFIN WITH M_VRFIN,CD_VRCAR WITH M_VRCAR,CD_CGC WITH CGCX,CD_REFER2 WITH M_REFER2,CD_RESERV WITH M_RESERV, ;
        CD_GR with "N",cd_status with "O",CD_IMEI WITH M_IMEI[M_CT],CD_CEL WITH M_CEL,CD_HORA WITH TIME(),CD_CONTAD WITH STRZERO(M_CT,3),;
        CD_AUTOR WITH M_AUTOR[m_ct],CD_VALOR WITH M_PERCENTR,CD_DEBCC WITH M_DEBCC,cd_vezesci with m_vezesci[m_ct], ;
        CD_ENDET WITH wEndTrega,CD_CIDAT WITH wCidaTrega,CD_BAIRT WITH Substr(wBairTrega,1,30),CD_CEPT WITH wCepTrega,CD_IBGET WITH wIBgeTrega, ;
        CD_UFT WITH wUFtrega,CD_NUMERO WITH M_NUMERO,CD_COMPLE WITH M_COMPLE,CD_NUMEROT WITH wNumero,CD_COMPLET WITH wCOMPLE
   If M_Ct = 1
      Repl CD_TXE WITH M_TXE,CD_TXM WITH M_TXM
   Endif
   If M_AUTOR[m_ct] >0
      Repl CD_VRCIRC WITH M_VRPLANO[m_ct]
   Endif
   If m_debcc = 2
       Repl CD_VEZES WITH 0
   Endif
   If w_garant[m_ct] > 0
      Repl cd_gr with "S",cd_dtgr with m_datsi,cd_status with "O",cd_qtdegr with w_vezesgr[m_ct], ;
           cd_vrgr with w_garant[m_ct],cd_plano with w_plano[m_ct],cd_fatorgr with m_grfator[m_ct]
           If m_tipo = 1 .or. m_tipo = 4 .or. m_tipo = 8 .or. m_tipo = 9 .or. m_tipo = 10
              Repl cd_unit With M_PRE[M_CT]
           Else
              If (m_tipo = 5) .and. (m_debcc = 6 .or. m_debcc = 7)
                 Repl cd_unit With M_PRE[M_CT]
              ElseIf m_tipo = 3 .or. m_tipo = 2
                 Repl cd_unit With M_pre[m_ct]
              Endif
           Endif
           If (m_tipo = 2 .or. m_tipo = 3) .and. M_NUM4 >0
              Repl cd_qtdegr with M_NUM4
           Endif
   ElseIf w_plav[m_ct] >0              // Venda com Garantia Avulsa
      Repl cd_status with "A",cd_vrgr with w_plav[m_ct],cd_plano with w_plano[m_ct]
   Endif
   Comm
   Unlock

   If !Empty(M_IMEI[M_CT]) .or. !Empty(wnSerie[M_CT])
      Sele 44
      If !Empty(M_IMEI[M_CT])
         Set Order to 1
         Seek M_IMEI[M_CT]
      Else
         Set Order to 6
         Seek wnSerie[M_CT]
      Endif
      If !Eof()
         If Bloqreg(0)
            Repl Orcamento with m_nota
         Endif
         Unlock
      Endif
      Sele 25
      Set Order to 1
   Endif

   M_CT++
 Enddo
 Release m_ibge

Setcolor(C_corg)
@ 08,01 clear to 17,60
@ 08,01 to 17,60
Setcolor("w*/b")
@ 08,10 Say "Confira Sua Venda !"
Setcolor("GR+/B")

Stor "n" to W_conf,W_delet,wCurso
Stor 0 to wIten,wTotv
W_Oper = Space(5)
Lin    = 9

wTemCodigoRelac = .t.             // Verifica se tem codigo relacionado
wItemZerado = .f.
wEntradaVenda = 0

Sele 25
Set Order to 1
Seek STR(M_NOTA,8,0)+SUBSTR(DTOC(M_DATSI),7,4)+SUBSTR(DTOC(M_DATSI),4,2)+SUBSTR(DTOC(M_DATSI),1,2)
w_recno=recno()
wTipo = cd_tipov
While !Eof() .and. CD_CODIOR = M_NOTA .AND. CD_DATAO = M_DATSI
  @ Lin,02 Say STRZERO(CD_QUANT,4)+" - "+STRZERO(CD_CODI,6)+"  "+SUBSTR(CD_PROD,1,40)

  If V_NOME <> CD_VENDED
     W_conf = "s"               // Coferindo se a venda eh mesmo desse vendedor
     Exit
  Endif

  If cd_unit = 0
     wItemZerado = .t.          // Venda com promocao
  Endif

  wIten++

  wTotv = wTotv + (cd_quant * cd_unit)
  If cd_entra >0 .and. wIten = 1
     wEntradaVenda = cd_entra
  Endif

  wRecOrca:=Recno()
  wCodigoComp:=RetDeparaComp(CD_CODI)           // Retorna Codigo para venda com relacionamento funcoes.prg
  If wCodigoComp >0
     wStatusCod:=VerificaCodRelac(wCodigoComp)  // Verificando orcamento funcoes.prg
     If wStatusCod = .f.
        wTemCodigoRelac = .f.
        Exit
     Endif
     Sele 25
     Set Order to 1
     Go wRecOrca
  Endif

  Sele 25
  Set Order to 1

  w_PROD = TRIM(CD_PROD)
  If(At("E-BOOK",w_PROD)) > 0
     wCurso = "s"
  Endif

  If !Empty(cd_imei) .and. Len(cd_imei) = 15
     w_PROD = TRIM(CD_PROD)
     If(At("TRIANG",w_PROD)) >0
        If(At("VIVO",w_PROD)) >0
           w_oper = "VIVO"
        Else
           If(At("CLARO",w_PROD)) >0
              w_oper = "CLARO"
           Else
              If(At("TIM",w_PROD)) >0
                 w_oper = "TIM"
              Else
                 If(At(" OI ",w_PROD)) >0
                    w_oper = " OI "
                 Else
                    If(At(".OI",w_PROD)) >0
                       w_oper = " OI "
                    Else
                       If(At(".OI ",w_PROD)) >0
                          w_oper = " OI "
                       Else
                          If(At("OI",w_PROD)) >0
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
  Lin++
  Skip
Enddo
 ww_oi = "s"                // lojas que nao pegam Oi...
 If Loja=03 .or. Loja=29 .or. Loja=30 .or. Loja=34 .or. Loja=35 .or. Loja=37 .or. Loja=51 .or. Loja=52
    ww_oi = "n"
 Endif
 If W_Oper <> Space(05) .and. ww_oi = "s"
    Go w_recno
    While !Eof() .and. CD_CODIOR = M_NOTA .AND. CD_DATAO = M_DATSI
     If Substr(CD_PROD,1,4) = "CHIP"
        w_PROD = TRIM(CD_PROD)
        w_oper = TRIM(w_oper)
        If(At(W_Oper,w_PROD)) >0
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
         wImei  = cd_imei
         wnSerie= cd_nSerie
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

       Alert("Seu Or‡amento de Venda foi Recusado. Operadoras Diferentes!;Or‡amento Deletado !")

       Release w_delet,w_prod,w_oper,w_recno
       Release all like m_prd*
       Release all like m_cod*
       Keyb(chr(27))
       Return
    Endif
 Endif
 Release ww_oi
 If W_Conf = "s"      // Nao confere com o orcamento do vendedor ( Erro na Rede )
    Go w_recno
    While !Eof() .and. CD_CODIOR = M_NOTA .AND. CD_DATAO = M_DATSI
      wImei = cd_imei
      wnSerie= cd_nSerie
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
    Alert("Sua Venda foi Recusada. Erro na Rede. Favor Refaze-la !")
    Alert("Or‡amento Deletado !")
    Release w_delet,z,w_prod,w_oper,w_recnom,W_conf
    Release all like m_prd*
    Release all like m_cod*
    Keyb(chr(27))
    Return
 Endif
 Release W_conf

 // Verificando Codigo Com Relacionamento no Orcamento
 If wTemCodigoRelac = .f.
    Alert("Seu Or‡amento de Venda foi Recusado. faltando Item de Relacionamento/Componente !")
    Go w_recno
    While !Eof() .and. CD_CODIOR = M_NOTA .and. CD_DATAO = M_DATSI
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
   Alert("Or‡amento Deletado !")
   Release all like m_prd*
   Release all like m_cod*
   Release flag,m_dias,wTotv,w_delet,z,w_prod,w_oper,w_recno,wCurso,wIten,lin,wTipo
   Keyb(chr(27))
   Return
 Endif

 If XY_CD <> "S" .and. Loja <> 15
    If wTotv = 0
       Alert("Seu Or‡amento de Venda foi Recusado. Item Zerado !")
       Go w_recno
       While !Eof() .and. CD_CODIOR = M_NOTA .and. CD_DATAO = M_DATSI
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
      Alert("Or‡amento Deletado !")
      Release all like m_prd*
      Release all like m_cod*
      Release flag,m_dias,wTotv,w_delet,z,w_prod,w_oper,w_recno,wCurso,wIten,lin,wTipo
      Keyb(chr(27))
      Return
    Endif
 Endif

 If wCurso = "s" .and. wIten = 1 .and. (wTipo = 2 .or. wTipo = 3 .or. wTipo = 6)
    Alert("Seu Or‡amento de Venda foi Recusado. Modalidade N„o Permitida !")
    Go w_recno
    While !Eof() .and. CD_CODIOR = M_NOTA .and. CD_DATAO = M_DATSI
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
    Alert("Or‡amento Deletado !")
 Endif
 M_Valord = M_NOTA

 wSt := VerificaOrdem(M_NOTA)            // Verifica se tem orcamento com valor zerado fora da sequencia
 If wSt = .t.
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
    Alert("Seu Or‡amento de Venda foi Recusado. Valor zerado tem que ser no segundo item !; Or‡amento Deletado !")
    Release w_delet,w_prod,w_oper,w_recno
    Release all like m_prd*
    Release all like m_cod*
    Keyb(chr(27))
    Return
 Endif

 If wItemZerado = .t.        // Verificando saida dos items com promocao
    Sele 25
    Set Order to 1
    Go w_recno
    wConfSaida=Trim(cd_saida)
    W_Delet  = "n"
    While !Eof() .and. CD_CODIOR = M_NOTA .AND. CD_DATAO = M_DATSI
      If Trim(cd_saida) <> wConfSaida
         W_Delet = "s"
         Exit
      Endif
      Skip
    Enddo
    If W_Delet = "s"
       Go w_recno
       While !Eof() .and. CD_CODIOR = M_NOTA .AND. CD_DATAO = M_DATSI
         If Bloqreg(0)
            Delete
         Endif
         Comm
         Unlock
         Skip
       Enddo
       Alert("Seu Or‡amento de Venda foi Recusado. Saidas Diferentes c/Promo‡ao!;Or‡amento Deletado !")
       Release w_delet,w_prod,w_oper,w_recno,wConfSaida,wItemZerado        // Verificando saida dos items com promocao

       Release all like m_prd*
       Release all like m_cod*
       Keyb(chr(27))
       Return
    Endif
 Endif


/*
 Status_r := Pega_Reserva(m_nota,wOpcao)         // Pegando Reserva On Line pelo Orcamento
 If Status_r <> "ok"
    Alert(Status_r)
    Alert("Fazer Reserva Por Telefone !")
 Endif
 Release Status_r,wConfSaida,wItemZerado
*/

// Reuniao em 24/01/2022 com Equipe de TI, CDZ e Alex  (Reservar no Pagamento da Venda - Crediario, Caixa)

 Visor()

 If m_plano >0 .and. m_plano < 4
    Set Color to
    Keyb(chr(13))
    GrCad(m_nota,m_plano)     //  Cadastro de garantia Estendia (GR.PRG)
 Endif
 Release w_delet,z,w_prod,w_oper,w_recno,wCurso,wIten,lin,wTipo

 Return


//***************************************************************************
// Procedimento Anterior de Reserva pelo orcamento em 24/01/2022
//***************************************************************************

 wtesteOrcam = alltrim(str(m_nota))
 !touch /tmp/orca_&wtesteOrcam

 wFase = "inicio de Orcamento, enviando ao Postgres "+wtesteOrcam
 !echo &wFase >> /tmp/orca_&wtesteOrcam

 @ 23,27 Say "Acessando Banco De Dodos PostGres"

 Stor "" to wSaidaCDs,wFilial
 SaidaCDSN = "N"
 wIdoDoo:=InsereOrcamento(M_Nota,V_CPF,@wSaidaCDs,@SaidaCDSN,@wFilial)      // funcoes.prg

 wFase = "Orcamento enviado ao Postgres "
 !echo &wFase >> /tmp/venda_&wtesteVenda

 If !Empty(wSaidaCds) .and. !Empty(wFilial)
    If SaidaCDSN = "N"
       wFase = "Orcamento sem Saida CD "+Trim(wSaidaCDs)
       !echo &wFase >> /tmp/venda_&wtesteVenda
    ElseIf SaidaCDSN = "S"
       wFase = "Orcamento com Saida CD "+Trim(wSaidaCDs)
       !echo &wFase >> /tmp/venda_&wtesteVenda
    Endif
    If wIdoDoo >0 .and. SaidaCDSN = "S"
       wFase = "Saida CD "+Trim(wSaidaCds)+" Com iDoDoo"
       !echo &wFase >> /tmp/venda_&wtesteVenda
    ElseIf wIdoDoo =0 .and. SaidaCDSN = "S"
       wFase = "Saida CD "+Trim(wSaidaCds)+" Sem iDoDoo"
       !echo &wFase >> /tmp/venda_&wtesteVenda
    Endif
 Else
    wFase = "Sem Retorno da IPI ou CD nao Migrado"
    !echo &wFase >> /tmp/venda_&wtesteVenda
 Endif

 If wIdoDoo >0 .and. SaidaCDSN = "S"

    wCnpjFilial:=Ret_NUm(xy_cgc)

    wVez   = 0
    Pega_IdOdoo := ""
    w_arq := "/tmp/orcamento_"+Alltrim(Str(wIdoDoo))+".txt"
    While .t.
      wVez++
      If wVez > 4
         wFase = "Nao Conseguiu fazer a reserva no oDoo pela "+Str(wVez)+"a. Tentativa  - "+time()
         !echo &wFase >> /tmp/orca_&wtesteOrcam
         Exit
      Endif
      // Grava ID do oDoo no ERP
      if !File("&w_arq")
         wFase = "Enviando Orcamento para o oDoo com ID: "+Alltrim(str(wIdoDoo))+" Tentativa: "+Str(wVez)+" a. - "+time()
         !echo &wFase >> /tmp/orca_&wtesteOrcam

         @ 23,27 Say "Enviando Dados para o oDoo...... Tentativa  "+Str(wVez)+" a."
         wEnvia:="python3.6 /opt/odoo_rpc/envia_orcamento_filial.py criar -o "+Str(wIdoDoo)+" -e "+wCnpjFilial
         !&wEnvia
      Endif
      // Lendo Arquivo txt do oDoo
      wFase = "Lendo Arquivo gerado pelo RPC no /tmp  Tentativa "+Str(wVez)+" a. - "+time()
      !echo &wFase >> /tmp/orca_&wtesteOrcam

      If File("&w_arq")
         resPid  := MemoRead("&w_arq")
         wLen    := Len(resPid)
         Pega_IdOdoo := Substr(resPid,1,wLen)
         wFase = "Gravando IDoDoo no DBF: "+Pega_IdOdoo
         !echo &wFase >> /tmp/orca_&wtesteOrcam

         Sele 25
         Set Order to 1
         Seek Str(m_nota,8,0)
         While !Eof() .and. cd_codior = m_nota
           If Bloqreg(0)
              Repl cd_iD with Val(Pega_IdOdoo)
           Endif
           Comm
           Unlock
           Skip
         Enddo
         Exit
      Endif
    Enddo
    If !File("&w_arq")
       wFase = "Arquivo Nao Encontrado: "+w_arq
       !echo &wFase >> /tmp/orca_&wtesteOrcam
    Endif
    *DeleteFile("&w_arq")
 ElseIf wIdoDoo = 0  .and. SaidaCDSN = "S"
    Alert("Sem Retorno de Numero de Or‡amento no Banco de Dados !")
 Endif

Release all like m_prd*
Release all like m_cod*
Release flag,m_dias,wFase
Keyb(chr(27))
Return

//*********************
  Function Pega_Reserva(wOrca,wOpcao)           && Reserva de Produtos que nao irao sair do Mostruario
//*********************
  Local wRet
  wRet = "ok"
  mlj = alltrim(strzero(Loja,2))
  Go w_recno
  While !Eof() .and. CD_CODIOR = M_NOTA .and. CD_DATAO = M_DATSI
   If cd_saida <> Trim("LOJA/") .and. cd_saida <> Trim("DEP") .and. (CD_RESERV = 0)
      wSaida := substr(cd_saida,1,13)
      wCdz   := 0
      Sele 3
      Set Order to 1
      Seek CDSIE->CD_CODI
      If CDSIE->CD_CODI >5 .and. !Eof()
         If CD_RESERVA = "N"
            wRet := "Reserva C/ Autorizacao do Setor de Compras !"
            Exit
         Endif
         If cd_grup = 11 .or. cd_grup = 12 .or. cd_grup = 14 .or. cd_grup = 8
            wRet :="Produtos Reservados p/ Administra‡„o. "
            Exit
         Endif
      Endif

      Stor 0 to wCdz,wRota,wDest
      Sele 12
      Veriout(setcolor(),23,"saida_item")
      Go Top
      While !Eof()
       If Substr(Saida_item,1,7) = Substr(wSaida,1,7)
          wCdz  = Loja
         *wRota = Rota
          wRota = 0
          wDest = Destino
          Exit
       Endif
       Skip
      Enddo
      Use
      If wCdz = 0
         Alert("Error na saida !")
      Endif
      If wCdz <> 10 .and. wCdz <> 11 .and. wCdz <> 19 .and. wCdz <> 20 .and. wCdz <> 99 .and. wCdz <> 44 .and. wCdz <> 15
         Release wSaida,wCdz
         wRet := "Conex„o Inv lida. Somente com os CD's !"
         Exit
      Endif

      If wOpcao = 4                   // Escolha de Outras como Reserva (Estoque Minimo)
         If wCdz = 44                 // Situacao entre loja e CD Diferentes por serem distantes
            Release wSaida,wCdz
            wRet := "Conex„o Inv lida. Somente com os CD's !"
            Exit
         Endif
      Endif

      wrr=savescreen(18,10,20,56)
      @ 18,10 to 20,55
      Setcolor("br+/b")
      @ 19,11 say "Efetuando reserva on line com "
      Setcolor("w+/b")
      @ 19,41 say wSaida
      Inkey(1)

     Restscreen(18,10,20,56,wrr)
     Release wrr

     Sele 12
     Veriout(SETCOLOR(),23,"filiais")
     Go Top
     While !Eof()
       If Val(Fili) = wCdz
          x_IP     = Trim(Ip_Tunel)
          w_Reserva= Reserva
          wCnpjCD  = Ret_Num(cgc)
          Exit
       Endif
       Skip
     Enddo
     Use

     Sele 25
     Set Order to 1
     Cor=Setcolor()
     Setcolor("b*/w")
     @ 15,22 Say "Conectando Atraves de IpTunel"

     Setcolor(Cor)
     Stor "" to w_Porta
     If (Loja=15 .and. wCdz=20)
        m_Ip = "127.0.0.1"                  // Mesmo Servidor
        w_Ip = "127.0.0.1"                  // Mesmo Servidor
     Else
        m_ip := TestaCon("Loja","","","")
        If Empty(m_ip)
           Return
        Else
           wLja = ""
           w_ip := TestaCon("Destino",wLja,x_ip,Strzero(wCdz,2))
           If Empty(w_ip)
              Return
           Endif
        Endif
     Endif

     wVended := Alltrim(cd_Vended)
     wVended := strtran("&wVended"," ","_",,,.T.)

     w_arq := "/tmp/RE"+Pid+"_"+alltrim(Str(cd_codi))+alltrim(str(wOrca))

     If File("&w_arq")
        DeleteFile("&w_arq")
     Endif

     mljx := mlj
     z:=At("/",cd_saida)
     If z != 0
        mljx := CharOnly("0123456789",cd_saida)
     Endif

     cHoras := Substr(time(),1,2)+Substr(time(),4,2)+Substr(time(),7,2)
     wHoras := Val(cHoras)

     m_ssh = 'ssh -C -l pegareserva '+w_Ip+' &W_Porta -t -q "/zenir/modulo/pegareserva/pegareserva "'+mlj+" "+mljx+" "+alltrim(str(cd_codi))+" "+alltrim(str(cd_quant))+" "+alltrim(strzero(cd_codven,3))+" "+alltrim(wVended)+" "+alltrim(str(cd_codior))+" "+m_ip+" "+Alltrim(Strzero(wCdz,2))+" "+cHoras+" "+Pid+" "+Alltrim(Strzero(wRota,2))+" "+Alltrim(Strzero(wDest,2))+" "+"Reservar"
     *Alert(m_ssh)
     !&m_ssh

     Pega_Res := ""
     If File("&w_arq")
        resPid   := MemoRead("&w_arq")
        W_Len    := Len(resPid)
        Pega_Res := Substr(resPid,1,w_Len)
        DeleteFile("&w_arq")
        Release w_len,resPid

        If Bloqreg(0)
           Repl cd_reserv with val(Pega_Res)
        Endif
        Unlock
        wUltRecno = Recno()
        wCodPres  = cd_codi
        wQuantres = cd_quant

        Ok := Verif_Res(wOrca)  // Verifica se ha reserva duplicada (siste.prg)
        /*
        If Ok = "Ok"
           stFil:=ConfigLoja(I_FilOrigem,wCdz)   // funcoes.prg
           If stFil = .T.
              wEnvia:="/opt/odoo_rpc/reserva_odoo.py criar -o "+Ret_num(xy_cgc)+" -d "+wCnpjCD+" -p "+alltrim(Str(wCodPres))+" -q "+Alltrim(Str(int(wQuantres)))+" -m "+Pega_Res
              !&wEnvia
           Endif
           Alert("Reserva Ok "+Pega_Res)
        Endif
        */
        Sele 25
        Set Order to 1
        Go wUltRecno
     Else
        Alert("Reserva N„o Localizada !")
     Endif
   Endif
   Skip
  Enddo
  Release w_arq,wNumRes,Pega_Res,w_len,respid,wVended,wConect,wHoras,Ok,wUltRecno,W_RESERVA,wConOper
Return(wRet)

//***********************
  Procedure VerificaOrdem(wOrca)
//***********************
  Local wRet,wNumItem
  wRet = .f.
  wNumItem = 1
  Sele 25
  Set Order to 1
  Go Top
  Seek Str(wOrca,8,0)
  While !Eof() .and. cd_codior = wOrca
    If cd_unit = 0 .and. wNumItem = 1
       wRet = .t.
       Exit
    Endif
    wNumItem++
    Skip
  Enddo
Return(wRet)

//*************************
  Procedure ConsultaSaldoCD(wCodi,wQuant,wVend,wVended,wSaida,wCdz)
//*************************

 Sele 12
 Veriout(SETCOLOR(),23,"filiais")
 Go Top
 While !Eof()
  If Val(Fili) = wCdz
     x_IP = Trim(Ip_Tunel)
     Exit
  Endif
  Skip
 Enddo
 Use
 If Empty(x_ip)
    Return("")
 Endif

 Sele 25
 Set Order to 1

 wrr=savescreen(15,22,16,57)
 Cor=Setcolor()
 Setcolor("b*/w")
 @ 15,22 Say "Conectando ao CD Atraves de IpTunel"
 Setcolor(Cor)
 inkey(1)

 Stor "" to w_Porta
 If (Loja=15 .and. I_Priorid=20)
    m_Ip = "127.0.0.1"                  // Mesmo Servidor
    w_Ip = "127.0.0.1"                  // Mesmo Servidor
 Else
    m_ip := TestaCon("Loja","","","")
    If Empty(m_ip)
       Return
    Else
       wLja = ""
       w_ip := TestaCon("Destino",wLja,x_ip,Strzero(I_Priorid,2))
       If Empty(w_ip)
          nResp:=0
          If(Alert("Pegar Reserva Manual Nesse CD ou Verifica o Proximo ?", {"Reservar Manual ","Verificar Proximo CD"})) = 1
             Pega_Res = "Link Fora"
             Return(Pega_Res)         // Reservar Manual
          Else
             Return
          Endif
       Endif
    Endif
 Endif

 wVended := Substr(wVended,1,3)

 w_arq := "/tmp/RE"+Pid+"_"+alltrim(Str(wCodi))+alltrim(str(wVend))

 If File("&w_arq")
    DeleteFile("&w_arq")
 Endif

 mlj  = alltrim(strzero(Loja,2))
 mljx = mlj
 If(At("/",wSaida)) > 0
    mljx := CharOnly("0123456789",wSaida)
 Endif

 cHoras  = Substr(time(),1,2)+Substr(time(),4,2)+Substr(time(),7,2)
 wHoras  = Val(cHoras)

 Stor 0 to  wDest,wOrcamen,wRota

 *m_ip = "168.190.30.240"   // IP de Teste (Deletar) 

 *m_ssh = 'ssh -C -l pegareserva '+w_Ip+' &W_Porta -t -q "/zenir/modulo/pegareserva/pegareservax "'+mlj+" "+mljx+" "+alltrim(str(wCodi))+" "+alltrim(str(wQuant))+" "+alltrim(strzero(wVend,3))+" "+alltrim(wVended)+" "+alltrim(str(wOrcamen))+" "+m_ip+" "+Alltrim(Strzero(wCdz,2))+" "+cHoras+" "+Pid+" "+Alltrim(Strzero(wRota,2))+" "+Alltrim(Strzero(wDest,2))+" "+"ConsultaSaldo"
  m_ssh = 'ssh -C -l pegareserva '+w_Ip+' &W_Porta -t -q "/zenir/modulo/pegareserva/pegareserva "'+mlj+" "+mljx+" "+alltrim(str(wCodi))+" "+alltrim(str(wQuant))+" "+alltrim(strzero(wVend,3))+" "+alltrim(wVended)+" "+alltrim(str(wOrcamen))+" "+m_ip+" "+Alltrim(Strzero(wCdz,2))+" "+cHoras+" "+Pid+" "+Alltrim(Strzero(wRota,2))+" "+Alltrim(Strzero(wDest,2))+" "+"ConsultaSaldo"
 !&m_ssh

 If File("&w_arq")
    ResPid   := MemoRead("&w_arq")
    W_Len    := Len(resPid)
    Pega_Res := Substr(resPid,1,w_Len)
    DeleteFile("&w_arq")
    Release w_len,resPid
 Else
    Pega_Res := "Reserva N„o Localizada !"
 Endif

 restscreen(15,22,16,57,wrr)
 Release wrr,ResPid,W_Len,wDest,wOrcamen,wRota,m_ssh,mljx,mlj,wLja,w_ip,m_ip,cHoras,wHoras

Return(Pega_Res)

//****************
  PROCEDURE TOTSAI
//****************
M_TOTS="S"
M_CONT="N"
PROCES=1
KEYB(CHR(27))

//*****************
  PROCEDURE SCRSAID
//*****************
/* Rola tela */
CORA = SETCOLOR()
SET COLOR TO
SCROLL(9,1,16,5,1)
SCROLL(9,7,16,12,1)
SCROLL(9,13,16,78,1)
SETCOLOR(CORA)
RETURN

//*******************************CONCERTA LANCAMENTO***********************
//*****************
  PROCEDURE EDIYTOR
//*****************
  LINANT=ROW()
  WHILE .T.
      COR=SETCOLOR()
      LINA=ROW()
      ED=SAVESCREEN(09,01,23,78)
      SETCOLOR("W+/BG+, B/RG,X")
      M_OPCA = ACHOICE(9,1,20,78,M_ACH)
      LIN=ROW()
      M_GR=0
      CLEAR GETS
      SETCOLOR("W+/BG+, B/RG,X")
      IF LASTKEY() = 27
         LIN=LINANT
         EXIT
      ENDIF
      SET KEY 28 TO
      WHILE .T.
       IF LASTKEY() =  13
          MG = STRZERO(M_OPCA,2,0)
          @ LIN,01 CLEAR TO LIN,78
          IF M_OPCA > 0
             SETCOLOR("W+/BG+, B/RG,X")
             @ LIN,1 GET M_QTD[&MG] PICT "99999"
             @ LIN,7 GET M_COD[&MG] PICT "999999"
             READ
             IF LASTKEY() = 27
                LIN=LINA
                RESTSCREEN(09,01,23,78,ED)
                EXIT
             ENDIF
             SELE 3
             SET ORDER TO 1
             GOTO TOP
             IF M_COD[&MG] = 0
                @ LIN,14 SAY "REGISTRO ELIMINADO..."
                EXIT
             ENDIF
             SEEK M_COD[&MG]
             IF EOF()
                FRASE2(23,"C¢digo n„o existe... Por favor verifique.",4,,,C_CORG)
                LOOP
             ENDIF
             M_PRD[&MG] = CD_PROD
             @ LIN,14 SAY SUBSTR(CD_PROD,1,30)
             @ LIN,45 GET M_COR[&MG]  PICT "@!"
             @ LIN,53 GET M_SAID[&MG] PICT "@!S8"
             @ LIN,64 SAY M_PRE[&MG]  PICT "@E 99,999.99"
             READ
             M_STO[&M] = M_PRE[&MG] * M_QTD[&MG]
             @ LIN,65 SAY M_STO[&M] PICT '@E 99,999,999.99'
             LIN=LINA
             RESTSCREEN(09,01,23,78,ED)
             SETCOLOR(COR)
             EXIT
          ENDIF
       ELSE
          LIN=LINA
          RESTSCREEN(09,01,23,78,ED)
          SETCOLOR(COR)
       ENDIF
     ENDDO
  SET COLOR TO
  //*******************************  LIMPA TELA
  @ 09,01 CLEAR TO 20,78
  @ 09,01 SAY "     ´      ´"
  @ 10,01 SAY "     ´      ´"
  @ 11,01 SAY "     ´      ´"
  @ 12,01 SAY "     ´      ´"
  @ 13,01 SAY "     ´      ´"
  @ 14,01 SAY "     ´      ´"
  @ 15,01 SAY "     ´      ´"
  @ 16,01 SAY "     ´      ´"
  @ 17,01 SAY "     ´      ´"
  @ 18,01 SAY "     ´      ´"
  @ 19,01 SAY "     ´      ´"
  @ 20,01 SAY "     ´      ´"
  //********************************
  LIN=LINA
  SETCOLOR(C_CORN)
  LINH = 9
  M_G  = 1
  M_GR = 0
  WHILE M_G <= VAL(M) -1
   IF M_COD[M_G]>0
      @ LINH,1 SAY STRZERO(M_QTD[M_G],5)
      @ LINH,7 SAY STRZERO(M_COD[M_G],6)
      SELE 3
      SET ORDER TO 1
      GOTO TOP
      SEEK M_COD[M_G]
      @ LINH,14 SAY SUBSTR(CD_PROD,1,29)
      @ LINH,44 SAY SUBSTR(M_COR[M_G],1,7)
      @ LINH,53 SAY SUBSTR(M_SAID[M_G],1,8)
      @ LINH,61 SAY M_PRE[M_G] PICT "@E 99,999.99"
      M_ST = M_PRE[M_G] * M_QTD[M_G]
      M_GR = M_GR + M_ST
      @ LINH,70 SAY M_ST PICT "@E 99,999.99"
      @ 22,66   SAY M_GR PICT "@E 99,999,999.99"
      LINH=LINH+1
   ENDIF
   IF LINH > 20
      LINH = 20
      SCRSAID()
   ENDIF
   M_G++
  ENDDO
  Exit
ENDDO
M_GRTO = M_GR
Return

//*************
  PROC SMV09_CO          && CONSULTA ORCAMENTOS
//*************
While .T.
  Stor 0 to M_ENTRAD,M_VRP1,M_VRP2,M_VRP3,M_VRP4,M_NUM2,M_NUM3,M_NUM4,M_RESERV
  Stor CTOD("  /  /    ") to M_DTA1,M_DTA2,M_DTA3,M_DTA4,M_DTA5,M_DTA6,M_DTA7,M_DTA8,M_DATX,m_ultima

  TelVen()

  @ 23,01 clear to 23,78
  Telv=savescreen(14,01,22,78)
  SETCOLOR("n+/w")
  STOR 0 TO M_NOTA,M_GRTO
  SET CURSOR ON
  STOR SPACE(20) TO M_NOME
  STOR SPACE(14) TO CPFX
  @ 3,01 SAY "Or‡amento :"GET M_NOTA PICT "99999999" VALID M_NOTA >0
  READ
  IF LASTKEY() = 27
     Release M_ENTRAD,M_VRP1,M_VRP2,M_VRP3,M_VRP4,M_NUM2,M_NUM3,M_NUM4,WtPFIN,WtPTIPO,WsDVEZES
     Release M_DTA1,M_DTA2,M_DTA3,M_DTA4,M_DTA5,M_DTA6,M_DTA7,M_DTA8,M_DATX
     Release M_QTD,M_CODI,M_TIPO,M_NOME,ENDEX,FON1X,CGCX,CPFX,M_BAICL,M_CEPCL,T_GARANT
     Release M_CIDACL,M_UFCL,M_REFER,M_REFER2,M_OBSER,M_SAIDA,M_RG,M_DATAO,M_RESERV
     Exit
  Endif
  SELE 25
  SET ORDER TO 1
  GOTO TOP
  SEEK STR(M_NOTA,8,0)
  IF EOF()
     Alert("Or‡amento N„o Efetuado. Por favor verifique.")
     Loop
  Endif
  m_dat   = CD_DATAO
  WtPFIN  = 0
  WtPTIPO = CD_TIPOV
  WsDVEZES= CD_VEZES

  If cd_reserv >0
     cor=setcolor()
     Setcolor("b/w")
     @ 22,01 Say "Reserva "+Strzero(cd_reserv,12)
     Setcolor(cor)
  Endif
  Sele 4
  Set Order to 15
  While .t.
    Seek str(m_nota,8,0)+substr(dtoc(m_dat),7,4)+substr(dtoc(m_dat),4,2)+substr(dtoc(m_dat),1,2)
    If Eof()
       m_dat=m_dat+1
       If m_dat > m_datsi
          Exit
       Endif
    Else
        Exit
    Endif
  Enddo
  If !Eof()
     WtPFIN  = SD_TPFIN
     WtPTIPO = SD_TIPO
     WsDVEZES= SD_VEZES
  Endif
  If Sd_Nota >0
     cor=setcolor()
     Setcolor("n/w")
     @ 03,49  SAY "Venda Efetuada Minuta "+Strzero(sd_nota,8)
     setcolor(cor)
  Endif
  While .T.
    SETCOLOR("W+/B")
    @ 6,40 clear to 6,75
    IF LASTKEY() = 27
       EXIT
    ENDIF
    SELE 25
    SET ORDER TO 1
    GOTO TOP
    SEEK STR(M_NOTA,8,0)
    IF EOF()
       FRASE2(23,"Final de arquivo ou Or‡amento Inexist.Pressione uma tecla.",,,,C_CORG)
       EXIT
    ENDIF
    @ 5,13 SAY CD_DATAO
    @ 5,32 CLEAR TO 05,77
    @ 5,32 SAY STRZERO(CD_CODICL,6) + " " + TRIM(CD_NOMECL)
    @ 6,13 SAY STRZERO(CD_CODVEN,3)+" "+SUBSTR(CD_VENDED,1,10)
    cor=setcolor()
    Setcolor("b/w")

    Stor "" to  m_tpfin,m_texto
    Ret_TipoVenda(WtPFIN,WtPTIPO,WsDVEZES,@m_texto,@m_tpfin)    // Funcoes.prg
    @ 22,27 Clear to 22,78
    @ 22,27 Say m_Texto
    Setcolor(cor)
    LIN = 9
    PRIV M_ACHE[30]
    M="01"
    STOR 0 TO M_TOTA,QUANT,M_DESCO,M_GRTO,M_STO,T_GARANT,T_AVULSO
    STOR 0 TO m_txe,m_txm
   WHILE !EOF() .AND. CD_CODIOR = M_NOTA
      M_QTD   = CD_QUANT
      M_CODI  = CD_CODI
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
      M_NOME  = CD_NOMECL
      M_CLIE  = CD_CODICL
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
      M_DATAO = CD_DATAO
      V_NOME  = CD_VENDED
      M_VEND  = CD_CODVEN
      M_COR   = CD_COR
      M_VRFIN = CD_VRFIN
      M_VRCAR = CD_VRCAR
      M_RESERV= CD_RESERV
      If CD_TXE >0
         M_TXE  = CD_TXE
      Endif
      If CD_TXM >0
         M_TXM = CD_TXM
      Endif
      M_ULTIMA=CD_DATAO
      M_GRT   =CD_GR
      M_PLANO =CD_PLANO
      M_IMEI  =CD_IMEI
      M_CEL   =CD_CEL
      M_ALT   ="N"
      M_TOTA = M_TOTA + (CD_UNIT * CD_QUANT)
      M_GRTO = M_TOTA
      @ 22,69 SAY M_TOTA    PICT "@E 999,999.99"
      QUANT=QUANT+CD_QUANT
      T_Garant = T_Garant + (CD_QUANT*CD_FATORGR)
      If cd_status = "A"
         T_Avulso = T_Avulso + (CD_QUANT * CD_VRGR)
      Endif
      M_ACHE[&M]=STRZERO(CD_QUANT,5,1)+"³"+STRZERO(CD_CODI,6)+"³"+SUBSTR(CD_PROD,1,27)+" ³"+SUBSTR(CD_COR,1,05)+" ³"+SUBSTR(CD_SAIDA,1,10)+"³"+STR(CD_UNIT,8,2)+"³"+STR(CD_UNIT*CD_QUANT,9,2)
      M = STRZERO(VAL(M)+1,2,0)
      SKIP
   Enddo
   If (m_tipo = 1 .or. m_tipo = 3 .or. m_tipo = 4 .or. m_tipo = 5 .or. m_tipo = 8 .or. m_tipo = 9 .or. m_tipo = 10) .and. (T_Garant >0)
      Cor=Setcolor()
      Setcolor("GR+/B")
      @ 20,49 SAY "Garantia Est"
      Cor=Setcolor(Cor)
      @ 20,69 SAY T_Garant        PICT "@E 999,999.99"
      @ 22,69 SAY M_GRTO+T_Garant PICT "@E 999,999.99"
      If m_tipo = 4 .or. m_tipo = 9 .or. m_tipo = 10
         @ 22,69 SAY M_GRTO+T_Garant+M_txm+M_txe PICT "@E 999,999.99"
      Endif
   Endif
   If T_Avulso > 0
      Cor=Setcolor()
      Setcolor("GR+/B")
      @ 23,49 SAY "Garantia Avulsa"
      Cor=Setcolor(Cor)
      @ 23,69 SAY T_Avulso        PICT "@E 999,999.99"
      @ 24,69 SAY M_GRTO+T_Avulso PICT "@E 999,999.99"
   Endif
   If M_txe >0
     @ 23,01 SAY "Taxa de Entrega  : "+str(m_txe,6,2)
   Endif
   If M_txm >0
     @ 24,01 SAY "Taxa de Montagem : "+str(m_txm,6,2)
   Endif
   Release T_AVULSO

   @ 16,71 say alltrim(str(val(m)-1))+" Itens"
   SETCOLOR("W+/BG+, B/RG,X")
   M_OPCA = ACHOICE(9,1,14,78,M_ACHE)
   RELEASE ALL LIKE M_ACH*
   IF LASTKEY() = 27
      RELEASE ALL LIKE M_ACH*
      LOOP
   ENDIF
   IF M_TIPO = 3 .OR. M_TIPO = 6
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
      @ 18,02 SAY M_TOTA   PICT "@E 999,999.99"
      @ 18,12 SAY M_ENTRAD PICT "@E 99,999.99"
      @ 18,23 SAY M_TOTA-M_ENTRAD PICT "@E 999,999.99"
      @ 17,37 SAY M_NUM1 PICT "99"
      @ 17,41 SAY M_VRP1 PICT "@E 999,999.99"
      @ 17,55 SAY M_DTA1
      @ 17,68 SAY M_DTA2
      @ 18,37 SAY M_NUM2 PICT "99"
      @ 18,41 SAY M_VRP2 PICT "@E 999,999.99"
      @ 18,55 SAY M_DTA3
      @ 18,68 SAY M_DTA4
      @ 19,37 SAY M_NUM3 PICT "99"
      @ 19,41 SAY M_VRP3 PICT "@E 999,999.99"
      @ 19,55 SAY M_DTA5
      @ 19,68 SAY M_DTA6
      @ 20,37 SAY M_NUM4 PICT "99"
      @ 20,41 SAY M_VRP4 PICT "@E 999,999.99"
      @ 20,55 SAY M_DTA7
      @ 20,68 SAY M_DTA8

      M_TOTT = (M_VRP1*M_NUM1)+(M_VRP2*M_NUM2)+(M_VRP3*M_NUM3)+(M_VRP4*M_NUM4)+M_ENTRAD
      @ 21,41 SAY M_TOTT PICT "@E 999,999.99"
    ENDIF
    sst=savescreen(13,02,23,24)
    TEC = 0
    If Lastkey()=27
       Exit
    Endif
   M_Alt = "N"
   Sele 25
   Set Order to 1
   SEEK STR(M_NOTA,8,0)
   If Tec = 2                  && Alterando Item
      Alert("Processo em An lise !")
      Loop
      Lin = 9
      Stor 0 to m_tota
      Cor=SetColor()
      M_Alt = "N"
      Stor 0 to m_Txe,m_txm
      While !EOF() .AND. CD_CODIOR = M_NOTA .AND. CD_DATAO = M_DATAO
       M_ULTIMA=CD_DATAO
       M_CODI  = CD_CODI
       M_TIPO  = CD_TIPOV
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
       M_RESERV= CD_RESERV
       If CD_TXE >0
          M_TXE = CD_TXE
       Endif
       If CD_TXM >0
          M_TXM   = CD_TXM
       Endif
       M_IMEI  = CD_IMEI
       M_CEL   = CD_CEL

       SetColor(Cor)
       @ LIN,01 GET M_QUANT pict "99999" VALID M_QUANT >0
       @ LIN,07 GET M_CODI PICT "999999" VALID M_CODI >0
       Read

       SELE 3
       SET ORDER TO 1
       GOTO TOP
       SEEK M_CODI
       IF !EOF()
          @ LIN,14 SAY SUBSTR(CD_PROD,1,29)
       ELSE
          @ LIN,14 SAY "Erro no arquivo..."
       ENDIF
       M_Prod = cd_prod
       M_Corp = cd_cor
       SELE 25
       SET ORDER TO 1
       SetColor(Cor)
       If !Empty(m_corp)
          m_cor=m_corp
       Endif
       @ LIN,45 GET M_COR PICT "@!"
       @ LIN,53 GET M_SAIDA PICT "@!"
       @ LIN,62 GET M_UNIT PICT "@E 9,999.99" VALID M_UNIT >0
       Read
       @ LIN,69 SAY M_UNIT * M_QUANT PICT "@E 999,999.99"
       M_TOTA = M_TOTA + (M_UNIT * M_QUANT)
       @ 22,69 SAY M_TOTA PICT "@E 999,999.99"
       LIN = LIN + 1
       IF LIN > 19
          LIN = 19
          SCRCANC()
       ENDIF
       nResp:=0
       nResp:=Alert( "Confirma  Altera‡„o Item ? ", {"Sim ","N„o "})
       If nResp=1
          If Bloqreg(0)
             Repl cd_codi with m_codi,cd_tipov with m_tipo,cd_cor with m_cor,cd_prod with m_prod, ;
                  cd_unit with m_unit,cd_saida with m_saida,cd_quant with m_quant
          EndIf
          M_Alt="S"
          Unlock
       Endif
       nResp:=0
       nResp:=Alert( "Altera Outro Item ? ", {"Sim ","N„o "})
       If nResp= 2
          Exit
       EndIf
       Skip
      Enddo
      IF M_TIPO = 4 .OR. M_TIPO = 8 .or. m_tipo = 9 .or. m_tipo = 10
         m_entcc=SaveScreen(11,05,13,31)
         SOMBRA(11,05,13,31,BOX)
         @ 12,06 SAY 'VALOR ENTRADA 'Get M_VRFIN PICT "@E 999,999.99" valid M_VRFIN <= M_TOTA
         READ
         RestScreen(11,05,13,31,m_entcc)
      ENDIF
      M_VRCAR = 0
      IF M_TIPO = 5
         m_entcc=SaveScreen(11,05,13,31)
         SOMBRA(11,05,13,31,BOX)
         @ 12,06 SAY 'VALOR ENTRADA 'Get M_VRCAR PICT "@E 999,999.99" valid M_VRCAR <= M_TOTA
         READ
         RestScreen(11,05,13,31,m_entcc)
      ENDIF

    Stor 0 to M_tota
    Sele 25
    Set Order to 1
    Seek Str(m_nota,8,0)
    While !eof() .and. cd_codior = m_nota
      If cd_datao = m_datao
         M_tota=M_Tota+(cd_unit*cd_quant)
         If Bloqreg(0)
            Repl cd_vrcar with m_vrcar,cd_vrfin with m_vrfin
         Endif
         Unlock
      EndIf
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
       @ 18,12 GET M_ENTRAD PICT "@E 99,999.99" valid M_ENTRAD <= M_NOTT
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
         If Bloqreg(0)
            Repl CD_NUMPRE WITH M_NUM,CD_ENTRA WITH M_ENTRAD,CD_NUM1 WITH M_NUM1,CD_NUM2 WITH M_NUM2,CD_NUM3 WITH M_NUM3,CD_NUM4 WITH M_NUM4, ;
                 CD_VRPARC1 WITH M_VRP1,CD_VRPARC2 WITH M_VRP2,CD_VRPARC3 WITH M_VRP3,CD_VRPARC4 WITH M_VRP4, ;
                 CD_DTA1 WITH M_DTA1,CD_DTA2 WITH M_DATX,CD_DTA3 WITH M_DTA3,CD_DTA4 WITH M_DTA4, ;
                 CD_DTA5 WITH M_DTA5,CD_DTA6 WITH M_DTA6,CD_DTA7 WITH M_DTA7,CD_DTA8 WITH M_DTA8
         EndIf
         COMM
         UNLOCK
         Skip
      EndDo
      TelVen()
   ENDIF
   Clear Gets
Endif
 If Tec = 3                  && Incluindo Item
    Stor 0 to M_TOTA
    Set Color to
    RestScreen(14,01,22,78,Telv)
    M_TOTS  = "N"
    M_AJUST = "N"   && VARIAVEL DE APOIO
    M_Alt   = "N"
    WHILE .T.
      M_Data=M_ULTIMA
      Stor 0 to M_CODX,M_QUANT,M_PE,M_PRE
      @ LIN,01 GET M_QUANT pict "99999"
      @ LIN,07 GET M_CODX PICT "999999"
      Read
      If Lastkey() = 27
         Exit
     Endif
     SELE 3
     SET ORDER TO 1
     GOTO TOP
     SEEK M_CODX
     IF !EOF()
        @ LIN,14 SAY SUBSTR(CD_PROD,1,29)
     ELSE
        @ LIN,14 SAY "Erro no arquivo..."
     ENDIF
      @ LIN,07 SAY STRZERO(M_CODX,6)
      @ LIN,14 SAY SUBSTR(CD_PROD,1,29)+" "+SUBSTR(CD_COR,1,6)
      M_PROMO   = CD_PROMO
      M_CUSTO   = CD_CUST
      M_VENDA   = CD_AVISTA2
      M_QUANT   = M_QUANT
      M_GRUPO   = CD_GRUP
      M_SBGRUPO = CD_SBGRUP
      M_COR     = SUBSTR(CD_COR,1,7)
      M_PRD     = CD_PROD
      COR=SETCOLOR()
      M_Tabe    = 2                   //  Usando tabela 2 ( Pr de Avista )
      M_Avista = cd_avista2

      IF CD_TABELA <> "S"
         Loop
      ENDIF
      IF EMPTY(M_COR)
         @ LIN,45 GET M_COR PICT "@!"
         READ
      ENDIF
      @ LIN,53 GET M_SAIDA PICT "@!S8"
      READ
      Stor 0 to M_res

      M_Res := Ret_Res(m_codx)    // Funcoes.prg

      If M_res >0
         Alert("Existe Reserva p/ este Produto !")
      Endif

      Sele 30
      Set Order to 1
      Seek M_Codx
      If Eof()
         Alert("Produto N„o Cadastrado. Atualize Tabela !")
      Endif

      CENTX  = CD_SALDO-(M_RES+CD_AVARIA+CD_AUTORIZ+CD_TRANSIT)

      Sele 3
      Set Order to 1
      IF CENTX < M_QUANT
         Alert("Estoque Insuficiente. Consulte Gerente.")
      ENDIF
      If M_GRUP = 8 .and. CD_PROMO >=M_DATA   && Esta no prazo de promocional de Celulares
         ALERT("Pre‡o Promocional At‚ Dia "+dtoc(m_promo))
         M_Avista = cd_vrpromo
         M_Venda  = cd_vrpromo
         M_PRE    = cd_vrpromo
         M_PRECO  = cd_vrpromo
      Else                             && Preco Normal
         M_Avista = cd_avista2
         M_Venda  = cd_avista2
         M_PRAUX  = cd_avista2
         M_PRE    = cd_avista2
         M_PRECO  = cd_avista2
      Endif
      M_PRCP=M_PRE

      @ LIN,60 GET M_PRE PICT "99,999.99"
      READ

      nResp:=0
      nResp:=Alert( " Venda de Produtos", {"Confirma ","Retorna "})
      IF nResp<>1 .Or. LASTKEY() = 27
         LOOP
      ENDIF
      @ LIN,60 SAY M_PRE PICT "99,999.99"
   *****************************VER ACRESCIMO OU DESCONTO***********
    IF M_TIPO = 2 .OR. M_TIPO = 3 .OR. M_TIPO = 6
       IF M_PRE<M_VENDA
          M_DE=M_VENDA-M_PRE    && M_DE = DESCONTOS
       ELSEIF M_PRE>M_VENDA
          M_AC=M_PRE-M_VENDA   && M_AC = ACRESCIMO
       ENDIF
    ELSEIF M_PRE<M_AVISTA
        M_DE=M_AVISTA - M_PRE
    ELSEIF M_PRE>M_AVISTA
        M_AC=M_PRE-M_AVISTA
    ENDIF

    M_TOTD  = M_TOTD  + M_DE
    M_TOTAC = M_TOTAC + M_AC

//  **************************************************************************
    IF CD_PROMO<M_DATA
       IF M_TIPO = 2 .OR. M_TIPO = 3 .OR. M_TIPO = 6
          IF M_PRE<M_VENDA
             M_DESC=M_PRE
          ENDIF
       ENDIF
    ELSEIF CD_PROMO>=M_DATA .AND. M_GRUPO = 8              && Celulares
       IF M_TIPO = 2 .OR. M_TIPO = 3 .OR. M_TIPO = 6
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
         IF CD_PROMO>=M_DATA .AND. M_GRUPO = 8
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
    M_STO     = M_PRE * M_QUANT
    M_GRTO    = M_GRTO + M_STO
    M_TOTA    = M_GRTO
    @ LIN,70 SAY M_STO PICT "@E 99,999.99"
    @ 22,60  SAY M_TOTAC-M_TOTD PICT "@E 9,999.99"
    @ 22,69  SAY M_GRTO    PICT "@E 999,999.99"

    SET KEY -9 TO TOTSAI

    LIN = LIN + 1
    If M_TOTS="S"
       CONTINUA="S"
       EXIT
    Endif
    If LIN > 28
       TOTSAI()
    Endif
    Sele 25
    Set order to 1
    nResp:=0
    nResp:=Alert( "Confirma  Inclus„o do Item ? ", {"Sim ","N„o "})
    If nResp=1
       If Adireg(0)
          Repl CD_CODIOR WITH M_NOTA,CD_DATAO WITH M_data,CD_CODICL WITH M_CLIE,CD_NOMECL WITH M_NOME, ;
               CD_QUANT WITH M_Quant,CD_CODI WITH M_CODX,CD_PROD WITH M_PRD,CD_UNIT WITH M_PRE, ;
               CD_VENDED WITH V_NOME,CD_CODVEN WITH M_VEND,cd_tipov with m_tipo,cd_cor with m_cor,cd_saida with m_saida, ;
               CD_ENDE WITH ENDEX,CD_FONE WITH FON1X,CD_CPF WITH CPFX,CD_BAIR WITH Substr(M_BAICL,1,30),CD_OBSER WITH M_OBSER, ;
               CD_CEP WITH M_CEPCL,CD_CIDA WITH M_CIDACL,CD_UF WITH M_UFCL,CD_REFER WITH M_REFER, ;
               CD_CGC WITH CGCX,CD_REFER2 WITH M_REFER2,cd_rg with m_rg, ;
               CD_RESERV WITH M_RESERV,CD_IMEI WITH M_IMEI,CD_CEL WITH M_CEL
       EndIf
       Comm
       Unlock
       M_Alt="S"
    Endif
    nResp:=0
    nResp:=Alert( "Inclui Outro Item ? ", {"Sim ","N„o "})
    If nResp= 2
       Exit
    EndIf
    SKIP
 ENDDO

    IF M_TIPO = 4 .OR. M_TIPO = 8 .or. m_tipo = 9 .or. m_tipo = 10
       m_entcc=SaveScreen(11,05,13,31)
       SOMBRA(11,05,13,31,BOX)
       @ 12,06 SAY 'VALOR ENTRADA 'Get M_VRFIN PICT "@E 999,999.99" valid M_VRFIN <= M_TOTA
       READ
       RestScreen(11,05,13,31,m_entcc)
    ENDIF

    M_VRCAR = 0
    IF M_TIPO = 5
       m_entcc=SaveScreen(11,05,13,31)
       SOMBRA(11,05,13,31,BOX)
       @ 12,06 SAY 'VALOR ENTRADA 'Get M_VRCAR PICT "@E 999,999.99" valid M_VRCAR <= M_TOTA
       READ
       RestScreen(11,05,13,31,m_entcc)
    ENDIF

    Sele 25
    Set Order to 1
    Seek Str(m_nota,8,0)
    While !eof() .and. cd_codior = m_nota .and. cd_datao = m_datao
      If Bloqreg(0)
         Repl cd_vrcar with m_vrcar,cd_vrfin with m_vrfin
      EndIf
      UNLOCK
      Skip
    EndDo

    Stor 0 to S_Dia

    IF M_TIPO = 2 .OR. M_TIPO = 3 .OR. M_TIPO = 6 .and. M_Alt="S"
       M_Nott=M_Tota
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
       M_DATT=M_ULTIMA
       S_DIA :=SOMADD(M_DATT)
       M_DTA1=M_ULTIMA+S_DIA
       M_DIA1=DTOC(M_DTA1)
       M_DAT1=M_DTA1

       @ 17,55 GET M_DTA1 VALID M_DTA1 >=M_DATAO

        If M_NUM1=1
           M_DATT=M_ULTIMA
           S_DIA :=SOMADD(M_DATT)
           M_DATX = M_ULTIMA+S_DIA
           M_DAT1 = M_DATX
        Endif
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
        M_NUM=M_NUM1+M_NUM2+M_NUM3+M_NUM4
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
        If Bloqreg(0)
           Repl CD_NUMPRE WITH M_NUM,CD_ENTRA WITH M_ENTRAD,CD_NUM1 WITH M_NUM1,CD_NUM2 WITH M_NUM2,CD_NUM3 WITH M_NUM3,CD_NUM4 WITH M_NUM4, ;
                CD_VRPARC1 WITH M_VRP1,CD_VRPARC2 WITH M_VRP2,CD_VRPARC3 WITH M_VRP3,CD_VRPARC4 WITH M_VRP4, ;
                CD_DTA1 WITH M_DTA1,CD_DTA2 WITH M_DATX,CD_DTA3 WITH M_DTA3,CD_DTA4 WITH M_DTA4, ;
                CD_DTA5 WITH M_DTA5,CD_DTA6 WITH M_DTA6,CD_DTA7 WITH M_DTA7,CD_DTA8 WITH M_DTA8
           COMM
           UNLOCK
        EndIf
        Skip
     EndDo
     TelVen()
   ENDIF
   Clear Gets
  EndIf

  If Tec = 1
     Sele 25
     Set order to 1
     SEEK STR(M_NOTA,8,0)
     SETCOLOR("B+/W")
     TC=SAVESCREEN(04,15,24,79)
     SOMBRA(10,20,24,78,BOX)
     @ 10,25 SAY "Dados do Cliente p/Emiss„o de Cupom Fiscal"
     SETCOLOR("B+/W")
     @ 11,21 SAY "Nome "GET M_NOME
     @ 12,21 SAY "Endere‡o "GET ENDEX
     @ 13,21 SAY "Bairro "GET M_BAICL  PICT "@!S20"
     @ 13,50 SAY "Cidade "GET M_CIDACL PICT "@!S19"
     @ 14,21 SAY "C.E.P "GET M_CEPCL PICT '99.999-999'
     @ 14,39 SAY "Fone "GET FON1X PICT "@!S15"
     @ 14,62 SAY "U.F."GET M_UFCL
     @ 15,21 SAY "C.P.F. "GET CPFX PICT "999.999.999-99"
     @ 15,50 SAY "C.G.C. "GET CGCX PICT '99.999.999/9999-99'
     @ 16,21 SAY "R.G    "GET M_RG
     @ 17,21 to 17,76
     @ 18,21 SAY "PONTO DE REF(1)"GET M_REFER  PICT "@!S40"
     @ 19,21 SAY "PONTO DE REF(2)"GET M_REFER2 PICT "@!S40"
     @ 20,21 SAY "N§ Ser/ Quadro "GET M_OBSER
     @ 21,21 SAY "Sa¡da dos Produtos "+substr(M_SAIDA,1,10)
     @ 21,50 SAY "N§ Reserva : "GET M_RESERV PICT "99999999"
     @ 22,50 SAY "N§ IMEI :"GET M_IMEI
     @ 23,50 SAY "N§ Celular :"GET M_CEL PICT "999-9999999999"
     If xy_cap_int = "CC"      // Lojas da Capital ( filiais.dbf )
        @ 24,21 SAY "Tx.de Entrega :"get m_txe pict "999.99"
        @ 24,48 SAY "Tx.de Montagem:"get m_txm pict "999.99"
     Endif
     READ
     RESTSCREEN(04,15,24,79,TC)
     Release TC
     nResp:=0
     nResp:=Alert( "Confirma Altera‡„o Cadastro? ", {"Sim ","N„o "})
     If nResp=1
        While !eof() .and. cd_codior = m_nota .and. cd_datao = m_datao
          If bloqreg(0)
             Repl CD_RG WITH M_RG,CD_ENDE WITH ENDEX,CD_FONE WITH FON1X,CD_CPF WITH CPFX,CD_BAIR WITH Substr(M_BAICL,1,30),CD_OBSER WITH M_OBSER, ;
                  CD_CEP WITH M_CEPCL,CD_CIDA WITH M_CIDACL,CD_UF WITH M_UFCL,CD_REFER WITH M_REFER,CD_CODICL WITH M_CLIE, ;
                  CD_CGC WITH CGCX,CD_REFER2 WITH M_REFER2,CD_NOMECL WITH M_NOME,CD_RESERV WITH M_RESERV, ;
                  CD_IMEI WITH M_IMEI,CD_CEL WITH M_CEL
          EndIf
          COMM
          UNLOCK
          Skip
        EndDo
     EndIf
  Endif
  If Tec = 4                  && Excluindo Item de Orcamento
     LIN = 9
     PRIV M_ACHE[30],M_COD[30],M_QTDE[30],M_VALOR[30],P_CODI,P_QTDE,P_VALOR
     M="01"
     M_Alt="N"
     RestScreen(14,01,22,78,Telv)
     STOR 0 TO M_TOTA,QUANT,M_DESCO,M_GRTO,M_STO,S_DIA
     While !Eof() .AND. CD_CODIOR = M_NOTA
      @ LIN,01 SAY STRZERO(CD_QUANT,5)
      @ LIN,07 SAY STRZERO(CD_CODI,6)
      M_QTD      = CD_QUANT
      M_CODX     = CD_CODI
      M_COD[&M]  = CD_CODI
      M_QTDE[&M] = CD_QUANT
      M_VALOR[&M]= CD_UNIT
      M_TIPO     = CD_TIPOV
      M_ENTRAD   = CD_ENTRA
      M_VRP1     = CD_VRPARC1
      M_VRP2     = CD_VRPARC2
      M_VRP3     = CD_VRPARC3
      M_VRP4     = CD_VRPARC4
      M_NUM1     = CD_NUM1
      M_NUM2     = CD_NUM2
      M_NUM3     = CD_NUM3
      M_NUM4     = CD_NUM4
      M_DTA1     = CD_DTA1
      M_DTA2     = CD_DTA2
      M_DTA3     = CD_DTA3
      M_DTA4     = CD_DTA4
      M_DTA5     = CD_DTA5
      M_DTA6     = CD_DTA6
      M_DTA7     = CD_DTA7
      M_DTA8     = CD_DTA8
      M_VRFIN    = CD_VRFIN
      M_VRCAR    = CD_VRCAR
      M_NOME     = CD_NOMECL
      M_CLIE     = CD_CODICL
      ENDEX      = CD_ENDE
      FON1X      = CD_FONE
      CGCX       = CD_CGC
      CPFX       = CD_CPF
      M_BAICL    = CD_BAIR
      M_CEPCL    = CD_CEP
      M_CIDACL   = CD_CIDA
      M_UFCL     = CD_UF
      M_REFER    = CD_REFER
      M_REFER2   = CD_REFER2
      M_OBSER    = CD_OBSER
      M_SAIDA    = CD_SAIDA
      M_RG       = CD_RG
      M_DATAO    = CD_DATAO
      V_NOME     = CD_VENDED
      M_VEND     = CD_CODVEN
      M_COR      = CD_COR
      M_VRFIN    = CD_VRFIN
      M_VRCAR    = CD_VRCAR
      SELE 3
      SET ORDER TO 1
      GOTO TOP
      SEEK M_CODX
      IF !EOF()
         @ LIN,14 SAY SUBSTR(CD_PROD,1,29)
      ELSE
         @ LIN,14 SAY "Erro no arquivo..."
      ENDIF
      SELE 25
      SET ORDER TO 1
      @ LIN,45 SAY SUBSTR(CD_COR,1,6)
      @ LIN,53 SAY SUBSTR(CD_SAIDA,1,8)
      @ LIN,62 SAY CD_UNIT PICT "@E 9,999.99"
      @ LIN,69 SAY CD_UNIT * CD_QUANT PICT "@E 999,999.99"
      M_TOTA = M_TOTA + (CD_UNIT * CD_QUANT)
      M_GRTO = M_TOTA
      @ 22,69 SAY M_TOTA              PICT "@E 999,999.99"
      QUANT=QUANT+CD_QUANT
      LIN = LIN + 1
      IF LIN > 19
         LIN = 19
         SCRCANC()
      ENDIF
      M_ACHE[&M]=STRZERO(CD_QUANT,5,1)+"³"+STRZERO(CD_CODI,6)+"³"+SUBSTR(CD_PROD,1,29)+" ³"+SUBSTR(CD_COR,1,05)+" ³"+SUBSTR(CD_SAIDA,1,7)+"³"+STR(CD_UNIT,8,2)+"³"+STR(CD_UNIT*CD_QUANT,10,2)
      M = STRZERO(VAL(M)+1,2,0)
      SKIP
     ENDDO
     SETCOLOR("W+/BG+, B/RG,X")
     M_OPCA = ACHOICE(9,1,20,78,M_ACHE)
     IF LASTKEY() = 27
        RELEASE ALL LIKE M_ACH*
        RELEASE M_ACHE[&M],M_COD[&M],M_QTDE[&M],M_VALOR[&M],P_CODI,P_QTDE,P_VALOR,LIN
        LOOP
     ENDIF

  Alert("Opera‡„o Recusada, Processo em Analise !")
  Return

  P_CODI =m_cod[M_OPCA]
  P_QTDE =m_qtde[M_OPCA]
  P_VALOR=m_valor[M_OPCA]
  nResp:=0
  nResp:=Alert( "Confirma Exclus„o do Item? ", {"Sim ","N„o "})
  If nResp = 2
     Exit
  Endif
  SELE 25
  SET ORDER TO 1
  SEEK STR(M_NOTA,8,0)
  WHILE !EOF() .AND. CD_CODIOR = M_NOTA
     If cd_datao = M_datao .and. str(cd_quant,7,1)=str(p_qtde,7,1) .and. cd_codi=p_codi .and. cd_unit=p_valor
        nResp:=0
        nResp:=Alert( "Deleta Codigo "+strzero(p_codi,6)+" do Or‡amento "+strzero(m_nota,8) , {"Sim ","N„o "})
        If nResp = 1
           wImei   = cd_imei
           wnSerie = cd_nSerie
           If Bloqreg(0)
	      Delete
	   Endif
           Comm
           Unlock
           M_Alt="S"
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
        Endif
     Endif
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

   IF M_TIPO = 2 .OR. M_TIPO = 3 .OR. M_TIPO = 6 .and. M_Alt="S"
      M_Nott=M_Tota
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
        M_DATT=M_ULTIMA
        S_DIA:=SOMADD(M_DATT)
        M_DTA1=M_ULTIMA+S_DIA
        M_DIA1=DTOC(M_DTA1)
        M_DAT1=M_DTA1

        @ 17,55 GET M_DTA1 VALID M_DAT1 >=M_DATAO

        If M_NUM1=1
           M_DATT=M_ULTIMA
           S_DIA :=SOMADD(M_DATT)
           M_DATX = M_ULTIMA+S_DIA
           M_DAT1 = M_DATX
        Endif
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
        M_NUM=M_NUM1+M_NUM2+M_NUM3+M_NUM4
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
         If Bloqreg(0)
            Repl CD_NUMPRE WITH M_NUM,CD_ENTRA WITH M_ENTRAD,CD_NUM1 WITH M_NUM1,CD_NUM2 WITH M_NUM2,CD_NUM3 WITH M_NUM3,CD_NUM4 WITH M_NUM4, ;
                 CD_VRPARC1 WITH M_VRP1,CD_VRPARC2 WITH M_VRP2,CD_VRPARC3 WITH M_VRP3,CD_VRPARC4 WITH M_VRP4, ;
                 CD_DTA1 WITH M_DTA1,CD_DTA2 WITH M_DATX,CD_DTA3 WITH M_DTA3,CD_DTA4 WITH M_DTA4, ;
                 CD_DTA5 WITH M_DTA5,CD_DTA6 WITH M_DTA6,CD_DTA7 WITH M_DTA7,CD_DTA8 WITH M_DTA8
           COMM
           UNLOCK
        EndIf
        Skip
       EndDo
     ENDIF
     TelVen()
  EndIF

  IF TEC = 5    && EXCLUI ORCAMENTOS
     Alert("Opera‡„o Recusada. Processo em Analise !")
     Return
     nResp:=0
     nResp:=Alert("Confirma Exclus„o do Or‡amento ? ", {"Sim ","N„o "})
     If nResp = 2
        Exit
     EndIf
     SELE 25
     SET ORDER TO 1
     SEEK STR(M_NOTA,8,0)
     While !Eof() .AND. CD_CODIOR = M_NOTA
       If cd_datao = M_datao
          wImei   = cd_imei
          wnSerie = cd_nSerie
          IF BLOQREG(0)
             DELETE
          ENDIF
          COMM
          UNLOCK
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
       Endif
       SKIP
     ENDDO
  EndIf
  If TEC = 6                          && // Alterando Plano de Pagamento
     CORX=SETCOLOR()
     M_TT=SAVESCREEN(09,14,20,46)
     SETCOLOR("RG/B")
     @ 10,14 CLEAR TO 19,46
     SETCOLOR("G+/R+")
     SOMBRA(10,15,18,42,BOX)
     COR=SETCOLOR()
     @ 10,23 SAY "Tipo Venda"
     SETCOLOR(COR)
     SET MESS TO 03 CENTER
     @ 12,18 PROM "1) A VISTA (DINH/CHEQ) " MESS "Venda a Vista / Dinheiro ou Cheque"
     @ 13,18 PROM "2) C/CHEQUE PRE-DATADO " MESS "Venda a Prazo com Cheque          "
     @ 14,18 PROM "3) A PRAZO NO CARNET   " MESS "Venda Parcelada com Carnet        "
     @ 15,18 PROM "4) FINANCEIRA (A VISTA)" MESS "Venda a Vista Financiada          "
     @ 16,18 PROM "5) CARTAO CREDITO      " MESS "Venda a Vista Cart„o  Cr‚dito     "
     @ 17,18 PROM "6) BOLETO              " MESS "Venda Boleto Banc rio             "
   /*
     @ 17,18 PROM "6) CARNET /CONVENIO    " MESS "Venda Parcelada Carnˆ / Convˆnio  "
     @ 18,18 PROM "7) BMG (Consignada)    " MESS "Venda Consignada Banco BMG        "
     @ 18,18 PROM "8) CAIXA/CONVENIO      " MESS "Parceria Caixa                    "
   */
     MENU TO M_TIPO
     RESTSCREEN(09,14,20,46,m_tt)
     If m_tipo = 6 
         m_tipo = 10   // Boleto
     Endif
     Lin = 9
     Stor 0 to m_tota
     Cor=SetColor()
     M_Alt = "N"
     WHILE !EOF() .AND. CD_CODIOR = M_NOTA .AND. CD_DATAO = M_DATAO
      M_ULTIMA=CD_DATAO
      M_CODX = CD_CODI
      M_COR  = CD_COR
      M_UNIT = CD_UNIT
      M_QUANT= CD_QUANT
      M_ENTRAD=CD_ENTRA
      M_VRP1= CD_VRPARC1
      M_VRP2= CD_VRPARC2
      M_VRP3= CD_VRPARC3
      M_VRP4= CD_VRPARC4
      M_NUM1= CD_NUM1
      M_NUM2= CD_NUM2
      M_NUM3= CD_NUM3
      M_NUM4= CD_NUM4
      M_DTA1= CD_DTA1
      M_DTA2= CD_DTA2
      M_DTA3= CD_DTA3
      M_DTA4= CD_DTA4
      M_DTA5= CD_DTA5
      M_DTA6= CD_DTA6
      M_DTA7= CD_DTA7
      M_DTA8= CD_DTA8
      M_VRFIN=CD_VRFIN
      M_VRCAR=CD_VRCAR

      M_CLIE = CD_CODICL
      M_NOME = CD_NOMECL
      ENDEX  = CD_ENDE
      FON1X  = CD_FONE
      CGCX   = CD_CGC
      CPFX   = CD_CPF
      M_BAICL= CD_BAIR
      M_CEPCL= CD_CEP
      M_CIDACL= CD_CIDA
      M_UFCL  = CD_UF
      M_REFER = CD_REFER
      M_REFER2= CD_REFER2
      M_OBSER = CD_OBSER
      M_SAIDA = CD_SAIDA
      M_RG    = CD_RG
      SetColor(Cor)
      @ LIN,01 GET M_QUANT pict "99999"
      @ LIN,07 GET M_CODX PICT "999999"
        Read

      SELE 3
      SET ORDER TO 1
      GOTO TOP
      SEEK M_CODX
      IF !EOF()
         @ LIN,14 SAY SUBSTR(CD_PROD,1,29)
         m_prod=cd_prod
      ELSE
         @ LIN,14 SAY "Erro no arquivo..."
      ENDIF
      SELE 25
      SET ORDER TO 1
      SetColor(Cor)
      @ LIN,45 GET M_COR PICT "@!"
      @ LIN,53 GET M_SAIDA pict "@!"
      @ LIN,62 GET M_UNIT PICT "@E 9,999.99"
      Read
      @ LIN,69 SAY M_UNIT * M_QUANT PICT "@E 999,999.99"
      M_TOTA = M_TOTA + (M_UNIT * M_QUANT)
      @ 22,69 SAY M_TOTA              PICT "@E 999,999.99"
      LIN = LIN + 1
      IF LIN > 19
         LIN = 19
         SCRCANC()
      ENDIF
      nResp:=0
      nResp:=Alert( "Confirma  Altera‡„o Item ? ", {"Sim ","N„o "})
      If nResp=1
         If Bloqreg(0)
            Repl cd_codi with m_codx,cd_tipov with m_tipo,cd_cor with m_cor, ;
                 cd_unit with m_unit,cd_saida with m_saida,cd_quant with m_quant,cd_prod with m_prod
            Comm
            Unlock
            M_Alt="S"
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
     If M_TIPO = 4 .OR. M_TIPO = 8 .or. m_tipo = 9 .or. m_tipo = 10
        m_entcc=savescreen(11,05,13,31)
        SOMBRA(11,05,13,31,BOX)
        @ 12,06 SAY 'VALOR ENTRADA 'Get M_VRFIN PICT "@E 999,999.99"
        READ
        RestScreen(11,05,13,31,m_entcc)
     Endif
     M_VRCAR = 0
     If M_TIPO = 5
        m_entcc=savescreen(11,05,13,31)
        SOMBRA(11,05,13,31,BOX)
        @ 12,06 SAY 'VALOR ENTRADA 'Get M_VRCAR PICT "@E 999,999.99"
        READ
        RestScreen(11,05,13,31,m_entcc)
     Endif
     Sele 25
     Set Order to 1
     Seek Str(m_nota,8,0)
     While !eof() .and. cd_codior = m_nota
       IF cd_datao = m_datao
          If Bloqreg(0)
             Repl cd_vrcar with m_vrcar,cd_vrfin with m_vrfin
          EndIf
          COMM
          UNLOCK
       Endif
       Skip
     EndDo

     Stor 0 to S_Dia

     IF M_TIPO = 2 .OR. M_TIPO = 3 .OR. M_TIPO = 6 .and. M_Alt="S"
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
        Endif
        M_VRP1=M_ENTRAD
        @ 18,23 SAY M_NOTT-M_ENTRAD PICT "@E 999,999.99"
        @ 17,37 GET M_NUM1 PICT "99" VALID M_NUM1 >0 .AND. M_NUM1<21
        READ
        M_VRP1=(M_NOTT-M_ENTRAD) / M_NUM1
        @ 17,41 GET M_VRP1 PICT "@E 999,999.99"
        M_DATT=M_ULTIMA
        S_DIA :=SOMADD(M_DATT)
        M_DTA1=M_ULTIMA+S_DIA
        M_DIA1=DTOC(M_DTA1)
        M_DAT1=M_DTA1

        @ 17,55 GET M_DTA1 VALID M_DTA1 >=M_DATAO
        If M_NUM1=1
           M_DATT=M_ULTIMA
           S_DIA :=SOMADD(M_DATT)
           M_DATX = M_ULTIMA+S_DIA
           M_DAT1 = M_DATX
        Endif

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
        M_NUM=M_NUM1+M_NUM2+M_NUM3+M_NUM4
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
             If Bloqreg(0)
                Repl CD_NUMPRE WITH M_NUM,CD_ENTRA WITH M_ENTRAD,CD_NUM1 WITH M_NUM1,CD_NUM2 WITH M_NUM2,CD_NUM3 WITH M_NUM3,CD_NUM4 WITH M_NUM4, ;
                     CD_VRPARC1 WITH M_VRP1,CD_VRPARC2 WITH M_VRP2,CD_VRPARC3 WITH M_VRP3,CD_VRPARC4 WITH M_VRP4, ;
                     CD_DTA1 WITH M_DTA1,CD_DTA2 WITH M_DATX,CD_DTA3 WITH M_DTA3,CD_DTA4 WITH M_DTA4, ;
                     CD_DTA5 WITH M_DTA5,CD_DTA6 WITH M_DTA6,CD_DTA7 WITH M_DTA7,CD_DTA8 WITH M_DTA8
             EndIf
             COMM
             UNLOCK
         Endif
         Skip
        EndDo
        TelVen()
  ENDIF
        Exit
  EndIf

  If TEC = 6         && IMPRIME ORCAMENTO
     Alert("Aten‡„o ! Ser  impresso na impressora de Carnˆs.")
     Prn_File=FS_Set("PrintFile")
     Set devi to print
     P_TITU= "               O R € A M E N T O"
     P_PAGI=1
     RELAX1=2
     SIGA  ="S"
     STOR 0 TO M_QUANT,M_ITEN,M_DESCO,M_ACRES,M_TOT
     OKPRINT()
     IF LASTKEY()=27
        RETURN
     ENDIF
     SET DEVI TO PRINT
     SELE 25
     SET ORDER TO 1
     SEEK STR(M_NOTA,8,0)
     WHILE !EOF() .AND. SIGA ="S" .AND. PROW() <58 .AND. CD_CODIOR = M_NOTA .AND. LASTKEY()=13
       IF RELAX1 = 2
          ESC = INKEY()
          ESCPRINT(ESC,24)
          SET DEVI TO PRINT
          @ PROW(),1 SAY CHR(18)
          CABECA(P_TITU,P_PAGI)
          P_PAGI = P_PAGI + 1
          @ PROW()+1,00 SAY CHR(18)
          @ PROW()  ,02 SAY 'QUANT'
          @ PROW()  ,09 SAY 'CODIG'
          @ PROW()  ,15 SAY 'DESCRICAO DA MERCADORIA'
          @ PROW()  ,45 SAY 'REFERENCIA'
          @ PROW()  ,59 SAY 'PR. UNIT'
          @ prow()  ,72 SAY 'Total R$'
          @ PROW()+1,00 SAY REPLICATE('Í',80)
       ENDIF
     WHILE !EOF() .AND. SIGA ="S" .AND. PROW() <58 .AND. CD_CODIOR = M_NOTA .AND. LASTKEY()=13
       ESC = INKEY()
       ESCPRINT(ESC,24)
       SET DEVI TO PRINT
       @ PROW()+1,01 SAY STRZERO(CD_QUANT,5,1)
       @ PROW()  ,08 SAY STRZERO(CD_CODI,6)
       @ PROW()  ,14 SAY SUBSTR(CD_PROD,1,28)
       @ PROW()  ,44 SAY SUBSTR(CD_FABR,1,10)
       @ PROW()  ,58 SAY CD_UNIT PICT "@E 9,999.99"
       @ PROW()  ,70 SAY CD_UNIT*CD_QUANT PICT "@E 99,999.99"
       M_ITEN=M_ITEN+1
       M_QUANT=M_QUANT+CD_QUANT
       M_TOT=M_TOT+(CD_QUANT*CD_UNIT)
       SKIP
       ESC = INKEY()
       ESCPRINT(ESC,24)
       SET DEVI TO PRINT
       IF PROW() >=58
          EJECT
          EXIT
       ENDIF
     ENDDO
     ENDDO
     @ PROW()+1,00 SAY REPLICATE('Í',80)
     @ PROW()+1,01 SAY STRZERO(M_QUANT,6,1)
     @ PROW()  ,14 SAY "ITENS "+STRZERO(M_ITEN,6)
     @ PROW()  ,69 SAY M_TOT PICT "@E 999,999.99"
     @ PROW()+2,2  SAY "Valor Or‡:"
     @ PROW()  ,14 SAY M_TOT PICT "@E 999,999.99"
     @ PROW()  ,14 SAY M_TOT PICT "@E 999,999.99"
     @ PROW()+4,02 SAY "_________________                             __________________"
     @ PROW()+1,02 SAY "   VENDEDOR                                         EMPRESA     "
     @ PROW()+1,00 SAY ""
     EJECT
     !("./imp &carne &prn_file")
     DelteFile("&prn_file")
      SET DEVI TO SCREEN
 ENDIF
  ENDDO
ENDDO
RETURN

//************
  PROC PROCCPF
//************
 M_passoucl = 1
 Clear Gets
 Setcolor(xcorstatus)
 sc=savescreen(10,15,15,70)
 Sombra(10,15,13,68,box)
 @ 11,16 say "Acesso On Line a Base de Dados do Servidor Iguatu"

While .t.
 Setcolor("b+/w")
 m_cpf = Space(14)
 m_cgc = Space(18)
 @ 12,17 Say "C.P.F: "GET M_CPF PICT "999.999.999-99" 
 *valid m_cpf<> space(14)
 @ 12,40 Say "C.N.P.J: "GET M_CGC PICT "99.999.999/9999-99" valid m_cgc<> space(18) when Empty(m_cpf)
 Read
 Setcolor(xcorstatus)
 If Lastkey() = 27
    M_passoucl = 0
    restscreen(10,15,15,70,sc)
    Exit
 Endif
 acpf = substr(m_cpf,1,3)+substr(m_cpf,5,3)+substr(m_cpf,9,3)+substr(m_cpf,13,2)
 If Val(m_cpf) >0
    If len(alltrim(acpf)) < 11
       Alert("C.P.F. Incompleto !")
       Loop
    Endif
    Ver_Cpf(acpf)
    If Res_Cpf = "EOF"
       Loop
    Endif
 Endif
 acgc = SUBS(M_CGC,1,2)+SUBS(M_CGC,4,3)+SUBS(M_CGC,8,3)+SUBS(M_CGC,12,4)+SUBS(M_CGC,17,2)
 If val(acgc) >0
    If len(alltrim(acgc)) < 14
       Alert("C.N.P.J Incompleto !")
       Loop
    Endif
    CNPJ(acgc)
    If Res_CNPJ = "EOF"
       Loop
    Endif
 Endif

 If !Empty(m_cpf) .or. !Empty(m_cgc)

    mlj = alltrim(strzero(Loja,2))

    Arqenvi = substr(dtoc(m_datsi),1,2)+substr(dtoc(m_datsi),4,2)+substr(time(),1,2)+substr(time(),4,2)+"_"+substr(time(),7,2)
    !cp /zenir/dirtrans/lj&mlj/xcliecad.dbf mains.&arqenvi
    w_main = "mains.&arqenvi"
    !chmod 777 /zenir/sistemas/loja&mlj/&w_main

    Stor "" to w_Porta
    @ 15,15 Say "Conectando Atraves de : IpTunel"

    m_ip := TestaCon("Loja","","","")
    If Empty(m_ip)
       Return
    Else
       If Loja = 51
          If Trim(xy_ipIbm) <> "168.190.30.253"
             xy_ipIbm = "168.190.30.253"
          Endif
          w_ip := TestaCon("Destino","51",xy_ipIbm,"")
       Else
          w_ip := TestaCon("Destino","",xy_ipIbm,"")
       Endif
       If Empty(w_ip)
          Return
       Endif
    Endif
    If Empty(m_cpf)
       m_cpf = "99999999999999"
    Endif

    m_ssh = 'ssh -C -l cliecred '+w_Ip+' &W_Porta -t -q "/zenir/modulo/cliecred/cliecred "'+mlj+" "+m_cpf+" "+m_ip+" "+w_main+" "+"Orcamento"+" "+m_cgc
    !&m_ssh
    Restscreen(10,15,15,70,sc)
 Else
    @ 23,10 say "Consulta Inv lida! [Pres] Enter"
    inkey(0)
    Exit
 Endif

    !sudo chmod 777 /zenir/sistemas/loja&mlj/&w_main
    Restscreen(10,15,15,70,sc)
    M_passoucl = 1

    Sele 24
    Use
    Sele 24
    Veriout(SETCOLOR(),23,"mains.&arqenvi")
    Go Top
    If !Empty(cl_nome)
       M_NOME   = CL_NOME
       M_BLO    = CL_BLOQ
       ENDEX    = CL_ENDE
       FON1X    = CL_FON1
       CGCX     = CL_CGC
       CPFX     = CL_CPF
       M_BAICL  = CL_BAIR
       M_NUMERO:=Ret_Numeros(CL_NUMERO,10)
       M_CEPCL  = CL_CEP
       M_CIDACL = CL_CIDA
       M_UFCL   = CL_UF
       M_REFER  = CL_LOCE
       M_REFER2 = SPACE(60)
       M_OBSER  = SPACE(40)
       M_SAIDA  = SPACE(18)
       M_RG     = CL_RG
       @ 5,32 SAY STRZERO(M_CLIE,6) + " " + TRIM(M_NOME)
       keyb(chr(13))
    Else
       Alert("Falha na Recep‡„o do Arquivo ou Cliente Inexistente !")
       M_passoucl = 0
    Endif
    Use
    If File("/zenir/sistemas/loja&mlj/&w_main")
       DeleteFile("/zenir/sistemas/loja&mlj/&w_main")
    Endif
    Release w_main,Arqenvi,mlj
    Exit
Enddo
Return(m_passoucl)

//******************
  Procedure Cad_Imei(W_Codi,W_Imei)
//******************

If Empty(w_imei)
   w_Imei = Space(15)
Endif
While .t.
  Sssi=savescreen(18,31,21,71)
  If w_Codi = 0
     Sombra(18,31,21,71,Box)
     @ 19,32 Say "Cadastrando Imei -> Codigo Prod"get W_Codi pict "999999" valid W_Codi >0
     @ 20,32 SAY "N§ de IMEI do Celular"get w_Imei VALID w_Imei <> SPACE(15)
  Else
     Sombra(18,31,20,71,Box)
     @ 19,32 SAY "N§ de IMEI do Celular"get w_Imei VALID w_Imei <> SPACE(15)
  Endif
  Read
  restscreen(18,31,21,71,Sssi)
  Release Sssi
  If Lastkey() = 27 .or. Empty(w_imei)
     Alert("Imei N„o Cadastrado ! ")
     Return(.f.)
  Endif

  wValidar:= ValidarImei(W_Codi,W_Imei)
  If wValidar = .f.
     Return(.f.)
  Endif
  Release wValidar

  Stor 0 to M_Valor
  M_notaf = ""
  M_DAT1  = M_DATSI

  wPs = "n"
  Sele 20
  Veriout(setcolor(),23,"cdfisc")
  Set index to index_cdfisc
  Sele 20
  Set Order to 1
  Seek str(w_codi,6,0)
  While !Eof() .and. F_CODIGO = W_CODI
   If F_ENTRA >0 .and. F_PERCF >0
      M_Valor = F_Custof
      M_Notaf = F_Nota
      M_Dat1  = F_Data
      If !Empty(F_cgccpf)
         wCnpj = F_cgccpf
      Endif
      wPs = "s"
      Exit
   Endif
   Skip
  Enddo
  Sele 20
  Use
  If wPs = "s"
     m_nomef = ""
     m_forn  = 0
     BuscaCNPJ(@m_nomef,@m_forn,wCnpj)    // funcoes.prg

     Sele 44
     Set Order to 1
     If Adireg(0)
        Repl cel_nota with val(m_notaf),cel_codi with w_codi,cel_imei with w_imei, ;
             cel_valor with m_valor,cel_datae with m_dat1,cel_forn with m_forn, ;
             cel_nomefo with m_nomef,cel_de with lojax,bipado with "S"
     Endif
     Comm
     Unlock
  Endif
  Release M_Valor,M_FORN,m_nomef,M_notaf,M_DAT1,wPs
  Alert("Cadastramento Ok !")
  Exit
Enddo
Return(.t.)

//***********************
  Procedure R_ReleaseOrca
//***********************
  RELEASE M_DAT1,M_DAT2,M_DAT3,M_DAT4,M_DAT5,M_DAT6,M_DAT7,M_DAT8,M_DAT9,M_DAT10,M_DAT11,M_DAT12,M_DAT23,M_DAT24,M_DAT25,W_MOD,T_PLAV
  RELEASE M_DAT13,M_DAT14,M_DAT13,M_DAT14,M_DAT15,M_DAT16,M_DAT17,M_DAT18,M_DAT19,M_DAT20,M_DAT21,M_DAT22,M_VEZES[&M],w_ttgaran,W_PLAV
  RELEASE M_NOTA,M_SERI,M_T,M_CLIE,M_GRTO,M,M_CONT,M_AC[&M],M_DE[&M],M_SAID[&M],m_codimei,m_txab,m_frt,m_mon,m_prcprom,M_GRTS,W_PASSCI
  RELEASE M_QTD[&M],M_COD[&M],M_STO[&M],M_PRE[&M],M_FORN[&M],M_COM[&M],M_COR[&M],M_PRD[&M],M_PERCENTR,W_PLANO,W_FAIXAP,wSaida,wValorSeguro
  RELEASE M_CO,M_PARE,M_NUMCH,M_PE,CENTX,M_NUM,M_OM,OM,M_VRCAR,M_PRECO,M_PRAUX,M_PROMO,M_VEND,M_PLM,M_VEZESPL,W_GR,M_PLANO,M_MESES
  RELEASE M_CH1,M_CH2,M_CH3,M_CH4,M_CH5,M_CH6,M_CH7,M_CH8,M_CH9,M_CH10,M_CH11,M_CH12,M_CH13,M_CH14,M_CH15,M_ENTRACH,M_VRFIN,W_AUTOR
  RELEASE M_PAR1,M_PAR2,M_PAR3,M_PAR4,M_PAR5,M_PAR6,M_PAR7,M_PAR8,M_PAR9,M_PAR10,M_PAR11,M_PAR12,M_PAR23,M_PAR24,M_PAR25,W_GARANT
  RELEASE M_PAR13,M_PAR14,M_PAR13,M_PAR14,M_PAR15,M_PAR16,M_PAR17,M_PAR18,M_PAR19,M_PAR20,M_PAR21,M_PAR22,VCONF,VCONF1,T_GARANT
  RELEASE M_TOTD,M_TOTAC,M_ENTRAD,M_VRP1,M_VRP2,M_VRP3,M_VRP4,M_NUM2,M_NUM3,M_NUM4,M_ATRASO,M_ORCA,m_com_sd,m_com_cd,m_percen
  RELEASE M_BANC,M_CONTA,M_DATACH,M_CHEQ,M_DATA,M_TOTS,M_AJUST,M_AUTO,S_DIA,M_RES,M_TXE,M_TXM,wCom
  RELEASE VEZES,M_ENDE,M_CPF,M_CGC,M_BAIR,M_CEP,M_CIDA,M_UF,M_REF,TXM,M_NUMERO,M_COMPLE,wNumero,wComple
  RELEASE m_num_vda,m_vrcirca,m_num_vdp,m_vrcircp,m_autor,M_VrPlano,w_vezesgr
  RELEASE all like M_QTD*
  RELEASE all like M_COD*
  RELEASE all like M_PRD*
  RELEASE all like M_STO*
  RELEASE all like M_PRE*
  RELEASE all like M_COM*
  RELEASE all like M_AUTOR*
  RELEASE all like w_garant*
  RELEASE all like m_grfator*
  RELEASE all like m_vezesci*
  RELEASE all like M_ACH*
  RELEASE all like M_AC*
  RELEASE all like M_DE*
  RELEASE all like M_COR*
  RELEASE all like M_SAID*
  RELEASE all like M_VEZES*
  RELEASE all like m_Vrplano*
  RELEASE all like M_IMEI*
  RELEASE all like w_plano*
  RELEASE all like w_plav*
  RELEASE all like w_vezesgr*
Return

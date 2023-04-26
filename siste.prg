//********************************************
/*
   FILE NAME : SISTE.PRG
   BY        : HELIO-SP
   DESC      : PROGRAMA PRINCIPAL
*/
//********************************************
#include "box.ch"
#include "inkey.ch"
#include "sipa.ch"
#include "fileio.ch"
#include "migracao.ch"

procedure main()
PUBLIC vdir:=""
vdir := "/"+curdir()

REQUEST DBFCDX
REQUEST DBFFPT
RDDSETDEFAULT('DBFCDX')

SET TALK OFF
SET DATE BRIT
SET WRAP ON
SET BELL OFF
SET SCOR OFF
SET CONF ON
SET DELE ON
SET CENTURY ON
SET EPOCH TO 2000
SET PATH TO /zenir/sistemas/tabela

PUBLIC XY_EMPRESA,XY_CIDADE,XY_TELEFO,XY_ISLOGAN,XY_ENDEREC,XY_NUMNF,XY_IpTunel,XY_CEP,XY_UF,XY_SLOGAN,XY_CGC,XY_ESTOQODOO
PUBLIC xy_cap_int,xy_com,xy_cd,xy_requi,xy_vend_td,xy_reserva,xy_reserva2,xy_reserva3,XY_MUNI,XY_VRTROCA,XY_IniFLinha,XY_FimFLinha
PUBLIC xy_ip_int,xy_ip_ext,xy_porta,xy_ipibm,xy_ip,xy_embratel,xy_outrosip,xy_rotembra,xy_rotoi,XY_GR,XY_BAIRRO,XY_CGF
PUBLIC IP_ESTX,IP_PREX,M_DATSI,LOJA,LOJAX,IPS_ESTX,lojas,I_UTEIS,I_FERI,I_DESCA
PUBLIC C_CORG,C_CORS,C_CORN,C_CORA,C_CORX,C_CORK,C_CORM,C_CORGX,MENU,XY_DTI,XY_IBM_EMB
PUBLIC FRAME[1],OP1,M_NOMEUSU,M_LOJA1,RELAX1,I_FILI,M_ACESSO,I_PRIORID,I_NOMEUSU
PUBLIC tESC,WPORTA,MMM_VAR,M_PR,TCF2,I_SENHA,I_FISCAL,M_LOJAD,wUltimoac
PUBLIC MOV_LINHA,MOV_COLUNA,contecor,nomecor,pasta,m_ultima,m_fechacx,SIGA,PID,Lojau
PUBLIC I_TXELECAP,I_TXELEINT,I_TXMOVCAP,I_TXMOVINT,I_TXCELCAR,I_TXCELCC,I_TXINFCAR,I_FilOrigem
PUBLIC I_TXINFCCC,I_TXINFCCI,I_TXCARNE,I_TXCHEQUE,I_TXFINANC,I_TXCONVEN,I_TXMOTOS,I_DIAS_M,I_DIAS_E
PUBLIC I_DESCAVEL,I_DESCAVMO,I_FT_01L,I_FT_02L,I_FT_03L,I_FT_04L,I_FT_05L,I_FT_18L,I_FT_24L
PUBLIC I_DCELECAP,I_DCELEINT,I_DCMOVCAP,I_DCMOVINT,I_DCCHEQUE,I_DCCARNE,I_TXE,I_TXM,I_TAC
PUBLIC wPercentPromo,wDescontoFilialSup
PUBLIC I_DataIniCC_01,I_DataFimCC_01,I_DataIniCC_02,I_DataFimCC_02,I_DataIniCC_03,I_DataFimCC_03
PUBLIC I_DataIniCC_04,I_DataFimCC_04,I_DataIniCC_06,I_DataFimCC_06,I_DataIniCC_07,I_DataFimCC_07
PUBLIC I_DataIniCC_08,I_DataFimCC_08,I_DataIniCC_16,I_DataFimCC_16,I_DataIniCC_17,I_DataFimCC_17
PUBLIC I_DataIniCC_18,I_DataFimCC_18,I_DataIniCC_19,I_DataFimCC_19,I_DataIniCa_01,I_DataFimCa_01
PUBLIC I_DataIniCa_02,I_DataFimCa_02,I_DataIniCa_03,I_DataFimCa_03,I_DataIniCa_04,I_DataFimCa_04
PUBLIC I_DataIniCa_06,I_DataFimCa_06,I_DataIniCa_07,I_DataFimCa_07,I_DataIniCa_08,I_DataFimCa_08
PUBLIC I_DataIniCa_16,I_DataFimCa_16,I_DataIniCa_17,I_DataFimCa_17,I_DataIniCa_18,I_DataFimCa_18
PUBLIC I_DataIniCa_19,I_DataFimCa_19,I_TaxaCC_01,I_TaxaCC_02,I_TaxaCC_03,I_TaxaCC_04,I_TaxaCC_06
PUBLIC I_TaxaCC_07,I_TaxaCC_08,I_TaxaCC_16,I_TaxaCC_17,I_TaxaCC_18,I_TaxaCC_19
PUBLIC I_TaxaCa_01,I_TaxaCa_02,I_TaxaCa_03,I_TaxaCa_04,I_TaxaCa_06,I_TaxaCa_07
PUBLIC I_TaxaCa_08,I_TaxaCa_16,I_TaxaCa_17,I_TaxaCa_18,I_TaxaCa_19
PUBLIC I_VezesCC_01,I_VezesCC_02,I_VezesCC_03,I_VezesCC_04,I_VezesCC_06,I_VezesCC_07,I_VezesCC_08
PUBLIC I_VezesCC_16,I_VezesCC_17,I_VezesCC_18,I_VezesCC_19
PUBLIC I_VezesCa_01,I_VezesCa_02,I_VezesCa_03,I_VezesCa_04,I_VezesCa_06,I_VezesCa_07,I_VezesCa_08
PUBLIC I_VezesCa_16,I_VezesCa_17,I_VezesCa_18,I_VezesCa_19

M_Pid  = ExecPIDnum()
Pid    = Alltrim(str(m_pid))
mains  = "main_"+pid
wmains = "wmain_"+pid

M_DATSI=DATE()
tEsc:=chr(27)

op       = 1
M_NOMEUSU= " "
M_LOJA1  = " "

BOX = "ÉÍ»º¼ÍÈº "

FRAME[1]=CHR(218)+CHR(196)+CHR(191)+CHR(179)+CHR(217)+;
         CHR(196)+CHR(192)+CHR(179)+SPACE(1)
 
C_CORM    := "W+/B+"
MENU      := "W+/B+"
C_CORG    := "W+/B,B/W,,,W+B"
C_CORGX   := "W+/BG+, B/RG*"
C_CORS    := "GR+/B, B/B"
C_CORN    := "W+/N, W+/N"
C_CORA    := "GR+/N, W+/N"
C_CORX    := "R+/B, B/B"
C_CORK    := "W/N"
VERMEL    := "W+/R+*"
CINZA     :="B+/W"
xcorfundo :="B+/B"
xcorstatus:="N/W"
xcormenu  :="N/B"
xcorget   :="W+/N+"
xcorjane  :="N/BG"
xcorletra :="W+/BG"

xmold:= "ÚÄ¿³ÙÄÀ³ "
exec=.t.

cWS1=getenv("HOSTNAME")

/*
sele 3
veriout(setcolor(),23,"cdsie")      && estoque
set index to index_cdsie
Sele 3
Set Order to 1
m_codx = 7000
While !Eof()

  Sele 3
  Set Order to 1
  seek m_codx
  codCompo:= RetornaCompo(m_codx)
  If codCompo >0
     m_codx = codCompo
     Sele 3
     Set Order to 1
     seek m_codx
     *dbedit()
  Endif
  Skip
  m_codx = cd_codi
  ? cd_codi,codCompo
  inkey(0)
Enddo
return
*/

*importatxt()
*return

/*
 If dow(m_datsi)= 7
    m_dat=m_datsi-6
 ElseIf dow(m_datsi)= 6
   m_dat=m_datsi-5
 ElseIf dow(m_datsi)= 5
   m_dat=m_datsi-4
 ElseIf dow(m_datsi)= 4
   m_dat=m_datsi-3
 ElseIf dow(m_datsi)= 3
   m_dat=m_datsi-2
 ElseIf dow(m_datsi)= 1
   m_dat=m_datsi-1
 Endif
 Alert(m_dat)
 wDiaSem := RetDiaSem(m_dat)
 Alert(wDiaSem)
 wdat = m_dat
 for i = m_dat to m_datsi       // Ultimos dias da Semana
   ? wdat++
 next
 alert("")
*/

wVendedor := Telain()

IF EMPTY(M_NOMEUSU)
   clear
   QUIT
ENDIF
If acess3 = "N"
   Clear
   Alert("Acesso as Vendas N„o Autorizado ! ")
   Clear
   Quit
Endif

I_NOMEUSU=M_NOMEUSU
TELSIE2 = SAVESCREEN(0,0,24,79)

@ 05,01 clear to 20,78

chdir(vdir)

CONFIG_EMP()    && CONFIGURA EMPRESA

 //   ****************************** Impressoras do FlagShip
      carne="carne_"+trim(I_fili)
      contr="contr_"+trim(I_fili)
      cobra="cobra_"+trim(I_fili)
      auten="auten_"+trim(I_fili)
      aute1="aute1_"+trim(I_fili)
      minut="minut_"+trim(I_fili)
      fisca="fisca_"+trim(I_fili)
 //   ******************************

Set color to w/W
    @ 05,01 clear to 20,78
Set color to n/W
    @ 05,02,20,77 BOX B_SINGLE
Set color to W+/W
    ln = 07
    cont = 1
    for i = 1 to Len(Alltrim(m_nomeusu))
        If ln = 07
           @ ln,01 Say Upper(Substr(m_nomeusu,Cont,1))
        Else
           @ ln,01 Say Lower(Substr(m_nomeusu,Cont,1))
        Endif
        ln++
        cont++
    Next
    Release ln,cont
    @ 05,02 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    @ 06,02 Say "³"
    @ 07,02 Say "³"
    @ 08,02 Say "³"
    @ 09,02 Say "³"
    @ 10,02 Say "³"
    @ 11,02 Say "³"
    @ 12,02 Say "³"
    @ 13,02 Say "³"
    @ 14,02 Say "³"
    @ 15,02 Say "³"
    @ 16,02 Say "³"
    @ 17,02 Say "³"
    @ 18,02 Say "³"
    @ 19,02 Say "³"

    @ 05,78 Say "L"
    @ 06,78 Say "i"
    @ 07,78 Say "n"
    @ 08,78 Say "u"
    @ 09,78 Say "x"
    @ 11,78 Say "O"
    @ 12,78 Say "r"
    @ 13,78 Say "‡"
    @ 14,78 Say "a"
    @ 15,78 Say "m"
    @ 16,78 Say "e"
    @ 17,78 Say "n"
    @ 18,78 Say "t"
    @ 19,78 Say "o"

    SET COLOR TO W+/W
    @ 18,26,20,49 BOX B_SINGLE
    SET COLOR TO N/W

    @ 18,26 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    @ 19,26 Say "³                      "
    @ 20,26 Say "À"

CBC()

Grava(I_NOMEUSU,"E",m_PID)

chdir(vdir)

CDABRE()        && ABRE TODOS OS ARQUIVOS

*csvcclientesativosInativos()

/*
 wField = "CD_RETIRA"
 wDbf   = "CDORCA"
 wCampo:= RetornacampoDBF(wField,wDbf)
 If wCampo = .F.
    Alert("Campo: "+wField+" do DBF: "+wDbf+ " Nao Encontrado ")
    Return
 Endif
 wField = "SD_RETIRA"
 wDbf   = "CDSAID"
 wCampo:= RetornacampoDBF(wField,wDbf)
 If wCampo = .F.
    Alert("Campo: "+wField+" do DBF: "+wDbf+ " Nao Encontrado ")
    Return
 Endif
*/

M_DAT=DATE()
VERIFCX(M_Dat)       && VERIFICA SE O CAIXA FOI ENCERRADO E MUDA A DATA AUTOMATICAMENTE

If Time() < "09:00:00"           // Zerando arquivo temporario de exclusao de reservas
   USE conexaoreserva EXCLUSIVE
   If reccount() >0
      If !NETERR()
         Zap
      Endif
   Endif
   Use
Endif

/*
while .t.
   wCodProd = 0
   @ 10,20 say "Produto:"get wCodProd
   Read
   wProdID = wCodProd

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
   alert(wStatus)

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
      wInsert:=InsereProduto(wProdID,wRetClie)
      If wInsert = .f.
         Return
      Endif
   Endif
   inkey(0)
   if lastkey() = 27
      Exit
   end
Enddo
quit
*/

/*
 m_datsi = ctod("12/11/2015")
 ww:=Verif_Res(26274)      // Verifica se ha' reserva duplicada
 Alert(ww)
 Quit
*/
/*
 If Trim(M_NomeUsu) = "HELIO"
    inkey(1)
    If !File("/tmp/disponivel_venda_temp.csv")
       Alert("Arquivo: /tmp/disponivel_venda_temp.csv Nao Encontrado ")
    Endif
 Endif
*/

 If File(".#*")            // Arquivo Temporario
    !rm .#*
 Endif


CadCpf(wVendedor)   // At. Cpf dos Vendedores funcoes.prg

PRIVATE OP[4],V1[7],V2[7],V3[8],V4[3]

OP[1] = 'Or‡amentos'
OP[2] = 'Clientes/Estoque'
OP[3] = 'Imei/Celulares/S‚rie'
OP[4] = 'Garantia Estendida'

V1[1] = "Or‡amentos             "
V1[2] = "Consulta               "
V1[3] = "Altera/Inclui/Exclui   "
V1[4] = "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
V1[5] = "Tabela Fretes/Fortaleza"
V1[6] = "Circulares On Line     "
V1[7] = "Vendas N„o Aprovadas   "
*V1[8]= "Atualiza Circulares    "

V2[1]= "Informa‡”es de Clientes"
V2[2]= "Consulta Venda  "
V2[3]= "Ficha de Estoque"
V2[4]= "Comiss”es"
V2[5]= "Gr fico Demonstrativo"
V2[6]= "Gr fico por Setor"
V2[7]= "Arq. Morto Or‡to "

V3[1] = "Cadastros IMEI/N§ SERIE"
V3[2] = "Inclui/Cad Novo IMEI/SR"
V3[3] = "Transfere IMEI         "
V3[4] = "Browse das Transferenc "
V3[5] = "Envia IMEI On Line     "
V3[6] = "Estoque                "
V3[7] = "Rela‡„o Roubo/Furto    "
V3[8] = "Importar Imei/N§ SERIE "

V4[1]= "Garantia Estendida   "
V4[2]= "Ranking              "
V4[3]= "Browse Arquivo       "
/*
V4[4]= "ÄÄÄÄMobile CursÄÄÄÄÄ "
V4[5]= "Browse Mobile Cursos "
V4[6]= "Ranking Mobile Cursos"
*/

ssi=savescreen(00,00,24,78)
******************************Aniversariantes*************************************
 If Month(m_datsi) = 1
    filer=vdir+"/aniv.001"
    Edita_arq:=MEMOREAD("aniv.001")
 ElseIf Month(m_datsi) = 2
    filer=vdir+"/aniv.002"
    Edita_arq:=MEMOREAD("aniv.002")
 ElseIf Month(m_datsi) = 3
    filer=vdir+"/aniv.003"
    Edita_arq:=MEMOREAD("aniv.003")
 ElseIf Month(m_datsi) = 4
    filer=vdir+"/aniv.004"
    Edita_arq:=MEMOREAD("aniv.004")
 ElseIf Month(m_datsi) = 5
    filer=vdir+"/aniv.005"
    Edita_arq:=MEMOREAD("aniv.005")
 ElseIf Month(m_datsi) = 6
    filer=vdir+"/aniv.006"
    Edita_arq:=MEMOREAD("aniv.006")
 ElseIf Month(m_datsi) = 7
    filer=vdir+"/aniv.007"
    Edita_arq:=MEMOREAD("aniv.007")
 ElseIf Month(m_datsi) = 8
    filer=vdir+"/aniv.008"
    Edita_arq:=MEMOREAD("aniv.008")
 ElseIf Month(m_datsi) = 9
    filer=vdir+"/aniv.009"
    Edita_arq:=MEMOREAD("aniv.009")
 ElseIf Month(m_datsi) = 10
    filer=vdir+"/aniv.010"
    Edita_arq:=MEMOREAD("aniv.010")
 ElseIf Month(m_datsi) = 11
    filer=vdir+"/aniv.011"
    Edita_arq:=MEMOREAD("aniv.011")
 ElseIf Month(m_datsi) = 12
    filer=vdir+"/aniv.012"
    Edita_arq:=MEMOREAD("aniv.012")
 Endif

 If !file("&filer")
    Alert("Arquivo de aniversariantes N„o Existe.Informe ao Programador! ")
 Endif
 If SUBSTR(DTOC(M_DATSI),1,5) = "25/12" .or. SUBSTR(DTOC(M_DATSI),1,5) = "31/12".or. SUBSTR(DTOC(M_DATSI),1,5) = "21/04" .or. SUBSTR(DTOC(M_DATSI),1,5) = "01/05"
    m_dataano=m_datsi+1
 Else
    m_dataano=m_datsi
 Endif

 Sele 40
 Veriout(setcolor(),23,"fun")        && Cadastro de Funcionrios / Folha
 Set index to index_funcio
 Cor := Setcolor()
 Setcolor("w/gr+")
 Sele 40
 Set Order to 1
 Go Top

 M_IMP= "N"
 LIN  = 03
 iflj = 00
 While !Eof()
  If cd_loja = "2 "
     iflj = 2
  ElseIf cd_loja = "3 "
     iflj = 3
  ElseIf cd_loja = "4 "
     iflj = 4
  ElseIf cd_loja = "5 "
     iflj = 5
  ElseIf cd_loja = "6 "
     iflj = 6
  ElseIf cd_loja = "7 "
     iflj = 7
  ElseIf cd_loja = "8 "
     iflj = 8
  ElseIf cd_loja = "9 "
     iflj = 9
  ElseIf cd_loja = "10"
     iflj = 16
  ElseIf cd_loja = "11"
     iflj = 17
  ElseIf cd_loja = "12"
     iflj = 18
  ElseIf cd_loja = "13"
     iflj = 21
  ElseIf cd_loja = "14"
     iflj = 22
  ElseIf cd_loja = "15"
     iflj = 24
  ElseIf cd_loja = "16"
     iflj = 23
  ElseIf cd_loja = "17"
     iflj = 25
  ElseIf cd_loja = "18"
     iflj = 26
  ElseIf cd_loja = "19"
     iflj = 27
  ElseIf cd_loja = "20"
     iflj = 28
  ElseIf cd_loja = "21"
     iflj = 29
  ElseIf cd_loja = "23"
     iflj = 31
  ElseIf cd_loja = "32"
     iflj = 32
  ElseIf cd_loja = "33"
     iflj = 33
  ElseIf cd_loja = "34"
     iflj = 34
  ElseIf cd_loja = "35"
     iflj = 35
  ElseIf cd_loja = "36"
     iflj = 36
  ElseIf cd_loja = "37"
     iflj = 37
  ElseIf cd_loja = "38"
     iflj = 38
  ElseIf cd_loja = "39"
     iflj = 39
  ElseIf cd_loja = "40"
     iflj = 40
  ElseIf cd_loja = "41"
     iflj = 41
  ElseIf cd_loja = "42"
     iflj = 42
  ElseIf cd_loja = "43"
     iflj = 43
  ElseIf cd_loja = "44"
     iflj = 44
  ElseIf cd_loja = "45"
     iflj = 45
  ElseIf cd_loja = "46"
     iflj = 46
  ElseIf cd_loja = "47"
     iflj = 47
  ElseIf cd_loja = "48"
     iflj = 48
  ElseIf cd_loja = "49"
     iflj = 49
  ElseIf cd_loja = "50"
     iflj = 50
  ElseIf cd_loja = "51"
     iflj = 51
  ElseIf cd_loja = "52"
     iflj = 52
  ElseIf cd_loja = "53"
     iflj = 53
  ElseIf cd_loja = "54"
     iflj = 54
  ElseIf cd_loja = "55"
     iflj = 55
  ElseIf cd_loja = "56"
     iflj = 56
  ElseIf cd_loja = "57"
     iflj = 57
  ElseIf cd_loja = "58"
     iflj = 58
  ElseIf cd_loja = "59"
     iflj = 59
  ElseIf cd_loja = "60"
     iflj = 60
  ElseIf cd_loja = "61"
     iflj = 61
  ElseIf cd_loja = "62"
     iflj = 62
  ElseIf cd_loja = "63"
     iflj = 63
  ElseIf cd_loja = "64"
     iflj = 64
  ElseIf cd_loja = "65"
     iflj = 65
  Endif
  If iflj = Loja .and. Empty(cd_deslig)
     If SUBSTR(DTOC(CD_NASCTO),1,5) = SUBSTR(DTOC(M_DATSI),1,5) .AND. EMPTY(CD_DESLIG) .AND. EMPTY(CD_RDESLIG)
        @ Lin,02 clear to lin,77
        @ Lin,02 SAY Cd_NOME
        Lin=Lin+1
        M_IMP="S"
     ElseIf SUBSTR(DTOC(CD_NASCTO),1,5) = SUBSTR(DTOC(M_DATAANO),1,5) .AND. EMPTY(CD_DESLIG) .AND. EMPTY(CD_RDESLIG)
        @ Lin,02 clear to lin,77
        @ Lin,02 SAY Cd_NOME
        Lin=Lin+1
        M_IMP="S"
     Endif
  Endif
  Skip
 EndDo
 SetColor(Cor)
 Sele 40
 Use
 If M_IMP ="S"
    Edita_arq:=MEMOEDIT(Edita_arq,5,01,20,77)
 Endif
Restscreen(00,00,24,78,ssi)

KEYB CHR(13)
OPCAO = 0

w_pass = "n"
Sele 3
Set Order to 1
Go Bott
While !Bof()
 If cd_dat1 >= m_datsi
    w_pass = "s"
    Exit
 Endif
 Skip -1
Enddo
If w_pass = "s"
   cor=setcolor()
   Set color to br+/w
   @ 19,66 Say "[F3]Pre‡os"
   Inkey(0)
   cor=setcolor(cor)
   Keyb(chr(13))
Endif
Release w_pass

While .T.
  SET KEY -1 TO  Acess_Link
  SET KEY -2 TO  VER_PRECOS  && Ver Precos de Produtos Alterados Nesta Data
  SET KEY -3 TO  CONSULTA    && CONSULTA
  SET KEY -4 TO  SAC_ZENIR   && SAC
  SET KEY -5 TO  CALCUL      && CALCULADORA (NESTE PRG) F6
  SET KEY -6 TO  MUDADATA    && MUDA A DATA DO SISTEMA  // NESTE PRG  F7
  SET KEY -7 TO  VERIF_IMEI  && VERIFICA A ENTREGA DO CELULAR ATRAVES DO IMEI // NESTE PRG
  SET KEY -8 TO  ACESS_RES   &&
 *SET KEY -9 TO  CONFI_RES   && CONFIRMA RESERVA ODOO
  SET KEY -40 TO MUDA_SEN    && MUDA SENHA DE USUARIO  --  PFILE.PRG  F11
  SET KEY  22 TO MUDAUSU     && TROCA DE USUARIO TECLA INSERT  USUARIO.PRG

  SetColor("gr+/b")
  @01,01 CLEAR TO 01,78
  @01,01 say CurDir()+"   "+XY_EMPRESA
  SAYDATA(01,58)
  @01,71 SAY TIME()

  Set Color to gr+/b
  @ 24,02 say "Inicio de Sistema: "+Dtoc(xy_dti)+"  Ultimo Acesso : "+dtoc(wUltimoac)+"  Usu rio: "+Trim(M_NOMEUSU)
  SetColor("w+/b,n/w,,,w+/b")
  @ 03,02 CLEAR TO 3,77

  @ 03,04 PROM OP[1]
  @ 03,18 PROM OP[2]
  @ 03,37 PROM OP[3]
  @ 03,60 PROM OP[4]
  MENU TO OPCAO
  SET CURSOR ON
  DO CASE
     CASE OPCAO = 1
          Set color to w/w
          @ 19,28 clear to 19,47
          Set color to b/w
          @ 19,28 Say "O"
          ORCA()
     CASE OPCAO = 2
          Set color to w+/w
          @ 19,30 Say "Melh"
          ESTO()
     CASE OPCAO = 3
          Set color to w+/w
          @ 19,34 Say "or"
          IMEI()
     CASE OPCAO = 4
          Set color to gr/w
          @ 19,37 Say "Est  "
          Set color to br/w
          @ 19,42 Say "Aqui !"
          If XY_GR ="S"
             GR()          //  Programa de Garantia Extendida Aon
          Endif
          Set color to w/w
          @ 19,28 clear to 19,47
     CASE OPCAO = 0
          If(Alert("Finaliza Programa SIE  ? " , {"Sim" , "N„o"} )) = 1
             SET COLOR TO
             Grava(i_nomeusu,"S",m_PID)                && Grava a Saida dos Terminais
             CLOSE ALL
             CLS
             QUIT
          ELSE
             KEYB CHR(13)
             LOOP
          ENDIF
     ENDCASE
ENDDO
RETURN

//**************
  Proc Confi_Res     // ACESSANDO LINK DAS RESERVAS
//**************
 Set key -8 to
 ssvr=savescreen(06,20,16,78)
 m_nota := 0
 While .t.
   @ 07,20 clear to 16,78
   @ 07,20 to 16,78
   Setcolor("n+/W")
   @ 06,52 Say "Nr Or‡amento"get m_nota
   @ 08,21 Say "Acesso on Line a Reservas...                   Nr Reserva"
   Read
   If Lastkey()= 27
      Release m_nota,Status_r
      Restscreen(06,20,16,78,ssvr)
      Exit
   Endif

   Status_r := ConfirmaRes(m_nota)             // Verifica reservas
   cor=setcolor()
   Setcolor("br+/b")
   lin = 09
   @ 09,21 clear to 15,77
   Sele 25
   Set Order to 1
   Seek STR(M_NOTA,8,0)+SUBSTR(DTOC(M_DATSI),7,4)+SUBSTR(DTOC(M_DATSI),4,2)+SUBSTR(DTOC(M_DATSI),1,2)
   While !Eof() .and. CD_CODIOR = M_NOTA .and. CD_DATAO = M_DATSI
     Setcolor("br+/b")
     @ lin,21 SAY Str(cd_quant,4)+" "+Strzero(cd_codi,6)+" "+substr(cd_prod,1,17)+" "+Substr(cd_saida,1,10)
     Setcolor("w+/b")
     @ lin,61 SAY Str(cd_reserv,16)
     lin++
     Skip
   Enddo
   Setcolor(cor)
   Inkey(0)
   Setcolor(cor)
   Restscreen(06,20,16,78,ssvr)
   Set key -8 to Acess_res
 Enddo
 Release Status_r,ssvr,m_nota
Return

//**************
  Proc Acess_Res     // ACESSANDO LINK DAS RESERVAS
//**************
 Set key -8 to
 ssvr=savescreen(06,20,16,78)
 m_nota := 0
 While .t.
   @ 07,20 clear to 16,78
   @ 07,20 to 16,78
   Setcolor("n+/W")
   @ 06,52 Say "Nr Or‡amento"get m_nota
   @ 08,21 Say "Acesso on Line a Reservas...                   Nr Reserva"
   Read
   If Lastkey()= 27
      Release m_nota,Status_r
      Restscreen(06,20,16,78,ssvr)
      Exit
   Endif

   Status_r := Busca_Reserva(m_nota)             // Verifica reservas
   If Status_r <> "ok"
      Alert(Status_r)
      Alert("Fazer Reserva Por Telefone !")
      keyb(chr(13))
      Loop
   Else
      cor=setcolor()
      Setcolor("br+/b")
      lin = 09
      @ 09,21 clear to 15,77
      Sele 25
      Set Order to 1
      Seek STR(M_NOTA,8,0)+SUBSTR(DTOC(M_DATSI),7,4)+SUBSTR(DTOC(M_DATSI),4,2)+SUBSTR(DTOC(M_DATSI),1,2)
      While !Eof() .and. CD_CODIOR = M_NOTA .and. CD_DATAO = M_DATSI
        Setcolor("br+/b")
        @ lin,21 SAY Str(cd_quant,4)+" "+Strzero(cd_codi,6)+" "+substr(cd_prod,1,17)+" "+Substr(cd_saida,1,10)
        Setcolor("w+/b")
        @ lin,61 SAY Str(cd_reserv,16)
        lin++
        Skip
      Enddo
      Setcolor(cor)
      Inkey(0)
   Endif
   Setcolor(cor)
   Restscreen(06,20,16,78,ssvr)
   Set key -8 to Acess_res
 Enddo
 Release Status_r,ssvr,m_nota
Return

//********************
  Function ConfirmaRes(wOrca)           && Reserva de Produtos que nao irao sair do Mostruario
//********************
 Local wRet
 wRet := "ok"
 lin  := 09
 mlj  := alltrim(strzero(Loja,2))
 cor=setcolor()
 OldNumRes = 0
 Sele 25
 Set Order to 1
 Seek STR(wOrca,8,0)+SUBSTR(DTOC(Date()),7,4)+SUBSTR(DTOC(Date()),4,2)+SUBSTR(DTOC(Date()),1,2)
 While !Eof() .and. CD_CODIOR = wOrca .and. cd_datao = Date()
   Setcolor("br+/b")
   @ lin,21 SAY Str(cd_quant,4)+" "+Strzero(cd_codi,6)+" "+substr(cd_prod,1,17)+" "+Substr(cd_saida,1,10)
   Setcolor("w+/b")
   @ lin,61 SAY Str(cd_reserv,16)
   If cd_reserv >0
      OldNumRes = cd_reserv
   Endif

   If Trim(cd_saida) <> "LOJA/" .and. Trim(cd_saida) <> "DEP" .and. cd_reserv >0
      wPega_Res = cd_reserv
      wSaida    = substr(cd_saida,1,13)
      wUltRecno = Recno()
      wCodPres  = cd_codi
      wQuantres = cd_quant
      nResp :=1
      If nResp = 1
         wCod := cd_codi
         wCdz := 0
         Sele 12
         Veriout(setcolor(),23,"saida_item")
         Go Top
         While !Eof()
           If Saida_item = wSaida
              wCdz = Loja
              Exit
           Endif
           Skip
         Enddo
         Use

         wrr=savescreen(18,10,20,56)
         @ 18,10 to 20,55
         Setcolor("br+/b")
         @ 19,11 say "Confirmando reserva on line com "
         Setcolor("w+/b")
         @ 19,41 say wSaida

         Restscreen(18,10,20,56,wrr)
         Release wrr

         Sele 12
         Veriout(SETCOLOR(),23,"filiais")
         Go Top
         While !Eof()
           If Val(Fili) = wCdz
              x_IP      = Trim(Ip_Tunel)
              w_Reserva = Reserva
              wCnpjCD   = Ret_Num(cgc)
              Exit
           Endif
           Skip
         Enddo
         Use

         Sele 25
         Set Order to 1
         Cor=Setcolor()
         Setcolor("b*/w")
         /*
         @ 16,13 Say "Conectando Atraves de : oDoo_RPC"
         Setcolor(Cor)
         stFil:=ConfigLoja(I_fili,wCdz)   // funcoes.prg
         If stFil = .T.
            wEnvia:=""
            nResp:=Alert( "Reserva online Via oDoo_RPC " , {"Confirmar" , "Cancelar" , "[Esc]Sair"} )
            If nResp =1
               wEnvia:="/opt/odoo_rpc/reserva_odoo.py confirmar -o "+Ret_num(xy_cgc)+" -d "+wCnpjCD+" -p "+alltrim(Str(wCodPres))+" -m "+Alltrim(str(wPega_Res))
            ElseIf nResp = 2
               wEnvia:="/opt/odoo_rpc/reserva_odoo.py cancelar -o "+Ret_num(xy_cgc)+" -d "+wCnpjCD+" -p "+alltrim(Str(wCodPres))+" -m "+Alltrim(str(wPega_Res))
            Endif
            !&wEnvia
         Endif
         */
         Sele 25
         Set Order to 1
         Go wUltRecno
      Else
         Sele 25
         Set Order to 1
      Endif
   Endif
   Skip
   Lin++
   Release w_len,resPid
 Enddo
 Setcolor(cor)
 Release w_arq,wNumRes_1,wNumRes,Pega_Res,w_len,respid,wVended,cor,nResp,cHoras,Ok,wUltRecno,W_RESERVA
 Release m_ipConect,m_ipRetorn
Return(wRet)

//**********************
  Function Busca_Reserva(wOrca)           && Reserva de Produtos que nao irao sair do Mostruario
//**********************
 Local wRet
 wRet := "ok"
 lin  := 09
 mlj  := alltrim(strzero(Loja,2))
 cor=setcolor()
 OldNumRes = 0
 wSaidaCdIguatu   = "N"
 wSaidaCdJuazeiro = "N"
*wSaidaCdSobral   = "N"
*wSaidaCdFort     = "N"
 Sele 25
 Set Order to 1
 Seek STR(wOrca,8,0)+SUBSTR(DTOC(M_DATSI),7,4)+SUBSTR(DTOC(M_DATSI),4,2)+SUBSTR(DTOC(M_DATSI),1,2)
 While !Eof() .and. CD_CODIOR = wOrca .and. CD_DATAO = M_DATSI

   Setcolor("br+/b")
   @ lin,21 SAY Str(cd_quant,4)+" "+Strzero(cd_codi,6)+" "+substr(cd_prod,1,17)+" "+Substr(cd_saida,1,10)
   Setcolor("w+/b")
   @ lin,61 SAY Str(cd_reserv,16)

   If cd_reserv >0
      OldNumRes = cd_reserv
   Endif

   If Trim(cd_saida) <> "LOJA/" .and. Trim(cd_saida) <> "DEP" .and. CD_RESERV = 0
      wSaida := substr(cd_saida,1,13)
      wCdz = 0

      Sele 12
      Veriout(setcolor(),23,"saida_outras")
      Goto Top
      While !Eof()
        If Saida_item = wSaida
           wCdz = Loja
           Exit
        Endif
        Skip
      Enddo
      Use

      Sele 25
      Set Order to 1

      wReserva := 0
      @ lin,61 Get wReserva pict "99999999999999999"
      Read

      nResp = 0
      If wReserva = 0 .or. Lastkey() = 27
         nResp:=Alert( "Pega Reserva On Line " , {"Sim" , "N„o"} )
      Else
         nResp=1
      Endif

      If nResp = 1 .and. wReserva = 0
         wCod := cd_codi
         If Trim(cd_saida) = "CD IG" .or.  Trim(cd_saida) = "CDZ IG"
            wSaidaCdIguatu = "S"
         Endif
         If Trim(cd_saida) = "CD JU" .or.  Trim(cd_saida) = "CDZ JU"
            wSaidaCdJuazeiro = "S"
         Endif
        /*
         If Trim(cd_saida) = "CD SOB" .or. Trim(cd_saida) = "CDZ SOB" .or. Trim(cd_saida) = "DEP SOB" .or. Trim(cd_saida) = "DEP. SOB" .or. Trim(cd_saida) = "DEP.SOB"
            wSaidaCdSobral = "S"
         Endif
         If Trim(cd_saida) = "CD FOR" .or. Trim(cd_saida) = "CDZ FOR"
            wSaidaCdFort = "S"
         Endif
        */

         Sele 3
         Set Order to 1
         Seek wCod
         Release wCod
         If CD_RESERVA = "N"
            wRet := "Reserva C/ Autorizacao do Setor de Compras !"
            Exit
         Endif
         If cd_grup = 11 .or. cd_grup = 12
            wRet :="Produtos Reservados p/ Administra‡„o. "
            Exit
         Endif

         If wReserva = 0 .and. wCdz <> 10 .and. wCdz <> 11 .and. wCdz <> 15 .and. wCdz <> 19 .and. wCdz <> 20 .and. wCdz <> 44 .and. wCdz <> 99
            Release wCdz,lin,nResp,wreserva
            wRet := "Conexao Invalida. Somente com os CD's !"
            Exit
         Endif

         wrr=savescreen(18,10,20,56)
         @ 18,10 to 20,55
         Setcolor("br+/b")
         @ 19,11 say "Efetuando reserva on line com "
         Setcolor("w+/b")
         @ 19,41 say wSaida

         Restscreen(18,10,20,56,wrr)
         Release wrr

         Sele 12
         Veriout(SETCOLOR(),23,"filiais")
         Go Top
         While !Eof()
           If Val(Fili) = wCdz
              x_IP      = Trim(Ip_Tunel)
              w_Reserva = Reserva
              wCnpjCD   = Ret_Num(cgc)
              Exit
           Endif
           Skip
         Enddo
         Use

         Sele 25
         Set Order to 1
         Cor=Setcolor()
         Setcolor("b*/w")
         @ 16,13 Say "Conectando Atraves de : IpTunel"
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
               If Loja = 51
                  wLja = "51"
               Else
                  wLja = ""
               Endif
               w_ip := TestaCon("Destino",wLja,x_ip,Strzero(wCdz,2))
               If Empty(w_ip)
                  Return
               Endif
            Endif
         Endif

         wVended := Alltrim(cd_Vended)
         wVended := Strtran("&wVended"," ","_",,,.T.)

         w_arq := "/tmp/RE"+Pid+"_"+alltrim(Str(cd_codi))+alltrim(str(wOrca))
         If File("&w_arq")
            Deletefile("&w_arq")
         Endif

         mljx := mlj
         z:=At("/",cd_saida)
         If z != 0
            mljx = Ret_Num(cd_saida)
         Endif
         If wReserva = 0
            cHoras = substr(time(),1,2)+substr(time(),4,2)+substr(time(),7,2)
            m_ssh = 'ssh -C -l pegareserva '+w_Ip+' &W_Porta -t -q "/zenir/modulo/pegareserva/pegareserva "'+mlj+" "+mljx+" "+alltrim(str(cd_codi))+" "+alltrim(str(cd_quant))+" "+alltrim(strzero(cd_codven,3))+" "+alltrim(wVended)+" "+alltrim(str(cd_codior))+" "+m_Ip+" "+Alltrim(Strzero(wCdz,2))+" "+cHoras+" "+Pid
            *Alert(m_ssh)
            !&m_ssh
         Endif
      Endif

      mljx := mlj
      z:=At("/",cd_saida)
      If z != 0
         mljx = Ret_Num(cd_saida)
      Endif

      wNumres_1 := Num_Reserva(mlj,wOrca,cd_datao,cd_codven,cd_codi,cd_quant,wCdz)    // Pega Numero de Reserva, Neste PRG
     *Alert(wNumres_1)

      If wReserva = 0
         Pega_Res := ""
         If File("&w_arq")
            ResPid   := MemoRead("&w_arq")
            W_Len    := Len(ResPid)
            Pega_Res := Substr(resPid,1,w_Len)
            Deletefile("&w_arq")

            Sele 25
            Set Order to 1
            If Bloqreg(0)
               Repl cd_reserv with val(Pega_Res)
            Endif
            Comm
            Unlock

            wUltRecno = Recno()
            wCodPres  = cd_codi
            wQuantres = cd_quant

            Ok := Verif_Res(wOrca)

            Sele 25
            Set Order to 1
            Go wUltRecno
         Else
            Alert("Reserva N„o Localizada !")
         Endif
      Else

         Sele 25
         Set Order to 1
         If (Alltrim(Str(wNumres_1,17)) = Alltrim(Str(wReserva,17)) .or. (wReserva=OldNumRes+1))
            If Bloqreg(0)
               Repl cd_reserv with wReserva
            Endif
            Comm
            Unlock
            Alert("Reserva Ok "+Str(wReserva))
         Else
            Alert("Numero de Reserva Invalido !")
         Endif

      Endif
   Endif
   Skip
   Lin++
   Release w_len,resPid
 Enddo
 Setcolor(cor)
 Release w_arq,wNumRes_1,wNumRes,Pega_Res,w_len,respid,wVended,cor,nResp,cHoras,Ok,wUltRecno,W_RESERVA
 Release m_ipConect,m_ipRetorn
Return(wRet)

//*********************
  Procedure Num_Reserva(mljx,mOrca,mdt,wCodvend,wCodip,wQuant,wCdz)
//*********************
 Priv nRet
      wdia := val(substr(dtoc(mdt),1,2))
      wmes := val(substr(dtoc(mdt),4,2))
      wano := val(substr(dtoc(mdt),9,2))

      wSoma_1 = StrZero(wCodvend,3)
      wsoma_1 = ((val(substr(wSoma_1,1,1)))+;
                 (val(substr(wSoma_1,2,1)))+;
                 (val(substr(wSoma_1,3,1))))

      wSoma_2 = StrZero(wCodip,6)
      wsoma_2 = ((val(substr(wSoma_2,1,1)))+;
                 (val(substr(wSoma_2,2,1)))+;
                 (val(substr(wSoma_2,3,1)))+;
                 (val(substr(wSoma_2,4,1)))+;
                 (val(substr(wSoma_2,5,1)))+;
                 (val(substr(wSoma_2,6,1))))

      wSoma_3 = StrZero(wQuant,3)
      wsoma_3 = ((val(substr(wSoma_3,1,1)))+;
                 (val(substr(wSoma_3,2,1)))+;
                 (val(substr(wSoma_3,3,1))))

      wSoma_4 = StrZero(wdia,2)
      wsoma_4 = ((val(substr(wSoma_4,1,1)))+;
                 (val(substr(wSoma_4,2,1))))

      wSoma_5 = StrZero(wmes,2)
      wsoma_5 = ((val(substr(wSoma_5,1,1)))+;
                 (val(substr(wSoma_5,2,1))))

      wSoma_6 = StrZero(wano,2)
      wsoma_6 = ((val(substr(wSoma_6,1,1)))+;
                 (val(substr(wSoma_6,2,1))))

      wSoma_7 = StrZero(mOrca,8)
      wsoma_7 = ((val(substr(wSoma_7,1,1)))+;
                 (val(substr(wSoma_7,2,1)))+;
                 (val(substr(wSoma_7,3,1)))+;
                 (val(substr(wSoma_7,4,1)))+;
                 (val(substr(wSoma_7,5,1)))+;
                 (val(substr(wSoma_7,6,1)))+;
                 (val(substr(wSoma_7,7,1)))+;
                 (val(substr(wSoma_7,8,1))))

      wSoma := wSoma_1+wSoma_2+wSoma_3+wSoma_4+wSoma_5+wSoma_6+wSoma_7

      D_V   := wSoma
      While wSoma >99
        If wSoma > 99 .and. wSoma < 999
           D_V = wSoma / 2
        Elseif wSoma > 999
           D_V = wSoma / 3
        Endif
        If D_V < 100
           Exit
        Endif
      Enddo

      wResult = int((wdia+wMes+wano)/3)
      wRes := mljx+Strzero(wCdz,2)+Alltrim(str(wResult,3))+Alltrim(str(wCodvend,3))+alltrim(str(wCodip,6))+alltrim(str(wQuant,3))+alltrim(str(d_v,2))

      wReservar:=Localiza_Res(val(wRes))
      Release mdt,wResult

Return(wReservar)

//*********************
  Function Localiza_Res(wRes)   // Verifica se ja tem uma reserva com o mesmo numero
//*********************
  Sele 29
  Set Order to 3
  Go Top
  While .t.
    Seek wRes
    If !Eof()
       wRes++
    Else
       Exit
    Endif
  Enddo
Return(wRes)

//********************
  Procedure Verif_Res(wOrca)      // Verifica se ha' reserva duplicada
//********************
  Local wOk
  wOk := "Ok"
  Sele 25
  Set Order to 1
  Seek STR(wOrca,8,0)+SUBSTR(DTOC(M_DATSI),7,4)+SUBSTR(DTOC(M_DATSI),4,2)+SUBSTR(DTOC(M_DATSI),1,2)
  n=0
  wOldNum = 0
  While !Eof() .and. CD_CODIOR = wOrca .and. CD_DATAO = M_DATSI
   If cd_reserv >0 .and. n = 0
      wOldNum = cd_reserv
      n++
   Endif
   Skip
   If CD_CODIOR = wOrca .and. CD_DATAO = M_DATSI .and. cd_reserv >0
      If Alltrim(Str(cd_reserv)) = Alltrim(Str(wOldNum))
         If Bloqreg(0)
            Repl cd_reserv with 0
         Endif
         Unlock
         wOk := ""
      Endif
   Endif
  Enddo
  Release wOldNum,n
  If Empty(wOk)
     Alert("Falha na Atualizacao. Favor Ligar Para Pedir o Nr de Reserva de um dos Itens ou Tente pelo F9 ")
  Endif
Return(wOk)

//********************
  Procedure Ver_Precos                    // Lista Com produtos com precos alterados
//********************
Priv wCodi[40000]
m      = "00001"
w_pass = "n"
Sele 3
Set Order to 1
Go Top
While !Eof()
 If cd_dat1 >= m_datsi
    w_pass = "s"
    wCodi[&m]=STRZERO(cd_codi,6)+" "+Substr(cd_Prod,1,23)+" "+Substr(cd_cor,1,5)+" "+str(cd_avista2,10,2)
    M = STRZERO(Val(m)+1,5,0)
 Endif
 Skip
Enddo
If w_pass = "s"
   wtel=savescreen(05,29,20,77)
   @ 05,29 to 20,77
   @ 06,30 clear to 19,76
   Set color to br/w
   @ 06,30 say "Codigo Descri‡„o do Produto    Cor     Valor R$"
   SetColor(c_corg)
   @ 07,30 to 07,76
   M_OPCA = ACHOICE(08,30,19,76,wCodi)
   restscreen(05,29,20,77,wtel)
   Keyb(chr(13))
Endif
Release w_pass,m,wCodi,m_opca,wtel
Release all like wCodi*
Return

//********************
  Procedure Verif_Imei          && Tecla F8 para Conferencia
//********************
 Cor = SetColor()
 m_im = savescreen(06,02,20,70)
 While .t.
   Padrao()  //cores
   MOV_LINHA := 6; MOV_COLUNA := 9
   JANELA( MOV_LINHA, MOV_COLUNA, MOV_LINHA + 13, MOV_COLUNA + 60, "Conferencia de Imei/N§ S‚rie Para Entrega " )
   SETCOLOR( CONTECOR[ 11 ] + "," + CONTECOR[ 9 ] + ",,," + CONTECOR[ 8 ] )
   M_imei   = Space(15)
   M_nSerie = Space(20)
   @ 08,20 Say "Bipar o Imei  : "get m_imei   pict "@!"
   @ 10,20 Say "Bipar N§ S‚rie: "get m_nSerie pict "@!" when Empty(m_imei)
   Read
   SETCOLOR( CONTECOR[ 2 ] + "," + CONTECOR[ 3 ] + ",,," + CONTECOR[ 2 ] )

   SetColor(Cor)
   If ((Lastkey() = 27) .or. (Empty(m_imei) .and. Empty(m_nSerie)))
      restscreen(06,02,20,70,m_im)
      Exit
   Endif
   Sele 44
   If !Empty(m_imei)
      Set Order to 1
      Seek m_imei
   ElseIf !Empty(M_nSerie)
      Set Order to 6
      Seek m_nSerie
   Endif
   If Eof()
      If !Empty(m_imei)
         Alert("Imei N„o Cadastrado !")
      ElseIf !Empty(M_nSerie)
         Alert("N§ S‚rie N„o Cadastrado !")
      Endif
      Loop
   Endif
   inkey(.1)
   m_codig = cel_codi
   wMinuta = minuta
   m_pass  = "n"
   wFaturado = "N"

   Sele 4
   Set Order to 1
   Seek Str(wMinuta,8,0)
   While !Eof() .and. sd_nota = wMinuta
     wPs = "n"
     If !Empty(m_imei) .and. sd_imei = m_imei .and. sd_codi = m_codig
        wPs = "s"
     ElseIf !Empty(m_nSerie) .and. sd_nserie = m_nSerie .and. sd_codi = m_codig
        wPs = "s"
     Endif
     If wPs = "s"
        m_pass  = "s"
        If !Empty(sd_fat)
           wFaturado = "S"
        Endif
        Exit
     Endif
     Skip
   Enddo
   If m_pass  = "n"
      Alert("Venda N„o Efetuada p/Este Produto. Verifique !")
   Else
      SetColor(c_corg)
      @ 11,15 to 11,65
      @ 16,15 to 16,65
      SETCOLOR( CONTECOR[ 11 ] + "," + CONTECOR[ 13 ] + ",,," + CONTECOR[ 13 ] )
      @ 12,20 say "Cliente     :"
      @ 13,20 say "Produto     :"
      @ 14,20 say "Or‡amento   :"
      @ 15,20 say "Faturado[SN]:"
      SETCOLOR(Cor)
      @ 12,34 say Substr(sd_nomecl,1,28)
      @ 13,34 say Strzero(sd_codi,6)+" "+Substr(sd_prod,1,20)
      @ 14,34 say Strzero(sd_orca,8)+"     Venda "+Strzero(sd_nota,8)
      @ 15,34 say wFaturado 
      Inkey(0)
   Endif
   restscreen(06,02,20,70,m_im)
   Release m_imei,m_pass,m_datas,m_im,m_codig
   Exit
 Enddo
 Return

//*******************
  PROCEDURE SAC_ZENIR
//*******************
  sc=savescreen(13,13,18,56)
  Set Color to N/W
  @ 13,13,16,56 BOX B_DOUBLE
  Set color to B+/W
  @ 13,13 Say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ"
  @ 14,13 Say "º                                          "
  @ 15,13 Say "º                                          "
  @ 16,13 Say "È"
  @ 14,15 prom "Sac Loja"
  @ 15,15 prom "Sac CDZ "
  Cor=Setcolor()
  SETCOLOR("B+/W, W+/B")
  Menu to wSac
  Setcolor(Cor)
  If Lastkey() = 27
     Restscreen(13,13,18,56,sc)
     Return
  Endif
  Set Color to
  Set Cursor On
  wCdz = "20"
  If wSac = 2
     @ 14,13 Say "º    Aguarde, Acessando...  SAC Zenir      "
     @ 15,13 Say "º                                          "
     If Loja = 6 .or. Loja = 9 .or. Loja = 32 .or. Loja = 46 .or. Loja = 52 .or. Loja = 54.or. Loja = 62
        wCdz = "99"
     ElseIf Loja = 8 .or. Loja = 31 .or. Loja = 48 .or. Loja = 63 .or. Loja = 69 .or. Loja = 70 .or. Loja = 14
        wCdz = "11"
     ElseIf Loja = 2 .or. Loja = 28
        wCdz = "20"
     ElseIf Loja = 37 .or. Loja = 39
        wCdz = "10"
     ElseIf xy_cap_int = "CC" .or. Loja = 55
        wCdz = "19"
     Endif
     If Lastkey() = 27
        RestScreen(13,13,18,56,sc)
        Return
     Endif

     Sele 24
     Veriout(SETCOLOR(),23,"filiais")
     Go Top
     While !Eof()
      If Fili = wCdz
         w_origem   = M_Lojad
         w_origem_p = strtran("&w_origem","(","",,,.T.)
         w_origem_p = strtran("&w_origem_p",")","",,,.T.)
         w_ip       = Trim(Ip_Tunel)
         Exit
      Endif
      Skip
     Enddo
     Use

     W_porta = ""
     wLink = "IpTunel"
     If (Loja=15 .and. wCdz="20")
        m_Ip = "127.0.0.1"                  // Mesmo Servidor
        w_Ip = "127.0.0.1"                  // Mesmo Servidor
     Else
        m_ip := TestaCon("Loja","F9")
        If Empty(m_ip)
           RestScreen(13,13,18,56,sc)
           Return
        Else
           w_ip := TestaCon("Destino","F9",w_ip,wCdz)
           If Empty(w_ip)
              RestScreen(13,13,18,56,sc)
              Return
           Endif
        Endif
     Endif

     @ 14,13 Say "º Acessando Sac On line "+w_origem_p
     ssh = 'ssh -C -l sac '+w_Ip+' &W_Porta -t -q "/zenir/modulo/sac/sac "'+strzero(Loja,2)+" "+wCdz+" "+m_ip
     *? ssh
     *inkey(0)
     !&ssh
  Else
     !/zenir/modulo/sac/./sac
     *!sac_loja
     *Alert("SAC Loja Pelo Crediario ou Fat!")
  Endif
Restscreen(13,13,18,56,sc)
Release wSac,sc,w_Origem,w_Origemp,cdz,wCdz
Return

//******************
  PROCEDURE MUDADATA
//******************
   Return

   Set Key 22 to
   Cor=SetColor()
   MD=SAVESCREEN(12,13,16,50)
   SET CURSOR ON
   M_DAT = M_DATSI
   Set color to n/W
   @ 12,13 clear to 16,48
   @ 13,15,15,46 BOX B_SINGLE
   Set color to W+/W
   @ 13,15 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ 14,15 Say "³Digite Nova Data :"get M_DAT
   @ 15,15 Say "À"
   READ
   IF !EMPTY(M_DAT)
       M_DATSI = M_DAT
       SAYDATA(0,67)
  ENDIF
  SETCOLOR(COR)
  RESTSCREEN(12,13,16,50,MD)
  Return

//*****************
  PROCEDURE VERIFCX(M_Dat)
//*****************
 Sele 10
 Veriout(setcolor(),23,"cdcash")     && caixa diario
 Set index to index_cdcash

 M_FECHACX="N"

 Sele 10
 Set Order to 1
 Seek M_Dat
 If !Eof()
    If CX_ENCE = "S"
       M_FECHACX="S"
       M_DATSI = CX_DATA+1
    Else
       M_FECHACX="N"
       M_DATSI = DATE()
    Endif
 Else
    M_DATSI = DATE()
 Endif
*M_DATSI = ctod("04/05/2022")
 M_ULTIMA=M_DATSI
 Use
Return

//***************
  PROC CONFIG_EMP    && CONFIGURANDO EMPRESA
//***************
/*
If Trim(M_nomeusu) = "HELIO"
   Veriout(SETCOLOR(),23,"empresa")
   wRet := isfield("DTAINISUP1")
   If wRet = .F.
      add_field("DTAINISUP1","D",8,0,"empresa.dbf")
   Endif
   Veriout(SETCOLOR(),23,"empresa")
   If bloqreg(0)
      Repl DTAINISUP1 with CTOD("29/08/2022")
   Endif
   Comm
   Unlock
   Veriout(SETCOLOR(),23,"empresa")
   wRet := isfield("DTAFIMSUP1")
   If wRet = .F.
      add_field("DTAFIMSUP1","D",8,0,"empresa.dbf")
   Endif
   Veriout(SETCOLOR(),23,"empresa")
   If bloqreg(0)
      Repl DTAFIMSUP1 with CTOD("30/09/2022")
   Endif
   Comm
   Unlock

   Veriout(SETCOLOR(),23,"empresa")
   wRet := isfield("DTAINISUP2")
   If wRet = .F.
      add_field("DTAINISUP2","D",8,0,"empresa.dbf")
   Endif
   Veriout(SETCOLOR(),23,"empresa")
   If bloqreg(0)
      Repl DTAINISUP2 with CTOD("")
   Endif
   Comm
   Unlock
   Veriout(SETCOLOR(),23,"empresa")
   wRet := isfield("DTAFIMSUP2")
   If wRet = .F.
      add_field("DTAFIMSUP2","D",8,0,"empresa.dbf")
   Endif
   Veriout(SETCOLOR(),23,"empresa")
   If bloqreg(0)
      Repl DTAFIMSUP2 with CTOD("")
   Endif
   Comm
   Unlock

   Veriout(SETCOLOR(),23,"empresa")
   wRet := isfield("DTAINISUP3")
   If wRet = .F.
      add_field("DTAINISUP3","D",8,0,"empresa.dbf")
   Endif
   Veriout(SETCOLOR(),23,"empresa")
   If bloqreg(0)
      Repl DTAINISUP3 with CTOD("10/10/2022")
   Endif
   Comm
   Unlock
   Veriout(SETCOLOR(),23,"empresa")
   wRet := isfield("DTAFIMSUP3")
   If wRet = .F.
      add_field("DTAFIMSUP3","D",8,0,"empresa.dbf")
   Endif
   Veriout(SETCOLOR(),23,"empresa")
   If bloqreg(0)
      Repl DTAFIMSUP3 with CTOD("31/10/2022")
   Endif
   Comm
   Unlock

   Veriout(SETCOLOR(),23,"empresa")
   wRet := isfield("DTAINISUP4")
   If wRet = .F.
      add_field("DTAINISUP4","D",8,0,"empresa.dbf")
   Endif
   Veriout(SETCOLOR(),23,"empresa")
   If bloqreg(0)
      Repl DTAINISUP4 with CTOD("")
   Endif
   Comm
   Unlock
   Veriout(SETCOLOR(),23,"empresa")
   wRet := isfield("DTAFIMSUP4")
   If wRet = .F.
      add_field("DTAFIMSUP4","D",8,0,"empresa.dbf")
   Endif
   Veriout(SETCOLOR(),23,"empresa")
   If bloqreg(0)
      Repl DTAFIMSUP4 with CTOD("")
   Endif
   Comm
   Unlock

   Unlock
   Veriout(SETCOLOR(),23,"empresa")
   wRet := isfield("PERCPROMOS")
   If wRet = .F.
      add_field("PERCPROMOS","N",6,2,"empresa.dbf")
   Endif
   Veriout(SETCOLOR(),23,"empresa")
   If bloqreg(0)
      Repl PERCPROMOS with 5
   Endif
   Comm
   Unlock
   use
Endif
*/

  Sele 48
  Veriout(SETCOLOR(),23,"empresa")
  If Indice = "S"
     Alert("Arquivos Sendo Indexados, Tente Mais Tarde !")
     Close All
     Cls
     Quit
  Endif
  // Pomomocao fora de linha
  /*
  If Bloqreg(0)
     Repl ini_flinha with ctod("19/12/2022"),fim_flinha with ctod("31/01/2023")
  Endif
  Unlock
  */

  I_UTEIS     = UTEIS
  I_FERI      = FERI
  I_DESCA     = DESCA
  I_FILI      = FILI
  I_FilOrigem = FILI
  I_PERC      = PERC
  I_JU        = JU
  I_DIAS_M    = ENTR_MOV
  I_DIAS_E    = ENTR_ELE
  IPS_ESTX    = SPC
  I_DARUMA    = DARUMA
  I_NOMET     = NOMET
  I_ENDET     = ENDET
  I_PLACA     = PLACA
  I_TXE       = TXE          // Taxa de Entrega ( Frete )
  I_TXM       = TXM          // Taxa de Montagem
  I_TAC       = TAC          // Tac ( TC Finanaceira )
  I_TXELECAP  = TX_ELE_CAP  // Taxa de eletro cartao p/ capital
  I_TXELEINT  = TX_ELE_INT  // Taxa de eletro cartao p/ interior
  I_TXMOVCAP  = TX_MOV_CAP  // Taxa de moveis cartao p/ capital
  I_TXMOVINT  = TX_MOV_INT  // Taxa de moveis cartao p/ interior
  I_TXCELCAR  = TX_CEL_CAR  // Taxa de celulares cartao p/ carne
  I_TXCELCC   = TX_CEL_CC   // Taxa de celulares cartao p/ cartao
  I_TXINFCAR  = TX_INF_CAR  // Taxa de informatica p/ carne
  I_TXINFCCC  = TX_INF_CCC  // Taxa de informatica cartao p/ capital
  I_TXINFCCI  = TX_INF_CCI  // Taxa de informatica cartao p/ interior
  I_TXCARNE   = TX_CARNE    // Taxa p/ vendas com carne
  I_TXCHEQUE  = TX_CHEQUE   // Taxa p/ vendas com cheque
  I_TXFINANC  = TX_FINANC   // Taxa p/ vendas com financeira
  I_TXCONVEN  = TX_CONVEN   // Taxa p/ vendas convenio
  I_TXMOTOS   = TX_MOTOS    // Taxa para motos
  I_DESCAVEL  = DESC_AV_EL  // Descontos p/ Vda A Vista p/ eletros
  I_DESCAVMO  = DESC_AV_MO  // Descontos p/ Vda A Vista p/ moveis
  I_FT_01L    = FT_01L      // FATORES LOSANGO C/ IOF
  I_FT_02L    = FT_02L
  I_FT_03L    = FT_03L
  I_FT_04L    = FT_04L
  I_FT_05L    = FT_05L
  I_FT_06L    = FT_06L
  I_FT_07L    = FT_07L
  I_FT_08L    = FT_08L
  I_FT_09L    = FT_09L
  I_FT_10L    = FT_10L
  I_FT_11L    = FT_11L
  I_FT_12L    = FT_12L
  I_FT_15L    = FT_15L
  I_FT_18L    = FT_18L
  I_FT_24L    = FT_24L
  I_DCELECAP  = DC_ELE_CAP  // Desc de eletro cartao p/ capital
  I_DCELEINT  = DC_ELE_INT  // Desc de eletro cartao p/ interior
  I_DCMOVCAP  = DC_MOV_CAP  // Desc de moveis cartao p/ capital
  I_DCMOVINT  = DC_MOV_INT  // Desc de moveis cartao p/ interior
  I_DCCELCAR  = DC_CEL_CAR  // Desc de celulares cartao p/ carne
  I_DCCELCC   = DC_CEL_CC   // Desc de celulares cartao p/ cartao
  I_DCINFCAR  = DC_INF_CAR  // Desc de informatica p/ carne
  I_DCINFCCC  = DC_INF_CCC  // Desc de informatica cartao p/ capital
  I_DCINFCCI  = DC_INF_CCI  // Desc de informatica cartao p/ interior
  I_DCCARNE   = DC_CARNE    // Desc p/ vendas com carne
  I_DCCHEQUE  = DC_CHEQUE   // Desc p/ vendas com cheque
  XY_EMPRESA  = EMPRESA
  XY_ENDEREC  = ENDEREC
  XY_CIDADE   = CIDADE
  XY_BAIRRO   = BAIRRO
  XY_MUNI     = MUNI
  XY_TELEFO   = TELEFO
  XY_UF       = UF
  XY_CEP      = CEP
  XY_CGC      = CGC
  XY_CGF      = CGF
  XY_SLOGAN   = SLOGAN
  XY_ISLOGAN  = ISLOGAN
  I_PRIORID   = LOJA_RES
  XY_GR       = GR_E
  XY_VRTROCA  = VRTROCAGR
  XY_DTI      = DT_INICIO
  XY_IniFLinha= INI_FLINHA   && Data Inicio de Promocao dos produtos fora de linha com comissao dobrada
  XY_FimFLinha= FIM_FLINHA   && Data Final de Promocao dos produtos fora de linha com comissao dobrada
  XY_ESTOQODOO= ESTOQODOO    && Saldos de Estoque pelo oDoo
  wPercentPromo=PERCPROMOS   && Parametros de Promocao por Supervisao

 // Tabela Promocional por tempo limitado e por Depto  (joaozinho) 
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

  If empty(xy_dti)
     xy_dti=ctod("01/09/1997")
  Endif
  If !Empty(Status)     // Status do Foradoar EstoqueReal
     If Time() < "08:00:00" .or. Time() > "18:00:00"
        If Bloqreg(0)
           Repl Status With " "
        Endif
        Unlock
     Endif
  Endif

  // Verificando se Tem Promocao por Supervisao   funcoes.prg
  wDescontoFilialSup = .f.
  RetAvistaSuper(DTAINISUP1,DTAFIMSUP1,DTAINISUP2,DTAFIMSUP2,DTAINISUP3,DTAFIMSUP3,DTAINISUP4,DTAFIMSUP4,1,2,3,4,@I_DESCAVEL,@I_DESCAVMO,@I_DCELECAP,@I_DCELEINT,@I_DCMOVINT,@I_DCCARNE,@I_DCMOVCAP,@I_DCCHEQUE,@wDescontoFilialSup)
  Sele 48
  Use

  Sele 48
  Veriout(SETCOLOR(),23,"filiais")
  While !Eof()
    If Fili = i_fili
       Lojax      = Trim(M_LOJAD)
       M_LOJA1    = Trim(M_LOJAD)
       vdir       = "/zenir/sistemas/loja"+trim(fili)
       Loja       = Val(fili)
       xy_cap_int = cap_int
       xy_com     = tipo_comis
       xy_cd      = cd
       xy_requi   = requisicao
       xy_reserva = reserva
       xy_reserva2= reserva2
       xy_reserva3= reserva3
       xy_ip_int  = trim(ip_interno)
       xy_ip_ext  = trim(ip_externo)
       xy_porta   = trim(porta)
       xy_ipibm   = trim(ip_ibm)
       xy_ibm_emb = trim(ip_ibm_emb)
       xy_embratel= trim(embratel)
       xy_outrosip= trim(outros_ip)
       xy_rotembra= trim(rot_embrat)
       xy_rotoi   = trim(rot_oi)
       XY_IPTUNEL = trim(Ip_Tunel)
       If !Empty(ip_interno)
          xy_ip   = trim(ip_interno)
       Else
          xy_ip   = trim(ip_externo)
       Endif
          xy_vend_td = tipo_comis
       Exit
    Endif
    Skip
  Enddo
  Pasta=vdir
  Lojas=loja
  Use

  /*
  If trim(m_nomeusu) = "HELIO"
    Sele 48
    Veriout(SETCOLOR(),23,"filiais")
    go top
    Sele 49
    Veriout(SETCOLOR(),23,"id")
    go top
    While !Eof()
     wcgc = cgc
     wID  = id
     Sele 48
     Go top
     While !Eof()
       If cgc = wCgc
          If Bloqreg(0)
             Repl IdOdoo with wID
          Endif
          Unlock
       Endif
       Skip
     Enddo
     Sele 49
     Skip
    Enddo
    Sele 48
    Use
    Sele 49
    Use
  Endif
 */

  Sele 48
  Veriout(SETCOLOR(),23,"emp_reserv")
  Go Top
  I_SENHA=SENHA
  Use

  // Atualizando datas e taxas temporarias
 /*
  Sele 48
  Veriout(SETCOLOR(),23,"empresa")
  If Bloqreg(0)
     If xy_cap_int = "CC"
        Repl taxacc_07 with 0
        Repl vezescc_07 with 10
        Repl dtinicc_07 with ctod("01/01/2023")
        Repl dtfimcc_07 with ctod("31/12/2023")
        Repl taxacc_08 with 0
        Repl vezescc_08 with 10
        Repl dtinicc_08 with ctod("01/01/2023")
        Repl dtfimcc_08 with ctod("31/12/2023")
 
        Repl taxacc_01 with 2.92
        Repl taxacc_02 with 2.92
        Repl taxacc_03 with 2.92
        Repl taxacc_04 with 2.92
        Repl taxacc_16 with 2.92
        Repl vezescc_01 with 12
        Repl vezescc_02 with 12
        Repl vezescc_03 with 12
        Repl vezescc_04 with 12
        Repl vezescc_16 with 12
        Repl dtinicc_01 with ctod("01/01/2023")
        Repl dtfimcc_01 with ctod("31/12/2023")
        Repl dtinicc_02 with ctod("01/01/2023")
        Repl dtfimcc_02 with ctod("31/12/2023")
        Repl dtinicc_03 with ctod("01/01/2023")
        Repl dtfimcc_03 with ctod("31/12/2023")
        Repl dtinicc_04 with ctod("01/01/2023")
        Repl dtfimcc_04 with ctod("31/12/2023")
        Repl dtinicc_16 with ctod("01/01/2023")
        Repl dtfimcc_16 with ctod("31/12/2023")

        && Eletroportateis cartao e carne
        Repl taxacc_03 with 0
        Repl vezescc_03 with 5
        Repl dtinicc_03 with ctod("01/01/2023")
        Repl dtfimcc_03 with ctod("31/12/2023")

        Repl taxaca_03 with 0
        Repl vezesca_03 with 5
        Repl dtinica_03 with ctod("01/01/2023")
        Repl dtfimca_03 with ctod("31/12/2023")

     Endif

     Repl taxacc_18 with 0
     Repl vezescc_18 with 5
     Repl dtinicc_18 with ctod("01/06/2022")
     Repl dtfimcc_18 with ctod("31/12/2030")

     Repl taxacc_19 with 0
     Repl vezescc_19 with 5
     Repl dtinicc_19 with ctod("01/06/2022")
     Repl dtfimcc_19 with ctod("31/12/2030")

     Repl taxaca_06 with 0
     Repl vezesca_06 with 3
     Repl dtinica_06 with ctod("01/06/2022")
     Repl dtfimca_06 with ctod("31/12/2030")

     Repl taxaca_18 with 0
     Repl vezesca_18 with 3
     Repl dtinica_18 with ctod("01/06/2022")
     Repl dtfimca_18 with ctod("31/12/2030")

     Repl taxaca_19 with 0
     Repl vezesca_19 with 3
     Repl dtinica_19 with ctod("01/06/2022")
     Repl dtfimca_19 with ctod("31/12/2030")
     If i_fili = "66" .or. i_fili = "58"
        Repl taxacc_06 with 0
        Repl vezescc_06 with 5
        Repl dtinicc_06 with ctod("01/06/2022")
        Repl dtfimcc_06 with ctod("31/12/2030")
     Endif
     If xy_cap_int = "CC"
        Repl taxacc_07 with 0
        Repl taxacc_08 with 0
        Repl vezescc_07 with 10
        Repl vezescc_08 with 10
        Repl dtinicc_07 with ctod("06/04/2021")
        Repl dtfimcc_07 with ctod("31/12/2022")
        Repl dtinicc_08 with ctod("06/04/2021")
        Repl dtfimcc_08 with ctod("31/12/2022")
     ElseIf xy_cap_int = "IN"
        Repl taxaca_01 with 0
        Repl taxaca_02 with 0
        Repl taxaca_03 with 0
        Repl taxaca_04 with 0
        Repl taxaca_16 with 0
        Repl taxaca_17 with 0
        Repl vezesca_01 with 4
        Repl vezesca_02 with 4
        Repl vezesca_03 with 4
        Repl vezesca_04 with 4
        Repl vezesca_16 with 4
        Repl vezesca_17 with 4
        Repl dtinica_01 with ctod("01/01/2022")
        Repl dtfimca_01 with ctod("31/12/2030")
        Repl dtinica_02 with ctod("01/01/2022")
        Repl dtfimca_02 with ctod("31/12/2030")
        Repl dtinica_03 with ctod("01/01/2022")
        Repl dtfimca_03 with ctod("31/12/2030")
        Repl dtinica_04 with ctod("01/01/2022")
        Repl dtfimca_04 with ctod("31/12/2030")
        Repl dtinica_16 with ctod("01/01/2022")
        Repl dtfimca_16 with ctod("31/12/2030")
        Repl dtinica_17 with ctod("01/01/2022")
        Repl dtfimca_17 with ctod("31/12/2030")
     Endif
  Endif
  Comm
  Unlock
  Use
 */
Return

//***************
  Proc Acess_Link              // ACESSANDO LINK DO DEPOSITO MAIS PROXIMO
//***************
 sst=savescreen(14,05,16,21)
 Sele 58
 Veriout(setcolor(),23,"ip_lojas")
 Go Top
 While .t.
   If xy_reserva = Nr_Filial
      Exit
   Endif
   Skip
 Enddo
 M_CORA =SETCOLOR()
 PRIV VETOR1[1],VETOR2[1]
 VETOR1[1]='FILIAL'
 VETOR2[1]='Sua Filial'
 @ 14,05 to 16,21
 DBEDIT(15,06,15,20,VETOR1,,,VETOR2)
 w_FILI = Nr_Filial
 Use
 Restscreen(14,05,16,21,sst)
 If Lastkey() = 27
    Release sst,m_ssh,W_Acess,mlj,wCdz
    keyb(chr(13))
    Return
 Endif
 Sele 58
 Veriout(SETCOLOR(),23,"filiais")
 While !Eof()
   If Fili = w_Fili
      m_origem   = M_lojad
      m_origem_p = strtran("&m_origem","(","",,,.T.)
      m_origem_p = strtran("&m_origem_p",")","",,,.T.)
      x_IP       = Trim(Ip_Tunel)
      wCdz       = FILI
      wCd        = CD
      Exit
   Endif
   Skip
 Enddo
 Use
 If Lastkey() = 27
    Release sst,m_ssh,W_Acess,mlj,wCdz
    keyb(chr(13))
    Return
 Endif
 Setcolor(xcorstatus)
 If (wCd <> "S")
    Release sst,m_ssh,W_Acess,mlj,wCdz
    Alert("Reservar Somente nos CDZ's !")
    keyb(chr(13))
    Return
 Endif
 W_Acess = "sistema0801reserva"
 If wCdz = "15"
    Release m_ssh,W_Acess,mlj,wCdz
    Alert("Reserva N„o Autorizada Para o Feirao Iguatu ! ")
    Return
 Endif
 sst1 = SaveScreen(11,13,16,56)
 Set Color to N/W
 @ 11,13,14,56 BOX B_DOUBLE
 Set color to W+/W
 @ 11,13 Say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ"
 @ 12,13 Say "º    Aguarde, Acessando Reserva OnLine     "
 @ 13,13 Say "º                                          "
 @ 14,13 Say "È"
 @ 13,18 say m_origem_p

 Stor "" to w_Porta
 wLink:= "IpTunel"
 @ 16,13 Say "Conectando Atraves da : "+wLink
 inkey(.1)

 If (Loja=15 .and. wCdz="20")
    w_Ip = "127.0.0.1"                  // Mesmo Servidor
 Else
    m_ip := TestaCon("Loja","")
    If Empty(m_ip)
       Return
    Else
       If Loja = 51
          w_ip := TestaCon("Destino","51",x_ip,wCdz)
       Else
          w_ip := TestaCon("Destino","",x_ip,wCdz)
       Endif
       If Empty(w_ip)
          Return
       Endif
    Endif
 Endif

 RestScreen(11,13,16,56,sst1)

 m_ssh = "ssh -C -l &W_Acess &w_ip &W_Porta"
 *? m_ssh
 *inkey(0)
 !&m_ssh

 Keyb(chr(27))
 Refresh()
 Release m_ssh,W_Acess,sst,sst1,mlj,wLink
Return

//******************
  Procedure IMP_FATU(i_fil)              // CONFIGURA IMPRESSORA DO FATURAMENTO
//******************
  Public Fisca
  Set Printer to

  dbarea= select()
  ord_ind = INDEXORD()                    // indice utilizado
  If ord_ind = 0
     ord_ind = 1
  Endif
  Sele 63
  Veriout(setcolor(),23,"impressora")
  Go Top
  While !Eof()
   If impressora = trim("desen")
      Exit
   Endif
   Skip
  Enddo
  If Eof()
     Go Top
  Endif
  M_CORA =SETCOLOR()
  TELA100=SAVESCREEN(12,55,19,74)
  SETCOLOR(C_corg)
  @ 12,55 clear to 19,74
  PRIV VETOR1[1]
  VETOR1[1]='IMPRESS'
  SETCOLOR("n+/w")
  DBEDIT(12,60,19,74,VETOR1,,,VETOR1)
  m_iprs = trim(impressora)
  z:=At("_",m_iprs)
  If z != 0
     fisca =trim(impressora)+trim(I_fil)
  Else
     fisca =trim(impressora)
  Endif
  Release m_iprs,Vetor1
  RESTSCREEN(12,55,19,74,TELA100)
  SETCOLOR(M_CORA)
  Use
  Sele &dbarea
  DBSETORDER(ord_ind)
Return(fisca)

//****************
  PROCEDURE TELAIN
//****************
PUBLIC CLIE1,CLIE2,CLIE3,CLIE4,CLIE5,CX12,FISC,ACESS3
PUBLIC OPC,SE,OKSENH,M_NOMEUSU,VEND3,LOJAU,NRLOJA
PUBLIC FORN1,FORN2,FORN3,ESTO1,ESTO2,ESTO3,ESTO4,ESTO5,ESTO6,ESTO7
PUBLIC MOVD1,MOVD2,MOVD3,MOVD4,MOVD5,MOVD6,MOVD7,MOVD8,MOVD9,MOVD10,MOVD11,MOVD12,MOVD13,MOVD14,MOVD15
PUBLIC RELE1,RELE2,RELE3,RELE4,RELE5,RELE6,RELE7,RELE8,RELE9,RELE10,RELE11,RELE12,RELE13,RELE14,MOVD16
PUBLIC PAGA1,RECE1,RECE2,UTIL1,CHEQ2,CHEQ1,VEND1,VEND2,PAGA2,FORN4,FORN5,CUST7,ESTO9
OKSENH = "N"

Set Color to W+/W
@ 00,00 Clear to 23,79
Set Color to N+/W
@ 00,00,24,79 BOX B_SINGLE
@ 02,00 Say "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 07,23,13,38 BOX B_SINGLE
    @ 08,40,12,62 BOX B_SINGLE
    @ 00,00 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    @ 01,00 Say "³"
    @ 02,00 Say "³"
    @ 03,00 Say "³"
    @ 04,00 Say "³"
    @ 05,00 Say "³"
    @ 06,00 Say "³"
    @ 07,00 Say "³"
    @ 08,00 Say "³ Acesso ao Sistema "+chr(16)
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

    Set color to gb+/w
    @ 07,23 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    @ 08,23 Say "³"
    @ 09,23 Say "³"
    @ 10,23 Say "³"
    @ 11,23 Say "³"
    @ 12,23 Say "³"
    @ 13,23 Say "À"

    @ 08,40 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    @ 09,40 Say "³"
    @ 10,40 Say "³"
    @ 11,40 Say "³"
    @ 12,40 Say "À"

   Set color to B/W
   @ 09,42 Say " 2013/xHarbour/ C "
   @ 10,42 Say " Conectiva Linux  "
   @ 11,42 Say " M¢dulo Vendas    "

   Set color to W+/B
   @ 01,01 CLEAR TO 01,78
   @ 01,33 Say "Zenir Moveis"
   @ 03,01,05,78 BOX B_SINGLE
   @ 03,01 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ 04,01 Say "³                                                                            "
   @ 05,01 Say "À"

   Set color to gr+/B
   @ 04,01 Say "³Sistema Integrado Empresarial - SIE                     "+DataExt(m_datsi)+" "+time()
   Set color to gr+/w

   wTexto = "02-Iguatu-2 03-CamposSales 04-Quixada 05-BrejoSanto 06-Crato 07-Mombaca 08-Sobral_1 09-Juazeiro 16-Barao 17-General "
   wTexto = wTexto + "21-Crateus 23-Senador-2 24-Acopiara 25-Maracanau 26-Quixeramobim 27-Itapipoca 28-Iguatu_3 29-V Alegre "
   wTexto = wTexto + "30-Assare 31-Sobral_2 32-Juazeiro_2 33-Senador_3 34-Ubajara 35-Cedro 36-Ico 37-Parambu 38-Tabuleiro 39-Taua "
   wTexto = wTexto + "40-Montese 41-Horizonte 42-Limoeiro 43-M Nova 14-Tiangua 45-Maranguape 46-M Velha 47-Pacajus 48-Sobral_3 "
   wTexto = wTexto + "49-Guaraciaba 51-Quixelo 52-Mauriti 53-Shopp Marac 54-Barbalha 55_Aracati 56-Shopp Mess 57-RMarKenn "
   wTexto = wTexto + "58-RMarPapi 59-SenPomp 60-P Branca 61-Caucaia 62_Shopp Cariri 63 Sobral 4 65.Senador 4 66.Iguatemi "
   wTexto = wTexto + "57-Eusebio Shopping 68-Messejana Centro 69-Massape 70-S Benedito 71-Cascavel 72-Pca Ferreira 73-Aquiraz"

   wCor=setcolor()
   wTelain = savescreen(00,00,24,79)
   @ 22,01 Say "Filiais:"
   SetColor("N+/W")
   @ 22,42 Say "Prog: H‚lio Milhomens (088)98812-2123"

   Desloca(23,24,01,wTexto)
   Restscreen(00,00,24,79,wtelain)
   Setcolor(wCor)

   Set cursor On
   SETCOLOR("B+/W, W+/B")
   If date() < ctod("10/12/2013")
      ssve=savescreen(,,,,)
      Desloca()
      restscreen(,,,,ssve)
      Release ssve
   Endif

   opc = 1

   Sele 48
   Veriout(SETCOLOR(),23,"empresa")
   Sele 48
   Goto Top
   I_FILI    := FILI
   I_PRIORID := LOJA_RES
   I_Fiscal  := EST_FISCAL
   Use
SELE 1
VERIOUT(SETCOLOR(),23,"usuario")
Set index to index_usuario
SELE 1
SET ORDER TO 1
SET CURSOR ON
SSU=SAVESCREEN(00,00,24,79)
While .T.
DO CASE
   CASE LASTKEY() = 27
        Clear
	CLOSE ALL
	QUIT
   CASE OPC = 5
     SEN()
     IF SE = "N"
        ALERT("Acesso N„o Autorizado")
        OKSENH = "N"
        LOOP
     ENDIF
     SELE 48
     VERIOUT(SETCOLOR(),23,"empresa")
     SELE 48
     Goto Top
     I_FILI    = FILI
     I_PRIORID = LOJA_RES
     @ 19,12 GET I_FILI PICT "99"
     @ 20,03 SAY "Prioridade"GET I_PRIORID PICT "99"
     READ
     CONFIRMA()
     IF LASTKEY()=13
        IF BLOQREG(0)
           Repl fili with i_fili,loja_res with i_priorid
        ENDIF
        Unlock
     ENDIF
     Use
     LOOP
  CASE OPC = 1
   M_CONT = 1
   While M_CONT < 4
    M_NOMEUSU = SPACE(15)
    M_ACESSO  = SPACE(15)

    If Trim(cWs1) = "deserver"
      M_NOMEUSU = "HELIO          "
    Else
       @ 08,25 SAy "Acessando..."
       @ 09,25 SAY "Usu rio"
       @ 10,25 GET M_NOMEUSU pict "@S10!" VALID M_NOMEUSU <> SPACE(15)
       Read
    Endif
    COR=SETCOLOR()
    @ 11,25 SAY "Acesso"
    IF LASTKEY() = 27
       CLS
       QUIT
    ENDIF
    IF LASTKEY() = 27
       CLS
       CLOSE ALL
       QUIT
    ENDIF
    SEEK M_NOMEUSU
    IF EOF()
       S=SAVESCREEN(23,00,23,80)
       Alert("Usu rio N„o Cadastrado... Verifique Usu rio !")
       M_CONT = M_CONT +1
       LOOP
    ENDIF
    If Trim(cWs1) = "deserver"
       M_ACESSO=ACESSO
       Keyb(chr(13))
       Exit
    Endif
    M_ACESSO=ACESSO
    Senha(M_ACESSO)
    IF ACESSO <> M_ACESSO
       S=SAVESCREEN(23,00,23,80)
       Alert("Senha N„o Cadastrada... Verifique !")
       M_CONT = M_CONT +1
       LOOP
    ELSE
       OKSENH = "S"
       RESTSCREEN(00,00,24,79,SSU)
       EXIT
    ENDIF
   ENDDO
   IF M_CONT >3
      SET COLOR TO
      Clear
      Alert("Acesso N„o Autorizado")
      Clear
      CLOSE ALL
      QUIT
   ENDIF
   If Lastkey()= 27
      Clear
      Close all
      Quit
   Endif
   Set Color To w+/b
   @ 04,01 clear to 06,48
   @ 00,00,24,80 BOX B_SINGLE
   @ 02,01,04,78 BOX B_SINGLE

   @ 21,01,23,79 BOX B_SINGLE
   Set color to b+/W
   *@ 21,01 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   *@ 22,01 Say "³"
   Set color to GR+/B
   @ 22,02 SAY "[  ]Ajud [  ]AcesLink [  ]Estq [  ]Sac [  ]Calc [  ]Data [  ]Cf Imei [  ]Res "
   Set color to w+/b
   @ 22,03 SAY "F1"
   @ 22,12 SAY "F2"
   @ 22,25 SAY "F4"
   @ 22,34 SAY "F5"
   @ 22,42 SAY "F6"
   @ 22,51 SAY "F7"
   @ 22,60 SAY "F8"
   @ 22,72 SAY "F9"
   Set color to B+/W

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
      ACESS3=U_ACESS3
      wUltimoac = u_datai

      If Empty(u_dataf)
         If Bloqreg(0)
            Repl u_dataf with m_datsi+180
         Endif
         Unlock
      Endif
      If Bloqreg(0)
         Repl u_datai with m_datsi
      Endif
      Unlock
      wDia  = u_dataf - m_datsi
      wRecno= recno()
      Use
      If Substr(m_nomeusu,1,5) <> "HELIO" .and. Substr(m_nomeusu,1,6) <> "CONTAB" .and. Substr(m_nomeusu,1,3) <> "TES"
         If wDia > 0 .and. wDia <= 5
            css=savescreen(,,,)
            Clear
            SetColor(vermel)
            Quadro(11,12,13,75,1)
            @ 12,13 say "Voce tem "+Strzero(wDia,2)+" Dias P/ Atualizar Sua Senha! Aperte F11 ao Entrar."
            Set Color to
            inkey(5)
            restscreen(,,,,css)
            setcolor(cor)
         ElseIf wDia <= 0
            Clear
            SetColor(vermel)
            Quadro(11,09,13,48,1)
            @ 12,10 say "Acesso Negado ! Renove sua Senha !"
            Set Color to
            Inkey(5)
            TrocaSen(M_Nomeusu,M_ACESSO,wRecno)
            Clear
            Close All
            Quit
         Endif
      Endif
      Release wDia,css
      Return(VEND3)
Endcase
Enddo
Return(VEND3)

//**************
  FUNCTION SENHA(M_SENHACES)
//**************
   chave=M_ACESSO
   lin1=12
   col1=25
   lin2:=lin1+1
   col2:=col1+10
   clear gets
   Priv sen:=savescreen(lin1-1,col1-21,lin2+1,col2+4)
   vez:=0
   clear typeahead
   do while (.t.)
      set cursor on
      senha20:=space(10) ; cont:=vr:=k:=0 ; col:=col1 ; c:=1
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
            @ 12,25 say space(10)
            Alert("Senha Inv lida")
         endif
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
   Restscreen(lin1-1,col1-21,lin2+1,col2+4,sen)
Return(M_SENHACES)

//**************
  Function Grava(wNomUs,wStat,wPid)
//**************
 wModulo = "Or‡amentos"
 Sele 40
 Veriout(setcolor(),23,"terminal")        && Acessos ao credi
 Set index to index_terminal

 Sele 40
 Set Order to 1
 Go Top
 If wStat = "E"
    If Adireg(0)
       Repl terminal With wmodulo,usuario With wNomUs,PID_Linux With wPID,;
            data With m_datsi,hora_entr With time(),Status With "Em Uso"
    Endif
    Comm
    Unlock
 Else
    Set Order to 2
    Seek Str(wPid,10,0)+SUBSTR(DTOC(M_Datsi),7,4)+SUBSTR(DTOC(M_Datsi),4,2)+SUBSTR(DTOC(M_Datsi),1,2)
    If !Eof()
       If Bloqreg(0)
          Repl hora_saida With time(),Status With "Em Off"
       Endif
       Comm
       Unlock
    Endif 
 Endif
 Use
 Release wModulo,wNomUs
Return

//*****************
  Function Muda_Est     // Muda estoques Fisico / Fiscal
//*****************
If m_nomeusu=trim("HELIO")
   Sele 48
   VERIOUT(SETCOLOR(),23,"empresa")
   Sele 48
   Goto Top
   I_Fiscal := EST_FISCAL
   @ 20,03 SAY "Estoque Fiscal "GET I_Fiscal PICT "@!"
   Read
   If Bloqreg(0)
      Repl Est_Fiscal with I_Fiscal
   Endif
   Comm
   Unlock
   Use
Endif

//**********
  Proc calen
//**********
setcolor(xcorstatus)
clear
mes=month(m_datsi)
ano=year(m_datsi)
!cal &mes &ano
inkey(0)
refresh()

//****************
  PROCEDURE CALCUL
//****************
MOV_LINHA := 5; MOV_COLUNA := 9
PADRAO()
calcu()
FUNCTION CALCU
//
// -> Fun‡„o que ativa a calculadora
LOCAL ULT_CURSOR := SETCURSOR(), ULT_COR := SETCOLOR(), LINHA := ROW(),;
      COLUNA := COL(), TELA, RESULTADO := 0, CONTADOR, CONTAR, LIN, COL,;
      ALGARISMOS := SPACE( 14 ), DECIMAIS := "", TECLA := CHR( 0 ),;
      MOV_TELA, ALG_OU_DEC := "A", PERCENTAGEM := " ", ULT_OPERADOR := "",;
      OK_OPERADOR := .F., CALCULO, TRANSPORTE, BO_TAO, TELA_CALCU,;
      L_CALCU, C_CALCU, TIPO_SAIDA := NIL, BOTOES := {;
      { 6, 4, " 7 ", { "7", CHR( T_HOME ) } },;
      { 6, 9, " 8 ", { "8", CHR( T_CIMA ) } },;
      { 6, 14, " 9 ", { "9", CHR( T_PGUP ) } },;
      { 6, 20, " - ", { "-" } },;
      { 6, 25, " + ", { "+" } },;
      { 8, 4, " 4 ", { "4", CHR( T_ESQUERDA ) } },;
      { 8, 9, " 5 ", { "5", CHR( 76 ) } },;
      { 8, 14, " 6 ", { "6", CHR( T_DIREITA ) } },;
      { 8, 20, " / ", { "/" } },;
      { 8, 25, " * ", { "*" } },;
      { 10, 4, " 1 ", { "1", CHR( T_END ) } },;
      { 10, 9, " 2 ", { "2", CHR( T_BAIXO ) } },;
      { 10, 14, " 3 ", { "3", CHR( T_PGDN ) } },;
      { 10, 20, " = ", { "=", CHR( T_ENTER ) } },;
      { 10, 25, " % ", { "%" } },;
      { 12, 4, " 0 ", { "0", CHR( T_INSERT ) } },;
      { 12, 9, " . ", { ".", CHR( T_DEL ) } },;
      { 12, 14, "Get", { "G" } },;
      { 12, 20, " C ", { "C", " " } },;
      { 12, 25, "cE ", { "E" } } }
DADOS_CALCU := {}

TELA := SAVESCREEN( 00, 00, MAXROW(), MAXCOL() )
JANELA( MOV_LINHA, MOV_COLUNA, MOV_LINHA + 15, MOV_COLUNA + 61, "Calculadora - S.I.E." )
COR( "BOX DA JANELA DE DIALOGO" )
@ MOV_LINHA + 1, MOV_COLUNA + 30, MOV_LINHA + 14, MOV_COLUNA + 30 BOX SPACE( 8 )
COR( "MENU" )
@ MOV_LINHA + 2, MOV_COLUNA + 33 CLEAR TO MOV_LINHA + 10, MOV_COLUNA + 58
SETCOLOR( ALLTRIM( SUBS( CONTECOR[ 5 ], 4 ) ) + "/" + ALLTRIM( SUBS( CONTECOR[ 4 ], 4 ) ) )
@ MOV_LINHA + 2, MOV_COLUNA + 4, MOV_LINHA + 4, MOV_COLUNA + 26 BOX "ÜÜÜÛßßßÛ"
FOR CONTAR := 1 TO LEN( BOTOES )
    BOT_CALC( MOV_LINHA + BOTOES[ CONTAR ][ 1 ],;
              MOV_COLUNA + BOTOES[ CONTAR ][ 2 ], BOTOES[ CONTAR ][ 3 ] )
NEXT
@ MOV_LINHA + 3, MOV_COLUNA + 5 SAY " " + STR( RESULTADO, 19, 4 ) + " " COLOR "W"
WHILE TECLA != CHR( T_ESC )
    TECLA := CHR( 0 )
    WHILE TECLA = CHR( 0 )
        TECLA := CHR( INKEY() )
    ENDDO
    TECLA := UPPER( TECLA )
    FOR CONTAR := 1 TO LEN( BOTOES )
        FOR CONTADOR := 1 TO LEN( BOTOES[ CONTAR ][ 4 ] )
            IF TECLA = BOTOES[ CONTAR ][ 4 ][ CONTADOR ]
                EXIT
            ENDIF
        NEXT
        IF CONTADOR <= LEN( BOTOES[ CONTAR ][ 4 ] )
            BOT_CALC( MOV_LINHA + BOTOES[ CONTAR ][ 1 ],;
                      MOV_COLUNA + BOTOES[ CONTAR ][ 2 ], BOTOES[ CONTAR ][ 3 ],;
                      .T. )
            TECLA := BOTOES[ CONTAR ][ 4 ][ 1 ]
            EXIT
        ENDIF
    NEXT
    SETCOLOR( "W" )
    IF AT( TECLA, CHR( 26 ) + CHR( 2 ) + CHR( 141 ) + CHR( 145 ) ) != 0
        MOV_TELA := SAVESCREEN( MOV_LINHA, MOV_COLUNA, MOV_LINHA + 15, MOV_COLUNA + 61 )
        RESTSCREEN( 00, 00, MAXROW(), MAXCOL(), TELA )
        IF TECLA = CHR( 26 )
            MOV_COLUNA--
        ELSEIF TECLA = CHR( 2 )
            MOV_COLUNA++
        ELSEIF TECLA = CHR( 141 )
            MOV_LINHA--
        ELSEIF TECLA = CHR( 145 )
            MOV_LINHA++
        ENDIF
        IF MOV_LINHA < 0
            MOV_LINHA := 0
        ELSEIF MOV_LINHA > 9
            MOV_LINHA := 9
        ELSEIF MOV_COLUNA < 0
            MOV_COLUNA := 0
        ELSEIF MOV_COLUNA > 20
            MOV_COLUNA := 20
        ENDIF
        RESTSCREEN( MOV_LINHA, MOV_COLUNA, MOV_LINHA + 15, MOV_COLUNA + 61, MOV_TELA )
    ENDIF
    IF TECLA = CHR( T_F1 )
    ENDIF
    IF TECLA = CHR( T_ESC )
        EXIT
    ENDIF

    IF TECLA = "."; ALG_OU_DEC := "D"; ENDIF
    ALGARISMOS := IIF( TECLA = "." .AND. ALGARISMOS = SPACE( 14 ),;
                    SPACE( 13 ) + "0", ALGARISMOS )
    IF TECLA = "%"
        IF RESULTADO != 0 .AND. ULT_OPERADOR $ "+-/*"
            PERCENTAGEM := IIF( PERCENTAGEM = "%", " ", "%" )
            SETCOLOR( ALLTRIM( SUBS( CONTECOR[ 6 ], 1, 2 ) ) + "/" +;
                      ALLTRIM( SUBS( CONTECOR[ 5 ], 4 ) ) )
            @ MOV_LINHA + 3, MOV_COLUNA + 26 SAY PERCENTAGEM
            IMP_CALCU( ALGARISMOS + "." + SUBS( DECIMAIS + "00", 1, 4 ) + "%" )
        ELSE
            @ MOV_LINHA + 3, MOV_COLUNA + 5 SAY SPACE( 13 ) + "0.00" COLOR "W"
            RESULTADO := 0; ALGARISMOS := SPACE( 14 ); DECIMAIS := ""
        ENDIF
    ELSEIF TECLA $ "0123456789" .AND.;
           IIF( ALG_OU_DEC = "A", LEN( LTRIM( ALGARISMOS ) ) != 14,;
                LEN( LTRIM( DECIMAIS ) ) != 4 )
        OK_OPERADOR := .T.
        IF ULT_OPERADOR = "="
            ULT_OPERADOR = " "
            RESULTADO = 0
        ENDIF
        IF ALG_OU_DEC = "A"
            ALGARISMOS = SUBS( ALGARISMOS + TECLA, 2 )
        ELSE
            DECIMAIS += TECLA
        ENDIF
        @ MOV_LINHA + 3, MOV_COLUNA + 6 SAY ALGARISMOS + "." + SUBS( DECIMAIS +;
                         "00", 1, 4 ) COLOR "W"
    ELSEIF TECLA $ "+-/*="
        IF TECLA != "="
            IF !OK_OPERADOR
                LOOP
            ENDIF
            OK_OPERADOR := .F.
        ENDIF
        IF RESULTADO != 0
            IF VAL( ALGARISMOS + "." + DECIMAIS ) != 0
                IF ULT_OPERADOR != "="
                    IF PERCENTAGEM = "%"
                        CALCULO := STR( RESULTADO, 19, 4 ) + ULT_OPERADOR + "(" +;
                                   STR( RESULTADO, 19, 4 ) + "*" + ALGARISMOS +;
                                   "." + SUBS( DECIMAIS + "00" , 1, 4 ) + ")/100.00"
                    ELSE
                        CALCULO := STR( RESULTADO, 19, 4 ) + ULT_OPERADOR +;
                                   ALGARISMOS + "." + SUBS( DECIMAIS + "00", 1, 4 )
                    ENDIF
                    RESULTADO := &CALCULO
                    IF STR( RESULTADO, 19, 4 ) = REPL( "*", 19 )
                        @ MOV_LINHA + 3, MOV_COLUNA + 6 SAY "    * E R R O *    " COLOR "W"
                        RESULTADO := 0
                        SETCOLOR( ALLTRIM( SUBS( CONTECOR[ 6 ], 1, 2 ) ) + "/" +;
                                  ALLTRIM( SUBS( CONTECOR[ 5 ], 4 ) ) )
                        @ MOV_LINHA + 3, MOV_COLUNA + 4 SAY " "
                        @ MOV_LINHA + 3, MOV_COLUNA + 26 SAY " "
                        IMP_CALCU()
                        IMP_CALCU( "E R R O        " )
                        IMP_CALCU()
                    ELSE
                        @ MOV_LINHA + 3, MOV_COLUNA + 6 SAY STR( RESULTADO, 19, 4 ) COLOR "W"
                        IF TECLA != "=" .AND. PERCENTAGEM != "%"
                          IMP_CALCU( TRAN( VAL( ALGARISMOS + "." + SUBS( DECIMAIS +;
                                "00", 1, 4 ) ), "@E 99,999,999,999,999.99" ) + TECLA )
                        ENDIF
                    ENDIF
                ENDIF
            ELSE
                IF TECLA != "="
                    IMP_CALCU( TRAN( RESULTADO, "@E 99,999,999,999,999.99" ) +;
                               TECLA )
                ENDIF
            ENDIF
        ELSEIF TECLA $ "+-/*"
            RESULTADO := VAL( ALGARISMOS + "." + DECIMAIS )
            IMP_CALCU( TRAN( VAL( ALGARISMOS + "." + SUBS( DECIMAIS + "00", 1,;
                       4 ) ), "@E 99,999,999,999,999.99" ) + TECLA )
        ENDIF
        SETCOLOR( ALLTRIM( SUBS( CONTECOR[ 6 ], 1 , 2 ) ) + "/" +;
                  ALLTRIM( SUBS( CONTECOR[ 5 ], 4 ) ) )
        @ MOV_LINHA + 3, MOV_COLUNA + 4 SAY IIF( TECLA $ "+-/*", TECLA, " " )
        @ MOV_LINHA + 3, MOV_COLUNA + 26 SAY " "
        IF TECLA = "="
            IF VAL( ALGARISMOS + "." + DECIMAIS ) != 0 .AND. PERCENTAGEM != "%"
                IMP_CALCU( TRAN( VAL( ALGARISMOS + "." + SUBS( DECIMAIS + "00",;
                           1, 4 ) ), "@E 99,999,999,999,999.99" ) + " " )
            ENDIF
            IMP_CALCU( "=" )
            IMP_CALCU( TRAN( RESULTADO, "@E 99,999,999,999,999.99" ) +;
                       " " )
            IMP_CALCU()
        ENDIF
        ALG_OU_DEC := "A"
        ALGARISMOS := SPACE( 14 )
        DECIMAIS := ""
        ULT_OPERADOR := TECLA
        PERCENTAGEM := " "
    ELSEIF TECLA $ "EC"
        ALG_OU_DEC := "A"
        ALGARISMOS := SPACE( 14 )
        DECIMAIS := ""
        PERCENTAGEM := " "
        IF TECLA $ "C"
            RESULTADO := 0
            SETCOLOR( ALLTRIM( SUBS( CONTECOR[ 6 ], 1, 2 ) ) + "/" +;
                      ALLTRIM( SUBS( CONTECOR[ 5 ], 4 ) ) )
            @ MOV_LINHA + 3, MOV_COLUNA + 4 SAY " "
            @ MOV_LINHA + 3, MOV_COLUNA + 26 SAY " "
            IMP_CALCU()
            IMP_CALCU( REPL( "Ä", 24 ) )
            IMP_CALCU()
        ENDIF
        @ MOV_LINHA + 3, MOV_COLUNA + 6 SAY SPACE( 13 ) + "0.00" COLOR "W"
    ELSEIF TECLA = "G"
        IF RESULTADO != 0
            TRANSPORTE := ALLTRIM( STR( RESULTADO ) )
        ELSE
            TRANSPORTE := ALLTRIM( STR( VAL( ALGARISMOS  + "." +  DECIMAIS ) ) )
        ENDIF
        IF "." $ TRANSPORTE
            FOR CONTADOR := LEN( TRANSPORTE ) TO 1 STEP -1
                IF SUBS( TRANSPORTE, CONTADOR, 1 ) != "0"
                    TRANSPORTE := SUBS( TRANSPORTE, 1, CONTADOR )
                    EXIT
                ENDIF
            NEXT
            IF SUBS( TRANSPORTE, LEN( TRANSPORTE ), 1 ) = "."
                TRANSPORTE := SUBS( TRANSPORTE, 1, LEN( TRANSPORTE ) - 1 )
            ENDIF
        ENDIF
        KEYBOARD TRANSPORTE
        EXIT
    ENDIF
ENDDO
SETCOLOR( ULT_COR )
RESTSCREEN( 00, 00, MAXROW(), MAXCOL(), TELA )
SETCURSOR( ULT_CURSOR )
*( L_CALCU, C_CALCU )
SETPOS( LINHA, COLUNA )

FUNCTION IMP_CALCU( CONTEUDO )
IF CONTEUDO = NIL; CONTEUDO := ""; ENDIF
COR( "MENU" )
SCROLL( MOV_LINHA + 2, MOV_COLUNA + 33, MOV_LINHA + 10, MOV_COLUNA + 58, 1 )
@ MOV_LINHA + 10, MOV_COLUNA + 33 SAY PADL( CONTEUDO, 25 )
IF CONTEUDO = REPL( "Ä", 24 )
    AADD( DADOS_CALCU, REPL( "-", 24 ) )
ELSEIF CONTEUDO = "="
    AADD( DADOS_CALCU, SPACE( 23 ) + "=" )
ELSE
    AADD( DADOS_CALCU, CONTEUDO )
ENDIF
RETURN NIL

FUNCTIO BOT_CALC( BOT_X, BOT_Y, BOT_N )
LOCAL TEMPO := SECONDS()
IF PCOUNT() = 4
    SETCOLOR( "N/" + ALLTRIM( SUBS( CONTECOR[ 4 ], 4 ) ) )
    @ BOT_X, BOT_Y + LEN( BOT_N ) - 1 SAY " "
    @ BOT_X + 1, BOT_Y - 1 SAY REPL( " ", LEN( BOT_N ) )
    IF BOT_Y = 20 + MOV_COLUNA .OR. BOT_Y = 25 + MOV_COLUNA
        COR( "BOTAO EM DESTAQUE" )
    ELSE
        COR( "BOTOES" )
    ENDIF
    @ BOT_X, BOT_Y - 1 SAY BOT_N
    WHILE ( SECONDS() - TEMPO ) < .1; ENDDO
    SETCOLOR( "N/" + ALLTRIM( SUBS( CONTECOR[ 4 ], 4 ) ) )
    @ BOT_X, BOT_Y - 1 SAY "Ü"
    @ BOT_X + 1, BOT_Y - 1 SAY REPL( "ß", LEN( BOT_N ) )
ENDIF
IF BOT_Y = 20 + MOV_COLUNA .OR. BOT_Y = 25 + MOV_COLUNA
    COR( "BOTAO EM DESTAQUE" )
ELSE
    COR( "BOTOES" )
ENDIF
@ BOT_X, BOT_Y SAY BOT_N
SETCOLOR( "N/" + ALLTRIM( SUBS( CONTECOR[ 4 ], 4 ) ) )
@ BOT_X, BOT_Y - 1 SAY "Ü"
@ BOT_X + 1, BOT_Y - 1 SAY REPL( "ß", LEN( BOT_N ) )
RETURN .T.
***

FUNCTION JANELA( PJAN1, PJAN2, PJAN3, PJAN4, PJAN5 )
IF PCOUNT() != 5
    PJAN5 := ""
ENDIF
SETCOLOR( CONTECOR[ 4 ] )
@ PJAN1, PJAN2 CLEAR TO PJAN3, PJAN4
*SETCOLOR( CONTECOR[ 5 ] )
SETCOLOR("w+/g+")
@ PJAN1, PJAN2, PJAN3, PJAN4 BOX " "
@ PJAN1, PJAN2 SAY "þ"
IF LEN( TRIM( PJAN5 ) ) > 0
    @ PJAN1, PJAN2 + ( ( ( PJAN4 + 1 - PJAN2 ) - LEN( PJAN5 ) ) / 2 ) SAY PJAN5
ENDIF
****

FUNCTION COR( NOM_COR )
QUAL_COR := ASCAN( NOMECOR, UPPER( NOM_COR ) )
IF QUAL_COR != 0
    IF QUAL_COR = 2
        SETCOLOR( CONTECOR[ 2 ] + "," + CONTECOR[ 3 ] + ",,," + CONTECOR[ 2 ] )
    ELSEIF QUAL_COR = 8
        SETCOLOR( CONTECOR[ 11 ] + "," + CONTECOR[ 9 ] + ",,," + CONTECOR[ 8 ] )
    ELSE
        SETCOLOR( CONTECOR[ QUAL_COR ] )
    ENDIF
ENDIF
RETURN .T.
****
***

FUNCTION PADRAO
CONTECOR:={}
CONTECOR := { "09/01",;
              "00/07",;
              "15/04",;
              "07/01",;
              "00/03",;
              "00/07",;
              "15/07",;
              "00/07",;
              "15/04",;
              "15/01",;
              "07/01",;
              "07/01",;
              "15/03" }

   // -> Controle de cores
    NOMECOR := { "FUNDO DA TELA",;
             "MENU",;
             "DESTAQUE DO MENU",;
             "JANELA DE DIALOGO",;
             "BOX DA JANELA DE DIALOGO",;
             "BOTOES",;
             "BOTAO EM DESTAQUE",;
             "GETS",;
             "GET EM DESTAQUE",;
             "TELA DE APRESENTACAO",;
             "CARACTERES AVULSOS",;
             "CERCADURAS",;
             "TITULO" }

RETURN .T.

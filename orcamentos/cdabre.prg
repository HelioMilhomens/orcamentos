********************************************************
/*
   file name : cdabre.prg
   by        : helio-sp
   desc      : abre arquivos compartilhados
*/
********************************************************
#include "migracao.ch"
#include "box.ch"

Procedure CdAbre()

Abre_Ind()

set exclusive off

sele 1
veriout(setcolor(),23,"cdclie")     && clientes
@ 19,61 say "(cdclie)  "
set index to index_clientes

sele 2
veriout(setcolor(),23,"cdforn")     && Fornecedores
@ 19,61 say "(cdforn)  "
set index to index_cdforn

sele 3
veriout(setcolor(),23,"cdsie")      && estoque
@ 19,61 say "(cdsie)   "
set index to index_cdsie

sele 4
veriout(setcolor(),23,"cdsaid")     && vendas
@ 19,61 say "(cdsaid)  "
set index to index_cdsaid

If esto9<>"N"
   sele 11
   veriout(setcolor(),23,"transfer")   && transferencias
   @ 19,61 say "(transfer)"
   set index to index_transfer
Endif

sele 14
veriout(setcolor(),23,"cidades")     && cadastro de cidades p/ fat COD_IBGE
@ 19,61 say "(cidades)"

sele 16
veriout(setcolor(),23,"cdbalc")     && vendedores
@ 19,61 say "(cdbalc)  "
set index to index_cdbalc

sele 17
veriout(setcolor(),23,"cdgrup")     && grupos
@ 19,61 say "(cdgrup)  "
set index to index_cdgrup

If movd8<>"N"
  sele 19
  veriout(setcolor(),23,"cdentra")  && entradas de mercadorias
  @ 19,61 say "(cdentra) "
  set index to index_cdentra
endif

Sele 25
veriout(setcolor(),23,"cdorca")     && orcamentos
@ 19,61 say "(cdorca)  "
set index to index_cdorca

Sele 29
veriout(setcolor(),23,"cdreserv")   && RESERVA DE ESTOQUE
@ 19,61 say "(cdreserv)"
Set Index to index_reserva

sele 30
veriout(setcolor(),23,"estoloja")   && ESTOQUE POR LOJA
@ 19,61 say "(estoloja)"
set index to index_estoloja

sele 27
veriout(setcolor(),23,"cdcida")      && cad de bairros e cidades
set index to index_cdcida
@ 19,61 say "(cdcida)  "

Sele 35
Veriout(setcolor(),23,"garantia")    && CADASTRO DE GARANTIA
@ 19,61 say "(garantia)"
Set index to index_garantia

/*
sele 40                             && So abre se necessario em siste.prg
veriout(setcolor(),23,"fun")        && Cadastro de Funcionrios / Folha
@ 19,61 say "(fun)     "
set index to index_funcio
*/

/*
sele 42
veriout(setcolor(),23,"cores")      && Cores de estoque (associacao de codigos)
@ 19,61 say "(cores)   "
set index to index_cores
*/

sele 43
veriout(setcolor(),23,"sgrupo")       && Sub_Grupos de Produtos
@ 19,61 say "(sgrupo)  "
set index to index_sgrupo

sele 44
veriout(setcolor(),23,"imei")         && Cadastro de Imei
@ 19,61 say "(imei)    "
set index to index_imei

Sele 54
Veriout(SETCOLOR(),23,"pendencia")
@ 19,61 say "(pendencias) "
set index to index_pendencia

sele 53
veriout(setcolor(),23,"mobile")    && Mobile Cursos
@ 19,61 say "(mobile)     "
set index to index_mobile

sele 57
veriout(setcolor(),23,"circcpd")    && Circulares do CPD
@ 19,61 say "(circcpd) "
set index to index_circcpd
@ 19,61 say "          "
Return

//******************
  Procedure Abre_Ind       // Ver naum ta faltando nenhum indice
//******************
Stor Space(01) to arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16
abre = "s"
arq1="index_clientes.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdforn.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdsie.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdsaid.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdsai2.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_spc.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdcashd.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_transfer.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdcash.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdplano.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cheques.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdbalc.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdgrup.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdentra.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdcomun.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdmont.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdorca.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdrequi.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_reserva.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_estoloja.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_textos.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_garantia.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_lixo.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_circular.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdfisc.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdconta.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdcash.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdauto.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_cdcusto.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_teto.cdx"
Ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
arq1="index_usuario.cdx"
Release arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10
Release arq11,arq12,arq13,arq14,arq15,arq16,abre

//*****************
  Procedure ver_arq(arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16)
//*****************
 Stor "s" to abre
While .t.
If !empty(arq1)
 If !File("&arq1")
    abre="n"
 Endif
 If abre = "n"
    Alert("Indice N„o Ativo -> "+arq1)
    exit
 endif
Endif
If !empty(arq2)
 If !File("&arq2")
    abre="n"
 Endif
 If abre = "n"
    Alert("Indice N„o Ativo -> "+arq2)
    exit
 endif
Endif
If !empty(arq3)
 If !File("&arq3")
    abre="n"
 Endif
 If abre = "n"
    Alert("Indice N„o Ativo -> "+arq3)
    exit
 endif
Endif
If !empty(arq4)
 If !File("&arq4")
    abre="n"
 Endif
 If abre = "n"
    Alert("Indice N„o Ativo -> "+arq4)
    exit
 endif
Endif
If !empty(arq5)
 If !File("&arq5")
    abre="n"
 Endif
 If abre = "n"
    Alert("Indice N„o Ativo -> "+arq5)
    exit
 endif
Endif
If !empty(arq6)
 If !File("&arq6")
    abre="n"
 Endif
 If abre = "n"
    Alert("Indice N„o Ativo -> "+arq6)
    exit
 endif
Endif
If !empty(arq7)
 If !File("&arq7")
    abre="n"
 Endif
 If abre = "n"
    Alert("Indice N„o Ativo -> "+arq7)
    exit
 endif
Endif
If !empty(arq8)
 If !File("&arq8")
    abre="n"
 Endif
 If abre = "n"
    Alert("Indice N„o Ativo -> "+arq8)
    exit
 endif
Endif
If !empty(arq9)
 If !File("&arq9")
    abre="n"
 Endif
 If abre = "n"
    Alert("Indice N„o Ativo -> "+arq9)
    exit
 endif
Endif
If !empty(arq10)
 If !File("&arq10")
    abre="n"
 Endif
 If abre = "n"
    Alert("Indice N„o Ativo -> "+arq10)
    exit
 endif
Endif
If !empty(arq11)
 If !File("&arq11")
    abre="n"
 Endif
 If abre = "n"
    Alert("Indice N„o Ativo -> "+arq11)
    exit
 endif
Endif
If !empty(arq12)
 If !File("&arq12")
    abre="n"
 Endif
 If abre = "n"
    Alert("Indice N„o Ativo -> "+arq12)
    exit
 endif
Endif
If !empty(arq13)
 If !File("&arq13")
    abre="n"
 Endif
 If abre = "n"
    Alert("Indice N„o Ativo -> "+arq13)
    exit
 endif
Endif
If !empty(arq14)
 If !File("&arq14")
    abre="n"
 Endif
 If abre = "n"
    Alert("Indice N„o Ativo -> "+arq14)
    exit
 endif
Endif
If !empty(arq15)
 If !File("&arq15")
    abre="n"
 Endif
 If abre = "n"
    Alert("Indice N„o Ativo -> "+arq15)
    exit
 endif
Endif
If !empty(arq16)
 If !File("&arq16")
    abre="n"
 Endif
 If abre = "n"
    Alert("Indice N„o Ativo -> "+arq16)
    exit
 endif
Endif
  exit
Enddo
  If abre ="n"
     Release arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10
     Release arq11,arq12,arq13,arq14,arq15,arq16,abre
     Alert("Falta de Indices ! Consulte Credi rio ")
     Close All
     clear
     Quit
  Endif

Stor Space(01) to arq1,arq2,arq3,arq4,arq5,arq6,arq7,arq8,arq9,arq10,arq11,arq12,arq13,arq14,arq15,arq16

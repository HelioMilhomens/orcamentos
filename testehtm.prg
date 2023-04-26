
#define CTRL Chr(13)+Chr(10)

private hArquivo,;
        cUltimaAtu := DToC(Date())
Set Century ON
Set(4, iif(__SetCentury(), "dd/mm/yyyy", "dd/mm/yy"))  
Set(5,year(date())-95)                                
Set Date Brit
Clear
hArquivo := fCreate('testehtm.htm',0)
If hArquivo = -1
   Alert('Erro na criacao do arquivo')
   Return NIL
EndIf
Use clientes New Exclusive

* --- Inicio da pagina
HtmlHeader()

* --- Cabecalho do relatorio
fWrite(hArquivo,'<table width="100%" border="0">'+CTRL)
fWrite(hArquivo,'<tr bgcolor="#CCCCCC">'+CTRL)
fWrite(hArquivo,'<td><strong>C&oacute;digo</strong></td>'+CTRL)
fWrite(hArquivo,'<td><strong>Nome</strong></td>'+CTRL)
fWrite(hArquivo,'<td><strong>Endere&ccedil;o</strong></td>'+CTRL)
fWrite(hArquivo,'<td><strong>Bairro</strong></td>'+CTRL)
fWrite(hArquivo,'<td><strong>CEP</strong></td>'+CTRL)
fWrite(hArquivo,'<td><strong>Cidade</strong></td>'+CTRL)
fWrite(hArquivo,'<td><strong>UF</strong></td>'+CTRL)
fWrite(hArquivo,'</tr>'+CTRL)

* --- Linhas de detalhe do relatorio
clientes->(DbGoTop())
Do While !clientes->(Eof())
   fWrite(hArquivo,'<tr class="small">'+CTRL)
   fWrite(hArquivo,'<td>'+cdclie->cl_codi+'</td>'+CTRL)
   fWrite(hArquivo,'<td>'+cdclie->cl_nome+'</td>'+CTRL)
   fWrite(hArquivo,'<td>'+cdclie->cl_ende+'</td>'+CTRL)
   fWrite(hArquivo,'<td>'+cdclie->cl_bair+'</td>'+CTRL)
   fWrite(hArquivo,'<td>'+cdclie->cl_cep+'</td>'+CTRL)
   fWrite(hArquivo,'<td>'+cdclie->cl_cida+'</td>'+CTRL)
   fWrite(hArquivo,'<td>'+cdclie->cl_uf+'</td>'+CTRL)
   fWrite(hArquivo,'</tr>'+CTRL)
   clientes->(DbSkip())
EndDo

* --- Final do relatorio
fWrite(hArquivo,'</table>'+CTRL)

* --- Final da pagina
HtmlFoot()
HtmlBottom()

fClose(hArquivo)

DbCloseAll()

* --- GRANDE... usando os macetes esquecidos do RWindows...
*!start testehtm.htm

Return NIL
* -----------------------------------------------------------------------------
Function HtmlHeader()
* Inicio da pagina
* -----------------------------------------------------------------------------
fWrite(hArquivo,'<HTML>'+CTRL)

* Inclui um style.css para os caracteres da linha de detalhe
fWrite(hArquivo,'<style type="text/css">'+CTRL)
fWrite(hArquivo,'<!--'+CTRL)
fWrite(hArquivo,'.small {'+CTRL)
fWrite(hArquivo,'       font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;'+CTRL)
fWrite(hArquivo,'       font-size: 9px;'+CTRL)
fWrite(hArquivo,'}'+CTRL)
fWrite(hArquivo,'-->'+CTRL)
fWrite(hArquivo,'</style>'+CTRL)

fWrite(hArquivo,'<HEAD>'+CTRL)
fWrite(hArquivo,'<TITLE>"PontoPRG - Pronto Socorro de Sistemas Clipper"</TITLE>'+CTRL)
fWrite(hArquivo,'</HEAD>'+CTRL)
fWrite(hArquivo,'<BODY>'+CTRL)
fWrite(hArquivo,'<TABLE WIDTH="100%" BORDER="0">'+CTRL)
fWrite(hArquivo,'<TR>'+CTRL)
fWrite(hArquivo,'<TR ALIGN="CENTER" BGCOLOR="#E1E8F0"><TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" BGCOLOR="#FFFFFF">'+CTRL)
fWrite(hArquivo,'<TR>'+CTRL)
fWrite(hArquivo,'<TD WIDTH="40%" ALIGN="CENTER"><img src="logotoya.jpg" WIDTH="225" height="75"></td>'+CTRL)
fWrite(hArquivo,'<td WIDTH="60%" ALIGN="CENTER" bgcolor="#e1e8f0"><font size="4">CADASTRO DE CLIENTES</font> </td>'+CTRL)
fWrite(hArquivo,'</tr>'+CTRL)
fWrite(hArquivo,'</TABLE></td>'+CTRL)
fWrite(hArquivo,'</tr>'+CTRL)
fWrite(hArquivo,'</TABLE>'+CTRL)
Return NIL
* -----------------------------------------------------------------------------
Function HtmlFoot()
* Rodape da pagina
* -----------------------------------------------------------------------------
fWrite(hArquivo,'<table width="100%" border="0" bgcolor="#e1e8f0">'+CTRL)
fWrite(hArquivo,'<tr>'+CTRL)
fWrite(hArquivo,'<td><table width="100%" border="0" bgcolor="ffffff">'+CTRL)
fWrite(hArquivo,'<tr>'+CTRL)
fWrite(hArquivo,'<td align="center">&Uacute;ltima atualiza&ccedil;&atilde;o: '+cUltimaAtu+' </td>'+CTRL)
fWrite(hArquivo,'</tr>'+CTRL)
fWrite(hArquivo,'<tr>'+CTRL)
fWrite(hArquivo,'<td align="center">Copyright &copy; 2004~2005 - <em><strong>toya</strong></em></td>'+CTRL)
fWrite(hArquivo,'</tr>'+CTRL)
fWrite(hArquivo,'</table></td>'+CTRL)
fWrite(hArquivo,'</tr>'+CTRL)
fWrite(hArquivo,'</table>'+CTRL)
Return NIL
* -----------------------------------------------------------------------------
Function HtmlBottom()
* Final da pagina
* -----------------------------------------------------------------------------
fWrite(hArquivo,'</BODY>'+CTRL)
fWrite(hArquivo,'</HTML>'+CTRL)
Return NIL
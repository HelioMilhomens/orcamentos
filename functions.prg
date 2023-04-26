//==========================================================================
// Sistema  .........: Arquivo com Funcoes criadas para substituir e manter a compatibilidade
//                    Com os modulos do sistema atual feito em Flagship
// Programa .........: functions.prg
// Autor ............: Alexandre Nascimento - Sex Abr 12 15:57:46 BRT 2013
// Ult. Alteracao....: Alexandre Nascimento - Sex Abr 12 15:57:59 BRT 2013
//==========================================================================

//Criar o arquivo Main que o flagship cria quando inicia a aplicação
#pragma BEGINDUMP
#include "hbapi.h"
#include "hbapiitm.h"
#include "hbapierr.h"
#include <errno.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
//=============================================
HB_FUNC(CREATEFILEMAIN) {
//=============================================
    unsigned char *cFile;
    cFile = hb_parc(1);
    FILE *address_of_file;
    address_of_file = fopen(cFile,"w");

    if (address_of_file == NULL)
    {
        printf("Nao consegui criar arquivo %s\n", cFile);
        return(0);
    }
    fclose(address_of_file);
}
#pragma ENDDUMP

// Procedure para substituir a funcao ExecPIDNum do flagship
#pragma BEGINDUMP
#include "hbapi.h"
#include "hbapiitm.h"
#include "hbapierr.h"
#include <errno.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>

//=============================================
HB_FUNC(GETPIDNUM)
//=============================================
{
    pid_t pid;
	/* obtem o id do processo */
	if ((pid = getpid()) < 0) {
	  perror("nao conseguir obter o pid");
	}
    hb_retnint( pid );
	//return(0);
}
#pragma ENDDUMP

//=============================================
Function ExecPIDNum()
//=============================================
Local nPid:=GetPidNum()
Local cFileName:=GetPathLoja()+"main."+Alltrim(str(nPid))
CreateFileMain(cFileName)
Return nPid

//=============================================
Function GetPathLoja()
//=============================================
Local cPathLoja:=""
Local cDbf:="empresa.dbf"
if file(cDbf)
   AbreDbf(cDbf,"Empresa")
   // Alert("Erro ao Abrir Dbf: " + cDBf)
   // quit
    Empresa->(dbGoTop())
    cPathLoja:="/zenir/sistemas/loja"+trim(fili)+"/"
    Empresa->(DBCloseArea())
endif
Return cPathLoja

//============================================
Procedure AbreDbf(cNomeDaTabela,cAlias)
//============================================
Local cDriver:="DBFCDX",lRet
//->Abre a tabela DBF em modo compartilhado e somente-leitura.
dbUseArea(.t.,cDriver,cNomeDaTabela,cAlias,.t.,.t.)
lRet:=iif(&cAlias->(Used()),.t.,.f.)
Return lRet

// Parser para substituir a chamada da funcao FS_SET(...)
// do Flagship no sistema.
//=============================================
Function FS_SET(p1)
//=============================================
Local cRetorno
Do Case
    Case lower(p1)="printfile"
        //cRetorno:= "/tmp/" + AppName() + "." + alltrim(str(ExecPidNum()))
        //cRetorno:= "./main" + "." + alltrim(str(ExecPidNum()))
        //cRetorno:= "main." + alltrim(str(ExecPidNum()))
        cRetorno:= "main." + Pid
        Set Print to &cRetorno
    OtherWise
        cRetorno:=""
EndCase
return cRetorno

//=============================================
Function AppName(lpath)
//=============================================
LOCAL nPos, cRet,cBarra:="/"
nPos:= rat(cBarra, hb_argv(0))
cRet:= substr(hb_argv(0), nPos+1)
If !Empty(lpath)
   cRet:= cBarra+CurDir()+cBarra+cRet
endif
Return cRet

//=============================================
Function Refresh()
//=============================================
Return .t.

// Parser em C para a chamad Chdir() do
// #cInline do Flagship
#pragma BEGINDUMP
#include "hbapi.h"
//=============================================
HB_FUNC(CHDIR) {
//=============================================
    unsigned char *cDir;
    cDir = hb_parc(1);

    if (chdir(cDir) == 0 )
        {
        // printf("Mudando para %s\n", cDir);
        chdir(cDir);
        }
    else
        printf("Chamada Chdir() com Pasta invalida %s\n", cDir);
}
#pragma ENDDUMP



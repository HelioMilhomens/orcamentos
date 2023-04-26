#!/usr/bin/env bash
# todo: implementar script
#
#xbuild pedid.xbp -B -All -Classic
##############
EXE="orca"
MAIN="siste.prg"

#xbuild $EXE $MAIN -Iinclude -B -Classic -Con -Link -Oc_out -DHB_EXT_INKEY \

xbuild $EXE $MAIN -L/zenir/modulo/libs -Iinclude -B -Classic -Con -Link libhbtip.a libconectordb.a -Oc_out -DHB_EXT_INKEY /zenir/erp_zenir/geral/functions.prg \
siste.prg \
cdabre.prg \
esto.prg \
fichae.prg \
funcoes.prg \
gr.prg \
help.prg \
imei.prg \
impressa.prg \
orca.prg \
pfile.prg \
rede.prg \
smv06.prg \
smv09.prg \
usuario.prg \
vdi.prg \
comvendas.prg \
aspfunco.prg \
importatxt.prg \
functions.prg

# Limpeza
~/xharbour/scripts/clean.sh

#Copia
#cp $EXE /zenir/sistemas/loja45/
#cd /zenir/sistemas/loja45/
./$EXE
#cd -

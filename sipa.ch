// -> Contantes utilizadas para ligar e desligar o cursor
#define DESLIGA  0
#define LIGA     1
#define CURSOR(P_CUR) (SETCURSOR( IIF( P_CUR = 0, 0, IIF( READINSERT(), 3, 1 ) ) ))
//
// -> Funcao utilizada para preparar o texto do HELP
#define SOS(TEX_TO)  (SOS += TEX_TO + CHR(13) + CHR(10))
//
// -> Beep
#define BEEP()         TONE( 250, 4 )
//
// -> Constantes para utilizacao de teclas
#define T_ENTER         13
#define T_ESC           27
#define T_INSERT        22
#define T_CIMA           5
#define T_BAIXO         24
#define T_ESQUERDA      19
#define T_DIREITA        4
#define T_HOME           1
#define T_END            6
#define T_PGUP          18
#define T_PGDN           3
#define T_BACKSPACE      8
#define T_CTRL_W        23
#define T_F1            28
#define T_F2            -1
#define T_F3            -2
#define T_F4            -3
#define T_F5            -4
#define T_F6            -5
#define T_F7            -6
#define T_F10           -9
#define T_CTRL_PGDN     30
#define T_CTRL_PGUP     31
#define T_DEL            7
#define T_CTRL_HOME     29
#define T_CTRL_END      23
#define T_CTRL_ESQUERDA 26
#define T_CTRL_DIREITA   2
#define T_TAB            9
#define T_SH_TAB       271
//

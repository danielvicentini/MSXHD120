'### modelo de jogo (usando BASIC MSX como exemplo)
'### Desenvolvido para ser pré-processado (convertido para MSX BASIC) pelo inliner.
'### neste diretório arquivo de tarefa pronto para usar o in-liner do Visual Code
'### 
'### processar esta código com a tarefa "convert_to_msxbasic"
'
'Este jogo tem a estrutura basica de um jogo
'
'Ate o momento e' possivel comecar o jogo (espaco),
'movimentar o caracter com as setas e soltar 1 bomba com espaco.
'inimigo copia movimentos do objeto
'fase termina no final das vidas
' agosto 2018

variaveis:

        key off
        '######## esqueleto do jogo ########
        '##variaveis (viDAS, pONtoS, recORDE); e coordenadas
        'pt = pontos; rec = recorde; vi = vidas
        rec=5
        
        ' Objetos e copia em branco dos objetos (para apagar na tela)
        ' O$ = objeto; B$ = bomba; I$ = inimigo
        O$="_[])": for b=1 to len(O$): NO$=NO$+" ": next
        B$="===": for b=1 to len(B$): NB$=NB$+" ": next
        I$="(-)": for b=1 to len(I$): NI$=NI$+" ": next

        ' x,y coordenadas do objeto (px,py coordenada anterior)
        ' xb,yb coordenadas do tiro
        ' xi,yi coordenadas inimigo (sxi,syi coord anterior)
        ' si comprimento do inimigo (para fins de colisao)

inicio:
        ' manda para tela de apresentacao
        gosub {{tela_apresentacao}}

        pt=0: vi=3: x=10: y=10: xi=65:yi=10

        ' tela vidas apresenta vidas e continuar
        gosub {{tela_vidas}}

jogo:

        'inicio
        cls: 

        '##chama o looping de execucao enquanto game on
        interval on
        on interval=1 gosub {{looping}}
              
        fim_jogo:        
                '##fim: interrompe jogo, chama tela final e  depois volta pra tela principal
                '### aqui o caso para a condição de fim é v=0 (Vidas =0)
                if vi = 0 then gosub {{tela_final}} : goto {{inicio}} 
                
                goto {{fim_jogo}}
                
        
        end

looping:

        '##### SUB Looping em execucao #####
        '##movimenta tela ##
        gosub {{sub_tela}}
        
        ' detecta barra de espaço pressionada e chama rotina gatilho 
        b=strig(0): if b=-1 then gosub {{sub_gatilho}}  

        '##movimentos dos elementos##
        gosub {{sub_movimentos}}

        ' testa colisão
        gosub {{sub_colisao}}

        '##reproduz musica## TBD
        
        '##atualiza fase## TBD            
        
        '##atualiza variaveis##
        
        'recorde 
        if pt > rec then rec = pt

        ' condicao que desliga o looping, no caso vidas = 0
        if vi=0 then interval off

        return

        ' fim do codigo

tela_vidas:
        '##### SUB tela de vidas pré-jogo

        cls
        locate 2,2: print "Vidas: "; vi
        locate 2,4: print "Prepare-se. [SPC] para continuar"
        
        A$=inkey$: if a$ <> CHR$(32) then goto {{@}}

        cls:return

tela_final:
        '##### SUB Tela Final do jogo #####
        cls
        locate 20,10: print "Fim. Pontos: ";pt; "[SPC]";
        
        A$=inkey$: if a$ <> CHR$(32) then goto {{@}}
        
        return

tela_apresentacao:
        '##### SUB Monta a tela Inicial #####
        cls:color 15,1,1: width 80
        print "JOGO":print "2018 Daniel Vicentini":print: print "[SPC] para comecar"
        print:print "recorde :"; rec
        
        A$=inkey$: if a$ <> CHR$(32) then goto {{@}}
        
        return

sub_gatilho:        
        ' ##### SUB GATILHO #####
        ' executa acao apos pressionar gatilho, neste caso barra de espaco
             
        ' se tiro ja em movimento, nao faz nada, se não, inicia tiro e copia coordenada do objeto para o tiro
        
         if bo=0 then bo=1: xb=x+len(O$):yb=y
        
        return

sub_colisao:

        ' se bater no chao ou inimigo diminui 1 vida
        if y => 20 then {{colisao_nave}}
        
        ' tamanho final do inimigo que será realizado para referencia
        si = xi+len(I$)-1
        
        ' testa colisao do objeto com inimigo
        if y=yi then if  x => xi and x <= si then {{colisao_nave}}
        
        'testa colisao do tiro com inimigo
        if bo=1 and yb = yi then if xb=>xi and xb<=si then {{colisao_inimgo}}
        
        return

        colisao_inimgo:
        ' pontua e reinicia inimigo colocando no final da tela
        pt=pt +1: xi=80-len(I$): bo=0: locate xb-len(b$),yb:print NB$

        return

        colisao_nave:
        ' coloca objeto no inicio e inimigo no comeco da tela
        vi = vi -1: x=10: y=10: yi=syi:xi=80-len(I$)
        
        ' chama a tela de vidas restantes e prepara-se, caso ainda tenha
        if vi>0 then gosub {{tela_vidas}}

        return


sub_movimentos:

        '##### SUB movimentos do teclado #####
        'stick(0) devolve movimentos do teclado; strig(0) barra de espaço
        
        X$=inkey$: px=x: py=y: M=stick(0)

        'fator de velocidade da nave
        f=2

        ' movimentos cima/embaixo/esquerda direita/diagonais
        if M=7 then x=x-f else if M=3 then x=x+f else if M=1 then y=y-f else if M=5 then y=y+f 
        
        if M=2 then y=y-f:x=x+f else if M=4 then y=y+f:x=x+f else if M=6 then y=y+f:x=x-f else if M=8 then y=y-f:x=x-f

        ' ##limites da tela##
        if x<1 then x=2 else if x>76 then x=76

        if y<=3 then y=3 else if y>=20 then y=20

        ' encerra trajeto da boma caso atinja final da tela
        if xb=>77-len(B$) then bo=0: locate xb,yb:print NB$

        'movimenta coordenadas da bomba caso esteja na tela
        if bo=1 then xb=xb+len(b$)
        
        'coordenada anterior do inimigo
        sxi = xi: syi = yi

        ' limite do inimigo
        if xi <= 1 then xi=75:yi=y

        if yi < 2 then yi = 2
        
        if yi > 21 then yi  = 21

        ' movimenta inimigo para esquerda
        xi = xi - 1

        ' movimento inimigo na altura do objeto
        if y > yi then yi=yi+1 else if y < yi then yi=yi-1

        return

sub_inimigo:

        'TBC        

sub_tela:
        '##### SUB apresentacao da tela do jogo
        locate 1,1: print "Jogo em Execucao"
        locate 18,1: print "Pontos: ";pt
        locate 40,1: print "Vidas :";vi
        locate 60,1: print "Recorde: "; rec
        
        ' tela
        ' roda (no futuro) o plano da tela, hj e' so' uma linha
        for b=0 to 79 step 10: locate b,20: print "##########": next

        'imprime inimigo e na coord anterior remove impressão
         locate sxi,syi:print NI$: locate xi,yi:print I$

        'imprime na tela objeto e na coordenada anterior remove impressão
        if x<>px or y<>py then locate px,py: print NO$: locate x,y: print O$

        'imprime tiro e na coord anterior remove impressao
        if bo=1 then locate xb,yb: print B$: locate xb-(len(b$)),yb: print NB$

        return

1000 key off:rec=5
1010 O$="_[])": for b=1 to len(O$): NO$=NO$+" ": next:B$="===": for b=1 to len(B$): NB$=NB$+" ": next:I$="(-)": for b=1 to len(I$): NI$=NI$+" ": next
1020 gosub 1220
1030 pt=0: vi=3: x=10: y=10: xi=65:yi=10
1040 gosub 1160
1050 interval on:on interval=1 gosub 1090
1060 if vi = 0 then gosub 1190 : goto 1020
1070 goto 1060
1080 end
1090 gosub 1520
1100 b=strig(0): if b=-1 then gosub 1250
1110 gosub 1370
1120 gosub 1270
1130 if pt > rec then rec = pt
1140 if vi=0 then interval off
1150 return
1160 cls:locate 2,2: print "Vidas: "; vi:locate 2,4: print "Prepare-se. [SPC] para continuar"
1170 A$=inkey$: if a$ <> CHR$(32) then goto 1170
1180 cls:return
1190 cls:locate 20,10: print "Fim. Pontos: ";pt; "[SPC]";
1200 A$=inkey$: if a$ <> CHR$(32) then goto 1200
1210 return
1220 cls:color 15,1,1: width 80:print "JOGO":print "2018 Daniel Vicentini":print: print "[SPC] para comecar":print:print "recorde :"; rec
1230 A$=inkey$: if a$ <> CHR$(32) then goto 1230
1240 return
1250 if bo=0 then bo=1: xb=x+len(O$):yb=y
1260 return
1270 if y => 20 then 1340
1280 si = xi+len(I$)-1
1290 if y=yi then if  x => xi and x <= si then 1340
1300 if bo=1 and yb = yi then if xb=>xi and xb<=si then 1320
1310 return
1320 pt=pt +1: xi=80-len(I$): bo=0: locate xb-len(b$),yb:print NB$
1330 return
1340 vi = vi -1: x=10: y=10: yi=syi:xi=80-len(I$)
1350 if vi>0 then gosub 1160
1360 return
1370 X$=inkey$: px=x: py=y: M=stick(0)
1380 f=2
1390 if M=7 then x=x-f else if M=3 then x=x+f else if M=1 then y=y-f else if M=5 then y=y+f
1400 if M=2 then y=y-f:x=x+f else if M=4 then y=y+f:x=x+f else if M=6 then y=y+f:x=x-f else if M=8 then y=y-f:x=x-f
1410 if x<1 then x=2 else if x>76 then x=76
1420 if y<=3 then y=3 else if y>=20 then y=20
1430 if xb=>77-len(B$) then bo=0: locate xb,yb:print NB$
1440 if bo=1 then xb=xb+len(b$)
1450 sxi = xi: syi = yi
1460 if xi <= 1 then xi=75:yi=y
1470 if yi < 2 then yi = 2
1480 if yi > 21 then yi  = 21
1490 xi = xi - 1
1500 if y > yi then yi=yi+1 else if y < yi then yi=yi-1
1510 return
1520 locate 1,1: print "Jogo em Execucao":locate 18,1: print "Pontos: ";pt:locate 40,1: print "Vidas :";vi:locate 60,1: print "Recorde: "; rec
1530 for b=0 to 79 step 10: locate b,20: print "##########": next
1540 locate sxi,syi:print NI$: locate xi,yi:print I$
1550 if x<>px or y<>py then locate px,py: print NO$: locate x,y: print O$
1560 if bo=1 then locate xb,yb: print B$: locate xb-(len(b$)),yb: print NB$
1570 return

SetBatchLines -1  
;----------------���α׷� ����ȭ��(�����̹���)------------------------
Coordmode, pixel, Screen  ;Screen(��üȭ��), Relative(�����), Window(����â), Client(���� �۾� ����)
;������ â Ȱ��ȭ
WinWait, ������,
IfWinNotActive, ������, , WinActivate, ������,
WinWaitActive, ������,
;������ ����â����
Gui,2:+Resize 
Gui,2:Margin,1,1 
Gui,2:Color,,silver 
Gui,2:add,edit,w%A_ScreenWidth% h%A_ScreenHeight% -VScroll 
Gui,2:Show, w500 h120,ȭ��ǥ �̹�����ġ����    ;â����
WinSet,TransColor,silver,ȭ��ǥ �̹�����ġ����
;������ ����ȭ��
Gui,Show, x131 y91 h381 w403, ����-FreestyleJam(16.08.24)[����F1/�ߴ�F2����F3]
Gui,Add, Button, x236 y5 w80 h20 , �����ϱ�
Gui,Add, Button, x318 y5 w80 h20 , ���ִٿ�
Gui,Add, Picture, x0 y0 w403 h381 , %A_ScriptDir%\����ȭ��.bmp
return
Button���ִٿ�:
Run, www.autohotkey.com/
Button�����ϱ�:
Run, http://cafe.naver.com/mabinogidsg/308330
return
GuiClose:
ExitApp
;----------------F1Ű�������� �����Ѵ�--------------------------------
F1::
Loop, {
;-------------- ȭ��ǥ �̹�����ġâ�� Ȱ��ȭ�Ѵ�------------
WinWait, ȭ��ǥ �̹�����ġ����
IfWinNotActive, ȭ��ǥ �̹�����ġ����, , WinActivate, ȭ��ǥ �̹�����ġ����,
WinWaitActive, ȭ��ǥ �̹�����ġ����
;--------------����â�� ��ǥ���� ���´�-------------------
WinGetPos,x,y,w,h,A ; A�� ���� Ȱ��ȭ�� â����ǥ�� ���´�
SysGet,wFrame,32 ; ���� �ý����� Border�� (â �׵θ� �β�)
SysGet,wCaption,4 ; ���� �ý����� Caption�� (���� ǥ���� ����)
Xpos:=x+wFrame                 ;��ġ�ҿ���ó����ǥx,y 
Ypos:=y+wFrame+wCaption
Width:=w-wFrame*2              ;â����, ����
Height:=h-wCaption-wFrame*2
Xpos_end := Xpos + Width       ;��ġ������������ǥx,y
Ypos_end := Ypos + Height
;--------------������ â Ȱ��ȭ----------------------
WinWait, ������,
IfWinNotActive, ������, , WinActivate, ������,
WinWaitActive, ������,
var_check_initeFindKey = 0  ;��ó�� Ű�� ã�Ҵ��� ����, �ʱ�ȭ
;----------------------����â ���� ȭ��ǥ��ġ & �� & �Է·���-------------------------------------------------------
;ASDW �˻��� D�˻����¿��� ȭ��ǥ�� ǥ�õǸ� ���� ASȭ��ǥ��ǥ�� ��ġ ���Ѵ� �����ǿ���
;��ȭ��ǥ�� �߰��ϸ� ASDW ���������� �� Ž�� (ùȸ��)
Loop, {
var_check_findeKey = 0    ;Ű��ã�Ҵ��� ����, �ʱ�ȭ
ImageSearch, vxA, vyA, Xpos, Ypos, Xpos_end, Ypos_end, *40 %A_ScriptDir%\A_����.bmp
if errorlevel = 0
{	
	if var_check_initeFindKey = 0  ;ó������ Ű�� ã�Ҵٸ�
	{
		Ypos := vyA                ;��ġ������ ������
		Ypos_end := vyA + 1 
		var_check_initeFindKey = 1	
		continue                   ;��ġ����ó������ ���ư��� A������Ž���Ѵ�
	}
	Ypos := vyA
	Ypos_end := vyA + 1 
	var_check_findeKey = 1
}
if errorlevel = 1
{
	vxA := Xpos+Width
}
ImageSearch, vxS, vyS, Xpos, Ypos, Xpos_end, Ypos_end, *40 %A_ScriptDir%\S_����.bmp
if errorlevel = 0
{
	if var_check_initeFindKey = 0  
	{
		Ypos := vyS
		Ypos_end := vyS + 1 
		var_check_initeFindKey = 1	
		continue                  
	}
	Ypos := vyS
	Ypos_end := vyS + 1 
	var_check_findeKey = 1
}
if errorlevel = 1
{
	vxS := Xpos+Width
}
ImageSearch, vxD, vyD, Xpos, Ypos, Xpos_end, Ypos_end, *40 %A_ScriptDir%\D_����.bmp
if errorlevel = 0          
{
	if var_check_initeFindKey = 0  
	{
		Ypos := vyD
		Ypos_end := vyD + 1 
		var_check_initeFindKey = 1	
		continue                  
	}
	Ypos := vyD
	Ypos_end := vyD + 1 
	var_check_findeKey = 1
}
if errorlevel = 1
{
	vxD := Xpos+Width
}
ImageSearch, vxW, vyW, Xpos, Ypos, Xpos_end, Ypos_end, *40 %A_ScriptDir%\W_����.bmp
if errorlevel = 0
{
	if var_check_initeFindKey = 0  
	{
		Ypos := vyW
		Ypos_end := vyW + 1 
		var_check_initeFindKey = 1	
		continue                  
	}
	Ypos := vyW
	Ypos_end := vyW + 1 
	var_check_findeKey = 1
}
if errorlevel = 1
{
	vxW := Xpos+Width
}
;---------ȭ��ǥ�� ã�Ҵٸ� ------------------------
if var_check_findeKey = 1 	;msgbox, a%vxA%, s%vxS%, d%vxD%, w%vxW%
{	
	;-------------ȭ��ǥ��--------------------------------	  
	if (vxA < vxS)
	{
		if (vxA < vxD)
		{
			if (vxA < vxW)
			{
				send, {a}	
				Xpos := vxA
				Xpos := Xpos + 25
			}
		}
	}
	if (vxS < vxA)
	{
		if (vxS < vxD)
		{
			if (vxS < vxW)
			{
				send, {s}
				Xpos := vxS
				Xpos := Xpos + 25
			}
		}
	}
	if (vxD < vxA)
	{
		if (vxD < vxS)
		{
			if (vxD < vxW)
			{
				send, {d}
				Xpos := vxD
				Xpos := Xpos + 25
			}
		}
	}
	if (vxW < vxA)
	{
		if (vxW < vxS)
		{
			if (vxW < vxD)
			{
				send {w}
				Xpos := vxW
				Xpos := Xpos + 25
			}
		}
	}
}
if var_check_findeKey = 0 ;��ã���� ������ 
{
	send, {f1}  ;������Ÿ���� Ŭ��
	break       ;��ó�������ΰ��� (ȭ��ǥ����â Ȱ��ȭ>��ǥ���>Ű��ġ)
}
}
}
Return
F2::Pause
F3::Exitapp
return


SetBatchLines -1  
;----------------프로그램 시작화면(설명이미지)------------------------
Coordmode, pixel, Screen  ;Screen(전체화면), Relative(상대적), Window(윈도창), Client(실제 작업 영역)
;마비노기 창 활성화
WinWait, 마비노기,
IfWinNotActive, 마비노기, , WinActivate, 마비노기,
WinWaitActive, 마비노기,
;윈도우 투명창생성
Gui,2:+Resize 
Gui,2:Margin,1,1 
Gui,2:Color,,silver 
Gui,2:add,edit,w%A_ScreenWidth% h%A_ScreenHeight% -VScroll 
Gui,2:Show, w500 h120,화살표 이미지서치영역    ;창생성
WinSet,TransColor,silver,화살표 이미지서치영역
;윈도우 시작화면
Gui,Show, x131 y91 h381 w403, 평판-FreestyleJam(16.08.24)[시작F1/중단F2종료F3]
Gui,Add, Button, x236 y5 w80 h20 , 문의하기
Gui,Add, Button, x318 y5 w80 h20 , 오핫다운
Gui,Add, Picture, x0 y0 w403 h381 , %A_ScriptDir%\시작화면.bmp
return
Button오핫다운:
Run, www.autohotkey.com/
Button문의하기:
Run, http://cafe.naver.com/mabinogidsg/308330
return
GuiClose:
ExitApp
;----------------F1키를누르면 시작한다--------------------------------
F1::
Loop, {
;-------------- 화살표 이미지서치창을 활성화한다------------
WinWait, 화살표 이미지서치영역
IfWinNotActive, 화살표 이미지서치영역, , WinActivate, 화살표 이미지서치영역,
WinWaitActive, 화살표 이미지서치영역
;--------------투명창의 좌표값을 얻어온다-------------------
WinGetPos,x,y,w,h,A ; A는 현재 활성화된 창의좌표를 얻어온다
SysGet,wFrame,32 ; 현재 시스템의 Border값 (창 테두리 두께)
SysGet,wCaption,4 ; 현재 시스템의 Caption값 (제목 표시줄 높이)
Xpos:=x+wFrame                 ;서치할영역처음좌표x,y 
Ypos:=y+wFrame+wCaption
Width:=w-wFrame*2              ;창의폭, 높이
Height:=h-wCaption-wFrame*2
Xpos_end := Xpos + Width       ;서치영역마지막좌표x,y
Ypos_end := Ypos + Height
;--------------마비노기 창 활성화----------------------
WinWait, 마비노기,
IfWinNotActive, 마비노기, , WinActivate, 마비노기,
WinWaitActive, 마비노기,
var_check_initeFindKey = 0  ;맨처음 키를 찾았는지 변수, 초기화
;----------------------투명창 영역 화살표서치 & 비교 & 입력루프-------------------------------------------------------
;ASDW 검색중 D검색상태에서 화살표가 표시되면 이전 AS화살표좌표를 서치 못한다 실패의원인
;즉화살표를 발견하면 ASDW 순차적으로 재 탐색 (첫회만)
Loop, {
var_check_findeKey = 0    ;키를찾았는지 변수, 초기화
ImageSearch, vxA, vyA, Xpos, Ypos, Xpos_end, Ypos_end, *40 %A_ScriptDir%\A_수정.bmp
if errorlevel = 0
{	
	if var_check_initeFindKey = 0  ;처음으로 키를 찾았다면
	{
		Ypos := vyA                ;서치범위를 좁히고
		Ypos_end := vyA + 1 
		var_check_initeFindKey = 1	
		continue                   ;서치루프처음으로 돌아가서 A부터재탐색한다
	}
	Ypos := vyA
	Ypos_end := vyA + 1 
	var_check_findeKey = 1
}
if errorlevel = 1
{
	vxA := Xpos+Width
}
ImageSearch, vxS, vyS, Xpos, Ypos, Xpos_end, Ypos_end, *40 %A_ScriptDir%\S_수정.bmp
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
ImageSearch, vxD, vyD, Xpos, Ypos, Xpos_end, Ypos_end, *40 %A_ScriptDir%\D_수정.bmp
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
ImageSearch, vxW, vyW, Xpos, Ypos, Xpos_end, Ypos_end, *40 %A_ScriptDir%\W_수정.bmp
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
;---------화살표를 찾았다면 ------------------------
if var_check_findeKey = 1 	;msgbox, a%vxA%, s%vxS%, d%vxD%, w%vxW%
{	
	;-------------화살표비교--------------------------------	  
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
if var_check_findeKey = 0 ;못찾으면 나가기 
{
	send, {f1}  ;프리스타일잼 클릭
	break       ;맨처음루프로간다 (화살표영역창 활성화>좌표얻기>키서치)
}
}
}
Return
F2::Pause
F3::Exitapp
return


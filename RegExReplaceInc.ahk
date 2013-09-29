/*
Function       : RegExReplaceInc() v3
Author         : hi5
Doc + Examples : https://github.com/hi5/RegExReplaceInc/
AHK Forum      : http://www.autohotkey.com/forum/topic68648.html
AutoHotkey     : Basic 1.0.48.05, AutoHotkey_L 1.0.X series
Purpose        : Function to add incremental numbers or strings to your replacement text during a RegExReplace

*/

RegExReplaceInc(Haystack,NeedleRegEx,Replace,Start=1,Increment=1)
   {
	Pos=1
	If Start is number		; check for number or text
	   Inc:=Start
	Else					; it is text, set values
	   {
	StringSplit, Repl, Start, % (Increment=1 ? "|" : Increment) ; %
		Inc:=Repl1
		Increment:=1
	   }   
	While Pos:=RegExMatch(Haystack,NeedleRegEx,A,Pos+StrLen(A)) 
	  {
	   If (InStr(Replace,"$i") > 0)
			StringReplace,Repl,Replace,$i,%Inc%,All
	   Else
			Repl := Replace . Inc
	   Haystack:=RegExReplace(Haystack,NeedleRegEx,Repl,A,1,Pos)
	   If Repl0				; 'text' mode
		{
		  If (Increment + 1 > Repl0)
			 Increment:=0	; reset back to 1
		  Increment++
			 Inc:=Repl%Increment%
		}
	   Else	; 'number' mode
		Inc+=Increment
	  }
    Return Haystack
   }
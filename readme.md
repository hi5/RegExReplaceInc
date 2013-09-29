# RegExReplaceInc() - v3.0

**Introduction**

This function is inspired on the \i option from the "Find and Replace" of text editor TextPad.
It allows you to add incremental numbers to your replacement text making it easier to create
unique identifiers or labels. For example numbered anchor targets in a html file:
name="anchor1", name="anchor2", name="anchor3" etc.

It also supports string incrementation where you can give a string as Start parameter
and a delimiter for the increment parameter (Thanks to Frankie for suggesting string
incrementation)

### Parameters

**RegExReplaceInc(Haystack,NeedleRegEx,Replace[,Start=1,[Increment=1]])**

|Parameter   |Description|
|------------|-----------|
|Haystack    | The string whose content is searched and replaced.|
|NeedleRegEx | The pattern to search for, which is a Perl-compatible regular expression (PCRE).|
|Replace     | The string to be substituted for each match, which is plain text, it may include backreferences like $1 as with [RegExReplace()](http://www.autohotkey.com/docs/commands/RegExReplace.htm "AutoHotkey's RegExReplace documentation"). Use the $i parameter to specify the desired location of the incremental value/text to be inserted. You can use $i multiple times.|
|Start       | Start value (number) or delimited string. |
|Increment   | Number to increment or decrement or the delimiter character in case of a delimited string, a &#124; is used by default.|

**The $i parameter explained**

By using the **$i** parameter in the replacement string you can specify the desired 
location of the incremental value/text to be inserted. You can use $i multiple times
in the Replacement text.

|Replace         | Effect    |
|----------------|-----------|
|"$i"            | Replace needle with incremental value.|
|"$i $1"         | Insert incremental value before backreference 1.|
|"$3$i $2$1"     | Insert incremental value after backreference 3.|
|"$i newtext $i  | Replace needle with incremental value at two locations, the same value will be used for each instance (1 newtext 1).|

**Examples of Start/Increment**

The default value of start & increment is 1 (one), so it uses numbers starting from 1, incrementing by 1 in the replacement.

|Start  |Increment|Effect|
|-------|---------|------|
|(empty)|(empty)  | Replace with numbers starting from 1, incrementing by 1.|
|10     |(empty)  | Replace with numbers starting from 10, incrementing by 1.|
|0      |10       | Replace with numbers starting from 0, incrementing by 10.|     
|100    |-10      | Replace with numbers starting from 100, decrementing by -10.|
|"Cricket&#124;Base&#124;Basket&#124;Foot" |(empty) | Replace with words, starting with Cricket. A &#124; (pipe character) is used as the default delimiter. If there are more replacements after the last word in the list (Foot), it starts with the first word (Cricket) again until all replacements are made.|
|"Ball,Disc,Net,Racquet" |"," | Replace with words, starting with Ball. A comma (,) is used as the delimiter.|

## Code Examples


**Example 1**

   ```autohotkey
   #include RegExReplaceInc.ahk ; Not required if you place RegExReplaceInc.ahk in your library
   Haystack=AutoHotkey is a free, open-source utility for Windows.
   MsgBox % RegExReplaceInc(Haystack,"e","")

   ; Result: AutoHotk1y is a fr23, op4n-sourc5 utility for Windows.
   ```

**Example 2**

   ```autohotkey
   #include RegExReplaceInc.ahk ; Not required if you place RegExReplaceInc.ahk in your library
   Haystack=
   (
   This a series of letters and numbers: A213, B356, Z1827,
   we want to change the numbers independent of the letters, 
   which are to be preserved, and swap the numbers and letters
   )
   MsgBox % RegExReplaceInc(Haystack,"([A-Z])[1-9][0-9][0-9]+","$i$1",300,33) ; start at 300 increment by 33

   ; Result: This a series of letters and numbers: 300A, 333B, 366Z, ....
   ```

**Example 3**

   ```autohotkey
   #include RegExReplaceInc.ahk ; Not required if you place RegExReplaceInc.ahk in your library
   Haystack=
   (
   <a href='/submenu/@@'>@@</a>
   <a href='/submenu/@@'>@@</a>
   <a href='/submenu/@@'>@@</a>
   <a href='/submenu/@@'>@@</a>
   )
   MsgBox % RegExReplaceInc(Haystack,"(@@'>@@)","$i.html'>$i","Cricket|Base|Basket|Foot")

   ; Result:
   ; <a href='/submenu/Cricket.html'>Cricket</a>
   ; <a href='/submenu/Base.html'>Base</a>
   ; <a href='/submenu/Basket.html'>Basket</a>
   ; <a href='/submenu/Foot.html'>Foot</a>
   ```

**Example 4**

   ```autohotkey
   #include RegExReplaceInc.ahk ; Not required if you place RegExReplaceInc.ahk in your library
   Haystack=
   (
   AutoHotkey is a free, open-source utility for Windows. With it, you can:
   - Automate almost anything by sending keystrokes and mouse clicks.
   - Create hotkeys for keyboard, joystick, and mouse. Virtually any key, button, or combination can become a hotkey.
   - Expand abbreviations as you type them. For example, typing "btw" can automatically produce "by the way".
   - Create custom data-entry forms, user interfaces, and menu bars. See GUI for details.
   - Remap keys and buttons on your keyboard, joystick, and mouse.
   - Respond to signals from hand-held remote controls via the WinLIRC client script.
   - Convert any script into an EXE file that can be run on computers that don't have AutoHotkey installed.
   )
   MsgBox % RegExReplaceInc(Haystack," key([a-z]*)"," [$i]key$1[/$i]")
   
   ; Result:
   ; AutoHotkey is a free, open-source utility for Windows. With it, you can:
   ; - Automate almost anything by sending [1]keystrokes[/1] and mouse clicks.
   ; - Create hotkeys for [2]keyboard[/2], joystick, and mouse. Virtually any [3]key[/3], .....
   ```

Source: <https://github.com/hi5/RegExReplaceInc/>
	
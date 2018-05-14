%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Ian Yuan
%Date:    June 2013
%Course:  ICS3CU1
%Teacher:  M. Ianni
%Program Name: Rubik's Cube
%Descriptions:  Final Program Name Here and a brief description of the game
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% main procedure to handle the Instruction Window
procedure displayInstructionWindow

    % flag that instruction screen is open - global var isIntroWindowOpen
    isInstructionWindowOpen := true
    % Open the window
    var winID : int
    winID := Window.Open ("position:top;center,graphics:600;400,title:Instructions Window")

    % create a button
    var quitisInstructionWindowButton := GUI.CreateButton (maxx - 100, 25, 0, "Close", QuitInstructionWindowButtonPressed)

    % file input code for instructions here
    var textfile : string := "Files/Text/Instructions.txt"
    var sWord : string
    var stream : int
    open : stream, textfile, get
    loop
	exit when eof (stream)
	get : stream, sWord : *
	put sWord
    end loop
    close : stream

    % Window will continue until quit button is pressed
    loop
	exit when GUI.ProcessEvent or isInstructionWindowOpen = false
    end loop
    % release the button
    GUI.Dispose (quitisInstructionWindowButton)
    %close/release the window
    Window.Close (winID)

end displayInstructionWindow

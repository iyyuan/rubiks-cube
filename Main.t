%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Ian Yuan
%Date:    June 2013
%Course:  ICS3CU1
%Teacher:  M. Ianni
%Program Name: Rubik's Cube
%Descriptions:  Rubik's Cube

%The cube is a 3x3x3 cube, and is a 3-D combination puzzle.
%In its solved state, the cube has 6 sides, each with a different color and each side with 9 squares.
%By rotating the cube sides various times, the cube is no longer solved.
%The objective is to solve the cube by having only 1 color on each side.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% files/code folder
include "files/code/includes.t"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% procedure to set all initial global variable with file scope
% even if already set (located in MyGlobalVars.t)
setInitialGameValues
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  ********  M A I N   P R O G R A M   S T E P S ********
% *********************   Main Variable Declarations Here
var winID : int
winID := Window.Open ("position:top;center,graphics:700;700,title:Rubik's Cube")
setscreen ("nobuttonbar,graphics:700;700,offscreenonly")

% ***************************************   Major Block A

% Display the introduction screen
loop
    displayIntroWindow (instructionsClicked, startClicked, quitClicked)
    if instructionsClicked = true then
	% Display the instructions window
	displayInstructionWindow
    end if
    if quitClicked = true then
	%Program ends, window closes
	exit
    end if
    if startClicked = true then
	%Starts the game
	exit
    end if
end loop


% ***************************************   Major Block B

if quitClicked = false then
    %Checks if the quit button was not pressed
    %If it was not clicked, then the display is drawn
    %The array is initialize
    %A process that displays the solved status in the bottom-left hand corner begins to run
    %Calls the getMouse procedure, which determines if any buttons were pressed, and if so, what procedure to call to update the cube

    drawBackground
    initializeCube
    fork solvedTrueOrFalse
    getMouse

end if

% *********** E N D     O F    P R O G R A M  ************

endGame
%Draws the end screen
View.Update
%waits 5 seconds before automatically closing the game window
delay (5000)
Window.Close (winID)



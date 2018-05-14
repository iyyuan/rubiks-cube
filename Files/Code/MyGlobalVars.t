%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Ian Yuan
%Date:    June 2013
%Course:  ICS3CU1
%Teacher:  D. Gillespie or M. Ianni
%Program Name: Rubik's Cube
%Descriptions:  Final Program Name Here and a brief description of the game
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% MyGlobalVars.t
% All global variables are coded in this file.
% These will have FILE scope.
% These must be document thoroughly - Descriptive name,
%   where used and for what purpose

var isIntroWindowOpen : boolean % Flag for Introduction Window state open or closed
var isFontWindowOpen : boolean
var isInstructionWindowOpen : boolean % Determines if the instruction window is open
var instructionsClicked : boolean % Determines if the user clicked the instructions button
var startClicked : boolean % Determines if the user started the game
var quitClicked : boolean % Determines if the user quit the game in the intro screen
var quitGame : boolean % Determines if the user wishes to quit during the actual game
var font1 := Font.New ("Arial:20")
var backgroundColor := Pic.FileNew ("Images/BackgroundColor.jpg")
const colors : array 1 .. 6 of int := init (red, yellow, 42, white, blue, green) %red,yellow,orange,white,blue,green
type Sides :
    record
	side : array 1 .. 3, 1 .. 3 of int
    end record
var rubiksArray : array 1 .. 6 of Sides

proc setInitialGameValues

    isIntroWindowOpen := false
    isFontWindowOpen := false
    isInstructionWindowOpen := false
    instructionsClicked := false
    startClicked := false
    quitClicked := false
    quitGame := false

end setInitialGameValues

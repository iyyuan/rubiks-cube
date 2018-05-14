%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Ian Yuan
%Date:    June 2013
%Course:  ICS3CU1
%Teacher:  M. Ianni
%Program Name: Rubik's Cube
%Descriptions:  Final Program Name Here and a brief description of the game
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%procedures to rotate the positions

procedure initializeCube
    %Initialize the array so that each side is solely one color and the cube is
    %in its solved state
    for a : 1 .. 6
	for b : 1 .. 3
	    for c : 1 .. 3
		rubiksArray (a).side (b, c) := colors (a)
	    end for
	end for
    end for
end initializeCube

procedure loadGame
    %Opens up the textfile with the name "Save.txt"
    %Loads the primary array with values entered from the textfile
    var textfile : string := "Files/Text/Save.txt"
    var stream : int
    var sWord : string
    var face, row, column : int
    face := 1
    row := 1
    column := 1
    open : stream, textfile, get
    loop
	exit when eof (stream)
	get : stream, sWord
	rubiksArray (face).side (row, column) := strint (sWord)
	column += 1
	if column > 3 then
	    column := 1
	    row += 1
	end if
	if row > 3 then
	    row := 1
	    face += 1
	end if
	exit when face > 6
    end loop
    close : stream
end loadGame

procedure saveGame
    %Saves current game
    %Only 1 save file is stored at a time
    var textfile : string := "Files/Text/Save.txt"
    var stream : int
    open : stream, textfile, put
    for a : 1 .. 6
	for b : 1 .. 3
	    for c : 1 .. 3
		put : stream, intstr (rubiksArray (a).side (b, c))
	    end for
	end for
    end for
    close : stream
end saveGame

procedure rotate (c : int, clockwise : boolean)
    % c is the side number
    % clockwise determines whether or not to rotate the side clockwise or counterclockwise
    var extra1 : int := rubiksArray (c).side (1, 1)
    var extra2 : int := rubiksArray (c).side (1, 2)
    if clockwise = true then %Rotate the side face clockwise
	rubiksArray (c).side (1, 1) := rubiksArray (c).side (3, 1)
	rubiksArray (c).side (3, 1) := rubiksArray (c).side (3, 3)
	rubiksArray (c).side (3, 3) := rubiksArray (c).side (1, 3)
	rubiksArray (c).side (1, 3) := extra1
	rubiksArray (c).side (1, 2) := rubiksArray (c).side (2, 1)
	rubiksArray (c).side (2, 1) := rubiksArray (c).side (3, 2)
	rubiksArray (c).side (3, 2) := rubiksArray (c).side (2, 3)
	rubiksArray (c).side (2, 3) := extra2
    else %Rotate the side face counterclockwise
	rubiksArray (c).side (1, 1) := rubiksArray (c).side (1, 3)
	rubiksArray (c).side (1, 3) := rubiksArray (c).side (3, 3)
	rubiksArray (c).side (3, 3) := rubiksArray (c).side (3, 1)
	rubiksArray (c).side (3, 1) := extra1
	rubiksArray (c).side (1, 2) := rubiksArray (c).side (2, 3)
	rubiksArray (c).side (2, 3) := rubiksArray (c).side (3, 2)
	rubiksArray (c).side (3, 2) := rubiksArray (c).side (2, 1)
	rubiksArray (c).side (2, 1) := extra2
    end if
end rotate

procedure frontRotate (c : int, clockwise : boolean)
    var extra : array 1 .. 3 of int
    rotate (c, clockwise) %rotates the front side and adjacent squares
    if clockwise = false then %rotates counterclockwise
	extra (1) := rubiksArray (5).side (1, 3)
	extra (2) := rubiksArray (5).side (2, 3)
	extra (3) := rubiksArray (5).side (3, 3)
	rubiksArray (5).side (1, 3) := rubiksArray (2).side (3, 3)
	rubiksArray (5).side (2, 3) := rubiksArray (2).side (3, 2)
	rubiksArray (5).side (3, 3) := rubiksArray (2).side (3, 1)
	rubiksArray (2).side (3, 1) := rubiksArray (6).side (1, 1)
	rubiksArray (2).side (3, 2) := rubiksArray (6).side (2, 1)
	rubiksArray (2).side (3, 3) := rubiksArray (6).side (3, 1)
	rubiksArray (6).side (1, 1) := rubiksArray (4).side (1, 3)
	rubiksArray (6).side (2, 1) := rubiksArray (4).side (1, 2)
	rubiksArray (6).side (3, 1) := rubiksArray (4).side (1, 1)
	rubiksArray (4).side (1, 1) := extra (1)
	rubiksArray (4).side (1, 2) := extra (2)
	rubiksArray (4).side (1, 3) := extra (3)
    else %rotates front clockwise
	extra (1) := rubiksArray (5).side (1, 3)
	extra (2) := rubiksArray (5).side (2, 3)
	extra (3) := rubiksArray (5).side (3, 3)
	rubiksArray (5).side (1, 3) := rubiksArray (4).side (1, 1)
	rubiksArray (5).side (2, 3) := rubiksArray (4).side (1, 2)
	rubiksArray (5).side (3, 3) := rubiksArray (4).side (1, 3)
	rubiksArray (4).side (1, 1) := rubiksArray (6).side (3, 1)
	rubiksArray (4).side (1, 2) := rubiksArray (6).side (2, 1)
	rubiksArray (4).side (1, 3) := rubiksArray (6).side (1, 1)
	rubiksArray (6).side (1, 1) := rubiksArray (2).side (3, 1)
	rubiksArray (6).side (2, 1) := rubiksArray (2).side (3, 2)
	rubiksArray (6).side (3, 1) := rubiksArray (2).side (3, 3)
	rubiksArray (2).side (3, 1) := extra (3)
	rubiksArray (2).side (3, 2) := extra (2)
	rubiksArray (2).side (3, 3) := extra (1)
    end if
end frontRotate

procedure slide (c : int)
    var extra : array 1 .. 3 of int
    case c of
	label 1 :     %Rotate Front-Right-Up
	    extra (1) := rubiksArray (1).side (1, 3)
	    extra (2) := rubiksArray (1).side (2, 3)
	    extra (3) := rubiksArray (1).side (3, 3)
	    rubiksArray (1).side (1, 3) := rubiksArray (4).side (1, 3)
	    rubiksArray (1).side (2, 3) := rubiksArray (4).side (2, 3)
	    rubiksArray (1).side (3, 3) := rubiksArray (4).side (3, 3)
	    rubiksArray (4).side (1, 3) := rubiksArray (3).side (3, 3)
	    rubiksArray (4).side (2, 3) := rubiksArray (3).side (2, 3)
	    rubiksArray (4).side (3, 3) := rubiksArray (3).side (1, 3)
	    rubiksArray (3).side (1, 3) := rubiksArray (2).side (3, 3)
	    rubiksArray (3).side (2, 3) := rubiksArray (2).side (2, 3)
	    rubiksArray (3).side (3, 3) := rubiksArray (2).side (1, 3)
	    rubiksArray (2).side (1, 3) := extra (1)
	    rubiksArray (2).side (2, 3) := extra (2)
	    rubiksArray (2).side (3, 3) := extra (3)
	    rotate (6, true)
	label 2 :     %Rotate Front-Left-Up
	    extra (1) := rubiksArray (1).side (1, 1)
	    extra (2) := rubiksArray (1).side (2, 1)
	    extra (3) := rubiksArray (1).side (3, 1)
	    rubiksArray (1).side (1, 1) := rubiksArray (4).side (1, 1)
	    rubiksArray (1).side (2, 1) := rubiksArray (4).side (2, 1)
	    rubiksArray (1).side (3, 1) := rubiksArray (4).side (3, 1)
	    rubiksArray (4).side (1, 1) := rubiksArray (3).side (3, 1)
	    rubiksArray (4).side (2, 1) := rubiksArray (3).side (2, 1)
	    rubiksArray (4).side (3, 1) := rubiksArray (3).side (1, 1)
	    rubiksArray (3).side (1, 1) := rubiksArray (2).side (3, 1)
	    rubiksArray (3).side (2, 1) := rubiksArray (2).side (2, 1)
	    rubiksArray (3).side (3, 1) := rubiksArray (2).side (1, 1)
	    rubiksArray (2).side (1, 1) := extra (1)
	    rubiksArray (2).side (2, 1) := extra (2)
	    rubiksArray (2).side (3, 1) := extra (3)
	    rotate (5, false)
	label 3 :     %Rotate Front-Top-Right
	    extra (1) := rubiksArray (1).side (1, 1)
	    extra (2) := rubiksArray (1).side (1, 2)
	    extra (3) := rubiksArray (1).side (1, 3)
	    rubiksArray (1).side (1, 1) := rubiksArray (5).side (1, 1)
	    rubiksArray (1).side (1, 2) := rubiksArray (5).side (1, 2)
	    rubiksArray (1).side (1, 3) := rubiksArray (5).side (1, 3)
	    rubiksArray (5).side (1, 1) := rubiksArray (3).side (1, 3)
	    rubiksArray (5).side (1, 2) := rubiksArray (3).side (1, 2)
	    rubiksArray (5).side (1, 3) := rubiksArray (3).side (1, 1)
	    rubiksArray (3).side (1, 1) := rubiksArray (6).side (1, 3)
	    rubiksArray (3).side (1, 2) := rubiksArray (6).side (1, 2)
	    rubiksArray (3).side (1, 3) := rubiksArray (6).side (1, 1)
	    rubiksArray (6).side (1, 1) := extra (1)
	    rubiksArray (6).side (1, 2) := extra (2)
	    rubiksArray (6).side (1, 3) := extra (3)
	    rotate (2, false)
	label 4 :     %Rotate Front-Bottom-Right
	    extra (1) := rubiksArray (1).side (3, 1)
	    extra (2) := rubiksArray (1).side (3, 2)
	    extra (3) := rubiksArray (1).side (3, 3)
	    rubiksArray (1).side (3, 1) := rubiksArray (5).side (3, 1)
	    rubiksArray (1).side (3, 2) := rubiksArray (5).side (3, 2)
	    rubiksArray (1).side (3, 3) := rubiksArray (5).side (3, 3)
	    rubiksArray (5).side (3, 1) := rubiksArray (3).side (3, 3)
	    rubiksArray (5).side (3, 2) := rubiksArray (3).side (3, 2)
	    rubiksArray (5).side (3, 3) := rubiksArray (3).side (3, 1)
	    rubiksArray (3).side (3, 1) := rubiksArray (6).side (3, 3)
	    rubiksArray (3).side (3, 2) := rubiksArray (6).side (3, 2)
	    rubiksArray (3).side (3, 3) := rubiksArray (6).side (3, 1)
	    rubiksArray (6).side (3, 1) := extra (1)
	    rubiksArray (6).side (3, 2) := extra (2)
	    rubiksArray (6).side (3, 3) := extra (3)
	    rotate (4, true)
	label 5 :     %Rotate Front-Top-Left
	    extra (1) := rubiksArray (1).side (1, 1)
	    extra (2) := rubiksArray (1).side (1, 2)
	    extra (3) := rubiksArray (1).side (1, 3)
	    rubiksArray (1).side (1, 1) := rubiksArray (6).side (1, 1)
	    rubiksArray (1).side (1, 2) := rubiksArray (6).side (1, 2)
	    rubiksArray (1).side (1, 3) := rubiksArray (6).side (1, 3)
	    rubiksArray (6).side (1, 1) := rubiksArray (3).side (1, 3)
	    rubiksArray (6).side (1, 2) := rubiksArray (3).side (1, 2)
	    rubiksArray (6).side (1, 3) := rubiksArray (3).side (1, 1)
	    rubiksArray (3).side (1, 1) := rubiksArray (5).side (1, 3)
	    rubiksArray (3).side (1, 2) := rubiksArray (5).side (1, 2)
	    rubiksArray (3).side (1, 3) := rubiksArray (5).side (1, 1)
	    rubiksArray (5).side (1, 1) := extra (1)
	    rubiksArray (5).side (1, 2) := extra (2)
	    rubiksArray (5).side (1, 3) := extra (3)
	    rotate (2, true)
	label 6 :     %Rotate Front-Bottom-Left
	    extra (1) := rubiksArray (1).side (3, 1)
	    extra (2) := rubiksArray (1).side (3, 2)
	    extra (3) := rubiksArray (1).side (3, 3)
	    rubiksArray (1).side (3, 1) := rubiksArray (6).side (3, 1)
	    rubiksArray (1).side (3, 2) := rubiksArray (6).side (3, 2)
	    rubiksArray (1).side (3, 3) := rubiksArray (6).side (3, 3)
	    rubiksArray (6).side (3, 1) := rubiksArray (3).side (3, 3)
	    rubiksArray (6).side (3, 2) := rubiksArray (3).side (3, 2)
	    rubiksArray (6).side (3, 3) := rubiksArray (3).side (3, 1)
	    rubiksArray (3).side (3, 1) := rubiksArray (5).side (3, 3)
	    rubiksArray (3).side (3, 2) := rubiksArray (5).side (3, 2)
	    rubiksArray (3).side (3, 3) := rubiksArray (5).side (3, 1)
	    rubiksArray (5).side (3, 1) := extra (1)
	    rubiksArray (5).side (3, 2) := extra (2)
	    rubiksArray (5).side (3, 3) := extra (3)
	    rotate (4, false)
	label 7 :     %Rotate Front-Right-Down
	    extra (1) := rubiksArray (1).side (1, 3)
	    extra (2) := rubiksArray (1).side (2, 3)
	    extra (3) := rubiksArray (1).side (3, 3)
	    rubiksArray (1).side (1, 3) := rubiksArray (2).side (1, 3)
	    rubiksArray (1).side (2, 3) := rubiksArray (2).side (2, 3)
	    rubiksArray (1).side (3, 3) := rubiksArray (2).side (3, 3)
	    rubiksArray (2).side (1, 3) := rubiksArray (3).side (3, 3)
	    rubiksArray (2).side (2, 3) := rubiksArray (3).side (2, 3)
	    rubiksArray (2).side (3, 3) := rubiksArray (3).side (1, 3)
	    rubiksArray (3).side (1, 3) := rubiksArray (4).side (3, 3)
	    rubiksArray (3).side (2, 3) := rubiksArray (4).side (2, 3)
	    rubiksArray (3).side (3, 3) := rubiksArray (4).side (1, 3)
	    rubiksArray (4).side (1, 3) := extra (1)
	    rubiksArray (4).side (2, 3) := extra (2)
	    rubiksArray (4).side (3, 3) := extra (3)
	    rotate (6, false)
	label 8 :     %Rotate Front-Left-Down
	    extra (1) := rubiksArray (1).side (1, 1)
	    extra (2) := rubiksArray (1).side (2, 1)
	    extra (3) := rubiksArray (1).side (3, 1)
	    rubiksArray (1).side (1, 1) := rubiksArray (2).side (1, 1)
	    rubiksArray (1).side (2, 1) := rubiksArray (2).side (2, 1)
	    rubiksArray (1).side (3, 1) := rubiksArray (2).side (3, 1)
	    rubiksArray (2).side (1, 1) := rubiksArray (3).side (3, 1)
	    rubiksArray (2).side (2, 1) := rubiksArray (3).side (2, 1)
	    rubiksArray (2).side (3, 1) := rubiksArray (3).side (1, 1)
	    rubiksArray (3).side (1, 1) := rubiksArray (4).side (3, 1)
	    rubiksArray (3).side (2, 1) := rubiksArray (4).side (2, 1)
	    rubiksArray (3).side (3, 1) := rubiksArray (4).side (1, 1)
	    rubiksArray (4).side (1, 1) := extra (1)
	    rubiksArray (4).side (2, 1) := extra (2)
	    rubiksArray (4).side (3, 1) := extra (3)
	    rotate (5, true)
	label 9 :     %Rotate Front-Middle-Up
	    extra (1) := rubiksArray (1).side (1, 2)
	    extra (2) := rubiksArray (1).side (2, 2)
	    extra (3) := rubiksArray (1).side (3, 2)
	    rubiksArray (1).side (1, 2) := rubiksArray (4).side (1, 2)
	    rubiksArray (1).side (2, 2) := rubiksArray (4).side (2, 2)
	    rubiksArray (1).side (3, 2) := rubiksArray (4).side (3, 2)
	    rubiksArray (4).side (1, 2) := rubiksArray (3).side (3, 2)
	    rubiksArray (4).side (2, 2) := rubiksArray (3).side (2, 2)
	    rubiksArray (4).side (3, 2) := rubiksArray (3).side (1, 2)
	    rubiksArray (3).side (1, 2) := rubiksArray (2).side (3, 2)
	    rubiksArray (3).side (2, 2) := rubiksArray (2).side (2, 2)
	    rubiksArray (3).side (3, 2) := rubiksArray (2).side (1, 2)
	    rubiksArray (2).side (1, 2) := extra (1)
	    rubiksArray (2).side (2, 2) := extra (2)
	    rubiksArray (2).side (3, 2) := extra (3)
	label 10 :     %Rotate Front-Middle-Down
	    extra (1) := rubiksArray (1).side (1, 2)
	    extra (2) := rubiksArray (1).side (2, 2)
	    extra (3) := rubiksArray (1).side (3, 2)
	    rubiksArray (1).side (1, 2) := rubiksArray (2).side (1, 2)
	    rubiksArray (1).side (2, 2) := rubiksArray (2).side (2, 2)
	    rubiksArray (1).side (3, 2) := rubiksArray (2).side (3, 2)
	    rubiksArray (2).side (1, 2) := rubiksArray (3).side (3, 2)
	    rubiksArray (2).side (2, 2) := rubiksArray (3).side (2, 2)
	    rubiksArray (2).side (3, 2) := rubiksArray (3).side (1, 2)
	    rubiksArray (3).side (1, 2) := rubiksArray (4).side (3, 2)
	    rubiksArray (3).side (2, 2) := rubiksArray (4).side (2, 2)
	    rubiksArray (3).side (3, 2) := rubiksArray (4).side (1, 2)
	    rubiksArray (4).side (1, 2) := extra (1)
	    rubiksArray (4).side (2, 2) := extra (2)
	    rubiksArray (4).side (3, 2) := extra (3)
	label 11 :     %Rotate Front-Middle-Right
	    extra (1) := rubiksArray (1).side (2, 1)
	    extra (2) := rubiksArray (1).side (2, 2)
	    extra (3) := rubiksArray (1).side (2, 3)
	    rubiksArray (1).side (2, 1) := rubiksArray (5).side (2, 1)
	    rubiksArray (1).side (2, 2) := rubiksArray (5).side (2, 2)
	    rubiksArray (1).side (2, 3) := rubiksArray (5).side (2, 3)
	    rubiksArray (5).side (2, 1) := rubiksArray (3).side (2, 3)
	    rubiksArray (5).side (2, 2) := rubiksArray (3).side (2, 2)
	    rubiksArray (5).side (2, 3) := rubiksArray (3).side (2, 1)
	    rubiksArray (3).side (2, 1) := rubiksArray (6).side (2, 3)
	    rubiksArray (3).side (2, 2) := rubiksArray (6).side (2, 2)
	    rubiksArray (3).side (2, 3) := rubiksArray (6).side (2, 1)
	    rubiksArray (6).side (2, 1) := extra (1)
	    rubiksArray (6).side (2, 2) := extra (2)
	    rubiksArray (6).side (2, 3) := extra (3)
	label 12 :     %Rotate Front-Middle-Left
	    extra (1) := rubiksArray (1).side (2, 1)
	    extra (2) := rubiksArray (1).side (2, 2)
	    extra (3) := rubiksArray (1).side (2, 3)
	    rubiksArray (1).side (2, 1) := rubiksArray (6).side (2, 1)
	    rubiksArray (1).side (2, 2) := rubiksArray (6).side (2, 2)
	    rubiksArray (1).side (2, 3) := rubiksArray (6).side (2, 3)
	    rubiksArray (6).side (2, 1) := rubiksArray (3).side (2, 3)
	    rubiksArray (6).side (2, 2) := rubiksArray (3).side (2, 2)
	    rubiksArray (6).side (2, 3) := rubiksArray (3).side (2, 1)
	    rubiksArray (3).side (2, 1) := rubiksArray (5).side (2, 3)
	    rubiksArray (3).side (2, 2) := rubiksArray (5).side (2, 2)
	    rubiksArray (3).side (2, 3) := rubiksArray (5).side (2, 1)
	    rubiksArray (5).side (2, 1) := extra (1)
	    rubiksArray (5).side (2, 2) := extra (2)
	    rubiksArray (5).side (2, 3) := extra (3)
    end case
end slide

procedure flip (c : int)
    case c of
	label 1 :     %flip top
	    slide (9)
	    slide (1)
	    slide (2)
	label 2 :     %flip right
	    slide (11)
	    slide (3)
	    slide (4)
	label 3 :     %flip left
	    slide (12)
	    slide (5)
	    slide (6)
	label 4 :     %flip bottom
	    slide (10)
	    slide (7)
	    slide (8)
    end case
end flip

procedure randomizeCube
    %randomizes the cube by calling the slide procedure with a random integer parameter
    for i : 1 .. 100
	slide (Rand.Int (1, 12))
    end for
end randomizeCube

procedure updateView
    %Draw Front Side
    Draw.FillBox (243, 453, 301, 394, rubiksArray (1).side (1, 1))
    Draw.FillBox (318, 453, 376, 394, rubiksArray (1).side (1, 2))
    Draw.FillBox (393, 453, 451, 394, rubiksArray (1).side (1, 3))
    Draw.FillBox (243, 378, 301, 319, rubiksArray (1).side (2, 1))
    Draw.FillBox (318, 378, 376, 319, rubiksArray (1).side (2, 2))
    Draw.FillBox (393, 378, 451, 319, rubiksArray (1).side (2, 3))
    Draw.FillBox (243, 303, 301, 244, rubiksArray (1).side (3, 1))
    Draw.FillBox (318, 303, 376, 244, rubiksArray (1).side (3, 2))
    Draw.FillBox (393, 303, 451, 244, rubiksArray (1).side (3, 3))
    %Draw Right Side
    Draw.FillBox (538, 415, 571, 382, rubiksArray (6).side (1, 1))
    Draw.FillBox (588, 415, 621, 382, rubiksArray (6).side (1, 2))
    Draw.FillBox (638, 415, 671, 382, rubiksArray (6).side (1, 3))
    Draw.FillBox (538, 365, 571, 332, rubiksArray (6).side (2, 1))
    Draw.FillBox (588, 365, 621, 332, rubiksArray (6).side (2, 2))
    Draw.FillBox (638, 365, 671, 332, rubiksArray (6).side (2, 3))
    Draw.FillBox (538, 315, 571, 282, rubiksArray (6).side (3, 1))
    Draw.FillBox (588, 315, 621, 282, rubiksArray (6).side (3, 2))
    Draw.FillBox (638, 315, 671, 282, rubiksArray (6).side (3, 3))
    %Draw Left Side
    Draw.FillBox (23, 415, 56, 382, rubiksArray (5).side (1, 1))
    Draw.FillBox (73, 415, 106, 382, rubiksArray (5).side (1, 2))
    Draw.FillBox (123, 415, 156, 382, rubiksArray (5).side (1, 3))
    Draw.FillBox (23, 365, 56, 332, rubiksArray (5).side (2, 1))
    Draw.FillBox (73, 365, 106, 332, rubiksArray (5).side (2, 2))
    Draw.FillBox (123, 365, 156, 332, rubiksArray (5).side (2, 3))
    Draw.FillBox (23, 315, 56, 282, rubiksArray (5).side (3, 1))
    Draw.FillBox (73, 315, 106, 282, rubiksArray (5).side (3, 2))
    Draw.FillBox (123, 315, 156, 282, rubiksArray (5).side (3, 3))
    %Draw Top Side
    Draw.FillBox (280, 673, 313, 640, rubiksArray (2).side (1, 1))
    Draw.FillBox (330, 673, 363, 640, rubiksArray (2).side (1, 2))
    Draw.FillBox (380, 673, 413, 640, rubiksArray (2).side (1, 3))
    Draw.FillBox (280, 623, 313, 590, rubiksArray (2).side (2, 1))
    Draw.FillBox (330, 623, 363, 590, rubiksArray (2).side (2, 2))
    Draw.FillBox (380, 623, 413, 590, rubiksArray (2).side (2, 3))
    Draw.FillBox (280, 573, 313, 540, rubiksArray (2).side (3, 1))
    Draw.FillBox (330, 573, 363, 540, rubiksArray (2).side (3, 2))
    Draw.FillBox (380, 573, 413, 540, rubiksArray (2).side (3, 3))
    %Draw Bottom Side
    Draw.FillBox (280, 158, 313, 125, rubiksArray (4).side (1, 1))
    Draw.FillBox (330, 158, 363, 125, rubiksArray (4).side (1, 2))
    Draw.FillBox (380, 158, 413, 125, rubiksArray (4).side (1, 3))
    Draw.FillBox (280, 108, 313, 75, rubiksArray (4).side (2, 1))
    Draw.FillBox (330, 108, 363, 75, rubiksArray (4).side (2, 2))
    Draw.FillBox (380, 108, 413, 75, rubiksArray (4).side (2, 3))
    Draw.FillBox (280, 58, 313, 25, rubiksArray (4).side (3, 1))
    Draw.FillBox (330, 58, 363, 25, rubiksArray (4).side (3, 2))
    Draw.FillBox (380, 58, 413, 25, rubiksArray (4).side (3, 3))
    %Draw Back Side
    Draw.FillBox (558, 138, 577, 119, rubiksArray (3).side (1, 1))
    Draw.FillBox (593, 138, 612, 119, rubiksArray (3).side (1, 2))
    Draw.FillBox (628, 138, 647, 119, rubiksArray (3).side (1, 3))
    Draw.FillBox (558, 103, 577, 84, rubiksArray (3).side (2, 1))
    Draw.FillBox (593, 103, 612, 84, rubiksArray (3).side (2, 2))
    Draw.FillBox (628, 103, 647, 84, rubiksArray (3).side (2, 3))
    Draw.FillBox (558, 68, 577, 49, rubiksArray (3).side (3, 1))
    Draw.FillBox (593, 68, 612, 49, rubiksArray (3).side (3, 2))
    Draw.FillBox (628, 68, 647, 49, rubiksArray (3).side (3, 3))
    View.Update
end updateView

procedure getMouse
    %Determines if the mouse has been pressed, and where has it been pressed
    %If the mouse was in a certain area, then a procedure may be called
    var mousex, mousey, mouseb : int
    loop
	Mouse.Where (mousex, mousey, mouseb)
	if mouseb = 1 then
	    if mousex > 237 and mousex < 455 and mousey < 508 and mousey > 495 then
		flip (1) %Flip top
	    elsif mousex > 237 and mousex < 305 and mousey < 487 and mousey > 475 then
		slide (2) %Rotate Front-Left-Up
	    elsif mousex > 312 and mousex < 381 and mousey < 487 and mousey > 475 then
		slide (9) %Rotate Front-Middle-Up
	    elsif mousex > 387 and mousex < 455 and mousey < 487 and mousey > 475 then
		slide (1) %Rotate Front-Right-Up
	    elsif mousex > 492 and mousex < 506 and mousey < 457 and mousey > 239 then
		flip (2) %flip right
	    elsif mousex > 472 and mousex < 486 and mousey < 486 and mousey > 389 then
		slide (3) %Rotate Front-Top-Right
	    elsif mousex > 472 and mousex < 486 and mousey < 382 and mousey > 314 then
		slide (11) %Rotate Front-Middle-Right
	    elsif mousex > 472 and mousex < 486 and mousey < 307 and mousey > 239 then
		slide (4) %Rotate Front-Bottom-Right
	    elsif mousex > 187 and mousex < 201 and mousey < 457 and mousey > 239 then
		flip (3) %flip left
	    elsif mousex > 207 and mousex < 221 and mousey < 457 and mousey > 389 then
		slide (5) %Rotate Front-Top-Left
	    elsif mousex > 207 and mousex < 221 and mousey < 383 and mousey > 314 then
		slide (12) %Rotate Front-Middle-Left
	    elsif mousex > 207 and mousex < 221 and mousey < 340 and mousey > 239 then
		slide (6) %Rotate Front-Bottom-Left
	    elsif mousex > 237 and mousex < 456 and mousey < 203 and mousey > 189 then
		flip (4) %flip bottom
	    elsif mousex > 237 and mousex < 306 and mousey < 223 and mousey > 209 then
		slide (8) %Rotate Front-Left-Down
	    elsif mousex > 312 and mousex < 381 and mousey < 223 and mousey > 209 then
		slide (10) %Rotate Front-Middle-Down
	    elsif mousex > 387 and mousex < 456 and mousey < 223 and mousey > 209 then
		slide (7) %Rotate Front-Right-Down
	    elsif mousex > 15 and mousex < 160 and mousey < 680 and mousey > 650 then
		randomizeCube
	    elsif mousex > 585 and mousex < 675 and mousey < 675 and mousey > 650 then
		quitGame := true %Quits the game
		exit
	    elsif mousex > 185 and mousex < 230 and mousey < 505 and mousey > 475 then
		frontRotate (1, true) %Rotates the front side clockwise
	    elsif mousex > 470 and mousex < 505 and mousey < 505 and mousey > 475 then
		frontRotate (1, false) %Rotates the front side counterclockwise
	    elsif mousex > 585 and mousex < 680 and mousey < 640 and mousey > 615 then
		saveGame %saves the game
	    elsif mousex > 585 and mousex < 680 and mousey < 600 and mousey > 575 then
		initializeCube %resets the array by re-initializing the values in the array
	    elsif mousex > 585 and mousex < 680 and mousey < 560 and mousey > 535 then
		loadGame %loads the game
	    end if
	end if
	updateView
	delay (100)
    end loop
end getMouse

procedure drawBackground
    %Draws the display
    var rubiksCubeDisplay := Pic.FileNew ("Images/CubeDisplay.jpg")
    Pic.Draw (rubiksCubeDisplay, 0, 0, 0)
    View.Update
end drawBackground

procedure determineIfSolved
    %Checks the array to see if all sides match
    %Exits loop if it does not
    var solved : boolean := true
    for a : 1 .. 6
	for b : 1 .. 3
	    for c : 1 .. 3
		if rubiksArray (a).side (1, 1) ~= rubiksArray (a).side (b, c) then
		    solved := false
		    exit
		end if
	    end for
	end for
    end for
    %Displays solved status that is continuously updated until user exits the game
    if quitGame = false then
	Pic.Draw (backgroundColor, 0, 0, 0)
	if solved = false then
	    Font.Draw ("Status : Unsolved", 0, 20, font1, red)
	else
	    Font.Draw ("Status : Solved", 1, 20, font1, yellow)
	end if
	View.Update
    end if
end determineIfSolved

process solvedTrueOrFalse
    %Keeps updating the solved status until the user quits the game
    loop
	exit when quitGame = true
	determineIfSolved
    end loop
end solvedTrueOrFalse

procedure endGame
    %Draws the ending screen
    var endScreen := Pic.FileNew ("Images/GameEndingScreen.jpg")
    Pic.Draw (endScreen, 0, 0, 0)
end endGame


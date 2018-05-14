%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Ian Yuan
%Date:    June 2013
%Course:  ICS3CU1
%Teacher:  M. Ianni
%Program Name: Rubik's Cube
%Descriptions:  Final Program Name Here and a brief description of the game
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% main procedure to handle the intro window
procedure displayIntroWindow (var instructions : boolean, var start : boolean, var quitmenu : boolean)

    % flag that intro screen is open - global var isIntroWindowOpen
    isIntroWindowOpen := true
    var mousex, mousey, mouseb : int
    var titleScreen := Pic.FileNew ("Images/GameTitlePageSquare.jpg")
    var arrow := Pic.FileNew ("Images/yellowarrow.bmp")
    loop
	instructions := false
	start := false
	loop
	    Pic.Draw (titleScreen, 0, 0, 0)
	    Mouse.Where (mousex, mousey, mouseb)
	    %Determines if mouse is hovering over the "Start" message
	    if mousex > 85 and mousex < 195 and mousey < 220 and mousey > 180 then
		%If it is, then draw an arrow indicating you are hovering over the Start button
		Pic.Draw (arrow, 50, 190, picMerge)
	    end if
	    %Determines if mouse is hovering over the "Instructions" message
	    if mousex > 85 and mousex < 340 and mousey < 160 and mousey > 120 then
		%If it is, then draw an arrow indicating you are hovering over the "Instructions" button
		Pic.Draw (arrow, 50, 130, picMerge)
	    end if
	    if mousex > 85 and mousex < 185 and mousey < 100 and mousey > 60 then
		%If it is, then draw an arrow indicating you are hovering over the "Quit" button
		Pic.Draw (arrow, 50, 70, picMerge)
	    end if
	    View.Update %Keep updating where and if an arrow is displayed
	    delay (100)
	    exit when mouseb = 1
	end loop
	if mouseb = 1 and mousex > 85 and mousex < 195 and mousey < 220 and mousey > 180 then
	    start := true
	    exit
	end if
	if mouseb = 1 and mousex > 85 and mousex < 340 and mousey < 160 and mousey > 120 then
	    instructions := true
	    exit
	end if
	if mouseb = 1 and mousex > 85 and mousex < 185 and mousey < 100 and mousey > 60 then
	    quitmenu := true
	    exit
	end if
	exit when start = true
    end loop

end displayIntroWindow

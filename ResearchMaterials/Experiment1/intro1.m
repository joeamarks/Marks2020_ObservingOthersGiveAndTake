function intro1()
%% Third Party Dictator Game Script Ver 0.3 

%% Configure Cogent
config_display(0, 4, [0 0 0], [1 1 1], 'Helvetica', 38, 28, 0);             % Configure display (window mode, resolution, black background, white foreground, fontname, fontsize, nbuffers, direct mode)
config_keyboard;                                                            % Configure keyboard (non-exclusive mode)
config_mouse(10);

%% Variables
endsplit = [10 ; 8];  

%% Experiment
start_cogent;

preparestring('Welcome to this experiment!',1,0,200);
preparestring('At the end of the instructions, the computer will be connected',1,0,50);
preparestring('with an online service that provides members the opportunity',1,0,0);
preparestring('to earn money by participating in a simple online game.',1,0,-50);
preparestring('Press any mouse button to proceed with instruction',1,0,-360);

preparestring('There are three players on each trial: A,B and C.',2,0,200); %1
preparestring('You are always player C.',2,0,150); %3
preparestring('At the beginning of a trial you will just be observing online players A and B.',2,0,100); %5
preparestring('Player B will receive between ?1 and ?15 from the experimenter.',2,0,50); %6
preparestring('Then player A can take any amount of that money from player B for her/himself.',2,0,0); %7
preparestring('There is nothing player B can do about it.',2,0,-50); %8
preparestring('On each trial you will be playing with different online participants.',2,0,-150); %4
preparestring('Everyone is anonymous.',2,0,-200); %2
preparestring('Press any mouse button to see an example',2,0,-360);

drawpict(1);
waitmouse;
clearpict(1);

drawpict(2);
waitmouse;
clearpict(2);

%% Start Task
i = 1;
q = 0;

while i == 1                                                             % Loop Trials task    
    q = q + 1;
    
%% Define level of endowment for player B
    endowment=endsplit(1,1);                                             % choose random initial endowment    

%% Fixation Cross Screen
    cgmakesprite(1,1280,1024,0,0,0);
    cgsetsprite(1);
    cgpencol(1,1,1);
    cgtext('+',0,0);
    cgsetsprite(0);
    cgdrawsprite(1,0,0);
    cgflip;
    wait(500);

%% Screen present member of game (experimenter, player A, and player B)
    cgmakesprite(2,1280,1024,0,0,0);
    cgsetsprite(2);
    loadpict('Experimenter.bmp',2,0,200);                                       
    cgpencol(1,0,0);
    cgtext('Experimenter',0,70);
    loadpict('Player.bmp',2,-200,-180);                                         
    cgpencol(1,1,1);
    cgtext('Player A',-200,-310);
    loadpict('Player.bmp',2,200,-180);                                          
    cgtext('Player B',200,-310);
    cgsetsprite(0);
    cgdrawsprite(2,0,0);
    cgflip;
    wait(5000);
    
%% Screen initial endowment from experimenter to player B
    cgsetsprite(2);
    cgtext(strcat('The experimenter gives Player B ?', num2str(endowment)),0,360);
    cgpencol(1,1,0);
    cgtext(strcat('?', num2str(endowment)),150,0); 
    cgsetsprite(0);
    cgdrawsprite(2,0,0);
    cgflip;
    wait(5000);
    
%% Screen player A decides how to split endowment
    cgmakesprite(4,1280,1024,0,0,0);
    cgsetsprite(4);
    cgpencol(1,1,1);
    cgtext('Player A decides how much to take from Player B',0,360);
    loadpict('Player.bmp',4,-200,0);                                         % Load stick-figure experimenter
    cgtext('Player A',-200,-150);
    cgtext('-',-200,150);
    loadpict('Player.bmp',4,200,0);                                          % Load stick-figure experimenter
    cgtext('Player B',200,-150);
    cgpencol(1,1,0);
    cgtext(strcat('?',num2str(endowment)),200,150);
    cgsetsprite(0);
    cgdrawsprite(4,0,0);
    cgflip;
    wait(5000);   

%% Define level of split between player A and B
    playerA=(endowment/10)*endsplit(2,1);                            % choose random split for player A
    strplayerA=num2str(playerA,'%32.16g');
    controlA=length(strplayerA)-find(strplayerA=='.');
    playerB=endowment-playerA;                                              % choose random split for player B
    strplayerB=num2str(playerB,'%32.16g');
    controlB=length(strplayerB)-find(strplayerB=='.');
    
%% Screen information about different amounts of endowment between players
    cgmakesprite(6,1280,1024,0,0,0);
    cgsetsprite(6);
    if isempty(controlA) == 1
        cgpencol(1,1,1);
        cgtext(strcat('Player A decided to take ?',num2str(sprintf('%.0f',playerA)),' from B'),0,360);
        cgtext(strcat('so player B is left with ?',num2str(sprintf('%.0f',playerB))),0,320);
        cgpencol(1,1,0);
        cgtext(strcat('?',num2str(sprintf('%.0f',playerA))),-200,150);
        cgtext(strcat('?',num2str(sprintf('%.0f',playerB))),200,150);
        cgpencol(1,1,1);
    else
        cgpencol(1,1,1);
        cgtext(strcat('Player A decided to take ?',num2str(sprintf('%.1f',playerA)),' from B'),0,360);
        cgtext(strcat('so player B is left with ?',num2str(sprintf('%.1f',playerB))),0,320);
        cgpencol(1,1,0);
        cgtext(strcat('?',num2str(sprintf('%.1f',playerA))),-200,150);
        cgtext(strcat('?',num2str(sprintf('%.1f',playerB))),200,150);
        cgpencol(1,1,1);
    end;
    loadpict('Player.bmp',6,-200,0);                                         % Load stick-figure experimenter
    cgtext('Player A',-200,-150);
    loadpict('Player.bmp',6,200,0);                                          % Load stick-figure experimenter
    cgtext('Player B',200,-150);
    cgsetsprite(0);
    cgdrawsprite(6,0,0);
    cgflip;
    wait(5000);
    
%% Screen Task for participant
cgmakesprite(18,1280,1024,0,0,0);
cgsetsprite(18);
cgpencol(1,1,1);
cgtext('Now you have the opportunity to penalize player A',0,50);
cgtext('by choosing an amount of money to be taken away',0,0);
cgtext('from A and go back to the experimenter.',0,-50);
cgtext('Press any mouse button to proceed with instruction',0,-360);
cgsetsprite(0);
cgdrawsprite(18,0,0);
cgflip;
waitmouse;

%% Screen penalize
    VASwidth=1280;                                                          % width sprite scales
    VASheight=320;                                                          % height sprite scales
    arrowwidth=20;                                                          % width sprite scale arrow
    arrowheight=20;                                                         % heigth sprite scale arrow
    leftend = -350;                                                         % left end (x-value) scale
    rightend = 350;                                                         % right end (x-value) scale
    xpos = randi([-60 60]);               %starting x pos of arrow

    cgmakesprite (7, 1280, 100, 0, 0, 0);
    cgsetsprite(7);
    cgpencol(1,1,1);
    cgtext('By how much would you like to penalize Player A?',0,0);

    cgmakesprite (8, VASwidth, VASheight, 0, 0, 0);    %make black ratesprite       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    cgsetsprite (8);                        %ready sprite to draw into
    cgalign ('c', 'c');                     %center alignment
    cgpencol (1, 1, 1);                     %white on black background
    cgfont ('Helvetica', 26);
    cgtext ('Move mouse cursor to a position on the scale and press LEFT mouse button.', 0, 140);
    cgtext ('Press RIGHT mouse button to confirm your decision.', 0, 110); 
    cgfont ('Helvetica', 38);
    cgrect (0, 30, rightend-leftend, 4);                  %draw horizontal line
    cgrect (leftend, 30, 4, 15);                %draw left major tick
    cgrect (rightend, 30, 4, 15);                 %draw right major tick
    %cgrect (leftend+rightend, 30, 2, 15);
    cgtext ('?0', leftend, -55);
    cgfont ('Helvetica', 26);
    cgtext ('(No penalty - leave all of A''s', leftend, -95);
    cgtext ('money)', leftend, -130);
    cgfont ('Helvetica', 38);
    if isempty(controlA) == 1
        cgtext (strcat('?',num2str(sprintf('%.0f',playerA))), rightend, -55);
    else
        cgtext (strcat('?',num2str(sprintf('%.1f',playerA))), rightend, -55);
    end;
    cgfont ('Helvetica', 26);
    cgtext ('(Maximum penalty - take', rightend, -95);
    cgtext ('away all of A''s money)', rightend, -130); 
    cgfont ('Helvetica', 38);
    
    cgmakesprite (9, 15, 15, 0, 0, 0);               %make arrowsprite       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    cgsetsprite (9);
    cgpencol (1, 0, 0);                     %white arrow
    %cgpolygon ([-0.5 0 0.5]*arrowwidth, [-0.5 0.5 -0.5].*arrowheight);
    cgellipse(0,0,15,15,'f')
    cgpencol (1, 1, 1);
    cgsetsprite (0);
    
    cgmakesprite (10, VASwidth, VASheight, 1, 1, 1);    %make black full ratesprite for later use       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    cgmakesprite(11,1280,1024,0,0,0);                                               % black empty sprite
    
    cgmakesprite(3,1280,1024,0,0,0);
       
    cgmakesprite(12,550,300,0,0,0);
    cgsetsprite(12);
    cgpencol(1,1,1);
    loadpict('Player.bmp',12,-200,0);                                    
    cgtext('Player A',-200,-130);
    loadpict('Player.bmp',12,200,0);                                     
    cgtext('Player B',200,-130);
    cgpencol(1,1,0);
    if isempty(controlA) == 1
        cgtext(strcat('?',num2str(sprintf('%.0f',playerA))),-200,130);
        cgtext(strcat('?',num2str(sprintf('%.0f',playerB))),200,130);
    else
        cgtext(strcat('?',num2str(sprintf('%.1f',playerA))),-200,130);
        cgtext(strcat('?',num2str(sprintf('%.1f',playerB))),200,130);
    end;

    cgmakesprite (13, 10, 10, 0, 0, 0);                                             % sprite mouse cursor
    cgsetsprite (13);
    cgpencol (1, 1, 1);                     
    cgpolygon ([-0.5 0 0.5]*15, [-0.5 0.5 -0.5].*15);
    
    map = getmousemap;
    clearmouse;
    x = 0;
    y = 0;
    d = 0;
    while 1
        cgsetsprite (10);                % ready whole ratingsprite to draw into
        cgdrawsprite (8, 0, 0);         % draw ratingscale
        if d == 1
            cgdrawsprite (9,xpos,30);    % draw ratingarrow
        end;
        cgsetsprite(11);
        cgdrawsprite(3,0,0);
        cgdrawsprite (10, 0, 130, VASwidth, VASheight);     % draw ratingsprite onto offscreen
        cgdrawsprite(12,0,-200);
        cgdrawsprite (7, 0, 360);
        cgdrawsprite(13,x,y);
        cgsetsprite (0);
        cgdrawsprite(11,0,0);          
        cgflip (0,0,0);
        
        readmouse;
        x = x + sum(getmouse(map.X));
        y = y - sum(getmouse(map.Y));
        
        if x < -560
            x = -560;
        elseif x > 560
            x = 560;
        elseif y < -400
            y = -400;
        elseif y > 400
            y = 400;
        end;
        
        %xmouse=getmouse(map.X);
        %ymouse=getmouse(map.Y);
        b1mouse=getmouse(map.Button1);
        b2mouse=getmouse(map.Button2);

        
        if ~isempty(b1mouse) && any(b1mouse == 128) && (x >= -360 && x <= 360) && (y >= 135 && y <= 180)
            t1 = time;
            xpos = x;
            if (x == -360) || (x == -359) || (x == -358) || (x == -357) || (x == -356) || (x == -355) || (x == -354) || (x == -353) || (x == -352) || (x == -351) || (x == -350) || (x == -349) || (x == -348) || (x == -347)
                xpos = -350;
            elseif (x == 360) || (x == 359) || (x == 358) || (x == 357) || (x == 356) || (x == 355) || (x == 354) || (x == 353) || (x == 352) || (x == 351) || (x == 350) || (x == 349) || (x == 348) || (x == 347)
                xpos = 350;
            elseif (x == -3) || (x == -2) || (x == -1) || (x == 0) || (x == 1) || (x == 2) || (x == 3)
                xpos = 0;
            end;
            d = 1;
        elseif ~isempty(b2mouse) && any(b2mouse == 128) && d == 1
            break        
        end;
    end;
    
    investment = (rightend+xpos)*((playerA/2)/rightend);
    strinvestment = num2str(investment,'%32.16g');
    control = length(strinvestment)-find(strinvestment=='.');
    
%% Screen display final result
%     cgmakesprite(18,1280,1024,0,0,0);
%     cgsetsprite(18);
%     cgpencol(1,1,1)
%     if isempty(control) == 1
%     cgtext(strcat('You have penalized Player A by ?',num2str(sprintf('%.0f',investment))),0,50);
%     cgtext(strcat('Player A will be paid ?',num2str(sprintf('%.0f',playerA-investment))),0,-50);
%     else
%     cgtext(strcat('You have penalized Player A by ?',num2str(sprintf('%.1f',investment))),0,50);
%     cgtext(strcat('Player A will be paid ?',num2str(sprintf('%.1f',playerA-investment))),0,-50);
%     end
%     cgsetsprite(0);
%     cgdrawsprite(18,0,0);
%     cgflip(0,0,0);
%     wait(5000);
    
%% End Screen
%     cgmakesprite(17,1280,1024,0,0,0);
%     cgsetsprite(17);
%     cgpencol(1,1,1);
%     cgtext('End',0,0);
%     cgsetsprite(0);
%     cgdrawsprite(17,0,0);
%     cgflip;
%     wait(3000);

i=i+1;
end;                                                                         % End Loop Trial

%% Screen end of intro 1
cgmakesprite(14,1280,1024,0,0,0);
cgsetsprite(14); 
cgpencol(1,1,1);
cgtext('End of Instruction',0,50);
cgtext('If you have any questions please ask the experimenter.',0,0);
cgtext('Press any mouse button to proceed to training session.',0,-50);
cgsetsprite(0);
cgdrawsprite(14,0,0);
cgflip(0,0,0);
waitmouse;

stop_cogent
end
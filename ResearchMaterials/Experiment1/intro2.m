function intro2()
%% Third Party Dictator Game Script Ver 0.1

%% Configure Cogent
config_display(0, 4, [0 0 0], [1 1 1], 'Helvetica', 38, 28, 0);             % Configure display (window mode, resolution, black background, white foreground, fontname, fontsize, nbuffers, direct mode)
config_keyboard;                                                            % Configure keyboard (non-exclusive mode)
config_mouse(10);

%% Variables
endsplit = [10 ; 8];  

%% Experiment
start_cogent;

preparestring('The games will be similar to the first session but now',1,0,25);
preparestring('you will be asked two questions within each game.',1,0,-25);
preparestring('Press any mouse button for an example',1,0,-360);

drawpict(1);
waitmouse;
clearpict(1);

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
    cgtext(strcat('The experimenter gives Player B £', num2str(endowment)),0,360);
    cgpencol(1,1,0);
    cgtext(strcat('£', num2str(endowment)),150,0); 
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
    cgtext(strcat('£',num2str(endowment)),200,150);
    cgsetsprite(0);
    cgdrawsprite(4,0,0);
    cgflip;
    wait(5000);    

%% Define level of split between player A and B
    playerA=(endowment/10)*endsplit(2,1);                                   % choose random split for player A
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
        cgtext(strcat('Player A decided to take £',num2str(sprintf('%.0f',playerA)),' from B'),0,360);
        cgtext(strcat('so player B is left with £',num2str(sprintf('%.0f',playerB))),0,320);
        cgpencol(1,1,0);
        cgtext(strcat('£',num2str(sprintf('%.0f',playerA))),-200,150);
        cgtext(strcat('£',num2str(sprintf('%.0f',playerB))),200,150);
        cgpencol(1,1,1);
    else
        cgpencol(1,1,1);
        cgtext(strcat('Player A decided to take £',num2str(sprintf('%.1f',playerA)),' from B'),0,360);
        cgtext(strcat('so player B is left with £',num2str(sprintf('%.1f',playerB))),0,320);
        cgpencol(1,1,0);
        cgtext(strcat('£',num2str(sprintf('%.1f',playerA))),-200,150);
        cgtext(strcat('£',num2str(sprintf('%.1f',playerB))),200,150);
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
    
%% Screen Question 1
    VASwidth=1280;                                                          % width sprite scales
    VASheight=320;                                                          % height sprite scales
    arrowwidth=20;                                                          % width sprite scale arrow
    arrowheight=20;                                                         % heigth sprite scale arrow
    leftend = -350;                                                         % left end (x-value) scale
    rightend = 350;                                                         % right end (x-value) scale
    xpos = randi([-60 60]);                                                 % random starting x pos of scale arrow (jittering between x = -60 and x = 60)

    negtopos = -350;
    postoneg = 350;
       
        cgmakesprite (19, 1280, 100, 0, 0, 0);                               % sprite question as headline
        cgsetsprite(19);
        cgpencol(1,1,1);
        cgtext('How does Player A''s decision make you feel?',0,0);

        cgmakesprite (20, VASwidth, VASheight, 0, 0, 0);                     % sprite feeling scale  
        cgsetsprite (20);                        
        cgalign ('c', 'c');                     
        cgpencol (1, 1, 1);                     
        cgrect (0, 0, rightend-leftend, 4);                  
        cgrect (leftend, 0, 4, 15);                
        cgrect (rightend, 0, 4, 15);                 
        cgtext ('-3', negtopos, -55);
        cgtext ('extremely', negtopos, -85);
        cgtext ('negative', negtopos, -115);
        cgtext ('0', negtopos+postoneg, -55);
        cgtext ('neutral', negtopos+postoneg, -100);
        cgtext ('+3', postoneg, -55);
        cgtext ('extremely', postoneg, -85);
        cgtext ('positive', postoneg, -115);
        for tick = 1:5
            cgrect ((rightend*(1/3))*(tick - 3), 0, 2, 15);
        end;
        
        cgmakesprite (21, 15, 15, 0, 0, 0);               	% sprite scale arrow
        cgsetsprite (21);
        cgpencol (1, 0, 0);                     
        %cgpolygon ([-0.5 0 0.5]*arrowwidth, [-0.5 0.5 -0.5].*arrowheight);
        cgellipse(0,0,15,15,'f')
        cgpencol (1, 1, 1);
        cgsetsprite (0);
        
        cgmakesprite (22, VASwidth, VASheight, 1, 1, 1);                     % sprite to draw scale and scale arrow into

        cgmakesprite(23,1280,1024,0,0,0);                                               % black empty sprite

        cgmakesprite(12,1280,1024,0,0,0);
        cgsetsprite(12);
        cgpencol(1,1,1);
        loadpict('Player.bmp',12,-200,-100);                                    
        cgtext('Player A',-200,-230);
        loadpict('Player.bmp',12,200,-100);                                     
        cgtext('Player B',200,-230);
        cgpencol(1,1,0);
    if isempty(controlA) == 1
        cgtext(strcat('£',num2str(sprintf('%.0f',playerA))),-200,30);
        cgtext(strcat('£',num2str(sprintf('%.0f',playerB))),200,30);
    else
        cgtext(strcat('£',num2str(sprintf('%.1f',playerA))),-200,30);
        cgtext(strcat('£',num2str(sprintf('%.1f',playerB))),200,30);
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
            cgsetsprite (22);                                                % ready whole ratingsprite to draw into
            cgdrawsprite (20, 0, 0);                                         % draw ratingscale
            if d == 1
                cgdrawsprite (21,xpos,0);    % draw ratingarrow
            end;
            cgsetsprite(23);                                                % whole sprite to draw into
            cgdrawsprite(12,0,0);                                            % draw distribution between two player
            cgdrawsprite (22, 0, 230, VASwidth, VASheight);                  % draw whole ratingsprite
            cgdrawsprite (19, 0, 360);                                       % draw headline
            cgdrawsprite(13,x,y);                                           % draw mouse cursor
            cgsetsprite (0);                                                % set sprite 0
            cgdrawsprite(23,0,0);                                           % draw whole sprite on sprite 0
            cgflip (0,0,0);                                                 % presenting scale
            
            readmouse;                                                      % Update mouse map for latest mouse activity
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
            
            xmouse=getmouse(map.X);
            ymouse=getmouse(map.Y);
            b1mouse=getmouse(map.Button1);
            b2mouse=getmouse(map.Button2);
            
            if ~isempty(b1mouse) && any(b1mouse == 128) && (x >= -360 && x <= 360) && (y >= 200 && y <= 245)
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
                break;
            end;
        end;

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
    cgrect (0, 0, rightend-leftend, 4);                  %draw horizontal line
    cgrect (leftend, 0, 4, 15);                %draw left major tick
    cgrect (rightend, 0, 4, 15);                 %draw right major tick
    %cgrect (leftend+rightend, 0, 2, 15);
    cgtext ('£0', leftend, -55);
    cgfont ('Helvetica', 26);
    cgtext ('(No penalty - leave all of A''s', leftend, -95);
    cgtext ('money)', leftend, -130);
    cgfont ('Helvetica', 38);
    if isempty(controlA) == 1
        cgtext (strcat('£',num2str(sprintf('%.0f',playerA))), rightend, -55);
    else
        cgtext (strcat('£',num2str(sprintf('%.1f',playerA))), rightend, -55);
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
    
    cgmakesprite(12,1280,1024,0,0,0);
    cgsetsprite(12);
    cgpencol(1,1,1);
    loadpict('Player.bmp',12,-200,-100);                                    
    cgtext('Player A',-200,-230);
    loadpict('Player.bmp',12,200,-100);                                     
    cgtext('Player B',200,-230);
    cgpencol(1,1,0);
    if isempty(controlA) == 1
        cgtext(strcat('£',num2str(sprintf('%.0f',playerA))),-200,30);
        cgtext(strcat('£',num2str(sprintf('%.0f',playerB))),200,30);
    else
        cgtext(strcat('£',num2str(sprintf('%.1f',playerA))),-200,30);
        cgtext(strcat('£',num2str(sprintf('%.1f',playerB))),200,30);
    end;
    
    map = getmousemap;
    clearmouse;
    x = 0;
    y = 0;
    d = 0;
    while 1
        cgsetsprite (10);                % ready whole ratingsprite to draw into
        cgdrawsprite (8, 0, 0);         % draw ratingscale
        if d == 1
            cgdrawsprite (9,xpos,0);    % draw ratingarrow
        end;
        cgsetsprite(11);
        cgdrawsprite(12,0,0);
        cgdrawsprite (10, 0, 230, VASwidth, VASheight);     % draw ratingsprite onto offscreen
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
     
        if ~isempty(b1mouse) && any(b1mouse == 128) && (x >= -360 && x <= 360) && (y >= 200 && y <= 245)
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
    
%% Screen Question 2
      xpos = randi([-60 60]);               %starting x pos of arrow

      cgmakesprite (25, 1280, 100, 0, 0, 0);
      cgsetsprite(25);
      cgpencol(1,1,1);
      cgtext('How does your decision make you feel?',0,0);
 
      cgmakesprite (21, 15, 15, 0, 0, 0);               %make arrowsprite
      cgsetsprite (21);
      cgpencol (1, 0, 0);                     %white arrow
      %cgpolygon ([-0.5 0 0.5]*arrowwidth, [-0.5 0.5 -0.5].*arrowheight);
      cgellipse(0,0,15,15,'f')
      cgpencol (1, 1, 1);
      cgsetsprite (0);
         
      cgmakesprite (22, VASwidth, VASheight, 1, 1, 1);    %make black full ratesprite for later use
 
      cgmakesprite(23,1280,1024,0,0,0);                                               % black empty sprite
      
      cgmakesprite(24,1280,1024,0,0,0);                                               % black empty sprite
 
      clearmouse;
      x = 0;
      y = 0;
      d = 0;   
      while 1
          cgsetsprite (22);                % ready whole ratingsprite to draw into
          cgdrawsprite (20, 0, 0);         % draw ratingscale
          if d == 1
            cgdrawsprite (21,xpos,0);    % draw ratingarrow
          end;
          cgsetsprite(23);
          cgdrawsprite(24,0,0);
          cgdrawsprite (22, 0, -65, VASwidth, VASheight);     % draw ratingsprite onto offscreen
          cgdrawsprite (25, 0, 65);
          cgdrawsprite(13,x,y);
          cgsetsprite (0);
          cgdrawsprite(23,0,0);
          cgflip (0,0,0);            % show offscreen (black background)
          
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

          if ~isempty(b1mouse) && any(b1mouse == 128) && (x >= -360 && x <= 360) && (y >= -95 && y <= -50)
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
              break;
           end;
       end;
       
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
end;

%% Screen end of intro 2
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

stop_cogent;
end
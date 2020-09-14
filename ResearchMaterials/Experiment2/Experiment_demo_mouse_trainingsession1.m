function Experiment_demo_mouse_trainingsession1(subjectNo)
%% Third Party Dictator Game Script Ver 0.3

%% Configure Cogent
config_display(0, 4, [0 0 0], [1 1 1], 'Helvetica', 38, 28, 0);             % Configure display (window mode, resolution, black background, white foreground, fontname, fontsize, nbuffers, direct mode)
config_keyboard;                                                            % Configure keyboard (non-exclusive mode)
config_mouse(10);

%% Variables
endsplit = [10 10 ; 2.5 7.5];

countrow = 1;
countrow2 = 1;
countrow3 = 1;

i=1;                                                                            % Trial Counter between blocks
j=1;                                                                            % Block Counter
l=1;                                                                          % Trial counter within blocks

%% Experiment
start_cogent;

map = getmousemap;

cgmakesprite (23, 10, 10, 0, 0, 0);                                             % sprite mouse cursor
cgsetsprite (23);
cgpencol (1, 1, 1);                     
cgpolygon ([-0.5 0 0.5]*15, [-0.5 0.5 -0.5].*15);

cgmakesprite(24,1280,1024,0,0,0);                                               % sprite connect to server button
cgsetsprite(24);
cgtext('You will now play 2 training trials.',0,50);
cgtext('Press any mouse button to proceed.',0,-50);

cgmakesprite(25,1280,1024,0,0,0);                                               % black empty sprite

cgmakesprite(28,1280,1024,0,0,0);                                               % black empty sprite

clearmouse;

cgsetsprite(0);
cgdrawsprite(24,0,0);
cgflip(0,0,0);
waitmouse;

%% Start Task
for i = i:2                                                             % Loop Trials task
%% Define level of endowment for player B
    endowment=endsplit(1,l);                                             % choose random initial endowment    
    DATA.datatraining1{l,1} = subjectNo;
    DATA.datatraining1{l,2} = j;
    DATA.datatraining1{l,3} = i;
    DATA.datatraining1{l,4} = endsplit(1,l);
%% SCREEN 1 Fixation Cross Screen
    cgmakesprite(1,1280,1024,0,0,0);
    cgsetsprite(1);
    cgpencol(1,1,1);
    cgtext('+',0,0);
    cgsetsprite(0);
    cgdrawsprite(1,0,0);
    cgflip;
    wait(500);

%% SCREEN 2: Display member of game (experimenter, player A, and player B)
% and initial endowment for player B
    cgmakesprite(2,1280,1024,0,0,0);
    cgsetsprite(2);
    loadpict('Experimenter.bmp',2,0,200);                                       
    cgpencol(1,0,0);
    cgtext('Experimenter',0,70);
    loadpict('Player.bmp',2,-200,-180);                                         
    cgpencol(1,1,1);
    cgtext('Player B',-200,-310);
    loadpict('Player.bmp',2,200,-180);                                          
    cgtext('Player A',200,-310);
    cgpencol(1,1,0);
    cgtext(strcat('£', num2str(endowment)),150,0);
    cgsetsprite(0);
    cgdrawsprite(2,0,0);
    cgflip;
    wait(3000);

%% SCREEN 3 player A decides how to split endowment
    cgmakesprite(4,1280,1024,0,0,0);
    cgsetsprite(4);
    cgpencol(1,1,1);
    %cgtext('Player A decides how much to take from Player B',0,360);
    loadpict('Player.bmp',4,-200,0);                                         % Load stick-figure experimenter
    cgtext('Player B',-200,-150);
    cgtext('-',-200,150);
    loadpict('Player.bmp',4,200,0);                                          % Load stick-figure experimenter
    cgtext('Player A',200,-150);
    cgpencol(1,1,0);
    cgtext(strcat('£',num2str(endowment)),200,150);
    cgsetsprite(0);
    cgdrawsprite(4,0,0);
    cgflip;
    o = randi([1000 6000]);
    wait(o);
    DATA.datatraining1{l,5} = o;

%% Define level of split between player A and B
    playerA=(endowment/10)*endsplit(2,l);                            % choose random split for player A
    strplayerA=num2str(playerA,'%32.16g');
    controlA=length(strplayerA)-find(strplayerA=='.');    
    playerB=endowment-playerA;                                              % choose random split for player B
    strplayerB=num2str(playerB,'%32.16g');
    controlB=length(strplayerB)-find(strplayerB=='.');    
    DATA.datatraining1{l,6} = endsplit(2,l);
    
%% SCREEN 4 information about different amounts of endowment between players
    cgmakesprite(6,1280,1024,0,0,0);
    cgsetsprite(6);
    if isempty(controlA) == 1
        %cgpencol(1,1,1);
        %cgtext(strcat('Player A decided to take ?',num2str(sprintf('%.0f',playerA)),' from B'),0,360);
        %cgtext(strcat('so player B is left with ?',num2str(sprintf('%.0f',playerB))),0,320);
        cgpencol(1,1,0);
        cgtext(strcat('£',num2str(sprintf('%.0f',playerA))),-200,150);
        cgtext(strcat('£',num2str(sprintf('%.0f',playerB))),200,150);
        cgpencol(1,1,1);
    else
        %cgpencol(1,1,1);
        %cgtext(strcat('Player A decided to take ?',num2str(sprintf('%.1f',playerA)),' from B'),0,360);
        %cgtext(strcat('so player B is left with ?',num2str(sprintf('%.1f',playerB))),0,320);
        cgpencol(1,1,0);
        cgtext(strcat('£',num2str(sprintf('%.1f',playerA))),-200,150);
        cgtext(strcat('£',num2str(sprintf('%.1f',playerB))),200,150);
        cgpencol(1,1,1);
    end;    
    loadpict('Player.bmp',6,-200,0);                                         % Load stick-figure experimenter
    cgtext('Player B',-200,-150);
    loadpict('Player.bmp',6,200,0);                                          % Load stick-figure experimenter
    cgtext('Player A',200,-150);
    cgsetsprite(0);
    cgdrawsprite(6,0,0);
    cgflip;
    wait(3000);    

%% Screen split and feeling Q 1
    VASwidth=1280;                                                          % width sprite scales
    VASheight=320;                                                          % height sprite scales
    arrowwidth=20;                                                          % width sprite scale arrow
    arrowheight=20;                                                         % heigth sprite scale arrow
    leftend = -350;                                                         % left end (x-value) scale
    rightend = 350;                                                         % right end (x-value) scale
    xpos = randi([-60 60]);                                                 % random starting x pos of scale arrow (jittering between x = -60 and x = 60)

    cgmakesprite(3,1280,1024,0,0,0);
    cgsetsprite(3);
    cgpencol(1,1,1);
    loadpict('Player.bmp',3,-200,-100);                                    
    cgtext('Player B',-200,-230);
    loadpict('Player.bmp',3,200,-100);                                     
    cgtext('Player A',200,-230);
    cgpencol(1,1,0);
    if isempty(controlA) == 1
        cgtext(strcat('£',num2str(sprintf('%.0f',playerA))),-200,30);
        cgtext(strcat('£',num2str(sprintf('%.0f',playerB))),200,30);
    else
        cgtext(strcat('£',num2str(sprintf('%.1f',playerA))),-200,30);
        cgtext(strcat('£',num2str(sprintf('%.1f',playerB))),200,30);
    end;

    negtopos = -350;
    postoneg = 350;

    cgmakesprite (9, 1280, 100, 0, 0, 0);                               % sprite question as headline
    cgsetsprite(9);
    cgpencol(1,1,1);
    cgtext('How does Player A''s decision make you feel?',0,0);

    cgmakesprite (4, VASwidth, VASheight, 0, 0, 0);                     % sprite feeling scale  
    cgsetsprite (4);                        
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

    cgmakesprite (5, 15, 15, 0, 0, 0);               	% sprite scale arrow
    cgsetsprite (5);
    cgpencol (1, 0, 0);                     %white arrow
    %cgpolygon ([-0.5 0 0.5]*arrowwidth, [-0.5 0.5 -0.5].*arrowheight);
    cgellipse(0,0,15,15,'f')
    cgpencol (1, 1, 1);
    cgsetsprite (0);

    cgmakesprite (6, VASwidth, VASheight, 1, 1, 1);                     % sprite to draw scale and scale arrow into

    countkey = 0;
    DATA.data3training1{countrow,1} = subjectNo;
    DATA.data3training1{countrow,2} = j;
    DATA.data3training1{countrow,3} = i;
    DATA.data3training1{countrow,4} = 1;
    DATA.data3training1{countrow,5} = countkey;
    DATA.data3training1{countrow,6} = 0;
    DATA.data3training1{countrow,7} = 0;
    DATA.data3training1{countrow,8} = 0;
    DATA.data3training1{countrow,9} = 0;    
    
    clearmouse;                                                        
    x = 0;                                                              
    y = 0;
    t0 = time;                                                          % catch start time
    m = 0;
    d = 0;
    while 1
        cgsetsprite (6);                                                % ready whole ratingsprite to draw into
        cgdrawsprite (4, 0, 0);                                         % draw ratingscale
        if d == 1
            cgdrawsprite (5,xpos,0);    % draw ratingarrow
        end                                    % draw ratingarrow
        cgsetsprite(25);                                                % whole sprite to draw into
        cgdrawsprite(3,0,0);                                            % draw distribution between two player
        cgdrawsprite (6, 0, 230, VASwidth, VASheight);                  % draw whole ratingsprite
        cgdrawsprite (9, 0, 360);                                       % draw headline
        cgdrawsprite(23,x,y);                                           % draw mouse cursor
        cgsetsprite (0);                                                % set sprite 0
        cgdrawsprite(25,0,0);                                           % draw whole sprite on sprite 0
        cgflip (0,0,0);                                                 % presenting scale
        t3 = time;

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

        %xmouse=getmouse(map.X);
        %ymouse=getmouse(map.Y);
        b1mouse=getmouse(map.Button1);
        b2mouse=getmouse(map.Button2);

        if ~isempty(b1mouse) && any(b1mouse == 128) && (x >= -360 && x <= 360) && (y >= 200 && y <= 245)
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
            countrow = countrow + 1;
            countkey = countkey + 1;
            DATA.data3training1{countrow,1} = subjectNo;
            DATA.data3training1{countrow,2} = j;
            DATA.data3training1{countrow,3} = i;
            DATA.data3training1{countrow,4} = 1;
            DATA.data3training1{countrow,5} = countkey;
            DATA.data3training1{countrow,6} = strcat('b1: ',num2str(b1mouse));
            DATA.data3training1{countrow,7} = xpos;
            DATA.data3training1{countrow,8} = xpos*(3/rightend);
            DATA.data3training1{countrow,9} = t1-t0;            

        elseif ~isempty(b2mouse) && any(b2mouse == 128) && d == 1
           t2 = time;
           countrow = countrow + 1;
           countkey = countkey + 1;
           DATA.datatraining1{countrow,1} = subjectNo;
           DATA.datatraining1{countrow,2} = j;
           DATA.datatraining1{countrow,3} = i;
           DATA.datatraining1{countrow,4} = 1;
           DATA.datatraining1{countrow,5} = countkey;
           DATA.datatraining1{countrow,6} = strcat('b2: ',num2str(b2mouse));
           DATA.datatraining1{countrow,7} = xpos;
           DATA.datatraining1{countrow,8} = xpos*(3/rightend);
           DATA.datatraining1{countrow,9} = t2-t0;
           break;
        end;

        if (((t3-t0)/1000) >= 10.01) && (m < 1) 
            m=1;
            cgmakesprite(35,1280,1024,0,0,0);
            cgsetsprite(35);
            cgpencol(1,1,1);
            cgtext('Please confirm your decision by pressing',0,25);
            cgtext('the RIGHT mouse button.',0,-25);
            cgsetsprite(0);
            cgdrawsprite(35,0,0);
            cgflip;
            wait(3000);                
        end
    end
    rt = ((t2-t0)/1000);
    feelingrate1 = xpos*(3/rightend);                                   % Collect information feelingrate 1 
    DATA.datatraining1{l,7} = feelingrate1;
    DATA.datatraining1{l,8} = rt;
    countrow = countrow + 1;    
    
%% Screen split and penalize player A
 
    DATA.datatraining1{l,9} = 9999;
    DATA.datatraining1{l,10} = 9999;
    countrow2 = countrow2 + 1;
    DATA.datatraining1{l,11} = 9999;
    DATA.datatraining1{l,12} = 9999;
   
    file = sprintf('sub%s_Training1_DATA.mat',subjectNo);
    save(file,'DATA');    
        
    l = l+1;
end;                                                                        % End Loop Trials

%% Screen end of block
cgmakesprite(8,1280,1024,0,0 ,0);
cgsetsprite(8); 
cgpencol(1,1,1);
cgtext('End of training session.',0,50);
cgtext('If you have any questions please ask the experimenter.',0,0);
cgtext('Press any mouse button to proceed to connect to online service.',0,-50);
cgsetsprite(25);
cgdrawsprite(8,0,0);
cgsetsprite(0);
cgdrawsprite(25,0,0);
cgflip(0,0,0);
waitmouse;

stop_cogent;
end
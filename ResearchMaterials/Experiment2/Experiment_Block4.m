%% Third Party Dictator Game Script Ver 0.3

clc                                                                         % Clear workspace
clear all                                                                   % Clear variables

%% Configure Cogent
config_display(0, 4, [0 0 0], [1 1 1], 'Helvetica', 38, 28, 0);             % Configure display (window mode, resolution, black background, white foreground, fontname, fontsize, nbuffers, direct mode)
config_keyboard;                                                            % Configure keyboard (non-exclusive mode)
config_mouse(10);

rng('shuffle');

%% Variables
DATA.subjectNo = input('Subject number? ','s');

intro4();
connect();

endow = repmat(1:15,[1,4]);
split = [0 0 0 0 0 0 1 1 1 1 1 1 2 2 2 2 2 2 3 3 3 3 3 3 4 4 4 4 4 4 5 5 5 5 5 5 6 6 6 6 6 6 7 7 7 7 7 7 8 8 8 8 8 8 9 9 9 9 9 9];
endsplit(1,:) = endow(randperm(60));
endsplit(2,:) = split(randperm(60));

countrow = 1;
countrow2 = 1;
countrow3 = 1;

i=181;                                                                            % Trial Counter between blocks
j=4;                                                                            % Block Counter
l=1;                                                                          % Trial counter within blocks

%% Experiment
start_cogent;
map = getmousemap;
x = 0;
y = 0;

cgmakesprite (23, 10, 10, 0, 0, 0);                                             % sprite mouse cursor
cgsetsprite (23);
cgpencol (1, 1, 1);                     
cgpolygon ([-0.5 0 0.5]*15, [-0.5 0.5 -0.5].*15);

cgmakesprite(28,1280,1024,0,0,0);                                               % black empty sprite

%% Screen Countdown
cgpencol(1,1,1);
preparestring('3', 1);                                                          % Prepare Buffer 1 for countdown with string '1'
preparestring('2', 2);                                                          % Prepare Buffer 2 for countdown with string '2'
preparestring('1', 3);                                                          % Prepare Buffer 3 for countdown with string '3'
preparestring('go', 4);                                                         % Prepare Buffer 4 for countdown with string 'go'

drawpict(1);                                                                    % Present Buffer 1
wait(700);                                                                      % wait 700 ms
drawpict(2);                                                                    % Present Buffer 2
wait(700);                                                                      % wait 700 ms
drawpict(3);                                                                    % Present Buffer 3
wait(700);                                                                      % wait 700 ms
drawpict(4);                                                                    % Present Buffer 4
wait(700);                                                                      % wait 700 ms

clearpict(1);                                                                   % Clear Buffer 1
clearpict(2);                                                                   % Clear Buffer 2
clearpict(3);                                                                   % Clear Buffer 3
clearpict(4);                                                                   % Clear Buffer 4

%% Start Task
for i = i:240                                                             % Loop Trials task
    
    DATA.data{l,1} = DATA.subjectNo;
    DATA.data{l,2} = j;                                                              % Collect information block
    DATA.data{l,3} = i;                                                              % Collect information trial

%% Define level of endowment for player B    
    endowment=endsplit(1,l);                                             % choose random initial endowment    
    DATA.data{l,4}=endsplit(1,l);                                             % save random initial endowment 
 
%% Fixation Cross Screen
    cgmakesprite(1,1280,1024,0,0,0);
    cgsetsprite(1);
    cgpencol(1,1,1);
    cgtext('+',0,0);
    cgsetsprite(0);
    cgdrawsprite(1,0,0);
    cgflip;
    wait(500);

%% Screen 1: Display member of game (experimenter, player A, and player B)
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

%% Screen player A decides how to split endowment
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
    o = randi([2000 5000]);
    wait(o);
    DATA.data{l,5}=o;

%% Define level of split between player A and B
    playerA=(endowment/10)*endsplit(2,l);                            % choose random split for player A
    strplayerA=num2str(playerA,'%32.16g');
    controlA=length(strplayerA)-find(strplayerA=='.');     
    playerB=endowment-playerA;                                              % choose random split for player B
    strplayerB=num2str(playerB,'%32.16g');
    controlB=length(strplayerB)-find(strplayerB=='.');    
    DATA.data{l,6}=endsplit(2,l);                                         % save random split

%% Screen information about different amounts of endowment between players
    cgmakesprite(6,1280,1024,0,0,0);
    cgsetsprite(6);
    if isempty(controlA) == 1
%         cgpencol(1,1,1);
%         cgtext(strcat('Player A decided to take £',num2str(sprintf('%.0f',playerA)),' from B'),0,360);
%         cgtext(strcat('so player B is left with £',num2str(sprintf('%.0f',playerB))),0,320);
        cgpencol(1,1,0);
        cgtext(strcat('£',num2str(sprintf('%.0f',playerA))),-200,150);
        cgtext(strcat('£',num2str(sprintf('%.0f',playerB))),200,150);
        cgpencol(1,1,1);
    else
%         cgpencol(1,1,1);
%         cgtext(strcat('Player A decided to take £',num2str(sprintf('%.1f',playerA)),' from B'),0,360);
%         cgtext(strcat('so player B is left with £',num2str(sprintf('%.1f',playerB))),0,320);
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
    wait(1000);

%% Feelings 1
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
    
        DATA.data{l,7} = 9999;
        DATA.data{l,8} = 9999;
    
%% Screen 3: Penalize Player A
    xpos = randi([-60 60]);               %starting x pos of arrow

    cgmakesprite (10, 1280, 100, 0, 0, 0);
    cgsetsprite(10);
    cgpencol(1,1,1);
    cgtext('By how much would you like to penalize Player A?',0,0);

    cgmakesprite (7, VASwidth, VASheight, 0, 0, 0);    %make black ratesprite       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    cgsetsprite (7);                        %ready sprite to draw into
    cgalign ('c', 'c');                     %center alignment
    cgpencol (1, 1, 1);                     %white on black background
    cgrect (0, 0, rightend-leftend, 4);                  %draw horizontal line
    cgrect (leftend, 0, 4, 15);                %draw left major tick
    cgrect (rightend, 0, 4, 15);                 %draw right major tick
    %cgrect (leftend+rightend, 0, 2, 15);
    cgtext ('£0', leftend, -55);
    cgfont ('Helvetica', 26);
    cgtext ('No penalty', leftend, -95);
    cgfont ('Helvetica', 38);    
    if isempty(controlA) == 1
        cgtext (strcat('£',num2str(sprintf('%.0f',playerB))), rightend, -55);
    else
        cgtext (strcat('£',num2str(sprintf('%.1f',playerB))), rightend, -55);
    end;
    cgfont ('Helvetica', 26);
    cgtext ('Penalize by', rightend, -95);
    cgtext ('maximum amount', rightend, -130); 
    cgfont ('Helvetica', 38);    
    
    cgmakesprite (5, 15, 15, 0, 0, 0);               %make arrowsprite       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    cgsetsprite (5);
    cgpencol (1, 0, 0);                     %white arrow
    %cgpolygon ([-0.5 0 0.5]*arrowwidth, [-0.5 0.5 -0.5].*arrowheight);
    cgellipse(0,0,15,15,'f')
    cgpencol (1, 1, 1);
    cgsetsprite (0);
    
    cgmakesprite (6, VASwidth, VASheight, 1, 1, 1);    %make black full ratesprite for later use       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    countkey = 0;
    DATA.data3{countrow2,1} = DATA.subjectNo;
    DATA.data3{countrow2,2} = j;
    DATA.data3{countrow2,3} = i;
    DATA.data3{countrow2,4} = 2;
    DATA.data3{countrow2,5} = countkey;
    DATA.data3{countrow2,6} = 0;
    DATA.data3{countrow2,7} = 0;
    DATA.data3{countrow2,8} = 0;
    DATA.data3{countrow2,9} = 0;

    clearmouse;
    x = 0;
    y = 0;
    t0 = time;
    m = 0;
    d = 0;
    while 1
        cgsetsprite (6);                % ready whole ratingsprite to draw into
        cgdrawsprite (7, 0, 0);         % draw ratingscale
        if d == 1
            cgdrawsprite (5,xpos,0);    % draw ratingarrow
        end
        cgsetsprite(25);
        cgdrawsprite(3,0,0);
        cgdrawsprite (6, 0, 230, VASwidth, VASheight);     % draw ratingsprite onto offscreen
        cgdrawsprite (10, 0, 360);
        cgdrawsprite(23,x,y);
        cgsetsprite (0);
        cgdrawsprite(25,0,0);          
        cgflip (0,0,0);
        t3 = time;
        
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
        
        xmouse=getmouse(map.X);
        ymouse=getmouse(map.Y);
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
            countrow2 = countrow2 + 1;
            countkey = countkey + 1;
            DATA.data3{countrow2,1} = DATA.subjectNo;
            DATA.data3{countrow2,2} = j;
            DATA.data3{countrow2,3} = i;
            DATA.data3{countrow2,4} = 2;
            DATA.data3{countrow2,5} = countkey;
            DATA.data3{countrow2,6} = strcat('b1: ',num2str(b1mouse));
            DATA.data3{countrow2,7} = xpos;
            DATA.data3{countrow2,8} = (rightend+xpos)*((playerA/2)/rightend);
            DATA.data3{countrow2,9} = t1-t0;
            
        elseif ~isempty(b2mouse) && any(b2mouse == 128) && d == 1
           t2 = time;
           countrow2 = countrow2 + 1;
           countkey = countkey + 1;
           DATA.data3{countrow2,1} = DATA.subjectNo;
           DATA.data3{countrow2,2} = j;
           DATA.data3{countrow2,3} = i;
           DATA.data3{countrow2,4} = 2;
           DATA.data3{countrow2,5} = countkey;
           DATA.data3{countrow2,6} = strcat('b2: ',num2str(b2mouse));
           DATA.data3{countrow2,7} = xpos;
           DATA.data3{countrow2,8} = (rightend+xpos)*((playerA/2)/rightend);
           DATA.data3{countrow2,9} = t2-t0;
           break;
        end;
        
%         if (((t3-t0)/1000) >= 10.01) && (m < 1)
%             m=1;
%             cgmakesprite(35,1280,1024,0,0,0);
%             cgsetsprite(35);
%             cgpencol(1,1,1);
%             cgtext('Please confirm your decision by pressing',0,25);
%             cgtext('the RIGHT mouse button.',0,-25);
%             cgsetsprite(0);
%             cgdrawsprite(35,0,0);
%             cgflip;
%             wait(3000);
%         end;
        n=1;
    end;
    
    if n == 0                                                           % Reactiontime Decision Feelingquestion
        rt = 9999;
        countrow2 = countrow2 + 1;
        DATA.data3{countrow2,1} = DATA.subjectNo;
        DATA.data3{countrow2,2} = j;
        DATA.data3{countrow2,3} = i;
        DATA.data3{countrow2,4} = 2;
        DATA.data3{countrow2,5} = 9999;
        DATA.data3{countrow2,6} = 9999;
        DATA.data3{countrow2,7} = xpos;
        DATA.data3{countrow2,8} = (rightend+xpos)*((playerA/2)/rightend);
        DATA.data3{countrow2,9} = 9999;
    else
        rt = ((t2-t0)/1000);
    end;
        
    investment = (rightend+xpos)*((playerB/2)/rightend);
    strinvestment = num2str(investment,'%32.16g');
    control = length(strinvestment)-find(strinvestment=='.');    
    DATA.data{l,9} = investment;
    DATA.data{l,10} = rt;
    countrow2 = countrow2 + 1;

%% Screen 4: For block 2 and 4 ask participants explicit feelings about own decision
    xpos = randi([-60 60]);               %starting x pos of arrow
    if j == 2 || j == 4
        cgmakesprite (11, 1280, 100, 0, 0, 0);
        cgsetsprite(11);
        cgpencol(1,1,1);
        cgtext('How does your decision make you feel?',0,0);
        
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
        
        cgmakesprite (5, 15, 15, 0, 0, 0);               %make arrowsprite
        cgsetsprite (5);
        cgpencol (1, 0, 0);                     %white arrow
        %cgpolygon ([-0.5 0 0.5]*arrowwidth, [-0.5 0.5 -0.5].*arrowheight);
        cgellipse(0,0,15,15,'f')
        cgpencol (1, 1, 1);
        cgsetsprite (0);
        
        cgmakesprite (6, VASwidth, VASheight, 1, 1, 1);    %make black full ratesprite for later use

        countkey = 0;
        DATA.data4{countrow3,1} = DATA.subjectNo;
        DATA.data4{countrow3,2} = j;
        DATA.data4{countrow3,3} = i;
        DATA.data4{countrow3,4} = 3;
        DATA.data4{countrow3,5} = countkey;
        DATA.data4{countrow3,6} = 0;
        DATA.data4{countrow3,7} = 0;
        DATA.data4{countrow3,8} = 0; %initial position cursor block 2
        DATA.data4{countrow3,9} = 0;

        clearmouse;
        x = 0;
        y = 0;
        t0 = time;
        m = 0;
        d = 0;
        while 1
            cgsetsprite (6);                % ready whole ratingsprite to draw into
            cgdrawsprite (4, 0, 0);         % draw ratingscale
            if d == 1
                cgdrawsprite (5,xpos,0);    % draw ratingarrow
            end
            cgsetsprite(25);
            cgdrawsprite(28,0,0);
            cgdrawsprite (6, 0, -65, VASwidth, VASheight);     % draw ratingsprite onto offscreen
            cgdrawsprite (11, 0, 65);
            cgdrawsprite(23,x,y);
            cgsetsprite (0);
            cgdrawsprite(25,0,0);
            cgflip (0,0,0);            % show offscreen (black background)
            t3 = time;
            
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

            xmouse=getmouse(map.X);
            ymouse=getmouse(map.Y);
            b1mouse=getmouse(map.Button1);
            b2mouse=getmouse(map.Button2);

            if ~isempty(b1mouse) && any(b1mouse == 128) && (x >= -360 && x <= 360) && (y >= -95 && y <= -50)
                t1 = time;
                xpos = x;
                if (x == -360) || (x == -359) || (x == -358) || (x == -357) || (x == -356) || (x == -355) || (x == -354) || (x == -353) || (x == -352) || (x == -351) || (x == -350) || (x == -349) || (x == -348) || (x == -347)
                    xpos = -350;
                elseif (x == 360) || (x == 359) || (x == 358) || (x == 357) || (x == 356) || (x == 355) || (x == 354) || (x == 353) || (x == 352) || (x == 351) || (x == 350) || (x == 349) || (x == 348) || (x == 347)
                    xpos = 350;
                elseif (x == -5) || (x == -4) || (x == -3) || (x == -2) || (x == -1) || (x == 0) || (x == 1) || (x == 2) || (x == 3) || (x == 4) || (x == 5)
                    xpos = 0;
                end;
                d = 1;
                countrow3 = countrow3 + 1;
                countkey = countkey + 1;
                DATA.data4{countrow3,1} = DATA.subjectNo;
                DATA.data4{countrow3,2} = j;
                DATA.data4{countrow3,3} = i;
                DATA.data4{countrow3,4} = 3;
                DATA.data4{countrow3,5} = countkey;
                DATA.data4{countrow3,6} = strcat('b1: ',num2str(b1mouse));
                DATA.data4{countrow3,7} = xpos;
                DATA.data4{countrow3,8} = xpos*(3/rightend);
                DATA.data4{countrow3,9} = t1-t0;

            elseif ~isempty(b2mouse) && any(b2mouse == 128) && d == 1
               t2 = time;
               countrow3 = countrow3 + 1;
               countkey = countkey + 1;
               DATA.data4{countrow3,1} = DATA.subjectNo;
               DATA.data4{countrow3,2} = j;
               DATA.data4{countrow3,3} = i;
               DATA.data4{countrow3,4} = 3;
               DATA.data4{countrow3,5} = countkey;
               DATA.data4{countrow3,6} = strcat('b2: ',num2str(b2mouse));
               DATA.data4{countrow3,7} = xpos;
               DATA.data4{countrow3,8} = xpos*(3/rightend);
               DATA.data4{countrow3,9} = t2-t0;
               break;
            end;
                                   
%             if (((t3-t0)/1000) >= 10.01) && (m < 1)
%                 m=1;
%                 cgmakesprite(35,1280,1024,0,0,0);
%                 cgsetsprite(35);
%                 cgpencol(1,1,1);
%                 cgtext('Please confirm your decision by pressing',0,25);
%                 cgtext('the RIGHT mouse button.',0,-25);
%                 cgsetsprite(0);
%                 cgdrawsprite(35,0,0);
%                 cgflip;
%                 wait(3000);
%             end;
            n=1;
        end;
        
        if n == 0                                                           % Reactiontime Decision Feelingquestion 2
            rt = 9999;
            countrow3 = countrow3 + 1;
            DATA.data4{countrow3,1} = DATA.subjectNo;
            DATA.data4{countrow3,2} = j;
            DATA.data4{countrow3,3} = i;
            DATA.data4{countrow3,4} = 3;
            DATA.data4{countrow3,5} = 9999;
            DATA.data4{countrow3,6} = 9999;
            DATA.data4{countrow3,7} = xpos;
            DATA.data4{countrow3,8} = xpos*(3/rightend);
            DATA.data4{countrow3,9} = 9999;            
        else
            rt = ((t2-t0)/1000);
        end;        
        
        feelingrate2 = xpos*(3/rightend);
        DATA.data{l,11} = feelingrate2;
        DATA.data{l,12} = rt;
        countrow3 = countrow3 + 1;
        
    else
        DATA.data{l,11} = 9999;
        DATA.data{l,12} = 9999;
    end;
    
    file = sprintf('sub%s_S4_DATA.mat',DATA.subjectNo);
    save(file,'DATA');
   
    l = l+1;
end;                                                                        % End Loop Trials

%% Screen end of block
cgmakesprite(8,1280,1024,0,0 ,0);
cgsetsprite(8); 
cgpencol(1,1,1);
cgtext('End of Session 4',0,50);
cgtext('End of Experiment',0,0);
cgtext('Please inform the experimenter',0,-50);
cgsetsprite(25);
cgdrawsprite(8,0,0);
cgsetsprite(0);
cgdrawsprite(25,0,0);
cgflip(0,0,0);
waitkeydown(inf,71);

stop_cogent;
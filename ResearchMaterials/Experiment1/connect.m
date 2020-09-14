function connect()
%% Third Party Dictator Game Script Ver 0.3

%% Configure Cogent
config_display(0, 4, [0 0 0], [1 1 1], 'Helvetica', 38, 28, 0);             % Configure display (window mode, resolution, black background, white foreground, fontname, fontsize, nbuffers, direct mode)
config_keyboard;                                                            % Configure keyboard (non-exclusive mode)
config_mouse(10);

%% Experiment
start_cogent;

map = getmousemap;
x = 0;
y = 0;

cgmakesprite (23, 10, 10, 0, 0, 0);                                             % sprite mouse cursor
cgsetsprite (23);
cgpencol (1, 1, 1);                     
cgpolygon ([-0.5 0 0.5]*15, [-0.5 0.5 -0.5].*15);

cgmakesprite(24,1280,1024,0,0,0);                                               % sprite connect to server button
cgsetsprite(24);
cgtext('Please press connect button to connect to online service',0,360);
loadpict('connect_button.bmp',24,0,0);

cgmakesprite(25,1280,1024,0,0,0);                                               % black empty sprite

cgmakesprite(26,175,80,0,0,0);                                                  % sprite start task button
cgsetsprite(26);
loadpict('start_button.bmp',26,0,0);

cgmakesprite(28,1280,1024,0,0,0);                                               % black empty sprite


%% Start Screen
clearmouse;

while 1                                                                         % screen connect to server
    cgsetsprite(25);
    cgdrawsprite(24,0,0);
    cgdrawsprite(23,x,y);
    cgsetsprite(0);
    cgdrawsprite(25,0,0);
	cgflip(0,0,0);

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
    
    if ~isempty(getmouse(map.Button1)) && any(getmouse(map.Button1) == 128) ... 
        && (x >= -100 && x <= 100) && (y >= -50 && y <= 50)
        break;
    end;
end;

%% Connect Screen
dotwidth = 15;
dotheight = 15;

cgmakesprite(21,300,200,0,0,0);                                                 % status internet connection and availability games I
cgsetsprite(21);
cgfont('Helvetica',20);
cgtext('Status: ...',0,80);
cgtext('Games: ...',0,55);

cgmakesprite(12,1280,1024,0,0,0)                                                % screen server connection
cgsetsprite(12);
loadpict('connect.bmp',12,0,50);
cgpencol(1,1,1);
cgellipse(-135,-80,dotwidth,dotheight);
cgellipse(-90,-80,dotwidth,dotheight);
cgellipse(-45,-80,dotwidth,dotheight);
cgellipse(0,-80,dotwidth,dotheight);
cgellipse(135,-80,dotwidth,dotheight);
cgellipse(90,-80,dotwidth,dotheight);
cgellipse(45,-80,dotwidth,dotheight);
cgsetsprite(0);
cgdrawsprite(12,0,0);
cgdrawsprite(21,0,-200);
cgflip(0,0,0);
wait(3000);

cgmakesprite(13,15,15,0,0,0);                                                   % load filled first dot
cgsetsprite(13);
cgpencol(1,1,1);
cgellipse(0,0,dotwidth,dotheight,'f');

cgmakesprite(14,15,15,0,0,0);                                                   % load filled second dot
cgsetsprite(14);
cgpencol(1,1,1);
cgellipse(0,0,dotwidth,dotheight,'f')

cgmakesprite(15,15,15,0,0,0);                                                   % load filled third dot
cgsetsprite(15);
cgpencol(1,1,1);
cgellipse(0,0,dotwidth,dotheight,'f')

cgmakesprite(16,15,15,0,0,0);                                                   % load filled fourth dot
cgsetsprite(16);
cgpencol(1,1,1);
cgellipse(0,0,dotwidth,dotheight,'f')

cgmakesprite(17,15,15,0,0,0);                                                   % load filled fifth dot
cgsetsprite(17);
cgpencol(1,1,1);
cgellipse(0,0,dotwidth,dotheight,'f')

cgmakesprite(18,15,15,0,0,0);                                                   % load filled sixth dot
cgsetsprite(18);
cgpencol(1,1,1);
cgellipse(0,0,dotwidth,dotheight,'f')

cgmakesprite(19,15,15,0,0,0);                                                   % load filled seventh dot
cgsetsprite(19);
cgpencol(1,1,1);
cgellipse(0,0,dotwidth,dotheight,'f')

cgmakesprite(20,300,200,0,0,0);                                                 % status internet connection and availability games III
cgsetsprite(20);
cgfont('Helvetica',20);
cgtext('Status: Online',0,80);
cgtext('Games: Available',0,55);

cgmakesprite(30,800,100,0,0,0);
cgsetsprite(30);
cgfont('Helvetica',38);
cgtext('If you are ready to start please press start button',0,0);

cgmakesprite(22,300,200,0,0,0);                                                 % status internet connection and availability games II
cgsetsprite(22);
cgfont('Helvetica',20);
cgtext('Status: Online',0,80);
cgtext('Games: ...',0,55);

for k = 1:7                                                                     % process connection to server and load games
    if k == 1
        cgsetsprite(0);
        cgdrawsprite(12,0,0)
        cgdrawsprite(13,-135,-80);
        cgdrawsprite(21,0,-200);
        cgflip(0,0,0);
    elseif k == 2
        cgsetsprite(0);
        cgdrawsprite(12,0,0)
        cgdrawsprite(13,-135,-80);
        cgdrawsprite(14,-90,-80);
        cgdrawsprite(21,0,-200);
        cgflip(0,0,0);
    elseif k == 3
        cgsetsprite(0);
        cgdrawsprite(12,0,0)
        cgdrawsprite(13,-135,-80);
        cgdrawsprite(14,-90,-80);
        cgdrawsprite(15,-45,-80);
        cgdrawsprite(21,0,-200);
        cgflip(0,0,0);
    elseif k == 4
        cgsetsprite(0);
        cgdrawsprite(12,0,0)
        cgdrawsprite(13,-135,-80);
        cgdrawsprite(14,-90,-80);
        cgdrawsprite(15,-45,-80);
        cgdrawsprite(16,0,-80);
        cgdrawsprite(22,0,-200);
        cgflip(0,0,0);
    elseif k == 5
        cgsetsprite(0);
        cgdrawsprite(12,0,0)
        cgdrawsprite(13,-135,-80);
        cgdrawsprite(14,-90,-80);
        cgdrawsprite(15,-45,-80);
        cgdrawsprite(16,0,-80);
        cgdrawsprite(17,45,-80);
        cgdrawsprite(22,0,-200);
        cgflip(0,0,0);
    elseif k == 6
        cgsetsprite(0);
        cgdrawsprite(12,0,0)
        cgdrawsprite(13,-135,-80);
        cgdrawsprite(14,-90,-80);
        cgdrawsprite(15,-45,-80);
        cgdrawsprite(16,0,-80);
        cgdrawsprite(17,45,-80);
        cgdrawsprite(18,90,-80);
        cgdrawsprite(22,0,-200);
        cgflip(0,0,0);
    elseif k == 7
        clearmouse;
        x = 0;
        y = 0;
        while 1
            cgsetsprite(25);            
            cgdrawsprite(12,0,0);
            cgdrawsprite(30,0,360);
            cgdrawsprite(13,-135,-80);
            cgdrawsprite(14,-90,-80);
            cgdrawsprite(15,-45,-80);
            cgdrawsprite(16,0,-80);
            cgdrawsprite(17,45,-80);
            cgdrawsprite(18,90,-80);
            cgdrawsprite(19,135,-80);
            cgdrawsprite(20,0,-200);
            cgdrawsprite(26,0,-250);
            cgdrawsprite(23,x,y);
            cgsetsprite(0);
            cgdrawsprite(25,0,0)
            cgflip(0,0,0);
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
    
            if ~isempty(getmouse(map.Button1)) && any(getmouse(map.Button1) ...
               == 128) && (x >= -86 && x <= 86) && (y >= -287 && y <= -213)
                break;
            end;
        end;           
    end;
    
    if k ~= 7
        o = randi([1000 3000]);
        wait(o);
    end;
end;

stop_cogent;
end
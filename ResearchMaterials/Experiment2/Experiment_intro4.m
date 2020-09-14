function Experiment_intro4()
%% Third Party Dictator Game Script Ver 0.3 

%% Configure Cogent
config_display(0, 4, [0 0 0], [1 1 1], 'Helvetica', 38, 28, 0);             % Configure display (window mode, resolution, black background, white foreground, fontname, fontsize, nbuffers, direct mode)
config_keyboard;                                                            % Configure keyboard (non-exclusive mode)
config_mouse(10);

start_cogent;

map = getmousemap;
x = 0;
y = 0;

preparestring('The games will be similar to the second session.',1,0,75);
preparestring('You will watch the games in real time.',1,0,25);
preparestring('After each game you will have the opportunity to penalize A.',1,0,-25);
preparestring('Additionally, you will be asked how you feel about your decision.',1,0,-75);
preparestring('Press any mouse button to proceed to connect to online service',1,0,-360);

drawpict(1);
waitmouse;
clearpict(1);

stop_cogent;
end

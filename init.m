[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
addpath(pathstr);
addpath(genpath(fullfile(pathstr, '../lfui/')));
addpath(genpath(fullfile(pathstr, '../datasets/')));

clear 'pathstr'

init_random_seed();

%%

% Change default figure stuff
set(0,'DefaultFigurePosition',[200, 300, 700, 700])
set(0,'DefaultAxesFontName', 'Courier')
set(0,'DefaultAxesFontSize', 25)
set(0,'DefaultAxesFontWeight','bold')
set(0,'DefaultAxesLineWidth', 2.5)

% dbstop if error
pick_and_place_feedback
pick_and_place_guidance


%% save plots
% [pathstr, ~, ~] = fileparts(mfilename('fullpath'));
% plotFolder = fullfile(pathstr, 'plot');
% if ~exist(plotFolder, 'dir')
%    mkdir(plotFolder)
% end
% 
% plotFormats = {'png', 'eps'};
% 
% plotFilenames = {'pick_and_place_feedback', 'pick_and_place_guidance'};
% 
% save_all_images(plotFolder, plotFormats, plotFilenames)
% close all
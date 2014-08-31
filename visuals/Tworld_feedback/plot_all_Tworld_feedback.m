Tworld_feedback
Tworld_feedback_right_left
Tworld_feedback_up_down


%% save plots
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
plotFolder = fullfile(pathstr, 'plot');
if ~exist(plotFolder, 'dir')
   mkdir(plotFolder)
end

plotFormats = {'png', 'eps'};

plotFilenames = {'Tworld_feedback', 'Tworld_feedback_right_left', 'Tworld_feedback_up_down'};

save_all_images(plotFolder, plotFormats, plotFilenames)
close all
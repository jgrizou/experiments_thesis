clean

[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
resultFolder = fullfile(pathstr, 'results');

analysisFolder = fullfile(pathstr, 'analysis');
if ~exist(analysisFolder, 'dir')
   mkdir(analysisFolder) 
end

log = folder_analysis_multiple_frame_feedback(fullfile(resultFolder, 'feedback'));
log.save(fullfile(analysisFolder, 'feedback'))

log = folder_analysis_multiple_frame_guidance(fullfile(resultFolder, 'guidance'));
log.save(fullfile(analysisFolder, 'guidance'))


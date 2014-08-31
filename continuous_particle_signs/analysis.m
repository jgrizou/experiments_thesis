clean
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));

analysisFolder = fullfile(pathstr, 'analysis');
if ~exist(analysisFolder, 'dir')
    mkdir(analysisFolder)
end

resultFolder = fullfile(pathstr, 'results');
resultsFolders = getfilenames(resultFolder);

for iFolder = 1:length(resultsFolders)

 
    filename = resultsFolders{iFolder};
    [~, fname, ~] = fileparts(filename);
    
    log = analyse_continuous_2D_folder(filename);

    saveFile = fullfile(analysisFolder, fname);
    log.save(saveFile)

end
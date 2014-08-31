clean
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));

analysisFolder = fullfile(pathstr, 'analysis');
if ~exist(analysisFolder, 'dir')
    mkdir(analysisFolder)
end

resultFolder = fullfile(pathstr, 'results');
positionSamplingMethodFolders = getfilenames(resultFolder);

for iPos = 1:length(positionSamplingMethodFolders)
    hypothesisSamplingMethodFolders = getfilenames(positionSamplingMethodFolders{iPos});
    for iHyp = 1:length(hypothesisSamplingMethodFolders)
        nHypothesisFolders = getfilenames(hypothesisSamplingMethodFolders{iHyp});
        for iNHyp = 1:length(nHypothesisFolders)            

            [~, positionSamplingMethod] = fileparts(positionSamplingMethodFolders{iPos});
            [~, hypothesisSamplingMethod] = fileparts(hypothesisSamplingMethodFolders{iHyp});
            [~, nHypothesis] = fileparts(nHypothesisFolders{iNHyp});
            
            filestr =  [positionSamplingMethod, '_', hypothesisSamplingMethod, '_', nHypothesis];
            disp(filestr)
            
            log = analyse_continuous_2D_folder(nHypothesisFolders{iNHyp});
 
            saveFile = fullfile(analysisFolder, filestr);
            log.save(saveFile)
            
        end
    end
end
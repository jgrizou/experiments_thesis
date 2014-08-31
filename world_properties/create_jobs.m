clean
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
jobFolder = fullfile(pathstr, 'wait_jobs');

if ~exist(jobFolder, 'dir')
    mkdir(jobFolder)
end

nJobs = 0;
% worlds = {'gridworld', 'pick_and_place'};
worlds = {'gridworld_5x5'};
actionSelectionMethods = {'random', 'greedy', 'e_greedy01', 'e_greedy05', 'uncertainty_signal', 'uncertainty_task'};

for iMethod = 1:length(actionSelectionMethods)
    for iWorld = 1:length(worlds)
        for i = 1:nJobs
            jobFile = generate_available_filename(jobFolder, '.m', 10);
            fid = fopen(jobFile, 'w');
            
            fprintf(fid, ['start_', worlds{iWorld} ,'\n']);
            
            fprintf(fid, ['setup\n']);
            
            switch actionSelectionMethods{iMethod}
                
                case 'random'
                    str = 'rec.actionSelectionInfo.method = ''random'';';
                    fprintf(fid, [str ,'\n']);
                    
                    str = 'rec.log_field(''uncertaintyMethod'', ''signal_sample'')';
                    fprintf(fid, [str ,'\n']);
                    
                case 'greedy'
                    str = 'rec.actionSelectionInfo.method = ''greedy'';';
                    fprintf(fid, [str ,'\n']);
                    
                    str = 'rec.log_field(''uncertaintyMethod'', ''signal_sample'')';
                    fprintf(fid, [str ,'\n']);
                    
                    
                case 'e_greedy01'
                    str = 'rec.actionSelectionInfo.method = ''e_greedy'';';
                    fprintf(fid, [str ,'\n']);
                    
                    str = 'rec.actionSelectionInfo.epsilon = 0.1;';
                    fprintf(fid, [str ,'\n']);
                    
                    str = 'rec.log_field(''uncertaintyMethod'', ''signal_sample'')';
                    fprintf(fid, [str ,'\n']);
                    
                case 'e_greedy05'
                    str = 'rec.actionSelectionInfo.method = ''e_greedy'';';
                    fprintf(fid, [str ,'\n']);
                    
                    str = 'rec.actionSelectionInfo.epsilon = 0.5;';
                    fprintf(fid, [str ,'\n']);
                    
                    str = 'rec.log_field(''uncertaintyMethod'', ''signal_sample'')';
                    fprintf(fid, [str ,'\n']);
                    
                case 'uncertainty_signal'
                    
                    str = 'rec.actionSelectionInfo.method = ''uncertainty'';';
                    fprintf(fid, [str ,'\n']);
                    str = 'rec.log_field(''uncertaintyMethod'', ''signal_sample'')';
                    fprintf(fid, [str ,'\n']);
                    
                case 'uncertainty_task'
                    str = 'rec.actionSelectionInfo.method = ''uncertainty'';';
                    fprintf(fid, [str ,'\n']);
                    str = 'rec.log_field(''uncertaintyMethod'', ''task'')';
                    fprintf(fid, [str ,'\n']);
                    
            end
            
            str = ['rec.log_field(''expFolderName'', ''', worlds{iWorld}, '_', actionSelectionMethods{iMethod}, ''')'];
            fprintf(fid, [str ,'\n']);
            
            fprintf(fid, 'main\n');
            fclose(fid);
        end
    end
end

clean
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
jobFolder = fullfile(pathstr, 'wait_jobs');

if ~exist(jobFolder, 'dir')
    mkdir(jobFolder)
end

nJobs = 0;
hypothesisSamplingMethod = {'random', 'active'};
positionSamplingMethod = {'random', 'uncertainty'};
nHypothesis = [5, 10, 50];

for iHypSampling = 1:length(hypothesisSamplingMethod)
    for iPosSampling = 1:length(positionSamplingMethod)
        for iNHyp = 1:length(nHypothesis)
            for i = 1:nJobs
                jobFile = generate_available_filename(jobFolder, '.m', 10);
                fid = fopen(jobFile, 'w');
                fprintf(fid, 'start\n');
                
                str = ['rec.log_field(''hypothesisSamplingMethod'', ''', hypothesisSamplingMethod{iHypSampling}, ''')'];
                fprintf(fid, [str ,'\n']);
                
                str = ['rec.log_field(''positionSamplingMethod'', ''', positionSamplingMethod{iPosSampling}, ''')'];
                fprintf(fid, [str ,'\n']);
                
                str = ['rec.log_field(''nHypothesis'', ', num2str(nHypothesis(iNHyp)), ')'];
                fprintf(fid, [str ,'\n']);

                fprintf(fid, 'main\n');
                fclose(fid);
            end
        end
    end
end

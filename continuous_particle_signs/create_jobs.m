clean
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
jobFolder = fullfile(pathstr, 'wait_jobs');

if ~exist(jobFolder, 'dir')
    mkdir(jobFolder)
end

nJobs = 0;

% for i = 1:nJobs
%     jobFile = generate_available_filename(jobFolder, '.m', 10);
%     fid = fopen(jobFile, 'w');
%     fprintf(fid, 'start\n');
% 
%     str = ['rec.log_field(''hypothesisSamplingMethod'', ''random'')'];
%     fprintf(fid, [str ,'\n']);
% 
%     str = ['rec.log_field(''positionSamplingMethod'', ''random'')'];
%     fprintf(fid, [str ,'\n']);
% 
%     str = ['rec.log_field(''nHypothesis'', 50)'];
%     fprintf(fid, [str ,'\n']);
% 
%     fprintf(fid, 'main\n');
%     fclose(fid);
% end

% for i = 1:nJobs
%     jobFile = generate_available_filename(jobFolder, '.m', 10);
%     fid = fopen(jobFile, 'w');
%     fprintf(fid, 'start\n');
% 
%     str = ['rec.log_field(''hypothesisSamplingMethod'', ''active'')'];
%     fprintf(fid, [str ,'\n']);
% 
%     str = ['rec.log_field(''positionSamplingMethod'', ''random'')'];
%     fprintf(fid, [str ,'\n']);
% 
%     str = ['rec.log_field(''nHypothesis'', 50)'];
%     fprintf(fid, [str ,'\n']);
% 
%     fprintf(fid, 'main\n');
%     fclose(fid);
% end

% 
% for i = 1:nJobs
%     jobFile = generate_available_filename(jobFolder, '.m', 10);
%     fid = fopen(jobFile, 'w');
%     fprintf(fid, 'start\n');
% 
%     str = ['rec.log_field(''hypothesisSamplingMethod'', ''random'')'];
%     fprintf(fid, [str ,'\n']);
% 
%     str = ['rec.log_field(''positionSamplingMethod'', ''uncertainty'')'];
%     fprintf(fid, [str ,'\n']);
% 
%     str = ['rec.log_field(''nHypothesis'', 50)'];
%     fprintf(fid, [str ,'\n']);
% 
%     fprintf(fid, 'main\n');
%     fclose(fid);
% end
% 
% for i = 1:nJobs
%     jobFile = generate_available_filename(jobFolder, '.m', 10);
%     fid = fopen(jobFile, 'w');
%     fprintf(fid, 'start\n');
% 
%     str = ['rec.log_field(''hypothesisSamplingMethod'', ''active'')'];
%     fprintf(fid, [str ,'\n']);
% 
%     str = ['rec.log_field(''positionSamplingMethod'', ''uncertainty'')'];
%     fprintf(fid, [str ,'\n']);
% 
%     str = ['rec.log_field(''nHypothesis'', 50)'];
%     fprintf(fid, [str ,'\n']);
% 
%     fprintf(fid, 'main\n');
%     fclose(fid);
% end


clean
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
jobFolder = fullfile(pathstr, 'wait_jobs');

if ~exist(jobFolder, 'dir')
   mkdir(jobFolder) 
end

nJobs = 500;
script_method_to_run = {'matching_method', 'simple_matching_method'};

for m = 1:length(script_method_to_run)
    for i = 1:nJobs
        jobFile = generate_available_filename(jobFolder, '.m', 10);
        fid = fopen(jobFile, 'w');
        fprintf(fid, 'start\n');
        fprintf(fid, [script_method_to_run{m} ,'\n']);
        fprintf(fid, 'main\n');
        fclose(fid);
    end 
end
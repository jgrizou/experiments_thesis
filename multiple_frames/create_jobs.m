clean
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
jobFolder = fullfile(pathstr, 'wait_jobs');

if ~exist(jobFolder, 'dir')
    mkdir(jobFolder)
end

nJobs = 100;
methods = {'feedback', 'guidance'};

for iMethod = 1:length(methods)
    for i = 1:nJobs
        jobFile = generate_available_filename(jobFolder, '.m', 10);
        fid = fopen(jobFile, 'w');

        fprintf(fid, ['start_teacher_', methods{iMethod} ,'\n']);

        fprintf(fid, 'setup\n');

        str = ['rec.log_field(''expFolderName'', ''', methods{iMethod}, ''')'];
        fprintf(fid, [str ,'\n']);

        fprintf(fid, 'main\n');
        fclose(fid);
    end
end

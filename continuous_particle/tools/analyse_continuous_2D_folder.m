function folderLog = analyse_continuous_2D_folder(folderName)
%ANALYSE_CONTINUOUS_2D_FOLDER

folderLog = Logger();



rF = getfilenames(folderName, 'refiles', '*.mat');
for irF = 1:length(rF)
    load(rF{irF})
    
    folderLog.log_field('fileName', rF{irF})
    
    log = analyse_continous_2D(rec);
    folderLog.log_from_logger(log, log.fields)

end
function folderLog = folder_analysis_multiple_frame_guidance(folderName)

folderLog = Logger();

rF = getfilenames(folderName, 'refiles', '*.mat');
for irF = 1:length(rF)
    load(rF{irF})
    
    folderLog.log_field('fileName', rF{irF})
    
    log = analysis_multiple_frame_guidance(rec);
    folderLog.log_from_logger(log, log.fields)

end
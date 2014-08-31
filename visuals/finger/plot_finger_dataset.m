common

%%

[pathstr, ~, ~] = fileparts(mfilename('fullpath'));


figure('Position', figPositionSquare)
hold on

dotSize = 100;

allX = [];
allY = [];


for i = 1:50
    load(fullfile(pathstr, 'move_up.mat'))
    tmp = formattedFingerData{i};
    tmp.X(tmp.X < 0) = 0;
    tmp.Y(tmp.Y < 0) = 0;
    allX = [allX, tmp.X];
    allY = [allY, tmp.Y];
    scatter(tmp.X, 1200-tmp.Y, dotSize, niceBlue , 'filled')
    
    load(fullfile(pathstr, 'move_down.mat'))
    tmp = formattedFingerData{i};
    tmp.X(tmp.X < 0) = 0;
    tmp.Y(tmp.Y < 0) = 0;
    allX = [allX, tmp.X];
    allY = [allY, tmp.Y];
    scatter(tmp.X, 1200-tmp.Y, dotSize, niceOrange , 'filled')
    
    
    load(fullfile(pathstr, 'move_right.mat'))
    tmp = formattedFingerData{i};
    tmp.X(tmp.X < 0) = 0;
    tmp.Y(tmp.Y < 0) = 0;
    allX = [allX, tmp.X];
    allY = [allY, tmp.Y];
    scatter(tmp.X, 1200-tmp.Y, dotSize, niceBlack, 'filled')
    
    
    load(fullfile(pathstr, 'move_left.mat'))
    tmp = formattedFingerData{i};
    tmp.X(tmp.X < 0) = 0;
    tmp.Y(tmp.Y < 0) = 0;
    allX = [allX, tmp.X];
    allY = [allY, tmp.Y];
    scatter(tmp.X, 1200-tmp.Y, dotSize, nicePurple , 'filled')
end

xlim([0, 800])
ylim([0, 1200])
set(gca,'DataAspectRatio',[1 1 1])

xlabel('X in pixel')
ylabel('Y in pixel')
title('Directional finger movements on a tablet')


%%

[pathstr, ~, ~] = fileparts(mfilename('fullpath'));


figure('Position', figPositionSquare)
hold on

dotSize = 100;

allX = [];
allY = [];


for i = 1:20
    load(fullfile(pathstr, 'sign_north.mat'))
    tmp = formattedFingerData{i};
    tmp.X(tmp.X < 0) = 0;
    tmp.Y(tmp.Y < 0) = 0;
    allX = [allX, tmp.X];
    allY = [allY, tmp.Y];
    scatter(tmp.X, 1200-tmp.Y, dotSize, niceBlue , 'filled')
end

xlim([0, 800])
ylim([0, 1200])
set(gca,'DataAspectRatio',[1 1 1])

xlabel('X in pixel')
ylabel('Y in pixel')
title('North sign movements on a tablet')


%%

[pathstr, ~, ~] = fileparts(mfilename('fullpath'));


figure('Position', figPositionSquare)
hold on

dotSize = 100;

allX = [];
allY = [];


for i = 1:20
    load(fullfile(pathstr, 'sign_south.mat'))
    tmp = formattedFingerData{i};
    tmp.X(tmp.X < 0) = 0;
    tmp.Y(tmp.Y < 0) = 0;
    allX = [allX, tmp.X];
    allY = [allY, tmp.Y];
    scatter(tmp.X, 1200-tmp.Y, dotSize, niceOrange , 'filled')
end

xlim([0, 800])
ylim([0, 1200])
set(gca,'DataAspectRatio',[1 1 1])

xlabel('X in pixel')
ylabel('Y in pixel')
title('South sign movements on a tablet')


%%

[pathstr, ~, ~] = fileparts(mfilename('fullpath'));


figure('Position', figPositionSquare)
hold on

dotSize = 100;

allX = [];
allY = [];


for i = 1:20
    load(fullfile(pathstr, 'sign_east.mat'))
    tmp = formattedFingerData{i};
    tmp.X(tmp.X < 0) = 0;
    tmp.Y(tmp.Y < 0) = 0;
    allX = [allX, tmp.X];
    allY = [allY, tmp.Y];
    scatter(tmp.X, 1200-tmp.Y, dotSize, niceBlack, 'filled')
end

xlim([0, 800])
ylim([0, 1200])
set(gca,'DataAspectRatio',[1 1 1])

xlabel('X in pixel')
ylabel('Y in pixel')
title('East sign movements on a tablet')

%%

[pathstr, ~, ~] = fileparts(mfilename('fullpath'));


figure('Position', figPositionSquare)
hold on

dotSize = 100;

allX = [];
allY = [];


for i = 1:20
    load(fullfile(pathstr, 'sign_west.mat'))
    tmp = formattedFingerData{i};
    tmp.X(tmp.X < 0) = 0;
    tmp.Y(tmp.Y < 0) = 0;
    allX = [allX, tmp.X];
    allY = [allY, tmp.Y];
    scatter(tmp.X, 1200-tmp.Y, dotSize, nicePurple , 'filled')
end

xlim([0, 800])
ylim([0, 1200])
set(gca,'DataAspectRatio',[1 1 1])

xlabel('X in pixel')
ylabel('Y in pixel')
title('West sign movements on a tablet')




    
    

    
    





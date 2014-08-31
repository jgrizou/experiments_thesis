% choose which hypothesis is the one taught by the teacher
teacherHypothesis = rec.environment.sample_positions(1); % this will be recorded at each iteration so not now

hypothesisRecordNames = cell(1, rec.nHypothesis);
for iHyp = 1:rec.nHypothesis
    hypothesisRecordNames{iHyp} = ['plabelHyp', num2str(iHyp)];
end
rec.logit(hypothesisRecordNames)

goalHypothesis = rec.environment.sample_positions(rec.nHypothesis);

for iStep = 1:rec.nSteps
    %% start loop
    stepTime = tic;
    fprintf('%4d/%4d',iStep, rec.nSteps);
    rec.logit(iStep)
    
    %% update hypothesis
    gmd = gmdistribution;
    if length(rec.iStep) > rec.nInitSteps
        switch rec.hypothesisSamplingMethod
            
            case 'random'
                filestr = generate_method_filestr(methodInfo);
                methodPlanningProba = proba_normalize_row(rec.(['probabilities_', filestr])(end, :));
                [~, idMax] = max(methodPlanningProba);
                keptHypothesis = goalHypothesis(idMax, :);
                goalHypothesis = rec.environment.sample_positions(rec.nHypothesis);
                goalHypothesis(1,:) = keptHypothesis;
                
            case 'active'
                filestr = generate_method_filestr(methodInfo);
                methodPlanningProba = proba_normalize_row(rec.(['probabilities_', filestr])(end, :));
                [~, idMax] = max(methodPlanningProba);
                keptHypothesis = goalHypothesis(idMax, :);
                
                mus = goalHypothesis;
                mus(end+1,:) = rec.muNoiseGM;
                
                sigmas = zeros(2, 2, rec.nHypothesis);
                for iHyp = 1:rec.nHypothesis
                    sigmas(:,:,iHyp) = eye(2) * rec.diagGM;
                end
                sigmas(:,:,end+1) = rec.sigmaNoiseGM;
                
                p = methodPlanningProba + rec.minWeightGM; %to avoid crashing the gmdistribution, it is renormalized in the gmdistribution function
                p = apply_noise([p, 0], rec.pNoiseGM);
                
                gmd = gmdistribution(mus, sigmas, p);
                
                goalHypothesis = random(gmd, rec.nHypothesis);
                goalHypothesis(1,:) = keptHypothesis;
                
                goalHypothesis(goalHypothesis > 1) = 1;
                goalHypothesis(goalHypothesis < 0) = 0;
        end
    end
    rec.logit(goalHypothesis)
    rec.logit(gmd)
    
    
    %% choose next position
    if length(rec.iStep) > rec.nInitSteps
        switch rec.positionSamplingMethod
            case 'random'
                position = rec.environment.sample_positions(1);
            case 'uncertainty'
                [~, idMax] = max(rec.positionUncertaintyValues(end,:));
                position = rec.positionToEstimateUncertainty(idMax, :, end);
        end
    else
        position = rec.environment.sample_positions(1);
    end
    rec.environment.set_position(position)
    rec.logit(position)
    
    %% simulate teacher response
    rec.logit(teacherHypothesis)
    teacherPLabel = rec.teacherFrame.compute_labels(rec.teacherHypothesis(end, :), rec.environment.get_position());
    teacherLabel = sample_action_discrete_policy(teacherPLabel);
    rec.log_field('teacherSignal', rec.teacherDispatcher.get_sample(teacherLabel));
    
    %% update labels
    if length(rec.iStep) > rec.nInitSteps
        rec.rm_field(rec.hypothesisRecordNames)
        for i = 1:size(rec.position,1)
            hypothesisPLabel = cell(1, rec.nHypothesis);
            for iHyp = 1:rec.nHypothesis
                hypothesisPLabel{iHyp} = rec.learnerFrame.compute_labels(rec.goalHypothesis(iHyp, :, end), rec.position(i, :));
            end
            rec.log_multiple_fields(rec.hypothesisRecordNames, hypothesisPLabel)
        end
    end
    
    %% compute hypothesis probabilities
    recorder_compute_proba(rec, rec.methodInfo)
    
    %% compute uncertainty on sampled point
    if strcmp(rec.positionSamplingMethod, 'uncertainty')
        positionToEstimateUncertainty = zeros(rec.nSampleToEstimateUncertainty, 2);
        positionUncertaintyValues = proba_normalize_row(ones(1, rec.nSampleToEstimateUncertainty));
        if length(rec.iStep) > rec.nInitSteps
            positionToEstimateUncertainty = rec.environment.sample_positions(rec.nSampleToEstimateUncertainty);
            positionUncertaintyValues = compute_uncertainty_per_node(rec, rec.uncertaintyMethod, rec.methodInfo, positionToEstimateUncertainty)';
        end
        rec.logit(positionToEstimateUncertainty)
        rec.logit(positionUncertaintyValues)
    end
    
    %% end loop
    rec.log_field('dispatcher_empty', rec.teacherDispatcher.who_is_empty())
    rec.log_field('stepTime', toc(stepTime))
    fprintf('\b\b\b\b\b\b\b\b\b')
end

[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
folder = fullfile(pathstr, 'results', [rec.positionSamplingMethod, '_', rec.hypothesisSamplingMethod, '_' ,num2str(rec.nHypothesis)]);
if ~exist(folder, 'dir')
    mkdir(folder)
end
recFilename = generate_timestamped_filename(folder, 'mat');
rec.save(recFilename)

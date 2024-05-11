function extract_features(path)
    keySet = {'cero', 'uno', 'dos', 'tres', 'cuatro', 'cinco', 'seis', 'siete', 'ocho', 'nueve'};
    valueSet = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    mapObj = containers.Map(keySet,valueSet);

    if isfolder(path)
        % Get a list of all WAV files in the folder
        files = dir(fullfile(path, '*.wav'));
        
        descriptors = []; % Initialize an empty array to store descriptors
        groundTruths = []; % Initialize an empty cell array to store ground truth labels
        
        for i = 1:length(files)
            % Get the file name
            fileName = files(i).name;

            % Get the full path to the audio file
            audioPath = fullfile(path, fileName);

            % remove the .wav extension and the 4 last characters (the number of the file)
            fileName = fileName(1:end-8);

            % Call the extract_features function for each audio file
            descriptor = extract_features_helper(audioPath);

            % Accumulate descriptors and ground truth labels
            descriptors = [descriptors; descriptor];
            groundTruths = [groundTruths; mapObj(fileName)];
        end

        descriptor = descriptors;
        groundTruth = groundTruths;
        
        % Save all descriptors and ground truth labels in one MAT file
        save('test_data.mat', 'descriptor', 'groundTruth');
    end

    if isfile(path)
        % Call the extract_features function for the audio file
        descriptor = extract_features_helper(path);

        [~, fileName, ~] = fileparts(path);
        groundTruth = mapObj(fileName(1:end-4));
        
        % Save the descriptor in a MAT file
        save('test_data.mat', 'descriptor', 'groundTruth');
    end
end

function [descriptor] =  extract_features_helper(audioPath)
    [audioIn,fs] = audioread(audioPath);

    frameDuration = 0.032; % 32ms
    overlapDuration = frameDuration/2; % solape del 50%

    L_frame = round(frameDuration*fs);
    overlapSamples = round(overlapDuration*fs);
    audioIn_mask = myVad(audioIn, fs);

    aFE = audioFeatureExtractor("SampleRate",fs, ...
        "Window",hamming((L_frame),"periodic"), ...
        "OverlapLength",overlapSamples, ...
        "mfcc",true, ...
        "mfccDelta",true, ...
        "spectralFlux",true, ...
        "spectralCentroid",true, ...
        "spectralSpread",true, ...
        "spectralSkewness",true, ...
        "spectralKurtosis",true, ...
        "spectralRolloffPoint",true);

    features = extract(aFE,audioIn_mask);
    idx = info(aFE); % variable estructurada

    avg_mfcc = mean(features(: , idx.mfcc),1);
    var_mfcc = var(features(: , idx.mfcc),1);
    max_mfcc = max(features(: , idx.mfcc),[],1);
    min_mfcc = min(features(: , idx.mfcc),[],1);
    avg_mfccDelta = mean(features(: , idx.mfccDelta),1);
    var_mfccDelta = var(features(: , idx.mfccDelta),1);
    mean_spectralFlux = mean(features(: , idx.spectralFlux),1);
    var_spectralFlux = var(features(: , idx.spectralFlux),1);
    mean_spectralCentroid = mean(features(: , idx.spectralCentroid),1);
    mean_spectralSpread = mean(features(: , idx.spectralSpread),1);
    mean_spectralSkewness = mean(features(: , idx.spectralSkewness),1);
    mean_spectralKurtosis = mean(features(: , idx.spectralKurtosis),1);
    mean_spectralRolloffPoint = mean(features(: , idx.spectralRolloffPoint),1);

    descriptor = [avg_mfcc var_mfcc max_mfcc min_mfcc avg_mfccDelta var_mfccDelta mean_spectralFlux var_spectralFlux mean_spectralCentroid mean_spectralSpread mean_spectralSkewness mean_spectralKurtosis mean_spectralRolloffPoint];
end

function audioIn_mask = myVad(audioIn, fs)
    [speechIndices, thresholds] = detectSpeech(audioIn,fs);

    % Aplica la máscara para seleccionar los valores
    audioIn_mask = [];

    for chunkIndices = speechIndices'
        audioIn_mask = [audioIn_mask; audioIn(chunkIndices(1):chunkIndices(2))];
    end
end



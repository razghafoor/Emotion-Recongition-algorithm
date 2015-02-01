function [ confMatrix, avgTotalFoneMeasure, totalClassificationRate, foldConfMatrices ] = CBREval(x, y, displayOn)
%CBREval performs 10-fold cross validation using a cbr
% INPUT
% x = matrix with number of examples and action units
% y = labels of x

    %number of features
    numFeatures = max(y);
    confMatrix = zeros(numFeatures,numFeatures);
    
    foldConfMatrices = zeros(numFeatures,numFeatures,10);
    
    for i=1:10
        [ trainInd, testInd ] = IndicesForFold(x, i);
        cbr = CBRinit(x(trainInd,:),y(trainInd));
        
        
        % Do actual testing to get a confusion matrix
        predictions = testCBR(cbr, x(testInd,:));
        indicesFold = testInd;
        foldLength = length(testInd);
        for j = 1:foldLength
            % We choose the row(actual) index via value of current fold index
            % in y and we choose the column index (predicted) by doing the same
            % with the predictions, then increment the value in the table.
           foldConfMatrices(y(indicesFold(j)),predictions(j),i) = foldConfMatrices(y(indicesFold(j)),predictions(j),i) +1;
        end
    end
    
    confMatrix = sum(foldConfMatrices,3);

    recalls = zeros(numFeatures, 1);
    precisions = zeros(numFeatures, 1);
    fones = zeros(numFeatures, 1);
    
    for j = 1:numFeatures
        recalls(j) = calcRecall(confMatrix, j);
        precisions(j) = calcPrecision(confMatrix, j);
        fones(j) = calcFmeasure(precisions(j), recalls(j), 1);
    end


    avgTotalRecall = mean(recalls);
    avgTotalPrecision = mean(precisions);
    avgTotalFoneMeasure = mean(fones);
    totalClassificationRate = trace(confMatrix) / sum(sum(confMatrix));
    
    if displayOn
    display('-- EVALUATION COMPLETE --');
    display(['unweighted mean; recall ' num2str(avgTotalRecall)...
            ' precision ' num2str(avgTotalPrecision)...
            ' f1 ' num2str(avgTotalFoneMeasure)...
            ' classification rate ' num2str(totalClassificationRate)]);
    display(['std; recall ' num2str(std(recalls))...
            ' precision ' num2str(std(precisions))...
            ' f1 ' num2str(std(fones))...
            ' classification rate N/A']);
    
    emotions = {};
    for i = 1:6
        emotions{i} = emolab2str(i);
    end
    display(emotions(1:6));
    [precisionPerEmotion, recallPerEmotion, fonesPerEmotion] = calcEmotionMeasures(confMatrix);
    display('precision per emotion');
    display(['    ' num2str(precisionPerEmotion,'%.3f &')]);
    display('recall per emotion');
    display(['    ' num2str(recallPerEmotion,'%.3f &')]);
    display('f_one per emotion');
    display(['    ' num2str(fonesPerEmotion,'%.3f &')]);
    end
    
end


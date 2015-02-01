function [ tp, fp, tn, fn ] = confusionMatBreakdown( confusionMat, class )
%CONFUSIONMATBREAKDOWN Given a confusion matrix and class, calculates True
%Postivites, False Positives, False Negatives and True Negatives. Assumes
%that rows correspond to the actual classes, columns to the predicted (as
%depicted in the CBC manual).
%   
    % true positives - examples classified correctly as members of positive
    % (given) class
    tp = confusionMat(class, class);

    % true negatives - examples classified correctly as members of negative
    % classes
    confusionMatSansClass = confusionMat;
    confusionMatSansClass(class,:) = 0;
    confusionMatSansClass(:,class) = 0;
    tn = sum(sum(confusionMatSansClass));
    
    % false positives - examples classified incorrectly as members of
    % positive class
    fp = sum(confusionMat(:,class)) - confusionMat(class,class);
    
    % false negatives - examples classified incorrectly as members of
    % negative classes
    fn = sum(confusionMat(class,:)) - confusionMat(class,class);
end
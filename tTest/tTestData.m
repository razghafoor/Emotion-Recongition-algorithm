function [hypos,crs] = tTestData(cnfsMsTrees, cnfsMsNets, cnfsMsCBR, alpha) 
% tTestData performs a t test on all pairs of non empty matrices passed in.
% The input matrices should be 3d and contain a confusion matrix per fold

	crs = zeros(6,10,3); % all classification rates per emotion

	% Calculate classification rates per fold per emotion
	for emot=1:6 % 6 emotions
        for i=1:10
			confTree = cnfsMsTrees(:,:,i);
			confNet = cnfsMsNets(:,:,i);
			confCBR = cnfsMsCBR(:,:,i);

			crs(emot,i,1) = calcClassifErrorPerEmotion(emot, confTree);
			crs(emot,i,2) = calcClassifErrorPerEmotion(emot, confNet);
			crs(emot,i,3) = calcClassifErrorPerEmotion(emot, confCBR);
        end
	end

	% hypos columns represent outcome of t-test (0 if null valid, 1 if null rejected)
	% | trees-nets | trees-cbr | nets-cbr |
	hypos = zeros(6,3);
	pairs = {[1 2] [1 3] [2 3]};
	% make comparisons to see if there is a difference between algos per emotion
	for emot=1:6
		for idx = 1:length(pairs)
			p = pairs{idx};
			% Bonferroni correction is used to get desired significance level with multiple comparisons
            [h, ~, ~, ~] = ttest(crs(emot,:,p(1)),crs(emot,:,p(2)),'Alpha',alpha/3);
			hypos(emot,idx) = h;
		end
    end
    
    % Display results in a more digestible manner:
    fprintf('Emotion\t\t\tTree vs Net\t\t\tTree vs CBR\t\t\tNet vs CBR\n\n');
    for emot=1:6
        fprintf('%s',emolab2str(emot));
        % variable number of tabs to align columns
        if emot == 4 || emot ==6
            fprintf('\t\t\t');
        else
            fprintf('\t\t\t\t');
        end
        for idx=1:length(pairs)
            hyp = hypos(emot,idx);
            p = pairs{idx};
            printLetter(p(1));
            
            if hyp == 0 % null hypothesis validated, no significant difference
                fprintf('~');
            else % there is a difference, need to figure out which one is better
                meanErrFirst = mean(crs(emot,:,p(1)));
                meanErrSecond = mean(crs(emot,:,p(2)));
                % first being compared is worse
                if meanErrFirst > meanErrSecond
                    fprintf('<');
                else
                    % first being compared is better
                    fprintf('>');
                end
            end
            printLetter(p(2));
            fprintf('\t\t\t\t\t');
        end
        fprintf('\n')
    end
    
end

function [ce] = calcClassifErrorPerEmotion(emot, confMatrix)    
    [ tp, fp, tn, fn ] = confusionMatBreakdown( confMatrix, emot );
	ce = 1 - ((tp + tn) / (tp + fn + tn + fp));
end

function [] = printLetter(num)
    if num == 1
        fprintf('T');
    elseif num == 2
        fprintf('N');
    else
        fprintf('C');
    end
end
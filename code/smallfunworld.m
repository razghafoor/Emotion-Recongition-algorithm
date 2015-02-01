% Give our CBR a spin!
% Free of charge~

load('forstudents\cleandata_students.mat');

rangeToTrain = 1:500;
[ cbr ] = CBRinit( x(rangeToTrain,:), y(rangeToTrain) );

kMax = 10;
classRate = zeros(kMax,1);
for k = 1:10
    % little error rate prediction
    beginRangeToTest = 501;
    predictions = testCBR(cbr, x(beginRangeToTest:end,:), k);
    % classification rate
    classRate(k) = 1-nnz(predictions-y(beginRangeToTest:end))/length(predictions);
end

%best is k = 3
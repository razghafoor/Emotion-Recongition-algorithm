load('forstudents/cleandata_students.mat')

range = 1:50;
% fones = zeros(length(range), 1);
% i = 0;
display('Starting k sweep..');
for k=range
%     i = i + 1;
    [ ~, avgTotalFoneMeasure, ~, ~ ] = CBREval(x, y, k, false);
    fones(k) = avgTotalFoneMeasure;
    display(k);
end
display('Sweep complete.');

plot(fones);
xlabel('k');
ylabel('F-one');
title('F-one vs k using 10-fold cross-validation, clean')
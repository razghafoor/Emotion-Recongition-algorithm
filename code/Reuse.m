function [ solvedCase ] = Reuse(retrievedCase, newCase)
%Reuse attaches the solution of the retrieved case to the new case
    solvedCase = newCase;
    solvedCase.solution = retrievedCase.solution;
end
%NEEDLEMAN-WUNSCH ALGORITHM
%Rachel K. Surridge
%9/25/2018

clc
clear all
close all

seq1 = 'CGGTTCGACGTTAC';
seq2 = 'CCGTTACGGCTTGC';

%SCORING SCHEME
match = 1;
mismatch = 0;
deletion = 0;

matrx = zeros(length(seq1)+1, length(seq2)+1);
for j = 2:1:length(seq1)+1                      %iterates through matrix columns
    for i = 2:1:length(seq2)+1                  %iterates through matrix rows within each column
        L = matrx(i, j-1) + deletion;           %adds deletion/insertion penalty to values in cells above and to the left of current cell
        U = matrx(i-1, j) + deletion; 
        if strcmp(seq1(i-1),seq2(j-1))          
            direx{i,j} = [matrx(i, j-1) + deletion, matrx(i-1, j) + deletion, matrx(i-1,j-1) + match];     %stores values of surrounding cells in separate matrix for later traceback
        else
            direx{i,j} = [matrx(i, j-1) + deletion, matrx(i-1, j) + deletion, matrx(i-1,j-1) + mismatch];
        end
        matrx(i,j) = max(direx{i,j});
    end
end

score = matrx(end,end);
[seqA, seqB] = traceback(matrx,direx, seq1, seq2);

fprintf('Score: %d\n',score);
fprintf('Best Alignment: \n%s \n%s\n',seqA, seqB);

clear deletion direx i insertion j L match matrx mismatch U
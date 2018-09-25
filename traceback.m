function [A, B] = traceback(matrx, direx, seq1, seq2)
%Function traceback.m requires input of original sequences, 
%Needleman similiarity matrix 'matrx' containing alignment score values, 
%and cell matrix 'direx' containing input vaues for each cell in order of 
%input from left, from above, and from diagonal {L,U,D}. traceback.m 
%returns A and B as the best alignments of the original sequences

i = length(seq1)+1;     %start at bottom right hand corner of sim matrix
j = length(seq2)+1;
remstrA = seq1;
remstrB = seq2;
A = '';
B = '';

while ~isempth(remstrA) && ~isempty(remstrB)
    if direx{i,j}(1) == matrx(i,j)     %if input comes from the left
        A = ['_' A]; 
        B = [seq2(j-1) B];
        j = j - 1;
    elseif direx{i,j}(2) == matrx(i,j) %if input comes from above
        B = ['_' B];
        A = [seq1(i-1) A];
        i = i - 1;
    elseif direx{i,j}(3) == matrx(i,j) %if input comes from diagonal
        A = [seq1(i-1) A]; 
        B = [seq2(j-1) B];
        i = i - 1;
        j = j - 1;
        remstrA = remstrA(1:(i-1));
        remstrB = remstrB(1:(j-1));
    end
end


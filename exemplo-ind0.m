#! /usr/bin/octave -qf

m = 3
n = 7
A = [2, 1, 1, 1, -1, 0, 0; 4, -2, 5, 1, 0, 1, 0; 4, -1, 3, 1, 0, 0, -1]
b = [9; 8; 5]
c = [34; 5; 19; 9; 0; 0; 0]
[ind x] = simplex(A, b, c, m, n, 1)

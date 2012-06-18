#! /usr/bin/octave -qf

m = 3
n = 4
A = [1, 2, 3, 0; 2, 1, 5, 0; 1, 2, -1, 1]
b = [15; 20; 10]
c = [-1; -2; -3; 1]
[ind x] = simplex(A, b, c, m, n, 1)

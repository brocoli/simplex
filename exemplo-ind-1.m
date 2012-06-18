#! /usr/bin/octave -qf

m = 2
n = 4
A = [-1, 1, 1, 0; 1, -2, 0, 1]
b = [1; 2]
c = [-2; -1; 0; 0]
[ind x] = simplex(A, b, c, m, n, 1)

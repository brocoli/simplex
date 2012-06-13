#! /usr/bin/env octave

# m = num de linhas
# n = num de colunas
function simplex(A,b,c,m,n,print)
    tableau = [1,-c',0;zeros(m,1),A,b]
    # W = sum das variaveis novas. m - 1
    hugetableau = 
        [           1,        zeros(1,n+1),      -ones(1,m),             0;
         zeros(m+1,1), tableau(:, [1:n+1]), eye(n)(:,[2:n]),tableau(:,n+2)]

#	[ind x]
endfunction

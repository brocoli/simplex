#! /usr/bin/octave -qf

% m = num de linhas
% n = num de colunas

function [ind x] = simplex(A,b,c,m,n,print)

	%initialize x with dummy value
	x = 0;
	muheps = eps*1000; %instabilidade numérica faz zeros ficarem maiores que epsilon...
	
	%make b positive, adjust A accordingly.
	for i = 1:m
		if b(i) < 0
			b(i) = -b(i);
			A(i,:) = -A(i,:);
		endif
	endfor
	
	%build the phase1 tableau
	cext = [-sum(A, 1),zeros(1,m)];
	tableau = [-sum(b),cext;b,A,eye(m)];
	basis = n+1:n+m;
	removedvars = 0;

	mahputs(print, "Simplex: Fase 1\n")
	
	%do the phase 1 magic
	[ind tableau basis iter] = runsimplex(basis,tableau,m,n+m,print,0);

	mahtableau(print, tableau, m, n+m, basis, iter, [0,0]);
	
	%no solution? ohnoes...
	if ind != 0
		return
	endif

	%resolver problemas de vars artificiais na base
	bi = 1;
	for varname = basis
		if varname > n
		
			if sum(abs(tableau(bi+1,2:n+1)) < muheps) == n %redundant restriction
				%remove redundant restriction, ajeitando o tableau, basis, A, b, m
				basis(bi) = [];
				tableau(bi+1,:) = [];
				A(bi,:) = [];
				b(bi) = [];
				--m;
				++removedvars;
				
				--bi;
				
			else %forcefully remove this var from the basis.
			
				for newvar = 1:n
					if tableau(1,newvar+1) != 0
						break;
					endif
				endfor
				
				%queremos que a variável varname (na linha bi+1 do tableau) saia da base, e que newvar entre.
				%pivotando...
				tableau(bi+1,:) /= tableau(bi+1,newvar+1);
				
				for i = 1:m+1
					if i != bi+1
						tableau(i,:) -= tableau(i,newvar+1)*tableau(bi+1,:);
					endif
				endfor
				
				basis(bi) = newvar;
				
			endif
		endif
		++bi;
	endfor
	
	%ajeitar o tableau fase 2
	cb = c(basis);
	tableau(1, 2:n+1) = c' - cb'*tableau(2:m+1,2:n+1);
	tableau(1,1) = -cb' * tableau(2:m+1,1);
	tableau(:,n+2:n+m+1+removedvars) = [];
	
	%do the phase 2 magic	
	mahputs(print, "Simplex: Fase 2\n")
	[ind tableau basis iter] = runsimplex(basis,tableau,m,n,print,0);

	mahtableau(print, tableau, m, n, basis, iter, [0,0]);
	if ind != 0
		return
	endif

	%extrair o x
	x = zeros(n, 1);
	x(basis) = tableau(2:m+1,1);
	if print
		printf("\nSolução ótima encontrada com custo %.3f:\n", -tableau(1,1));
		x
	endif
endfunction

function [ind tableau basis iter] = runsimplex(basis,tableau,m,n,p,iter)

	muheps = eps*1000; %de novo, problemas de estabilidade numérica.

	while 1 %condição de saída é não achar nenhuma coluna onde melhorar.

		++iter;

		%choose column
		col = 2;
		while col <= n+1 && tableau(1,col) >= 0
			++col;
		endwhile

		%THERESNOCOLUMN
		if col > n+1
			if tableau(1,1) < -muheps
				ind = 1;
			else
				ind = 0;
			endif
			return
		endif

		%choose row
		row = 0;
		minvalue = Inf;
		for i = 2:m+1
			if tableau(i,col) > 0
				theta = tableau(i,1) / tableau(i,col);
				if minvalue > theta
					row = i;
					minvalue = theta;
				endif
			endif
		endfor
		
		if row == 0 %nenhuma linha tem um custo > 0. Posso andar infinitamente
			ind = -1;
			return
		endif
		
		mahtableau(p, tableau, m, n, basis, iter, [row-1,col-1]);

		%uptade the basis vector with the new var, removing the old var
		basis(row - 1) = col - 1;
		
		%pivotando...
		%put 1 hear.
		tableau(row,:) /= tableau(row,col);
		
		%put zeroes evriwhear else.
		for i = 1:m+1
			if i != row
				tableau(i,:) -= tableau(i,col)*tableau(row,:);
			endif
		endfor
	endwhile
	
endfunction

function mahputs(p, str)
	if p
		puts(str);
	endif
endfunction

function mahtableau(p, tableau, m, n, basis, iter, pivo)
	if !p
		return
	endif
	printf("Iteração %d\n", iter);
	printf("            |");
	for i = 1:n
		printf(" x%-5.d |", i);
	endfor
	printf("\n");
	printf("%*.3f |",11,tableau(1,1));
	for i = 1:n
		printf("%*.3f |",7,tableau(1,i+1));
	endfor
	printf("\n");
	printf("-------------");
	for i = 1:n
		printf("---------");
	endfor
	printf("\n");
	for i = 1:m
		printf("x%-2.d %*.3f |", basis(i),7,tableau(i+1,1));
		for j = 1:n
			printf("%*.3f",7,tableau(i+1,j+1));
			if(pivo(1) == i && pivo(2) == j)
				printf("*|");
			else
				printf(" |");
			endif
		endfor
		printf("\n");
	endfor
	printf("\n");
endfunction

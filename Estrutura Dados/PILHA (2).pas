Program Pzim ;  

type 
vetor = array[1..4] of integer;
var
v : vetor;
topo,numero,valorAtual: integer;

//criar pilha
	function ehVazio(p1:vetor;valoratual:integer):boolean;
		begin
		if valoratual = 0 then
			ehVazio := true
		else
			ehVazio := p1[valoratual]= 0;
		end;
	
	function ehCheia(p1:vetor;valoratual:integer):boolean;
		begin
		if valoratual = 0 then
			valoratual :=0
		else
			ehCheia := p1[4]<> 0;
		end;
	
	procedure preenche(var p1:vetor; var valoratual:integer);
		var
		x:integer;
		begin
			if p1[4] > 0 then
				writeln('Espaço limite alcançado')
				else
				begin
					writeln('Informe um valor:');
					readln(x);
					valorAtual := valorAtual +1; 
					p1[valorAtual]:= x;
				end;	
		end;
		
		
		procedure exclui (var p1:vetor; var valoratual:integer);
			     begin
			     if p1[1] = 0 then
						writeln('Nao a valores para excluir')
						else
						begin
							p1[valorAtual]:= 0;
							valorAtual := valorAtual -1;
						end;
			     end;
			     
		procedure imprime (p1:vetor);
		var 
		i:integer;
			begin
				for i:= 1 to 4 do
					begin
						writeln('|', p1[i])
					end;
			     writeln('|')
			end;
	

Begin

Writeln('Digite os respectivos valores para realizar as açoes:');
writeln('1: insere');
writeln('2: exclui');
writeln('3: verifica se esta vazia');
writeln('4: Verifica se esta cheia');
writeln('5: Imprime Pilha');
writeln('6: Sair do programa');
valorAtual:= 0;
while numero <> 6 do
	  begin
	  readln(numero);
	  	if numero = 1 then
	  	begin
	  		preenche(v,valorAtual);
	  		writeln('Digite um valor de 1 a 6:');
	  	end;
	  	if numero = 2 then
	  	begin
	  		exclui(v,valorAtual);
	  		writeln('Digite um valor de 1 a 6:');
	  		end;
	  	if numero = 3 then
	  		if ehvazio(v,valorAtual) = true then
					writeln('Array vazio')
					else
					writeln('Não esta vazio');
	  	if numero = 4 then
	  		if ehCheia(v,valorAtual) = true then
					writeln('Array cheio')
					else
					writeln('Não esta cheio');
	  	if numero = 5 then
	  		imprime(v);
	    if numero = 6 then
	    	break;
	  	if numero > 6 then
	  		writeln('Valor invalido');
	  end;


  
End.
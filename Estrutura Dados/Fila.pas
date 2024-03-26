Program FILA ;

Type
fila = array [1..4] of integer;

var
fila1: fila;
quengaGorda,numero : integer;
 	
 	function ehVazio(fila1: fila; quengaGorda: integer): boolean;
					begin
						if fila1[1] = 0 then
							ehVazio := true;
					end;
					
	function ehCheia(fila1:fila;quengaGorda:integer):boolean;
		begin
			if quengaGorda = 0 then
				ehCheia := false
				else
				if fila1[4] > 0 then
		      ehCheia := true;
		end;
		
		procedure insere (var fila1:fila;var quengaGorda:integer);
		var
		x,i:integer;
			begin
			  if fila1[4] > 0 then 
			  		writeln('Fila esta cheia')
			  	else
			  		begin
			  			writeln('Informe um valor');
			  			readln(x);
			  			quengaGorda := quengaGorda+1;
			  			fila1[quengaGorda]:= x;		
			  	end;
			end;
			
			procedure remove (var fila1:fila;var quengaGorda:integer);
			var
			i,armazena: integer;
				begin
				  if quengaGorda = 0 then
				  	quengaGorda:=0
				  	else
				  for i:= 1 to 3 do
					begin	 
				  	armazena:= fila1[i+1];
				  	fila1[i]:= armazena;
				 	end; 
				 		fila1[4]:= 0;
					 quengaGorda:= quengaGorda -1;	
				end;	
				
				procedure Escreve (fila1: fila);
				var
				i:integer;
				    begin
				      for i:= 1 to 4 do
				      	begin
				      		writeln('|', fila1[i]);
				      	end;			     
				    end;
	Begin 	
	    Writeln('Digite os respectivos valores para realizar as açoes:');
writeln('1: insere');
writeln('2: exclui');
writeln('3: verifica se esta vazia');
writeln('4: Verifica se esta cheia');
writeln('5: Imprime Pilha');
writeln('6: Sair do programa');
quengaGorda:= 0;
while numero <> 6 do
	  begin
	  readln(numero);
	  	if numero = 1 then
	  	begin
	  		insere(fila1,quengaGorda);
	  		writeln('Digite um valor de 1 a 6:');
	  	end;
	  	if numero = 2 then
	  	begin
	  		remove(fila1,quengaGorda);
	  		writeln('Digite um valor de 1 a 6:');
	  		end;
	  	if numero = 3 then
	  		if ehvazio(fila1,quengaGorda) = true then
					writeln('Array vazio')
					else
					writeln('Não esta vazio');
	  	if numero = 4 then
	  		if ehCheia(fila1,quengaGorda) = true then
					writeln('Array cheio')
					else
					writeln('Não esta cheio');
	  	if numero = 5 then
	  		Escreve(fila1);
	    if numero = 6 then
	    	break;
	  	if numero > 6 then
	  		writeln('Valor invalido');
	  end;
	End.
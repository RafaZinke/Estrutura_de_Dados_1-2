Program Pzim ;
//cria o tipo pessoa
 type
 		pessoa = record
 			nome: string;
 			idPessoa: integer;
 			possuiIngresso: boolean;
 		end;		
//cria record de pilha de ingressos
	type
		pilhaIngresso = record
		topo: integer;
		idIngresso: array[1..50]of integer;
	end;
	var
		pilhaCamarote,pilhalateral,pilhagol : pilhaIngresso;
	
// cria filas de pessoas
	type
		filaPessoa = record
			topo: integer;
			idFila: array[1..50] of pessoa;
		end;
	var
		 filaGeral,filaCamarote : filaPessoa;
	
//criando as filas de camarote e geral
	procedure criaPilhaIngresso(var pilha:pilhaIngresso);
	var
	i:integer;
		begin
			for i := 1 to 50 do
				begin
				  pilha.idIngresso[i]:= i;
				end;	
		    pilha.topo := 50;
		end;
		
		

Begin
  
End.
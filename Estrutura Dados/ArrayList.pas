Program Pzim ;
		
	Type
		pessoa = record
			nome: string;
			idade: integer;
		end;
		vetor = array [1..4] of pessoa;
		var
		vetorPessoa:vetor;
		pessoa1: pessoa;
		i: integer;
		
		
		
		function criaPessoa(): pessoa;
	  var
		novaPessoa: pessoa;
		nome:string;
		idade:integer;
			begin
				writeln('Digite nome e idade');
				readln(nome);
	 			readln(idade);
		  	novaPessoa.nome := nome;
		  	novaPessoa.idade := idade;
		  	criaPessoa := novaPessoa;
			end;
		
	Begin
		 
		 for i:= 1 to 4 do
		 	begin
		 		vetorPessoa[i]:= criaPessoa();
			end; 
			
			for i:= 1 to 4 do
		 	begin
		 		writeln('Pessoa: ', i, ' nome:', vetorPessoa[i].nome,' Idade: ', 
				 vetorPessoa[i].idade);
			end; 
			 	
	End.
Program pzim ;

Type
	pessoa = record
   	nome: string;
   	idade: integer;
  end;
  
  var
  nome : string;
  idade:integer;
	pessoa1 : pessoa;
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
	pessoa1:= criaPessoa();
	writeln(pessoa1.nome); 
	writeln(pessoa1.idade); 
End.
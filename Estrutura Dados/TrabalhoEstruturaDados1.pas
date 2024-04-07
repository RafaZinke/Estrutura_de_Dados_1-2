Program Pzim ;
// variaveis globais
var
// esse id é um contador para atribuir as novas pessoas criadas.
id,totalIngressos,cond,num1,fila:integer;

//cria o record pessoa
 type
 		pessoa = record
 			nome: string;
 			idPessoa: integer;
 			tipoFila: integer;
 		end;		
//cria record de pilha de ingressos
	type
		pilhaIngresso = record
		topo: integer;
		idIngresso: array[1..50]of integer;
	end;
	var
		pilhaCamarote,pilhalateral,pilhagol : pilhaIngresso;
	
// cria record fila de pessoas
	type
		filaPessoa = record
			topo: integer;
			idFila: array[1..50] of pessoa;
		end;
	var
		 filaGeral,filaCamarote : filaPessoa;
		 
// Escreve valores da pilha de ingresso;
	procedure escrevePilha(pilha: pilhaIngresso);
	var
	i: integer;
		begin
			for i:= 1 to pilha.topo do
				writeln('| ',pilha.idIngresso[i]);
				writeln('Valores restantes: ', pilha.topo); 
		end;	 
// cria leitor de valores da fila
	procedure escreveFila(fila: filaPessoa);
	var
	i: integer;
	pes: pessoa;
		begin
		  for i := 1 to fila.topo -1 do
		  	begin
		  		pes:= fila.idFila[i];
		  	 	writeln('| ', 'Nome: ',pes.nome, ' Id: ', pes.idPessoa);
		  	end;
		end;
		 

// cria record lista de torcedores
	type
		listaTorcedor = record
			torcedores: array[1..150] of pessoa;	
			topo: integer;
		end;
	var
		listaTorcedor1: listaTorcedor;
			
	// Escreve valores listaTorcedores
	procedure escreveTorcedores();
	var i: integer;
	pes:pessoa;
		begin
		 for i:= 1 to listaTorcedor1.topo do
		 	begin
		 		pes := listaTorcedor1.torcedores[i];
		 		writeln('|', pes.nome, pes.idPessoa);
		 	end;
		end;
		
//criando as pilhas de camarote e geral
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
		    
// cria pessoa
		function criaPessoa(): pessoa;
		var
		p:pessoa;	
		nom: string;    
    	begin
    	writeln('Qual o nome da pessoa');
    		readln(nom);
    		p.nome := nom;
				p.idpessoa := id;		 
    	  id:= id+1;
    	  criaPessoa:= p;
    	  writeln('Pessoa de id: ', id-1, ' Com nome: ', p.nome, ' Criada.');
    	end;  
				
//RemoveIngressos baseado na qunatidade informada pela pessoa.
	procedure removeIngressos (quantidade:integer;var pilha: pilhaIngresso);
	var 
	i: integer;
		begin
		if quantidade < pilha.topo then
			begin
		 for i:= 1 to quantidade do
		      begin
		      	pilha.idIngresso[pilha.topo]:= 0;
		      	pilha.topo := pilha.topo - 1;
		      end;
			end
		else
			begin
			for i:= 1 to pilha.topo do
		      begin
		      	pilha.idIngresso[pilha.topo]:= 0;
		      	pilha.topo := pilha.topo - 1;
		      end;
			end;	
		end;
		
// PessoaEntraFila baseado em qual fila ela escolher
	  procedure insereFila(var filaGeral,filaCamarote: filaPessoa);
	  var
	  p:pessoa;
	  num:integer;
	  	begin
	  	  p:= criaPessoa();
	  	  writeln('Qual fila voce quer entrar?');
	  	  writeln('Digite 1 para entrar na fila geral; Digite 2 para entrar na fila de camarote');
	  	  readln(num);
	  	  if num = 1 then
	  	  	begin
	  	  		filaGeral.idFila[filaGeral.topo]:= p;
	  	  		filaGeral.topo:= filaGeral.topo + 1;
	  	  		p.tipoFila:= 1;
	  	  	end
	  	  	else
	  	  		if num = 2 then
	  	  			begin
	  	  			  filaCamarote.idFila[filaCamarote.topo]:= p;
	  	  				filaCamarote.topo := filaCamarote.topo + 1;
	  	  				p.tipoFila:= 1;
	  	  			end
	  	  				else
	  	  					writeln('Valor informado incorreto');
	  	 end;
	  //Remove pessoa da fila
	  	procedure removePessoaFila(var fila: filaPessoa);
	  	var
	  	i:integer;
	  		begin
	  			for i:= 1 to fila.topo do
	  			begin
						fila.idFila[i] := fila.idFila[i+1];	
					end;
					fila.topo := fila.topo -1;
	  		end;
	  		
	  //armazena lista de torcedores
	  	procedure armazenaListaTorcedor(fila: filaPessoa);
	  		begin
	  		  listaTorcedor1.torcedores[listaTorcedor1.topo]:= fila.idFila[1];
	  		  listaTorcedor1.topo:= listaTorcedor1.topo + 1;
	  		end;
	  		
		// Compra ingresso para primeira pessoa na fila informada, depois remove essa pessoa da fila e 
		// armazena na de torcedor.	  	 
	 procedure compraIngresso(tipo:integer);
	 var
	  assento ,quantidadeIngressos:integer;
	  	  begin
					// qual fila a pessoa esta, entao atribui a variavel x, que entra na condicional de compra de ingresso.
						if tipo = 1 then
							begin
								writeln('Qual assento voce deseja?');
								writeln('Digite 1 -> Lateral, Digite 2 -> Atrás do gol');
								readln(assento);
								// faz a compra do ingresso na lateral do gol
								if assento = 1 then
									begin	
							  		writeln('Quantos ingressos queres comprar (Maximo de 6)?');
							  		readln(quantidadeIngressos);
							  		if quantidadeIngressos > 6 then
							  			writeln('Quantidade deve ser menor ou igual a 6')
							  		else
							  			begin
							  		 		armazenaListaTorcedor(filaGeral);
							  		  	removePessoaFila(filaGeral);
							  		  	removeIngressos(quantidadeIngressos,pilhalateral);
							  		  	
							  		  	if quantidadeIngressos <  pilhalateral.topo then
							  		  	totalIngressos := totalIngressos + (quantidadeIngressos * 80)
							  		  	else
							  		  	totalIngressos:= totalIngressos + (pilhalateral.topo * 80);
							  			end;
							  	end; 
							  		//faz a compra do ingresso atrás do gol	 
									if assento = 2 then 
										begin
									    writeln('Quantos ingressos queres comprar (Maximo de 6)?');
							  			readln(quantidadeIngressos);
							  			if quantidadeIngressos > 6 then
							  				writeln('Quantidade deve ser menor ou igual a 6')
							  				else
							  					begin
							  		 				armazenaListaTorcedor(filaGeral);
							  		  			removePessoaFila(filaGeral);
							  		  			removeIngressos(quantidadeIngressos,pilhagol);
							  		  			if quantidadeIngressos <  pilhagol.topo then
							  		  			totalIngressos := totalIngressos + (quantidadeIngressos * 50)
							  		  			else
							  		  			totalIngressos := totalIngressos + (pilhagol.topo * 50);
							  					end;
							  			end;	
											// fim da verificação se x = 1									
									end;
									// Faz a compra na fila de camarote	
						if tipo = 2 then
							begin
								writeln('Quantos ingressos queres comprar (Maximo de 6)?');
							  	readln(quantidadeIngressos);
							  	if quantidadeIngressos > 6 then
							  		writeln('Quantidade deve ser menor ou igual a 6')
							  	else
							  		begin
							  		 	armazenaListaTorcedor(filaCamarote);
							  		  removePessoaFila(filaCamarote);
							  		  removeIngressos(quantidadeIngressos,pilhaCamarote);
							  		  if quantidadeIngressos <  pilhaCamarote.topo then
							  		  totalIngressos := totalIngressos + (quantidadeIngressos * 150)
							  		  else
							  		  totalIngressos := totalIngressos + (pilhaCamarote.topo * 150);
							  		end;
							end
							else
								writeln('Valor incorreto');										   
	  	  	end;

Begin
//cria as 3 pilhas de ingresso
criaPilhaIngresso(pilhaCamarote);
criaPilhaIngresso(pilhalateral);
criaPilhaIngresso(pilhagol);
//inicia o topo das filas e da lista de torcedores
filaGeral.topo := 1;
filaCamarote.topo:= 1;
listaTorcedor1.topo:= 1;
//inicia o delimitador para 1
id := 1;

 while cond  <> 10 do
 	begin
 	writeln;
    writeln ('    MENU    ');
    writeln ('------------'); 
    writeln('1 - Coloca pessoa na fila.');
    writeln('2 - Escreve fila de Camarote.');
    writeln('3 - Escreve fila Geral.');
    writeln('4 - Compra Ingresso');
    writeln('5 - Verifica pilha Ingressos');
    writeln('6 - Valor arrecadado:');
    writeln('7- Lista torcedores:');
    writeln('10 - Sair do programa');
  	readln(cond);
  	
  	if cond = 1 then
  		begin
  		  insereFila(filaGeral,filaCamarote);
  		end;
  	if cond = 2 then
  		begin
  		  escreveFila(filaCamarote);
  		end;
  	if cond = 3 then
  		begin
  			escreveFila(filaGeral);
  		end;
  	if cond = 4 then
  		begin
  		if (filaCamarote.topo > 1)or (filaGeral.topo > 1) then
  			begin
  				writeln('Qual fila ira comprar o ingresso? 1: Geral, 2: Camarote');
  				readln(fila);
  			end
  				else
  		  		writeln('Não existem pessoas na fila');
  		  	
  		if fila = 2 then
  		begin
  			if filaCamarote.topo > 1 then
  		  compraIngresso(fila)
  		  else
  		writeln('Não existem pessoas na fila');
  		 end;
  		if fila = 1 then
  		begin
  			if filaGeral.topo > 1 then
  		  compraIngresso(fila)
  		  else
  		writeln('Não existem pessoas na fila');
  		end;
  	end;	  
  		
  	if cond = 5 then
  		begin
  		  writeln('Qual pilha queres verificar?');
  		  writeln('Digite 1 para Camarote, 2 para Lateral, 3 para Atrás do gol: ');
  		  readln(num1);
  		  	if num1 = 1 then
  		  		begin
  		  		  escrevePilha(pilhaCamarote)
  		  		end;
  		  	if num1 = 2 then
  		  		begin
  		  		  escrevePilha(pilhaLateral)
  		  		end;
  		  	if num1 = 3 then
  		  		begin
  		  		  escrevePilha(pilhaGol)
  		  		end;
  		end;
  		
  		if cond = 6 then
  			begin
  			writeln('Valor total arrecadado: ');
  			writeln(totalIngressos, ',00.');
  			end;
  			
  		if cond = 7 then
  			begin
  			 escreveTorcedores(); 			
  			end;
  		if cond = 10 then
  		begin
  		  writeln('Encerrando programa');
  		  break;
  		end;
 	end;
//1 - > pessoa entra na fila
//2 -> compra ingresso (primeira pessoa da fila é oferecida a opçao
// de comprar igresso (1 a 6)) executa entao a procedure removeingresso da fila
// e insere pessoa na lista de torcedores com a procedure insereTorcedor.
End.
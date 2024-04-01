Program Pzim ;

// 3 pilhas ingresso (1-100, 101-200, 201-300)
// cada pilha de ingresso é pré cadastrada em um array de inteiro
// 2 filas de compradores (fila aceita tipo pessoa)
// 6 ingressos por comprador, armazena uma booleana para cade ID de pessoa se tem ou não ingresso
// pra cada ingresso que sai da pilha é armazenado numa variavel total1,2,3
//a lista de pessoas deve ser feita com record de pessoas com as informações:
  // ID,nome,valorCarteira.
  
  type
  pessoa = record
    possuiIngresso: boolean;
    nome:string;
    id:integer;
  end;
  
  pilhaIngresso = array[1..100] of integer;
  filaPessoa = array[1..10]of pessoa;
  torcedor = array[1..100] of pessoa;
  listaPessoa = array [1..5] of pessoa;
  
  var
  idpessoa,idCamarote,idGeral: integer;
  Camarotes,Lateral,atrasGol: pilhaIngresso ;
  filaCamarote,filaGeral: filaPessoa;
  i,topoCamarote,topoLateral,topoAtrasGol:integer;
  pessoa1,pessoa2:pessoa;
  listaPessoa1: listaPessoa;
  
  
		procedure preencheIngresso();
		var
		i: integer;
  begin
    for i:= 1 to 100 do
    begin
      Camarotes[i]:= i;
      lateral[i]:= i+100;
      atrasGol[i]:= i+200;
    end;
  end;
  
    function criaPessoa ():pessoa;
    var
    novapessoa: pessoa;
    nome: string;
    id: integer;
    possuiIngresso:boolean;
    	begin
    	   novapessoa.id := idpessoa;
    	   idpessoa:= idpessoa+1;
    	   novapessoa.possuiIngresso:=false;
    	   writeln('Qual o nome da pessoa: ');
    	   readln(novapessoa.nome);
    	    criaPessoa:= novapessoa;
    	end;
  
     procedure entraFilaCamarote(var filaCamarote:filaPessoa;
		 var pessoaFila: pessoa;var pos1:integer);
     	begin
     	  if filaCamarote[10].id <> 0  then
     	  	writeln('A fila esta Cheia favor esperar')
     	  	else
     	  	begin
     	  	filaCamarote[pos1] := pessoaFila;
     	  	pos1:= pos1+1;
					end;		  
     	end;
     	
     	 procedure entraFilaGeral(var filaGeral:filaPessoa;
		 var pessoaFila: pessoa; var pos2:integer);
     	begin
     	  if filaGeral[10].id <> 0  then
     	  	writeln('A fila esta Cheia favor esperar')
     	  	else
     	  	begin
     	  	filaGeral[pos2] := pessoaFila;
     	  	pos2 := pos2+1;
					end;		  
     	end;
        
      procedure arrayListPessoa(var lista : listaPessoa);
      var 
      i:integer;
      	begin
      	   for i:= 1 to 5 do
      	   	 lista[i] := criaPessoa();
      	end;
  

  		procedure compraIngressoCamarote(var lista: filaPessoa;
			var pes: pessoa);
  		var
  		quantidade,i:integer;
  			begin
  		   pes:= lista[1];
  		   	writeln('Quantos ingressos queres comprar?');
  		   	readln(quantidade);
  		   	if quantidade > 6 then	
  		   		writeln('O limite de ingressos que podes comprar é 6')
  		   	else
  		   		begin
  		   			for i := 1 to quantidade do
  		   				begin
  		   				Camarotes[topoCamarote] := 0;
  		   				topoCamarote:= topoCamarote -1;
  		   				end;
  		   			  pes.possuiIngresso:=true;
  		   			  lista[1]:= lista[2];
  		   		end;
  		
  			end;
  Begin
  topoCamarote:= 100;
  idCamarote :=1;
  idGeral:= 1;
  idpessoa:= 1;
  preencheIngresso();
  arrayListPessoa(listaPessoa1);
  entraFilaCamarote(filaCamarote,listaPessoa1[1],idCamarote);
  pessoa1:= listaPessoa[1];
  for i:= 1 to 5 do 	
  	begin
  	   	writeln('|', filaCamarote[i].nome, ' id: ', filaCamarote[i].id, ' Possui ingresso? ',
		filaCamarote[i].possuiIngresso );
  	end;
  for i:= 1 to 5 do 	
  	begin
  	write('|', listaPessoa1[i].nome, ' id: ', listaPessoa1[i].id, ' Possui ingresso? ',
		listaPessoa1[i].possuiIngresso );
  	end;
  	CompraIngressoCamarote(filaCamarote,pessoa1);
  	 for i:= 1 to 5 do 	
  	begin
  	write('|', listaPessoa1[i].nome, ' id: ', listaPessoa1[i].id, ' Possui ingresso? ',
		listaPessoa1[i].possuiIngresso );
  	end;
  	 for i:= 1 to 5 do 	
  	begin
  	   	writeln('|', filaCamarote[i].nome, ' id: ', filaCamarote[i].id, ' Possui ingresso? ',
		filaCamarote[i].possuiIngresso );
  	end;
  
  End.
Program FilasCopytech ;

type
pessoa = record
	nome: string;
	copias: integer;
	prioridade: boolean;
end;

ptnodo = ^elemento;
elemento = record
	p : pessoa;
	prox : ptnodo;
	anterior : ptnodo;
end;

Filas = record
	primeiro, ultimo: ptnodo;
end;

var
filaMono, filaColor, filaPloter : Filas;
numero, nfila: integer;

procedure iniciaFila(var fila: Filas);
begin
	fila.primeiro := nil;
	fila.ultimo := nil;
end;

function criaCliente(): pessoa;
var 
p1: pessoa;
copias: integer;
nome: string;
begin
	writeln('Informe nome e quantidade de copias que desja fazer: ');
	writeln('Nome: ');
	readln(nome);
	p1.nome:= nome;
	writeln('Quantidade de copias: ');
	readln(copias);
	p1.copias:= copias;
	criaCliente:= p1;
end;

procedure insereFila(var fila: Filas);
var
pes1: pessoa;
aux: ptnodo;
begin
	new(aux);
	pes1:= criaCliente();
	aux^.p := pes1;
	aux^.prox := nil;
	aux^.anterior := fila.ultimo;

	if fila.primeiro = nil then
	begin
		fila.primeiro:= aux;
	end
	else
	begin
		fila.ultimo^.prox := aux;
	end;
	
	fila.ultimo:= aux;
end;

procedure lerValores(fila: Filas);
var
	aux: ptnodo;
begin
	aux := fila.primeiro;
	while aux <> nil do
	begin
		writeln('Nome: ', aux^.p.nome, ' Numero de copias: ', aux^.p.copias);
		aux := aux^.prox;
	end;
end;

procedure total (fila: Filas);
var quantidadePessoas,quantidadeCopias : integer;
aux : ptnodo;
	begin
	  aux := fila.primeiro;
	  while aux <> nil do
	  	begin
	  	 quantidadePessoas := quantidadePessoas +1;
	  	 quantidadeCopias := quantidadeCopias + aux^.p.copias;
	  	 aux := aux^.prox;
	  	end;
	    writeln('Quantidade de pessoas na fila: ',quantidadePessoas); 
	    writeln('Quantidade de copias totais na fila: ',quantidadeCopias);
	end;

procedure deletaValor(var fila: Filas);
var
  aux: ptnodo;
begin
  if fila.primeiro = nil then
  begin
    writeln('A fila está vazia. Não há elementos para deletar.');
    exit;
  end;

  aux := fila.primeiro;

  if fila.primeiro = fila.ultimo then
  begin
    fila.primeiro := nil;
    fila.ultimo := nil;
  end
  else
  begin
    fila.primeiro := aux^.prox;
    fila.primeiro^.anterior := nil;
  end;

  Dispose(aux);
  writeln('Elemento deletado.');
end;

	procedure prioridade(var fila: Filas);
var
  aux, anterior: ptnodo;
  nomep: string;
begin
  if fila.primeiro = nil then
  begin
    writeln('A fila está vazia. Não há elementos para dar prioridade.');
    exit;
  end;

  if fila.primeiro^.p.prioridade then
  begin
    writeln('O usuário ', fila.primeiro^.p.nome, ' já tem prioridade.');
    exit;
  end;

  writeln('Que usuário da fila deseja dar prioridade?');
  readln(nomep);

  aux := fila.primeiro;
  anterior := nil;

  while aux <> nil do
  begin
    if aux^.p.nome = nomep then
    begin
      aux^.p.prioridade := true;

      if anterior <> nil then
      begin
        anterior^.prox := aux^.prox;
        if aux^.prox <> nil then
          aux^.prox^.anterior := anterior
        else
          fila.ultimo := anterior;
      end
      else
      begin
        fila.primeiro := aux^.prox;
        if fila.primeiro <> nil then
          fila.primeiro^.anterior := nil
        else
          fila.ultimo := nil;
      end;

      aux^.prox := fila.primeiro;
      aux^.anterior := nil;
      if fila.primeiro <> nil then
        fila.primeiro^.anterior := aux;
      fila.primeiro := aux;

      writeln('Prioridade dada ao usuário: ', nomep);
      exit;
    end;

    anterior := aux;
    aux := aux^.prox;
  end;

  writeln('Usuário não encontrado na fila.');
end;
	
Begin
	iniciaFila(filaMono);
	iniciaFila(filaColor);
	iniciaFila(filaPloter);
	
	Writeln('Digite os respectivos valores para realizar as açoes:');
writeln('1: insere');
writeln('2: exclui');
writeln('3: Imprime Fila');
writeln('4: Total de pessoas/copias na fila');
writeln('5: Colocar pessoa como prioridade');
writeln('8: Sair do programa');
	while (numero <> 8 ) do
		begin
		readln(numero);
		
		if numero = 1 then
			begin
				writeln('Digite 1: FILA MONO. Digite 2: FILA COLOR. Digite 3: FILA PLOTER.');
					readln(nfila);
					if nfila = 1 then
						begin
						insereFila(filaMono)
						end;
						if nfila = 2 then
						begin
						insereFila(filaColor)
						end;
						if nfila = 3 then
						begin
						insereFila(filaPloter)
						end;
						 
			end;	
		
		if numero = 2 then 
			begin
			  writeln('Digite 1: FILA MONO. Digite 2: FILA COLOR. Digite 3: FILA PLOTER.');
					readln(nfila);
					if nfila = 1 then
						begin
						deletaValor(filaMono)
						end;
						if nfila = 2 then
						begin
						deletaValor(filaColor)
						end;
						if nfila = 3 then
						begin
						deletaValor(filaPloter)
						end;
			end;
		if numero = 3 then
			begin
			  writeln('Digite 1: FILA MONO. Digite 2: FILA COLOR. Digite 3: FILA PLOTER.');
					readln(nfila);
					if nfila = 1 then
						begin
						lerValores(filaMono)
						end;
						if nfila = 2 then
						begin
						lerValores(filaColor)
						end;
						if nfila = 3 then
						begin
						lerValores(filaPloter)
						end;
			end;
		if numero = 4 then
			begin
			 writeln('Digite 1: FILA MONO. Digite 2:FILA COLOR. Digite 3: FILA PLOTER.');
					readln(nfila);
					if nfila = 1 then
						begin
						total(filaMono)
						end;
						if nfila = 2 then
						begin
						total(filaColor)
						end;
						if nfila = 3 then
						begin
						total(filaPloter)
						end;
			end;
		   
	
	if numero = 5 then
		begin
		writeln('Digite 1: FILA MONO. Digite 2: FILA COLOR. Digite 3: FILA PLOTER.');
					readln(nfila);
					if nfila = 1 then
						begin
						prioridade(filaMono)
						end;
						if nfila = 2 then
						begin
						prioridade(filaColor)
						end;
						if nfila = 3 then
						begin
						prioridade(filaPloter)
						end;
		end;
		writeln('Digite um novo numero para continuar o programa: ');
	end;
End.

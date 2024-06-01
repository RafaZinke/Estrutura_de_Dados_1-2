Program FilasCopytech ;

type
pessoa = record
	nome: string;
	copias: integer;
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

procedure deletaValor(var fila: Filas);
var aux: ptnodo;
begin
  if fila.ultimo = nil then
  begin
    writeln('A fila está vazia. Não há elementos para deletar.');
    exit;
  end;

  aux := fila.ultimo;

  if fila.primeiro = fila.ultimo then
  begin
    // Se a fila tiver apenas um elemento
    fila.primeiro := nil;
    fila.ultimo := nil;
  end
  else
  begin
    // Se a fila tiver mais de um elemento
    fila.ultimo := aux^.anterior;
    fila.ultimo^.prox := nil;
  end;

  Dispose(aux);
  writeln('Elemento deletado.');
	end;
	
Begin
	iniciaFila(filaColor);
	insereFila(filaColor);                    
	insereFila(filaColor);
	insereFila(filaColor);
	lerValores(filaColor); 
	deletaValor(filaColor);
	lerValores(filaColor);
	deletaValor(filaColor);
	lerValores(filaColor);
	deletaValor(filaColor);
	lerValores(filaColor); 
	insereFila(filaColor);
	lerValores(filaColor);
End.

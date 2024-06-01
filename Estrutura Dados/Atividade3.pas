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
	  aux^.anterior:= nil;
	  
	  
	  
	  
	end;
	
Begin
  
End.
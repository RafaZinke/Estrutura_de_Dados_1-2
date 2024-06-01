Program filadinamica;

type
tipoInt = integer;
ptnodo = ^elemento;
elemento = record
  dado : tipoInt;
  prox : ptnodo
end;

var
fila : ptnodo;
value : tipoInt;

procedure inicia(var fila : ptnodo);
begin
  fila := nil;
end;

procedure insereValor(valor : tipoInt; var fila: ptnodo);
var aux, atual, anterior: ptnodo;
begin
  new(aux);
  aux^.dado:= valor;
  aux^.prox:= nil;
  
  if fila = nil then
  fila:= aux
  else
  atual:= fila;
  begin
    while (atual^.prox <> nil) do
    begin
      anterior := atual;
      atual:= atual^.prox;
    end;
    atual^.prox := aux;
  end;
end;

procedure lerValores(fila: ptnodo);
var aux: ptnodo;
begin
  aux:= fila;
  while(aux <> nil) do
  begin
    writeln(aux^.dado);
    aux:= aux^.prox;
  end;
end;

procedure deletaValor(var fila : ptnodo);
var aux: ptnodo;
	begin
	  aux:= fila;
	  fila:= aux^.prox;
	  dispose(aux);
	end;

Begin
  inicia(fila);
  readln(value);
  insereValor(value, fila);
  readln(value);
  insereValor(value, fila);
  readln(value);
  insereValor(value, fila);
  lerValores(fila);
  writeln('');
  deletaValor(fila);
  deletaValor(fila);
  lerValores(fila);
  
End.
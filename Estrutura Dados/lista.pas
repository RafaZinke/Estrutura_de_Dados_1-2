program Pzim;

type
  lista = array[1..4] of integer;

var
  v: lista;
  numero: integer;

function ehVazio(lista1: lista): boolean;
begin
  if lista1[1] = 0 then
    ehVazio := true
  else
    ehVazio := false;
end;

function ehCheia(lista1: lista): boolean;
begin
  if lista1[4] <> 0 then
    ehCheia := true
  else
    ehCheia := false;
end;

procedure insere(var lista1: lista);
var
  x, pos: integer;
  p: boolean;
begin
  writeln('Digite o valor que você quer inserir:');
  readln(x);
  writeln('Qual posição:');
  readln(pos);

  while (p = false) do
  begin
    if lista1[pos] > 0 then
    begin
      writeln('Ja existe um valor nessa posição, escolha outra posicao');
      readln(pos);
    end
    else
      p := true;
  end;

  lista1[pos] := x;
end;

procedure remove(var lista1: lista);
var
  pos: integer;
  p: boolean;
begin
  writeln('Digite a posicao que queres remover o valor:');
  readln(pos);

  while (p = false) do
  begin
    if lista1[pos] = 0 then
    begin
      writeln('Não existe um valor nessa posição, escolha outra posicao');
      readln(pos);
    end
    else
      p := true;
  end;

  lista1[pos] := 0;
end;

procedure escreveLista(lista1: lista);
var
  i: integer;
begin
  for i := 1 to 4 do
    write('|', ' ', lista1[i]);
end;

begin
  writeln('Digite os respectivos valores para realizar as ações:');
  writeln('1: insere');
  writeln('2: exclui');
  writeln('3: verifica se esta vazia');
  writeln('4: Verifica se esta cheia');
  writeln('5: Imprime Lista');
  writeln('6: Sair do programa');

  while numero <> 6 do
  begin
    readln(numero);
    if numero = 1 then
    begin
      insere(v);
      writeln('Digite um valor de 1 a 6:');
    end;
    if numero = 2 then
    begin
      remove(v);
      writeln('Digite um valor de 1 a 6:');
    end;
    if numero = 3 then
      if ehVazio(v) then
        writeln('Lista vazia')
      else
        writeln('Lista Não está vazia');
    if numero = 4 then
      if ehCheia(v) then
        writeln('Lista cheia')
      else
        writeln('Lista Não está cheia');
    if numero = 5 then
    begin
      escreveLista(v);
      writeln;
      writeln('Digite um valor de 1 a 6:');
    end;
    if numero > 6 then
      writeln('Valor inválido');
  end;
end.

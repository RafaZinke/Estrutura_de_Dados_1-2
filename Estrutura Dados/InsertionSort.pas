	 //Rafael zink e Carlos
program InsertSort;

type
  vetor = array[1..15] of integer;

var
  v1: vetor;
  i, j, valor: integer;

procedure criaArray(var v: vetor);
begin
  for i := 1 to 15 do
    v[i] := Random(100) + 1;  
end;

procedure insertionSort(var v: vetor);
begin
  for i := 2 to 15 do  
  begin
    valor := v[i];
    j := i - 1;

    while (j >= 1) and (v[j] > valor) do
    begin
      v[j + 1] := v[j];
      j := j - 1;  
    end;

    v[j + 1] := valor;
  end;
end;

begin
  criaArray(v1);

  Writeln('Array original:');
  for i := 1 to 15 do
    Write(v1[i]:3, ' '); 

  Writeln;

  insertionSort(v1);

  Writeln('Array após ser organizado:');
  for i := 1 to 15 do
    Write(v1[i]:3, ' ');

  Writeln;
end.

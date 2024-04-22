program selecSort;

var
  vetor: array[1..500] of integer;
  tam,j,i, menor, aux: integer;

begin

	writeln('Informe a quantidade de elementos do vetor: ');
	readln(tam);
	
  for i := 1 to tam do
  begin
  	writeln;
  	write('Digite o valor da posição ',i,' : ');
    readln(vetor[i]);
  end;


  writeln('Vetor original:');
  for i := 1 to tam do
    write(vetor[i], '| ');

  for i := 1 to tam-1 do
  begin
    menor := i;
    for j := i + 1 to tam do
      if vetor[j] < vetor[menor] then
        menor := j;
        
			aux := vetor[i];
			vetor[i] := vetor[menor];
    	vetor[menor] := aux;

  end;

  writeln('Vetor ordenado:');
  for i := 1 to tam do
    write(vetor[i], '| ');
end.
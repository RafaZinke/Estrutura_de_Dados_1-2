Program Pzim;

type
  tipo_string = string;
  ptnodo = ^elemento;
  elemento = record
    dado: tipo_string;
    prox: ptnodo;
  end;

var
  lista: ptnodo;
  valor: tipo_string;
  numero: integer;
  nomecidade: string;

procedure criaLista(var lista: ptnodo);
begin
  lista := nil;
end;

procedure insereLista(var lista: ptnodo; nome: tipo_string);
var
  cidade, atual, anterior: ptnodo;
begin
  new(cidade);
  cidade^.dado := nome;
  cidade^.prox := nil;

  if lista = nil then
    lista := cidade
  else
  begin
    atual := lista;
    anterior := nil;

    while (atual <> nil) and (atual^.dado < nome) do
    begin
      anterior := atual;
      atual := atual^.prox;
    end;

    if anterior = nil then
    begin
      cidade^.prox := lista;
      lista := cidade;
    end
    else
    begin
      anterior^.prox := cidade;
      cidade^.prox := atual;
    end;
  end;
end;

procedure ListarCidades(cidade: ptnodo);
var
  atual: ptnodo;
begin
  atual := cidade;

  while atual <> nil do
  begin
    WriteLn(atual^.dado);
    atual := atual^.prox;
  end;
end;

procedure RemoverCidade(var cidade: ptnodo; nome: tipo_string);
var
  atual, anterior: ptnodo;
begin
  if cidade = nil then
    Exit;

  atual := cidade;
  anterior := nil;

  while (atual <> nil) and (atual^.dado <> nome) do
  begin
    anterior := atual;
    atual := atual^.prox;
  end;

  if atual = nil then
    Exit;

  if anterior = nil then
    cidade := cidade^.prox
  else
    anterior^.prox := atual^.prox;

  Dispose(atual);
end;

Begin
  criaLista(lista);
  numero:= 1;
		while numero<>0 do
    begin
      
       writeln ('0-Sair');
       writeln ('1-Inserir');
       writeln ('2-Remover');
       writeln ('3-Mostrar lista');
       readln (numero);
       writeln;
       case numero of
          1: begin
          		writeln('Qual o nome da cidade (Deve iniciar com uma letra maiuscula)');
          		readln(nomeCidade);
              insereLista(lista, nomecidade);
             end;
          2: begin
              writeln('Qual cidade deseja remover?');
              readln(nomeCidade);
              RemoverCidade(lista, nomecidade);
             end;
          3: begin
               writeln('Imprime lista');
               ListarCidades(lista);
             end;
       end;
				
		
		
		end;
  
End.

program TabelaHashPlacas;

const
  TamanhoTabela = 6; // Defina o tamanho fixo da tabela

type
  PElemento = ^TElemento;
  TElemento = record
    Placa: string;
    Ocupado: boolean;
    Proximo: PElemento; // Apontador para lidar com colis�es
  end;

var
  Tabela: array[0..TamanhoTabela - 1] of PElemento;
  opcao: integer;

// Fun��o para obter a posi��o de uma letra no alfabeto
function PosicaoNoAlfabeto(Caractere: char): integer;
begin
  if Caractere in ['A'..'Z'] then
    PosicaoNoAlfabeto := Ord(Caractere) - Ord('A') + 1 // Letras mai�sculas
  else if Caractere in ['a'..'z'] then
    PosicaoNoAlfabeto := Ord(Caractere) - Ord('a') + 1 // Letras min�sculas
  else
    PosicaoNoAlfabeto := 0; // N�o � uma letra
end;

// Fun��o Hash usando soma de posi��es no alfabeto
function FuncaoHash(Placa: string): integer;
var
  Soma, i: integer;
begin
  Soma := 0;
  for i := 1 to Length(Placa) do
  begin
    if Placa[i] in ['A'..'Z', 'a'..'z'] then
      Soma := Soma + PosicaoNoAlfabeto(Placa[i]) // Soma posi��es no alfabeto
    else if Placa[i] in ['0'..'9'] then
      Soma := Soma + Ord(Placa[i]) - Ord('0'); // Soma o valor num�rico diretamente
  end;
  FuncaoHash := Soma mod TamanhoTabela;
end;

// Inicializa a Tabela
procedure InicializarTabela;
var
  i: integer;
begin
  for i := 0 to TamanhoTabela - 1 do
    Tabela[i] := nil;
end;

// Adiciona uma Placa na Tabela HASH
procedure AdicionarPlaca(Placa: string);
var
  Hash: integer;
  NovoElemento: PElemento;
  Atual: PElemento;
begin
  Hash := FuncaoHash(Placa);

  // Cria��o do novo elemento
  New(NovoElemento);
  NovoElemento^.Placa := Placa;
  NovoElemento^.Ocupado := True;
  NovoElemento^.Proximo := nil;

  // Se o �ndice est� vazio, insere diretamente
  if Tabela[Hash] = nil then
  begin
    Tabela[Hash] := NovoElemento;
    Writeln('Placa ', Placa, ' adicionada no �ndice ', Hash);
  end
  else
  begin
    // Percorre a lista at� o final para adicionar o novo elemento
    Atual := Tabela[Hash];
    while Atual^.Proximo <> nil do
      Atual := Atual^.Proximo;

    Atual^.Proximo := NovoElemento;
    Writeln('Placa ', Placa, ' adicionada ao �ndice ', Hash, ' (colis�o resolvida por encadeamento).');
  end;
end;

// Remove a �ltima placa no �ndice informado
procedure RemoverPlacaPorIndice(Indice: integer);
var
  Atual, Anterior: PElemento;
begin
  // Verifica se o �ndice � v�lido
  if (Indice < 0) or (Indice >= TamanhoTabela) then
  begin
    Writeln('Erro: �ndice inv�lido.');
    Exit;
  end;

  // Verifica se o �ndice est� vazio
  if Tabela[Indice] = nil then
  begin
    Writeln('Erro: Nenhuma placa encontrada no �ndice ', Indice, '.');
    Exit;
  end;

  Atual := Tabela[Indice];
  Anterior := nil;

  // Percorre a lista at� o �ltimo elemento
  while Atual^.Proximo <> nil do
  begin
    Anterior := Atual;
    Atual := Atual^.Proximo;
  end;

  // Remove o �ltimo elemento
  if Anterior = nil then
  begin
    // Caso seja o �nico elemento na lista
    Tabela[Indice] := nil;
  end
  else
  begin
    // Caso haja mais de um elemento na lista
    Anterior^.Proximo := nil;
  end;

  Writeln('Placa ', Atual^.Placa, ' removida do �ndice ', Indice, '.');
  Dispose(Atual); // Libera a mem�ria
end;

// Exibe a Tabela
procedure ExibirTabela;
var
  i: integer;
  Atual: PElemento;
begin
  Writeln('Tabela Hash:');
  for i := 0 to TamanhoTabela - 1 do
  begin
    Write(i, ': ');
    Atual := Tabela[i];
    if Atual = nil then
      Writeln('[vazio]')
    else
    begin
      while Atual <> nil do
      begin
        Write(Atual^.Placa);
        if Atual^.Proximo <> nil then
          Write(' -> ');
        Atual := Atual^.Proximo;
      end;
      Writeln;
    end;
  end;
end;

// Menu Principal
procedure Menu;
var
  Placa: string;
  Indice: integer;
begin
  repeat
    Writeln('--- MENU ---');
    Writeln('1. Adicionar placa');
    Writeln('2. Exibir tabela');
    Writeln('3. Remover placa por �ndice');
    Writeln('4. Sair');
    Write('Escolha uma opcao: ');
    Readln(opcao);

    case opcao of
      1:
        begin
          Write('Digite a placa (formato ABC1D23): ');
          Readln(Placa);
          if Length(Placa) = 7 then
            AdicionarPlaca(Placa)
          else
            Writeln('Erro: Placa inv�lida. Certifique-se de usar o formato correto.');
        end;
      2:
        ExibirTabela;
      3:
        begin
          Write('Digite o �ndice onde deseja remover a �ltima placa: ');
          Readln(Indice);
          RemoverPlacaPorIndice(Indice);
        end;
      4:
        Writeln('Saindo do programa...');
      else
        Writeln('Opcao invalida! Tente novamente.');
    end;
    Writeln; // Linha em branco para separa��o entre opera��es
  until opcao = 4;
end;

// Programa Principal
begin
  InicializarTabela;
  Menu;
end.

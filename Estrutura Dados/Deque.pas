program deque;

type
  tipo_inf = integer;
  ptnodo = ^tnodo;
  tnodo = record
    dado: tipo_inf;
    prox, ant: ptnodo;
  end;

var
  inicio: ptnodo;
  fim: ptnodo;
  qtdElementos: integer;

procedure inicializaDeque(var inicio: ptnodo; var fim: ptnodo; var qtdElementos: integer);
begin
  inicio := nil;
  fim := nil;
  qtdElementos := 0;
end;

procedure insereInicio(var inicio: ptnodo; var fim: ptnodo; var qtdElementos: integer; valor: tipo_inf);
var
  novo: ptnodo;
begin
  new(novo);
  if novo = nil then
  begin
    writeln('Memória cheia');
    exit;
  end;
  novo^.dado := valor;
  novo^.prox := inicio;
  novo^.ant := nil;
  if inicio <> nil then
    inicio^.ant := novo;
  inicio := novo;
  if fim = nil then
    fim := novo;
  qtdElementos := qtdElementos + 1;
end;

procedure insereFim(var inicio: ptnodo; var fim: ptnodo; var qtdElementos: integer; valor: tipo_inf);
var
  novo: ptnodo;
begin
  new(novo);
  if novo = nil then
  begin
    writeln('Memória cheia');
    exit;
  end;
  novo^.dado := valor;
  novo^.prox := nil;
  novo^.ant := fim;
  if fim <> nil then
    fim^.prox := novo;
  fim := novo;
  if inicio = nil then
    inicio := novo;
  qtdElementos := qtdElementos + 1;
end;

procedure removeInicio(var inicio: ptnodo; var fim: ptnodo; var qtdElementos: integer; var valor: tipo_inf);
var
  temp: ptnodo;
begin
  if inicio = nil then
  begin
    writeln('Deque vazio');
    exit;
  end;
  valor := inicio^.dado;
  temp := inicio;
  inicio := inicio^.prox;
  if inicio <> nil then
    inicio^.ant := nil;
  if inicio = nil then
    fim := nil;
  dispose(temp);
  qtdElementos := qtdElementos - 1;
end;

procedure removeFim(var inicio: ptnodo; var fim: ptnodo; var qtdElementos: integer; var valor: tipo_inf);
var
  temp: ptnodo;
begin
  if fim = nil then
  begin
    writeln('Deque vazio');
    exit;
  end;
  valor := fim^.dado;
  temp := fim;
  fim := fim^.ant;
  if fim <> nil then
    fim^.prox := nil;
  if fim = nil then
    inicio := nil;
  dispose(temp);
  qtdElementos := qtdElementos - 1;
end;

function acessoInicio(inicio: ptnodo): tipo_inf;
begin
  if inicio = nil then
  begin
    writeln('Deque vazio');
    halt;
  end;
  acessoInicio := inicio^.dado;
end;

function acessoFim(fim: ptnodo): tipo_inf;
begin
  if fim = nil then
  begin
    writeln('Deque vazio');
    halt;
  end;
  acessoFim := fim^.dado;
end;

function tamanhoDeque(qtdElementos: integer): integer;
begin
  tamanhoDeque := qtdElementos;
end;

function dequeVazio(inicio: ptnodo): boolean;
begin
  dequeVazio := inicio = nil;
end;

function dequeCheio: boolean;
begin
  dequeCheio := false;
end;

var
  opcao: integer;
  valor: tipo_inf;

begin
  inicializaDeque(inicio, fim, qtdElementos);
  repeat
    writeln('Menu:');
    writeln('1. Inserir no início');
    writeln('2. Inserir no fim');
    writeln('3. Remover do início');
    writeln('4. Remover do fim');
    writeln('5. Acessar o início');
    writeln('6. Acessar o fim');
    writeln('7. Verificar tamanho');
    writeln('8. Verificar se está vazio');
    writeln('9. Verificar se está cheio');
    writeln('0. Sair');
    writeln('Escolha uma opção:');
    readln(opcao);

    case opcao of
      1: begin
        writeln('Digite o valor:');
        readln(valor);
        insereInicio(inicio, fim, qtdElementos, valor);
      end;
      2: begin
        writeln('Digite o valor:');
        readln(valor);
        insereFim(inicio, fim, qtdElementos, valor);
      end;
      3: begin
        removeInicio(inicio, fim, qtdElementos, valor);
        writeln('Valor removido: ', valor);
      end;
      4: begin
        removeFim(inicio, fim, qtdElementos, valor);
        writeln('Valor removido: ', valor);
      end;
      5: writeln('Início: ', acessoInicio(inicio));
      6: writeln('Fim: ', acessoFim(fim));
      7: writeln('Tamanho: ', tamanhoDeque(qtdElementos));
      8: if dequeVazio(inicio) then
        writeln('Deque está vazio')
      else
        writeln('Deque não está vazio');
      9: if dequeCheio then
        writeln('Deque está cheio')
      else
        writeln('Deque não está cheio');
    end;
  until opcao = 0;
end.
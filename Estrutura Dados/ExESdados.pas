
//programa do Rafael Zika
program ArvoreBinaria;

type
  PNo = ^TNo;
  TNo = record
    valor: integer;
    esq, dir: PNo;
  end;

var
  raiz: PNo;


function NovoNo(valor: integer): PNo;
var
  no: PNo;
begin
  New(no);
  no^.valor := valor;
  no^.esq := nil;
  no^.dir := nil;
  NovoNo := no;
end;


procedure Inserir(var raiz: PNo; valor: integer);
begin
  if raiz = nil then
    raiz := NovoNo(valor)
  else if valor < raiz^.valor then
    Inserir(raiz^.esq, valor)
  else
    Inserir(raiz^.dir, valor);
end;


function Remover(var raiz: PNo; valor: integer): PNo;
var
  temp: PNo;
begin
  if raiz = nil then
    Remover := nil
  else if valor < raiz^.valor then
    raiz^.esq := Remover(raiz^.esq, valor)
  else if valor > raiz^.valor then
    raiz^.dir := Remover(raiz^.dir, valor)
  else
  begin
    if (raiz^.esq = nil) and (raiz^.dir = nil) then
    begin
      Dispose(raiz);
      raiz := nil;
    end
    else if raiz^.esq = nil then
    begin
      temp := raiz;
      raiz := raiz^.dir;
      Dispose(temp);
    end
    else if raiz^.dir = nil then
    begin
      temp := raiz;
      raiz := raiz^.esq;
      Dispose(temp);
    end
    else
    begin
      temp := raiz^.dir;
      while temp^.esq <> nil do
        temp := temp^.esq;
      raiz^.valor := temp^.valor;
      raiz^.dir := Remover(raiz^.dir, temp^.valor);
    end;
  end;
  Remover := raiz;
end;


function Altura(raiz: PNo): integer;
var
  altEsq, altDir: integer;
begin
  if raiz = nil then
    Altura := 0
  else
  begin
    altEsq := Altura(raiz^.esq);
    altDir := Altura(raiz^.dir);
    if altEsq > altDir then
      Altura := altEsq + 1
    else
      Altura := altDir + 1;
  end;
end;


function Nivel(raiz: PNo; valor, nivelAtual: integer): integer;
begin
  if raiz = nil then
    Nivel := -1
  else if valor = raiz^.valor then
    Nivel := nivelAtual
  else if valor < raiz^.valor then
    Nivel := Nivel(raiz^.esq, valor, nivelAtual + 1)
  else
    Nivel := Nivel(raiz^.dir, valor, nivelAtual + 1);
end;


function ContarFolhas(raiz: PNo): integer;
begin
  if raiz = nil then
    ContarFolhas := 0
  else if (raiz^.esq = nil) and (raiz^.dir = nil) then
    ContarFolhas := 1
  else
    ContarFolhas := ContarFolhas(raiz^.esq) + ContarFolhas(raiz^.dir);
end;


procedure PreFixado(raiz: PNo);
begin
  if raiz <> nil then
  begin
    Write(raiz^.valor, ' ');
    PreFixado(raiz^.esq);
    PreFixado(raiz^.dir);
  end;
end;


procedure InFixado(raiz: PNo);
begin
  if raiz <> nil then
  begin
    InFixado(raiz^.esq);
    Write(raiz^.valor, ' ');
    InFixado(raiz^.dir);
  end;
end;


procedure PosFixado(raiz: PNo);
begin
  if raiz <> nil then
  begin
    PosFixado(raiz^.esq);
    PosFixado(raiz^.dir);
    Write(raiz^.valor, ' ');
  end;
end;


function ArvoreCompleta(raiz: PNo; index, numeroNos: integer): boolean;
begin
  if raiz = nil then
    ArvoreCompleta := true
  else if index >= numeroNos then
    ArvoreCompleta := false
  else
    ArvoreCompleta := ArvoreCompleta(raiz^.esq, 2 * index + 1, numeroNos) and
                      ArvoreCompleta(raiz^.dir, 2 * index + 2, numeroNos);
end;


function ContarNos(raiz: PNo): integer;
begin
  if raiz = nil then
    ContarNos := 0
  else
    ContarNos := 1 + ContarNos(raiz^.esq) + ContarNos(raiz^.dir);
end;


var
  opcao, valor, numNos, index: integer;
begin
  raiz := nil;
  repeat
    WriteLn('1 - Incluir elemento');
    WriteLn('2 - Remover elemento');
    WriteLn('3 - Caminhamento pr�-fixado');
    WriteLn('4 - Caminhamento in-fixado');
    WriteLn('5 - Caminhamento p�s-fixado');
    WriteLn('6 - Ver altura da �rvore');
    WriteLn('7 - Ver n�vel de um elemento');
    WriteLn('8 - Contar n�s folhas');
    WriteLn('9 - Verificar se �rvore � completa');
    WriteLn('0 - Sair');
    Write('Op��o: ');
    ReadLn(opcao);
    
    case opcao of
      1: begin
           Write('Digite o valor a ser inclu�do: ');
           ReadLn(valor);
           Inserir(raiz, valor);
         end;
      2: begin
           Write('Digite o valor a ser removido: ');
           ReadLn(valor);
           raiz := Remover(raiz, valor);
         end;
      3: begin
           WriteLn('Caminhamento pr�-fixado:');
           PreFixado(raiz);
           WriteLn;
         end;
      4: begin
           WriteLn('Caminhamento in-fixado:');
           InFixado(raiz);
           WriteLn;
         end;
      5: begin
           WriteLn('Caminhamento p�s-fixado:');
           PosFixado(raiz);
           WriteLn;
         end;
      6: WriteLn('Altura da �rvore: ', Altura(raiz));
      7: begin
           Write('Digite o valor para verificar o n�vel: ');
           ReadLn(valor);
           WriteLn('N�vel do elemento: ', Nivel(raiz, valor, 0));
         end;
      8: WriteLn('N�s folhas: ', ContarFolhas(raiz));
      9: begin
           numNos := ContarNos(raiz);
           if ArvoreCompleta(raiz, 0, numNos) then
             WriteLn('A �rvore � completa.')
           else
             WriteLn('A �rvore n�o � completa.');
         end;
    end;
  until opcao = 0;
end.

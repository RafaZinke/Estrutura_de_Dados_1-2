program ArvoreBinariaUFs;

type
  // Estrutura para o nó dos municípios
  MunicipioPtr = ^Municipio;
  Municipio = record
    nome: string;
    esquerda, direita: MunicipioPtr;
  end;

  // Estrutura para o nó das UFs
  UFPtr = ^UF;
  UF = record
    sigla: string;
    esquerda, direita: UFPtr;
    municipios: MunicipioPtr;
    countMunicipios: integer;
  end;

// Procedimentos e Funções para Árvores de UFs e Municípios

// Função para criar um novo nó de UF
function CriarUF(sigla: string): UFPtr;
var
  novaUF: UFPtr;
begin
  new(novaUF);
  novaUF^.sigla := sigla;
  novaUF^.esquerda := nil;
  novaUF^.direita := nil;
  novaUF^.municipios := nil;
  novaUF^.countMunicipios := 0;
  CriarUF := novaUF;
end;

// Função para criar um novo nó de município
function CriarMunicipio(nome: string): MunicipioPtr;
var
  novoMunicipio: MunicipioPtr;
begin
  new(novoMunicipio);
  novoMunicipio^.nome := nome;
  novoMunicipio^.esquerda := nil;
  novoMunicipio^.direita := nil;
  CriarMunicipio := novoMunicipio;
end;

// Função para inserir UF na árvore de UFs
procedure InserirUF(var raiz: UFPtr; sigla: string);
begin
  if raiz = nil then
    raiz := CriarUF(sigla)
  else if sigla < raiz^.sigla then
    InserirUF(raiz^.esquerda, sigla)
  else if sigla > raiz^.sigla then
    InserirUF(raiz^.direita, sigla);
end;

// Função para inserir município na árvore de municípios de uma UF
procedure InserirMunicipio(var raiz: MunicipioPtr; nome: string);
begin
  if raiz = nil then
    raiz := CriarMunicipio(nome)
  else if nome < raiz^.nome then
    InserirMunicipio(raiz^.esquerda, nome)
  else if nome > raiz^.nome then
    InserirMunicipio(raiz^.direita, nome);
end;

// Função para encontrar uma UF na árvore
function EncontrarUF(raiz: UFPtr; sigla: string): UFPtr;
begin
  if raiz = nil then
    EncontrarUF := nil
  else if sigla = raiz^.sigla then
    EncontrarUF := raiz
  else if sigla < raiz^.sigla then
    EncontrarUF := EncontrarUF(raiz^.esquerda, sigla)
  else
    EncontrarUF := EncontrarUF(raiz^.direita, sigla);
end;

// Procedimento para exibir a árvore de UFs
procedure ExibirUFs(raiz: UFPtr);
begin
  if raiz <> nil then
  begin
    ExibirUFs(raiz^.esquerda);
    writeln(raiz^.sigla);
    ExibirUFs(raiz^.direita);
  end;
end;

// Procedimento para exibir a árvore de municípios de uma UF
procedure ExibirMunicipios(raiz: MunicipioPtr);
begin
  if raiz <> nil then
  begin
    ExibirMunicipios(raiz^.esquerda);
    writeln(raiz^.nome);
    ExibirMunicipios(raiz^.direita);
  end;
end;

// Procedimento para contar municípios de uma UF
function ContarMunicipios(raiz: MunicipioPtr): integer;
begin
  if raiz = nil then
    ContarMunicipios := 0
  else
    ContarMunicipios := 1 + ContarMunicipios(raiz^.esquerda) + ContarMunicipios(raiz^.direita);
end;

// Procedimento para incluir município em uma UF
procedure IncluirMunicipio(var raiz: UFPtr; sigla, nomeMunicipio: string);
var
  uf: UFPtr;
begin
  uf := EncontrarUF(raiz, sigla);
  if uf = nil then
  begin
    InserirUF(raiz, sigla);
    uf := EncontrarUF(raiz, sigla);
  end;
  InserirMunicipio(uf^.municipios, nomeMunicipio);
  uf^.countMunicipios := ContarMunicipios(uf^.municipios);
end;

// Procedimento para remover um município (simplificado para manter o exemplo)
procedure RemoverMunicipio(var raiz: MunicipioPtr; nome: string);
begin
  if raiz <> nil then
  begin
    if nome < raiz^.nome then
      RemoverMunicipio(raiz^.esquerda, nome)
    else if nome > raiz^.nome then
      RemoverMunicipio(raiz^.direita, nome)
    else
    begin
      // Remover nó (não implementado completamente para simplificar)
      dispose(raiz);
      raiz := nil;
    end;
  end;
end;

// Procedimento para remover município de uma UF e atualizar a árvore principal se necessário
procedure RemoverMunicipioUF(var raiz: UFPtr; sigla, nomeMunicipio: string);
var
  uf: UFPtr;
begin
  uf := EncontrarUF(raiz, sigla);
  if uf <> nil then
  begin
    RemoverMunicipio(uf^.municipios, nomeMunicipio);
    uf^.countMunicipios := ContarMunicipios(uf^.municipios);
    if uf^.countMunicipios = 0 then
    begin
      // Remover UF da árvore (não implementado completamente)
    end;
  end;
end;

// Menu Principal
procedure Menu();
var
  opcao: integer;
  sigla, nomeMunicipio: string;
  raizUF: UFPtr;
begin
  raizUF := nil;
  repeat
    writeln('--- Menu ---');
    writeln('1. Incluir município');
    writeln('2. Remover município');
    writeln('3. Exibir árvore de UFs');
    writeln('4. Exibir municípios de uma UF');
    writeln('5. Contar municípios de uma UF');
    writeln('6. Sair');
    writeln('Escolha uma opção: ');
    readln(opcao);

    case opcao of
      1: begin
           writeln('Digite a sigla da UF: ');
           readln(sigla);
           writeln('Digite o nome do município: ');
           readln(nomeMunicipio);
           IncluirMunicipio(raizUF, sigla, nomeMunicipio);
         end;
      2: begin
           writeln('Digite a sigla da UF: ');
           readln(sigla);
           writeln('Digite o nome do município: ');
           readln(nomeMunicipio);
           RemoverMunicipioUF(raizUF, sigla, nomeMunicipio);
         end;
      3: begin
           writeln('Árvore de UFs:');
           ExibirUFs(raizUF);
         end;
      4: begin
           writeln('Digite a sigla da UF: ');
           readln(sigla);
           writeln('Municípios da UF ', sigla, ':');
           ExibirMunicipios(EncontrarUF(raizUF, sigla)^.municipios);
         end;
      5: begin
           writeln('Digite a sigla da UF: ');
           readln(sigla);
           writeln('Total de municípios em ', sigla, ': ', ContarMunicipios(EncontrarUF(raizUF, sigla)^.municipios));
         end;
      6: writeln('Saindo...');
    else
      writeln('Opção inválida! Tente novamente.');
    end;
  until opcao = 6;
end;

// Programa principal
begin
  Menu();
end.

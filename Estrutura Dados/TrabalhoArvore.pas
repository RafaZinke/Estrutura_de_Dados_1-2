program ArvoreBinariaUFs;

type
  // Estrutura para o n� dos munic�pios
  MunicipioPtr = ^Municipio;
  Municipio = record
    nome: string;
    esquerda, direita: MunicipioPtr;
  end;

  // Estrutura para o n� das UFs
  UFPtr = ^UF;
  UF = record
    sigla: string;
    esquerda, direita: UFPtr;
    municipios: MunicipioPtr;
    countMunicipios: integer;
  end;

// Procedimentos e Fun��es para �rvores de UFs e Munic�pios

// Fun��o para criar um novo n� de UF
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

// Fun��o para criar um novo n� de munic�pio
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

// Fun��o para inserir UF na �rvore de UFs
procedure InserirUF(var raiz: UFPtr; sigla: string);
begin
  if raiz = nil then
    raiz := CriarUF(sigla)
  else if sigla < raiz^.sigla then
    InserirUF(raiz^.esquerda, sigla)
  else if sigla > raiz^.sigla then
    InserirUF(raiz^.direita, sigla);
end;

// Fun��o para inserir munic�pio na �rvore de munic�pios de uma UF
procedure InserirMunicipio(var raiz: MunicipioPtr; nome: string);
begin
  if raiz = nil then
    raiz := CriarMunicipio(nome)
  else if nome < raiz^.nome then
    InserirMunicipio(raiz^.esquerda, nome)
  else if nome > raiz^.nome then
    InserirMunicipio(raiz^.direita, nome);
end;

// Fun��o para encontrar uma UF na �rvore
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

// Procedimento para exibir a �rvore de UFs
procedure ExibirUFs(raiz: UFPtr);
begin
  if raiz <> nil then
  begin
    ExibirUFs(raiz^.esquerda);
    writeln(raiz^.sigla);
    ExibirUFs(raiz^.direita);
  end;
end;

// Procedimento para exibir a �rvore de munic�pios de uma UF
procedure ExibirMunicipios(raiz: MunicipioPtr);
begin
  if raiz <> nil then
  begin
    ExibirMunicipios(raiz^.esquerda);
    writeln(raiz^.nome);
    ExibirMunicipios(raiz^.direita);
  end;
end;

// Procedimento para contar munic�pios de uma UF
function ContarMunicipios(raiz: MunicipioPtr): integer;
begin
  if raiz = nil then
    ContarMunicipios := 0
  else
    ContarMunicipios := 1 + ContarMunicipios(raiz^.esquerda) + ContarMunicipios(raiz^.direita);
end;

// Procedimento para incluir munic�pio em uma UF
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

// Procedimento para remover um munic�pio (simplificado para manter o exemplo)
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
      // Remover n� (n�o implementado completamente para simplificar)
      dispose(raiz);
      raiz := nil;
    end;
  end;
end;

// Procedimento para remover munic�pio de uma UF e atualizar a �rvore principal se necess�rio
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
      // Remover UF da �rvore (n�o implementado completamente)
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
    writeln('1. Incluir munic�pio');
    writeln('2. Remover munic�pio');
    writeln('3. Exibir �rvore de UFs');
    writeln('4. Exibir munic�pios de uma UF');
    writeln('5. Contar munic�pios de uma UF');
    writeln('6. Sair');
    writeln('Escolha uma op��o: ');
    readln(opcao);

    case opcao of
      1: begin
           writeln('Digite a sigla da UF: ');
           readln(sigla);
           writeln('Digite o nome do munic�pio: ');
           readln(nomeMunicipio);
           IncluirMunicipio(raizUF, sigla, nomeMunicipio);
         end;
      2: begin
           writeln('Digite a sigla da UF: ');
           readln(sigla);
           writeln('Digite o nome do munic�pio: ');
           readln(nomeMunicipio);
           RemoverMunicipioUF(raizUF, sigla, nomeMunicipio);
         end;
      3: begin
           writeln('�rvore de UFs:');
           ExibirUFs(raizUF);
         end;
      4: begin
           writeln('Digite a sigla da UF: ');
           readln(sigla);
           writeln('Munic�pios da UF ', sigla, ':');
           ExibirMunicipios(EncontrarUF(raizUF, sigla)^.municipios);
         end;
      5: begin
           writeln('Digite a sigla da UF: ');
           readln(sigla);
           writeln('Total de munic�pios em ', sigla, ': ', ContarMunicipios(EncontrarUF(raizUF, sigla)^.municipios));
         end;
      6: writeln('Saindo...');
    else
      writeln('Op��o inv�lida! Tente novamente.');
    end;
  until opcao = 6;
end;

// Programa principal
begin
  Menu();
end.

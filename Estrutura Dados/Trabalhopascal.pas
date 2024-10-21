Program ArvoreBinaria;
Type 
    PtrNo = ^TNo;
    TNo = record
        info: integer;
        esq, dir: PtrNo;
    end;

var 
    raiz: PtrNo;
    opcao: integer;
    contador: integer = 0;
procedure CriaArvoreVazia(var raiz: PtrNo);
begin
    raiz := nil;
end;

function NovoNo(valor: integer): PtrNo;
var 
    novo: PtrNo;
begin
    new(novo);
    novo^.info := valor;
    novo^.esq := nil;
    novo^.dir := nil;
    NovoNo := novo;
end;

procedure Insere(var raiz: PtrNo; valor: integer);
begin
    if raiz = nil then
        raiz := NovoNo(valor)
    else if valor < raiz^.info then
        Insere(raiz^.esq, valor)
    else
        Insere(raiz^.dir, valor);
end;

procedure PreOrdem(raiz: PtrNo);
begin
    if raiz <> nil then
    begin
        write(raiz^.info, ' ');
        PreOrdem(raiz^.esq);
        PreOrdem(raiz^.dir);
    end;
end;

procedure EmOrdem(raiz: PtrNo);
begin
    if raiz <> nil then
    begin
        EmOrdem(raiz^.esq);
        write(raiz^.info, ' ');
        EmOrdem(raiz^.dir);
    end;
end;

procedure PosOrdem(raiz: PtrNo);
begin
    if raiz <> nil then
    begin
        PosOrdem(raiz^.esq);
        PosOrdem(raiz^.dir);
        write(raiz^.info, ' ');
    end;
end;

function Altura(raiz: PtrNo): integer;
var 
    altEsq, altDir: integer;
begin
    if raiz = nil then
        Altura := -1
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

function NivelElemento(raiz: PtrNo; valor: integer): integer;
begin
    if raiz = nil then
        NivelElemento := -1
    else if raiz^.info = valor then
        NivelElemento := 0
    else if valor < raiz^.info then
    begin
        if NivelElemento(raiz^.esq, valor) = -1 then
            NivelElemento := -1
        else
            NivelElemento := NivelElemento(raiz^.esq, valor) + 1;
    end
    else
    begin
        if NivelElemento(raiz^.dir, valor) = -1 then
            NivelElemento := -1
        else
            NivelElemento := NivelElemento(raiz^.dir, valor) + 1;
    end;
end;

procedure ContaNosFolha(raiz: PtrNo; var contador: integer);
begin
    if raiz <> nil then
    begin
        if (raiz^.esq = nil) and (raiz^.dir = nil) then
        begin
            write(raiz^.info, ' ');
            contador := contador + 1;
        end;
        ContaNosFolha(raiz^.esq, contador);
        ContaNosFolha(raiz^.dir, contador);
    end;
end;

function EhCompleta(raiz: PtrNo): boolean;
var 
    alt, numNos: integer;

    function ContaNos(raiz: PtrNo): integer;
    begin
        if raiz = nil then
            ContaNos := 0
        else
            ContaNos := 1 + ContaNos(raiz^.esq) + ContaNos(raiz^.dir);
    end;

begin
    if raiz = nil then
        EhCompleta := true
    else
    begin
        alt := Altura(raiz);
        numNos := ContaNos(raiz);
        EhCompleta := numNos = (1 shl (alt + 1)) - 1;
    end;
end;

function NoMinimo(raiz: PtrNo): PtrNo;
begin
    if raiz = nil then
        NoMinimo := nil
    else if raiz^.esq = nil then
        NoMinimo := raiz
    else
        NoMinimo := NoMinimo(raiz^.esq);
end;

procedure Remove(var raiz: PtrNo; valor: integer);
var 
    temp: PtrNo;
begin
    if raiz = nil then
        writeln('Elemento não encontrado!')
    else if valor < raiz^.info then
        Remove(raiz^.esq, valor)
    else if valor > raiz^.info then
        Remove(raiz^.dir, valor)
    else
    begin
        if (raiz^.esq = nil) and (raiz^.dir = nil) then
        begin
            dispose(raiz);
            raiz := nil;
        end
        else if raiz^.esq = nil then
        begin
            temp := raiz;
            raiz := raiz^.dir;
            dispose(temp);
        end
        else if raiz^.dir = nil then
        begin
            temp := raiz;
            raiz := raiz^.esq;
            dispose(temp);
        end
        else
        begin
            temp := NoMinimo(raiz^.dir);
            raiz^.info := temp^.info;
            Remove(raiz^.dir, temp^.info);
        end;
    end;
end;

Begin
    CriaArvoreVazia(raiz);
    
    repeat
        writeln;
        writeln('1 - Inserir elemento');
        writeln('2 - Remover elemento');
        writeln('3 - Caminhamento Pre-Ordem');
        writeln('4 - Caminhamento Em-Ordem');
        writeln('5 - Caminhamento Pos-Ordem');
        writeln('6 - Altura da arvore');
        writeln('7 - Nivel de um elemento');
        writeln('8 - Nos folhas');
        writeln('9 - Verificar se e completa');
        writeln('0 - Sair');
        write('Escolha uma opcao: ');
        readln(opcao);
        
        case opcao of
            1: begin
                write('Digite o valor a ser inserido: ');
                readln(opcao);
                Insere(raiz, opcao);
            end;
            
            2: begin
                write('Digite o valor a ser removido: ');
                readln(opcao);
                Remove(raiz, opcao);
            end;
            
            3: begin
                write('Pre-Ordem: ');
                PreOrdem(raiz);
                writeln;
            end;
            
            4: begin
                write('Em-Ordem: ');
                EmOrdem(raiz);
                writeln;
            end;
            
            5: begin
                write('Pos-Ordem: ');
                PosOrdem(raiz);
                writeln;
            end;
            
            6: begin
                writeln('Altura da arvore: ', Altura(raiz));
            end;
            
            7: begin
                write('Digite o elemento: ');
                readln(opcao);
                writeln('Nivel do elemento: ', NivelElemento(raiz, opcao));
            end;
            
            8: begin
               
                write('Nos folhas: ');
                ContaNosFolha(raiz, contador);
                writeln;
                writeln('Total de nos folhas: ', contador);
            end;
            
            9: begin
                if EhCompleta(raiz) then
                    writeln('A arvore e completa')
                else
                    writeln('A arvore nao e completa');
            end;
        end;
    until opcao = 0;
End.
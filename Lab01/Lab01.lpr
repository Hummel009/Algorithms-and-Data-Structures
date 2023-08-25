program Lab01;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  TData = integer;
  TPElem = ^TElem;

  TElem = record
    Data: TData;
    PNext: TPElem;
  end;

  TQueue = record
    Cnt: integer;
    PFirst, PLast: TPElem;
  end;

var
  Q: TQueue;
  Data: TData;
  I, K, Kr, N: integer;

  // Инициализация очереди
  procedure Init(var aQ: TQueue);
  begin
    aQ.Cnt := 0;
    aQ.PFirst := nil;
    aQ.PLast := nil;
  end;

  // Добавление элемента в конец очереди
  procedure Push(var aQ: TQueue; const aData: TData);
  var
    PElem: TPElem;
  begin
    New(PElem);
    PElem^.Data := aData;
    PElem^.PNext := nil;
    if aQ.PFirst = nil then
      aQ.PFirst := PElem
    else
      aQ.PLast^.PNext := PElem;
    aQ.PLast := PElem;
    Inc(aQ.Cnt);
  end;

  // Извлечение элемента из начала очереди
  function Pop(var aQ: TQueue; var aData: TData): boolean;
  var
    PElem: TPElem;
  begin
    Result := False;
    if aQ.PFirst = nil then Exit;

    PElem := aQ.PFirst;
    aData := PElem^.Data;
    aQ.PFirst := PElem^.PNext;
    if aQ.PFirst = nil then
      aQ.PLast := nil;
    Dispose(PElem);
    Dec(aQ.Cnt);
    Result := True;
  end;

  // Освобождение памяти, связанной с очередью
  procedure Free(var aQ: TQueue);
  var
    Data: TData;
  begin
    while Pop(aQ, Data) do ;
  end;

  // Вывод элементов очереди
  procedure QWriteln(const aQ: TQueue);
  var
    PElem: TPElem;
  begin
    PElem := aQ.PFirst;
    while PElem <> nil do
    begin
      Write(PElem^.Data, ' ');
      PElem := PElem^.PNext;
    end;
  end;

begin
  Init(Q);

  Write('Enter the maximum number of players (N): ');
  Readln(N);

  Write('Enter K (the number of disappearing person): ');
  Readln(K);

  // Перебор для разных значений N
  for N := 1 to N do
  begin
    Init(Q);

    // Инициализация очереди для данного N
    for I := 1 to N do
      Push(Q, I);

    // Выполнение считалочки
    while Q.Cnt > 1 do
    begin
      Kr := K mod Q.Cnt;
      if Kr = 0 then Kr := Q.Cnt;

      for I := 1 to Kr - 1 do
      begin
        Pop(Q, Data);
        Push(Q, Data);
      end;

      Pop(Q, Data);

      Write(Data, ' ');
    end;

    Pop(Q, Data);

    // Вывод оставшегося элемента
    Writeln('| Alive: ', Data);

    // Освобождение памяти, используемой для текущей очереди
    Free(Q);
  end;

  Readln;
end.

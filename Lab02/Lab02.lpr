program Lab02;

{$APPTYPE CONSOLE}

type
  TPhoneNumber = string;

  TPhoneNode = ^EPhoneNode;

  EPhoneNode = record
    Data: TPhoneNumber;
    Next: TPhoneNode;
  end;

  // Добавляет новый узел с номером телефона в конец списка
  procedure AddPhoneNode(var Head: TPhoneNode; const PhoneNumber: TPhoneNumber);
  var
    NewNode, Current: TPhoneNode;
  begin
    New(NewNode);
    NewNode^.Data := PhoneNumber;
    NewNode^.Next := nil;

    if Head = nil then
      Head := NewNode
    else
    begin
      Current := Head;
      while Current^.Next <> nil do
        Current := Current^.Next;
      Current^.Next := NewNode;
    end;
  end;

  // Загружает номера телефонов в список
  procedure LoadPhoneNumbers(var ListHead: TPhoneNode);
  var
    i, Len: integer;
    PhoneNumber: TPhoneNumber;
  begin
    Write('Enter the quantity of phone numbers: ');
    ReadLn(Len);

    for i := 1 to Len do
    begin
      repeat
        Write('Number #', i, ': ');
        ReadLn(PhoneNumber);
        if ((Length(PhoneNumber) <> 7) and (Length(PhoneNumber) <> 3)) then
          WriteLn('Incorrect input');
      until ((Length(PhoneNumber) = 7) or (Length(PhoneNumber) = 3));

      AddPhoneNode(ListHead, PhoneNumber);
    end;
  end;

  // Выводит номера телефонов из списка
  procedure PrintPhoneNumbers(Head: TPhoneNode);
  begin
    while Head <> nil do
    begin
      WriteLn(Head^.Data);
      Head := Head^.Next;
    end;
  end;

  // Удаляет номера KGB (с 3 символами) из одного списка и добавляет их в другой
  procedure RemoveKGBNumbers(var Dest: TPhoneNode; Src: TPhoneNode);
  begin
    while Src <> nil do
    begin
      if Length(Src^.Data) <> 3 then
        AddPhoneNode(Dest, Src^.Data);
      Src := Src^.Next;
    end;
  end;

  // Сортирует номера телефонов в списке
  procedure SortPhoneNumbers(var Head: TPhoneNode);
  var
    Current, NextNode: TPhoneNode;
    TempData: TPhoneNumber;
  begin
    if (Head = nil) or (Head^.Next = nil) then
      Exit;

    Current := Head;
    while Current <> nil do
    begin
      NextNode := Current^.Next;
      while NextNode <> nil do
      begin
        if Current^.Data > NextNode^.Data then
        begin
          TempData := Current^.Data;
          Current^.Data := NextNode^.Data;
          NextNode^.Data := TempData;
        end;
        NextNode := NextNode^.Next;
      end;
      Current := Current^.Next;
    end;
  end;

var
  PhoneListIncludingKGB, PhoneListExcludingKGB: TPhoneNode;
begin
  PhoneListIncludingKGB := nil;
  PhoneListExcludingKGB := nil;

  // Загрузка номеров телефонов включая KGB
  LoadPhoneNumbers(PhoneListIncludingKGB);

  WriteLn;
  WriteLn('Phone numbers including KGB:');
  PrintPhoneNumbers(PhoneListIncludingKGB);

  WriteLn;
  WriteLn('Phone numbers excluding KGB:');
  // Удаление KGB номеров из списка и сортировка остальных
  RemoveKGBNumbers(PhoneListExcludingKGB, PhoneListIncludingKGB);
  SortPhoneNumbers(PhoneListExcludingKGB);
  PrintPhoneNumbers(PhoneListExcludingKGB);

  // Очистка памяти, освобождение списка
  while PhoneListIncludingKGB <> nil do
  begin
    PhoneListExcludingKGB := PhoneListIncludingKGB^.Next;
    Dispose(PhoneListIncludingKGB);
    PhoneListIncludingKGB := PhoneListExcludingKGB;
  end;

  while PhoneListExcludingKGB <> nil do
  begin
    PhoneListIncludingKGB := PhoneListExcludingKGB^.Next;
    Dispose(PhoneListExcludingKGB);
    PhoneListExcludingKGB := PhoneListIncludingKGB;
  end;

  ReadLn;
end.

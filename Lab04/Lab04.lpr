program Lab04;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  Num = record
    N: integer;
    Name: string;
    LastName: string;
    Number: string;
    Patronoic: string;
  end;

  LElem = ^Elem;

  Elem = record
    Data: Num;
    Next: LElem;
  end;

var
  First: LElem;
  LastName, Number: string;
  Sort: integer;
  Flag: boolean;

  procedure FindByLastName(X: LElem; LastName: string);
  var
    Count: integer;
  begin
    Count := 0;
    while X <> nil do
    begin
      if X^.Data.LastName = LastName then
      begin
        Write(X^.Data.Name: 10, ' ');
        Write(X^.Data.LastName: 15, ' ');
        Write(X^.Data.Patronoic: 15, ' ');
        WriteLn(X^.Data.Number: 17);
        Inc(Count);
      end;
      X := X^.Next;
    end;
    if Count = 0 then
      WriteLn('Abonent does not exist!');

  end;

  procedure FindByNumber(X: LElem; Number: string);
  var
    Count: integer;
  begin
    Count := 0;
    while X <> nil do
    begin

      if X^.Data.Number = Number then
      begin
        Write(X^.Data.Name: 10, ' ');
        Write(X^.Data.LastName: 15, ' ');
        Write(X^.Data.Patronoic: 15, ' ');
        WriteLn(X^.Data.Number: 17);
        Inc(Count);

      end;
      X := X^.Next;
    end;
    if Count = 0 then
      WriteLn('Abonent does not exist!');

  end;

  procedure Input(var X: integer);
  var
    Error: integer;
    Sus: string;
  begin

    repeat
      ReadLn(Sus);
      Val(Sus, X, Error);
      if (Error <> 0) or (Length(Sus) <> 7) then
        WriteLn('Error!');
    until (Error = 0) and (Length(Sus) = 7);

  end;

  procedure Make(X: LElem);
  var
    Y: LElem;
    Number, N: integer;
    Name, LastName, Patronoic: string;
    Change: string;
  begin
    Change := 'Yes';
    N := 1;
    while (Change <> 'No') do
    begin

      Write('Enter the name: ');
      ReadLn(Name);
      Write('Enter the surname: ');
      ReadLn(LastName);
      Write('Enter the patronoic: ');
      ReadLn(Patronoic);
      Write('Enter the phone number: ');
      Input(Number);

      X^.Data.Number := '+37529' + IntToStr(Number);

      X^.Data.Name := Name;
      X^.Data.LastName := LastName;
      X^.Data.Patronoic := Patronoic;
      X^.Data.N := N;
      Inc(N);
      Y := X;
      New(X);

      Y^.Next := X;
      Write('Do you want to add another one? ');
      ReadLn(Change);
    end;
    Y^.Next := nil;

  end;

  procedure Show(X: LElem);
  begin

    while (X <> nil) do
    begin
      Write(X^.Data.Name: 10, ' ');
      Write(X^.Data.LastName: 15, ' ');
      Write(X^.Data.Patronoic: 15, ' ');
      WriteLn(X^.Data.Number: 17);
      X := X^.Next;
    end;
  end;

  procedure SortNumber(Y: LElem; Sort: integer);
  var
    Len, I, J: integer;
    X: LElem;
    Tmps: Num;
    Flag: boolean;
  begin
    X := Y;
    Len := 0;
    while X <> nil do
    begin
      Inc(Len);
      X := X^.Next;
    end;

    for I := 1 to Len do
    begin
      X := Y;
      for J := 1 to Len - I do
      begin
        Flag := False;
        case Sort of
          1:
            if X^.Data.Name > X^.Next^.Data.Name then
              Flag := True;
          2:
            if X^.Data.LastName > X^.Next^.Data.LastName then
              Flag := True;
          3:
            if X^.Data.Patronoic > X^.Next^.Data.Patronoic then
              Flag := True;
        end;

        if Flag then
        begin
          Tmps := X^.Data;
          X^.Data := X^.Next^.Data;
          X^.Next^.Data := Tmps;
        end;
        X := X^.Next;
      end;
    end;
  end;

begin
  New(First);
  Make(First);
  WriteLn;
  WriteLn('Enter the sort type: 1 - name, 2 - surname, 3 - patronoic');
  Flag := False;
  repeat
    ReadLn(Sort);
    if (Sort in [1, 2, 3]) then
      Flag := True;
  until Flag;

  SortNumber(First, Sort);

  WriteLn;
  Show(First);
  WriteLn;
  WriteLn('Enter the surname to find the phone number');
  ReadLn(LastName);
  WriteLn;
  FindByLastName(First, LastName);
  WriteLn;
  WriteLn('Enter the phone number to find the surname');
  ReadLn(Number);
  WriteLn;
  FindByNumber(First, Number);

  Dispose(First);

  ReadLn;
end.

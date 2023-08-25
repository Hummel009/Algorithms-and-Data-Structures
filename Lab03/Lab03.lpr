program Lab03;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  Polynom = ^EPolynom;

  EPolynom = record
    Number: integer;
    Power: integer;
    Next: Polynom;
  end;

var
  First, Second, Third: Polynom;
  N, X: integer;

  // Ввод числа с обработкой ошибок
  procedure SystemIn(var Res: integer);
  var
    Error: integer;
    S: string;
  begin
    repeat
      Readln(s);
      Val(s, Res, Error);
      if Error <> 0 then
        WriteLn('Wrong number!');
    until Error = 0;
  end;

  // Создание полинома
  procedure Make(X: Polynom; N: integer);
  var
    Y: Polynom;
    Number: integer;
  begin
    while (N >= 0) do
    begin
      Write('Number near (X^', N, ') = ');
      SystemIn(Number);
      if Number <> 0 then
      begin
        X^.Number := Number;
        X^.Power := N;

        Y := X;
        New(X);
        Y^.Next := X;
      end;
      N := N - 1;
    end;
    Y^.Next := nil;
  end;

  // Вывод полинома
  procedure SystemOut(P: Polynom);
  begin
    if P^.Power <> 0 then
    begin
      if P^.Number = 1 then
        Write('X^', P^.Power)
      else
      if P^.Number > 1 then
        Write(P^.Number, 'X^', P^.Power)
      else
      if P^.Number = -1 then
        Write('-X^', P^.Power)
      else
      if P^.Number < 0 then
        Write(P^.Number, 'X^', P^.Power);
    end
    else
      Write(P^.Number);

    while P <> nil do
    begin
      P := P^.Next;
      if (P <> nil) then
      begin
        if (P^.Number < 0) then
        begin
          Write(' - ');
          if P^.Power <> 0 then
          begin
            if P^.Number = -1 then
              Write('X^', P^.Power)
            else
              Write(-1 * P^.Number, 'X^', P^.Power);
          end
          else
          begin
            Write(-1 * P^.Number);
          end;
        end
        else
        begin
          Write(' + ');
          if P^.Power <> 0 then
          begin
            if P^.Number = 1 then
              Write('X^', P^.Power)
            else
              Write(P^.Number, 'X^', P^.Power);
          end
          else
          begin
            Write(P^.Number);
          end;
        end;
      end;
    end;
  end;

  // Сравнение полиномов на равенство
  function Equality(P: Polynom; Q: Polynom): boolean;
  var
    Flag: boolean;
  begin
    Flag := True;
    while (P <> nil) and (Q <> nil) and Flag do
    begin
      if P^.Power = Q^.Power then
      begin
        if P^.Number <> Q^.Number then
          Flag := False;
      end
      else
        Flag := False;
      P := P^.Next;
      Q := Q^.Next;
    end;

    if Flag then
      WriteLn('P = Q')
    else
      WriteLn('P != Q');

    Result := Flag;
  end;

  // Вычисление значения полинома при заданном X
  function Calculate(P: Polynom; X: integer): integer;
  var
    I, Mult: integer;
  begin
    Result := 0;
    while P <> nil do
    begin
      Mult := 1;
      for I := 1 to P^.Power do
        Mult := Mult * X;
      Result := Result + P^.Number * Mult;

      P := P^.Next;
    end;
  end;

  // Сложение двух полиномов
  procedure Sum(P: Polynom; Q: Polynom; R: Polynom);
  var
    Y: Polynom;
  begin
    while (Q <> nil) and (P <> nil) do
    begin
      if P^.Power < Q^.Power then
      begin
        R^.Number := Q^.Number;
        R^.Power := Q^.Power;
        Q := Q^.Next;
      end
      else
      if P^.Power = Q^.Power then
      begin
        R^.Number := Q^.Number + P^.Number;
        R^.Power := Q^.Power;
        P := P^.Next;
        Q := Q^.Next;
      end
      else
      if P^.Power > Q^.Power then
      begin
        R^.Number := P^.Number;
        R^.Power := P^.Power;
        P := P^.Next;
      end;

      Y := R;
      New(R);
      Y^.Next := R;
    end;

    Y^.Next := nil;
  end;

begin
  New(First);
  New(Second);
  New(Third);

  Write('Enter the power of the 1st polynomial: ');
  SystemIn(N);
  Make(First, N);
  Write('1st polynomial: ');
  SystemOut(First);
  WriteLn;

  Write('Enter the power of the 2nd polynomial: ');
  SystemIn(N);
  Make(Second, N);
  Write('2nd polynomial: ');
  SystemOut(Second);
  WriteLn;

  Equality(First, Second);

  Write('The sum of polynomials: ');
  Sum(First, Second, Third);
  SystemOut(Third);
  WriteLn;

  Write('X1 = ');
  Readln(X);
  WriteLn('Y1 = ', Calculate(First, X));

  Write('X2 = ');
  Readln(X);
  WriteLn('Y2 = ', Calculate(Second, X));

  Readln;
end.

Program Lab3;

{$APPTYPE CONSOLE}

Uses
  SysUtils;

Type
  Polynom = ^EPolynom;

  EPolynom = Record
    Number: Integer;
    Power: Integer;
    Next: Polynom;
  End;

Var
  First, Second, Third: Polynom;
  N, X: Integer;

Procedure SystemIn(var Res: Integer);
Var
  Error: Integer;
  S: String;
Begin
  Repeat
    Readln(s);
    Val(s, Res, Error);
    If Error <> 0 Then
      WriteLn('Wrong number!');
  Until Error = 0;
End;

Procedure Make(X: Polynom; N: Integer);
Var
  Y: Polynom;
  Number: Integer;
Begin
  While (N >= 0) Do
  Begin
    Write('Number near (X^', N, ') = ');
    SystemIn(Number);
    If Number <> 0 Then
    Begin
      X^.Number:= Number;
      X^.Power:= N;

      Y:= X;
      New(X);

      Y^.Next:= X;
    End;
    N:= N - 1;

  End;
  Y^.Next:= Nil;

End;

Procedure SystemOut(P: Polynom);
Begin
  If P^.Power <> 0 Then
  Begin
    If P^.Number = 1 Then

      Write('X^', P^.Power)
    Else
      If P^.Number > 1 Then

        Write(P^.Number, 'X^', P^.Power)
      Else
        If P^.Number = -1 Then
          Write('-X^', P^.Power)
        Else
          If P^.Number < 0 Then
            Write(P^.Number, 'X^', P^.Power);
  End
  Else
    Write(P^.Number);

  While P <> Nil Do
  Begin

    P:= P^.Next;
    If (P <> Nil) Then
    Begin

      If (P^.Number < 0) Then
      Begin
        Write(' - ');
        If P^.Power <> 0 Then
        Begin
          If P^.Number = -1 Then
            Write('X^', P^.Power)
          Else
            Write(-1 * P^.Number, 'X^', P^.Power);
        End
        Else
        Begin
          Write(-1 * P^.Number);
        End;
      End
      Else
      Begin

        Write(' + ');
        If P^.Power <> 0 Then
        Begin

          If P^.Number = 1 Then
            Write('X^', P^.Power)
          Else
            Write(P^.Number, 'X^', P^.Power);
        End
        Else
        Begin
          Write(P^.Number);
        End;
      End;
    End;

  End;
End;

Function Equality(P: Polynom; Q: Polynom): Boolean;
Var
  Flag: Boolean;
Begin
  Flag:= true;
  While (P <> Nil) And (Q <> Nil) And Flag Do
  Begin
    If P^.Power = Q^.Power Then
    Begin
      If P^.Number <> Q^.Number Then
        Flag:= False;
    End
    Else
      Flag:= False;
    P:= P^.Next;
    Q:= Q^.Next;
  End;

  If Flag Then
    WriteLn('P = Q')
  Else
    WriteLn('P != Q');

  Result:= Flag;

End;

Function Calculate(P: Polynom; X: Integer): Integer;
Var
  I, Mult: Integer;
Begin
  Result:= 0;
  While P <> Nil Do
  Begin
    Mult:= 1;
    For I:= 1 To P^.Power Do
      Mult:= Mult * X;
    Result:= Result + P^.Number * Mult;

    P:= P^.Next;
  End;
End;

Procedure Sum(P: Polynom; Q: Polynom; R: Polynom);
Var
  Y: Polynom;
Begin

  While (Q <> Nil) And (P <> Nil) Do
  Begin

    If P^.Power < Q^.Power Then
    Begin
      R^.Number:= Q^.Number;
      R^.Power:= Q^.Power;
      Q:= Q^.Next;
    End
    Else
      If P^.Power = Q^.Power Then
      Begin
        R^.Number:= Q^.Number + P^.Number;
        R^.Power:= Q^.Power;
        P:= P^.Next;
        Q:= Q^.Next;
      End
      Else
        If P^.Power > Q^.Power Then
        Begin
          R^.Number:= P^.Number;
          R^.Power:= P^.Power;
          P:= P^.Next;
        End;

    Y:= R;
    New(R);
    Y^.Next:= R;

  End;

  Y^.Next:= Nil;
End;

Begin
  New(First);
  New(Second);
  New(Third);

  Write('Enter the power of the 1st polynom: ');
  SystemIn(N);
  Make(First, N);
  SystemOut(First);
  WriteLn;

  Write('Enter the power of the 2nd polynom: ');
  SystemIn(N);
  Make(Second, N);
  SystemOut(Second);
  WriteLn;

  Equality(First, Second);

  Write('The sum of polynoms: ');
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
End.

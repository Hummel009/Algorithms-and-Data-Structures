Program Lab5;

{$APPTYPE CONSOLE}

Uses
  SysUtils;

Type
  Pt = ^Elem;
  Elem = Record
    Prior: Integer;
    SubExp: String;
    Next: Pt;
    Prev: Pt;
  End;

Procedure MakePrioretyOtn(S: Char; Var Result: Integer);
Var
  Numbers: Set Of Char;
Begin
  Numbers:= ['0'..'9'];
  Case S Of
    '(':
      Result:= 9;
    ')':
      Result:= 0;
    '+', '-':
      Result:= 1;
    '*', '/':
      Result:= 3;
    '^':
      Result:= 6;
  End;

  If S In Numbers Then
    Result:= 7;
End;

Procedure MakePrioretyStack(S: Char; var Result: Integer);
Var
  Numbers: Set Of Char;
Begin
  Numbers:= ['0'..'9'];    
  Case S Of
    '(':
      Result:= 0;
    '+', '-':
      Result:= 2;
    '*', '/':
      Result:= 4;
    '^':
      Result:= 5;
  End;

  If S In Numbers Then
    Result:= 8;
End;

Function InfToPost(S: String): String;
Var
  X, Y: pt;
  I, K: Integer;
  Prior: Integer;
  Num, Temp: String;
  Numbers: Set Of Char;
Begin
  Numbers:= ['0'..'9'];

  New(X);
  Y:= X;
  X.Prev:= Nil;
  X.Prior:= -2;

  New(X);
  Y.Next:= X;
  X.Prev:= Y;

  Result:= '';
  S:= StringReplace(S, ' ', '', [rfReplaceAll]);
  I:= 1;

  While I <= Length(S) Do
  Begin
    If S[I] In Numbers Then
    Begin
      K:= 1;
      Num:= '';
      While S[I] In Numbers Do
      Begin
        Num:= Num + ' ';
        Num[K]:= S[I];
        K:= K + 1;
        I:= I + 1;
      End;
      Temp:= Num;
    End
    Else
    Begin
      Temp:= S[I];
      I:= I + 1;
    End;
    MakePrioretyOtn(S[I - 1], Prior);
    If (Prior > Y.Prior) Or (Y.Prior = -2) Then
    Begin
      X.SubExp:= Temp;
      MakePrioretyStack(S[I - 1], X.Prior);
      Y:= X;
      New(X);
      Y.Next:= X;
      X.Prev:= Y;
    End
    Else
      If (Prior <= Y.Prior) And (Prior <> -1) Then
      Begin
        Result:= Result + Y.SubExp + ' ';
        Y:= Y.Prev;
        Y.Next:= X;
        X.Prev:= Y;

        While (Prior < Y.Prior) And (Y.Prior <> 0) Do
        Begin
          Result:= Result + Y.SubExp + ' ';
          Y:= Y.Prev;
          Y.Next:= X;
          X.Prev:= Y;
        End;

        If Prior <> 0 Then
        Begin
          X.SubExp:= Temp;
          MakePrioretyStack(S[I - 1], X.Prior);
          Y:= X;
          New(X);
          Y.Next:= X;
          X.Prev:= Y;
        End
        Else
        Begin
          Y:= Y.Prev;
          Y.Next:= X;
          X.Prev:= Y;
        End;
      End;

  End;

  While Y.Prior <> -2 Do
  Begin
    Result:= Result + Y.SubExp + ' ';
    Y:= Y.Prev;
    Y.Next:= X;
    X.Prev:= Y;
  End;
End;

Var
  S: String;
  Syms: Set Of Char = ['-', '+', '*', '/', '^', '(', ')'];
  Nums: Set Of Char = ['0'..'9'];
  N, I: Integer;
Begin
  Writeln('Enter the formula:');
  Readln(S);
  S:= InfToPost(S);
  Writeln('Polish note: ', S);

  N:= 1;
  For I:= 1 To Length(S) Do
    If (S[I] In Nums) And (S[I - 1] = ' ') Then
      Inc(N);

  For I:= 1 To Length(S) Do
    If (S[I] In Syms) Then
      Dec(N);

  Writeln('The rank: ', N);
  Readln;
End.


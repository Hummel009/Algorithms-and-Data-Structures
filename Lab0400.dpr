Program Lab4;

{$APPTYPE CONSOLE}

Uses
  SysUtils;

Type
  Num = Record
    N: integer;
    Name: String;
    LastName: String;
    Number: String;
    Patronoic: String;
  End;

  LElem = ^Elem;

  Elem = Record
    Data: Num;
    Next: LElem;
  End;

Var
  First: LElem;
  LastName, Number: String;
  Sort: Integer;
  Flag: Boolean;

Procedure FindByLastName(X: LElem; LastName: String);
Var
  Count: Integer;
Begin
  Count:= 0;
  While X <> Nil Do
  Begin
    If X^.Data.LastName = LastName Then
    Begin
      Write(X^.Data.Name: 10, ' ');
      Write(X^.Data.LastName: 15, ' ');
      Write(X^.Data.Patronoic: 15, ' ');
      WriteLn(X^.Data.Number: 17);
      Inc(Count);
    End;
    X:= X^.Next;
  End;
  If Count = 0 Then
    WriteLn('Abonent does not exist!');

End;

Procedure FindByNumber(X: LElem; Number: String);
Var
  Count: Integer;
Begin
  Count:= 0;
  While X <> Nil Do
  Begin

    If X^.Data.Number = Number Then
    Begin
      Write(X^.Data.Name: 10, ' ');
      Write(X^.Data.LastName: 15, ' ');
      Write(X^.Data.Patronoic: 15, ' ');
      WriteLn(X^.Data.Number: 17);
      inc(Count);

    End;
    X:= X^.Next;
  End;
  If Count = 0 Then
    WriteLn('Abonent does not exist!');

End;

Procedure Input(Var X: Integer);
Var
  Error: Integer;
  Sus: String;
Begin

  Repeat
    ReadLn(Sus);
    Val(Sus, X, Error);
    If (Error <> 0) Or (Length(Sus) <> 7) Then
      WriteLn('Error!');
  Until (Error = 0) And (Length(Sus) = 7);

End;   

Procedure Make(X: LElem);
Var
  Y: LElem;
  Number, N: Integer;
  Name, LastName, Patronoic: String;
  Change: String;
Begin
  Change:= 'Yes';
  N:= 1;
  While (Change <> 'No') Do
  Begin

    Write('Enter the name: ');
    ReadLn(Name);
    Write('Enter the surname: ');
    ReadLn(LastName);
    Write('Enter the patronoic: ');
    ReadLn(Patronoic);
    Write('Enter the phone number: ');
    Input(Number);

    X^.Data.Number:= '+37529' + IntToStr(Number);

    X^.Data.Name:= NAme;
    X^.Data.LastName:= LastName;
    X^.Data.Patronoic:= Patronoic;
    X^.Data.N:= N;
    Inc(N);
    Y:= X;
    New(X);

    Y^.Next:= X;
    Write('Do you want to add another one? ');
    ReadLn(Change);
  End;
  Y^.Next:= Nil;

End;       

Procedure Show(X: LElem);
Begin

  While (X <> Nil) Do
  Begin
    Write(X^.Data.Name: 10, ' ');
    Write(X^.Data.LastName: 15, ' ');
    Write(X^.Data.Patronoic: 15, ' ');
    WriteLn(X^.Data.Number: 17);
    X:= X^.Next;
  End;
End;

Procedure SortNumber(Y: LElem; Sort: Integer);
Var
  Len, I, J: integer;
  X: LElem;
  Tmps: Num;
  Flag: Boolean;
Begin
  X:= Y;
  Len:= 0;
  While X <> Nil Do
  Begin
    Inc(Len);
    X:= X^.Next;
  End;

  For I:= 1 To Len Do
  Begin
    X:= Y;
    For J:= 1 To Len - I Do
    Begin
      Flag:= False;
      Case Sort Of
        1:
          If X^.Data.Name > X^.Next^.Data.Name Then
            Flag:= True;
        2:
          If X^.Data.LastName > X^.Next^.Data.LastName Then
            Flag:= True;
        3:
          If X^.Data.Patronoic > X^.Next^.Data.Patronoic Then
            Flag:= True;
      End;

      If Flag Then
      Begin
        Tmps:= X^.Data;
        X^.Data:= X^.Next^.Data;
        X^.Next^.Data:= Tmps;
      End;
      X:= X^.Next
    End;
  End
End;

Begin
  New(First);
  Make(First);
  WriteLn;
  WriteLn('Enter the sort type: 1 - name, 2 - surname, 3 - patronoic');
  Flag:= False;
  Repeat
    ReadLn(Sort);
    If (Sort In [1, 2, 3]) Then
      Flag:= True;
  Until Flag;

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
End.


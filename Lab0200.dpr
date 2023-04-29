Program Lab2;

{$APPTYPE CONSOLE}

//Declare types
Type
  //Two-sided list
  TYesKGB = ^EYesKGB;
  EYesKGB = Record
    Data: String;
    Next, Prev: TYesKGB;
  End;
     
  //One-sided list
  TNoKGB = ^ENoKGB;
  ENoKGB = Record
    Data: String;
    Next: TNoKGB;
  End;
  
//Declare variables
Var
  VYesKGB: TYesKGB;
  VNoKGB: TNoKGB;

Procedure LoadYesKGB(Var X: TYesKGB);
Var
  I, Check, Error, Len: Integer;
  Y: TYesKGB;
Begin
  New(X);
  Write('Enter the quantity of phone numbers: ');
  ReadLn(Len);
  X^.Prev:= Nil;

  //Filling the list
  For I:= 0 To Len - 1 Do
  Begin
    Y:= X;

    //Check for the correct input
    Repeat
      Write('Number #', I+1, ':');
      ReadLn(X^.Data);
      Val(X^.Data, Check, Error);
      If ((Length(X^.Data) <> 7) And (Length(X^.Data) <> 3)) Or (Error <> 0) Then
        WriteLn('Incorrect input');
    Until ((Length(X^.Data) = 7) Or (Length(X^.Data) = 3)) And (Error = 0);

    //Setting previous and next for every element
    If I < Len - 1 Then
    Begin
      New(X);
      Y^.Next:= X;
      X^.Prev:= Y;
    End;
  End;
  Y^.Next:= Nil;
End;

//Shows all numbers including KGB
Procedure PrintYesKGB(X: TYesKGB);
Begin
  While X <> Nil Do
  Begin
    WriteLn(X^.Data);
    X:= X^.Prev;
  End;
End;
  
//Shows all numbers excluding KGB
Procedure PrintNoKGB(X: TNoKGB);
Begin
  While X <> Nil Do
  Begin
    WriteLn(X^.Data);
    X:= X^.Next;
  End;
End;
             
//Removes KGB numbers (3 symbols) from the list
Procedure RemoveKGB(Y: TNoKGB; X: TYesKGB);
Begin
  While X <> Nil Do
  Begin
    If Length(X^.Data) <> 3 Then
    Begin
      New(Y^.Next);
      Y:= Y^.Next;
      Y^.Data:= X^.Data;
    End;
    X:= X^.Prev;
  End;
  Y^.Next:= Nil;
End;

//Sorts not-KGB numbers by symbols
Procedure SortNoKGB(Start: TNoKGB);
Var
  I, J, Len: Integer;
  X: TNoKGB;
  Temp: String;
Begin
  X:= Start;
  Len:= 0;
  While X <> Nil Do
  Begin
    Inc(Len);
    X:= X^.Next;
  End;
  For I:= 1 To Len Do
  Begin
    X:= Start;

    //Comparing strings does the same as comparing every number
    For J:= 1 To Len - I Do
    Begin
      If X^.Data > X^.Next^.Data Then
      Begin
        Temp:= X^.Data;
        X^.Data:= X^.Next^.Data;
        X^.Next^.Data:= Temp;
      End;
      X:= X^.Next;
    End;
  End;
End;

Begin
  LoadYesKGB(VYesKGB);
  WriteLn;
  WriteLn('Phone numbers including KGB:');
  PrintYesKGB(VYesKGB);
  WriteLn;
  Write('Phone numbers excluding KGB:');    
  New(VNoKGB);
  RemoveKGB(VNoKGB, VYesKGB);
  SortNoKGB(VNoKGB);
  PrintNoKGB(VNoKGB);
  ReadLn;
End.

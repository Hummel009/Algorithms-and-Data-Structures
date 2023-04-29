Program Lab1;

//Use app
{$APPTYPE CONSOLE}

//Declare modules
Uses
  SysUtils;

Type
  //base type
  TData = Integer;
  //link to element
  TPElem = ^TElem;
  //the element
  TElem = Record
    //main data
    Data:TData;
    //link to the next element
    PNext:TPElem;
  End;
  //Order
  TQueue = Record
    //Num of elements
    Cnt:Integer;
    //Link to the first and the second
    PFirst, PLast:TPElem;
  End;   

Var
  Q:TQueue;
  Data:TData;
  Cmd, Code, i, Cnt, K, Kr:Integer;
  S:String;
  Loop:Boolean;

//The creating (init) of the order. Only for not-empty (clear before)
Procedure Init(Var aQ:TQueue);
Begin
  aQ.Cnt:= 0;
  aQ.PFirst:= Nil;
  aQ.PLast:= Nil;
End;

//Add to finish
Procedure Push(Var aQ:TQueue; Const aData:TData);
Var
  PElem:TPElem;
Begin
  New(PElem);
  PElem^.Data:= aData;
  PElem^.PNext:= Nil;
  If aQ.PFirst = Nil Then
    aQ.PFirst:= PElem
  Else
    aQ.PLast^.PNext:= PElem;
  aQ.PLast:= PElem;
  Inc(aQ.Cnt);
End;

//Take the first element. If is not empty, returns aData. If not, returns False and doesn't work
Function Pop(Var aQ:TQueue; Var aData:TData):Boolean;
Var
  PElem:TPElem;
Begin
  Result:= False;
  If aQ.PFirst = Nil Then Exit;

  PElem:= aQ.PFirst;
  aData:= PElem^.Data;
  aQ.PFirst:= PElem^.PNext;
  If aQ.PFirst = Nil Then
    aQ.PLast:= Nil;
  Dispose(PElem);
  Dec(aQ.Cnt);
  Result:= True;
End;

//Clear data
Procedure Free(Var aQ:TQueue);
Var
  Data:TData;
Begin
  While Pop(aQ, Data) Do ;
End;

//Print from end to start
Procedure QWriteln(Const aQ:TQueue);
Var
  PElem:TPElem;
  i:Integer;
Begin
  PElem:= aQ.PFirst;
  i:= 0;
  While PElem <> Nil Do
  Begin
    Inc(i);
    If i > 1 Then Write(', ');
    Write(PElem^.Data);
    PElem:= PElem^.PNext;
  End;
  Writeln;
End;

Begin
  Init(Q);

  Write('The loop? Type "Yes" or "No": ');
  Readln(S);
  If S = 'Yes' Then
    loop:= true
  Else
    loop:= False;

  If Not loop Then
    //Enter quantity
    Repeat
      Write('Quantity: ');
      Readln(S);
      Val(S, Cnt, Code);
      If (Code > 0) Or (Cnt <= 0) Then
      Begin
        Writeln('Error.');
        Code:= 1;
      End
    Until Code = 0;

  //Enter the number of disappearing person
  Repeat
    Write('Disappearing: ');
    Readln(S);
    Val(S, K, Code);
    If (Code > 0) Or (K <= 0) Then
    Begin
      Writeln('Error.');
      Code:= 1;
    End
  Until Code = 0;

  //Clear memory
  Free(Q);
  For Cnt:= 1 To 64 Do
  Begin
    //Add users to list
    For i:= 1 To Cnt Do
      Push(Q, i);

    //Repeat until there is one alive
    While Q.Cnt > 1 Do
    Begin
      //The pos of disappearing person
      Kr:= K Mod Q.Cnt;
      If Kr = 0 Then Kr:= Q.Cnt;

      //move all people BEFORE disappearing from the beginning to end
      For i:= 1 To Kr - 1 Do
      Begin
        //From the beginning
        Pop(Q, Data);
        //To the end
        Push(Q, Data);
      End;

      //The current first person is KR. Remove and do not add back
      Pop(Q, Data);

      //Display him
      Write(Data, ' ');
    End;
    Pop(Q, Data);

    //The last person is alive
    Write('| Alive: ', Data);

    //Clear memory
    Free(Q);
    Writeln;
    Writeln;
  End;

  Readln;
End.



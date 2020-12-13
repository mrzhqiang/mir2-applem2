unit GateCommon;

interface
uses
  Windows, Messages, SysUtils, Classes, Forms;

const
  MAXMAPLOGINGATECOUNT = 5;
  MAXMAPSELGATECOUNT = 6;
  MAXMAPRUNGATECOUNT = 20;
  MAPGATENAME = 'Map_GameGate';
  EVENTGATENAME = 'Event_GameGate';

type
  pTMapGateInfo = ^TMapGateInfo;
  TMapGateInfo = packed record
    LoginGate: array[0..MAXMAPLOGINGATECOUNT - 1] of THandle;
    SelGate: array[0..MAXMAPSELGATECOUNT - 1] of THandle;
    RunGate: array[0..MAXMAPRUNGATECOUNT - 1] of THandle;
  end;

  TGateType = (gt_LoginGate, gt_SelGate, gt_RunGate, gt_All);

function AddMapHandle(GateType: TGateType; Handle: THandle): Boolean;
procedure DelMapHandle(GateType: TGateType; Handle: THandle);
procedure SendMapMsg(GateType: TGateType; wIdent: Word; sSendMsg: string);

implementation

uses
Hutil32;

var
  FileHandle: THandle = 0;
  MapGateInfo: pTMapGateInfo = nil;
  EventHandle: THandle;
  boCreate: Boolean;

function Lock: Boolean;
begin
  Result := False;
  if EventHandle > 0 then begin
    if WAIT_OBJECT_0 = WaitForSingleObject(EventHandle, 5 * 1000) then
      Result := True
  end;
end;

procedure UnLock;
begin
  if EventHandle > 0 then
    SetEvent(EventHandle);
end;

procedure SendMapMsg(GateType: TGateType; wIdent: Word; sSendMsg: string);
var
  SendData: TCopyDataStruct;
  I: Integer;
  nParam: Integer;
begin
  nParam := MakeLong(Word(GateType), wIdent);
  SendData.cbData := Length(sSendMsg) + 1;
  GetMem(SendData.lpData, SendData.cbData);
  StrCopy(SendData.lpData, PChar(sSendMsg));
  try
    if MapGateInfo <> nil then begin
      if Lock then begin
        try
          case GateType of
            gt_LoginGate: begin
                for I := Low(MapGateInfo.LoginGate) to High(MapGateInfo.LoginGate) do begin
                  if MapGateInfo.LoginGate[I] <> 0 then begin
                    SendMessage(MapGateInfo.LoginGate[I], WM_COPYDATA, nParam, Cardinal(@SendData));
                  end;
                end;
              end;
            gt_SelGate: begin
                for I := Low(MapGateInfo.SelGate) to High(MapGateInfo.SelGate) do begin
                  if MapGateInfo.SelGate[I] <> 0 then begin
                    SendMessage(MapGateInfo.SelGate[I], WM_COPYDATA, nParam, Cardinal(@SendData));
                  end;
                end;
              end;
            gt_RunGate: begin
                for I := Low(MapGateInfo.RunGate) to High(MapGateInfo.RunGate) do begin
                  if MapGateInfo.RunGate[I] <> 0 then begin
                    SendMessage(MapGateInfo.RunGate[I], WM_COPYDATA, nParam, Cardinal(@SendData));
                  end;
                end;
              end;
            gt_All: begin
                for I := Low(MapGateInfo.LoginGate) to High(MapGateInfo.LoginGate) do begin
                  if MapGateInfo.LoginGate[I] <> 0 then begin
                    SendMessage(MapGateInfo.LoginGate[I], WM_COPYDATA, nParam, Cardinal(@SendData));
                  end;
                end;
                for I := Low(MapGateInfo.SelGate) to High(MapGateInfo.SelGate) do begin
                  if MapGateInfo.SelGate[I] <> 0 then begin
                    SendMessage(MapGateInfo.SelGate[I], WM_COPYDATA, nParam, Cardinal(@SendData));
                  end;
                end;
                for I := Low(MapGateInfo.RunGate) to High(MapGateInfo.RunGate) do begin
                  if MapGateInfo.RunGate[I] <> 0 then begin
                    SendMessage(MapGateInfo.RunGate[I], WM_COPYDATA, nParam, Cardinal(@SendData));
                  end;
                end;
              end;
          end;
        finally
          UnLock;
        end;
      end;
    end;
  finally
    FreeMem(SendData.lpData);
  end;
end;

function AddMapHandle(GateType: TGateType; Handle: THandle): Boolean;
var
  i: Integer;
begin
  Result := False;
  if MapGateInfo <> nil then begin
    if Lock then begin
      try
        case GateType of
          gt_LoginGate: begin
              for I := Low(MapGateInfo.LoginGate) to High(MapGateInfo.LoginGate) do begin
                if MapGateInfo.LoginGate[I] = 0 then begin
                  MapGateInfo.LoginGate[I] := Handle;
                  Result := True;
                  break;
                end;
              end;
            end;
          gt_SelGate: begin
              for I := Low(MapGateInfo.SelGate) to High(MapGateInfo.SelGate) do begin
                if MapGateInfo.SelGate[I] = 0 then begin
                  MapGateInfo.SelGate[I] := Handle;
                  Result := True;
                  break;
                end;
              end;
            end;
          gt_RunGate: begin
              for I := Low(MapGateInfo.RunGate) to High(MapGateInfo.RunGate) do begin
                if MapGateInfo.RunGate[I] = 0 then begin
                  MapGateInfo.RunGate[I] := Handle;
                  Result := True;
                  break;
                end;
              end;
            end;
        end;
      finally
        UnLock;
      end;
    end;
  end;
end;

procedure DelMapHandle(GateType: TGateType; Handle: THandle);
var
  i: Integer;
begin
  if MapGateInfo <> nil then begin
    if Lock then begin
      try
        case GateType of
          gt_LoginGate: begin
              for I := Low(MapGateInfo.LoginGate) to High(MapGateInfo.LoginGate) do begin
                if MapGateInfo.LoginGate[I] = Handle then begin
                  MapGateInfo.LoginGate[I] := 0;
                  break;
                end;
              end;
            end;
          gt_SelGate: begin
              for I := Low(MapGateInfo.SelGate) to High(MapGateInfo.SelGate) do begin
                if MapGateInfo.SelGate[I] = Handle then begin
                  MapGateInfo.SelGate[I] := 0;
                  break;
                end;
              end;
            end;
          gt_RunGate: begin
              for I := Low(MapGateInfo.RunGate) to High(MapGateInfo.RunGate) do begin
                if MapGateInfo.RunGate[I] = Handle then begin
                  MapGateInfo.RunGate[I] := 0;
                  break;
                end;
              end;
            end;
        end;
      finally
        UnLock;
      end;
    end;
  end;
end;

initialization
  begin
    boCreate := False;
    // 创建一个可自动还原的事件，主要用来做进程间同步（猜测是多个网关的数据同步）
    EventHandle := CreateEvent(nil, False, True, EVENTGATENAME);
    FileHandle := OpenFileMapping(FILE_MAP_ALL_ACCESS, False, MAPGATENAME);
    if FileHandle = 0 then begin
      FileHandle := CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, SizeOf(TMapGateInfo), MAPGATENAME);
      boCreate := True;
    end;
    if FileHandle <> 0 then begin
      MapGateInfo := MapViewOfFile(FileHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0);
      if boCreate then begin
        if MapGateInfo <> nil then
          SafeFillChar(MapGateInfo^, SizeOf(TMapGateInfo), #0)
        else begin
          CloseHandle(FileHandle);
          FileHandle := 0;
        end;
      end;
    end;
  end;

finalization
  begin
    if MapGateInfo <> nil then
      UnMapViewOfFile(MapGateInfo);
    if FileHandle <> 0 then
      CloseHandle(FileHandle);
    if EventHandle <> 0 then
      CloseHandle(EventHandle);
  end;
end.


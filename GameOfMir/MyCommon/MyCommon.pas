unit MyCommon;

interface
uses
  Windows, SysUtils, DateUtils, PsAPI, TLHelp32;

type

  {TFileTime = packed record
    CreateTime: TDateTime;
    ChangeTime: TDateTime;
  end;   }

  PFileVersionInfo = ^TFileVersionInfo;
  TFileVersionInfo = packed record
    sVersion: string[24];
    wMajor: Integer;
    wMinor: Integer;
    wRelease: Integer;
    wBuild: Integer;
  end;

  pTTranslate = ^TTranslate;
  TTranslate = packed record
    wLanguage: Word;
    wCodePage: Word;
  end;

  TFileInfo = packed record
    CommpanyName: string;
    FileDescription: string;
    FileVersion: string;
    InternalName: string;
    LegalCopyright: string;
    LegalTrademarks: string;
    OriginalFileName: string;
    ProductName: string;
    ProductVersion: string;
    SpecialBuild: string;
    PrivateBuild: string;
    Comments: string;
    VsFixedFileInfo: VS_FIXEDFILEINFO;
    UserDefineValues: array of string;
  end;

  //ת���ļ�ʱ��Ϊ��ͨʱ��
function CovFileDate(FileTime: _FileTime): TDateTime;
function GetIdeSerialNumber: string; //��ȡӲ�̵ĳ���ϵ�кţ�
function GetCpuID(): string; //��ȡCPU��ϵ�к�

//�õ�����İ汾��
function GetFileVersion(sFileName: string; FileVersionInfo: PFileVersionInfo): boolean;

function GetFileVersionInfomation(const FileName: string; var Info: TFileInfo; const UserDefine: array of string): Boolean;

//ʱ��ת��ΪGMT��ʽ
function DateTimeToGMT(const DateTime: TDateTime): string;


//���������ļ�����ȡ���ھ��
function GetHandleByFileName(sFileName: string): THandle;

//ȡ�ļ�����޸�ʱ��
function FileTime(FileName: string): TDateTime;

function GetFileVerSionInfoByNameW(sFileName, sName: WideString): WideString;
function SetFileVerSionInfoByNameW(sFileName, sName, sValue: WideString): Boolean;

implementation

function SetFileVerSionInfoByNameW(sFileName, sName, sValue: WideString): Boolean;
var
  dwSize, dwSize2: LongWord;
  Buffer: Pointer;
  Translate: pTTranslate;
  ValueBuffer: PWideChar;
  hResource: THandle;
begin
  Result := False;
  dwSize := GetFileVersionInfoSizeW(PWideChar(sFileName), dwSize);
  if dwSize = 0 then exit;
  Buffer := AllocMem(dwSize);
  Try
    if GetFileVersionInfoW(PWideChar(sFileName), 0, dwSize, Buffer) then begin
      VerQueryValueW(Buffer, PWideChar(WideString('\\VarFileInfo\\Translation')), Pointer(Translate), dwSize2);
      VerQueryValueW(Buffer, PWideChar(WideString(Format('\\StringFileInfo\\%.4x%.4x\\' + sName, [Translate.wLanguage, Translate.wCodePage]))), Pointer(ValueBuffer), dwSize2);
      if dwSize2 > 0 then begin
        hResource := BeginUpdateResourceW(PWideChar(sFileName), False);
        if hResource > 0 then begin
          Move(sValue[1], ValueBuffer^, (Length(sValue) + 1) * 2);
          Result := UpdateResourceW(hResource, MakeIntResourceW(RT_VERSION), MakeIntResourceW(VS_VERSION_INFO), Translate.wLanguage, Buffer, dwSize) and EndUpdateResourceW(hResource, False);
        end;
      end;
    end;
  Finally
    FreeMem(Buffer);
  End;
end;

function GetFileVerSionInfoByNameW(sFileName, sName: WideString): WideString;
var
  dwSize, dwSize2: LongWord;
  Buffer: Pointer;
  Translate: pTTranslate;
  ValueBuffer: PWideChar;
begin
  Result := '';
  dwSize := GetFileVersionInfoSizeW(PWideChar(sFileName), dwSize);
  if dwSize = 0 then exit;
  Buffer := AllocMem(dwSize);
  Try
    if GetFileVersionInfoW(PWideChar(sFileName), 0, dwSize, Buffer) then begin
      VerQueryValueW(Buffer, PWideChar(WideString('\\VarFileInfo\\Translation')), Pointer(Translate), dwSize2);
      VerQueryValueW(Buffer, PWideChar(WideString(Format('\\StringFileInfo\\%.4x%.4x\\' + sName, [Translate.wLanguage, Translate.wCodePage]))), Pointer(ValueBuffer), dwSize2);
      Result := ValueBuffer;
    end;
  Finally
    FreeMem(Buffer);
  End;
end;

function FileTime(FileName: string): TDateTime;
var
  vSearchRec: TSearchRec;
  LocalFileTime: TFileTime;
  I: Integer;
begin
  if FindFirst(filename, faAnyFile, vSearchRec) = 0 then
    FileTimeToLocalFileTime(vSearchRec.FindData.ftLastWriteTime, LocalFileTime);
  FileTimeToDosDateTime(LocalFileTime, LongRec(I).Hi, LongRec(I).Lo);
  FindClose(vSearchRec);
  Result := FileDateToDateTime(I);
end;

//ȡCPU���

function GetCpuID(): string;
type
  TCPUID = array[1..4] of Longint;
var
  CPUIDinfo: TCPUID;
  function IsCPUID_Available: Boolean;
  asm
      PUSHFD       {direct access to flags no possible, only via stack}
      POP     EAX     {flags to EAX}
      MOV     EDX,EAX   {save current flags}
      XOR     EAX,$200000; {not ID bit}
      PUSH    EAX     {onto stack}
      POPFD        {from stack to flags, with not ID bit}
      PUSHFD       {back to stack}
      POP     EAX     {get back to EAX}
      XOR     EAX,EDX   {check if ID bit affected}
      JZ      @exit    {no, CPUID not availavle}
      MOV     AL,True   {Result=True}
      @exit:
  end;
  function GetCPUIDSN: TCPUID; assembler;
  asm
      PUSH    EBX         {Save affected register}
      PUSH    EDI
      MOV     EDI,EAX     {@Resukt}
      MOV     EAX,1
      DW      $A20F       {CPUID Command}
      STOSD             {CPUID[1]}
      MOV     EAX,EBX
      STOSD               {CPUID[2]}
      MOV     EAX,ECX
      STOSD               {CPUID[3]}
      MOV     EAX,EDX
      STOSD               {CPUID[4]}
      POP     EDI     {Restore registers}
      POP     EBX
  end;
begin
  if IsCPUID_Available then begin
    CPUIDinfo := GetCPUIDSN;
  end
  else begin //����cpu��ID
    CPUIDinfo[1] := 0136;
    CPUIDinfo[4] := 66263155;
  end;
  Result := IntToHex((CPUIDinfo[1] {+ CPUIDinfo[2] }+ CPUIDinfo[3] + CPUIDinfo[4]), 8);
end;

function GetHandleByFileName(sFileName: string): THandle;
type
  PEnumInfo = ^TEnumInfo;
  TEnumInfo = record
    ProcessID: DWORD;
    HWND: THandle;
  end;

  function EnumWindowsProc(Wnd: DWORD; var EI: TEnumInfo): Bool; stdcall;
  var
    PID: DWORD;
  begin
    GetWindowThreadProcessID(Wnd, @PID);
    Result := (PID <> EI.ProcessID) or (not IsWindowVisible(WND)) or (not IsWindowEnabled(WND));
    if not Result then
      EI.HWND := WND;
  end;

  function FindMainWindow(PID: DWORD): DWORD;
  var
    EI: TEnumInfo;
  begin
    EI.ProcessID := PID;
    EI.HWND := 0;
    EnumWindows(@EnumWindowsProc, Integer(@EI));
    Result := EI.HWND;
  end;

  function GetHWndByPID(const hPID: THandle): THandle;
  begin
    if hPID <> 0 then Result := FindMainWindow(hPID)
    else Result := 0;
  end;
var
  ProcessName: array[0..MAX_PATH] of Char; //������
  FSnapshotHandle: THandle; //���̿��վ��
  FProcessEntry32: TProcessEntry32; //������ڵĽṹ����Ϣ
  ContinueLoop: BOOL;
  ProcessHandle: THandle;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0); //����һ�����̿���
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32); //�õ�ϵͳ�е�һ������
  //ѭ������
  while ContinueLoop do begin
    ProcessHandle := Windows.OpenProcess(PROCESS_ALL_ACCESS, False, FProcessEntry32.th32ProcessID);
    Try
      if ProcessHandle > 0 then begin
        GetModuleFileNameEx(ProcessHandle, 0, @ProcessName[0], MAX_PATH);
        if CompareText(sFileName, ProcessName) = 0 then begin
          Result := GetHWndByPID(FProcessEntry32.th32ProcessID);
          Break;
        end;
      end;
    Finally
      CloseHandle(ProcessHandle);
    End;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle); //   �ͷſ��վ��
end;


//ʱ��ת��ΪGMT��ʽ

function DateTimeToGMT(const DateTime: TDateTime): string;
begin
  Result := FormatDateTime('ddd, dd mmm yyyy hh:mm:ss', IncHour(DateTime, -8));
  Result := StringReplace(Result, 'һ��', 'Jan', [rfReplaceAll]);
  Result := StringReplace(Result, '����', 'Feb', [rfReplaceAll]);
  Result := StringReplace(Result, '����', 'Mar', [rfReplaceAll]);
  Result := StringReplace(Result, '����', 'Apr', [rfReplaceAll]);
  Result := StringReplace(Result, '����', 'May', [rfReplaceAll]);
  Result := StringReplace(Result, '����', 'Jun', [rfReplaceAll]);
  Result := StringReplace(Result, '����', 'Jul', [rfReplaceAll]);
  Result := StringReplace(Result, '����', 'Aug', [rfReplaceAll]);
  Result := StringReplace(Result, '����', 'Sep', [rfReplaceAll]);
  Result := StringReplace(Result, 'ʮ��', 'Oct', [rfReplaceAll]);
  Result := StringReplace(Result, 'ʮһ��', 'Nov', [rfReplaceAll]);
  Result := StringReplace(Result, 'ʮ����', 'Dec', [rfReplaceAll]);
  Result := StringReplace(Result, '������', 'Sun', [rfReplaceAll]);
  Result := StringReplace(Result, '����һ', 'Mon', [rfReplaceAll]);
  Result := StringReplace(Result, '���ڶ�', 'Tue', [rfReplaceAll]);
  Result := StringReplace(Result, '������', 'Wed', [rfReplaceAll]);
  Result := StringReplace(Result, '������', 'Thu', [rfReplaceAll]);
  Result := StringReplace(Result, '������', 'Fri', [rfReplaceAll]);
  Result := StringReplace(Result, '������', 'Sat', [rfReplaceAll]);
  Result := Result + ' GMT';
end;

{-------------------------------------------------------------------------------
  �������ã� ת���ļ�ʱ��Ϊ��ͨʱ��
  ������:    CovFileDate
  ����:      HuangFei
  ����:      2009.11.11
  ����:      Fd: _FileTime
  ����ֵ:    TDateTime
-------------------------------------------------------------------------------}

function CovFileDate(FileTime: _FileTime): TDateTime;
var
  Tct: _SystemTime;
  Temp: _FileTime;
begin
  FileTimeToLocalFileTime(FileTime, Temp);
  FileTimeToSystemTime(Temp, Tct);
  CovFileDate := SystemTimeToDateTime(Tct);
end;

{-------------------------------------------------------------------------------
  ��������:  �õ�����İ汾��
  ������:    GetFileVersion
  ����:      HuangFei
  ����:      2009.12.17
  ����:      sFileName: string; var Major, Minor, Release, Build: integer
  ����ֵ:    boolean
-------------------------------------------------------------------------------}

function GetFileVersion(sFileName: string; FileVersionInfo: PFileVersionInfo): boolean;
var
  Buffer: PChar;
  VS: PVSFixedFileInfo;
  dwSize: LongWord;
begin
  Result := False;
  if FileVersionInfo = nil then
    exit;
  FillChar(FileVersionInfo^, SizeOf(TFileVersionInfo), #0);
  dwSize := GetFileVersionInfoSize(PChar(sFileName), dwSize);
  if dwSize = 0 then
    exit;
  Buffer := AllocMem(dwSize);
  try
    if GetFileVersionInfo(PChar(sFileName), 0, dwSize, Buffer) then
      if VerQueryValue(Buffer, '\', Pointer(VS), dwSize) then begin
        FileVersionInfo.wMajor := HiWord(VS.dwFileVersionMS);
        FileVersionInfo.wMinor := LoWord(VS.dwFileVersionMS);
        FileVersionInfo.wRelease := HiWord(VS.dwFileVersionLS);
        FileVersionInfo.wBuild := LoWord(VS.dwFileVersionLS);
        FileVersionInfo.sVersion := Format('%d.%d.%d.%d', [FileVersionInfo.wMajor, FileVersionInfo.wMinor, FileVersionInfo.wRelease, FileVersionInfo.wBuild]);
        Result := True;
      end;
  finally
    FreeMem(Buffer);
  end;
end;

function GetFileVersionInfomation(const FileName: string; var Info: TFileInfo; const UserDefine: array of string): Boolean;
const
  SFInfo = '\StringFileInfo\';
var
  VersionInfo: Pointer;
  InfoSize: DWORD;
  InfoPointer: Pointer;
  Translation: Pointer;
  VersionValue: string;
  unused: DWORD;
  iUseDefineNum: Integer;
begin
  unused := 0;
  Result := False;
  InfoSize := GetFileVersionInfoSize(pchar(FileName), unused);
  if InfoSize > 0 then begin
    GetMem(VersionInfo, InfoSize);
    Result := GetFileVersionInfo(pchar(FileName), 0, InfoSize, VersionInfo);
    if Result then begin
      VerQueryValue(VersionInfo, '\VarFileInfo\Translation', Translation, InfoSize);
      VersionValue := SFInfo + IntToHex(LoWord(Longint(Translation^)), 4) +
        IntToHex(HiWord(Longint(Translation^)), 4) + '\';
      VerQueryValue(VersionInfo, pchar(VersionValue + 'CompanyName'), InfoPointer, InfoSize);
      Info.CommpanyName := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'FileDescription'), InfoPointer, InfoSize);
      Info.FileDescription := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'FileVersion'), InfoPointer, InfoSize);
      Info.FileVersion := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'InternalName'), InfoPointer, InfoSize);
      Info.InternalName := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'LegalCopyright'), InfoPointer, InfoSize);
      Info.LegalCopyright := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'LegalTrademarks'), InfoPointer, InfoSize);
      Info.LegalTrademarks := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'OriginalFileName'), InfoPointer, InfoSize);
      Info.OriginalFileName := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'ProductName'), InfoPointer, InfoSize);
      Info.ProductName := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'ProductVersion'), InfoPointer, InfoSize);
      Info.ProductVersion := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'SpecialBuild'), InfoPointer, InfoSize);
      Info.SpecialBuild := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'PrivateBuild'), InfoPointer, InfoSize);
      Info.PrivateBuild := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'Comments'), InfoPointer, InfoSize);
      Info.Comments := string(pchar(InfoPointer));
      if VerQueryValue(VersionInfo, '\', InfoPointer, InfoSize) then
        Info.VsFixedFileInfo := TVSFixedFileInfo(InfoPointer^);
      for iUseDefineNum := Low(UserDefine) to High(UserDefine) do begin
        if VerQueryValue(VersionInfo, PChar(VersionValue + UserDefine[iUseDefineNum]), InfoPointer, InfoSize) then begin
          Info.UserDefineValues[iUseDefineNum] := string(pchar(InfoPointer));
        end;
      end;
      {if   UserDefine   <>   ''   then
      begin
          if   VerQueryValue(VersionInfo,   pchar(VersionValue   +   UserDefine),   InfoPointer,   InfoSize)   then
              Info.UserDefineValue   :=   string(pchar(InfoPointer));
      end;}
    end;
    FreeMem(VersionInfo);
  end;
end;

function GetIdeSerialNumber: string; //��ȡӲ�̵ĳ���ϵ�кţ�
const
  IDENTIFY_BUFFER_SIZE = 512;
type
  TIDERegs = packed record
    bFeaturesReg: BYTE; //   Used   for   specifying   SMART   "commands".
    bSectorCountReg: BYTE; //   IDE   sector   count   register
    bSectorNumberReg: BYTE; //   IDE   sector   number   register
    bCylLowReg: BYTE; //   IDE   low   order   cylinder   value
    bCylHighReg: BYTE; //   IDE   high   order   cylinder   value
    bDriveHeadReg: BYTE; //   IDE   drive/head   register
    bCommandReg: BYTE; //   Actual   IDE   command.
    bReserved: BYTE; //   reserved   for   future   use.     Must   be   zero.
  end;
  TSendCmdInParams = packed record
    cBufferSize: DWORD; //   Buffer   size   in   bytes
    irDriveRegs: TIDERegs; //   Structure   with   drive   register   values.
    bDriveNumber: BYTE; //   Physical   drive   number   to   send   command   to   (0,1,2,3).
    bReserved: array[0..2] of Byte;
    dwReserved: array[0..3] of DWORD;
    bBuffer: array[0..0] of Byte; //   Input   buffer.
  end;
  TIdSector = packed record
    wGenConfig: Word;
    wNumCyls: Word;
    wReserved: Word;
    wNumHeads: Word;
    wBytesPerTrack: Word;
    wBytesPerSector: Word;
    wSectorsPerTrack: Word;
    wVendorUnique: array[0..2] of Word;
    sSerialNumber: array[0..19] of CHAR;
    wBufferType: Word;
    wBufferSize: Word;
    wECCSize: Word;
    sFirmwareRev: array[0..7] of Char;
    sModelNumber: array[0..39] of Char;
    wMoreVendorUnique: Word;
    wDoubleWordIO: Word;
    wCapabilities: Word;
    wReserved1: Word;
    wPIOTiming: Word;
    wDMATiming: Word;
    wBS: Word;
    wNumCurrentCyls: Word;
    wNumCurrentHeads: Word;
    wNumCurrentSectorsPerTrack: Word;
    ulCurrentSectorCapacity: DWORD;
    wMultSectorStuff: Word;
    ulTotalAddressableSectors: DWORD;
    wSingleWordDMA: Word;
    wMultiWordDMA: Word;
    bReserved: array[0..127] of BYTE;
  end;
  PIdSector = ^TIdSector;
  TDriverStatus = packed record
    bDriverError: Byte; //   ���������صĴ�����룬�޴��򷵻�0
    bIDEStatus: Byte; //   IDE����Ĵ��������ݣ�ֻ�е�bDriverError   Ϊ   SMART_IDE_ERROR   ʱ��Ч
    bReserved: array[0..1] of Byte;
    dwReserved: array[0..1] of DWORD;
  end;
  TSendCmdOutParams = packed record
    cBufferSize: DWORD; //   bBuffer�Ĵ�С
    DriverStatus: TDriverStatus; //   ������״̬
    bBuffer: array[0..0] of BYTE; //   ���ڱ�������������������ݵĻ�������ʵ�ʳ�����cBufferSize����
  end;
var
  hDevice: Thandle;
  cbBytesReturned: DWORD;
  SCIP: TSendCmdInParams;
  aIdOutCmd: array[0..(SizeOf(TSendCmdOutParams) + IDENTIFY_BUFFER_SIZE - 1) - 1] of Byte;
  IdOutCmd: TSendCmdOutParams absolute aIdOutCmd;
  procedure ChangeByteOrder(var Data; Size: Integer);
  var
    ptr: Pchar;
    i: Integer;
    c: Char;
  begin
    ptr := @Data;
    for I := 0 to (Size shr 1) - 1 do begin
      c := ptr^;
      ptr^ := (ptr + 1)^;
      (ptr + 1)^ := c;
      Inc(ptr, 2);
    end;
  end;
begin
  Result := ''; //   ��������򷵻ؿմ�
  Try
    if SysUtils.Win32Platform = VER_PLATFORM_WIN32_NT then begin //   Windows   NT,   Windows   2000
      hDevice := CreateFile('\\.\PhysicalDrive0', GENERIC_READ or GENERIC_WRITE,
        //   ��ʾ!   �ı����ƿ���������������������ڶ�����������   '\\.\PhysicalDrive1\'
        FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
    end
    else //   Version   Windows   95   OSR2,   Windows   98
      hDevice := CreateFile('\\.\SMARTVSD', 0, 0, nil, CREATE_NEW, 0, 0);
    if hDevice = INVALID_HANDLE_VALUE then Exit;
    try
      FillChar(SCIP, SizeOf(TSendCmdInParams) - 1, #0);
      FillChar(aIdOutCmd, SizeOf(aIdOutCmd), #0);
      cbBytesReturned := 0;
      with SCIP do {//   Set   up   data   structures   for   IDENTIFY   command.   } begin
        cBufferSize := IDENTIFY_BUFFER_SIZE;
        //bDriveNumber   :=   0;
        with irDriveRegs do begin
          bSectorCountReg := 1;
          bSectorNumberReg := 1;
          //if   Win32Platform=VER_PLATFORM_WIN32_NT   then   bDriveHeadReg   :=   $A0
          //else   bDriveHeadReg   :=   $A0   or   ((bDriveNum   and   1)   shl   4);
          bDriveHeadReg := $A0;
          bCommandReg := $EC;
        end;
      end;
      if not DeviceIoControl(hDevice, $0007C088, @SCIP, SizeOf(TSendCmdInParams) - 1,
        @aIdOutCmd, SizeOf(aIdOutCmd), cbBytesReturned, nil) then
        Exit;
    finally
      CloseHandle(hDevice);
    end;
    with PIdSector(@IdOutCmd.bBuffer)^ do begin
      ChangeByteOrder(sSerialNumber, SizeOf(sSerialNumber));
      (PChar(@sSerialNumber) + SizeOf(sSerialNumber))^ := #0;
      Result := sSerialNumber;
    end;
  Except
    Result := '';
  end;
end;

end.


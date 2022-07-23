unit SoundUtil;

interface

uses
  SysUtils, Classes, Bass, HGESounds, 
  Grobal2, HUtil32, WMFile, WIL, Share;

type
  TBGMState = (bgmPlay, bgmStop, bgmPause);

var
  CurVolume: integer;
  MusicStream: TMemoryStream;
  MusicHS: HSTREAM;

procedure LoadSoundList(flname: string);
procedure LoadBGMusicList(flname: string);
procedure InitializeSound();
procedure PlaySound(idx: integer);
procedure PlaySoundEx(wavname: string); overload;
procedure PlaySoundEx(idx: integer); overload;
procedure PlayBGM(wavname: string); overload;
procedure PlayBGM(idx: integer); overload;
procedure ChangeBGMState(BGMState: TBGMState);
procedure ClearBGM();
procedure ClearBGMEx();
//procedure PlayMp3(wavname: string; boFlag: Boolean; boBGSound: Boolean = False);
procedure SilenceSound;
procedure ItemClickSound(std: TStdItem);
procedure ItemUseSound(stdmode: TStdMode);
procedure PlayMapMusic(boFlag: Boolean);

type
  SoundInfo = record
    Idx: integer;
    Name: string;
  end;

const
  //bmg_intro = 'wav\log-in-long2.wav';
  //bmg_select = 'wav\sellect-loop2.wav';
  //bmg_field = 'wav\Field2.wav';
  //bmg_gameover = 'wav\game over2.wav';
  bmg_Login = 50;
  bmg_SelChr = 50;
  bmg_enter = 53;
  bmg_LoginDoor = 50;
  bmg_Alive = 60;
  bmg_Camera = 61;
  bmg_Repair = 62;
  bmg_NewEMail = 63;
  bmg_intro = 'wav\Log-in-long2.wav';
  bmg_select = 'wav\sellect-loop2.wav';
  bmg_field = 'wav\Field2.wav';
  bmg_gameover = 'wav\game over2.wav';
  bmg_HeroLogin = 'wav\HeroLogin.wav';
  bmg_HeroLogout = 'wav\HeroLogout.wav';
  bmg_newysound = 'wav\newysound-mix.wav';
  bmg_Openbox = 'wav\Openbox.wav';
  bmg_SelectBoxFlash = 'wav\SelectBoxFlash.wav';
  bmg_Field2 = 'wav\Field2.wav';
  bmg_splitshadow = 'wav\splitshadow.wav'; //分身
  bmg_longswordhit = 'wav\longsword-hit.wav'; //开天斩
  bmg_heroshield = 'wav\hero-shield.wav'; //护体神盾
  bmg_powerup = 'wav\powerup.wav'; //人物升级
  bmg_LONGFIREHITMan = 'wav\M56-0.wav';
  bmg_LONGFIREHITwoMan = 'wav\M56-3.wav';
  bmg_SKILL_74_0 = 'wav\M58-0.wav';
  bmg_SKILL_74_3 = 'wav\M58-3.wav';
  bmg_SKILL_48_0 = 'wav\M57-0.wav';
  bmg_warpower_up = 'wav\warpower-up.wav';
  bmg_ItemLevel = 54;
  bmg_ItemLevel_OK = 55;
  bmg_ItemLevel_Fail = 'wav\M100-2.wav';
  bmg_cboZs1_start_m = 'wav\cboZs1_start_m.wav';
  bmg_cboZs1_start_w = 'wav\cboZs1_start_w.wav';
  bmg_cboZs2_start = 'wav\cboZs2_start.wav';
  bmg_cboZs3_start_m = 'wav\cboZs3_start_m.wav';
  bmg_cboZs3_start_w = 'wav\cboZs3_start_w.wav';
  bmg_cboZs4_start = 'wav\cboZs4_start.wav';
  bmp_warpower_up = 'wav\warpower-up.wav';

  s_walk_ground_l = 1;
  s_walk_ground_r = 2;
  s_run_ground_l = 3;
  s_run_ground_r = 4;
  s_walk_stone_l = 5;
  s_walk_stone_r = 6;
  s_run_stone_l = 7;
  s_run_stone_r = 8;
  s_walk_lawn_l = 9;
  s_walk_lawn_r = 10;
  s_run_lawn_l = 11;
  s_run_lawn_r = 12;
  s_walk_rough_l = 13;
  s_walk_rough_r = 14;
  s_run_rough_l = 15;
  s_run_rough_r = 16;
  s_walk_wood_l = 17;
  s_walk_wood_r = 18;
  s_run_wood_l = 19;
  s_run_wood_r = 20;
  s_walk_cave_l = 21;
  s_walk_cave_r = 22;
  s_run_cave_l = 23;
  s_run_cave_r = 24;
  s_walk_room_l = 25;
  s_walk_room_r = 26;
  s_run_room_l = 27;
  s_run_room_r = 28;
  s_walk_water_l = 29;
  s_walk_water_r = 30;
  s_run_water_l = 31;
  s_run_water_r = 32;
  s_horsewalk = 10000056;
  //s_horserun = 10000004;


  s_hit_short = 50;
  s_hit_wooden = 51;
  s_hit_sword = 52;
  s_hit_do = 53;
  s_hit_axe = 54;
  s_hit_club = 55;
  s_hit_long = 56;
  s_hit_fist = 57;

  s_struck_short = 60;
  s_struck_wooden = 61;
  s_struck_sword = 62;
  s_struck_do = 63;
  s_struck_axe = 64;
  s_struck_club = 65;

  s_struck_body_sword = 70;
  s_struck_body_axe = 71;
  s_struck_body_longstick = 72;
  s_struck_body_fist = 73;

  s_struck_armor_sword = 80;
  s_struck_armor_axe = 81;
  s_struck_armor_longstick = 82;
  s_struck_armor_fist = 83;

  //s_powerup_man         = 80;
  //s_powerup_woman       = 81;
  //s_die_man             = 82;
  //s_die_woman           = 83;
  //s_struck_man          = 84;
  //s_struck_woman        = 85;
  //s_firehit             = 86;

  //s_struck_magic        = 90;
  s_strike_stone = 91;
  s_drop_stonepiece = 92;

  s_rock_door_open = 100;
  s_intro_theme = 102;
  s_meltstone = 101;
  s_main_theme = 102;
  s_norm_button_click = 103;
  s_rock_button_click = 104;
  s_glass_button_click = 105;
  s_money = 106;
  s_eat_drug = 107;
  s_click_drug = 108;
  s_spacemove_out = 109;
  s_spacemove_in = 110;

  s_click_weapon = 111;
  s_click_armor = 112;
  s_click_ring = 113;
  s_click_armring = 114;
  s_click_necklace = 115;
  s_click_helmet = 116;
  s_click_grobes = 117;
  s_itmclick = 118;

  s_yedo_man = 130;
  s_yedo_woman = 131;
  s_longhit = 132;
  s_widehit = 133;
  s_rush_l = 134;
  s_rush_r = 135;
  s_firehit_ready = 136;
  s_firehit = 137;

  s_man_struck = 138;
  s_wom_struck = 139;
  s_man_die = 144;
  s_wom_die = 145;

implementation

uses
  ClMain, MShare, GameSetup;

var
  OldBGName: string = '';
  OldBGIndex: Integer = -1;

procedure LoadSoundList(flname: string);
var
  i, k, idx, n: integer;
  strlist: TStringList;
  str, data: string;
begin
  if FileExists(flname) then begin
    strlist := TStringList.Create;
    strlist.LoadFromFile(flname);
    idx := 0;
    for i := 0 to strlist.Count - 1 do begin
      str := strlist[i];
      if str <> '' then begin
        if str[1] = ';' then
          continue;
        str := Trim(GetValidStr3(str, data, [':', ' ', #9]));
        n := StrToIntDef(data, 0);
        if n > idx then begin
          for k := 0 to n - g_SoundList.Count - 1 do
            g_SoundList.Add('');
          g_SoundList.Add(str);
          idx := n;
        end;
      end;
    end;
    strlist.Free;

  end;
end;

procedure LoadBGMusicList(flname: string);
var
  strlist: TStringList;
  str, sIdxName, sFileName: string;
  i, Idx, n, k, nid: Integer;
  MemoryStream: TMemoryStream;
begin
  BGMusicList.Clear;
  MemoryStream := g_WMusicImages.GetDataStream(0, dtData);
  if MemoryStream <> nil then begin
    strlist := TStringList.Create;
    strlist.LoadFromStream(MemoryStream);
    Idx := 0;
    for i := 0 to strlist.Count - 1 do begin
      str := strlist[i];
      if (str = '') or (str[1] = ';') then
        continue;
      str := GetValidStr3(str, sIdxName, [':', ' ', #9]);
      str := GetValidStr3(str, sFileName, [':', ' ', #9]);
      n := StrToIntDef(sIdxName, 0);
      nid := StrToIntDef(Trim(sFileName), 0);
      if n > idx then begin
        for k := 0 to n - BGMusicList.Count - 1 do
          BGMusicList.Add('');
        BGMusicList.AddObject('', TObject(nid));
        idx := n;
      end;
    end;
    strlist.Free;
    MemoryStream.Free;
  end;
end;

procedure InitializeSound();
var
  i: Integer;
begin
  while g_SoundList.Count < 12000 do
    g_SoundList.Add('');
  //if g_SoundList.Count >= 10582 then begin
    g_SoundList[10340] := 'wav\M28-1.wav';
    g_SoundList[10342] := 'wav\M28-3.wav';

    g_SoundList[10380] := 'wav\M6-1.wav';
    g_SoundList[10382] := 'wav\M19-3.wav';

    g_SoundList[10390] := 'wav\M1-1.wav';
    g_SoundList[10391] := 'wav\M1-2.wav';
    g_SoundList[10392] := 'wav\M1-3.wav';

    g_SoundList[10440] := 'wav\M39-0.wav';
    g_SoundList[10441] := 'wav\M39-1.wav';
    g_SoundList[10442] := 'wav\M39-2.wav';
    g_SoundList[10443] := 'wav\M39-3.wav';

    g_SoundList[10551] := '';
    g_SoundList[10552] := '';

    g_SoundList[10570] := 'wav\M58-0.wav';
    g_SoundList[10571] := '';
    g_SoundList[10572] := 'wav\M58-3.wav';
    g_SoundList[10580] := g_SoundList[10310];
    g_SoundList[10581] := g_SoundList[10311];
    g_SoundList[10582] := g_SoundList[10312];
  //end;
  //if (g_SoundList.Count >= 10592) then begin
    g_SoundList[10590] := 'wav\M58-0.wav';
    g_SoundList[10591] := '';
    g_SoundList[10592] := 'wav\M39-3.wav';
  //end;
  //if (g_SoundList.Count >= 10602) then begin
    g_SoundList.Objects[10600] := TObject(100);
    g_SoundList[10601] := '';
    g_SoundList.Objects[10602] := TObject(102);
  //end;
  //if (g_SoundList.Count >= 10612) then begin
    g_SoundList[10360] := 'wav\M1-1.wav';
    g_SoundList[10361] := 'wav\M39-1.wav';
    g_SoundList[10362] := 'wav\M39-3.wav';

    g_SoundList[10420] := 'wav\M42-2.wav';
    g_SoundList[10421] := '';
    g_SoundList[10422] := '';

    g_SoundList[10520] := 'wav\M49-0.wav';
    g_SoundList[10521] := 'wav\M49-1.wav';
    g_SoundList[10522] := 'wav\M49-2.wav';

    g_SoundList[10610] := 'wav\M42-0.wav';
    g_SoundList[10611] := '';
    g_SoundList[10612] := 'wav\M42-2.wav';
  //end;
  //if (g_SoundList.Count >= 10620) then begin
    g_SoundList[10620] := 'wav\M41-0.wav';
    g_SoundList[10621] := '';
    g_SoundList[10622] := '';

    g_SoundList[10630] := 'wav\M13-3.wav';
    g_SoundList[10631] := '';
    g_SoundList[10632] := '';

    g_SoundList[10660] := g_SoundList[10570];
    g_SoundList[10661] := g_SoundList[10571];
    g_SoundList[10662] := g_SoundList[10572];

    g_SoundList[10670] := g_SoundList[10130];
    g_SoundList[10671] := g_SoundList[10131];
    g_SoundList[10672] := g_SoundList[10132];

    g_SoundList[10700] := 'wav\M46-1.wav';
    g_SoundList[10702] := 'wav\M52-2.wav';

    g_SoundList[10710] := 'wav\旋风.wav';
    g_SoundList[10712] := 'wav\xsws_pbec.wav';

    g_SoundList[10720] := 'wav\M49-2.wav';
    g_SoundList[10722] := 'wav\M28-3.wav';

    g_SoundList[11140] := 'wav\cboFs1_start.wav';
    g_SoundList[11142] := 'wav\cboFs1_target.wav';
    g_SoundList[11150] := 'wav\cboFs2_start.wav';
    g_SoundList[11152] := 'wav\cboFs2_target.wav';
    g_SoundList[11160] := 'wav\cboFs3_start.wav';
    g_SoundList[11162] := 'wav\cboFs3_target.wav';
    g_SoundList[11170] := 'wav\cboFs4_start.wav';
    g_SoundList[11171] := '';
    g_SoundList[11172] := '';

    g_SoundList[11180] := 'wav\cboDs1_start.wav';
    g_SoundList[11182] := 'wav\cboDs1_target.wav';
    g_SoundList[11190] := 'wav\cboDs2_start.wav';
    g_SoundList[11192] := 'wav\cboDs2_target.wav';
    g_SoundList[11200] := 'wav\cboDs3_start.wav';
    g_SoundList[11202] := 'wav\cboDs3_target.wav';
    g_SoundList[11210] := 'wav\cboDs4_start.wav';
    g_SoundList[11212] := 'wav\cboDs4_target.wav';

    g_SoundList[11230] := 'wav\M56-0.wav';
    g_SoundList[11231] := 'wav\M56-3.wav';
    g_SoundList[11240] := 'wav\xsws_tsgj.wav';
    g_SoundList[11242] := 'wav\xsws_pbec.wav';
    g_SoundList.Objects[11232] := TObject(107);

    for I := 0 to 15 do begin
      g_SoundList[2900 + I] := g_SoundList[1900 + I];
      g_SoundList[2920 + I] := g_SoundList[1900 + I];
      g_SoundList[2940 + I] := g_SoundList[1900 + I];
    end;
    g_SoundList[9224] := 'wav\9210-4.wav';
    g_SoundList[9234] := 'wav\9210-4.wav';
    for I := 0 to 9 do begin
      g_SoundList[9240 + I] := g_SoundList[9210 + I];
      g_SoundList[9250 + I] := g_SoundList[9220 + I];
      g_SoundList[9260 + I] := g_SoundList[9230 + I];
    end;
    for I := 5200 to 7199 do begin
      g_SoundList.Objects[I] := TObject(I);
    end;
end;


procedure PlaySound(idx: integer);
var
  MemoryStream: TMemoryStream;
begin
  //10000033  BGMusicList
  if not g_boCanSound then exit;
  
  if (g_Sound <> nil) and g_boSound and (g_btSoundVolume > 0) then begin
    if idx >= 10000000 then begin
      dec(idx, 10000000);
      if (idx > 0) and (idx < BGMusicList.Count) and (g_WMusicImages.boInitialize) then begin
        if BGMusicList.Objects[idx] <> nil then begin
          MemoryStream := g_WMusicImages.GetDataStream(Integer(BGMusicList.Objects[idx]), dtWav);
          if MemoryStream <> nil then begin
            Try
              try
                MemoryStream.Position := 0;
                g_Sound.EffectStream(MemoryStream, FALSE, FALSE);
              except
              end;
            Finally
              MemoryStream.Free;
            End;
          end;
        end;
      end;
    end else begin
      if (idx >= 0) and (idx < g_SoundList.Count) then begin
        if g_SoundList[idx] <> '' then begin
          if FileExists(g_SoundList[idx]) then
          try
            g_Sound.EffectFile(g_SoundList[idx], FALSE, FALSE);
          except
          end;
        end else
        if g_SoundList.Objects[idx] <> nil then begin
          PlaySound(10000000 + Integer(g_SoundList.Objects[idx]));
        end;
      end;
    end;
  end;
end;

procedure PlaySoundEx(wavname: string);
begin
  if not g_boCanSound then exit;
  if (g_Sound <> nil) and g_boSound and (g_btSoundVolume > 0) then begin
    if wavname <> '' then
      if FileExists(wavname) then begin
        try
          g_Sound.EffectFile(wavname, False, FALSE);
        except
        end;
      end;
  end;
end;

procedure PlaySoundEx(idx: integer);
var
  MemoryStream: TMemoryStream;
begin
  if not g_boCanSound then exit;
  if (g_Sound <> nil) and g_boSound and (g_btSoundVolume > 0) and g_WMusicImages.boInitialize then begin
    MemoryStream := g_WMusicImages.GetDataStream(idx, dtWav);
    if MemoryStream <> nil then begin
      Try
        try
          MemoryStream.Position := 0;
          g_Sound.EffectStream(MemoryStream, False, FALSE);
        except
        end;
      Finally
        MemoryStream.Free;
      End;
    end;
  end;
end;

procedure PlayMapMusic(boFlag: Boolean);
begin
  ClearBGM;
  if (g_nAreaStateValue = OT_FREEPKAREA) and (BGMusicList.Count > 6) then begin
    PlayBGM(Integer(BGMusicList.Objects[6]));
  end else
  if (g_nMapMusic >= 0) and (g_nMapMusic < BGMusicList.Count) then begin
    PlayBGM(Integer(BGMusicList.Objects[g_nMapMusic]));
  end;
end;

procedure PlayBGM(wavname: string);
begin
  if (not g_boBGSound) or (g_btMP3Volume <= 0) then exit;
  if (OldBGName = wavname) and (MusicHS > 0) then begin
    if BASS_ChannelIsActive(MusicHS) <> BASS_ACTIVE_PLAYING then
      BASS_ChannelPlay(MusicHS, False);
      BASS_ChannelSetAttribute(MusicHS, BASS_ATTRIB_VOL, g_btMP3Volume / 100);
    exit;
  end;
  ClearBGMEx;
  Try
    MusicHS := BASS_StreamCreateFile(False, PAnsiChar(wavname), 0, 0, BASS_SAMPLE_LOOP);
    if MusicHS < BASS_ERROR_ENDED then begin
      BASS_StreamFree(MusicHS);
      MusicHS := 0;
      exit;
    end;
    OldBGName := wavname;
    BASS_ChannelPlay(MusicHS, True);
    BASS_ChannelSetAttribute(MusicHS, BASS_ATTRIB_VOL, g_btMP3Volume / 100);
  Except
  End;
end;

procedure PlayBGM(idx: integer);
begin
  if (not g_boBGSound) or (not g_WMusicImages.boInitialize) or (g_btMP3Volume <= 0) then exit;
  if (OldBGIndex = idx) and (MusicHS > 0) then begin
    if BASS_ChannelIsActive(MusicHS) <> BASS_ACTIVE_PLAYING then
      BASS_ChannelPlay(MusicHS, False);
      BASS_ChannelSetAttribute(MusicHS, BASS_ATTRIB_VOL, g_btMP3Volume / 100);
    exit;
  end;
  ClearBGMEx;
  Try
    MusicStream := g_WMusicImages.GetDataStream(idx, dtMusic);
    if MusicStream <> nil then begin
      MusicHS := BASS_StreamCreateFile(True, MusicStream.Memory, 0, MusicStream.Size, BASS_SAMPLE_LOOP);
      if MusicHS < BASS_ERROR_ENDED then begin
        BASS_StreamFree(MusicHS);
        MusicHS := 0;
        FreeAndNil(MusicStream);
        exit;
      end;
      OldBGIndex := idx;
      BASS_ChannelPlay(MusicHS, True);
      BASS_ChannelSetAttribute(MusicHS, BASS_ATTRIB_VOL, g_btMP3Volume / 100);
    end;
  Except
  End;
end;

procedure ChangeBGMState(BGMState: TBGMState);
begin
  if MusicHS >= BASS_ERROR_ENDED then begin
    case BGMState of
      bgmPlay: BASS_ChannelPlay(MusicHS, False);
      bgmStop: BASS_ChannelStop(MusicHS);
      bgmPause: BASS_ChannelPause(MusicHS);
    end;
    BASS_ChannelSetAttribute(MusicHS, BASS_ATTRIB_VOL, g_btMP3Volume / 100);
  end;
end;

procedure SilenceSound;
begin
  if g_Sound <> nil then begin
    g_Sound.Clear;
  end;
end;

procedure ClearBGM();
begin
  ChangeBGMState(bgmStop);
end;

procedure ClearBGMEx();
begin
  OldBGName := '';
  OldBGIndex := -1;
  BASS_StreamFree(MusicHS);
  MusicHS := 0;
  if MusicStream <> nil then MusicStream.Free;
  MusicStream := nil;
end;

procedure ItemClickSound(std: TStdItem);
begin
  case std.StdMode of
    tm_Drug: PlaySound(s_click_drug);
    //ts_Open: PlaySound(s_click_drug);
    tm_Weapon, tm_Nail: PlaySound(s_click_weapon);
    tm_Dress, tm_Saddle: PlaySound(s_click_armor);
    tm_Ring: PlaySound(s_click_ring);
    tm_ArmRing: begin
        if (pos('手镯', std.Name) > 0) or (pos('手套', std.Name) > 0) then
          PlaySound(s_click_grobes)
        else
          PlaySound(s_click_armring);
      end;
    tm_Necklace, tm_Bell: PlaySound(s_click_necklace);
    tm_Helmet: PlaySound(s_click_helmet);
  else
    PlaySound(s_itmclick);
  end;
end;

procedure ItemUseSound(stdmode: TStdMode);
begin
  case stdmode of
    tm_Drug: PlaySound(s_click_drug);
    tm_Restrict: PlaySound(s_eat_drug);
  else
    ;
  end;
end;

end.


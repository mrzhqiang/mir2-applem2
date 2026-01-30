program M2Server;

uses
  Forms,
  Windows,
  Graphics,
  svMain in 'svMain.pas' {FrmMain},
  LocalDB in 'LocalDB.pas' {FrmDB},
  IdSrvClient in 'IdSrvClient.pas' {FrmIDSoc},
  FSrvValue in 'FSrvValue.pas' {FrmServerValue},
  SDK in 'SDK.pas',
  UsrEngn in 'UsrEngn.pas',
  ObjNpc in 'ObjNpc.pas',
  ObjMon2 in 'ObjMon2.pas',
  ObjMon in 'ObjMon.pas',
  ObjGuard in 'ObjGuard.pas',
  Envir in 'Envir.pas',
  ObjBase in 'ObjBase.pas',
  ObjAxeMon in 'ObjAxeMon.pas',
  Mission in 'Mission.pas',
  Magic in 'Magic.pas',
  M2Share in 'M2Share.pas',
  ItmUnit in 'ItmUnit.pas',
  FrnEngn in 'FrnEngn.pas',
  Event in 'Event.pas',
  Castle in 'Castle.pas',
  RunDB in 'RunDB.pas',
  RunSock in 'RunSock.pas',
  HUtil32 in '..\Common\HUtil32.pas',
  Mudutil in '..\Common\Mudutil.pas',
  GeneralConfig in 'GeneralConfig.pas' {frmGeneralConfig},
  GameConfig in 'GameConfig.pas' {frmGameConfig},
  FunctionConfig in 'FunctionConfig.pas' {frmFunctionConfig},
  ObjRobot in 'ObjRobot.pas',
  BnkEngn in 'BnkEngn.pas',
  ViewSession in 'ViewSession.pas' {frmViewSession},
  ViewOnlineHuman in 'ViewOnlineHuman.pas' {frmViewOnlineHuman},
  ViewLevel in 'ViewLevel.pas' {frmViewLevel},
  ViewList in 'ViewList.pas' {frmViewList},
  OnlineMsg in 'OnlineMsg.pas' {frmOnlineMsg},
  HumanInfo in 'HumanInfo.pas' {frmHumanInfo},
  ViewKernelInfo in 'ViewKernelInfo.pas' {frmViewKernelInfo},
  ConfigMerchant in 'ConfigMerchant.pas' {frmConfigMerchant},
  ItemSet in 'ItemSet.pas' {frmItemSet},
  ConfigMonGen in 'ConfigMonGen.pas' {frmConfigMonGen},
  GameCommand in 'GameCommand.pas' {frmGameCmd},
  MonsterConfig in 'MonsterConfig.pas' {frmMonsterConfig},
  UnitManage in 'UnitManage.pas',
  JClasses in 'JClasses.pas',
  ActionSpeedConfig in 'ActionSpeedConfig.pas' {frmActionSpeed},
  CastleManage in 'CastleManage.pas' {frmCastleManage},
  Common in '..\Common\Common.pas',
  EngineRegister in 'EngineRegister.pas' {FrmRegister},
  AttackSabukWallConfig in 'AttackSabukWallConfig.pas' {FrmAttackSabukWall},
  Grobal2 in '..\Common\Grobal2.pas',
  DESTR in '..\Common\DESTR.pas',
  ObjMon3 in 'ObjMon3.pas',
  ObjPlay in 'ObjPlay.pas',
  ObjPlayCmd in 'ObjPlayCmd.pas',
  MD5Unit in '..\Common\MD5Unit.pas',
  Guild in 'Guild.pas',
  FrmShop in 'FrmShop.pas' {FormShop},
  FrnEmail in 'FrnEmail.pas',
  OjbKindMon in 'OjbKindMon.pas',
  CheckDLL in '..\Common\CheckDLL.pas',
  MyCommon in '..\MyCommon\MyCommon.pas',
  DLLLoader in '..\Common\DLLLoader.pas',
  CheckDllFile in '..\Common\CheckDllFile.pas',
  CoralWry in 'CoralWry.pas',
  EncryptFile in '..\Common\EncryptFile.pas',
  EDcodeEx in '..\Common\EDcodeEx.pas',
  RegDllFile in 'RegDllFile.pas',
  DES in '..\Common\DES.pas',
  OnlineEmail in 'OnlineEmail.pas' {frmOnlineEmail},
  ViewCompoundInfo in 'ViewCompoundInfo.pas' {FrmViewCompoundInfo},
  EditCompoundInfo in 'EditCompoundInfo.pas' {EditCompoundInfoForm},
  RefineSystem in 'RefineSystem.pas',
  CrystalSystem in 'CrystalSystem.pas',
  SoulSystem in 'SoulSystem.pas',
  MonsterAffixSystem in 'MonsterAffixSystem.pas';

{$R *.res}

{$IFDEF PLUGOPEN}
exports
  MainOutMessageAPI name 'MainOutMessageAPI',
  AddGameDataLogAPI name 'AddGameDataLogAPI',
  Config_sEnvirDir name 'Config_sEnvirDir',
  Config_sPlugDir name 'Config_sPlugDir',
  Config_sUserDataDir name 'Config_sUserDataDir',
  API_GetMem name 'API_GetMem',
  API_GetMemFreeMem name 'API_GetMemFreeMem',
  API_GetMemReallocMem name 'API_GetMemReallocMem',
  API_GetGrobalVer name 'API_GetGrobalVer',
  API_UnModule name 'API_UnModule',
  API_SetHookUserLoadAndSave name 'API_SetHookUserLoadAndSave',
  API_GetHookUserLoadAndSave name 'API_GetHookUserLoadAndSave',

  //GetGameGoldName name 'GetGameGoldName',
  //GetGameDiamondName name 'GetGameDiamondName',
  GetGameLogGold name 'GetGameLogGold',
  GetGameLogGameGold name 'GetGameLogGameGold',
  GetGameLogGamePoint name 'GetGameLogGamePoint',
  GetGameLogGameDiamond name 'GetGameLogGameDiamond',
  
  EDcode_Decode6BitBuf name 'EDcode_Decode6BitBuf',
  EDcode_Encode6BitBuf name 'EDcode_Encode6BitBuf',

  IDSrv_SendGameGoldChangeMsg name 'IDSrv_SendGameGoldChangeMsg',
  IDSrv_GameGoldChange name 'IDSrv_GameGoldChange',
  API_IntegerChange name 'API_IntegerChange',

  TList_Create name 'TList_Create',
  TList_Free name 'TList_Free',
  TList_Count name 'TList_Count',
  TList_Add name 'TList_Add',
  TList_Insert name 'TList_Insert',
  TList_Items name 'TList_Items',
  TList_Delete name 'TList_Delete',
  TList_Clear name 'TList_Clear',
  TList_Exchange name 'TList_Exchange',

  TStringList_Create name 'TStringList_Create',
  TStringList_Free name 'TStringList_Free',
  TStringList_Count name 'TStringList_Count',
  TStringList_Add name 'TStringList_Add',
  TStringList_AddObject name 'TStringList_AddObject',
  TStringList_Insert name 'TStringList_Insert',
  TStringList_Strings name 'TStringList_Strings',
  TStringList_Objects name 'TStringList_Objects',
  TStringList_SetObjects name 'TStringList_SetObjects',
  TStringList_Delete name 'TStringList_Delete',
  TStringList_Clear name 'TStringList_Clear',
  TStringList_Exchange name 'TStringList_Exchange',
  TStringList_LoadFormFile name 'TStringList_LoadFormFile',
  TStringList_SaveToFile name 'TStringList_SaveToFile',

  TBaseObject_Create name 'TBaseObject_Create',
  TBaseObject_Free name 'TBaseObject_Free',
  TBaseObject_sMapFileName name 'TBaseObject_sMapFileName',
  TBaseObject_sMapName name 'TBaseObject_sMapName',
  TBaseObject_sMapNameA name 'TBaseObject_sMapNameA',
  TBaseObject_sCharName name 'TBaseObject_sCharName',
  TBaseObject_sCharNameA name 'TBaseObject_sCharNameA',
  TBaseObject_nCurrX name 'TBaseObject_nCurrX',
  TBaseObject_nCurrY name 'TBaseObject_nCurrY',
  TBaseObject_btDirection name 'TBaseObject_btDirection',
  TBaseObject_btGender name 'TBaseObject_btGender',
  TBaseObject_btHair name 'TBaseObject_btHair',
  TBaseObject_btJob name 'TBaseObject_btJob',
  TBaseObject_nGold name 'TBaseObject_nGold',
  TBaseObject_Ability name 'TBaseObject_Ability',

  TBaseObject_WAbility name 'TBaseObject_WAbility',
  TBaseObject_nCharStatus name 'TBaseObject_nCharStatus',
  TBaseObject_sHomeMap name 'TBaseObject_sHomeMap',
  TBaseObject_nHomeX name 'TBaseObject_nHomeX',
  TBaseObject_nHomeY name 'TBaseObject_nHomeY',

  TBaseObject_boOnHorse name 'TBaseObject_boOnHorse',
  TBaseObject_btHorseType name 'TBaseObject_btHorseType',
  TBaseObject_btDressEffType name 'TBaseObject_btDressEffType',
  TBaseObject_wPkPoint name 'TBaseObject_wPkPoint',
  TBaseObject_boAllowGroup name 'TBaseObject_boAllowGroup',
  TBaseObject_boAllowGuild name 'TBaseObject_boAllowGuild',
  TBaseObject_nFightZoneDieCount name 'TBaseObject_nFightZoneDieCount',
  //TBaseObject_nBonusPoint name 'TBaseObject_nBonusPoint',
  //TBaseObject_nHungerStatus name 'TBaseObject_nHungerStatus',
  TBaseObject_boAllowGuildReCall name 'TBaseObject_boAllowGuildReCall',
  TBaseObject_duBodyLuck name 'TBaseObject_duBodyLuck',
  TBaseObject_nBodyLuckLevel name 'TBaseObject_nBodyLuckLevel',
  TBaseObject_wGroupRcallTime name 'TBaseObject_wGroupRcallTime',
  TBaseObject_boAllowGroupReCall name 'TBaseObject_boAllowGroupReCall',
  TBaseObject_nCharStatusEx name 'TBaseObject_nCharStatusEx',
  TBaseObject_dwFightExp name 'TBaseObject_dwFightExp',
  TBaseObject_nViewRange name 'TBaseObject_nViewRange',
  TBaseObject_wAppr name 'TBaseObject_wAppr',
  TBaseObject_btRaceServer name 'TBaseObject_btRaceServer',
  TBaseObject_btRaceImg name 'TBaseObject_btRaceImg',
  TBaseObject_btHitPoint name 'TBaseObject_btHitPoint',
  TBaseObject_nHitPlus name 'TBaseObject_nHitPlus',
  TBaseObject_nHitDouble name 'TBaseObject_nHitDouble',
  TBaseObject_boRecallSuite name 'TBaseObject_boRecallSuite',
  TBaseObject_nHealthRecover name 'TBaseObject_nHealthRecover',
  TBaseObject_nSpellRecover name 'TBaseObject_nSpellRecover',
  TBaseObject_btAntiPoison name 'TBaseObject_btAntiPoison',
  TBaseObject_nPoisonRecover name 'TBaseObject_nPoisonRecover',
  TBaseObject_nAntiMagic name 'TBaseObject_nAntiMagic',
  TBaseObject_nLuck name 'TBaseObject_nLuck',
  TBaseObject_nPerHealth name 'TBaseObject_nPerHealth',
  TBaseObject_nPerHealing name 'TBaseObject_nPerHealing',
  TBaseObject_nPerSpell name 'TBaseObject_nPerSpell',
  TBaseObject_btGreenPoisoningPoint name 'TBaseObject_btGreenPoisoningPoint',
  TBaseObject_nGoldMax name 'TBaseObject_nGoldMax',
  TBaseObject_btSpeedPoint name 'TBaseObject_btSpeedPoint',
  TBaseObject_btPermission name 'TBaseObject_btPermission',
  TBaseObject_nHitSpeed name 'TBaseObject_nHitSpeed',
  TBaseObject_TargetCret name 'TBaseObject_TargetCret',
  TBaseObject_LastHiter name 'TBaseObject_LastHiter',
  TBaseObject_ExpHiter name 'TBaseObject_ExpHitter',
  TBaseObject_btLifeAttrib name 'TBaseObject_btLifeAttrib',
  TBaseObject_GroupOwner name 'TBaseObject_GroupOwner',
  TBaseObject_GroupMembersList name 'TBaseObject_GroupMembersList',
  TBaseObject_boHearWhisper name 'TBaseObject_boHearWhisper',
  TBaseObject_boBanShout name 'TBaseObject_boBanShout',
  TBaseObject_boBanGuildChat name 'TBaseObject_boBanGuildChat',
  TBaseObject_boAllowDeal name 'TBaseObject_boAllowDeal',
  TBaseObject_Master name 'TBaseObject_Master',
  TBaseObject_btAttatckMode name 'TBaseObject_btAttatckMode',
  TBaseObject_nNameColor name 'TBaseObject_nNameColor',
  //TBaseObject_nLight name 'TBaseObject_nLight',
  TBaseObject_ItemList name 'TBaseObject_ItemList',
  TBaseObject_MyGuild name 'TBaseObject_MyGuild',
  TBaseObject_UseItems name 'TBaseObject_UseItems',
  TBaseObject_btMonsterWeapon name 'TBaseObject_btMonsterWeapon',
  TBaseObject_PEnvir name 'TBaseObject_PEnvir',
  TBaseObject_boGhost name 'TBaseObject_boGhost',
  TBaseObject_boDeath name 'TBaseObject_boDeath',

  TBaseObject_DeleteBagItem name 'TBaseObject_DeleteBagItem',

  TBaseObject_SendMsg name 'TBaseObject_SendMsg',
  TBaseObject_SendRefMsg name 'TBaseObject_SendRefMsg',
  TBaseObject_SendDefMsg name 'TBaseObject_SendDefMsg',
  TBaseObject_SendDefSocket name 'TBaseObject_SendDefSocket',

  TBaseObject_SysMsg name 'TBaseObject_SysMsg',
  TBaseObject_SysHintMsg name 'TBaseObject_SysHintMsg',
  TBaseObject_GetFrontPosition name 'TBaseObject_GetFrontPosition',
  TBaseObject_GetRecallXY name 'TBaseObject_GetRecallXY',
  TBaseObject_SpaceMove name 'TBaseObject_SpaceMove',
  TBaseObject_FeatureChanged name 'TBaseObject_FeatureChanged',
  TBaseObject_StatusChanged name 'TBaseObject_StatusChanged',
  TBaseObject_GetFeatureToLong name 'TBaseObject_GetFeatureToLong',
  TBaseObject_GetFeature name 'TBaseObject_GetFeature',
  TBaseObject_GetCharColor name 'TBaseObject_GetCharColor',
  TBaseObject_GetNamecolor name 'TBaseObject_GetNamecolor',
  TBaseObject_GoldChanged name 'TBaseObject_GoldChanged',
  TBaseObject_GameGoldChanged name 'TBaseObject_GameGoldChanged',
  TBaseObject_MagCanHitTarget name 'TBaseObject_MagCanHitTarget',

  TBaseObject_IsProtectTarget name 'TBaseObject_IsProtectTarget',
  TBaseObject_IsAttackTarget name 'TBaseObject_IsAttackTarget',
  TBaseObject_IsProperTarget name 'TBaseObject_IsProperTarget',
  TBaseObject_IsProperFriend name 'TBaseObject_IsProperFriend',
  TBaseObject_TrainSkillPoint name 'TBaseObject_TrainSkillPoint',
  TBaseObject_GetAttackPower name 'TBaseObject_GetAttackPower',
  TBaseObject_MakeSlave name 'TBaseObject_MakeSlave',
  TBaseObject_MakeGhost name 'TBaseObject_MakeGhost',
  TBaseObject_RefNameColor name 'TBaseObject_RefNameColor',
  TBaseObject_AddItemToBag name 'TBaseObject_AddItemToBag',
  //TBaseObject_AddItemToStorage name 'TBaseObject_AddItemToStorage',
  TBaseObject_ClearBagItem name 'TBaseObject_ClearBagItem',
  //TBaseObject_ClearStorageItem name 'TBaseObject_ClearStorageItem',

  TBaseObject_SetHookGetFeature name 'TBaseObject_SetHookGetFeature',
  TBaseObject_GetHookGetFeature name 'TBaseObject_GetHookGetFeature',

  TBaseObject_SetHookEnterAnotherMap name 'TBaseObject_SetHookEnterAnotherMap',
  TBaseObject_GetHookEnterAnotherMap name 'TBaseObject_GetHookEnterAnotherMap',

  TBaseObject_SetHookObjectDie name 'TBaseObject_SetHookObjectDie',
  TBaseObject_GetHookObjectDie name 'TBaseObject_GetHookObjectDie',

  TPlayObject_nSoftVersionDate name 'TPlayObject_nSoftVersionDate',
  TPlayObject_nSoftVersionDateEx name 'TPlayObject_nSoftVersionDateEx',
  TPlayObject_GetLoginPlay name 'TPlayObject_GetLoginPlay',
  TPlayObject_dLogonTime name 'TPlayObject_dLogonTime',
  TPlayObject_dwLogonTick name 'TPlayObject_dwLogonTick',
  TPlayObject_nMemberType name 'TPlayObject_nMemberType',
  TPlayObject_nMemberLevel name 'TPlayObject_nMemberLevel',
  TPlayObject_nGameGold name 'TPlayObject_nGameGold',
  TPlayObject_nGamePoint name 'TPlayObject_nGamePoint',
  //TPlayObject_nPayMentPoint name 'TPlayObject_nPayMentPoint',
  TPlayObject_IncGold name 'TPlayObject_IncGold',
  TPlayObject_MagicList name 'TPlayObject_MagicList',



  TPlayObject_Create name 'TPlayObject_Create',
  TPlayObject_Free name 'TPlayObject_Free',
  TPlayObject_SendSocket name 'TPlayObject_SendSocket',
  TPlayObject_SendDefMessage name 'TPlayObject_SendDefMessage',
  TPlayObject_SendAddItem name 'TPlayObject_SendAddItem',
  TPlayObject_SendDelItem name 'TPlayObject_SendDelItem',
  TPlayObject_SendBagItemDuraChange name 'TPlayObject_SendBagItemDuraChange',
  TPlayObject_TargetInNearXY name 'TPlayObject_TargetInNearXY',

  TPlayObject_SetHookCreate name 'TPlayObject_SetHookCreate',
  TPlayObject_GetHookCreate name 'TPlayObject_GetHookCreate',

  TPlayObject_SetHookDestroy name 'TPlayObject_SetHookDestroy',
  TPlayObject_GetHookDestroy name 'TPlayObject_GetHookDestroy',

  TPlayObject_SetHookUserLoginStart name 'TPlayObject_SetHookUserLoginStart',
  TPlayObject_GetHookUserLoginStart name 'TPlayObject_GetHookUserLoginStart',
  TPlayObject_SetHookUserLoginEnd name 'TPlayObject_SetHookUserLoginEnd',
  TPlayObject_GetHookUserLoginEnd name 'TPlayObject_GetHookUserLoginEnd',

  TPlayObject_SetHookUserCmd name 'TPlayObject_SetHookUserCmd',
  TPlayObject_GetHookUserCmd name 'TPlayObject_GetHookUserCmd',

  TPlayObject_SetHookPlayOperateMessage name 'TPlayObject_SetHookPlayOperateMessage',
  TPlayObject_GetHookPlayOperateMessage name 'TPlayObject_GetHookPlayOperateMessage',

  TPlayObject_SetHookClientQueryBagItems name 'TPlayObject_SetHookClientQueryBagItems',
  TPlayObject_SetHookClientQueryUserState name 'TPlayObject_SetHookClientQueryUserState',
  TPlayObject_SetHookSendActionGood name 'TPlayObject_SetHookSendActionGood',
  TPlayObject_SetHookSendActionFail name 'TPlayObject_SetHookSendActionFail',

  TPlayObject_SetHookSendWalkMsg name 'TPlayObject_SetHookSendWalkMsg',
  TPlayObject_SetHookSendHorseRunMsg name 'TPlayObject_SetHookSendHorseRunMsg',
  TPlayObject_SetHookSendRunMsg name 'TPlayObject_SetHookSendRunMsg',
  TPlayObject_SetHookSendDeathMsg name 'TPlayObject_SetHookSendDeathMsg',
  TPlayObject_SetHookSendSkeletonMsg name 'TPlayObject_SetHookSendSkeletonMsg',
  TPlayObject_SetHookSendAliveMsg name 'TPlayObject_SetHookSendAliveMsg',
  TPlayObject_SetHookSendSpaceMoveMsg name 'TPlayObject_SetHookSendSpaceMoveMsg',
  TPlayObject_SetHookSendChangeFaceMsg name 'TPlayObject_SetHookSendChangeFaceMsg',
  TPlayObject_SetHookSendUseitemsMsg name 'TPlayObject_SetHookSendUseitemsMsg',
  TPlayObject_SetHookSendUserLevelUpMsg name 'TPlayObject_SetHookSendUserLevelUpMsg',
  TPlayObject_SetHookSendUserAbilieyMsg name 'TPlayObject_SetHookSendUserAbilieyMsg',
  //TPlayObject_SetHookSendUserStatusMsg name 'TPlayObject_SetHookSendUserStatusMsg',
  TPlayObject_SetHookSendUserStruckMsg name 'TPlayObject_SetHookSendUserStruckMsg',
  TPlayObject_SetHookSendUseMagicMsg name 'TPlayObject_SetHookSendUseMagicMsg',
  TPlayObject_SetHookSendSocket name 'TPlayObject_SetHookSendSocket',
  TPlayObject_SetHookSendGoodsList name 'TPlayObject_SetHookSendGoodsList',

  TPlayObject_SetHookCheckUserItems name 'TPlayObject_SetHookCheckUserItems',
  TPlayObject_GetHookCheckUserItems name 'TPlayObject_GetHookCheckUserItems',

  TPlayObject_SetHookRun name 'TPlayObject_SetHookRun',
  TPlayObject_GetHookRun name 'TPlayObject_GetHookRun',

  TPlayObject_SetHookFilterMsg name 'TPlayObject_SetHookFilterMsg',
  TPlayObject_GetHookFilterMsg name 'TPlayObject_GetHookFilterMsg',

  TPlayObject_CheckPlaySideNpc name 'TPlayObject_CheckPlaySideNpc',
  TPlayObject_DiamondChanged name 'TPlayObject_DiamondChanged',
  TPlayObject_nGameDiamond name 'TPlayObject_nGameDiamond',
  TPlayObject_dwUpLoadPhotoTime name 'TPlayObject_dwUpLoadPhotoTime',
  TPlayObject_SetPhotoName name 'TPlayObject_SetPhotoName',
  TPlayObject_FriendList name 'TPlayObject_FriendList',

  TPlayObject_SetHookPlayObjectMakeGhost name 'TPlayObject_SetHookPlayObjectMakeGhost',
  TPlayObject_GetHookPlayObjectMakeGhost name 'TPlayObject_GetHookPlayObjectMakeGhost',

  TPlayObject_AddCheckMsg name 'TPlayObject_AddCheckMsg',
  TPlayObject_GetDBIndex name 'TPlayObject_GetDBIndex',
  TPlayObject_GetLookIndex name 'TPlayObject_GetLookIndex',

  TNormNpc_sFilePath name 'TNormNpc_sFilePath',
  TNormNpc_sPath name 'TNormNpc_sPath',
  TNormNpc_GetLineVariableText name 'TNormNpc_GetLineVariableText',

  TNormNpc_SetScriptActionCmd name 'TNormNpc_SetScriptActionCmd',
  TNormNpc_GetScriptActionCmd name 'TNormNpc_GetScriptActionCmd',

  TNormNpc_SetScriptConditionCmd name 'TNormNpc_SetScriptConditionCmd',
  TNormNpc_GetScriptConditionCmd name 'TNormNpc_GetScriptConditionCmd',

  TNormNpc_SetScriptAction name 'TNormNpc_SetScriptAction',
  TNormNpc_GetScriptAction name 'TNormNpc_GetScriptAction',

  TNormNpc_SetScriptCondition name 'TNormNpc_SetScriptCondition',
  TNormNpc_GetScriptCondition name 'TNormNpc_GetScriptCondition',

  TNormNpc_GetManageNpc name 'TNormNpc_GetManageNpc',
  TNormNpc_GetFunctionNpc name 'TNormNpc_GetFunctionNpc',
  TNormNpc_GotoLable name 'TNormNpc_GotoLable',

  TMerchant_NewGoodsList name 'TMerchant_NewGoodsList',
  TMerchant_GetItemPrice name 'TMerchant_GetItemPrice',
  //TMerchant_GetUserPrice name 'TMerchant_GetUserPrice',
  TMerchant_GetUserItemPrice name 'TMerchant_GetUserPrice',

  TMerchant_boSellOff name 'TMerchant_boSellOff',

  TMapManager_FindMap name 'TMapManager_FindMap',
  TEnvirnoment_GetRangeBaseObject name 'TEnvirnoment_GetRangeBaseObject',

  TUserEngine_Create name 'TUserEngine_Create',
  TUserEngine_Free name 'TUserEngine_Free',
  TUserEngine_GetUserEngine name 'TUserEngine_GetUserEngine',

  TUserEngine_GetPlayObject name 'TUserEngine_GetPlayObject',

  TUserEngine_GetLoadPlayList name 'TUserEngine_GetLoadPlayList',
  TUserEngine_GetPlayObjectList name 'TUserEngine_GetPlayObjectList',
  TUserEngine_GetLoadPlayCount name 'TUserEngine_GetLoadPlayCount',
  TUserEngine_GetPlayObjectCount name 'TUserEngine_GetPlayObjectCount',
  TUserEngine_GetStdItemByName name 'TUserEngine_GetStdItemByName',
  TUserEngine_GetStdItemByIndex name 'TUserEngine_GetStdItemByIndex',
  TUserEngine_CopyToUserItemFromName name 'TUserEngine_CopyToUserItemFromName',

  TUserEngine_SetHookRun name 'TUserEngine_SetHookRun',
  TUserEngine_GetHookRun name 'TUserEngine_GetHookRun',
  TUserEngine_SetHookClientUserMessage name 'TUserEngine_SetHookClientUserMessage',
  TUserEngine_GetHookClientUserMessage name 'TUserEngine_GetHookClientUserMessage',

  TUserEngine_GetProcessHumanCriticalSection name 'TUserEngine_GetProcessHumanCriticalSection',

  TItemUnit_GetItemAddValue name 'TItemUnit_GetItemAddValue',
  TItemUnit_Dispose name 'TItemUnit_Dispose',

  TMagicManager_GetMagicManager name 'TMagicManager_GetMagicManager',
  TMagicManager_DoSpell name 'TMagicManager_DoSpell',
  TMagicManager_MPow name 'TMagicManager_MPow',
  TMagicManager_GetPower name 'TMagicManager_GetPower',
  TMagicManager_GetPower13 name 'TMagicManager_GetPower13',
  TMagicManager_GetRPow name 'TMagicManager_GetRPow',
  //TMagicManager_IsWarrSkill name 'TMagicManager_IsWarrSkill',

  TMagicManager_MagBigHealing name 'TMagicManager_MagBigHealing',
  TMagicManager_MagPushArround name 'TMagicManager_MagPushArround',
  TMagicManager_MagPushArroundTaos name 'TMagicManager_MagPushArroundTaos',
  TMagicManager_MagTurnUndead name 'TMagicManager_MagTurnUndead',
  TMagicManager_MagMakeHolyCurtain name 'TMagicManager_MagMakeHolyCurtain',
  TMagicManager_MagMakeGroupTransparent name 'TMagicManager_MagMakeGroupTransparent',
  TMagicManager_MagTamming name 'TMagicManager_MagTamming',
  TMagicManager_MagSaceMove name 'TMagicManager_MagSaceMove',
  TMagicManager_MagMakeFireCross name 'TMagicManager_MagMakeFireCross',
  TMagicManager_MagBigExplosion name 'TMagicManager_MagBigExplosion',
  TMagicManager_MagElecBlizzard name 'TMagicManager_MagElecBlizzard',
  TMagicManager_MabMabe name 'TMagicManager_MabMabe',
  TMagicManager_MagMakeSlave name 'TMagicManager_MagMakeSlave',
  TMagicManager_MagMakeSinSuSlave name 'TMagicManager_MagMakeSinSuSlave',
  TMagicManager_MagWindTebo name 'TMagicManager_MagWindTebo',
  TMagicManager_MagGroupLightening name 'TMagicManager_MagGroupLightening',
  TMagicManager_MagGroupAmyounsul name 'TMagicManager_MagGroupAmyounsul',
  TMagicManager_MagGroupDeDing name 'TMagicManager_MagGroupDeDing',
  TMagicManager_MagGroupMb name 'TMagicManager_MagGroupMb',
  TMagicManager_MagHbFireBall name 'TMagicManager_MagHbFireBall',
  TMagicManager_MagLightening name 'TMagicManager_MagLightening',
  TMagicManager_SetHookDoSpell name 'TMagicManager_SetHookDoSpell',
  TMagicManager_GetHookDoSpell name 'TMagicManager_GetHookDoSpell'
  ;
{$ENDIF}

procedure Start();
begin
  //g_Config.nServerFile_CRCA := CalcFileCRC(Application.ExeName);
  Application.Initialize;
  Application.HintPause := 100;
  Application.HintShortPause := 100;
  Application.HintHidePause := 5000;
  Application.Title := 'M2Server';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TfrmOnlineEmail, frmOnlineEmail);
  Application.CreateForm(TFrmViewCompoundInfo, FrmViewCompoundInfo);
  Application.CreateForm(TEditCompoundInfoForm, EditCompoundInfoForm);
  // Application.CreateForm(TFormShop, FormShop);
  asm
    jz @@Start
    jnz @@Start
    db 0EBh
    @@Start:
  end;
  //Application.CreateForm(TFrmMsgClient, FrmMsgClient);
  Application.CreateForm(TFrmIDSoc, FrmIDSoc);
  //Application.CreateForm(TFrmServerValue, FrmServerValue);
  //Application.CreateForm(TftmPlugInManage, ftmPlugInManage);
  //Application.CreateForm(TfrmGameCmd, frmGameCmd);
  //Application.CreateForm(TfrmMonsterConfig, frmMonsterConfig);
  Application.Run;
end;

asm
  jz @@Start
  jnz @@Start
  db 0E8h
@@Start:
  lea eax,Start
  call eax
  jz @@end
  jnz @@end
  db 0F4h
  db 0FFh
@@end:

end.


// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzanimtr.pas' rev: 10.00

#ifndef RzanimtrHPP
#define RzanimtrHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzanimtr
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TRzAnimatorFrameChangeEvent)(System::TObject* Sender, int Frame);

class DELPHICLASS TRzAnimator;
class PASCALIMPLEMENTATION TRzAnimator : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FAnimate;
	bool FContinuous;
	Word FDelay;
	Word FDelayUntilRepeat;
	Imglist::TImageIndex FLastImageIndex;
	Imglist::TImageIndex FImageIndex;
	Imglist::TCustomImageList* FImages;
	Imglist::TChangeLink* FImagesChangeLink;
	Graphics::TBitmap* FBitmap;
	Extctrls::TTimer* FTimer;
	bool FTransparent;
	TRzAnimatorFrameChangeEvent FOnFrameChange;
	Classes::TNotifyEvent FOnCycleComplete;
	void __fastcall TimerExpired(System::TObject* Sender);
	void __fastcall ImagesChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall DrawImage(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall FrameChange(int Frame);
	DYNAMIC void __fastcall CycleComplete(void);
	virtual void __fastcall SetAnimate(bool Value);
	virtual void __fastcall SetContinuous(bool Value);
	virtual void __fastcall SetDelay(Word Value);
	virtual void __fastcall SetImageIndex(Imglist::TImageIndex Value);
	virtual void __fastcall SetImageList(Imglist::TCustomImageList* Value);
	virtual void __fastcall SetTransparent(bool Value);
	
public:
	__fastcall virtual TRzAnimator(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzAnimator(void);
	void __fastcall StartAnimation(void);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool Animate = {read=FAnimate, write=SetAnimate, default=1};
	__property bool Continuous = {read=FContinuous, write=SetContinuous, default=1};
	__property Word Delay = {read=FDelay, write=SetDelay, default=100};
	__property Word DelayUntilRepeat = {read=FDelayUntilRepeat, write=FDelayUntilRepeat, default=100};
	__property Imglist::TImageIndex ImageIndex = {read=FImageIndex, write=SetImageIndex, default=0};
	__property Imglist::TCustomImageList* ImageList = {read=FImages, write=SetImageList};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property TRzAnimatorFrameChangeEvent OnFrameChange = {read=FOnFrameChange, write=FOnFrameChange};
	__property Classes::TNotifyEvent OnCycleComplete = {read=FOnCycleComplete, write=FOnCycleComplete};
	__property Color  = {default=-16777211};
	__property OnClick ;
	__property OnDblClick ;
	__property OnContextPopup ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzAnimator(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzanimtr */
using namespace Rzanimtr;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzanimtr

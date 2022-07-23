// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzintlst.pas' rev: 10.00

#ifndef RzintlstHPP
#define RzintlstHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzintlst
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS EOutOfRange;
class PASCALIMPLEMENTATION EOutOfRange : public Classes::EListError 
{
	typedef Classes::EListError inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall EOutOfRange(const AnsiString Msg) : Classes::EListError(Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall EOutOfRange(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size) : Classes::EListError(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall EOutOfRange(int Ident)/* overload */ : Classes::EListError(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall EOutOfRange(int Ident, System::TVarRec const * Args, const int Args_Size)/* overload */ : Classes::EListError(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall EOutOfRange(const AnsiString Msg, int AHelpContext) : Classes::EListError(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall EOutOfRange(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size, int AHelpContext) : Classes::EListError(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall EOutOfRange(int Ident, int AHelpContext)/* overload */ : Classes::EListError(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall EOutOfRange(System::PResStringRec ResStringRec, System::TVarRec const * Args, const int Args_Size, int AHelpContext)/* overload */ : Classes::EListError(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~EOutOfRange(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzIntegerList;
class PASCALIMPLEMENTATION TRzIntegerList : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
public:
	int operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TList* FList;
	Classes::TDuplicates FDuplicates;
	int FMin;
	int FMax;
	bool FSorted;
	void __fastcall ReadMin(Classes::TReader* Reader);
	void __fastcall WriteMin(Classes::TWriter* Writer);
	void __fastcall ReadMax(Classes::TReader* Reader);
	void __fastcall WriteMax(Classes::TWriter* Writer);
	void __fastcall ReadIntegers(Classes::TReader* Reader);
	void __fastcall WriteIntegers(Classes::TWriter* Writer);
	void __fastcall SetSorted(bool Value);
	void __fastcall QuickSort(int L, int R);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual bool __fastcall Find(int N, int &Index);
	int __fastcall GetCount(void);
	int __fastcall GetItem(int Index);
	virtual void __fastcall SetItem(int Index, int Value);
	void __fastcall SetMin(int Value);
	void __fastcall SetMax(int Value);
	virtual void __fastcall Sort(void);
	
public:
	__fastcall TRzIntegerList(void);
	__fastcall virtual ~TRzIntegerList(void);
	virtual int __fastcall Add(int Value);
	virtual void __fastcall AddIntegers(TRzIntegerList* List);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Clear(void);
	virtual void __fastcall Delete(int Index);
	bool __fastcall Equals(TRzIntegerList* List);
	virtual void __fastcall Exchange(int Index1, int Index2);
	virtual int __fastcall IndexOf(int N);
	virtual void __fastcall Insert(int Index, int Value);
	virtual void __fastcall InsertNumber(int Index, int Value);
	virtual void __fastcall Move(int CurIndex, int NewIndex);
	__property Classes::TDuplicates Duplicates = {read=FDuplicates, write=FDuplicates, nodefault};
	__property int Count = {read=GetCount, nodefault};
	__property int Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property int Min = {read=FMin, write=SetMin, nodefault};
	__property int Max = {read=FMax, write=SetMax, nodefault};
	__property bool Sorted = {read=FSorted, write=SetSorted, nodefault};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzintlst */
using namespace Rzintlst;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzintlst

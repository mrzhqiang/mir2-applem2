// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzsysres.pas' rev: 10.00

#ifndef RzsysresHPP
#define RzsysresHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzsysres
{
//-- type declarations -------------------------------------------------------
#pragma option push -b
enum TFreeSystemResources { gfsr_SystemResources, gfsr_GDIResources, gfsr_UserResources };
#pragma option pop

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE int __fastcall GetFreeSystemResources(TFreeSystemResources ResType);

}	/* namespace Rzsysres */
using namespace Rzsysres;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzsysres

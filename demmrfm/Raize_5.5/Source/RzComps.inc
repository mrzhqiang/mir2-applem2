{===============================================================================
  RzComps Include File

  This file is included into each unit and serves as a common place to add
  conditional defines and compiler directives to be used by all units.

  Symbol                Meaning
  ------------------------------------------------------------------------------
  VER13x                Compiler version is between 130 and 139 (Delphi 5)
  VER14x                Compiler version is between 140 and 149 (Delphi 6)
  VER15x                Compiler version is between 150 and 159 (Delphi 7)
  VER16x                Compiler version is between 160 and 169 (Delphi 8)
  VER17x                Compiler version is between 170 and 179 (Delphi 2005)
  VER18x                Compiler version is between 180 and 189 (BDS 2006/2007)
  VER20x                Compiler version is between 200 and 209 (RS 2009)
  VER21x                Compiler version is between 210 and 219 (RS 2010)
  VER22x                Compiler version is between 220 and 229 (XE)

  DELPHI                Is a Delphi verison of the compiler.
  BCB                   Is a C++Builder version of the compiler.

  VCL50                 VCL version 5.0 (Delphi 5.0, C++Builder 5)
  VCL60                 VCL version 6.0 (Delphi 6.0, C++Builder 6)
  VCL70                 VCL version 7.0 (Delphi 7.0)
  VCL80                 VCL version 8.0 (Delphi 8.0)
  VCL90                 VCL version 9.0 (Delphi 9.0 - a.k.a. Delphi 2005)
  VCL100                VCL version 10.0 (Delphi 10.0 - a.k.a. Delphi 2006)
  VCL105                VCL version 10.5 (Delphi 10.5 - a.k.a. Delphi 2007)
  VCL120                VCL version 12.0 (Delphi 12.0 - a.k.a. Delphi 2009)
  VCL140                VCL version 14.0 (Delphi 14.0 - a.k.a. Delphi 2010)
  VCL150                VCL version 15.0 (Delphi 15.0 - a.k.a. Delphi XE)

  VCL50_OR_HIGHER       VCL version 5.0 or higher
  VCL60_OR_HIGHER       VCL version 6.0 or higher
  VCL70_OR_HIGHER       VCL version 7.0 or higher
  VCL80_OR_HIGHER       VCL version 8.0 or higher
  VCL90_OR_HIGHER       VCL version 9.0 or higher
  VCL100_OR_HIGHER      VCL version 10.0 or higher
  VCL105_OR_HIGHER      VCL version 10.5 or higher
  VCL120_OR_HIGHER      VCL version 12.0 or higher
  VCL140_OR_HIGHER      VCL version 14.0 or higher
  VCL150_OR_HIGHER      VCL version 15.0 or higher

  DELPHI5               Delphi 5
  DELPHI6               Delphi 6
  DELPHI7               Delphi 7     
  DELPHI8               Delphi 8
  DELPHI9               Delphi 9
  DELPHI10              Delphi 10
  DELPHI12              Delphi 12
  DELPHI14              Delphi 14
  DELPHI15              Delphi 15
  D5_OR_HIGHER          Delphi 5 or higher
  D6_OR_HIGHER          Delphi 6 or higher
  D7_OR_HIGHER          Delphi 7 or higher
  D8_OR_HIGHER          Delphi 8 or higher
  D9_OR_HIGHER          Delphi 9 or higher
  D10_OR_HIGHER         Delphi 10 or higher
  D12_OR_HIGHER         Delphi 12 or higher
  D14_OR_HIGHER         Delphi 14 or higher
  D15_OR_HIGHER         Delphi 15 or higher

  BCB5                  C++Builder 5
  BCB6                  C++Builder 6
  BCB5_OR_HIGHER        C++Builder 5 or higher
  BCB6_OR_HIGHER        C++Builder 6 or higher
  BCB10_OR_HIGHER       C++Builder 10 or higher
  BCB12_OR_HIGHER       C++Builder 12 or higher
  BCB14_OR_HIGHER       C++Builder 14 or higher
  BCB15_OR_HIGHER       C++Builder 15 or higher

  DOT_NET               Compiling for Microsoft .NET Framework



  Copyright © 1995-2010 by Raize Software, Inc.  All Rights Reserved.
===============================================================================}

{$DEFINE VER_UNKNOWN}

// VER130 (Delphi 5 & C++Builder 5)

{$IFDEF VER130}
  {$UNDEF VER_UNKNOWN}
  {$DEFINE VER13x}
  {$DEFINE VCL50}

  {$IFDEF BCB}
    {$DEFINE BCB5}
    {$DEFINE BCB5_OR_HIGHER}
    {$OBJEXPORTALL ON}
  {$ELSE}
    {$DEFINE DELPHI}
    {$DEFINE DELPHI5}
    {$DEFINE D5_OR_HIGHER}
  {$ENDIF}

  {$DEFINE VCL50_OR_HIGHER}
{$ENDIF}


// VER140 (Delphi 6 & C++Builder 6 & Kylix 1)

{$IFDEF VER140}
  {$UNDEF VER_UNKNOWN}
  {$DEFINE VER14x}
  {$DEFINE VCL60}

  {$IFDEF MSWINDOWS}
    {$IFDEF BCB}
      {$DEFINE BCB6}
      {$DEFINE BCB5_OR_HIGHER}
      {$DEFINE BCB6_OR_HIGHER}
      {$OBJEXPORTALL ON}
    {$ELSE}
      {$DEFINE DELPHI}
      {$DEFINE DELPHI6}
      {$DEFINE D5_OR_HIGHER}
      {$DEFINE D6_OR_HIGHER}
    {$ENDIF}
  {$ELSE}
    // Non-Windows compiler (i.e. Kylix)
  {$ENDIF}

  {$DEFINE VCL50_OR_HIGHER}
  {$DEFINE VCL60_OR_HIGHER}
{$ENDIF}


// VER150 (Delphi 7)

{$IFDEF VER150}
  {$UNDEF VER_UNKNOWN}
  {$DEFINE VER15x}
  {$DEFINE VCL70}

  {$IFDEF MSWINDOWS}
    {$IFDEF BCB}
      {$DEFINE BCB5_OR_HIGHER}
      {$DEFINE BCB6_OR_HIGHER}
      {$OBJEXPORTALL ON}
    {$ELSE}
      {$DEFINE DELPHI}
      {$DEFINE DELPHI7}
      {$DEFINE D5_OR_HIGHER}
      {$DEFINE D6_OR_HIGHER}
      {$DEFINE D7_OR_HIGHER}
    {$ENDIF}
    {$DEFINE DOT_NET_WARNINGS_OFF}
  {$ELSE}
    // Non-Windows compiler (i.e. Kylix)
  {$ENDIF}

  {$DEFINE VCL50_OR_HIGHER}
  {$DEFINE VCL60_OR_HIGHER}
  {$DEFINE VCL70_OR_HIGHER}
{$ENDIF}


// VER160 (Delphi 8)

{$IFDEF VER160}
  {$UNDEF VER_UNKNOWN}
  {$DEFINE VER16x}
  {$DEFINE VCL80}

  {$IFDEF MSWINDOWS}
    {$IFDEF BCB}
      {$DEFINE BCB5_OR_HIGHER}
      {$DEFINE BCB6_OR_HIGHER}
      {$OBJEXPORTALL ON}
    {$ELSE}
      {$DEFINE DELPHI}
      {$DEFINE DELPHI8}
      {$DEFINE D5_OR_HIGHER}
      {$DEFINE D6_OR_HIGHER}
      {$DEFINE D7_OR_HIGHER}
      {$DEFINE D8_OR_HIGHER}
    {$ENDIF}
    //{$DEFINE DOT_NET_WARNINGS_OFF}
  {$ELSE}
    // Non-Windows compiler (i.e. Kylix)
  {$ENDIF}

  {$DEFINE VCL50_OR_HIGHER}
  {$DEFINE VCL60_OR_HIGHER}
  {$DEFINE VCL70_OR_HIGHER}
  {$DEFINE VCL80_OR_HIGHER}
{$ENDIF}


// VER170 (Delphi 2005)

{$IFDEF VER170}
  {$UNDEF VER_UNKNOWN}
  {$DEFINE VER17x}
  {$DEFINE VCL90}

  {$IFDEF MSWINDOWS}
    {$IFDEF BCB}
      {$DEFINE BCB5_OR_HIGHER}
      {$DEFINE BCB6_OR_HIGHER}
      {$OBJEXPORTALL ON}
    {$ELSE}
      {$DEFINE DELPHI}
      {$DEFINE DELPHI9}
      {$DEFINE D5_OR_HIGHER}
      {$DEFINE D6_OR_HIGHER}
      {$DEFINE D7_OR_HIGHER}
      {$DEFINE D8_OR_HIGHER}
      {$DEFINE D9_OR_HIGHER}
    {$ENDIF}
    //{$DEFINE DOT_NET_WARNINGS_OFF}
  {$ELSE}
    // Non-Windows compiler (i.e. Kylix)
  {$ENDIF}

  {$DEFINE VCL50_OR_HIGHER}
  {$DEFINE VCL60_OR_HIGHER}
  {$DEFINE VCL70_OR_HIGHER}
  {$DEFINE VCL80_OR_HIGHER}
  {$DEFINE VCL90_OR_HIGHER}
{$ENDIF}


// VER180 (Delphi 2006) and VER185 (Delphi 2007)

{$IFDEF VER180}
  {$UNDEF VER_UNKNOWN}
  {$DEFINE VER18x}
  {$DEFINE VCL100}

  {$IFDEF MSWINDOWS}
    {$IFDEF BCB}
      {$DEFINE BCB5_OR_HIGHER}
      {$DEFINE BCB6_OR_HIGHER}
      {$DEFINE BCB10_OR_HIGHER}
      {$OBJEXPORTALL ON}
    {$ELSE}
      {$DEFINE DELPHI}
      {$DEFINE DELPHI10}
      {$DEFINE D5_OR_HIGHER}
      {$DEFINE D6_OR_HIGHER}
      {$DEFINE D7_OR_HIGHER}
      {$DEFINE D8_OR_HIGHER}
      {$DEFINE D9_OR_HIGHER}
      {$DEFINE D10_OR_HIGHER}
    {$ENDIF}
    //{$DEFINE DOT_NET_WARNINGS_OFF}
  {$ELSE}
    // Non-Windows compiler (i.e. Kylix)
  {$ENDIF}

  {$DEFINE VCL50_OR_HIGHER}
  {$DEFINE VCL60_OR_HIGHER}
  {$DEFINE VCL70_OR_HIGHER}
  {$DEFINE VCL80_OR_HIGHER}
  {$DEFINE VCL90_OR_HIGHER}
  {$DEFINE VCL100_OR_HIGHER}
  
  {$IFDEF VER185}
    {$DEFINE VCL105}
    {$DEFINE VCL105_OR_HIGHER}
  {$ENDIF}
  
{$ENDIF}



// VER200 (RAD Studio 2009)

{$IFDEF VER200}
  {$UNDEF VER_UNKNOWN}
  {$DEFINE VER20x}
  {$DEFINE VCL120}

  {$IFDEF MSWINDOWS}
    {$IFDEF BCB}
      {$DEFINE BCB5_OR_HIGHER}
      {$DEFINE BCB6_OR_HIGHER}
      {$DEFINE BCB10_OR_HIGHER}
      {$DEFINE BCB12_OR_HIGHER}
      {$OBJEXPORTALL ON}
    {$ELSE}
      {$DEFINE DELPHI}
      {$DEFINE DELPHI12}
      {$DEFINE D5_OR_HIGHER}
      {$DEFINE D6_OR_HIGHER}
      {$DEFINE D7_OR_HIGHER}
      {$DEFINE D8_OR_HIGHER}
      {$DEFINE D9_OR_HIGHER}
      {$DEFINE D10_OR_HIGHER}
      {$DEFINE D12_OR_HIGHER}
    {$ENDIF}
    //{$DEFINE DOT_NET_WARNINGS_OFF}
  {$ELSE}
    // Non-Windows compiler (i.e. Kylix)
  {$ENDIF}

  {$DEFINE VCL50_OR_HIGHER}
  {$DEFINE VCL60_OR_HIGHER}
  {$DEFINE VCL70_OR_HIGHER}
  {$DEFINE VCL80_OR_HIGHER}
  {$DEFINE VCL90_OR_HIGHER}
  {$DEFINE VCL100_OR_HIGHER}
  {$DEFINE VCL105_OR_HIGHER}
  {$DEFINE VCL120_OR_HIGHER}
{$ENDIF}


// VER210 (RAD Studio 2010)

{$IFDEF VER210}
  {$UNDEF VER_UNKNOWN}
  {$DEFINE VER21x}
  {$DEFINE VCL140}

  {$IFDEF MSWINDOWS}
    {$IFDEF BCB}
      {$DEFINE BCB5_OR_HIGHER}
      {$DEFINE BCB6_OR_HIGHER}
      {$DEFINE BCB10_OR_HIGHER}
      {$DEFINE BCB12_OR_HIGHER}
      {$DEFINE BCB14_OR_HIGHER}
      {$OBJEXPORTALL ON}
    {$ELSE}
      {$DEFINE DELPHI}
      {$DEFINE DELPHI12}
      {$DEFINE D5_OR_HIGHER}
      {$DEFINE D6_OR_HIGHER}
      {$DEFINE D7_OR_HIGHER}
      {$DEFINE D8_OR_HIGHER}
      {$DEFINE D9_OR_HIGHER}
      {$DEFINE D10_OR_HIGHER}
      {$DEFINE D12_OR_HIGHER}
      {$DEFINE D14_OR_HIGHER}
    {$ENDIF}
    //{$DEFINE DOT_NET_WARNINGS_OFF}
  {$ELSE}
    // Non-Windows compiler (i.e. Kylix)
  {$ENDIF}

  {$DEFINE VCL50_OR_HIGHER}
  {$DEFINE VCL60_OR_HIGHER}
  {$DEFINE VCL70_OR_HIGHER}
  {$DEFINE VCL80_OR_HIGHER}
  {$DEFINE VCL90_OR_HIGHER}
  {$DEFINE VCL100_OR_HIGHER}
  {$DEFINE VCL105_OR_HIGHER}
  {$DEFINE VCL120_OR_HIGHER}
  {$DEFINE VCL140_OR_HIGHER}
{$ENDIF}


// VER220 (RAD Studio XE)

// If compiler version is unknown, assume to be VER220

{$IFDEF VER220}
  {$DEFINE USE_VER220}
{$ENDIF}

{$IFDEF VER_UNKNOWN}
  {$UNDEF VER_UNKNOWN}
  {$DEFINE USE_VER220}
{$ENDIF}

{$IFDEF USE_VER220}
  {$UNDEF VER_UNKNOWN}
  {$DEFINE VER22x}
  {$DEFINE VCL150}

  {$IFDEF MSWINDOWS}
    {$IFDEF BCB}
      {$DEFINE BCB5_OR_HIGHER}
      {$DEFINE BCB6_OR_HIGHER}
      {$DEFINE BCB10_OR_HIGHER}
      {$DEFINE BCB12_OR_HIGHER}
      {$DEFINE BCB14_OR_HIGHER}
      {$DEFINE BCB15_OR_HIGHER}
      {$OBJEXPORTALL ON}
    {$ELSE}
      {$DEFINE DELPHI}
      {$DEFINE DELPHI12}
      {$DEFINE D5_OR_HIGHER}
      {$DEFINE D6_OR_HIGHER}
      {$DEFINE D7_OR_HIGHER}
      {$DEFINE D8_OR_HIGHER}
      {$DEFINE D9_OR_HIGHER}
      {$DEFINE D10_OR_HIGHER}
      {$DEFINE D12_OR_HIGHER}
      {$DEFINE D14_OR_HIGHER}
      {$DEFINE D15_OR_HIGHER}
    {$ENDIF}
    //{$DEFINE DOT_NET_WARNINGS_OFF}
  {$ELSE}
    // Non-Windows compiler (i.e. Kylix)
  {$ENDIF}

  {$DEFINE VCL50_OR_HIGHER}
  {$DEFINE VCL60_OR_HIGHER}
  {$DEFINE VCL70_OR_HIGHER}
  {$DEFINE VCL80_OR_HIGHER}
  {$DEFINE VCL90_OR_HIGHER}
  {$DEFINE VCL100_OR_HIGHER}
  {$DEFINE VCL105_OR_HIGHER}
  {$DEFINE VCL120_OR_HIGHER}
  {$DEFINE VCL140_OR_HIGHER}
  {$DEFINE VCL150_OR_HIGHER}
{$ENDIF}


{== Warnings ==================================================================}

{$IFDEF VCL60_OR_HIGHER}
  {$WARN UNIT_PLATFORM OFF}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_DEPRECATED OFF}
  {$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}


{$IFDEF DOT_NET_WARNINGS_OFF}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
{$ENDIF}


{$IFDEF CIL}
  {$DEFINE DOT_NET}
  {$DEFINE CLR_11}
  {$IFDEF VER185}
    {$DEFINE CLR_20}
  {$ENDIF}
{$ENDIF}


{== Code Generation Directives ================================================}

{$ALIGN ON}
{$OPTIMIZATION ON}
{$SAFEDIVIDE OFF}
{$STACKFRAMES OFF}

// Runtime Errors

{$IFOPT D+}
  // Compiled with Debug Information
  {$ASSERTIONS ON}
  {$LOCALSYMBOLS ON}
  {$RANGECHECKS ON}
  {$REFERENCEINFO ON}
{$ELSE}
  // Compiled without Debug Information
  {$ASSERTIONS OFF}
  {$LOCALSYMBOLS OFF}
  {$RANGECHECKS OFF}
  {$REFERENCEINFO OFF}
{$ENDIF}

{$IOCHECKS ON}
{$OVERFLOWCHECKS OFF}

// Syntax Options

{$BOOLEVAL OFF}
{$LONGSTRINGS ON}
{$WRITEABLECONST OFF}
{$OPENSTRINGS ON}
{$TYPEDADDRESS OFF}
{$VARSTRINGCHECKS OFF}
{$EXTENDEDSYNTAX ON}

// Miscellaneous Directives

{$IMPORTEDDATA ON}
{$MINENUMSIZE 1}


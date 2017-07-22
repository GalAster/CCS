(* ::Package:: *)
(* ::Title:: *)
(*CCS Method*)
(* ::Subchapter:: *)
(*程序包介绍*)
(* ::Text:: *)
(*Mathematica Package*)
(*Created by Mathematica Plugin for IntelliJ IDEA*)
(*Establish from GalAster's template*)
(**)
(*Author:GalAster*)
(*Creation Date:2017.7.12*)
(*Copyright:CC4.0 BY+NA+NC*)
(**)
(*该软件包遵从CC协议:署名、非商业性使用、相同方式共享*)
(**)
(*该程序包为CCS(常量交换库)提供下载和标准化生成方法*)
(* ::Section:: *)
(*函数说明*)
BeginPackage["CCS`"];
ExampleFunction::usage = "这里应该填这个函数的说明,如果要换行用\"\r\"\r就像这样";
(* ::Section:: *)
(*程序包正体*)
(* ::Subsection::Closed:: *)
(*主设置*)
CCS$Version="V1.0";
CCS$Environment="V11.0+";
CCS$LastUpdate="2017-7-22";
STD::usage = "程序包的说明,这里抄一遍";
Begin["`Private`"];
(* ::Subsection::Closed:: *)
(*主体代码*)
(* ::Subsubsection:: *)
(*STD 方法*)
STD$DS[Name_] := Block[{name, print},
  Clear[Name]; name = ToString@Name;
  print = {"!Constants", name <> "=", "",
    "!StandardizationSaveProcess", "",
    "SetDirectory[NotebookDirectory[]];",
    "DumpSave[\"" <> name <> ".mx\"," <> name <> "];", "",
    "!StandardizationLoadProcess", "",
    "SetDirectory[NotebookDirectory[]];",
    "<<" <> name <> ".mx"};
  Export["temp.txt", StringJoin@Riffle[print, "\n"]];
  SystemOpen["temp.txt"]];
STD$CCS[Name_] := Block[{name, print},
  Clear[Name]; name = ToString@Name;
  print = {"!Constants", name <> "=", "",
    "!StandardizationSaveProcess", "",
    "Clear[compress,save];",
    "compress=BinarySerialize[" <> name <> ",PerformanceGoal->\"Size\"]",
    "SetDirectory[NotebookDirectory[]];",
    "save=OpenWrite[\"" <> name <> ".ccs\", BinaryFormat->True];",
    "BinaryWrite[save,compress];Close[save];", "",
    "!StandardizationLoadProcess", "",
    "SetDirectory[NotebookDirectory[]];",
    name <> "=BinaryDeserialize[ByteArray[BinaryReadList[\"" <> name <> ".ccs\", \"Byte\"]]];"};
  Export["temp.txt", StringJoin@Riffle[print, "\n"]];
  SystemOpen["temp.txt"]];


(* ::Subsubsection:: *)
(*功能块 2*)
Options[STD]={Method->"CCS"};
STD[Name_,OptionsPattern[]]:=Switch[OptionValue[Method],"CCS",STD$CCS[Name],"DS",STD$DS[Name]];
SetAttributes[{STD$DS,STD$CCS},HoldAll];SetAttributes[STD,HoldFirst];

(* ::Subsection::Closed:: *)
(*附加设置*)
End[] ;

EndPackage[];

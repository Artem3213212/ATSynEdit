{
Copyright (C) Alexey Torgashin, uvviewsoft.com
License: MPL 2.0 or LGPL
}
unit ATSynEdit_Adapters;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics,
  ATSynEdit_CanvasProc;

type
  { TATAdapterHilite }

  TATAdapterHilite = class(TComponent)
  private
    FDynamicHiliteEnabled: boolean;
    FDynamicHiliteMaxLines: integer;
    FDynamicHiliteSupportedInCurLexer: boolean;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AddEditor(AEditor: TComponent); virtual;
    //
    procedure OnEditorChange(Sender: TObject); virtual;
    procedure OnEditorCalcHilite(Sender: TObject;
      var AParts: TATLineParts;
      ALineIndex, ACharIndex, ALineLen: integer;
      var AColorAfterEol: TColor); virtual;
    procedure OnEditorCalcPosColor(Sender: TObject;
      AX, AY: integer; var AColor: TColor); virtual;
    procedure OnEditorCaretMove(Sender: TObject); virtual;
    procedure OnEditorScroll(Sender: TObject); virtual;
    procedure OnEditorBeforeCalcHilite(Sender: TObject); virtual;
    //
    property DynamicHiliteEnabled: boolean read FDynamicHiliteEnabled write FDynamicHiliteEnabled;
    //dyn-hiliting global enabled flag.
    //set value from your app.
    //dyn-hiliting is on, if some chars colors depend on caret position,
    //e.g. in EControl HTML lexer: hilites of < > change, if caret is near < >
    property DynamicHiliteMaxLines: integer read FDynamicHiliteMaxLines write FDynamicHiliteMaxLines;
    //pass here some int from application options, e.g. 5000 is ok
    property DynamicHiliteSupportedInCurLexer: boolean read FDynamicHiliteSupportedInCurLexer write FDynamicHiliteSupportedInCurLexer;
    //pass here value, which real apdater (subclass of TATAdapterHilite)
    //detected for current syntax. EControl adapter calculates it from lexer-file.
    function DynamicHiliteActiveNow(ALinesCount: integer): boolean;
    //resulting bool, calculated from above props, and current count of lines.
    //ATSynEdit reads it.
  end;

implementation

{ TATAdapterHilite }

constructor TATAdapterHilite.Create(AOwner: TComponent);
begin
  inherited;
  FDynamicHiliteEnabled:= true;
  FDynamicHiliteSupportedInCurLexer:= true;
  FDynamicHiliteMaxLines:= 1000;
end;

procedure TATAdapterHilite.AddEditor(AEditor: TComponent);
begin
  // not nil: adapter adds this editor object to his editors list,
  //   and should setup editor's OnLog
  // nil: adapter forgets about all editors
end;

procedure TATAdapterHilite.OnEditorChange(Sender: TObject);
begin
  //
end;

procedure TATAdapterHilite.OnEditorCalcHilite(Sender: TObject;
  var AParts: TATLineParts; ALineIndex, ACharIndex, ALineLen: integer;
  var AColorAfterEol: TColor);
begin
  //
end;

procedure TATAdapterHilite.OnEditorCalcPosColor(Sender: TObject; AX,
  AY: integer; var AColor: TColor);
begin
  //
end;

procedure TATAdapterHilite.OnEditorCaretMove(Sender: TObject);
begin
  //
end;

procedure TATAdapterHilite.OnEditorScroll(Sender: TObject);
begin
  //
end;

procedure TATAdapterHilite.OnEditorBeforeCalcHilite(Sender: TObject);
begin
  //
end;

function TATAdapterHilite.DynamicHiliteActiveNow(ALinesCount: integer): boolean;
begin
  Result:=
    DynamicHiliteEnabled and
    DynamicHiliteSupportedInCurLexer and
    (ALinesCount<=DynamicHiliteMaxLines);
end;


end.


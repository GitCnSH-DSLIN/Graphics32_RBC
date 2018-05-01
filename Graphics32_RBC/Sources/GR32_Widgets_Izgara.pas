unit GR32_Widgets_Izgara;

interface

uses
    GR32_Widgets_Base
  , GR32_Rubicube_Utils         //  Rubicube extensions
  , GR32                        //  TBitmap32
          //  TColor32, ColorTo
  , GR32_Polygons               //  Poligon hesaplama form�lleri
  , System.Classes              //  TComponent
  , System.SysUtils             //  FreeAndNil
                  //  Min
  , Vcl.Graphics                //  TColor
  , Vcl.Controls                //  TCustomControl
  ;

type
  TGR32WidgetIzgara = class(TGR32CustomWidget)
    private
      FAralikDikey  : Integer;
      FAralikYatay  : Integer;
      FBackground   : TColor;
      FBorderColor  : TColor;
      FBorderStyle  : TPenStyle;
      FBorderWidth  : Integer;
      FDamaModu     : Boolean;
      FLineColor    : TColor;
      FLineStyle    : TPenStyle;
      FLineWidth    : Integer;
      procedure SetAralikDikey(const Value: Integer);
      procedure SetAralikYatay(const Value: Integer);
      procedure SetBackground(const Value: TColor);
      procedure SetBorderColor(const Value: TColor);
      procedure SetBorderStyle(const Value: TPenStyle);
      procedure SetBorderWidth(const Value: Integer);
      procedure SetDamamModu(const Value: Boolean);
      procedure SetLineColor(const Value: TColor);
      procedure SetLineStyle(const Value: TPenStyle);
      procedure SetLineWidth(const Value: Integer);
    protected
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure PaintControl; override;
    published
      property AralikDikey  : Integer     read  FAralikDikey    write SetAralikDikey    ;
      property AralikYatay  : Integer     read  FAralikYatay    write SetAralikYatay    ;
      property Background   : TColor      read  FBackground     write SetBackground     ;
      property BorderColor  : TColor      read  FBorderColor    write SetBorderColor    ;
      property BorderStyle  : TPenStyle   read  FBorderStyle    write SetBorderStyle    ;
      property BorderWidth  : Integer     read  FBorderWidth    write SetBorderWidth    ;
      property DamaModu     : Boolean     read  FDamaModu       write SetDamamModu      ;
      property LineColor    : TColor      read  FLineColor      write SetLineColor      ;
      property LineStyle    : TPenStyle   read  FLineStyle      write SetLineStyle      ;
      property LineWidth    : Integer     read  FLineWidth      write SetLineWidth      ;
      property Margins;
      property Left;
      property Top;
      property Width;
      property Height;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Graphics32RBC', [TGR32WidgetIzgara]);
end;


{ TGR32WidgetIzgara }

constructor TGR32WidgetIzgara.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAralikDikey  := 10;
  FAralikYatay  := 10;
  FBackground   := clWindow;
  FBorderColor  := $00CECECE;
  FBorderStyle  := psDot;
  FBorderWidth  := 1;
  FLineColor    := $00EBEBEB;
  FLineStyle    := psDot;
  FLineWidth    := 1;
end;

destructor TGR32WidgetIzgara.Destroy;
begin
  //
  inherited Destroy;
end;

procedure TGR32WidgetIzgara.SetAralikDikey(const Value: Integer);
begin
  FAralikDikey := Value; Invalidate;
end;

procedure TGR32WidgetIzgara.SetAralikYatay(const Value: Integer);
begin
  FAralikYatay := Value; Invalidate;
end;

procedure TGR32WidgetIzgara.SetBackground(const Value: TColor);
begin
  FBackground := Value; Invalidate;
end;

procedure TGR32WidgetIzgara.SetBorderColor(const Value: TColor);
begin
  FBorderColor := Value; Invalidate;
end;

procedure TGR32WidgetIzgara.SetBorderStyle(const Value: TPenStyle);
begin
  FBorderStyle := Value; Invalidate;
end;

procedure TGR32WidgetIzgara.SetBorderWidth(const Value: Integer);
begin
  FBorderWidth := Value; Invalidate;
end;

procedure TGR32WidgetIzgara.SetDamamModu(const Value: Boolean);
begin
  FDamaModu := Value; Invalidate;
end;

procedure TGR32WidgetIzgara.SetLineColor(const Value: TColor);
begin
  FLineColor := Value; Invalidate;
end;

procedure TGR32WidgetIzgara.SetLineStyle(const Value: TPenStyle);
begin
  FLineStyle := Value; Invalidate;
end;

procedure TGR32WidgetIzgara.SetLineWidth(const Value: Integer);
begin
  FLineWidth := Value; Invalidate;
end;

procedure TGR32WidgetIzgara.PaintControl;
var
  T, L, W, H  : Integer;                // Genel �er�eve bilgisi
  BW_, LW_    : Integer;                // Border ve Frame �izgi kal�nl���
  I, J, K, MI, MJ: Integer;
  Ressam      : TPolygonRenderer32VPR;  // TPolygonRenderer32; //  Tuval
  XY, QW      : TFloatPoint;

  CL : TColor32;
  X, Y: Integer;
  OddY, OddX: Boolean;
  ScanLine: PColor32Array;
  CCheckerBoardColor: array[0..1] of TColor32;

begin
  CCheckerBoardColor[0] := Color32(FBackground);
  CCheckerBoardColor[1] := Color32(FLineColor);
  Ressam          := TPolygonRenderer32VPR.Create;
  Ressam.Filler   := nil; // hen�z bir gradient kullanmad�k.
  Ressam.FillMode := pfWinding;// FAyarlar.StyleFill.toPolyFillMode; // pfWinding; // bu ayar, iki �izgi �st �ste kesi�ti�inde �izgilerin kesi�ti�i k�s�mlar�n birbirini yok etmesini engeller...
  Ressam.Bitmap   := Self.FBuffer;
  Ressam.Bitmap.Clear( Color32(FBackground) );

  T  := 0;
  L  := 0;
  W  := ClientWidth ;
  H  := ClientHeight;
  if (FDamaModu = False) then begin
      XY.X := 0;
      XY.Y := 0;
      QW.X := W;
      QW.Y := 0;
      repeat
        XY.X := XY.X + FAralikYatay;
        XY.Y := 0;
        QW.X := XY.X;
        QW.Y := H;
        Ressam.SekilBas(Color32(FLineColor), Ressam.Cizgi(XY, QW, FLineWidth, FLineStyle));
      until (XY.X >= W);

      XY.X := 0;
      XY.Y := 0;
      QW.X := W;
      QW.Y := 0;
      repeat
        XY.X := 0;
        XY.Y := XY.Y + FAralikDikey;
        QW.X := W;
        QW.Y := XY.Y;
        Ressam.SekilBas(Color32(FLineColor), Ressam.Cizgi(XY, QW, FLineWidth, FLineStyle));
      until (XY.Y >= H);
  end else begin
      I := round(ClientWidth / FAralikYatay);
      J := round(ClientHeight / FAralikDikey);
      for Y := 0 to J do begin
          for X := 0 to I do begin
              if  Odd(X) xor Odd(Y)
              then CL := CCheckerBoardColor[ 0 ]
              else CL := CCheckerBoardColor[ 1 ];
              XY.X := (X * FAralikYatay) + (FAralikYatay div 2) + FBorderWidth;
              XY.Y := (Y * FAralikDikey) + (FAralikDikey div 2) + FBorderWidth;
              Ressam.SekilBas(CL, Ressam.Dikdortgen(XY, FAralikYatay, FAralikDikey));
          end;
      end;

  end;

  Ressam.SekilBas( Color32(FBorderColor), Ressam.DikDortgenCizgi(Merkez, W, H, FBorderWidth, FBorderStyle ) );
  Ressam.Free;
end;

end.

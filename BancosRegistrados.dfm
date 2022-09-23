object fmBancosRegistrados: TfmBancosRegistrados
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Bancos Registrados'
  ClientHeight = 647
  ClientWidth = 524
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbBancos: TListBox
    Left = 0
    Top = 0
    Width = 524
    Height = 647
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnDblClick = lbBancosDblClick
    OnKeyDown = lbBancosKeyDown
    OnMouseDown = lbBancosMouseDown
    ExplicitLeft = 264
    ExplicitTop = 128
    ExplicitWidth = 121
    ExplicitHeight = 97
  end
  object PopupMenu1: TPopupMenu
    Left = 252
    Top = 136
    object mEditarCnx: TMenuItem
      Caption = 'Editar Conex'#227'o'
      OnClick = mEditarCnxClick
    end
  end
  object FDCn: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    Left = 256
    Top = 328
  end
end

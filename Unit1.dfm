object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 621
  ClientWidth = 996
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object EdgeBrowser1: TEdgeBrowser
    Left = 0
    Top = 57
    Width = 996
    Height = 564
    Align = alClient
    TabOrder = 0
    OnCreateWebViewCompleted = EdgeBrowser1CreateWebViewCompleted
    OnNavigationCompleted = EdgeBrowser1NavigationCompleted
    OnWebMessageReceived = EdgeBrowser1WebMessageReceived
    ExplicitWidth = 1010
    ExplicitHeight = 639
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 996
    Height = 57
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 1010
    object Label1: TLabel
      Left = 16
      Top = 19
      Width = 58
      Height = 13
      Caption = 'Search Text'
    end
    object BackButton: TButton
      Left = 928
      Top = 16
      Width = 23
      Height = 22
      Caption = #57510
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = BackClick
    end
    object ForwardButton: TButton
      Left = 957
      Top = 16
      Width = 23
      Height = 22
      Caption = #57515
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = ForwardClick
    end
    object Edit1: TEdit
      Left = 88
      Top = 16
      Width = 329
      Height = 21
      TabOrder = 0
    end
    object Button1: TButton
      Left = 423
      Top = 14
      Width = 75
      Height = 25
      Caption = 'Find'
      TabOrder = 1
      OnClick = FindClick
    end
    object Button2: TButton
      Left = 536
      Top = 14
      Width = 75
      Height = 25
      Caption = 'Copy'
      TabOrder = 2
      OnClick = CopyClick
    end
  end
end

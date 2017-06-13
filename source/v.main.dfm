object vMain: TvMain
  Left = 0
  Top = 0
  Caption = 'String Replacer'
  ClientHeight = 471
  ClientWidth = 851
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter: TRzSplitter
    Left = 0
    Top = 0
    Width = 851
    Height = 471
    Position = 531
    Percent = 63
    HotSpotVisible = True
    SplitterWidth = 7
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 40
    ExplicitWidth = 662
    BarSize = (
      531
      0
      538
      471)
    UpperLeftControls = (
      Panel1)
    LowerRightControls = (
      Label2
      Panel2
      MemoRplc)
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 525
      Height = 465
      Align = alClient
      TabOrder = 0
      ExplicitLeft = -173
      ExplicitWidth = 273
      ExplicitHeight = 94
      object RzSplitter1: TRzSplitter
        Left = 1
        Top = 1
        Width = 523
        Height = 463
        Position = 229
        Percent = 44
        HotSpotVisible = True
        SplitterWidth = 7
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 160
        ExplicitTop = 184
        ExplicitWidth = 200
        ExplicitHeight = 100
        BarSize = (
          229
          0
          236
          463)
        UpperLeftControls = (
          ListBoxFiles)
        LowerRightControls = (
          Panel4)
        object ListBoxFiles: TListBox
          Left = 0
          Top = 0
          Width = 229
          Height = 463
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
          OnClick = ListBoxFilesClick
          ExplicitLeft = -60
          ExplicitWidth = 160
          ExplicitHeight = 100
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 287
          Height = 463
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 100
          ExplicitHeight = 100
          object LabelFile: TLabel
            Left = 1
            Top = 1
            Width = 285
            Height = 13
            Align = alTop
            Caption = '-'
            ExplicitWidth = 4
          end
          object MemoFile: TMemo
            AlignWithMargins = True
            Left = 4
            Top = 17
            Width = 279
            Height = 442
            Align = alClient
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
      end
    end
    object Label2: TLabel
      Left = 0
      Top = 41
      Width = 313
      Height = 13
      Align = alTop
      Caption = 'Replace Text:'
      ExplicitWidth = 67
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 313
      Height = 41
      Align = alTop
      TabOrder = 0
      ExplicitWidth = 558
      object ButtonRplc: TButton
        Left = 8
        Top = 9
        Width = 75
        Height = 25
        Caption = 'Replace'
        TabOrder = 0
        OnClick = ButtonRplcClick
      end
      object ButtonSaveFile: TButton
        Left = 89
        Top = 9
        Width = 75
        Height = 25
        Caption = 'Save'
        TabOrder = 1
        OnClick = ButtonSaveFileClick
      end
      object ButtonRplcAllSave: TButton
        Left = 185
        Top = 9
        Width = 120
        Height = 25
        Caption = 'Replace All && Save'
        TabOrder = 2
        OnClick = ButtonRplcAllSaveClick
      end
    end
    object MemoRplc: TMemo
      AlignWithMargins = True
      Left = 3
      Top = 57
      Width = 307
      Height = 411
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
end

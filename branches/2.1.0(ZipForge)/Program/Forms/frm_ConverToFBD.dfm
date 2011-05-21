object frmConvertToFBD: TfrmConvertToFBD
  Left = 0
  Top = 0
  ActiveControl = edPublisher
  BorderStyle = bsDialog
  Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077' '#1074' FBD'
  ClientHeight = 460
  ClientWidth = 586
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object RzPanel1: TPanel
    Left = 0
    Top = 0
    Width = 586
    Height = 419
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object RzLabel1: TLabel
      Left = 207
      Top = 283
      Width = 55
      Height = 13
      Caption = #1040#1085#1085#1086#1090#1072#1094#1080#1103
    end
    object lblAuthor: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 8
      Width = 81
      Height = 13
      Caption = #1040#1074#1090#1086#1088#1099' '#1082#1085#1080#1075#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTitle: TLabel
      Left = 12
      Top = 27
      Width = 80
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1082#1085#1080#1075#1080
    end
    object mmAnnotation: TMemo
      Left = 207
      Top = 302
      Width = 372
      Height = 115
      ScrollBars = ssBoth
      TabOrder = 4
      WordWrap = False
    end
    object RzGroupBox2: TGroupBox
      Left = 207
      Top = 48
      Width = 372
      Height = 73
      Caption = #1048#1079#1076#1072#1090#1077#1083#1100
      TabOrder = 2
      object RzLabel4: TLabel
        Left = 10
        Top = 45
        Width = 27
        Height = 13
        Caption = 'ISBN:'
        FocusControl = edISBN
      end
      object RzLabel6: TLabel
        Left = 222
        Top = 18
        Width = 35
        Height = 13
        Caption = #1043#1086#1088#1086#1076':'
        FocusControl = edCity
      end
      object RzLabel7: TLabel
        Left = 306
        Top = 45
        Width = 23
        Height = 13
        Caption = #1043#1086#1076':'
        FocusControl = edYear
      end
      object RzLabel5: TLabel
        Left = 10
        Top = 18
        Width = 52
        Height = 13
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
        FocusControl = edPublisher
      end
      object edISBN: TEdit
        Left = 43
        Top = 42
        Width = 251
        Height = 21
        TabOrder = 2
      end
      object edPublisher: TEdit
        Left = 68
        Top = 15
        Width = 142
        Height = 21
        TabOrder = 0
      end
      object edYear: TEdit
        Left = 335
        Top = 42
        Width = 28
        Height = 21
        TabOrder = 3
      end
      object edCity: TEdit
        Left = 263
        Top = 15
        Width = 100
        Height = 21
        TabOrder = 1
      end
    end
    object btnOpenBook: TButton
      Left = 489
      Top = 14
      Width = 90
      Height = 25
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1082#1085#1080#1075#1091
      Caption = #1054#1090#1082#1088#1099#1090#1100
      ImageIndex = 2
      Images = ilButtonImages
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnOpenBookClick
    end
    object RzGroupBox3: TGroupBox
      Left = 4
      Top = 48
      Width = 198
      Height = 369
      Caption = #1054#1073#1083#1086#1078#1082#1072
      TabOrder = 1
      object FCover: TImage
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 188
        Height = 312
        Hint = #1054#1073#1083#1086#1078#1082#1072
        Align = alTop
        Center = True
        ParentShowHint = False
        Proportional = True
        ShowHint = True
        Stretch = True
      end
      object btnPasteCover: TButton
        Left = 103
        Top = 336
        Width = 90
        Height = 25
        Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1080#1079' '#1073#1091#1092#1077#1088#1072
        Caption = #1048#1079' '#1073#1091#1092#1077#1088#1072
        ImageIndex = 0
        Images = ilButtonImages
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnPasteCoverClick
      end
      object btnLoad: TButton
        Left = 7
        Top = 336
        Width = 90
        Height = 25
        Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
        Caption = #1048#1079' '#1092#1072#1081#1083#1072
        ImageIndex = 1
        Images = ilButtonImages
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnLoadClick
      end
    end
    object alFBDAuthors: TFBDAuthorTable
      Left = 207
      Top = 127
      Width = 372
      Height = 150
      TabOrder = 3
      DesignSize = (
        372
        150)
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 419
    Width = 586
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnSave: TButton
      Left = 423
      Top = 10
      Width = 75
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Default = True
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnCancel: TButton
      Left = 504
      Top = 10
      Width = 75
      Height = 25
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnPrevious: TButton
      Left = 7
      Top = 10
      Width = 75
      Height = 25
      Hint = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#13#1082#1085#1080#1075#1072
      Caption = #1053#1072#1079#1072#1076
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnPreviousClick
    end
    object btnNext: TButton
      Left = 88
      Top = 10
      Width = 75
      Height = 25
      Hint = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#13#1082#1085#1080#1075#1072
      Caption = #1042#1087#1077#1088#1077#1076
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnNextClick
    end
  end
  object ilButtonImages: TImageList
    ColorDepth = cd32Bit
    Left = 344
    Top = 256
    Bitmap = {
      494C010103000800D00010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000838383FF838383FF828282FF828282FF818181FF808080FF808080FF7E7E
      7EFF7D7D7DFF7D7D7DFF7D7D7DFF00000000336073C0448099FF448099FF4480
      99FF448099FF448099FF448099FF448099FF224354FF31617BFF31617BFF325A
      70FF354650FF2A4759EF000000000000000000000000676767FF676767FF6767
      67FF666666FF666666FF666666FF666666FF666666FF656565FF656565FF6565
      65FF656565FF656565FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003B80AAFF3B80AAFF3B80
      AAFF929292FFF9F9F9FFF2F2F2FFF3F3F3FFF3F3F3FFF3F3F3FFF2F2F2FFF2F2
      F2FFF2F2F2FFF8F8F8FF8C8C8CFF000000005595AEFF6AB5D3FF6AB5D3FF6AB5
      D3FF6AB5D3FF6AB5D3FF6AB5D3FF6AB5D3FF31637AFF4A9DC4FF4A9DC4FF406D
      85FFEEA97EFF405B6BFF000000000000000000000000757575FFFCFCFCFF98A9
      CBFFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF6F6F6FFF6F6F6FFF6F6
      F6FFFCFCFCFF737373FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003B80AAFF67B1CFFF69B3
      D1FF9D9D9DFFF3F3F3FFE8E8E8FFE9E9E9FFE9E9E9FFE9E9E9FFE8E8E8FFE7E7
      E7FFE6E6E6FFF2F2F2FF999999FF000000005A99B2FF6DB9D6FF6DB9D6FF6DB9
      D6FF6DB9D6FF6DB9D6FF6DB9D6FF6DB9D6FF6B8B9AFFCCCCCCFFCCCCCCFF467B
      95FFEEA97EFF45687DFF000000000000000000000000818181FF7C7C7DFF98A9
      CBFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B0
      8CFFD9B08CFF7E7E7EFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003B80AAFF69B4D2FF6BB6
      D3FFA7A7A7FFF5F5F5FFECECECFFECECECFFECECECFFECECECFFECECECFFEBEB
      EBFFE9E9E9FFF4F4F4FFA3A3A3FF000000005F9DB5FF70BDD9FF70BDD9FF70BD
      D9FF70BDD9FF70BDD9FF70BDD9FF70BDD9FF7696A4FFE4E4E4FFCCCCCCFF508A
      A5FFE4E4E4FF4B7188FF0000000000000000000000008B8B8BFFF8F8F8FF98A9
      CBFFE5E5E5FFE5E5E5FFE5E5E5FFE5E5E5FFE3E3E3FFE2E2E2FFE1E1E1FFE0E0
      E0FFF7F7F7FF8A8A8AFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004186AEFF6CB7D4FF6DBA
      D5FFAEAEAEFFF7F7F7FFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEEEEEEFFEEEE
      EEFFECECECFFF5F5F5FFACACACFF0000000064A1B8FF73C1DCFF73C1DCFF73C1
      DCFF73C1DCFF73C1DCFF73C1DCFF73C1DCFF7B9297FFE9D0B9FFCCCCCCFF548D
      A8FFE4E4E4FF50788DFF000000000000000000000000959595FFD9B08CFF98A9
      CBFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B0
      8CFFD9B08CFF929292FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000488CB3FF6EBBD6FF6FBD
      D8FFB4B4B4FFF8F8F8FFF1F1F1FFF2F2F2FFF2F2F2FFF2F2F2FFF1F1F1FFF0F0
      F0FFEFEFEFFFF6F6F6FFB2B2B2FF0000000069A6BBFF76C5DFFF76C5DFFF76C5
      DFFF76C5DFFF76C5DFFF76C5DFFF76C5DFFF7D9CA9FFE7E7E7FFCCCCCCFF5791
      ABFFE4E4E4FF567E92FF0000000000000000000000009A9A9AFFFAFAFAFF98A9
      CBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEAEAEAFFEAEAEAFFE9E9E9FFE6E6
      E6FFF8F8F8FF999999FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004D91B7FF70BED8FF71C0
      DAFFB9B9B9FFF9F9F9FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF3F3F3FFF2F2
      F2FFF1F1F1FFF7F7F7FFB7B7B7FF000000006EAABFFF79CAE2FF79CAE2FF79CA
      E2FF79CAE2FF79CAE2FF79CAE2FF76C5DFFF82969BFFE9D0B9FFCCCCCCFF5B95
      AEFFE4E4E4FF5D8597FF000000000000000000000000A1A1A1FFD9B08CFF98A9
      CBFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B0
      8CFFD9B08CFFA0A0A0FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000569BBFFF72C1DBFF74C3
      DDFFBBBBBBFFFAFAFAFFF6F6F6FFF6F6F6FFF7F7F7FFF6F6F6FFF6F6F6FFF5F5
      F5FFF3F3F3FFF8F8F8FFBABABAFF0000000073AFC2FF7CCFE5FF7CCFE5FF7CCF
      E5FF7CCFE5FF7CCFE5FF7CCFE5FF7CCFE5FF6D93A3FF8DB2C2FFCCCCCCFF62A7
      C4FF689AAFFF5D7E8CEF000000000000000000000000A5A5A5FF7C7C7DFF98A9
      CBFFF0F0F0FFF2F2F2FFF2F2F2FFF0F0F0FFF0F0F0FFEFEFEFFFEEEEEEFFEDED
      EDFFFAFAFAFFA5A5A5FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005DA1C3FF74C4DEFF76C6
      E0FFBEBEBEFFFBFBFBFFF8F8F8FFF8F8F8FFF8F8F8FFF8F8F8FFF7F7F7FFF6F6
      F6FFF5F5F5FFF9F9F9FFBDBDBDFF0000000078B3C5FF80D3E8FF80D3E8FF80D3
      E8FF80D3E8FF80D3E8FF80D3E8FF80D3E8FF83C1D6FF789FAEFF90AAB5FF74B5
      D2FF6F97A7FF0E121420000000000000000000000000A9A9A9FFD9B08CFF98A9
      CBFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B0
      8CFFD9B08CFFA7A7A7FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000062A7C8FF76C7E0FF78C9
      E2FFBFBFBFFFFCFCFCFFF9F9F9FFFAFAFAFFFAFAFAFFFAFAFAFFF9F9F9FFF8F8
      F8FFF6F6F6FFFAFAFAFFBFBFBFFF000000007DB7C9FF83D7EBFF83D7EBFF83D7
      EBFF83D7EBFF83D7EBFF83D7EBFF83D7EBFF83D7EBFF82CADCFF8FA5AEFF7CB3
      CAFF6F97A7FF00000000000000000000000000000000ABABABFFFCFCFCFF98A9
      CBFFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF4F4F4FFF3F3F3FFF2F2F2FFF0F0
      F0FFFBFBFBFFABABABFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006AAFCEFF79CAE2FF7ACC
      E4FFC0C0C0FFFCFCFCFFFAFAFAFFFBFBFBFFFBFBFBFFFBFBFBFFFAFAFAFFC6C6
      C6FFC4C4C4FFCDCDCDFFBFBFBFFF0000000083BCCDFF86DBEEFF86DBEEFF86DB
      EEFF86DBEEFF86DBEEFF86DBEEFF86DBEEFF86DBEEFF86DBEEFF92A6AFFF87B9
      D0FF6F97A7FF00000000000000000000000000000000ACACACFFD9B08CFF98A9
      CBFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B0
      8CFFD9B08CFFACACACFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006BB1CFFF7BCDE5FF7CCF
      E6FFC0C0C0FFFDFDFDFFFBFBFBFFFBFBFBFFFCFCFCFFFBFBFBFFFBFBFBFFCBCB
      CBFFEEEEEEFFC9C9C9FF7777779F0000000087C0D0FF89DFF1FF89DFF1FF89DF
      F1FF89DFF1FF89DFF1FF89DFF1FF89DFF1FF89DFF1FF89DFF1FF87A0AAFF90BF
      D4FF6F97A7FF00000000000000000000000000000000ADADADFFFCFCFCFF98A9
      CBFFF8F8F8FFF8F8F8FFFAFAFAFFF8F8F8FFF8F8F8FFF7F7F7FFF6F6F6FFF3F3
      F3FFFCFCFCFFADADADFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006CB2D0FF7DD0E7FFA0A3
      A4FF929596FF8B8E8FFF848788FF848788FF7C8081FF7C8081FF7C8081FFE9E9
      E9FFCACACAFF7777779F00000000000000008CC4D3FF8CE3F4FF8CE3F4FF8CE3
      F4FF8CE3F4FF8CE3F4FF8CE3F4FF8CE3F4FF8CE3F4FF8CE3F4FF8AA1ABFF98C5
      D9FF6F97A7FF00000000000000000000000000000000AFAFAFFFD9B08CFF98A9
      CBFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFD9B08CFFAFAFAFFFBCBC
      BCFFD0D0D0FFA2A2A2EF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006DB3D0FF80D3E9FF81BA
      C9FF848686FF8B8D8EFF9EA3A4FFA5ADAEFF8F9292FF848586FFAAAAAAFFC0C0
      C0FF93B2C0FF00000000000000000000000091C9D7FF8FE7F8FF8FE7F8FF8FE7
      F8FF8FE7F8FF8FE7F8FF8FE7F8FF8FE7F8FF8FE7F8FF8FE7F8FF8DA3ACFFA0CB
      DDFF6F97A7FF00000000000000000000000000000000AFAFAFFF7C7C7DFF98A9
      CBFFFAFAFAFFFBFBFBFFFBFBFBFFFBFBFBFFFAFAFAFFF8F8F8FFBCBCBCFFD9D9
      D9FFA4A4A4EF2121213000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006EB4D1FF82D6ECFF84D8
      EDFF898A8AFFBFC3C4FFB6BBBCFFC8D0D1FFC1C5C6FF828383FF8EE8F9FF90EA
      FAFF50A2C5FF00000000000000000000000096CEDAFF92EBFBFF92EBFBFF92EB
      FBFF92EBFBFF92EBFBFF92EBFBFF92EBFBFF92EBFBFF92EBFBFF6D8F9DFFA7CF
      E0FF6F97A7FF00000000000000000000000000000000AFAFAFFFFFFFFFFF98A9
      CBFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFF8F8F8FFD0D0D0FFA4A4
      A4EF212121300000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006FB6D2FF6FB6D2FF70B7
      D3FF6C8F9EFF7296A4FF849298FF86959BFF6B8F9DFF6D929FFF72BBD7FF65B4
      D2FF5BABCBFF000000000000000000000000759EA5C09BD2DDFF9BD2DDFF9BD2
      DDFF9BD2DDFF9BD2DDFF9BD2DDFF9BD2DDFF9BD2DDFF9BD2DDFF879FA9FF729A
      A7E0384C548000000000000000000000000000000000AFAFAFFFAFAFAFFFAFAF
      AFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFA4A4A4EF2121
      2130000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object FBD: TFBDDocument
    Memo = mmAnnotation
    Image = FCover
    Left = 288
    Top = 256
  end
end

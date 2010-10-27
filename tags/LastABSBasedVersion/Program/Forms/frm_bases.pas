(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2010 Aleksey Penkov
  *
  * Authors Aleksey Penkov   alex.penkov@gmail.com
  *         Nick Rymanov     nrymanov@gmail.com
  * Created                  22.02.2010
  * Description              ����� �������������� ������� ���������
  *
  * $Id$
  *
  * History
  *
  ****************************************************************************** *)

{
TODO -oNickR : ��������, ����� ����� �������� �������� ����������. ������, �������� ������ ���������� � ������������� ����������
}

unit frm_bases;

interface

uses
  Windows,
  Messages,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  unit_StaticTip,
  unit_AutoCompleteEdit,
  ComCtrls,
  unit_Interfaces;

type
  TfrmBases = class(TForm)
    pcCollectionInfo: TPageControl;
    tsGeneralInfo: TTabSheet;
    tsConnectionInfo: TTabSheet;
    cbRelativePath: TCheckBox;
    MHLStaticTip1: TMHLStaticTip;
    edDescription: TEdit;
    lblCollectionDescription: TLabel;
    lblCollectionRoot: TLabel;
    edCollectionRoot: TMHLAutoCompleteEdit;
    edCollectionFile: TMHLAutoCompleteEdit;
    edCollectionName: TEdit;
    lblCollectionFile: TLabel;
    lblCollectionName: TLabel;
    btnNewFile: TButton;
    btnSelectRoot: TButton;
    lblUser: TLabel;
    edUser: TEdit;
    edPass: TEdit;
    lblPassword: TLabel;
    edURL: TEdit;
    lblURL: TLabel;
    lblScript: TLabel;
    mmScript: TMemo;
    pnButtons: TPanel;
    btnOk: TButton;
    btnCancel: TButton;

    procedure FormShow(Sender: TObject);
    procedure edDBFileButtonClick(Sender: TObject);
    procedure edDBFolderButtonClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);

  private
    CollectionID: Integer;
    FSystemData: ISystemData;

    function GetDisplayName: string;
    procedure SetDisplayName(const Value: string);
    function GetDBFileName: string;
    procedure SetDBFileName(const Value: string);
    function GetRootFolder: string;
    procedure SetRootFolder(const Value: string);
    function GetDescription: string;
    procedure SetDescription(const Value: string);
    function GetPass: string;
    function GetScript: string;
    function GetURL: string;
    function GetUser: string;
    procedure SetPass(const Value: string);
    procedure SetScript(const Value: string);
    procedure SetURL(const Value: string);
    procedure SetUser(const Value: string);

    property DisplayName: string read GetDisplayName write SetDisplayName;
    property DBFileName: string read GetDBFileName write SetDBFileName;
    property RootFolder: string read GetRootFolder write SetRootFolder;
    property Description: string read GetDescription write SetDescription;
    property URL: string read GetURL write SetURL;
    property User: string read GetUser write SetUser;
    property Pass: string read GetPass write SetPass;
    property Script: string read GetScript write SetScript;
  public

  end;

var
  frmBases: TfrmBases;

implementation

uses
  SysUtils,
  unit_Helpers,
  unit_Consts,
  unit_Errors,
  unit_Globals,
  unit_SystemDatabase;

resourcestring
  rstrChooseDataFolder = '�������� ����� ��� ���������� ������';

{$R *.dfm}

procedure TfrmBases.FormShow(Sender: TObject);
var
  CollectionInfo: TCollectionInfo;
begin
  FSystemData := GetSystemData;
  CollectionInfo := FSystemData.GetActiveCollectionInfo;

  CollectionID := CollectionInfo.ID;

  DisplayName := CollectionInfo.Name;
  DBFileName := CollectionInfo.DBFileName;
  RootFolder := CollectionInfo.RootFolder;
  Description := CollectionInfo.Notes;
  URL := CollectionInfo.URL;
  Pass := CollectionInfo.Password;
  User := CollectionInfo.User;
  Script := CollectionInfo.Script;
end;

function TfrmBases.GetDisplayName: string;
begin
  Result := Trim(edCollectionName.Text);
end;

procedure TfrmBases.SetDisplayName(const Value: string);
begin
  edCollectionName.Text := Value;
end;

function TfrmBases.GetPass: string;
begin
  Result := edPass.Text;
end;

procedure TfrmBases.SetPass(const Value: string);
begin
  edPass.Text := Value;
end;

function TfrmBases.GetDBFileName: string;
begin
  Result := Trim(edCollectionFile.Text);
end;

function TfrmBases.GetDescription: string;
begin
  Result := Trim(edDescription.Text);
end;

procedure TfrmBases.SetDescription(const Value: string);
begin
  edDescription.Text := Value;
end;

procedure TfrmBases.SetDBFileName(const Value: string);
begin
  edCollectionFile.Text := Value;
end;

function TfrmBases.GetRootFolder: string;
begin
  Result := Trim(edCollectionRoot.Text);
end;

procedure TfrmBases.SetRootFolder(const Value: string);
begin
  edCollectionRoot.Text := Value;
end;

function TfrmBases.GetScript: string;
begin
  Result := mmScript.Lines.Text;
end;

procedure TfrmBases.SetScript(const Value: string);
begin
  mmScript.Lines.Text := Value;
end;

function TfrmBases.GetURL: string;
begin
  Result := edURL.Text;
end;

procedure TfrmBases.SetURL(const Value: string);
begin
  edURL.Text := Value;
end;

function TfrmBases.GetUser: string;
begin
  Result := edUser.Text;
end;

procedure TfrmBases.SetUser(const Value: string);
begin
  edUser.Text := Value;
end;

procedure TfrmBases.edDBFileButtonClick(Sender: TObject);
var
  AFileName: string;
begin
  { TODO -oNickR -cBug : ���������� ��������� ������, ����� ������ ����� ������ ����� ������ ����� }
  if GetFileName(fnOpenCollection, AFileName) then
    edCollectionFile.Text := AFileName;
end;

procedure TfrmBases.edDBFolderButtonClick(Sender: TObject);
var
  AFolder: string;
begin
  AFolder := edCollectionRoot.Text;
  if GetFolderName(Handle, rstrChooseDataFolder, AFolder) then
    edCollectionRoot.Text := AFolder;
end;

procedure TfrmBases.btnSaveClick(Sender: TObject);
var
  ADBFileName: string;
  ARootFolder: string;
  CollectionInfo: TCollectionInfo;
begin
  if (DisplayName = '') or (DBFileName = '') or (RootFolder = '') then
  begin
    MessageDlg(rstrAllFieldsShouldBeFilled, mtError, [mbOk], 0);
    Exit;
  end;

  //
  // �������� �������� ���������
  //
  if FSystemData.FindCollectionWithProp(cpDisplayName, DisplayName, CollectionID) then
  begin
    MessageDlg(Format(rstrCollectionAlreadyExists, [DisplayName]), mtError, [mbOk], 0);
    Exit;
  end;

  //
  // TODO -oNickR -cBug: � �������� �������� �������� ���������� ������������ DataPath
  //
  if not cbRelativePath.Checked then
  begin
    ADBFileName := ExpandFileName(DBFileName);
    if '' = ExtractFileExt(ADBFileName) then
      ADBFileName := ChangeFileExt(ADBFileName, COLLECTION_EXTENSION);

    ARootFolder := ExcludeTrailingPathDelimiter(ExpandFileName(RootFolder));
  end
  else
  begin
    ADBFileName := DBFileName;
    if '' = ExtractFileExt(ADBFileName) then
      ADBFileName := ChangeFileExt(ADBFileName, COLLECTION_EXTENSION);

    ARootFolder := ExcludeTrailingPathDelimiter(RootFolder);
  end;

  //
  // �������� �������� � ������������� �����
  //
  if not FileExists(ADBFileName) then
  begin
    MessageDlg(Format(rstrFileDoesntExists, [ADBFileName]), mtError, [mbOk], 0);
    Exit;
  end;

  if FSystemData.FindCollectionWithProp(cpFileName, ADBFileName, CollectionID) then
  begin
    MessageDlg(Format(rstrFileAlreadyExistsInDB, [ADBFileName]), mtError, [mbOk], 0);
    Exit;
  end;

  CollectionInfo := TCollectionInfo.Create;
  try
    FSystemData.GetCollectionInfo(CollectionID, CollectionInfo);
    CollectionInfo.Name := DisplayName;
    CollectionInfo.RootFolder := ARootFolder;
    CollectionInfo.DBFileName := ADBFileName;
    CollectionInfo.Notes := Description;
    CollectionInfo.URL := URL;
    CollectionInfo.User := User;
    CollectionInfo.Password := Pass;
    CollectionInfo.Script := Script;

    FSystemData.UpdateCollectionInfo(CollectionInfo);
  finally
    FreeAndNil(CollectionInfo);
  end;

  ModalResult := mrOk;
end;

end.

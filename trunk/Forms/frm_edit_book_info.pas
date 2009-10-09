
{******************************************************************************}
{                                                                              }
{                                 MyHomeLib                                    }
{                                                                              }
{                                Version 0.9                                   }
{                                20.08.2008                                    }
{                    Copyright (c) Aleksey Penkov  alex.penkov@gmail.com       }
{                                                                              }
{******************************************************************************}


unit frm_edit_book_info;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzShellDialogs, RzCommon, RzSelDir, RzPanel, RzRadGrp, StdCtrls,
  Mask, RzEdit, RzDBEdit, RzDBBnEd, RzButton, ExtCtrls, ComCtrls, RzListVw, VirtualTrees,
  RzCmboBx;

type
  TfrmEditBookInfo = class(TForm)
    RzPanel1: TRzPanel;
    RzPanel3: TRzPanel;
    btnSave: TRzBitBtn;
    btnCancel: TRzBitBtn;
    RzGroupBox4: TRzGroupBox;
    edSN: TRzNumericEdit;
    RzGroupBox2: TRzGroupBox;
    edT: TEdit;
    RzGroupBox1: TRzGroupBox;
    lvAuthors: TRzListView;
    btnADelete: TRzBitBtn;
    btnAChange: TRzBitBtn;
    btnAddAuthor: TRzBitBtn;
    RzGroupBox5: TRzGroupBox;
    lblGenre: TLabel;
    btnGenres: TButton;
    cbSeries: TRzComboBox;
    RzGroupBox3: TRzGroupBox;
    edKeyWords: TEdit;
    RzGroupBox6: TRzGroupBox;
    cbLang: TRzComboBox;
    Button1: TButton;
    Button2: TButton;
    procedure btnGenresClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAddAuthorClick(Sender: TObject);
    procedure btnAChangeClick(Sender: TObject);
    procedure btnADeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure edTChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FChanged : boolean;

    procedure FillLists;
    function SaveData: boolean;
    { Private declarations }
  public
//     procedure FillGenrelist;
  end;

var
  frmEditBookInfo: TfrmEditBookInfo;

implementation

uses
  dm_collection,
  unit_database,
  dm_user,
  frm_genre_tree,
  unit_globals,
  frm_main,
  frm_edit_author;

{$R *.dfm}

procedure TfrmEditBookInfo.btnGenresClick(Sender: TObject);
var
  Data:PGenreData;
  Node:PVirtualNode;
begin
  if frmGenreTree.ShowModal=mrOk then
  begin
    lblGenre.Caption:='';
    Node:=frmGenreTree.tvGenresTree.GetFirstSelected;
    while Node<>nil do
    begin
      Data:=frmGenreTree.tvGenresTree.GetNodeData(Node);
      lblGenre.Caption:=lblGenre.Caption+Data.Text+' ; ';
      Node:=frmGenreTree.tvGenresTree.GetNextSelected(Node);
    end;
    FChanged := True;
  end;
end;

procedure TfrmEditBookInfo.FillLists;
begin
  cbSeries.Items.Clear;
  dmCollection.tblSeries.First;
  dmCollection.tblSeries.Next;
  while not dmCollection.tblSeries.eof do
  begin
    cbSeries.Items.Add(dmCollection.tblSeries['S_Title']);
    dmCollection.tblSeries.Next;
  end;
end;

procedure TfrmEditBookInfo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Dummy : boolean;
begin
  if Key = VK_F1 then   frmMain.HH(0,0,Dummy);
end;

procedure TfrmEditBookInfo.FormShow(Sender: TObject);
begin
  FChanged := False;
  if frmGenreTree.tvGenresTree.GetFirstSelected=nil then frmMain.FillGenresTree(frmGenreTree.tvGenresTree);
  FillLists;
end;


function TfrmEditBookInfo.SaveData: boolean;
begin
  Result := False;
  if not FChanged then
  begin
    Result := True;
    Exit;
  end;

  if lvAuthors.Items.Count=0 then
  begin
    MessageDlg('������� ������� ������ ������!',mtError,[mbOk],0);
    Exit;
  end;
  if edT.Text='' then
  begin
    MessageDlg('������� �������� �����!',mtError,[mbOk],0);
    Exit;
  end;
  Result := True;
end;

procedure TfrmEditBookInfo.btnADeleteClick(Sender: TObject);
begin
  lvAuthors.DeleteSelected;
end;

procedure TfrmEditBookInfo.btnAddAuthorClick(Sender: TObject);
var
  Family:TListItem;
begin
  frmEditAuthor.edFamily.Clear;
  frmEditAuthor.edName.Clear;
  frmEditAuthor.edMiddle.Clear;
  if frmEditAuthor.ShowModal=mrOk then
  begin
    Family:=lvAuthors.Items.Add;
    Family.Caption:=frmEditAuthor.edFamily.Text;
    Family.SubItems.Add(frmEditAuthor.edName.Text);
    Family.SubItems.Add(frmEditAuthor.edMiddle.Text);
    FChanged := True;
  end;
end;

procedure TfrmEditBookInfo.btnAChangeClick(Sender: TObject);
var
  Family:TListItem;
begin
  Family:=lvAuthors.Selected;
  if Family=nil then Exit;

  frmEditAuthor.edFamily.Text:=Family.Caption;
  if Family.SubItems.Count>0 then frmEditAuthor.edName.Text:=Family.SubItems[0];
  if Family.SubItems.Count>1 then frmEditAuthor.edMiddle.Text:=Family.SubItems[1];
  if frmEditAuthor.ShowModal=mrOk then
  begin
    Family.Caption:=frmEditAuthor.edFamily.Text;
    if Family.SubItems.Count>0 then Family.SubItems[0]:=frmEditAuthor.edName.Text
      else Family.SubItems.Add(frmEditAuthor.edName.Text);
    if Family.SubItems.Count>1 then Family.SubItems[1]:=frmEditAuthor.edMiddle.Text
       else Family.SubItems.Add(frmEditAuthor.edMiddle.Text);
    FChanged := True;
  end;
end;

procedure TfrmEditBookInfo.btnSaveClick(Sender: TObject);
begin
  if SaveData then
    ModalResult := mrOk;
end;

procedure TfrmEditBookInfo.Button1Click(Sender: TObject);
begin
  if SaveData then
  begin
    frmMain.SelectNextBook(FChanged,True);
    FChanged := False;
  end;
end;

procedure TfrmEditBookInfo.Button2Click(Sender: TObject);
begin
  if SaveData then
  begin
    frmMain.SelectNextBook(FChanged, False);
    FChanged := False;
  end;
end;

procedure TfrmEditBookInfo.edTChange(Sender: TObject);
begin
  FChanged := True;
end;

end.

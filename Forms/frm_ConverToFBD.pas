unit frm_ConverToFBD;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  StdCtrls,
  RzLabel,
  Mask,
  RzEdit,
  Buttons,
  ExtCtrls,
  RzPanel,
  fictionbook_21,
  dm_Collection,
  unit_Globals;

type
  TfrmConvertToFBD = class(TForm)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    mmAnnotation: TMemo;
    FCover: TImage;
    BitBtn1: TBitBtn;
    btnPasteCover: TBitBtn;
    btnSave: TBitBtn;
    RzGroupBox1: TRzGroupBox;
    edFirstName: TRzEdit;
    RzLabel2: TRzLabel;
    edMiddleName: TRzEdit;
    RzLabel3: TRzLabel;
    edLastName: TRzEdit;
    RzLabel8: TRzLabel;
    edNickName: TRzEdit;
    RzLabel9: TRzLabel;
    RzLabel1: TRzLabel;
    RzGroupBox2: TRzGroupBox;
    RzLabel4: TRzLabel;
    edISBN: TRzEdit;
    edPublisher: TRzEdit;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    edYear: TRzEdit;
    edSity: TRzEdit;
    RzLabel5: TRzLabel;
    BitBtn2: TBitBtn;
    procedure btnPasteCoverClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    FLines: TStringList;
    FBD: IXMLFictionBook;

    FBookFileName: string;
    FFBDFileName: string;

    FBookRecord: TBookRecord;
    FileName : string;
    FFolder: string;

    function MakeFBD:boolean;
    function CreateZip:boolean;
    procedure ChangeBookData;
    procedure ResizeImage;

  public
    { Public declarations }
  end;

var
  frmConvertToFBD: TfrmConvertToFBD;

implementation

uses
  EncdDecd,
  jpeg,
  pngimage,
  Clipbrd,
  XMLDoc,
  frm_Main,
  ZipForge,
  dm_user,
  unit_Helpers;

{$R *.dfm}

procedure TfrmConvertToFBD.BitBtn1Click(Sender: TObject);
var
  Input, Output: TMemoryStream;
  IMG: TGraphic;

  FileName,Ext : string;


begin
   if not GetFileName(fnOpenCoverImage,FileName) then Exit;

   Output := TMemoryStream.Create;
   Input := TMemoryStream.Create;

   Input.LoadFromFile(Filename);
   EncodeStream(Input, Output);

   FLines.Clear;
   Output.Seek(0,soFromBeginning);
   FLines.LoadFromStream(Output);

   Ext := LowerCase(ExtractFileExt(Filename));
   try
     if Ext = '.png' then
          IMG := TPngImage.Create
     else
       if (Ext = '.jpg') or (Ext = '.jpeg') then
              IMG := TJPEGImage.Create;
     if Assigned(IMG) then
     begin
       Input.Seek(0,soFromBeginning);
       IMG.LoadFromStream(Input);
       FCover.Picture.Assign(IMG);
       FCover.Invalidate;
    end;
  finally
    IMG.Free;
    Output.Free;
    Input.Free;
  end;
//  ResizeImage;
end;

procedure TfrmConvertToFBD.BitBtn2Click(Sender: TObject);
begin
  frmMain.tbtbnReadClick(Sender);
end;

procedure TfrmConvertToFBD.btnPasteCoverClick(Sender: TObject);
var
  s : string;
  Icon: TJPEGImage;
  Input, Output: TMemoryStream;
  IMG: TGraphic;
begin
 Output := TMemoryStream.Create;
 Input := TMemoryStream.Create;

 IMG := TJPEGImage.Create;
 try
   FCover.Picture.RegisterClipboardFormat(cf_BitMap,TJPEGImage);
   FCover.Picture.Bitmap.LoadFromClipBoardFormat(cf_BitMap,ClipBoard.GetAsHandle(cf_Bitmap),0);

   ResizeImage;

   IMG.Assign(FCover.Picture.Bitmap);
   IMG.SaveToStream(Input);

   Input.Seek(0,soFromBeginning);
   EncodeStream(Input,Output);
   FLines.Clear;
   Output.Seek(0,soFromBeginning);
   FLines.LoadFromStream(Output);
 finally
   Output.Free;
   Input.Free;
   IMG.Free;
 end;
end;

procedure TfrmConvertToFBD.btnSaveClick(Sender: TObject);
begin
  if MakeFBD then
   if CreateZip then
     ChangeBookData;
  Modalresult := mrOk;
end;

procedure TfrmConvertToFBD.ChangeBookData;
begin
  DMCollection.ActiveTable.Edit;
  DMCollection.ActiveTable.FieldByName('Ext').Value := '.zip';
  DMCollection.ActiveTable.Post;
end;

function TfrmConvertToFBD.CreateZip:boolean;
var
  Zip: TZipForge;
begin
  Result := False;
  Zip := TZipForge.Create(nil);
  try
    zip.FileName := ChangeFileExt(FBookFileName,'.zip');
    zip.OpenArchive(fmCreate);
    zip.BaseDir := ExtractFilePath(zip.FileName);
    zip.AddFiles(FBookrecord.FileName + FBookrecord.FileExt);
    zip.AddFiles(FBookrecord.FileName + '.fbd');
    zip.CloseArchive;
    Result := True;
    DeleteFile(FFBDFileName);
    DeleteFile(FBookFileName);
  finally
    Zip.Free;
  end;
end;

procedure TfrmConvertToFBD.FormCreate(Sender: TObject);
begin
  FLines := TStringList.Create;
end;

procedure TfrmConvertToFBD.FormDestroy(Sender: TObject);
begin
  FLines.Free;
end;

procedure TfrmConvertToFBD.FormShow(Sender: TObject);
begin
  DMCollection.GetCurrentBook(FBookRecord);

  FBookFileName := DMUser.ActiveCollection.RootFolder + FBookRecord.Folder + '\'
                   + FBookrecord.FileName + FBookrecord.FileExt;

  FFBDFilename := ChangeFileExt(FBookFileName,'.fbd');
end;

function TfrmConvertToFBD.MakeFBD:boolean;
var
  XML : TXMLDocument;
  A: IXMLAuthorType;
  S : IXMLSequenceType;
  Bin : IXMLBinary;
  C: IXMLImageType;
  MS: TMemoryStream;
  SL: TstringList;
  Str: string;
  i: integer;
begin
  Result := False;
  MS := TMemoryStream.Create;
  SL := TStringList.Create;
  XML := TXmlDocument.Create(Self);
  XML.Active := True;
  try
    FBD := GetFictionBook(XML);

    XML.Version := '1.0';
    XML.Encoding := 'UTF-8';

    with FBD.Description.Titleinfo do
    begin
      Author.Clear;
      for i := 0 to High(FBookRecord.Authors) do
      begin
        A := Author.Add;
        A.Lastname.Text := FBookRecord.Authors[i].LastName;
        A.Firstname.Text :=FBookRecord.Authors[i].FirstName;
        A.Middlename.Text :=FBookRecord.Authors[i].MiddleName;
      end;

      Booktitle.Text := FBookRecord.Title;

      Annotation.Text := mmAnnotation.Text;
      Lang := FBookRecord.Lang;
      Keywords.Text := FBookRecord.KeyWords;

      Genre.Clear;
      for i := 0 to High(FBookRecord.Genres) do
        Genre.Add(FBookRecord.Genres[i].GenreFb2Code);

      if FBookRecord.Series <> '' then
      begin
        try
          Sequence.Clear;
          S := Sequence.Add;

          S.Name := FBookRecord.Series;
          S.Number := FBookRecord.SeqNumber
        except
        end;
      end;
    end; // with Description

    with FBD.Description do
    begin
      Publishinfo.Publisher.Text := edPublisher.Text;
      Publishinfo.City.Text := edSity.Text;
      Publishinfo.Year := edYear.Text;
      Publishinfo.Isbn.Text := edISBN.Text;
    end;

    with FBD.Description do
    begin
      A := Documentinfo.Author.Add;

      A.Firstname.Text := edFirstName.Text;
      A.Middlename.Text := edMiddleName.Text;
      A.LastName.Text := edLastName.Text;
      A.Nickname.Text := edNickName.Text;

      DocumentInfo.Programused.Text := 'MyHomeLib 1.6';
      DocumentInfo.Date.Text := DateToStr(Now);
      DocumentInfo.Version := '1.0';
    end;

    if Length(FLines.Text) > 100 then
    begin
      Bin := FBD.Binary.Add;
      Bin.Id := 'cover.jpg';
      Bin.Contenttype := 'image/jpeg';
      Bin.Text := FLines.Text;
      C := FBD.Description.Titleinfo.Coverpage.Add;
    end;

    XML.SaveToStream(MS);

  //----------------------------------------------------------------------------
  //                              ������� ��� XML
    MS.Seek(0,soFromBeginning);
    SL.LoadFromStream(MS);
    Str := SL.Text;
    StrReplace('<FictionBook xmlns="http://www.gribuser.ru/xml/fictionbook/2.0">',
             '<FictionBook xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.gribuser.ru/xml/fictionbook/2.0">',
             Str);

    StrReplace('<coverpage><image/></coverpage>',
                 '<coverpage><image xlink:href="#cover.jpg"/></coverpage>',Str);
    SL.Text := Str;
    //----------------------------------------------------------------------------
    SL.SaveToFile(FFBDFileName);
    Result := True;
  finally
    SL.Free;
    MS.Free;
  end;
end;

procedure TfrmConvertToFBD.ResizeImage;
const
  maxWidth = 300;
  maxHeight = 450;
var
  thumbnail : TBitmap;
  thumbRect : TRect;
begin
    // resize

   thumbnail := TBitmap.Create;
   thumbnail.Assign(FCover.Picture.Bitmap);
   try
     thumbRect.Left := 0;
     thumbRect.Top := 0;

     //proportional resize
     if thumbnail.Width > thumbnail.Height then
     begin
       thumbRect.Right := maxWidth;
       thumbRect.Bottom := (maxWidth * thumbnail.Height) div thumbnail.Width;
     end
     else
     begin
       thumbRect.Bottom := maxHeight;
       thumbRect.Right := (maxHeight * thumbnail.Width) div thumbnail.Height;
     end;

     thumbnail.Canvas.StretchDraw(thumbRect, thumbnail) ;

     //resize image
     thumbnail.Width := thumbRect.Right;
     thumbnail.Height := thumbRect.Bottom;

     //display in a TImage control
     FCover.Picture.Assign(thumbnail) ;
   finally
     thumbnail.Free;
   end;

end;

end.
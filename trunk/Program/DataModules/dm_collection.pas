(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2010 Aleksey Penkov
  *
  * Authors Aleksey Penkov   alex.penkov@gmail.com
  *         Nick Rymanov     nrymanov@gmail.com
  *
  * History
  * NickR 02.03.2010    ��� ����������������
  *
  ****************************************************************************** *)

unit dm_collection;

interface

uses
  Classes,
  ABSMain,
  DB,
  unit_Globals;

type
  TDMCollection = class(TDataModule)
    DBCollection: TABSDatabase;
    dsAuthors: TDataSource;
    BooksByAuthor: TABSTable;
    BooksByGenre: TABSTable;
    Genres: TABSTable;
    BooksBySerie: TABSTable;
    dsSeries: TDataSource;
    BooksByAuthorID: TAutoIncField;
    BookGenres: TABSTable;
    GenreBooks: TABSTable;
    dsGenreBooks: TDataSource;
    BooksBySerieID: TAutoIncField;
    BooksBySerieSerieID: TIntegerField;
    BooksByGenreID: TAutoIncField;
    AuthorBooks: TABSTable;
    dsAuthorBooks: TDataSource;
    tblBooks: TABSTable;
    AllAuthors: TABSTable;
    BookAuthors: TABSTable;
    tblBooksID: TAutoIncField;
    tblBooksSerieID: TIntegerField;
    tblBooksSeqNumber: TSmallintField;
    tblBooksLibID: TIntegerField;
    tblBooksDate: TDateField;
    tblBooksTitle: TWideStringField;
    tblBooksInsideNo: TIntegerField;
    tblBooksFileName: TWideStringField;
    tblBooksExt: TWideStringField;
    tblBooksSize: TIntegerField;
    tblBooksCode: TSmallintField;
    tblBooksFolder: TWideStringField;
    tblBooksLocal: TBooleanField;
    tblBooksDeleted: TBooleanField;
    tblSeriesB1: TABSTable;
    Authors: TABSQuery;
    AuthorsID: TAutoIncField;
    AuthorsFamily: TWideStringField;
    AuthorsName: TWideStringField;
    AuthorsMiddle: TWideStringField;
    Series: TABSQuery;
    SeriesSerieID: TAutoIncField;
    SeriesTitle: TWideStringField;
    tblBooksLibRate: TIntegerField;
    tblBooksLang: TWideStringField;
    tblBooksKeyWords: TWideStringField;
    sqlBooks: TABSQuery;
    GenresGenreCode: TWideStringField;
    GenresParentCode: TWideStringField;
    GenresFB2Code: TWideStringField;
    GenresGenreAlias: TWideStringField;
    GenreBooksGenreCode: TWideStringField;
    GenreBooksBookID: TIntegerField;
    AuthorBooksAuthorID: TIntegerField;
    AuthorBooksBookID: TIntegerField;
    BookGenresGenreCode: TWideStringField;
    BookGenresBookID: TIntegerField;
    BookAuthorsAuthorID: TIntegerField;
    BookAuthorsBookID: TIntegerField;
    dsGenres: TDataSource;
    tblSeriesB1SerieID: TAutoIncField;
    tblSeriesB1SerieTitle: TWideStringField;
    tblBooksSeries: TWideStringField;
    sqlBooksID: TIntegerField;
    AllBooks: TABSTable;
    AllBooksBookID: TAutoIncField;
    AllBooksLibID: TIntegerField;
    AllBooksTitle: TWideStringField;
    AllBooksSerieID: TIntegerField;
    AllBooksSeqNumber: TSmallintField;
    AllBooksDate: TDateField;
    AllBooksLibRate: TIntegerField;
    AllBooksLang: TWideStringField;
    AllBooksFolder: TWideStringField;
    AllBooksFileName: TWideStringField;
    AllBooksInsideNo: TIntegerField;
    AllBooksExt: TWideStringField;
    AllBooksSize: TIntegerField;
    AllBooksCode: TSmallintField;
    AllBooksLocal: TBooleanField;
    AllBooksDeleted: TBooleanField;
    AllBooksKeyWords: TWideStringField;
    AllSeries: TABSTable;
    AllSeriesSerieID: TAutoIncField;
    AllSeriesSerieTitle: TWideStringField;
    AllExtra: TABSTable;
    AllExtraBookID: TIntegerField;
    AllExtraAnnotation: TWideMemoField;
    AllExtraReview: TWideMemoField;
    AllExtraRate: TIntegerField;
    AllExtraProgress: TIntegerField;
    AllGenres: TABSTable;
    AllGenresGenreCode: TWideStringField;
    AllGenresParentCode: TWideStringField;
    AllGenresFB2Code: TWideStringField;
    AllGenresAlias: TWideStringField;
    AllAuthorsAuthorID: TAutoIncField;
    AllAuthorsLastName: TWideStringField;
    AllAuthorsFirstName: TWideStringField;
    AllAuthorsMiddleName: TWideStringField;

  strict private
    // GetCurrentBook(var R: TBookRecord);
    // SetActiveTable
    FIsFavorites: Boolean;
    FActiveTable: TABSTable;

  private type
    TUpdateExtraProc = reference to procedure;

  strict private
    procedure UpdateExtra(BookID: Integer; DatabaseID: Integer; UpdateProc: TUpdateExtraProc);
    procedure ClearExtra(BookID: Integer; DatabaseID: Integer; UpdateProc: TUpdateExtraProc);

    procedure GetAuthor(AuthorID: Integer; var Author: TAuthorData);
    procedure GetBookAuthors(BookID: Integer; var BookAuthors: TBookAuthors);

    function GetBookSerie(SerieID: Integer): string;

    procedure GetGenre(const GenreCode: string; var Genre: TGenreData);
    procedure GetBookGenres(BookID: Integer; var BookGenres: TBookGenres; RootGenre: PGenreData = nil); overload;

  public
    // TfrmMain.tvBooksTreeChange
    // TfrmMain.tbtbnReadClick
    // TfrmMain.tbtbnReadClick
    // TfrmMain.miDeleteBookClick
    // TDownloader.Download
    procedure GetBookFileName(BookID: Integer; DatabaseID: Integer; out AFolder, AFile, AExt: string; out ANo: Integer); deprecated;

    // TfrmMain.FormCreate
    // TfrmMain.pgControlChange
    procedure SetActiveTable(Tag: Integer); deprecated;

    // TDownloader.DoDownload
    procedure GetBookLibID(BookID: Integer; DatabaseID: Integer; out ARes: string); deprecated;

    // TExport2XMLThread.WorkFunction
    // TExport2INPXThread.WorkFunction
    // WriteFb2InfoToFile
    // TfrmConvertToFBD.PrepareForm
    procedure GetCurrentBook(var R: TBookRecord); overload; deprecated;

    procedure SetTableState(State: Boolean);

  public
    //
    // ����� ������, ����������� DatabaseID
    //

    //
    // ���������� ��� ������
    //
    procedure GetBookRecord(BookID: Integer; DatabaseID: Integer; var BookRecord: TBookRecord; LoadExtra: Boolean); overload;

    //
    // ���������� �����
    //
    procedure SetLocal(BookID: Integer; DatabaseID: Integer; AState: Boolean);

    //
    // ���������� ����� �� ������� Extra
    //
    procedure SetRate(BookID: Integer; DatabaseID: Integer; Rate: Integer);
    procedure SetProgress(BookID: Integer; DatabaseID: Integer; Progress: Integer);
    function GetReview(BookID: Integer; DatabaseID: Integer): string;
    function SetReview(BookID: Integer; DatabaseID: Integer; const Review: string): Integer;

    //
    // ������ � ��������
    //
    procedure AddBookToGroup(BookID: Integer; DatabaseID: Integer; GroupID: Integer);

    //
    // ���������� �� ������� ���������
    //
    procedure GetStatistics(out AuthorsCount: Integer; out BooksCount: Integer; out SeriesCount: Integer);
  end;

var
  DMCollection: TDMCollection;

implementation

uses
  Windows,
  Forms,
  SysUtils,
  StrUtils,
  IOUtils,
  Variants,
  dm_user,
  unit_Consts,
  unit_Messages,
  unit_Helpers;

{$R *.dfm}

{ TDMMain }

procedure TDMCollection.GetBookLibID(BookID: Integer; DatabaseID: Integer; out ARes: String);
begin
  if DatabaseID = DMUser.ActiveCollection.ID then
  begin
    Assert(AllBooks.Active);

    if not AllBooks.Locate(BOOK_ID_FIELD, BookID, []) then
    begin
      Assert(False);
      Exit;
    end;

    ARes := AllBooksLibID.AsString;
  end
  else
    DMUser.GetBookLibID(BookID, DatabaseID, ARes);
end;

procedure TDMCollection.GetBookFileName(
  BookID: Integer;
  DatabaseID: Integer;
  out AFolder: string;
  out AFile: string;
  out AExt: string;
  out ANo: Integer
  );
begin
  if DatabaseID = DMUser.ActiveCollection.ID then
  begin
    Assert(AllBooks.Active);

    if not AllBooks.Locate(BOOK_ID_FIELD, BookID, []) then
    begin
      // TODO : RESTORE Assert(False);
      Exit;
    end;

    AFolder := TPath.Combine(DMUser.ActiveCollection.RootPath, AllBooksFolder.Value);
    AFile := AllBooksFileName.Value;
    AExt := AllBooksExt.Value;
    ANo := AllBooksInsideNo.Value;

    if ExtractFileExt(AFile) <> ZIP_EXTENSION then // ����� ���� ��������!
      AFile := AFile + AExt;
  end
  else
    DMUser.GetBookFileName(BookID, DatabaseID, AFolder, AFile, AExt, ANo);
end;

procedure TDMCollection.GetStatistics(out AuthorsCount: Integer; out BooksCount: Integer; out SeriesCount: Integer);
var
  FilterStateA: Boolean;
  FilterStringA: string;

  BM1: TBookMark;
begin
  (* ***************************************************************************
    *
    * ����� ��������������� ������������ 3 ������� �������,
    * �� ���� ������� ��� ����
    *
    *************************************************************************** *)

  BM1 := Authors.GetBookmark;
  try
    FilterStateA := Authors.Filtered;
    FilterStringA := Authors.Filter;
    Authors.Filtered := False;

    AuthorsCount := Authors.RecordCount;
    BooksCount := AllBooks.RecordCount;
    SeriesCount := AllSeries.RecordCount;

    Authors.Filter := FilterStringA;
    Authors.Filtered := FilterStateA;

    Authors.GotoBookmark(BM1);
  finally
    Authors.FreeBookmark(BM1);
  end;
end;

procedure TDMCollection.SetActiveTable(Tag: Integer);
begin
  if Tag = PAGE_FAVORITES then
  begin
    FActiveTable := DMUser.BooksByGroup;
    FIsFavorites := True;
  end
  else
  begin
    FActiveTable := tblBooks;
    FIsFavorites := False;
  end;
end;

procedure TDMCollection.SetTableState(State: Boolean);
begin
  Authors.Active := State;
  AuthorBooks.Active := State;
  BooksByAuthor.Active := State;

  Series.Active := State;
  BooksBySerie.Active := State;

  Genres.Active := State;
  GenreBooks.Active := State;
  BooksByGenre.Active := State;

  BookGenres.Active := State;
  BookAuthors.Active := State;

  tblBooks.Active := State;
  tblSeriesB1.Active := State;

  AllAuthors.Active := State;
  AllSeries.Active := State;
  AllBooks.Active := State;
  AllExtra.Active := State;
  AllGenres.Active := State;
end;

// ============================================================================
//
// ����� ������
//
// ============================================================================

function TDMCollection.GetBookSerie(SerieID: Integer): string;
begin
  if AllSeries.Locate(SERIE_ID_FIELD, SerieID, []) then
    Result := AllSeriesSerieTitle.Value
  else
    Result := '';
end;

procedure TDMCollection.GetGenre(const GenreCode: string; var Genre: TGenreData);
begin
  Assert(AllGenres.Active);
  if AllGenres.Locate(GENRE_CODE_FIELD, GenreCode, []) then
  begin
    Genre.GenreCode := GenreCode;
    Genre.ParentCode := AllGenresParentCode.Value;
    Genre.FB2GenreCode := AllGenresFB2Code.Value;
    Genre.GenreAlias := AllGenresAlias.Value;
  end
  else
    Genre.Clear;
end;

procedure TDMCollection.GetAuthor(AuthorID: Integer; var Author: TAuthorData);
begin
  Assert(AllAuthors.Active);
  if AllAuthors.Locate(AUTHOR_ID_FIELD, AuthorID, []) then
  begin
    Author.AuthorID := AuthorID;
    Author.LastName := AllAuthorsLastName.Value;
    Author.FirstName := AllAuthorsFirstName.Value;
    Author.MiddleName := AllAuthorsMiddleName.Value;
  end
  else
    Author.Clear;
end;

procedure TDMCollection.GetBookAuthors(BookID: Integer; var BookAuthors: TBookAuthors);
var
  i: Integer;
begin
  Assert(Self.BookAuthors.Active);
  Self.BookAuthors.SetRange([BookID], [BookID]);
  try
    i := Length(BookAuthors);
    Self.BookAuthors.First;
    while not Self.BookAuthors.Eof do
    begin
      SetLength(BookAuthors, i + 1);
      GetAuthor(Self.BookAuthorsAuthorID.Value, BookAuthors[i]);

      Inc(i);
      Self.BookAuthors.Next;
    end;
  finally
    Self.BookAuthors.CancelRange;
  end;
end;

procedure TDMCollection.GetBookGenres(BookID: Integer; var BookGenres: TBookGenres; RootGenre: PGenreData = nil);
var
  i: Integer;
begin
  Assert(Self.BookGenres.Active);

  Self.BookGenres.SetRange([BookID], [BookID]);
  try
    i := Length(BookGenres);
    Self.BookGenres.First;

    while not Self.BookGenres.Eof do
    begin
      SetLength(BookGenres, i + 1);
      GetGenre(BookGenresGenreCode.Value, BookGenres[i]);

      Inc(i);
      Self.BookGenres.Next;
    end;

    if Assigned(RootGenre) then
    begin
      if Length(BookGenres) > 0 then
        GetGenre(BookGenres[0].ParentCode, RootGenre^)
      else
        RootGenre^.Clear;
    end;
  finally
    Self.BookGenres.CancelRange;
  end;
end;

procedure TDMCollection.GetCurrentBook(var R: TBookRecord);
var
  BookID: Integer;
  DatabaseID: Integer;
begin
  BookID := FActiveTable.FieldByName(BOOK_ID_FIELD).Value;
  if FActiveTable = tblBooks then
    DatabaseID := DMUser.ActiveCollection.ID
  else
    DatabaseID := FActiveTable.FieldByName(DB_ID_FIELD).AsInteger;

  GetBookRecord(BookID, DatabaseID, R, True);
end;

procedure TDMCollection.GetBookRecord(BookID: Integer; DatabaseID: Integer; var BookRecord: TBookRecord; LoadExtra: Boolean);
begin
  BookRecord.Clear;

  if DatabaseID = DMUser.ActiveCollection.ID then
  begin
    Assert(AllBooks.Active);

    if not AllBooks.Locate(BOOK_ID_FIELD, BookID, []) then
    begin
      Assert(False);
      Exit;
    end;

    BookRecord.Title := AllBooksTitle.Value;
    BookRecord.Folder := AllBooksFolder.Value;
    BookRecord.FileName := AllBooksFileName.Value;
    BookRecord.FileExt := AllBooksExt.Value;
    BookRecord.InsideNo := AllBooksInsideNo.Value;
    BookRecord.SerieID := AllBooksSerieID.Value;
    BookRecord.Serie := GetBookSerie(AllBooksSerieID.Value);
    BookRecord.SeqNumber := AllBooksSeqNumber.Value;
    BookRecord.Code := AllBooksCode.Value;
    BookRecord.Size := AllBooksSize.Value;
    BookRecord.LibID := AllBooksLibID.Value;
    BookRecord.Deleted := AllBooksDeleted.Value;
    BookRecord.Local := AllBooksLocal.Value;
    BookRecord.Date := AllBooksDate.Value;
    BookRecord.Lang := AllBooksLang.Value;
    BookRecord.LibRate := AllBooksLibRate.Value;
    BookRecord.KeyWords := AllBooksKeyWords.Value;

    //
    // ������ �� ������� Extra
    //
    Assert(AllExtra.Active);
    if LoadExtra and AllExtra.Locate(BOOK_ID_FIELD, BookID, []) then
    begin
      //
      // ��� ���� ����� ���������� ������ ��� ����������� ����� � ������ ���������.
      // �� ���� ��������� ������� ��� �� ������������.
      //
      BookRecord.Review := AllExtraReview.Value;
      BookRecord.Annotation := AllExtraAnnotation.Value;
      BookRecord.Rate := AllExtraRate.Value;
      BookRecord.Progress := AllExtraProgress.Value;
    end;

    GetBookGenres(BookID, BookRecord.Genres, @(BookRecord.RootGenre));
    GetBookAuthors(BookID, BookRecord.Authors);

    BookRecord.CollectionName := DMUser.ActiveCollection.Name;
  end
  else
    DMUser.GetBookRecord(BookID, DatabaseID, BookRecord);
end;

procedure TDMCollection.SetLocal(BookID: Integer; DatabaseID: Integer; AState: Boolean);
begin
  Assert(DatabaseID = DMUser.ActiveCollection.ID);

  if AllBooks.Locate(BOOK_ID_FIELD, BookID, []) then
  begin
    AllBooks.Edit;
    AllBooksLocal.Value := AState;
    AllBooks.Post;
  end;

  DMUser.SetLocal(BookID, DatabaseID, AState);
end;

procedure TDMCollection.UpdateExtra(BookID, DatabaseID: Integer; UpdateProc: TUpdateExtraProc);
begin
  Assert(DatabaseID = DMUser.ActiveCollection.ID);
  Assert(AllExtra.Active);

  if AllExtra.Locate(BOOK_ID_FIELD, BookID, []) then
    AllExtra.Edit
  else
  begin
    AllExtra.Append;
    AllExtraBookID.Value := BookID;
  end;

  UpdateProc;

  AllExtra.Post;
end;

procedure TDMCollection.ClearExtra(BookID: Integer; DatabaseID: Integer; UpdateProc: TUpdateExtraProc);
begin
  Assert(DatabaseID = DMUser.ActiveCollection.ID);
  Assert(AllExtra.Active);

  if AllExtra.Locate(BOOK_ID_FIELD, BookID, []) then
  begin
    AllExtra.Edit;
    UpdateProc;
    AllExtra.Post;

    //
    // ��� �������� ���� ������� ����� - ������ ������
    //
    if AllExtraAnnotation.IsNull and AllExtraReview.IsNull and AllExtraRate.IsNull and AllExtraProgress.IsNull then
      AllExtra.Delete;
  end;
end;

procedure TDMCollection.SetRate(BookID, DatabaseID, Rate: Integer);
begin
  Assert(DatabaseID = DMUser.ActiveCollection.ID);

  if Rate = 0 then
    ClearExtra(
      BookID, DatabaseID,
      procedure
      begin
        AllExtraRate.Clear;
      end
    )
  else
    UpdateExtra(
      BookID, DatabaseID,
      procedure
      begin
        AllExtraRate.Value := Rate;
      end
    );

  //
  // ������� ���������� � �������
  //
  DMUser.SetRate(BookID, DatabaseID, Rate);
end;

procedure TDMCollection.SetProgress(BookID, DatabaseID, Progress: Integer);
begin
  Assert(DatabaseID = DMUser.ActiveCollection.ID);

  if Progress = 0 then
    ClearExtra(
      BookID, DatabaseID,
      procedure
      begin
        AllExtraProgress.Clear;
      end
    )
  else
    UpdateExtra(
      BookID, DatabaseID,
      procedure
      begin
        AllExtraProgress.Value := Progress;
      end
    );

  //
  // ������� ���������� � �������
  //
  DMUser.SetProgress(BookID, DatabaseID, Progress);
end;

function TDMCollection.GetReview(BookID: Integer; DatabaseID: Integer): string;
begin
  Assert(AllExtra.Active);

  if DatabaseID = DMUser.ActiveCollection.ID then
  begin
    if AllExtra.Locate(BOOK_ID_FIELD, BookID, []) then
    begin
      Result := AllExtraReview.Value;
    end;
  end
  else
    Result := DMUser.GetReview(BookID, DatabaseID);
end;

function TDMCollection.SetReview(BookID: Integer; DatabaseID: Integer; const Review: string): Integer;
var
  NewReview: string;
begin
  Assert(DatabaseID = DMUser.ActiveCollection.ID);

  Result := 0;
  NewReview := Trim(Review);

  if AllBooks.Locate(BOOK_ID_FIELD, BookID, []) then
  begin
    AllBooks.Edit;

    if NewReview = '' then
    begin
      ClearExtra(
        BookID, DatabaseID,
        procedure
        begin
          AllExtraReview.Clear;
        end
      );
      AllBooksCode.Value := 0;
    end
    else
    begin
      UpdateExtra(
        BookID, DatabaseID,
        procedure
        begin
          AllExtraReview.Value := NewReview;
        end
      );
      AllBooksCode.Value := 1;
      Result := 1;
    end;

    AllBooks.Post;

    //
    // ������� ���������� � �������
    //
    Result := Result or DMUser.SetReview(BookID, DatabaseID, NewReview);
  end;
end;

procedure TDMCollection.AddBookToGroup(BookID: Integer; DatabaseID: Integer; GroupID: Integer);
var
  BookRecord: TBookRecord;
begin
  Assert(DatabaseID = DMUser.ActiveCollection.ID);
  Assert(AllBooks.Active);
  Assert(AllExtra.Active);

  GetBookRecord(BookID, DatabaseID, BookRecord, True);

  DMUser.AddBookToGroup(BookID, DatabaseID, GroupID, BookRecord);
end;

end.
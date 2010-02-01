unit dm_librusec;

interface

uses
  SysUtils, Classes, DB, DBAccess, MyAccess, MemDS, MyEmbConnection, DADump,
  MyDump;

type
  TLib = class(TDataModule)
    Connection: TMyConnection;
    dsBook: TMyDataSource;
    dsAvtorname: TMyDataSource;
    dsGenrelist: TMyDataSource;
    dsSeqname: TMyDataSource;
    Avtor: TMyQuery;
    Genre: TMyQuery;
    Series: TMyQuery;
    GenreGenreCode: TWideStringField;
    SeriesSeqName: TWideStringField;
    SeriesSeqNumb: TIntegerField;
    AvtorLastName: TWideStringField;
    AvtorFirstName: TWideStringField;
    AvtorMiddleName: TWideStringField;
    Book: TMyQuery;
    BookBookId: TLargeintField;
    BookTitle: TWideStringField;
    BookFileSize: TLargeintField;
    BookFileType: TWideStringField;
    BookDeleted: TWideStringField;
    BookTime: TDateTimeField;
    BookLang: TWideStringField;
    BookN: TLargeintField;
    Bookkeywords: TWideStringField;
    Query: TMyQuery;
    procedure BookAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    procedure QueryAvtor(BookID: integer);
    procedure QueryGenre(BookID: integer);
    procedure QuerySeries(BookID: integer);
    function  QueryRate(BookID: integer):string;
  public
    { Public declarations }
    function GetBookRecord(BookID: integer; fb2only: boolean = false): string; overload;
    function GetBookRecord(FN: string; fb2only: boolean = false; oldFormat: boolean = false): string; overload;
    function RecordToString(FN: string = ''):string ;
    procedure ShowAll;
    function LastBookID: integer;
  end;

var
  Lib: TLib;

implementation
uses
  MemData;

const
  QS = 'SELECT B.BookId, B.Title, B.FileSize, B.FileType, B.Deleted, B.Time, B.Lang, B.N, B.KeyWords ';

{$R *.dfm}

procedure TLib.BookAfterScroll(DataSet: TDataSet);
begin
  QueryAvtor(Lib.BookBookId.Value);
  QueryGenre(Lib.BookBookId.Value);
  QuerySeries(Lib.BookBookId.Value);
end;

function TLib.GetBookRecord(FN: string; fb2only: boolean; oldFormat: boolean): string;
var
  Query : string;
begin
  if oldFormat then
    Query :=QS + ', F.FileName FROM libbook B, libfilenameold F WHERE B.BookId = F.BookID AND F.FileName = "' + FN + '"'
  else
    Query := QS + ', F.FileName FROM libbook B, libfilename F WHERE B.BookId = F.BookID AND F.FileName = "' + FN + '"';

  Book.SQL.Text := Query;
  Book.Execute;
  QueryAvtor(Lib.BookBookId.Value);
  QueryGenre(Lib.BookBookId.Value);
  QuerySeries(Lib.BookBookId.Value);
  Result := RecordToString(FN);
end;

function TLib.LastBookID: integer;
var
  Count : integer;
begin
  Query.SQL.Text := 'Select Count(*) From libbook';
  Query.Execute;
  Count := Query.Fields[0].AsInteger;
  Book.SQL.Text := 'SELECT * FROM `libbook` LIMIT ' +  IntToStr(Count - 1) +  ', 1';
  Book.Execute;
  Result := BookBookID.Value;
end;

function TLib.GetBookRecord(BookID: integer; fb2only: boolean = false): string;
var
  Query : string;
begin
  if fb2only then
       Query := QS + 'FROM libbook B WHERE B.FileType = "fb2" and B.BookId = ' + IntToStr(BookID)
     else
       Query := QS + 'FROM libbook B WHERE B.BookId = ' + IntToStr(BookID);

  Book.SQL.Text := Query;
  Book.Execute;
  if Book.RecordCount = 0 then
  begin
    Result := '';
    Exit;
  end;
  QueryAvtor(Lib.BookBookId.Value);
  QueryGenre(Lib.BookBookId.Value);
  QuerySeries(Lib.BookBookId.Value);
  Result := RecordToString;
end;

procedure TLib.QueryAvtor(BookID: integer);
begin
  Avtor.SQL.Text := 'select an.LastName, an.FirstName, an.MiddleName from' + #10 +
                    '(libavtor ba left outer join libavtoraliase aa on aa.badid = ba.avtorid)' + #10 +
                    'join libavtorname an on an.avtorid = COALESCE(aa.goodid, ba.avtorid) ' + #10 +
                    'WHERE  ba.bookid = ' + IntToStr(BookID);

  Avtor.Execute;
end;

procedure TLib.QueryGenre(BookID: integer);
begin
  Genre.SQL.Text := 'SELECT G.GenreCode  FROM libgenrelist G, libgenre GL' + #10 +
                    'WHERE GL.BookID = '+ IntToStr(BookID)  + #10 +
                    'AND G.GenreID = GL.GenreId' ;
  Genre.Execute;
end;

function TLib.QueryRate(BookID: integer): string;
begin
  Query.SQL.Text := 'SELECT AVG(Rate) FROM Librate WHERE BookID = ' + IntToStr(BookID);
  Query.Execute;
  if Query.Fields[0].AsInteger <> 0 then
     Result := IntToStr(Query.Fields[0].AsInteger)
   else
     Result := '';
end;

procedure TLib.QuerySeries(BookID: integer);
begin
  Series.SQL.Text := 'SELECT S.SeqName, SL.SeqNumb FROM libseqname S, libseq SL' + #10 +
                    'Where SL.BookID = '+ IntToStr(BookID)  + #10 +
                    'AND S.SeqID = SL.SeqId';
  Series.Execute;
end;

function TLib.RecordToString(FN: string = ''): string;
const
  c = #4;
var
  A: string;
  S: string;
  G: string;
  SN: string;
  Del: string;
  Date: string;
  Year,Month,Day: word;
  Ext: string;
begin
  A := '';
  Avtor.First;
  while not Avtor.Eof do
  begin
      A := A + AvtorLastname.Value + ',' +
           AvtorFirstName.Value + ',' +
           AvtorMiddlename.Value + ':';
    Avtor.Next;
  end;
  if A = '' then A := '�����������,�����,:';

  G := '';
  Genre.First;
  while not Lib.Genre.Eof do
  begin
    G := G + GenreGenreCode.Value + ':';
    Genre.Next;
  end;
  if G = '' then G := 'other:';


  if Series.RecordCount > 0 then
  begin
    S  := copy(SeriesSeqName.Value, 1, 80);
    SN := SeriesSeqNumb.AsWideString;
  end
  else
  begin
    SN := '0';
     S := '';
  end;

  Del := Bookdeleted.Value;

  if FN = '' then
  begin
    FN := BookBookId.AsWideString;
    Ext:= BookFileType.AsWideString;
  end
  else begin
    Ext := ExtractFileExt(FN);
    FN := copy(FN, 1, length(FN) - Length(Ext) -1);
    if Ext[1] = '.' then Delete(Ext,1,1);
  end;

  DecodeDate(BookTime.AsDateTime,Year,Month,Day);
  Date := Format('%d-%.2d-%.2d',[Year,Month,Day]);
  Result := A + c +                             // ������
            G + c +                             // �����
            trim(BookTitle.AsWideString) + c +  // ��������
            S + c + SN + c +                    // �����, �����
            FN + c +       // ��� �����
            BookFileSize.AsWideString + c +     // ������
            BookBookId.AsWideString + c +       // LibID
            Del + c +                           // Deleted
            Ext + c +     // type
            Date + c +                          // Date
            BookLang.AsWideString + c +         // Lang
            QueryRate(BookBookID.Value) + c +   // N
            Bookkeywords.AsWideString + c;      // Keywords
  Result := StringReplace(Result, #10, '', [rfReplaceAll]);
  Result := StringReplace(Result, #13, '', [rfReplaceAll]);
end;

procedure TLib.ShowAll;
begin
  Book.SQL.Text := QS + 'FROM libbook B';
  Book.Execute;
end;

end.
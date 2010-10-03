(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2010 Aleksey Penkov
  *
  * Authors             eg
  * Created             12.09.2010
  * Description
  *
  * $Id$
  *
  * History
  *
  ****************************************************************************** *)

unit unit_SystemDatabase_Abstract;

interface

uses
  Classes,
  Windows,
  unit_Globals,
  unit_Consts,
  unit_Interfaces,
  unit_MHLGenerics,
  UserData;

type
  // --------------------------------------------------------------------------
  TBookCollectionCache = TInterfaceCache<Integer, IBookCollection>;

  // --------------------------------------------------------------------------

  TSystemData = class abstract(TInterfacedObject)
  protected
    FActiveCollectionInfo: TCollectionInfo;
    FCollectionCache: TBookCollectionCache;

    function InternalCreateCollection(const CollectionID: Integer): IBookCollection; virtual; abstract;

  protected
    //
    // ISystemData
    //
    function HasCollections: Boolean;
    function FindFirstExistingCollectionID(const PreferredID: Integer): Integer;

    function GetCollection(const CollectionID: Integer): IBookCollection;

    function GetActiveCollectionInfo: TCollectionInfo;
    function GetActiveCollection: IBookCollection;

    //
    // ���������������� ������
    //
    procedure ExportUserData(data: TUserData);

    //Iterators:
    function GetBookIterator(const GroupID: Integer; const DatabaseID: Integer = INVALID_COLLECTION_ID): IBookIterator; virtual; abstract;
    function GetGroupIterator: IGroupIterator; virtual; abstract;
    function GetCollectionInfoIterator: ICollectionInfoIterator; virtual; abstract;

    //
    // ��������� ������
    //
    procedure ClearCollectionCache;

  public
    constructor Create;
    destructor Destroy; override;
  end;

resourcestring
  rstrNamelessColection = '���������� ���������';
  rstrUnknownCollection = '����������� ���������';
  rstrFavoritesGroupName = '���������';
  rstrToReadGroupName = '� ���������';

implementation

uses
  SysUtils;

{ TSystemData }

constructor TSystemData.Create;
begin
  inherited Create;

  FCollectionCache := TBookCollectionCache.Create;
end;

destructor TSystemData.Destroy;
begin
  FreeAndNil(FCollectionCache);
  inherited Destroy;
end;

function TSystemData.HasCollections: Boolean;
begin
  Result := (GetCollectionInfoIterator.RecordCount > 0);
end;

function TSystemData.FindFirstExistingCollectionID(const PreferredID: Integer): Integer;
var
  it: ICollectionInfoIterator;
  Info: TCollectionInfo;
begin
  Result := INVALID_COLLECTION_ID;

  it := GetCollectionInfoIterator;
  while it.Next(Info) do
  begin
    if FileExists(Info.DBFileName) then
    begin
      if Info.ID = PreferredID then
      begin
        //
        // ������������ ������������ ��� ���������, ��� �������� -> �������
        //
        Result := Info.ID;
        Break;
      end;

      if Result = INVALID_COLLECTION_ID then
      begin
        //
        // �������� ������ ��������� ���������
        //
        Result := Info.ID;
      end;
    end;
  end;
end;

procedure TSystemData.ExportUserData(data: TUserData);
var
  CollectionID: Integer;
  BookGroup: TBookGroup;
  GroupIterator: IGroupIterator;
  GroupData: TGroupData;
  BookIterator: IBookIterator;
  BookRecord: TBookRecord;
begin
  Assert(Assigned(data));

  CollectionID := FActiveCollectionInfo.ID;

  GroupIterator := GetGroupIterator;
  while GroupIterator.Next(GroupData) do
  begin
    BookGroup := data.Groups.AddGroup(GroupData.GroupID, GroupData.Text);

    BookIterator := GetBookIterator(GroupData.GroupID, CollectionID);
    while BookIterator.Next(BookRecord) do
      BookGroup.AddBook(BookRecord.BookKey.BookID, BookRecord.LibID);
  end;
end;

function TSystemData.GetActiveCollectionInfo: TCollectionInfo;
begin
  Assert(INVALID_COLLECTION_ID <> FActiveCollectionInfo.ID);
  Result := FActiveCollectionInfo;
end;

function TSystemData.GetCollection(const CollectionID: Integer): IBookCollection;
begin
  Assert(INVALID_COLLECTION_ID <> CollectionID);
  FCollectionCache.LockMap;
  try
    if FCollectionCache.ContainsKey(CollectionID) then
    begin
      Result := FCollectionCache.Get(CollectionID);
    end
    else
    begin
      Result := InternalCreateCollection(CollectionID);
      FCollectionCache.Add(CollectionID, Result);
    end;
  finally
    FCollectionCache.UnlockMap;
  end;
end;

function TSystemData.GetActiveCollection: IBookCollection;
begin
  Assert(FActiveCollectionInfo.ID > 0);
  Result := GetCollection(FActiveCollectionInfo.ID);
end;

procedure TSystemData.ClearCollectionCache;
begin
  FCollectionCache.Clear;
end;

end.
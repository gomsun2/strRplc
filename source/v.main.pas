unit v.main;

interface

uses
  mvw.vForm,
  Spring.Collections,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, RzPanel, RzSplit;

type
  TvMain = class(TvForm)
    Splitter: TRzSplitter;
    Panel1: TPanel;
    Panel2: TPanel;
    ButtonRplc: TButton;
    MemoRplc: TMemo;
    Label2: TLabel;
    ButtonSaveFile: TButton;
    ButtonRplcAllSave: TButton;
    RzSplitter1: TRzSplitter;
    ListBoxFiles: TListBox;
    Panel4: TPanel;
    LabelFile: TLabel;
    MemoFile: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure ListBoxFilesClick(Sender: TObject);

    procedure ButtonRplcClick(Sender: TObject);
    procedure ButtonSaveFileClick(Sender: TObject);
    procedure ButtonRplcAllSaveClick(Sender: TObject);private
  private
    FFiles: TStringList;
    FRplcDic: IDictionary<String, String>;
    FBakDir: String;
    procedure BuildRplcDic;
    procedure CreateBakDirectory;
    procedure CreasteRplcFile;
    function BackupFile(const AFileName: String): Boolean;
  protected
    procedure DoDropFile(const ACnt: Integer; const AFiles: TStringList); override;
  public
  end;

var
  vMain: TvMain;

implementation

{$R *.dfm}

uses
  svc.option,

  mFontHelper, System.IOUtils, mListBoxHelper, System.Generics.Collections, mDateTimeHelper, mIOUtils, System.UITypes,
  System.DateUtils
  ;

procedure TvMain.ButtonRplcAllSaveClick(Sender: TObject);
var
  LFile: String;
  LBuf: TStringList;
begin
  ButtonRplcAllSave.Enabled := False;
  LBuf := TStringList.Create;
  try
    BuildRplcDic;
    CreateBakDirectory;
    CreasteRplcFile;
    for LFile in FFiles do
      if TFile.Exists(LFile) then
      begin
        LBuf.LoadFromFile(LFile);
        FRplcDic.ForEach(
          procedure(const AItem: TPair<String, String>)
          begin
            LBuf.Text := LBuf.Text.Replace(AItem.Key, AItem.Value, [rfReplaceAll])
          end);
        if not BackupFile(LFile) then
          Break;
        LBuf.SaveToFile(LFile);
      end;
    MessageDlg('작업이 완료되었습니다.', mtInformation, [mbOK], 0);
  finally
    FreeAndNil(LBuf);
    ButtonRplcAllSave.Enabled := True;
  end;
end;

procedure TvMain.ButtonRplcClick(Sender: TObject);
var
  LRplc: String;
begin
  BuildRplcDic;
  MemoFile.Lines.BeginUpdate;
  LRplc := MemoFile.Lines.Text;
  FRplcDic.ForEach(
    procedure(const AItem: TPair<String, String>)
    begin
      LRplc := LRplc.Replace(AItem.Key, AItem.Value, [rfReplaceAll])
    end);
  MemoFile.Lines.Text := LRplc;
  MemoFile.Lines.EndUpdate;
end;

procedure TvMain.ButtonSaveFileClick(Sender: TObject);
begin
  if not ListBoxFiles.ItemSelected then
    Exit;

  CreateBakDirectory;
  CreasteRplcFile;
  BackupFile(FFiles[ListBoxFiles.ItemIndex]);
  MessageDlg('작업이 완료되었습니다.', mtWarning, [mbOK], 0);
end;

procedure TvMain.DoDropFile(const ACnt: Integer; const AFiles: TStringList);
var
  i: Integer;
begin
  FFiles.Assign(AFiles);
  ListBoxFiles.Items.BeginUpdate;
  try
    ListBoxFiles.Clear;
    for i := 0 to AFiles.Count -1 do
      ListBoxFiles.Items.Add(TPath.GetFileName(AFiles[i]));
  finally
    ListBoxFiles.Items.EndUpdate;
  end;
end;

procedure TvMain.CreasteRplcFile;
begin
  svcOption.LastRplcTxt := TPath.Combine(FBakDir, Now.ToString('YYYYMMDD HHNN') + '.txt');
  MemoRplc.Lines.SaveToFile(svcOption.LastRplcTxt);
end;

function TvMain.BackupFile(const AFileName: String): Boolean;
var
  LBak: String;
begin
  Result := True;
  if TFile.Exists(AFileName) then
  begin
    try
      LBak := TPath.Combine(FBakDir, TPath.GetFileName(AFileName));
      TFile.Move(AFileName, LBak);
    except on E: Exception do
      if (MessageDlg('백업간 다음 오류가 발생하였습니다.'#13#10+E.Message+#13#10#13#10'중단 하시겠습니까 ?', mtError, [mbYes, mbNo], 0) = mrYes) then
        Exit(False)
    end;
  end;
end;

procedure TvMain.CreateBakDirectory;
begin
  FBakDir := TPath.Combine(TDirectory.GetCurrentDirectory, 'gstrRplc '+Now.ToString('YYYYMMDD HHNN'));
  if not TDirectory.Exists(FBakDir) then
    TDirectory.CreateDirectory(FBakDir);
end;

procedure TvMain.BuildRplcDic;
var
  LLine: string;
  LBuf: TArray<String>;
begin
  FRplcDic.Clear;
  for LLine in MemoRplc.Lines do
  begin
    LBuf := LLine.Split([',']);
    if Length(LBuf) = 2 then
      FRplcDic.AddOrSetValue(LBuf[0], LBuf[1]);
  end;
end;

procedure TvMain.FormCreate(Sender: TObject);
var
  LLasRplcFile: String;
begin
  FFiles := TStringList.Create;
  FRplcDic := TCollections.CreateDictionary<String, String>;

  EnableDropdownFiles := True;
  TFixedWidthFont.AssingToCtrls([MemoFile, MemoRplc, ListBoxFiles, LabelFile]);

  LLasRplcFile := svcOption.LastRplcTxt;
  if not LLasRplcFile.IsEmpty and TFile.Exists(LLasRplcFile) then
    MemoRplc.Lines.LoadFromFile(LLasRplcFile);
end;

procedure TvMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FFiles);
end;

procedure TvMain.ListBoxFilesClick(Sender: TObject);
var
  LBox: TListBox absolute Sender;
begin
  if not LBox.ItemSelected then
    Exit;

  if TFile.Exists(FFiles[LBox.ItemIndex]) then
  begin
    LabelFile.Caption := FFiles[LBox.ItemIndex];
    MemoFile.Lines.LoadFromFile(FFiles[LBox.ItemIndex]);
  end;
end;

end.

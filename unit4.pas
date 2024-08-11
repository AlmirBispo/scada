unit Unit4; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SdfData, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  DBGrids, StdCtrls, ComCtrls;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Datasource1: TDatasource;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    sdf: TSdfDataSet;
    StatusBar1: TStatusBar;
    TrackBar1: TTrackBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form4: TForm4; 

implementation
{$R *.lfm}

{ TForm4 }
 uses unit3,unit1,shellapi,windows;
 {$i empilhar_cql.txt}
 {$i identar.txt}
 {$i executar_cql.txt}
procedure TForm4.Button2Click(Sender: TObject);
begin
  form1.Timer1.Enabled:=false;
  close;
end;

procedure TForm4.Button1Click(Sender: TObject);
var sc:tstringlist;
   var sim:tstringlist;
     i:integer;
     perm:string;
begin
 {
  sc:=tstringlist.create;
  sc.add(inttostr(trackbar1.Position));
  sc.SaveToFile(application.Location+'time.exe');
  sc.free;
  }
  if fileexists(application.location+'sim\'+sdf.FieldByName('CQL').AsString) then
  begin
  sim:=tstringlist.create;
  sim.LoadFromFile(application.location+'sim\'+sdf.FieldByName('CQL').AsString);
//  sim.text:=identar(sim.text);
  sim.text:=verificar_sintaxe(sim.text);
  //sim.savetofile('rod.txt');
  perm:='{none;@open_domain;(scada.dmn);(scada);(all);0;query=0;to_field=0}';//internacional
  for i:=0 to sim.count-1 do
  begin
  executa_cql(application.location,perm + '{'+sim.strings[i]+'}');
  application.ProcessMessages;
  sleep(trackbar1.Position);
  end;
  sim.free;
  statusbar1.Panels[0].Text:=('Script Loaded !');
  end;
form1.Timer1.Enabled:=true;
end;

procedure TForm4.DBGrid1DblClick(Sender: TObject);

begin



end;

procedure TForm4.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var sc:tstringlist;
begin
  sc:=tstringlist.create;
   sc.add('0');
   sc.SaveToFile(application.Location+'time.exe');
   sc.free;
  form1.Timer1.Enabled:=true;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  form1.Timer1.Enabled:=false;
  trackbar1.Position:=1000;
  sdf.Active:=false;
  sdf.FileName:=application.location+'SIMULATE.csv';
  sdf.FirstLineAsSchema:=true;
  sdf.Active:=true;
  sdf.First;
  dbgrid1.AutoFillColumns:=true;

end;

procedure TForm4.TrackBar1Change(Sender: TObject);
begin
  statusbar1.Panels[0].Text:='Time: '+inttostr(trackbar1.Position);
end;

end.


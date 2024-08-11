unit Unit5; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, ExtCtrls,fphttpclient;

type

  { TForm5 }

  TForm5 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    tb: TTrackBar;
    Timeimport: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure tbChange(Sender: TObject);
    procedure TimeimportTimer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form5: TForm5; 

implementation

{$R *.lfm}

{ TForm5 }
uses shellapi;
procedure TForm5.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TForm5.FormShow(Sender: TObject);
var imp:tstringlist;
begin
     button1.Enabled:=false;
if fileexists(application.location+'sim\import.inf') then
begin
imp:=tstringlist.create;
imp.loadfromfile(application.location+'sim\import.inf');
edit1.text:=imp.strings[0];
edit2.text:=imp.strings[1];
edit3.text:=imp.strings[2];
tb.position:=strtoint(imp.strings[3]);
imp.free;
 end;
end;

procedure TForm5.RadioButton1Change(Sender: TObject);
begin
if radiobutton1.Checked then

   button1.Enabled:=true;
end;

procedure TForm5.RadioButton2Change(Sender: TObject);
begin
if radiobutton2.Checked then
   button1.Enabled:=false;
end;

procedure TForm5.tbChange(Sender: TObject);
begin
  label1.caption:=inttostr(tb.position);
end;

procedure TForm5.TimeimportTimer(Sender: TObject);
var   http:TFPHttpClient;
    s:Tstringlist;
begin
if (edit1.text='' ) or
(edit2.text='' ) or
(edit3.text='' ) then begin  showmessage('Imput data !');exit;end;

s:=Tstringlist.create;
http:= TFPHttpClient.Create(Nil);
//importar process
http.get(edit1.text+'/services/'+edit2.text+'_'+edit3.text+'/PROCESS.csv', s);
s.SaveToFile(application.Location + 'PROCESS.csv');
//importa obj-config
s.Clear;
http.get(edit1.text+'/services/'+edit2.text+'_'+edit3.text+'/OBJ-CONFIG.csv', s);
s.SaveToFile(application.Location + 'OBJ-CONFIG.csv');

http.Free;
s.free;
end;

procedure TForm5.Button1Click(Sender: TObject);
var imp:tstringlist;
begin
  if radiobutton1.Checked=true then
  begin

  imp:=tstringlist.create;
  imp.Add(edit1.text);
  imp.Add(edit2.text);
  imp.Add(edit3.text);
  imp.Add(inttostr(tb.position));
  imp.savetofile(application.location+'sim\import.inf');
  imp.free;
  timeimport.Interval:=tb.Position;
  timeimport.Enabled:=true;
  end;
    if radiobutton2.Checked=true then
  begin

  timeimport.Interval:=tb.Position;
  timeimport.Enabled:=false;
  end;
end;

end.


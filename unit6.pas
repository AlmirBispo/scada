unit Unit6;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TForm6 }

  TForm6 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form6: TForm6;

implementation
  uses Unit1;
{$R *.lfm}

{ TForm6 }

procedure TForm6.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TForm6.Button1Click(Sender: TObject);
var sms:Tstringlist;
   value:longint;
begin
  if (edit1.text='') or
(edit2.text='') or
(edit3.text='') or
(edit4.text='') then begin  Showmessage('Input Data !');exit;end;
sms:=Tstringlist.create;
if (edit1.text<>'') or
(edit2.text<>'') or
(edit3.text<>'') or
(edit4.text<>'') then
begin
sms.add(edit1.text);
sms.add(edit2.text);
sms.add(edit3.text);
sms.add(edit4.text);
sms.savetofile(application.location+'Alarmes\sms.txt');
if radiobutton1.Checked=true then  begin value:= 60000; end;
if radiobutton2.Checked=true then  begin value:= 5*(60000); end;
if radiobutton3.Checked=true then  begin value:= 10*(60000); end;
if radiobutton4.Checked=true then  begin value:= 30*(60000); end;
if radiobutton5.Checked=true then  begin value:=60* 60000; end;
timer1.Interval:=value;
end;
sms.free;

end;

procedure TForm6.FormShow(Sender: TObject);
var sms:Tstringlist;
begin
sms:=Tstringlist.create;
sms.LoadFromFile(application.location+'Alarmes\sms.txt');
edit1.text:=sms.Strings[0];
edit2.text:=sms.Strings[1];
edit3.text:=sms.Strings[2];
edit4.text:=sms.Strings[3];
sms.free;
end;

procedure TForm6.Timer1Timer(Sender: TObject);
begin
  form1.SMS_Enviado:=false;
end;

end.


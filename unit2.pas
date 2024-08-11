unit Unit2; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Spin, Arrow, Buttons, strutils,shellapi;

type

  { TForm2 }

  TForm2 = class(TForm)
    Arrow1: TArrow;
    Arrow2: TArrow;
    Arrow3: TArrow;
    Arrow4: TArrow;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    cd1: TColorDialog;
    cd2: TColorDialog;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Edit4: TEdit;
    GroupBox17: TGroupBox;
    MyObj: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    GroupBox12: TGroupBox;
    GroupBox13: TGroupBox;
    GroupBox14: TGroupBox;
    GroupBox15: TGroupBox;
    GroupBox16: TGroupBox;
    GroupBox9: TGroupBox;
    prototipo: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    se2: TSpinEdit;
    se3: TSpinEdit;
    se4: TSpinEdit;
    se5: TSpinEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    sf2: TFloatSpinEdit;
    se1: TSpinEdit;
    prototipo_atualizar: TSpeedButton;
    procedure Arrow1Click(Sender: TObject);
    procedure Arrow2Click(Sender: TObject);
    procedure Arrow3Click(Sender: TObject);
    procedure Arrow4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure prototipo_atualizarClick(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
  private
      Obj_caldeira,Obj_duto,Obj_termo,Obj_DD,peca,Obj_Esteira,Obj_val,Obj_tag,Obj_tempo,background,Obj_float:tbitmap;  { private declarations }
  xpos,ypos:integer;
       COR_CONTORNO,meucontorno:string;
  public

  sx,sy:string;  { public declarations }
  end; 

var
  Form2: TForm2; 

implementation
uses unit1,Unit3;
{$R *.lfm}
{$i iph.txt}
{$i portas.txt}
{$i maquina_virtual.pas}
{ TForm2 }

procedure TForm2.Arrow3Click(Sender: TObject);
begin
  se5.Value:=se5.Value - 50;
  prototipo_atualizar.Click;
end;

procedure TForm2.Arrow2Click(Sender: TObject);
begin
    se4.Value:=se4.Value + 50;
      prototipo_atualizar.Click;
end;

procedure TForm2.Arrow1Click(Sender: TObject);
begin
      se4.Value:=se4.Value - 50;
        prototipo_atualizar.Click;
end;

procedure TForm2.Arrow4Click(Sender: TObject);
begin
    se5.Value:=se5.Value + 50;
      prototipo_atualizar.Click;
end;

procedure TForm2.Button2Click(Sender: TObject);

begin
form3:=tform3.create(self);
form3.showmodal;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  close;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  form3:=tform3.create(self);
form3.showmodal;
end;

procedure TForm2.ComboBox1Change(Sender: TObject);
begin

  if  combobox1.text='@temporizador' then begin edit4.text:='12:00:00'; end;
  if  combobox1.text<>'@temporizador' then begin edit4.text:='0'; end;
end;

procedure TForm2.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

  //form1.planta.canvas.Draw(0,0,Background_Image('modelo_2.bmp'));
   form1.planta.picture.loadfromfile(application.location+'default.bmp');
    form1.timer1.Enabled:=true;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
    prototipo_atualizar.Hide;
  form2.Width:=420;
  form2.top:=5;
  form2.Left:=screen.Width -430;
  if (sx<>'0') and(sy <> '0')then
  begin
   form2.se4.Value:= strtoint(form2.sx);
  form2.se5.Value:= strtoint(form2.sy);
end;

  se2.value:=60;
  se3.value:=60;
  //botoes
  button1.Enabled:=false;
  button2.Enabled:=false;
  button4.Enabled:=false;
//carrega tabela process.csv
if fileexists(application.Location+'PROCESS.que') then
begin
combobox2.Items.LoadFromFile(application.Location+'PROCESS.que');
combobox2.Text:=combobox2.Items[0];
end;

end;

procedure TForm2.Panel1Click(Sender: TObject);
begin
  if cd1.Execute then
  begin
  panel1.Color:=cd1.Color;
  button1.enabled:=true;
  button2.enabled:=true;
  end;
end;

procedure TForm2.Panel2Click(Sender: TObject);
begin
    if cd2.Execute then begin panel2.Color:=cd2.Color;button1.enabled:=true;button2.enabled:=true; end;
end;

procedure TForm2.prototipo_atualizarClick(Sender: TObject);
var classe,uid,nome,tags,iniv,setv,alertv,com,dev,ow,oh,opx,opy,ocolor,obackc:string;
     xc,yc:integer;
begin
  prototipo.Picture.Clear;
  classe:=combobox1.Text;
  uid:=combobox2.Text;
  nome:=MyObj.text;
  tags:=edit2.text;
  iniv:=(edit4.text);

  setv:=floattostr(sf2.Value);
  alertv:=inttostr(se1.Value);
  com:=combobox3.text;
  dev:=edit3.Text;
  //propriedades
  ow:=inttostr(se2.Value);
  oh:=inttostr(se3.Value);
  opx:=inttostr(se4.Value);
  opy:=inttostr(se5.Value);
  ocolor:=inttostr(panel1.color);
  obackc:=inttostr(panel2.color);
   if (uid='') or
   (classe='')or
   (nome='') or
   (tags='') or
   (iniv='') or
   (setv='') or
   (alertv='') or
   (com='') or
   (dev ='') or
   (ow ='') or
   (oh ='') or
   (opx='') or
   (opy='') or
   (ocolor='') or
   (obackc='')
   then begin showmessage('Please ,input data !');exit;end;
   xc:=((prototipo.Width div 2)-(strtoint(ow) div 2));
   yc:=((prototipo.Height div 2)-(strtoint(oh) div 2));

  if classe='@caldeira' then
  begin
   form1.planta.picture.loadfromfile(application.location+'default.bmp');
   caldeira(strtoint(opx),strtoint(opy),(form1.planta.Picture.Bitmap),variant(uid),variant(nome),variant(iniv),variant(ow),variant(oh),variant(ocolor),variant(obackc) );
    form2.prototipo.picture:=form1.planta.picture;
   end;
  //
    if classe='@duto' then
  begin
  form1.planta.picture.loadfromfile(application.location+'default.bmp');
  Duto(strtoint(opx),strtoint(opy),(form1.planta.Picture.Bitmap),variant(uid),variant(nome),variant(ow),variant(oh),variant(ocolor),variant(obackc) );
form2.prototipo.picture:=form1.planta.picture;
   end;
    //
     if classe='@termometro' then
  begin
       form1.planta.picture.loadfromfile(application.location+'default.bmp');
   termometro(strtoint(opx),strtoint(opy),(form1.planta.Picture.Bitmap),variant(uid),variant(nome),variant(iniv),variant(ow),variant(oh),variant(ocolor),variant(obackc) );
 form2.prototipo.picture:=form1.planta.picture;
   end;
     //
      if classe='@display_digital' then
  begin
      form1.planta.picture.loadfromfile(application.location+'default.bmp');
   display_digital(strtoint(opx),strtoint(opy),(form1.planta.Picture.Bitmap),variant(uid),variant(nome),variant(iniv),variant(ow),variant(oh),variant(ocolor),variant(obackc) );
 form2.prototipo.picture:=form1.planta.picture;
   end;
       if classe='@esteira_horizontal' then
  begin
  form1.planta.picture.loadfromfile(application.location+'default.bmp');
  Esteira_horizontal(strtoint(opx),strtoint(opy),(form1.planta.Picture.Bitmap),variant(uid),variant(nome),variant(iniv),variant(ow),variant(oh),variant(ocolor),variant(obackc) );
  form2.prototipo.picture:=form1.planta.picture;
   end;
   if classe='@esteira_vertical' then
  begin
  form1.planta.picture.loadfromfile(application.location+'default.bmp');
  esteira_vertical(strtoint(opx),strtoint(opy),(form1.planta.Picture.Bitmap),variant(uid),variant(nome),variant(iniv),variant(ow),variant(oh),variant(ocolor),variant(obackc) );
   form2.prototipo.picture:=form1.planta.picture;
   end;
   //
    if classe='@tag_status' then
  begin
  form1.planta.picture.loadfromfile(application.location+'default.bmp');
  tag_status(strtoint(opx),strtoint(opy),(form1.planta.Picture.Bitmap),variant(uid),variant(nome),variant(iniv),variant(ow),variant(oh),variant(ocolor),variant(obackc) );
    form2.prototipo.picture:=form1.planta.picture;
   end;
     //
  if classe='@valvula' then
  begin

  if strtofloat(iniv)>0 then begin iniv:='1';end else iniv:='0';
  form1.planta.picture.loadfromfile(application.location+'default.bmp');
  valvula(strtoint(opx),strtoint(opy),(form1.planta.Picture.Bitmap),variant(uid),variant(nome),variant(iniv),variant(ow),variant(oh),variant(ocolor),variant(obackc) );
  form2.prototipo.picture:=form1.planta.picture;
  end;
  if classe='@tag_float' then
  begin
  form1.planta.picture.loadfromfile(application.location+'default.bmp');
  tag_float(strtoint(opx),strtoint(opy),(form1.planta.Picture.Bitmap),variant(uid),variant(nome),variant(iniv),variant(ow),variant(oh),variant(ocolor),variant(obackc) );
    form2.prototipo.picture:=form1.planta.picture;
  end;
  if classe='@temporizador' then
  begin
   iniv:=timetostr(now);
   form1.planta.picture.loadfromfile(application.location+'default.bmp');
   temporizador(strtoint(opx),strtoint(opy),(form1.planta.Picture.Bitmap),variant(uid),variant(nome),variant(iniv),variant(ow),variant(oh),variant(ocolor),variant(obackc) );
     form2.prototipo.picture:=form1.planta.picture;
  end;

    Obj_caldeira.Free;
    Obj_duto.free;
    Obj_termo.free;
    Obj_DD.free;
    Obj_Esteira.free;
    Obj_val.free;
    Obj_tag.free;
    Obj_Tempo.free;

end;

procedure TForm2.RadioButton1Change(Sender: TObject);
begin
   if radiobutton1.Checked=true then
   begin
   button2.enabled:=true;
   button4.enabled:=false;
   //objetos
    //objetos
   combobox1.Enabled:=true;
   combobox3.Enabled:=true;
   myobj.enabled:=true;
   edit4.Enabled:=true;
   edit2.Enabled:=true;
   edit3.Enabled:=true;
   sf2.Enabled:=true;

   se1.Enabled:=true;
   se2.Enabled:=true;
   se3.Enabled:=true;
   se4.Enabled:=true;
   se5.Enabled:=true;
   end;
end;

procedure TForm2.RadioButton2Change(Sender: TObject);
begin
   if radiobutton2.Checked=true then
   begin
   button4.enabled:=true;
   button2.enabled:=false;
   button1.enabled:=false;
   //objetos
   combobox1.Enabled:=false;
   combobox3.Enabled:=false;
   myobj.enabled:=false;
   edit4.Enabled:=false;
   edit2.Enabled:=false;
   edit3.Enabled:=false;
   sf2.Enabled:=false;

   se1.Enabled:=false;
   se2.Enabled:=false;
   se3.Enabled:=false;
   se4.Enabled:=false;
   se5.Enabled:=false;
   end;
end;

end.


unit Unit3; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  SynMemo, SynEdit, SynHighlighterAny;

type

  { TForm3 }

  TForm3 = class(TForm)
    ImageList1: TImageList;
    StatusBar1: TStatusBar;
    SynAnySyn1: TSynAnySyn;
    sm: TSynMemo;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form3: TForm3; 

implementation
 uses unit1,unit2,Unit4,shellapi,windows;
{$R *.lfm}
{$i executar_cql.txt}
{$i identar.txt}
{ TForm3 }

procedure TForm3.FormShow(Sender: TObject);
var MYDB:string;
   uid,nome,curval,setval,av,pt,dt,aliases:string;//processos
   classe,tags,ow,oh,ox,oy,oc,obc:string;//obj-config
   cql,sim:tstringlist;
begin
//MYDB:=application.location;
cql:=tstringlist.create;
uid:=form2.combobox2.text;
nome:=form2.myobj.text;
curval:=form2.edit4.text;
setval:=floattostr(form2.sf2.value);
av:=inttostr(form2.se1.value);
pt:=form2.combobox3.text;
dt:=form2.edit3.text;
aliases:=form2.combobox4.text;
//
classe:=form2.combobox1.text;
tags:=form2.edit2.text;
ow:=inttostr(form2.se2.value);
oh:=inttostr(form2.se3.value);
ox:=inttostr(form2.se4.value);
oy:=inttostr(form2.se5.value);
oc:=inttostr(form2.panel1.color);
obc:=inttostr(form2.panel2.color);

//


MYDB:='';
statusbar1.Panels[0].Text:=application.Location;


if (uid='')or
(nome='')or
(curval='')or
(setval='')or
(av='')or
(pt='')or
(dt='')or
(classe='')or
(tags='')or
(ow='')or
(oh='')or
(ox='')or
(oy='')or
(oc='')or
(aliases='')or
(obc='') then begin showmessage('Plase,input data !');close;end;
//cria cql para simulacao
sim:=tstringlist.create;
if (classe='@tag_status') or (classe='@valvula')then
begin
sim.add('{none;@open_domain;(scada.dmn);(scada);(all);0;query=0;to_field=0}');//internacional
sim.add('{PROCESS;@update;PID;('+uid+');(1);(PID);query=0;to_field=2}');
sim.add('{PROCESS;@update;PID;('+uid+');(0);(PID);query=0;to_field=2}');
sim.add('{PROCESS;@update;PID;('+uid+');(1);(PID);query=0;to_field=2}');
sim.add('{PROCESS;@update;PID;('+uid+');(0);(PID);query=0;to_field=2}');
sim.add('{PROCESS;@update;PID;('+uid+');(1);(PID);query=0;to_field=2}');
sim.add('{PROCESS;@update;PID;('+uid+');(0);(PID);query=0;to_field=2}');
sim.add('{PROCESS;@update;PID;('+uid+');(1);(PID);query=0;to_field=2}');
sim.add('{PROCESS;@update;PID;('+uid+');(0);(PID);query=0;to_field=2}');
sim.add('{PROCESS;@update;PID;('+uid+');(1);(PID);query=0;to_field=2}');
sim.add('{PROCESS;@update;PID;('+uid+');(0);(PID);query=0;to_field=2}');
end;
if (classe<>'@tag_status')and(classe<>'@temporizador') then
begin
sim.add('{none;@open_domain;(scada.dmn);(scada);(all);0;query=0;to_field=0}');//internacional
sim.add('{PROCESS;@update;PID;('+uid+');(1);(PID);query=0;to_field=2}');
sim.add('{PROCESS;@update;PID;('+uid+');(5);(PID);query=0;to_field=2}');
sim.add('{PROCESS;@update;PID;('+uid+');(15);(PID);query=0;to_field=2}');
sim.add('{PROCESS;@update;PID;('+uid+');(25);(PID);query=0;to_field=2}');
sim.add('{PROCESS;@update;PID;('+uid+');(50);(PID);query=0;to_field=2}');
sim.add('{PROCESS;@update;PID;('+uid+');(30);(PID);query=0;to_field=2}');
sim.add('{PROCESS;@update;PID;('+uid+');(20);(PID);query=0;to_field=2}');
sim.add('{PROCESS;@update;PID;('+uid+');(15);(PID);query=0;to_field=2}');
sim.add('{PROCESS;@update;PID;('+uid+');(10);(PID);query=0;to_field=2}');
sim.add('{PROCESS;@update;PID;('+uid+');(0);(PID);query=0;to_field=2}');
end;
sim.text:=identar(sim.text);
sim.savetofile(application.location+'sim\'+uid+'-'+nome+'.cql');
sim.free;
//
if form2.RadioButton1.Checked=true then
begin
if form2.ComboBox1.text='@temporizador' then begin setval:=timetostr(now);end;
cql.add('{none;@open_domain;(scada.dmn);(scada);(all);0;query=0;to_field=0}');//internacional
cql.add('{'+MYDB+'PROCESS;@add;('+uid+';'+nome+';'+curval+';'+setval+';'+av+';'+pt+';'+dt+';'+aliases+';0;0'+');0;0;0;query=0;to_field=0}');
cql.add('{'+MYDB+'OBJ-CONFIG;@add;('+uid+';'+classe+';'+tags+';'+ow+';'+oh+';'+ox+';'+oy+';'+oc+';'+obc+');0;0;0;query=0;to_field=0}');
cql.add('{'+MYDB+'PROCESS;@list;0;0;0;0;query=0;to_field=0}');
//adicionar cql de simulacao
cql.add('{'+MYDB+'SIMULATE;@add;('+uid+';'+uid+'-'+nome+'.cql);0;0;0;query=0;to_field=0}');
end;
if form2.RadioButton2.Checked=true then
begin
//excluir
//@excluir;(process;obj-config;simulate)
cql.add('{none;@open_domain;(scada.dmn);(scada);(all);0;query=0;to_field=0}');//internacional
cql.add('{'+MYDB+'none;@exclude;('+MYDB+'PROCESS;'+MYDB+'OBJ-CONFIG;'+MYDB+'SIMULATE);('+uid+');0;0;query=0;to_field=0}');
cql.add('{'+MYDB+'PROCESS;@list;0;0;0;0;query=0;to_field=0}');
if fileexists  (pchar(application.Location+'sim\'+uid+'-'+nome+'.cql')) then
deletefile(pchar(application.Location+'sim\'+uid+'-'+nome+'.cql'))
end;

sm.text:=identar(cql.text);
// executa_cql(MYDB,cql.text);
  cql.free;
 sm.Enabled:=false;


end;

procedure TForm3.ToolButton1Click(Sender: TObject);
var MYDB:string;
   cql:tstringlist;
begin

MYDB:=application.Location;

cql:=tstringlist.create;
if sm.text=''then begin showmessage('No Source Code to Execute !');exit;end;
if sm.text<>'' then
 begin
 executa_cql(MYDB,sm.text);
 if form2.RadioButton1.Checked=true then
  showmessage('Object add to table !');
  if form2.RadioButton2.Checked=true then
  showmessage('Object deleted from table !');
  end;

cql.free;
end;

procedure TForm3.ToolButton2Click(Sender: TObject);
begin
  close;
end;

end.


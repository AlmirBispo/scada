unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, epiktimer, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, Menus, Buttons, ExtDlgs, StdCtrls, strutils,shellapi;

type

  { TForm1 }

  TForm1 = class(TForm)
    MenuItem26: TMenuItem;
    et: TEpikTimer;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    bk: TOpenPictureDialog;
    MenuItem9: TMenuItem;
    planta: TImage;
    PopupMenu1: TPopupMenu;
    atualizar: TSpeedButton;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    procedure atualizarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure plantaClick(Sender: TObject);
    procedure plantaMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    //exportar

  private
   Obj_caldeira,Obj_duto,Obj_termo,Obj_DD,peca,Obj_Esteira,Obj_val,Obj_tag,Obj_tempo,background,Obj_float:tbitmap;{ private declarations }
     COR_CONTORNO:string;
  public
  SMS_MSG:Tstringlist;
  SMS_Enviado:boolean;
  Root_user,Root_senha:string;
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation
 uses Unit2,unit4,Unit5,Unit6;
{$R *.lfm}
{$i iph.txt}
{$i portas.txt}
{$i maquina_virtual.pas}

{ TForm1 }

//Almir Bispo,gibroh_webmaster@hotmail.com

//
procedure TForm1.Timer1Timer(Sender: TObject);
var i:integer;
  processo,config,P,C:tstringlist;
  vPID,vCLASS,vTAG,vWIDTH,vHEIGHT,vPOSX,vPOSY,vCOLOR_FULL,vCOLOR_BK:variant;   //config
  pPID,pNAME,pCURRENT_VALUE,pSET_VALUE,pALERT_VALUE,pPORT_TRIGGER,pDEVICE_TRIGGER:variant;//processo
  TM:Ttime;
  //conteudo sms
  contsms:Tstringlist;
  usuario,senha,fone,email:string;
begin
//contabilização de tempo de execução
  et.Clear;
  et.Start;
 TM:=Ttime(now);
   P:=tstringlist.create;P.Delimiter:=char(';');
      C:=tstringlist.create;C.Delimiter:=char(';');

   processo:=tstringlist.create;processo.Delimiter:=char(';');
   config:=tstringlist.create;config.Delimiter:=char(';');
 if not fileexists(application.location+'PROCESS.csv') then begin exit; end;
 if not fileexists(application.location+'OBJ-CONFIG.csv') then begin exit; end;
  if fileexists(application.location+'PROCESS.csv') and fileexists(application.location+'OBJ-CONFIG.csv') then
  begin
   processo.LoadFromFile(application.location+'PROCESS.csv');
   config.LoadFromFile(application.location+'OBJ-CONFIG.csv');


    //color
//   planta.Picture.Clear;
    planta.canvas.Pen.Width:=1;
    planta.Canvas.Pen.Color:=cllime;
    planta.Canvas.Brush.Color:=tcolor(0);
   for i:=0 to config.Count-1 do
   begin
//   application.ProcessMessages;
     C.DelimitedText:=config.Strings[i];
     P.DelimitedText:=processo.Strings[i];
   //variaveis  config
   vPID:=C.Strings[0];
   vCLASS:=C.Strings[1];
   vTAG:=C.Strings[2];
   vWIDTH:=C.Strings[3];
   vHEIGHT:=C.Strings[4];
   vPOSX:=C.Strings[5];
   vPOSY:=C.Strings[6];
   vCOLOR_FULL:=C.Strings[7];
   vCOLOR_BK:=C.Strings[8];
   //variaveis processo
   pPID:=P.Strings[0];
   pNAME:=P.Strings[1];
   pCURRENT_VALUE:=P.Strings[2];
   pSET_VALUE:=P.Strings[3];
   pALERT_VALUE:=P.Strings[4];
   pPORT_TRIGGER:=P.Strings[5];
   pDEVICE_TRIGGER:=P.Strings[6];

   if vPID<>'' then
   begin


     if ansiuppercase(vCLASS)='@CALDEIRA' then
     begin
     //alerta
     vCOLOR_BK:=variant(   Alerta((P.Strings[2]),(P.Strings[4]))   );
     //contramedida :disparada quando o valor corrente da tabela de processos é diferente valor setado

        if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) =ansiuppercase('Alarm')) then
        begin
        sysutils.Beep;
        end;
        //sms
         if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) = ansiuppercase('sms')) then
        begin
          if SMS_Enviado=false then
          begin
          usuario:=SMS_MSG.Strings[0];
          senha:=SMS_MSG.Strings[1];
          fone:=SMS_MSG.Strings[2];
          email:=SMS_MSG.Strings[3];
          contsms:=Tstringlist.create;
          contsms.add('{none;@open_domain;(scada.dmn);(scada);(all);0;query=0;to_field=0}');//internacional
                                                                               //chave privada do usuario
          contsms.add('{none;@import;(http://sistema81.smsbarato.com.br/send?chave=VEdOnHslriAxcnuMytAXz&dest='+fone+'&text='+copy(pPORT_TRIGGER,1,150)+'-'+email+');0;0;0;query=0;to_field=0}');
   //       contsms.add('{none;@importar;(http://sms.3ring.com.br/enviar_mensagem?u='+email+'&p='+senha+'&n='+fone+'&m='+copy(pPORT_TRIGGER,1,150)+');0;0;0;query=0;destino=0}');
          contsms.SaveToFile(application.location+'inpout_comp.exe');
          shellexecute(handle,pchar('open'),pchar(application.Location+'CSV_PARSER.exe'),nil,nil,0);
          contsms.free;

          end;
         end;

     //caldeira
     caldeira(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,vHEIGHT-pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
     //planta.canvas.draw(vPOSX,vPOSY,( Caldeira(vPID,pNAME,vHEIGHT-pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
     end;

     if ansiuppercase(vCLASS)='@DUTO' then
     begin
          //alerta
     vCOLOR_BK:=variant(   Alerta((P.Strings[2]),(P.Strings[4]))   );
     //contramedida :disparada quando o valor corrente da tabela de processos é diferente valor setado
       if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) =ansiuppercase('Alarm')) then
       begin
       sysutils.Beep;
       end;
        //sms
         if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) = ansiuppercase('sms')) then
        begin
          if SMS_Enviado=false then
          begin
          usuario:=SMS_MSG.Strings[0];
          senha:=SMS_MSG.Strings[1];
          fone:=SMS_MSG.Strings[2];
          email:=SMS_MSG.Strings[3];
          contsms:=Tstringlist.create;
          contsms.add('{none;@open_domain;(scada.dmn);(scada);(all);0;query=0;to_field=0}');//internacional
          contsms.add('{none;@import;(http://sistema81.smsbarato.com.br/send?chave=VEdOnHslriAxcnuMytAXz&dest='+fone+'&text='+copy(pPORT_TRIGGER,1,150)+'-'+email+');0;0;0;query=0;to_field=0}');
//          contsms.add('{none;@importar;(http://sms.3ring.com.br/enviar_mensagem?u='+email+'&p='+senha+'&n='+fone+'&m='+copy(pPORT_TRIGGER,1,150)+');0;0;0;query=0;destino=0}');
          contsms.SaveToFile(application.location+'inpout_comp.exe');
          shellexecute(handle,pchar('open'),pchar(application.Location+'CSV_PARSER.exe'),nil,nil,0);
          contsms.free;

          end;
         end;
    //duto horizontal
   Duto(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
//    planta.canvas.draw(vPOSX,vPOSY,( Duto(vPID,pNAME,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
     end;
    //duto vertical
//    planta.canvas.draw(125,410,( Duto('PID:0003','D-Y',30,80,clblack,clred) ));
     //termo
     if ansiuppercase(vCLASS)='@TERMOMETRO' then
     begin
          //alerta
     vCOLOR_BK:=variant(   Alerta((P.Strings[2]),(P.Strings[4]))   );
     //contramedida :disparada quando o valor corrente da tabela de processos é diferente valor setado
          if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) =ansiuppercase('Alarm')) then
        begin
        sysutils.Beep;
        end;
          //sms
                  if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) = ansiuppercase('sms')) then
                 begin
                   if SMS_Enviado=false then
                   begin
                   usuario:=SMS_MSG.Strings[0];
                   senha:=SMS_MSG.Strings[1];
                   fone:=SMS_MSG.Strings[2];
                   email:=SMS_MSG.Strings[3];
                   contsms:=Tstringlist.create;
                   contsms.add('{none;@open_domain;(scada.dmn);(scada);(all);0;query=0;to_field=0}');//internacional
                   contsms.add('{none;@import;(http://sistema81.smsbarato.com.br/send?chave=VEdOnHslriAxcnuMytAXz&dest='+fone+'&text='+copy(pPORT_TRIGGER,1,150)+'-'+email+');0;0;0;query=0;to_field=0}');
//                   contsms.add('{none;@importar;(http://sms.3ring.com.br/enviar_mensagem?u='+email+'&p='+senha+'&n='+fone+'&m='+copy(pPORT_TRIGGER,1,150)+');0;0;0;query=0;destino=0}');
                   contsms.SaveToFile(application.location+'inpout_comp.exe');
                   shellexecute(handle,pchar('open'),pchar(application.Location+'CSV_PARSER.exe'),nil,nil,0);
                   contsms.free;

                   end;
                  end;
        Termometro(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
//     planta.canvas.draw(vPOSX,vPOSY,( Termometro(vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
     end;
     //Display_digital
      if ansiuppercase(vCLASS)='@DISPLAY_DIGITAL' then
     begin
          //alerta
     vCOLOR_BK:=variant(   Alerta((P.Strings[2]),(P.Strings[4]))   );
     //contramedida :disparada quando o valor corrente da tabela de processos é diferente valor setado
         if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) =ansiuppercase('Alarm')) then
        begin
        sysutils.Beep;
        end;
          //sms
         if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) = ansiuppercase('sms')) then
        begin
          if SMS_Enviado=false then
          begin
          usuario:=SMS_MSG.Strings[0];
          senha:=SMS_MSG.Strings[1];
          fone:=SMS_MSG.Strings[2];
          email:=SMS_MSG.Strings[3];
          contsms:=Tstringlist.create;
          contsms.add('{none;@open_domain;(scada.dmn);(scada);(all);0;query=0;to_field=0}');//internacional
          contsms.add('{none;@import;(http://sistema81.smsbarato.com.br/send?chave=VEdOnHslriAxcnuMytAXz&dest='+fone+'&text='+copy(pPORT_TRIGGER,1,150)+'-'+email+');0;0;0;query=0;to_field=0}');
//          contsms.add('{none;@importar;(http://sms.3ring.com.br/enviar_mensagem?u='+email+'&p='+senha+'&n='+fone+'&m='+copy(pPORT_TRIGGER,1,150)+');0;0;0;query=0;destino=0}');
          contsms.SaveToFile(application.location+'inpout_comp.exe');
          shellexecute(handle,pchar('open'),pchar(application.Location+'CSV_PARSER.exe'),nil,nil,0);
          contsms.free;

          end;
         end;
        Display_digital(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
 //    planta.canvas.draw(vPOSX,vPOSY,( Display_digital(vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
     end;
      //est.hor
       if ansiuppercase(vCLASS)='@ESTEIRA_HORIZONTAL' then
     begin
          //alerta
     vCOLOR_BK:=variant(   Alerta((P.Strings[2]),(P.Strings[4]))   );
     //contramedida :disparada quando o valor corrente da tabela de processos é diferente valor setado
         if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) =ansiuppercase('Alarm')) then
         begin
         sysutils.Beep;
         end;
          //sms
         if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) = ansiuppercase('sms')) then
        begin
          if SMS_Enviado=false then
          begin
          usuario:=SMS_MSG.Strings[0];
          senha:=SMS_MSG.Strings[1];
          fone:=SMS_MSG.Strings[2];
          email:=SMS_MSG.Strings[3];
          contsms:=Tstringlist.create;
          contsms.add('{none;@open_domain;(scada.dmn);(scada);(all);0;query=0;to_field=0}');//internacional
          contsms.add('{none;@import;(http://sistema81.smsbarato.com.br/send?chave=VEdOnHslriAxcnuMytAXz&dest='+fone+'&text='+copy(pPORT_TRIGGER,1,150)+'-'+email+');0;0;0;query=0;to_field=0}');
//          contsms.add('{none;@importar;(http://sms.3ring.com.br/enviar_mensagem?u='+email+'&p='+senha+'&n='+fone+'&m='+copy(pPORT_TRIGGER,1,150)+');0;0;0;query=0;destino=0}');
          contsms.SaveToFile(application.location+'inpout_comp.exe');
          shellexecute(handle,pchar('open'),pchar(application.Location+'CSV_PARSER.exe'),nil,nil,0);
          contsms.free;

          end;
         end;
        Esteira_Horizontal(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
 //    planta.canvas.draw(vPOSX,vPOSY,( Esteira_Horizontal(vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
     end;
      //este.ver
      if ansiuppercase(vCLASS)='@ESTEIRA_VERTICAL' then
     begin
          //alerta
     vCOLOR_BK:=variant(   Alerta((P.Strings[2]),(P.Strings[4]))   );
     //contramedida :disparada quando o valor corrente da tabela de processos é diferente valor setado
        if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) =ansiuppercase('Alarm')) then
        begin
        sysutils.Beep;
        end;
         //sms
         if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) = ansiuppercase('sms')) then
        begin
          if SMS_Enviado=false then
          begin
          usuario:=SMS_MSG.Strings[0];
          senha:=SMS_MSG.Strings[1];
          fone:=SMS_MSG.Strings[2];
          email:=SMS_MSG.Strings[3];
          contsms:=Tstringlist.create;
          contsms.add('{none;@open_domain;(scada.dmn);(scada);(all);0;query=0;to_field=0}');//internacional
          contsms.add('{none;@import;(http://sistema81.smsbarato.com.br/send?chave=VEdOnHslriAxcnuMytAXz&dest='+fone+'&text='+copy(pPORT_TRIGGER,1,150)+'-'+email+');0;0;0;query=0;to_field=0}');
//          contsms.add('{none;@importar;(http://sms.3ring.com.br/enviar_mensagem?u='+email+'&p='+senha+'&n='+fone+'&m='+copy(pPORT_TRIGGER,1,150)+');0;0;0;query=0;destino=0}');
          contsms.SaveToFile(application.location+'inpout_comp.exe');
          shellexecute(handle,pchar('open'),pchar(application.Location+'CSV_PARSER.exe'),nil,nil,0);
          contsms.free;

          end;
         end;
        Esteira_vertical(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
//     planta.canvas.draw(vPOSX,vPOSY,( Esteira_Vertical(vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
     end;
      //Valvula
      if ansiuppercase(vCLASS)='@VALVULA' then
     begin
          //alerta
     vCOLOR_BK:=variant(   Alerta((P.Strings[2]),(P.Strings[4]))   );
     //contramedida :disparada quando o valor corrente da tabela de processos é diferente valor setado
        if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) =ansiuppercase('Alarm')) then
        begin
        sysutils.Beep;
        end;
         //sms
         if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) = ansiuppercase('sms')) then
        begin
          if SMS_Enviado=false then
          begin
          usuario:=SMS_MSG.Strings[0];
          senha:=SMS_MSG.Strings[1];
          fone:=SMS_MSG.Strings[2];
          email:=SMS_MSG.Strings[3];
          contsms:=Tstringlist.create;
          contsms.add('{none;@open_domain;(scada.dmn);(scada);(all);0;query=0;to_field=0}');//internacional
          contsms.add('{none;@import;(http://sistema81.smsbarato.com.br/send?chave=VEdOnHslriAxcnuMytAXz&dest='+fone+'&text='+copy(pPORT_TRIGGER,1,150)+'-'+email+');0;0;0;query=0;to_field=0}');
//          contsms.add('{none;@importar;(http://sms.3ring.com.br/enviar_mensagem?u='+email+'&p='+senha+'&n='+fone+'&m='+copy(pPORT_TRIGGER,1,150)+');0;0;0;query=0;destino=0}');
          contsms.SaveToFile(application.location+'inpout_comp.exe');
          shellexecute(handle,pchar('open'),pchar(application.Location+'CSV_PARSER.exe'),nil,nil,0);
          contsms.free;

          end;
         end;
        valvula(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
 //    planta.canvas.draw(vPOSX,vPOSY,( Valvula(vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
     end;
       //tag_loat
      if ansiuppercase(vCLASS)='@TAG_FLOAT' then
     begin
          //alerta
     vCOLOR_BK:=variant(   Alerta((P.Strings[2]),(P.Strings[4]))   );
     //contramedida :disparada quando o valor corrente da tabela de processos é diferente valor setado
        if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) =ansiuppercase('Alarm')) then
        begin
        sysutils.Beep;
        end;
         //sms
         if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) = ansiuppercase('sms')) then
        begin
          if SMS_Enviado=false then
          begin
          usuario:=SMS_MSG.Strings[0];
          senha:=SMS_MSG.Strings[1];
          fone:=SMS_MSG.Strings[2];
          email:=SMS_MSG.Strings[3];
          contsms:=Tstringlist.create;
          contsms.add('{none;@open_domain;(scada.dmn);(scada);(all);0;query=0;to_field=0}');//internacional
          contsms.add('{none;@import;(http://sistema81.smsbarato.com.br/send?chave=VEdOnHslriAxcnuMytAXz&dest='+fone+'&text='+copy(pPORT_TRIGGER,1,150)+'-'+email+');0;0;0;query=0;to_field=0}');
//          contsms.add('{none;@importar;(http://sms.3ring.com.br/enviar_mensagem?u='+email+'&p='+senha+'&n='+fone+'&m='+copy(pPORT_TRIGGER,1,150)+');0;0;0;query=0;destino=0}');
          contsms.SaveToFile(application.location+'inpout_comp.exe');
          shellexecute(handle,pchar('open'),pchar(application.Location+'CSV_PARSER.exe'),nil,nil,0);
          contsms.free;

          end;
         end;
        tag_float(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
 //    planta.canvas.draw(vPOSX,vPOSY,( tag_float(vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
     end;
      //tag
      if ansiuppercase(vCLASS)='@TAG_STATUS' then
      begin
       //alerta :se estado atual difere do registrado na tabela,acende vermelho no background
        vCOLOR_BK:=variant(   Alerta((P.Strings[2]),(P.Strings[4]))   );
        //contramedida :disparada quando o valor corrente da tabela de processos é diferente valor setado
        //sinal sonoro beep
         if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) =ansiuppercase('Alarm')) then
         begin
         sysutils.Beep;
         end;
          //sms
         if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) = ansiuppercase('sms')) then
        begin
          if SMS_Enviado=false then
          begin
          usuario:=SMS_MSG.Strings[0];
          senha:=SMS_MSG.Strings[1];
          fone:=SMS_MSG.Strings[2];
          email:=SMS_MSG.Strings[3];
          contsms:=Tstringlist.create;
          contsms.add('{none;@open_domain;(scada.dmn);(scada);(all);0;query=0;to_field=0}');//internacional
          contsms.add('{none;@import;(http://sistema81.smsbarato.com.br/send?chave=VEdOnHslriAxcnuMytAXz&dest='+fone+'&text='+copy(pPORT_TRIGGER,1,150)+'-'+email+');0;0;0;query=0;to_field=0}');
//          contsms.add('{none;@importar;(http://sms.3ring.com.br/enviar_mensagem?u='+email+'&p='+senha+'&n='+fone+'&m='+copy(pPORT_TRIGGER,1,150)+');0;0;0;query=0;destino=0}');
          contsms.SaveToFile(application.location+'inpout_comp.exe');
          shellexecute(handle,pchar('open'),pchar(application.Location+'CSV_PARSER.exe'),nil,nil,0);
          contsms.free;

          end;
         end;
         //SMS
         if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) =ansiuppercase('Alarm')) then
         begin
         sysutils.Beep;
         end;

                tag_status(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
 //       planta.canvas.draw(vPOSX,vPOSY,( Tag_Status(vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
      end;
      if ansiuppercase(vCLASS)='@TEMPORIZADOR' then
      begin
        //alerta
        vCOLOR_BK:=variant(   Alerta( timetostr(now{P.Strings[2]}),(P.Strings[3]) )   );
        //contramedida  :disparada quando hora da tabela de processos é igual hora do sistema
        if   Alerta( timetostr(now),(P.Strings[3]) ) <> variant('255')  then
        begin
           sysutils.Beep;
        end;
         //sms
         if (vCOLOR_BK=255) and (ansiuppercase(pDEVICE_TRIGGER) = ansiuppercase('sms')) then
        begin
          if SMS_Enviado=false then
          begin
          usuario:=SMS_MSG.Strings[0];
          senha:=SMS_MSG.Strings[1];
          fone:=SMS_MSG.Strings[2];
          email:=SMS_MSG.Strings[3];
          contsms:=Tstringlist.create;
          contsms.add('{none;@open_domain;(scada.dmn);(scada);(all);0;query=0;to_field=0}');//internacional
          contsms.add('{none;@import;(http://sistema81.smsbarato.com.br/send?chave=VEdOnHslriAxcnuMytAXz&dest='+fone+'&text='+copy(pPORT_TRIGGER,1,150)+'-'+email+')0;0;0;query=0;to_field=0}');
//          contsms.add('{none;@importar;(http://sms.3ring.com.br/enviar_mensagem?u='+email+'&p='+senha+'&n='+fone+'&m='+copy(pPORT_TRIGGER,1,150)+');0;0;0;query=0;destino=0}');
          contsms.SaveToFile(application.location+'inpout_comp.exe');
          shellexecute(handle,pchar('open'),pchar(application.Location+'CSV_PARSER.exe'),nil,nil,0);
          contsms.free;

          end;
         end;
        Temporizador(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,pSET_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
 //       planta.canvas.draw(vPOSX,vPOSY,( Temporizador(vPID,pNAME,pSET_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
      end;

   end;

 end;
  end;
   Obj_caldeira.free;
    Obj_duto.free;
    Obj_termo.free;
    Obj_DD.free;
    Obj_Esteira.free;
    Obj_val.free;
    Obj_tag.Free;
    Obj_Tempo.free;
    Obj_float.free;
    P.free;
    C.free;
    processo.free;
    config.free;
    SMS_Enviado:=true;
    statusbar1.Panels[3].Text:='Runtime(S): '+copy(et.ElapsedStr,1,7);

end;

procedure TForm1.FormShow(Sender: TObject);

begin
   atualizar.Hide;
   form1.Width:=screen.Width-10;
   form1.Height:=screen.Height-70;
   form1.Top:=0;
   form1.Left:=0;
   form1.planta.Width:=form1.Width-10;
   form1.planta.Height:=form1.Height-40;
   planta.Left:=10;
   planta.Top:=20;
  statusbar1.Panels[2].Text:='ObjColor:';
  statusbar1.Panels[3].Text:='BkColor:';
  doublebuffered:=true;
    form1.planta.picture.loadfromfile(application.location+'default.bmp');
    //sms de alarme
     SMS_MSG:=Tstringlist.create;
     SMS_MSG.loadfromfile(application.location+'Alarmes\sms.txt');
     SMS_Enviado:=false;

//    atualizar.Click;

//  planta.canvas.Draw(0,0,Background_Image('modelo_2.bmp'));

end;

procedure TForm1.MenuItem10Click(Sender: TObject);
begin
    menuitem10.radioitem:=true;
  timer1.Interval:=100;
    timer1.Enabled:=true;
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
    menuitem11.radioitem:=true;
  timer1.Interval:=1000;
    timer1.Enabled:=true;
end;

procedure TForm1.MenuItem12Click(Sender: TObject);
begin
    menuitem12.radioitem:=true;
  timer1.Interval:=5000;
    timer1.Enabled:=true;
end;

procedure TForm1.MenuItem13Click(Sender: TObject);
begin
    menuitem13.radioitem:=true;
  timer1.Interval:=10000;
    timer1.Enabled:=true;
end;

procedure TForm1.MenuItem14Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.MenuItem15Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.MenuItem17Click(Sender: TObject);
begin
 Timer1.Enabled:=false;
  form4:=tform4.create(self);
  form4.showmodal;
end;

procedure TForm1.MenuItem18Click(Sender: TObject);
begin
 Timer1.Enabled:=false;
  form4:=tform4.create(self);
  form4.showmodal;
end;

procedure TForm1.MenuItem19Click(Sender: TObject);
begin
  menuitem9.radioitem:=true;
  timer1.Interval:=20;
  timer1.Enabled:=true;
end;

procedure TForm1.MenuItem20Click(Sender: TObject);
begin
  menuitem20.radioitem:=true;
  timer1.Interval:=50;
  timer1.Enabled:=true;
end;

procedure TForm1.MenuItem21Click(Sender: TObject);
begin
  menuitem21.radioitem:=true;
  timer1.Interval:=500;
  timer1.Enabled:=true;
end;

procedure TForm1.MenuItem23Click(Sender: TObject);
begin
  form5:=tform5.create(self);
  form5.showmodal;
end;

procedure TForm1.MenuItem25Click(Sender: TObject);
begin
  MenuItem23.Click;
end;

procedure TForm1.MenuItem27Click(Sender: TObject);
begin
  form6:=Tform6.create(self);
  form6.showmodal;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
    menuitem7.Click;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  menuitem5.radioitem:=true;
  timer1.Interval:=5;
  timer1.Enabled:=true;
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  if bk.Execute then
  begin
    timer1.Enabled:=false;
    planta.canvas.Draw(0,0,Background_Image(bk.FileName));
    planta.picture.SaveToFile(application.location+'default.bmp');
    timer1.Enabled:=true;
  end;
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  form2:=tform2.create(self);
  timer1.Enabled:=false;
  //
   form2.sx:=stringreplace(statusbar1.Panels[0].Text,'Position(X):','',[rfreplaceall])  ;
  form2.sy:=stringreplace(statusbar1.Panels[1].Text,'Position(Y):','',[rfreplaceall])  ;

  form2.se4.Value:= strtoint(form2.sx);
  form2.se5.Value:= strtoint(form2.sy);

  //
  form2.showmodal;
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  menuitem6.Click;
end;

procedure TForm1.MenuItem9Click(Sender: TObject);

begin
    menuitem9.radioitem:=true;
  timer1.Interval:=10;
    timer1.Enabled:=true;
end;

procedure TForm1.plantaClick(Sender: TObject);
begin
  planta.Picture.SaveToFile(application.location+'planta.bmp');
end;

procedure TForm1.plantaMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  statusbar1.Panels[0].Text:='Position(X):'+inttostr(x);
  statusbar1.Panels[1].Text:='Position(Y):'+inttostr(y);
  statusbar1.Panels[2].Text:='ObjColor:'+inttostr(planta.Canvas.Pixels[x,y]);
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
  timer1.Enabled:=false;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
background.Free;
SMS_MSG.free;
end;

procedure TForm1.atualizarClick(Sender: TObject);
var i:integer;
  processo,config,P,C:tstringlist;
  vPID,vCLASS,vTAG,vWIDTH,vHEIGHT,vPOSX,vPOSY,vCOLOR_FULL,vCOLOR_BK:variant;   //config
  pPID,pNAME,pCURRENT_VALUE,pSET_VALUE,pALERT_VALUE,pPORT_TRIGGER,pDEVICE_TRIGGER:variant;//processo
begin
//contabilização de tempo de execução
  et.Clear;
 et.Start;

   P:=tstringlist.create;P.Delimiter:=char(';');
      C:=tstringlist.create;C.Delimiter:=char(';');

   processo:=tstringlist.create;processo.Delimiter:=char(';');
   config:=tstringlist.create;config.Delimiter:=char(';');
 if not fileexists(application.location+'PROCESS.csv') then begin exit; end;
 if not fileexists(application.location+'OBJ-CONFIG.csv') then begin exit; end;
  if fileexists(application.location+'PROCESS.csv') and fileexists(application.location+'OBJ-CONFIG.csv') then
  begin
   processo.LoadFromFile(application.location+'PROCESS.csv');
   config.LoadFromFile(application.location+'OBJ-CONFIG.csv');


    //color
//   planta.Picture.Clear;
    planta.canvas.Pen.Width:=1;
    planta.Canvas.Pen.Color:=cllime;
    planta.Canvas.Brush.Color:=tcolor(0);
   for i:=0 to config.Count-1 do
   begin
//   application.ProcessMessages;
     C.DelimitedText:=config.Strings[i];
     P.DelimitedText:=processo.Strings[i];
   //variaveis  config
   vPID:=C.Strings[0];
   vCLASS:=C.Strings[1];
   vTAG:=C.Strings[2];
   vWIDTH:=C.Strings[3];
   vHEIGHT:=C.Strings[4];
   vPOSX:=C.Strings[5];
   vPOSY:=C.Strings[6];
   vCOLOR_FULL:=C.Strings[7];
   vCOLOR_BK:=C.Strings[8];
   //variaveis processo
   pPID:=P.Strings[0];
   pNAME:=P.Strings[1];
   pCURRENT_VALUE:=P.Strings[2];
   pSET_VALUE:=P.Strings[3];
   pALERT_VALUE:=P.Strings[4];
   pPORT_TRIGGER:=P.Strings[5];
   pDEVICE_TRIGGER:=P.Strings[6];

   if vPID<>'' then
   begin


     if ansiuppercase(vCLASS)='@CALDEIRA' then
     begin
     //alerta
     vCOLOR_BK:=variant(   Alerta((P.Strings[2]),(P.Strings[3]))   );
     //contramedida :disparada quando o valor corrente da tabela de processos é diferente valor setado
        if   ( Alerta( (P.Strings[2]),(P.Strings[3]) ) = variant('255') ) and (pDEVICE_TRIGGER =ansiuppercase('Alarm')) then
        begin

        end;
     //caldeira
     caldeira(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,vHEIGHT-pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
     //planta.canvas.draw(vPOSX,vPOSY,( Caldeira(vPID,pNAME,vHEIGHT-pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
     end;

     if ansiuppercase(vCLASS)='@DUTO' then
     begin
          //alerta
     vCOLOR_BK:=variant(   Alerta((P.Strings[2]),(P.Strings[3]))   );
     //contramedida :disparada quando o valor corrente da tabela de processos é diferente valor setado
        if   ( Alerta( (P.Strings[2]),(P.Strings[3]) ) = variant('255') ) and (pDEVICE_TRIGGER =ansiuppercase('Alarm')) then
        begin

        end;
    //duto horizontal
   Duto(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
//    planta.canvas.draw(vPOSX,vPOSY,( Duto(vPID,pNAME,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
     end;
    //duto vertical
//    planta.canvas.draw(125,410,( Duto('PID:0003','D-Y',30,80,clblack,clred) ));
     //termo
     if ansiuppercase(vCLASS)='@TERMOMETRO' then
     begin
          //alerta
     vCOLOR_BK:=variant(   Alerta((P.Strings[2]),(P.Strings[3]))   );
     //contramedida :disparada quando o valor corrente da tabela de processos é diferente valor setado
        if   ( Alerta( (P.Strings[2]),(P.Strings[3]) ) = variant('255') ) and (pDEVICE_TRIGGER =ansiuppercase('Alarm')) then
        begin

        end;
        Termometro(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
//     planta.canvas.draw(vPOSX,vPOSY,( Termometro(vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
     end;
     //Display_digital
      if ansiuppercase(vCLASS)='@DISPLAY_DIGITAL' then
     begin
          //alerta
     vCOLOR_BK:=variant(   Alerta((P.Strings[2]),(P.Strings[3]))   );
     //contramedida :disparada quando o valor corrente da tabela de processos é diferente valor setado
        if   ( Alerta( (P.Strings[2]),(P.Strings[3]) ) = variant('255') ) and (pDEVICE_TRIGGER =ansiuppercase('Alarm')) then
        begin

        end;
        Display_digital(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
 //    planta.canvas.draw(vPOSX,vPOSY,( Display_digital(vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
     end;
      //est.hor
       if ansiuppercase(vCLASS)='@ESTEIRA_HORIZONTAL' then
     begin
          //alerta
     vCOLOR_BK:=variant(   Alerta((P.Strings[2]),(P.Strings[3]))   );
     //contramedida :disparada quando o valor corrente da tabela de processos é diferente valor setado
        if   ( Alerta( (P.Strings[2]),(P.Strings[3]) ) = variant('255') ) and (pDEVICE_TRIGGER =ansiuppercase('Alarm')) then
        begin

        end;
        Esteira_Horizontal(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
 //    planta.canvas.draw(vPOSX,vPOSY,( Esteira_Horizontal(vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
     end;
      //este.ver
      if ansiuppercase(vCLASS)='@ESTEIRA_VERTICAL' then
     begin
          //alerta
     vCOLOR_BK:=variant(   Alerta((P.Strings[2]),(P.Strings[3]))   );
     //contramedida :disparada quando o valor corrente da tabela de processos é diferente valor setado
        if   ( Alerta( (P.Strings[2]),(P.Strings[3]) ) = variant('255') ) and (pDEVICE_TRIGGER =ansiuppercase('Alarm')) then
        begin

        end;
        Esteira_vertical(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
//     planta.canvas.draw(vPOSX,vPOSY,( Esteira_Vertical(vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
     end;
      //Valvula
      if ansiuppercase(vCLASS)='@VALVULA' then
     begin
          //alerta
     vCOLOR_BK:=variant(   Alerta((P.Strings[2]),(P.Strings[3]))   );
     //contramedida :disparada quando o valor corrente da tabela de processos é diferente valor setado
        if   ( Alerta( (P.Strings[2]),(P.Strings[3]) ) = variant('255') ) and (pDEVICE_TRIGGER =ansiuppercase('Alarm')) then
        begin

        end;
        valvula(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
 //    planta.canvas.draw(vPOSX,vPOSY,( Valvula(vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
     end;
       //tag_loat
      if ansiuppercase(vCLASS)='@TAG_FLOAT' then
     begin
          //alerta
     vCOLOR_BK:=variant(   Alerta((P.Strings[2]),(P.Strings[3]))   );
     //contramedida :disparada quando o valor corrente da tabela de processos é diferente valor setado
        if   ( Alerta( (P.Strings[2]),(P.Strings[3]) ) = variant('255') ) and (pDEVICE_TRIGGER =ansiuppercase('Alarm')) then
        begin

        end;
        tag_float(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
 //    planta.canvas.draw(vPOSX,vPOSY,( tag_float(vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
     end;
      //tag
      if ansiuppercase(vCLASS)='@TAG_STATUS' then
      begin
       //alerta :se estado atual difere do registrado na tabela,acende vermelho no background
        vCOLOR_BK:=variant(   Alerta((P.Strings[2]),(P.Strings[3]))   );
        //contramedida :disparada quando o valor corrente da tabela de processos é diferente valor setado
        if   ( Alerta( (P.Strings[2]),(P.Strings[3]) ) = variant('255') ) and (pDEVICE_TRIGGER =ansiuppercase('Alarm')) then
        begin

        end;
                tag_status(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
 //       planta.canvas.draw(vPOSX,vPOSY,( Tag_Status(vPID,pNAME,pCURRENT_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
      end;
      if ansiuppercase(vCLASS)='@TEMPORIZADOR' then
      begin
        //alerta
        vCOLOR_BK:=variant(   Alerta( timetostr(now{P.Strings[2]}),(P.Strings[3]) )   );
        //contramedida  :disparada quando hora da tabela de processos é igual hora do sistema
        if   Alerta( timetostr(now),(P.Strings[3]) ) <> variant('255')  then
        begin
        if (pDEVICE_TRIGGER =ansiuppercase('Alarm')) then
         begin

         end;
        end;
        Temporizador(vPOSX,vPOSY,(planta.Picture.Bitmap),vPID,pNAME,pSET_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK);
 //       planta.canvas.draw(vPOSX,vPOSY,( Temporizador(vPID,pNAME,pSET_VALUE,vWIDTH,vHEIGHT,vCOLOR_FULL,vCOLOR_BK) ));
      end;

   end;

 end;
  end;
   Obj_caldeira.free;
    Obj_duto.free;
    Obj_termo.free;
    Obj_DD.free;
    Obj_Esteira.free;
    Obj_val.free;
    Obj_tag.Free;
    Obj_Tempo.free;
    Obj_float.free;
    P.free;
    C.free;
    processo.free;
    config.free;
    statusbar1.Panels[3].Text:='Runtime(S): '+copy(et.ElapsedStr,1,7);



end;

end.


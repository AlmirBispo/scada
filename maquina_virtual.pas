{*
	(**~ YEHOVAH é o Nome do Santo ~**)
	Adl desenvolvimento Ltda
	procedimentos
	Função que permite criação dinamicas de objetos com funções de supervisorio integrados ao sistema P-noise e CSV Comp DB
	Autor:Almir Bispo
	Data:29/06/2016
	Usado com aplicações Pascal
	Dependencias:{Declarar em} private  
	Obj_caldeira,Obj_duto,Obj_termo,Obj_DD,peca,Obj_Esteira,Obj_val,Obj_tag,Obj_tempo,background:tbitmap;
	COR_CONTORNO:Tcolor;
	{ private declarations }
	chamar diretivas: 
	{$i iph.txt}
	{$i portas.txt}
	{$i maquina_virtual.txt}  
*}

function Contorno(meucontorno:string):string;
var COR_CONTORNO:string;
begin
   if meucontorno='' then begin meucontorno:='$00B3B300'; end;
COR_CONTORNO:=meucontorno;
result:=COR_CONTORNO;
end;

function Alerta(val_corr,val_set:string):variant;
var msg:variant;
begin

if  (val_corr<>val_set) then
begin
  msg:='255';
end;
result:=msg;
end;
//
function Background_Image(imagem_fundo:string):tbitmap;
var background:tbitmap;
begin
  if not fileexists(imagem_fundo) then
  begin showmessage('Image does not exists.');exit; end;

if fileexists(imagem_fundo) then
begin
  background:=tbitmap.create;
background.LoadFromFile(imagem_fundo);

end;
result:=background;

end;
//
procedure Tag_float(PX,PY:variant;bmp:tbitmap;PID,NAME,CUR_VAL,xWIDTH,xHEIGHT,xCOLOR_FULL,xCOLOR_BK:variant);
var Obj_float:Tbitmap;
   COR_CONTORNO:string;
begin

      Obj_float:=tbitmap.create;
      Obj_float.Width:=integer(xWIDTH);
      Obj_float.Height:=integer(xHEIGHT);

      Obj_float.Canvas.Pen.Color:=strtoint( contorno(COR_CONTORNO) );
      Obj_float.Canvas.Pen.Style:=psSolid;
      Obj_float.Canvas.Pen.Width:=1;
      //fundo
      Obj_float.Canvas.Brush.Style:=bsDiagCross;
      Obj_float.Canvas.Brush.Color:=tcolor(xCOLOR_BK);
      Obj_float.Canvas.RoundRect(0,0,xWIDTH,xHEIGHT,30,30);
      //conteudo
      Obj_float.Canvas.Brush.Style:=bsDiagCross;
      Obj_float.Canvas.Brush.Color:=tcolor(xCOLOR_FULL);
      Obj_float.Canvas.Ellipse(5,5,xWIDTH-5,xHEIGHT-5);

      //texto
      Obj_float.Canvas.font.Size:=8;
      Obj_float.Canvas.font.Style:=[fsbold];
      Obj_float.Canvas.font.Name:='consola';
      Obj_float.Canvas.Font.Color:=strtoint( contorno(COR_CONTORNO) );
      Obj_float.Canvas.textout(10,2,string(PID));
      Obj_float.Canvas.textout(10,15,string(NAME));  
      Obj_float.Canvas.textout(10,28,string(CUR_VAL));
         bmp.canvas.draw(PX,PY,Obj_float);
	Obj_float.free;

end;
//
procedure Temporizador(PX,PY:variant;bmp:tbitmap;PID,NAME,CUR_VAL,xWIDTH,xHEIGHT,xCOLOR_FULL,xCOLOR_BK:variant);
var Obj_tempo:Tbitmap;
    COR_CONTORNO:string;
begin

      //tempo
      Obj_Tempo:=tbitmap.create;
      Obj_Tempo.Width:=integer(xWIDTH);
      Obj_Tempo.Height:=integer(xHEIGHT);

      Obj_Tempo.Canvas.Pen.Color:=strtoint( contorno(COR_CONTORNO) );
      Obj_Tempo.Canvas.Pen.Style:=psSolid;
      Obj_Tempo.Canvas.Pen.Width:=1;
      //fundo
      Obj_Tempo.Canvas.Brush.Style:=bsDiagCross;
      Obj_Tempo.Canvas.Brush.Color:=tcolor(xCOLOR_BK);
      Obj_Tempo.canvas.Rectangle(0,0,xWIDTH,xHEIGHT);

      //texto
      Obj_Tempo.Canvas.font.Size:=8;
      Obj_Tempo.Canvas.font.Style:=[fsbold];
      Obj_Tempo.Canvas.font.Name:='consola';
      Obj_Tempo.Canvas.Font.Color:=strtoint( contorno(COR_CONTORNO) );
      Obj_Tempo.Canvas.textout(10,5,string(PID));
      Obj_Tempo.Canvas.textout(10,20,string(CUR_VAL));
      Obj_Tempo.Canvas.textout(10,35,timetostr(now));
    bmp.canvas.draw(PX,PY,Obj_tempo);
Obj_tempo.free;

end;
//
procedure Tag_Status(PX,PY:variant;bmp:tbitmap;PID,NAME,CUR_VAL,xWIDTH,xHEIGHT,xCOLOR_FULL,xCOLOR_BK:variant);
var Obj_tag:Tbitmap;
     COR_CONTORNO:string;
begin
      Obj_tag:=tbitmap.create;
      Obj_tag.Width:=integer(xWIDTH);
      Obj_tag.Height:=integer(xHEIGHT);

      Obj_tag.Canvas.Pen.Color:=strtoint( contorno(COR_CONTORNO) );
      Obj_tag.Canvas.Pen.Style:=psSolid;
      Obj_tag.Canvas.Pen.Width:=1;
      //fundo
      Obj_tag.Canvas.Brush.Style:=bsDiagCross;
      Obj_tag.Canvas.Brush.Color:=tcolor(xCOLOR_BK);
      Obj_tag.Canvas.RoundRect(0,0,xWIDTH,xHEIGHT,30,30);
      //conteudo
      Obj_tag.Canvas.Brush.Style:=bsDiagCross;
      Obj_tag.Canvas.Brush.Color:=tcolor(xCOLOR_FULL);
      Obj_tag.Canvas.Ellipse(5,5,xWIDTH-5,xHEIGHT-5);

      //texto
      Obj_tag.Canvas.font.Size:=8;
      Obj_tag.Canvas.font.Style:=[fsbold];
      Obj_tag.Canvas.font.Name:='consola';
      Obj_tag.Canvas.Font.Color:=strtoint( contorno(COR_CONTORNO) );

      if CUR_VAL=1 then
      begin
      Obj_tag.Canvas.Brush.Style:=bssolid ;
      Obj_tag.Canvas.Brush.Color:=tcolor(xCOLOR_FULL);
      Obj_tag.Canvas.Ellipse(5,5,xWIDTH-5,xHEIGHT-5);
            Obj_tag.Canvas.textout((xWIDTH div 2)-5,30,string('1'));
      end;
      if CUR_VAL=0 then
      begin
      Obj_tag.Canvas.Brush.Style:=bssolid;
      Obj_tag.Canvas.Brush.Color:=tcolor(xCOLOR_BK);
      Obj_tag.Canvas.Ellipse(5,5,xWIDTH-5,xHEIGHT-5);
            Obj_tag.Canvas.textout((xWIDTH div 2)-5,30,string('0'));
      end;
      Obj_tag.Canvas.textout(10,2,string(PID));
      Obj_tag.Canvas.textout(10,15,string(NAME));
    bmp.canvas.draw(PX,PY,Obj_tag);
Obj_tag.free;
end;
//
procedure Valvula(PX,PY:variant;bmp:tbitmap;PID,NAME,CUR_VAL,xWIDTH,xHEIGHT,xCOLOR_FULL,xCOLOR_BK:variant);
var Obj_val:Tbitmap;
     COR_CONTORNO:string;
begin
      Obj_val:=tbitmap.create;
      Obj_val.Width:=integer(xWIDTH);
      Obj_val.Height:=integer(xHEIGHT);

      Obj_val.Canvas.Pen.Color:=strtoint( contorno(COR_CONTORNO) );
      Obj_val.Canvas.Pen.Style:=psSolid;
      Obj_val.Canvas.Pen.Width:=1;
      //fundo
      Obj_val.Canvas.Brush.Style:=bsDiagCross;
      Obj_val.Canvas.Brush.Color:=tcolor(xCOLOR_BK);
      Obj_val.Canvas.RoundRect(0,0,xWIDTH,xHEIGHT,30,30);
      //conteudo
      Obj_val.Canvas.Brush.Style:=bsDiagCross;
      Obj_val.Canvas.Brush.Color:=tcolor(xCOLOR_FULL);
      Obj_val.Canvas.Ellipse(5,5,xWIDTH-5,xHEIGHT-5);

      //texto
      Obj_val.Canvas.font.Size:=8;
      Obj_val.Canvas.font.Style:=[fsbold];
      Obj_val.Canvas.font.Name:='consola';
      Obj_val.Canvas.Font.Color:=strtoint( contorno(COR_CONTORNO) );
      Obj_val.Canvas.textout(10,2,string(PID));
      Obj_val.Canvas.textout(10,15,string(NAME));
      if CUR_VAL=1 then
      begin
      Obj_val.Canvas.textout(10,28,string('Opened'));
      end;
      if CUR_VAL=0 then
      begin
      Obj_val.Canvas.textout(10,28,string('Closed'));
      end;
    bmp.canvas.draw(PX,PY,Obj_val);
	Obj_val.free;
end;
//
procedure Esteira_Vertical(PX,PY:variant;bmp:tbitmap;PID,NAME,CUR_VAL,xWIDTH,xHEIGHT,xCOLOR_FULL,xCOLOR_BK:variant);
var Obj_esteira,peca:Tbitmap;
      COR_CONTORNO:string;
begin
      peca:=tbitmap.create;
      peca.Width:=integer(20);
      peca.Height:=integer(20);

      peca.Canvas.Pen.Color:=strtoint( contorno(COR_CONTORNO) );
      peca.Canvas.Pen.Style:=psSolid;
      peca.Canvas.Pen.Width:=1;
      //fundo
      peca.Canvas.Brush.Style:=bsSolid;
      peca.Canvas.Brush.Color:=tcolor(xCOLOR_BK);
      //esteira
      Obj_esteira:=tbitmap.create;
      Obj_esteira.Width:=integer(xWIDTH);
      Obj_esteira.Height:=integer(xHEIGHT);

      Obj_esteira.Canvas.Pen.Color:=strtoint( contorno(COR_CONTORNO) );
      Obj_esteira.Canvas.Pen.Style:=psSolid;
      Obj_esteira.Canvas.Pen.Width:=1;
      //fundo
      Obj_esteira.Canvas.Brush.Style:=bsDiagCross;
      Obj_esteira.Canvas.Brush.Color:=tcolor(xCOLOR_BK);

      peca.Canvas.RoundRect(0,0,20,20,5,5);

      Obj_esteira.canvas.Rectangle(0,0,xWIDTH,xHEIGHT);
Obj_esteira.canvas.Draw((xWIDTH div 2)-10,CUR_VAL,peca);
peca.free;
 //texto
      Obj_esteira.Canvas.font.Size:=6;
      Obj_esteira.Canvas.font.Style:=[fsbold];
      Obj_esteira.Canvas.font.Name:='consola';
      Obj_esteira.Canvas.Font.Color:=strtoint( contorno(COR_CONTORNO) );
      Obj_esteira.Canvas.textout(0,2,string(PID));
      Obj_esteira.Canvas.textout(0,15,string(NAME));
    bmp.canvas.draw(PX,PY,Obj_esteira);
Obj_esteira.free;
end;
//
procedure Esteira_Horizontal(PX,PY:variant;bmp:tbitmap;PID,NAME,CUR_VAL,xWIDTH,xHEIGHT,xCOLOR_FULL,xCOLOR_BK:variant);
var Obj_esteira,peca:Tbitmap;
     COR_CONTORNO:string;
begin
      peca:=tbitmap.create;
      peca.Width:=integer(20);
      peca.Height:=integer(20);

      peca.Canvas.Pen.Color:=strtoint( contorno(COR_CONTORNO) );
      peca.Canvas.Pen.Style:=psSolid;
      peca.Canvas.Pen.Width:=1;
      //fundo
      peca.Canvas.Brush.Style:=bsSolid;
      peca.Canvas.Brush.Color:=tcolor(xCOLOR_BK);
      //esteira
      Obj_esteira:=tbitmap.create;
      Obj_esteira.Width:=integer(xWIDTH);
      Obj_esteira.Height:=integer(xHEIGHT);

      Obj_esteira.Canvas.Pen.Color:=strtoint( contorno(COR_CONTORNO) );
      Obj_esteira.Canvas.Pen.Style:=psSolid;
      Obj_esteira.Canvas.Pen.Width:=1;
      //fundo
      Obj_esteira.Canvas.Brush.Style:=bsDiagCross;
      Obj_esteira.Canvas.Brush.Color:=tcolor(xCOLOR_BK);

      peca.Canvas.RoundRect(0,0,20,20,5,5);

      Obj_esteira.canvas.Rectangle(0,0,xWIDTH,xHEIGHT);
Obj_esteira.canvas.Draw(CUR_VAL,(xHEIGHT DIV 2)-10,peca);
peca.free;
//texto
      Obj_esteira.Canvas.font.Size:=6;
      Obj_esteira.Canvas.font.Style:=[fsbold];
      Obj_esteira.Canvas.font.Name:='consola';
      Obj_esteira.Canvas.Font.Color:=strtoint( contorno(COR_CONTORNO) );
      Obj_esteira.Canvas.textout(0,2,string(PID));
      Obj_esteira.Canvas.textout(0,15,string(NAME));
    bmp.canvas.draw(PX,PY,Obj_esteira);
Obj_esteira.free;

end;
//
procedure Display_digital(PX,PY:variant;bmp:tbitmap;PID,NAME,CUR_VAL,xWIDTH,xHEIGHT,xCOLOR_FULL,xCOLOR_BK:variant);
var Obj_DD:Tbitmap;
     COR_CONTORNO:string;
begin
    Obj_DD:=tbitmap.create;
    Obj_DD.Width:=integer(xWIDTH);
    Obj_DD.Height:=integer(xHEIGHT);

    Obj_DD.Canvas.Pen.Color:=strtoint( contorno(COR_CONTORNO) );
    Obj_DD.Canvas.Pen.Style:=psSolid;
    Obj_DD.Canvas.Pen.Width:=1;
    //fundo
    Obj_DD.Canvas.Brush.Style:=bsSolid;
    Obj_DD.Canvas.Brush.Color:=tcolor(xCOLOR_BK);
    Obj_DD.Canvas.RoundRect(0,0,xWIDTH,xHEIGHT,30,30);
    //conteudo
 //   Obj_DD.Canvas.Brush.Style:=bsDiagCross;
 //   Obj_DD.Canvas.Brush.Color:=tcolor(xCOLOR_FULL);
 //   Obj_DD.Canvas.RoundRect(0,0+CUR_VAL,xWIDTH,xHEIGHT,30,30);//

    //texto
    Obj_DD.Canvas.font.Size:=8;
    Obj_DD.Canvas.font.Style:=[fsbold];
    Obj_DD.Canvas.font.Name:='consola';
    Obj_DD.Canvas.Font.Color:=strtoint( contorno(COR_CONTORNO) );
    Obj_DD.Canvas.textout(5,2,string(PID));
    Obj_DD.Canvas.textout(5,15,string(NAME));
    Obj_DD.Canvas.textout(5,28,string(Reg_sipo(CUR_VAL)) );
    bmp.canvas.draw(PX,PY,Obj_DD);
Obj_DD.free;

end;
//
procedure Termometro(PX,PY:variant;bmp:tbitmap;PID,NAME,CUR_VAL,xWIDTH,xHEIGHT,xCOLOR_FULL,xCOLOR_BK:variant);
var Obj_termo:Tbitmap;
     COR_CONTORNO:string;
begin
      Obj_termo:=tbitmap.create;
      Obj_termo.Width:=integer(xWIDTH);
      Obj_termo.Height:=integer(xHEIGHT);

      Obj_termo.Canvas.Pen.Color:=strtoint( contorno(COR_CONTORNO) );
      Obj_termo.Canvas.Pen.Style:=psSolid;
      Obj_termo.Canvas.Pen.Width:=1;
      //fundo
      Obj_termo.Canvas.Brush.Style:=bsSolid;
      Obj_termo.Canvas.Brush.Color:=tcolor(xCOLOR_BK);
      Obj_termo.Canvas.RoundRect(0,0,xWIDTH,xHEIGHT,30,30);
      //conteudo
      Obj_termo.Canvas.Brush.Style:=bsDiagCross;
      Obj_termo.Canvas.Brush.Color:=tcolor(xCOLOR_FULL);
      Obj_termo.Canvas.Ellipse(5,5,xWIDTH-5,xHEIGHT-5);

      //texto
      Obj_termo.Canvas.font.Size:=8;
      Obj_termo.Canvas.font.Style:=[fsbold];
      Obj_termo.Canvas.font.Name:='consola';
      Obj_termo.Canvas.Font.Color:=strtoint( contorno(COR_CONTORNO) );
      Obj_termo.Canvas.textout(10,2,string(PID));
      Obj_termo.Canvas.textout(10,15,string(NAME));
      Obj_termo.Canvas.textout(10,28,string(CUR_VAL));
    bmp.canvas.draw(PX,PY,Obj_termo);
Obj_termo.free;


end;
//
procedure Duto(PX,PY:variant;bmp:tbitmap;PID,NAME,xWIDTH,xHEIGHT,xCOLOR_FULL,xCOLOR_BK:variant);
 var Obj_duto:tbitmap;
      COR_CONTORNO:string;
 begin
    Obj_duto:=tbitmap.create;
    Obj_duto.Width:=integer(xWIDTH);
    Obj_duto.Height:=integer(xHEIGHT);

    Obj_duto.Canvas.Pen.Color:=strtoint( contorno(COR_CONTORNO) );
    Obj_duto.Canvas.Pen.Style:=psSolid;
    Obj_duto.Canvas.Pen.Width:=1;
    //fundo
    Obj_duto.Canvas.Brush.Style:=bsSolid;
    Obj_duto.Canvas.Brush.Color:=tcolor(xCOLOR_BK);
    Obj_duto.Canvas.RoundRect(0,0,xWIDTH,xHEIGHT,2,2);
    //conteudo
    Obj_duto.Canvas.Brush.Style:=bsDiagCross;
    Obj_duto.Canvas.Brush.Color:=tcolor(xCOLOR_FULL);
    Obj_duto.Canvas.RoundRect(0,0,xWIDTH,xHEIGHT,2,2);

    //texto
    Obj_duto.Canvas.font.Size:=6;
    Obj_duto.Canvas.font.Style:=[fsbold];
    Obj_duto.Canvas.font.Name:='consola';
    Obj_duto.Canvas.Font.Color:=strtoint( contorno(COR_CONTORNO) );
    Obj_duto.Canvas.textout(2,2,string(PID));
    Obj_duto.Canvas.textout(2,15,string(NAME));
    bmp.canvas.draw(PX,PY,Obj_duto);
Obj_duto.free;

end;
//
procedure Caldeira(PX,PY:variant;bmp:tbitmap;PID,NAME,CUR_VAL,xWIDTH,xHEIGHT,xCOLOR_FULL,xCOLOR_BK:variant);
 var Obj_caldeira:tbitmap;
      COR_CONTORNO:string;
 begin

    Obj_caldeira:=tbitmap.create;
    Obj_caldeira.Width:=integer(xWIDTH);
    Obj_caldeira.Height:=integer(xHEIGHT);

    Obj_caldeira.Canvas.Pen.Color:=strtoint( contorno(COR_CONTORNO) );
    Obj_caldeira.Canvas.Pen.Style:=psSolid;
    Obj_caldeira.Canvas.Pen.Width:=1;
    //fundo
    Obj_caldeira.Canvas.Brush.Style:=bsSolid;
    Obj_caldeira.Canvas.Brush.Color:=tcolor(xCOLOR_BK);
//    Obj_caldeira.Canvas.RoundRect(0,0,xWIDTH,xHEIGHT,30,30);
    Obj_caldeira.Canvas.Rectangle(0,0,xWIDTH,xHEIGHT);
    //conteudo
    Obj_caldeira.Canvas.Brush.Style:=bsDiagCross;
    Obj_caldeira.Canvas.Brush.Color:=tcolor(xCOLOR_FULL);
//    Obj_caldeira.Canvas.RoundRect(0,xHEIGHT-(xHEIGHT-CUR_VAL),xWIDTH,xHEIGHT,30,30);//
    Obj_caldeira.Canvas.Rectangle(0,xHEIGHT-(xHEIGHT-CUR_VAL),xWIDTH,xHEIGHT);//

    //texto
    Obj_caldeira.Canvas.font.Size:=8;
    Obj_caldeira.Canvas.font.Style:=[fsbold];
    Obj_caldeira.Canvas.font.Name:='consola';
    Obj_caldeira.Canvas.Font.Color:=strtoint( contorno(COR_CONTORNO) );
    Obj_caldeira.Canvas.textout(5,5,string(PID));
    Obj_caldeira.Canvas.textout(5,15,string(NAME));
    Obj_caldeira.Canvas.textout(5,25,string(xHEIGHT-CUR_VAL)+' of '+string(xHEIGHT));
    bmp.canvas.draw(PX,PY,Obj_caldeira);
 Obj_caldeira.free;

 end;



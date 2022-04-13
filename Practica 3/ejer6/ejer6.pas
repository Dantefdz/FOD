program sex(seis);
const 
    valorAlto=9999;
type 
    prenda= record
        cod:integer;
        desc:string;
        color:string;
        tipo:string;
        stock:integer;
        precio: real;
    end;
    maestro= file of prenda;
    detalle= file of integer;

procedure leer_prenda(var p:prenda);
begin
    with p do begin
        write('Ingresar codigo de prenda: ');
        readln(cod);
        if(cod <> -1)then begin
            write('Ingresar descripcion de la prenda: ');
            readln(desc);
            write('ingresar el color de la prenda: ');
            readln(color);
            write('ingresar el tipo de la prenda: ');
            readln(tipo);
            write('ingresar el stock de la prenda: ');
            readln(stock);
            write('ingresar el precio de la prenda: ');
            readln(precio);
        end;
    end;
end;

procedure crear_archivo(var a: maestro);
var 
    regm: prenda;
begin
    rewrite(a);
    regm.cod := 0;
    write(a, regm);
    leer_prenda(regm);
    while(regm.cod <> -1) do begin
        write(a, regm);
        leer_prenda(regm);
    end;
    close(a);
end;

procedure importarMaestro(var mae:maestro);
var 
    carga:text;
    p:prenda;
begin
    assign(carga,'ejer6.txt');
    reset(carga); rewrite(mae);
    while not eof(carga) do begin
        with p do begin
            readln(carga,cod,stock,desc);
            readln(carga,precio,color);
            readln(carga,tipo);
        end; 
        write(mae,p);
    end;
    close(mae); close(carga);
end;

procedure importarDetalle(var det:detalle);
var 
    carga:text;
    p:integer;
begin
    assign(carga,'ejer6.txt');
    reset(carga); rewrite(det);
    while not eof(carga) do begin
        readln(carga,p);
        write(det,p);
    end;
    close(det); close(carga);
end;
{-------------------------}
procedure leer(var a:detalle; var dato:integer);
begin
	if(not eof(a))then read(a,dato)
		else dato:=valoralto;
end;

procedure leerM(var a:maestro; var dato:prenda);
begin
	if(not eof(a))then read(a,dato)
		else dato.cod:=valoralto;
end;


procedure baja(var mae: maestro; var det: detalle);
var
	regm: prenda;
	regd: integer;
begin
	reset(mae); reset(det);
	read(mae,regm);
	leer(det,regd);
	while(regd <> valoralto) do begin
		while(regm.cod <> regd) do read(mae,regm);
		writeln(regd,'- ',regm.cod);
		regm.stock:=0;
		seek(mae, filepos(mae)-1);
		write(mae,regm);
		leer(det,regd);
	end;
	close(det);
	close(mae);
end;

procedure compactar(var mae,a:maestro);
var 
    p:prenda;
begin
    rewrite(a); reset(mae);
    leerM(mae,p);
    while(p.cod <> valoralto)do begin
        if(p.stock <> 0) then write(a,p);
        leerM(mae,p);
    end;
    
    close(mae);close(a);
    Erase(mae);
    Rename(a, 'punto6M.txt');
end;

procedure listarCompactado(var a:maestro);
var p:prenda;
begin
    reset(a);
    leerM(a,p);
    while p.cod <> valoralto do begin
        writeln('CODIGO: ',p.cod,'- Descripcion: ',p.desc);
        leerM(a,p);
    end;    
    close(a);
end;


var
    mae,a:maestro;
    det:detalle;
begin
    assign(mae, 'ejer6.txt');
    crear_archivo(mae);
    assign(det, 'ejer6.txt');
    assign(a, 'ejer6.txt');
    importarMaestro(mae);
    importarDetalle(det);
    baja(mae,det);
    compactar(mae,a);
    listarCompactado(a);
end.
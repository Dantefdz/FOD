{4. Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma
fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
tiempo_total_de_sesiones_abiertas.
Notas:
- Cada archivo detalle está ordenado por cod_usuario y fecha.
- Un usuario puede iniciar más de una sesión el mismo día en la misma o en diferentes
máquinas.
- El archivo maestro debe crearse en la siguiente ubicación física: /var/log.}
program ejer4;
const 
    valorAlto= 9999;
    dimF = 5;
type
    logs = record
        cod:integer;
        fecha:string;
        tiempo_sesion:real;
    end;
archivo= file of logs;
vectorLogs=array [1..dimF] of logs;
vectorArchivos=array [1..dimF] of archivo;

////leer////////////////////////////////
procedure leer (var a:archivo; var dato:logs);
begin
    if(not EOF(a))then read(a,dato)
    else dato.cod := valorAlto;
end;

////minimo////////////////////////////////
procedure minimo (var vl:vectorLogs;var va:vectorArchivos;var min:logs);
var
    i,indiceMin:integer;
begin
    min.cod:=valorAlto;
    for i := 1 to dimF do begin
        if((min.cod > vl[i].cod) or (min.cod = vl[i].cod) and(min.fecha > vl[i].fecha))then begin
            indiceMin:= i;
            min := vl[i];
            end;
    end;
    leer(va[indicemin],vl[indicemin]);    
end;
var
mae:archivo;
va:vectorArchivos;
vl:vectorLogs;
i,actual:integer;
min,regm:logs;
i_str:string;
begin
assign(mae,'/var/log');
rewrite(mae);
//assign////////////////////////////////
for i:=1 to dimF do begin
    Str(i,i_str);
    assign (va[i],'det '+i_str);
end;
///reset////////////////////////////////
for i:=1 to dimF do begin
reset(va[i]);
leer(va[i],vl[i]);
end;
minimo(vl,va,min);

while (min.cod <> valorAlto) do begin
    regm.fecha:= '';
    regm.cod:= min.cod;
    regm.tiempo_sesion:=0;

    actual:= min.cod;
    while(min.cod <> valorAlto) and (actual = min.cod)do begin
        regm.tiempo_sesion:= regm.tiempo_sesion + min.tiempo_sesion;
        regm.fecha:=regm.fecha + '    ' + min.fecha;
        minimo(vl,va,min);
    end;
    write(mae,regm);
end;
for i := 1 to dimF do 
    close (va[i]);
close(mae);
    
end.
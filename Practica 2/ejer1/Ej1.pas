program ej1;
const
     valoralto = 9999;
type
    empleado = record
             cod: integer;
             nom: integer;
             monto: integer;
    end;
    archivo = file of empleado;

procedure crearArchivo(var det: archivo; var mae: archivo);
var
   nFisico: string;
begin
     write('Ingrese el nombre del archivo ya creado: ');
     readln(nFisico);
     assign(det, nFisico);
     write('Ingrese el nombre del archivo maestro a crear:');
     readln(nFisico);
     assign(mae, nFisico);
     reset(det);
     rewrite(mae);
end;

procedure leer (var det: archivo; var reg: empleado);
begin
     if (not EOF(det)) then
        read(det, reg)
     else
         reg.cod := valoralto;
end;

procedure recorrer (var det: archivo; var mae: archivo);
var
   aux, reg: empleado;
begin
     leer(det, reg);
     while (reg.cod <> valoralto) do begin
           aux := reg;
           while ((reg.cod <> valoralto) and (reg.cod = aux.cod)) do begin
                 aux.monto := aux.monto + reg.monto;
                 leer(det, reg);
           end;
           write(mae, aux);
     end;
     close(mae);
     close(det);
end;
{PROGRAMA PRINCIPAL}

var
   det, mae: archivo;
begin
     {Preparo los dos archivos}
     crearArchivo(det, mae);

     {Recorro el detalle y creo el maestro}
     recorrer(det, mae);
end.

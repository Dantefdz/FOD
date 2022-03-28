{1. Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del
archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
se ingrese el número 30000, que no debe incorporarse al archivo.}
program Ejercicio_1;
type
    archivo = file of integer;
procedure crearArchivo (var logico: archivo);
var
   nombreFisico: string;
begin
     write('Ingrese el nombre del archivo: ');
     readln(nombreFisico);

     assign(logico, nombreFisico);
     rewrite(logico);
end;
procedure cargarArchivo (var logico: archivo);
var
   num: integer;
begin
     writeln('Ingrese los numeros a cargar. La carga se detiene con 30000.');
     readln(num);
     while (num <> 30000) do begin
           write(logico, num);
           read(num);
     end;
     close(logico);
end;
var
   logico: archivo;
begin
     crearArchivo(logico);
     cargarArchivo(logico);
end.

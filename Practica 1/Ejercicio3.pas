program Ejercicio_3;
type
    empleado = record
            num: integer;
            ape:string;
            nom: string;
            edad: integer;
            DNI: integer;
    end;

    archivo = file of empleado;

function menu: integer;
var
   inicio: integer;
begin
     writeln('Seleccione una opcion:');
     write('   ');
     writeln('0: cerrar el programa.');
     write('   ');
     writeln('1: crear archivo.');
     write('   ');
     writeln('2: abrir un archivo ya generado.');

     writeln();

     write('- ');
     read(inicio);
     writeln(' -');
     writeln();

     if (inicio = 2) then begin
        write('      ');
        writeln('3: listar los datos de una persona ingresando el apellido.');
        write('      ');
        writeln('4: listar a todas las personas del archivo.');
        write('      ');
        writeln('5: listar en pantalla a los menores de 18');
        
        writeln();

        write('- ');
        read(inicio);
        writeln(' -');
        writeln();
     end;
     menu := inicio;
end;

procedure leer (var a: empleado);
begin
    write('Ingrese el apellido: ');
        readln(a.ape);
    if (a.ape <> 'fin') then begin
        write('Ingrese el DNI: ');
        readln(a.DNI);
        write('Ingrese el nombre: ');
        readln(a.nom);
        write('Ingrese el numero de empleado');
        readln(a.num);
        write('Ingrese el edad: ');
        readln(a.edad);
     end;
end;

procedure crearArchivo (var logico: archivo);
var
   aux: empleado;
begin
     rewrite(logico);
     leer(aux);
     while (aux.ape <> 'fin') do begin
        write(logico, aux);
        leer(aux);
     end;
     close(logico);
end;

procedure mostrarEmpleado (a: empleado);
begin
     write(a.ape, ' ', a.nom, ', ', a.edad, ' años, ', 'DNI = ', a.DNI, 'numero',a.num);
end;

procedure listaApellido (var logico: archivo);
var
   aux: empleado;
   apellidoIngresado: string;
   nombreIngresado: string;
begin
     reset(logico);

     write('Ingrese el apellido: ');
     readln(apellidoIngresado);

     write('ingrese el nombre: ');
     readln(nombreIngresado);

     while (not EOF(logico)) do begin
           read(logico, aux);
           if ((aux.ape = apellidoIngresado) or (aux.nom = apellidoIngresado) )then mostrarEmpleado(aux);
     end;
     close(logico);

     writeln();
end;

procedure lista (var logico: archivo);
var
   aux: empleado;
begin
     reset(logico);
     while (not EOF(logico)) do begin
           read(logico, aux);
           mostrarEmpleado(aux);
     end;
     close(logico);

     writeln();
end;

procedure listaMenores (var logico: archivo);
var
   aux: empleado;
begin
     reset(logico);
     while (not EOF(logico)) do begin
           read(logico, aux);
           if (aux.edad < 70) then mostrarEmpleado(aux);
     end;
     close(logico);

     writeln();
end;
var
   logico: archivo;
   nombreFisico: string;
   inicio: integer;
begin
     write('Ingrese el nombre del archivo: ');
     readln(nombreFisico);
     assign(logico, nombreFisico);
     writeln();

     repeat
           inicio := menu;
           case inicio of
                1: crearArchivo(logico);
                3: listaApellido(logico);
                4: lista(logico);
                5: listaMenores(logico);
           end;
     until(inicio = 0);
end.
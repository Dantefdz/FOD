{4. Agregar al menú del programa del ejercicio 3, opciones para:
a. Añadir una o más empleados al final del archivo con sus datos ingresados por
teclado.
b. Modificar edad a una o más empleados.
c. Exportar el contenido del archivo a un archivo de texto llamado
“todos_empleados.txt”.
d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
que no tengan cargado el DNI (DNI en 00).
NOTA: Las búsquedas deben realizarse por número de empleado.}
program ejercicio4;

Type 
  empleado = Record
    num: integer;
    apellido: string[25];
    nombre: string[25];
    edad: integer;
    dni: string[10];
  End;
  arch_emp = file Of empleado;



Procedure cargarEmpleado(Var e:empleado);
Begin
  write('Ingrese apellido del empleado: ');
  readln(e.apellido);
  If (e.apellido <> 'fin') Then
    Begin
      write('Ingrese nombre del empleado: ');
      readln(e.nombre);
      write('Ingrese edad del empleado: ');
      readln(e.edad);
      write('Ingrese dni del empleado: ');
      readln(e.dni);
      write('Ingrese num del empleado: ');
      readln(e.num);
    End;
End;


Procedure menu2();
Begin
  writeln('-----------MENU------------');
  writeln('1.Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado.');
  writeln('2.Listar en pantalla los empleados de a uno por línea.');
  writeln('3.Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.');
  writeln('4.Aniadir empeleados.');
  writeln('5.Modificar edad a un o varios empleados.');
  writeln('6.Exportar el contenido del archivo a un archivo de texto llamado “todos_empleados.txt”.');
  writeln('7.Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados que no tengan cargado el DNI (DNI en 00).');
  writeln('8.salir');
  write('Ingrese una opcion: ');
End;

Procedure menu();
Begin
  writeln('-----------MENU------------');
  writeln('1.Crear archivo' + #10 +
        '2.Abrir archivo' + #10 + '3.Salir' + #10 + 'Ingrese una opcion: ');
  writeln('---------------------------');
End;

Procedure imprimir(e:empleado);
Begin
  write('Nombre: ' + e.nombre + #10 + 'Apellido: ' + e.apellido + #10 + 'Dni: '
        , e.dni , #10 , 'Edad: ' , e.edad , #10 , 'Numero de empleado: ' , e.num
        , #10);
End;

Procedure listado(Var arch:arch_emp);

Var 
  e: empleado;
Begin
  reset(arch);
  While Not eof(arch) Do
    Begin
      read(arch,e);
      imprimir(e);
      writeln();
    End;
  close(arch);
End;

Procedure listadoEmpleadoMayores(Var arch:arch_emp);

Var 
  e: empleado;
Begin
  reset(arch);
  While Not eof(arch) Do
    Begin
      read(arch,e);
      If (e.edad > 70) Then
        imprimir(e);
    End;
  close(arch)
End;

Procedure buscarIgual(Var arch:arch_emp);

Var 
  e: empleado;
  nombre: string;
Begin
  reset(arch);
  write('Ingrese nombre o apellido: ');
  readln(nombre);
  While Not eof(arch) Do
    Begin
      read(arch,e);
      If ((e.nombre = nombre) Or (e.apellido = nombre)) Then
        imprimir(e);
    End;
  close(arch);
End;

procedure modificarEdad(var arch:arch_emp);
var
  e:empleado;
  nro: integer;
  edad: integer;
  ok: boolean;
begin
  ok := false;
  reset(arch);
  write('Ingrese numero del empleado a modificar: ');
  readln(nro);
  while not(nro = -1) do begin
    while not (eof(arch)) do begin
      read(arch,e);
      if(e.num = nro) then begin
        writeln('Empleado encontrado.');
        imprimir(e);
        write('ingrese la edad para modificarlo: ');
        readln(edad);
        e.edad := edad;
        seek(arch,filepos(arch)-1);
        write(arch,e);
        ok:= true;
      end
    end;
    if not (ok) then
      writeln('El empleado no se econtro');
    write('Ingrese numero del empleado a modificar: ');
    readln(nro);
    seek(arch,0);
    ok:= False;
  end;
  close(arch);
end;

procedure exportarV1(var arch:arch_emp);
var
  e:empleado;
  archivo_guardar: Text;
Begin
  reset(arch);
  assign(archivo_guardar,'todos_empleados.txt');
  Rewrite(archivo_guardar);
  while not eof(arch) do begin
    read(arch,e);
    write(archivo_guardar, 'Apellido: '+ e.apellido + ' Nombre: '+ e.nombre+ ' Numero de empleado: ', e.num ,' Edad: ',e.edad,' Dni: '+ e.dni,' ', #10);
  end;
  close(arch);
  close(archivo_guardar);
end;

procedure exportarV2(var arch:arch_emp);
var
  e:empleado;
  archivo_guardar: Text;
begin
  reset(arch);
  assign(archivo_guardar,'faltaDNIEmpleado.txt');
  Rewrite(archivo_guardar);
  while not eof(arch) do begin
    read(arch,e);
    if(e.dni = '00') then
      write(archivo_guardar, 'Apellido: '+ e.apellido + ' Nombre: '+ e.nombre+ ' Numero de empleado: ', e.num ,' Edad: ',e.edad,' Dni: '+ e.dni,' ', #10);
  end;
  close(arch);
  close(archivo_guardar);
end;

Procedure crear(Var arch: arch_emp);
Var 
  nombre_archivo: string;
  e: empleado;
Begin
  write('Ingrese nombre de archivo: ');
  readln(nombre_archivo);
  Assign(arch, nombre_archivo);
  Rewrite(arch);
  cargarEmpleado(e);
  While (e.apellido <> 'fin') Do
    Begin2
      Write(arch,e);2
      cargarEmpleado(e);
    End;
  close(arch);
End;

Procedure aniadir(Var arch: arch_emp);

Var 
  e: empleado;
Begin
  reset(arch);
  cargarEmpleado(e);
  seek(arch,FileSize(arch));
  While (e.apellido <> 'fin') Do
    Begin
      write(arch,e);
      cargarEmpleado(e);
    End;
  Close(arch);
End;

Procedure abrir(Var arch: arch_emp);
Var 
  seleccion: char;
  nombre_archivo: string;
Begin
  write('Ingrese nombre de archivo: ');
  readln(nombre_archivo);
  Assign(arch, nombre_archivo);
  menu2();
  readln(seleccion);
  Case seleccion Of 
    '1': buscarIgual(arch);
    '2': listado(arch);
    '3': listadoEmpleadoMayores(arch);
    '4': aniadir(arch);
    '5': modificarEdad(arch);
    '6': exportarV1(arch);
    '7': exportarV2(arch);
    '8': writeln('Hasta la proxima');
  End;
End;

Procedure MostrarMenu(Var arch: arch_emp);

Var 
  seleccion: char;
Begin
  menu();
  readln(seleccion);
  Case seleccion Of 
    '1': crear(arch);
    '2': abrir(arch);
    '3': write('Hasta la proxima');
  End;
End;

Var 
  archivo : arch_emp;
Begin
  MostrarMenu(archivo);
End.
{5. Realizar un programa para una tienda de celulares, que presente un menú con
opciones para:
a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
correspondientes a los celulares, deben contener: código de celular, el nombre,
descripcion, marca, precio, stock mínimo y el stock disponible.
b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
stock mínimo.
c. Listar en pantalla los celulares del archivo cuya descripción contenga una
cadena de caracteres proporcionada por el usuario.
d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
“celulares.txt” con todos los celulares del mismo.
NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario
una única vez.
NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en
tres líneas consecutivas: en la primera se especifica: código de celular, el precio y
marca, en la segunda el stock disponible, stock mínimo y la descripción y en la tercera
nombre en ese orden. Cada celular se carga leyendo tres líneas del archivo
“celulares.txt”}
program ejercicio5;
type 
    celular = record
        cod: integer;
        nom: string;
        desc: string;
        marca: string;
        precio:real;
        stockMin: integer;
        stockDis: integer;
        end;
    celu_file = file of celular;

//esto crea el archivo 
procedure CrearArchivo(var c: celu_file);
var 
    txt: Text;
    cel:celular;
begin
    Assign(txt, 'celu.txt');
    reset(txt);

    rewrite(c);

    while(not eof(txt))do begin
        readln(txt, cel.cod, cel.precio, cel.marca);
        readln(txt,cel.stockDis,cel.stockMin,cel.desc);
        readln(txt,cel.nom);
        write(c,cel);
    end;
    close(c);
    close(txt);

    write('se creo el archivo correctamente');
end;

//esto imprime en txt
procedure imprimir_Celular(var c:celular);
begin 
    writeln('codigo',c.cod);
    writeln('Nombre',c.nom);
    writeln('descripción',c.desc);
    writeln('marca',c.marca);
    writeln('precio',c.precio);
    writeln('Stock minimo',c.stockMin);
    writeln('Stock Dispio',c.stockDis);
    writeln();
end;

//saco el stock minimo
procedure listar_stock_minimo(var c:celu_file);
var
    cel:celular;
begin
    reset(c);
    while (not eof(c))do begin
        read(c,cel);
        if(cel.stockDis < cel.stockMin)then
            imprimir_Celular(cel);
    end;
    close(c);
end;

//lista con descripcion

procedure listar_con_descripcion(var c: celu_file);
var
    cel:celular;
    cadena:string;
    encontro:boolean;
begin
    encontro:=false;
    write('ingrese cadena de texto:');
    readln(cadena);
    write('resultado que coinciden:');
    reset(c);
    while (not eof(c))do begin  
        read(c,cel);
        if(pos(cadena,cel.desc)<> 0) then begin
            imprimir_Celular(cel);
            if(not encontro) then 
                encontro:=true;
            end;
        end;
        if(not encontro)then
            writeln('la cadena que se ingreso no es coincide con ninguna descripcion');
        close(c);
end;

//exportar archivo a txt

procedure exportar_archivo(var c:celu_file);
var
    cel:celular;
    archivo_guardar:Text;
begin
    reset(c);
    Assign(archivo_guardar,'celulares.txt');
    rewrite(archivo_guardar);
    while(not eof(c))do begin
        read(c,cel);
        write(archivo_guardar, 'Codigo' , cel.cod, #10 + 'Nombre:' + cel.nom + #10 + 'Descripcion: ' + cel.desc + #10 + 'Marca: ' + cel.marca + #10 + 'Precio: ' ,cel.precio, #10, 'Stock minimo: ', cel.stockMin, #10 + 'Stock disponible: ', cel.stockDis);
    end;
    close(c);
    close(archivo_guardar);
    writeln('se exporto el archivo a texto');
end;

//mostrar menu

procedure showMenu(var c:celu_file);
var 
opcion:string;
begin
     writeln('======== MENU ========');
    writeln('1. Crear archivo .');
    writeln('2. Listar celulares con stock menor al minimo.');
    writeln('3. Listar celulares con determinada descripcion.');
    writeln('4. Exportar archivo a texto.');
    writeln('5. Salir.');
    writeln('======================');
    readln(opcion);
    case opcion of 
        '1': CrearArchivo(c);
        '2': listar_stock_minimo(c);
        '3': listar_con_descripcion(c);
        '4': exportar_archivo(c);
        '5': halt;
        else begin
            write('Ingreso una opcion invalida. Vuelva a intentar.');
            showMenu(c);
        end;
    end;
    showMenu(c);
end;
var
    c: celu_file;
    nombre_archivo: string;
begin
    write('Ingrese nombre para el archivo binario con el que va a trabajar: ');
    readln(nombre_archivo);
    Assign(c, nombre_archivo);
    showMenu(c);
end.
program ejercicio2;
const
    valor_alto = 9999;
type
    alumno = record
        cod : integer;  
        nombre : string[25];
        apellido : string[25];
        cant_sinf : integer;
        cant_conf : integer;
    end;

    alumnoD = record
        cod : integer;
        aprobo : string;
    end;

    alumno_maestro = file of alumno;
    alumno_detalle = file of alumnoD;


    procedure imrprimirAlumnoMaestro(var rM: alumno);
    begin
        writeln('');
        writeln('Codigo: ', rM.cod);
        writeln('Nombre: ', rM.nombre);
        writeln('Apellido: ', rM.apellido);
        writeln('Cantidad de materias aprobadas sin final: ', rM.cant_sinf);
        writeln('Cantidad de materias con final aprobado: ', rm.cant_conf);
        writeln('');
    end;

    //INCISO A
    
    procedure crearArchivoMaestro(var archivo_text: Text; var archivo_maestro: alumno_maestro);
    var
        rM: alumno;
    begin   
        reset(archivo_text);
        rewrite(archivo_maestro);
        while not eof(archivo_text) do begin
            readln(archivo_text, rM.cod, rM.nombre);
            readln(archivo_text, rM.cant_sinf, rM.cant_conf, rM.apellido);
            write(archivo_maestro,rM);
        end;
        close(archivo_text);
        close(archivo_maestro);
    end;

    //INCISO B

    procedure crearArchivoDetalle(var archivo_text: Text; var archivo_detalle: alumno_detalle);
    var
        rD: alumnoD;
    begin
        Assign(archivo_text,'detalle.txt');
        reset(archivo_text);
        rewrite(archivo_detalle);
        while not eof(archivo_text) do begin
            readln(archivo_text, rD.cod, rD.aprobo);
            write(archivo_detalle,rD);
        end;
        close(archivo_text);
        close(archivo_detalle);
    end;

    //INCISO C

    procedure listar(var archivo_txt_maestro: Text);
    var
        rM:alumno;
    begin
        Assign(archivo_txt_maestro,'reporteAlumnos.txt');
        reset(archivo_txt_maestro);
        while not eof(archivo_txt_maestro) do begin
            readln(archivo_txt_maestro, rM.cod, rM.nombre);
            readln(archivo_txt_maestro, rM.cant_sinf, rM.cant_conf, rM.apellido);
            imrprimirAlumnoMaestro(rM);
        end;
        close(archivo_txt_maestro);
    end;

    procedure listarContenidoM(var archivo_maestro: alumno_maestro);
    var
        rM: alumno;
        archivo_txt_maestro: Text; 
    begin
        Assign(archivo_txt_maestro,'reporteAlumnos.txt');
        rewrite(archivo_txt_maestro);
        reset(archivo_maestro);
        while not eof(archivo_maestro) do begin
            read(archivo_maestro, rM);
            writeln(archivo_txt_maestro,rM.cod, rM.nombre);
            writeln(archivo_txt_maestro,rM.cant_sinf,' ',rM.cant_conf,rM.apellido);
        end;    
        close(archivo_txt_maestro);
        close(archivo_maestro);
        listar(archivo_txt_maestro);
    end;

    //Inciso D

    procedure imprimirAlumnoDetale(var rD: alumnoD);
    begin
        writeln('');
        writeln('Codigo: ', rD.cod);
        writeln('Aprobo:', rD.aprobo);
    end;

    procedure listarContenidoDetalle(var archivo_txt_detalle: Text);
    var
        rD:alumnoD;
    begin
        Assign(archivo_txt_detalle,'reporteDetalle.txt');
        reset(archivo_txt_detalle);
        while not eof(archivo_txt_detalle) do begin
            readln(archivo_txt_detalle, rD.cod, rD.aprobo);
            imprimirAlumnoDetale(rD);
        end;
        close(archivo_txt_detalle);
    end;

    procedure listarContenidoD(var archivo_detalle: alumno_detalle);
    var
        rD: alumnoD;
        archivo_txt_detalle: Text; 
    begin
        Assign(archivo_txt_detalle,'reporteDetalle.txt');
        rewrite(archivo_txt_detalle);
        reset(archivo_detalle);
        while not eof(archivo_detalle) do begin
            read(archivo_detalle,rD);
            writeln(archivo_txt_detalle, rD.cod, rD.aprobo);
        end;
        close(archivo_txt_detalle);
        close(archivo_detalle);
        listarContenidoDetalle(archivo_txt_detalle);
    end;

    //Inciso E

    procedure leer(var archivo_detalle: alumno_detalle; var rD: alumnoD);
    begin
        if not eof(archivo_detalle) then 
            read(archivo_detalle,rD)
        else
            rD.cod := valor_alto;
    end;

    procedure actualizarMaestro(var archivo_maestro: alumno_maestro; var archivo_detalle: alumno_detalle);
    var
        rM: alumno;
        rD: alumnoD;
    begin
        reset(archivo_maestro);
        reset(archivo_detalle);
        leer(archivo_detalle,rD);
        while(rD.cod <> valor_alto) do begin
            read(archivo_maestro,rM);
            while(rD.cod <> rM.cod) do begin
                read(archivo_maestro,rM);
            end;
            while(rD.cod = rM.cod) do begin
                if(rD.aprobo = 'aprobado') then 
                    rM.cant_conf := rM.cant_conf + 1
                else
                    rM.cant_sinf := rM.cant_sinf + 1;
                leer(archivo_detalle,rD)
            end;
            Seek(archivo_maestro, filepos(archivo_maestro) - 1);
            write(archivo_maestro,rM);
        end;
        close(archivo_maestro);
        close(archivo_detalle);
    end;

    //Inciso F

    procedure listarAprobados(var archivo_text: Text);
    var
        rM:alumno;
    begin
        Assign(archivo_text,'listado_alumnos.txt');
        reset(archivo_text);
        while not eof(archivo_text) do begin
            readln(archivo_text, rM.cod, rM.nombre);
            readln(archivo_text, rM.cant_sinf, rM.cant_conf, rM.apellido);
            imrprimirAlumnoMaestro(rM);
        end;
        close(archivo_text);
    end;

    procedure listarAlumnos(var archivo_maestro: alumno_maestro);
    var
        rM: alumno;
        archivo_text: Text;
    begin
        Assign(archivo_text,'listado_alumnos.txt');
        rewrite(archivo_text);
        reset(archivo_maestro);
        while not eof(archivo_maestro) do begin
            read(archivo_maestro,rM);
            if(rM.cant_sinf > 4) then begin
                writeln(archivo_text,rM.cod, rM.nombre);
                writeln(archivo_text,rM.cant_sinf,' ',rM.cant_conf,rM.apellido);
            end;
        end;
        close(archivo_maestro);
        close(archivo_text);
        listarAprobados(archivo_text);
    end;

    procedure imprimirMenu();
    begin
        writeln('-----MENU------');
        writeln('1. Crear el archivo maestro a partir de un archivo de texto llamado “alumnos.txt”.');
        writeln('2. Crear el archivo detalle a partir de en un archivo de texto llamado “detalle.txt”.');
        writeln('3. Listar el contenido del archivo maestro en un archivo de texto llamado “reporteAlumnos.txt”.');
        writeln('4. Listar el contenido del archivo detalle en un archivo de texto llamado “reporteDetalle.txt”.');
        writeln('5. Actualizar el archivo maestro.');
        writeln('6. Listar en un archivo de texto los alumnos que tengan más de cuatro materias con cursada aprobada pero no aprobaron el final.Deben listarse todos los campos.');
        writeln('7. Salir.');
        writeln('---------------');
        write('Ingrese una opcion: ');
    end;

    procedure showMenu(var archivo_Text_alumnos: Text ; var archivo_Text_Detalle: Text; var archivoM: alumno_maestro; var archivoD: alumno_detalle);
    var
        seleccion: string;
    begin
        imprimirMenu();
        readln(seleccion);
        case seleccion of
            '1': crearArchivoMaestro(archivo_Text_alumnos,archivoM);
            '2': crearArchivoDetalle(archivo_Text_Detalle,archivoD);
            '3': listarContenidoM(archivoM);
            '4': listarContenidoD(archivoD);
            '5': actualizarMaestro(archivoM,archivoD);
            '6': listarAlumnos(archivoM);
            '7': halt;
        end;
        showMenu(archivo_Text_alumnos,archivo_Text_Detalle,archivoM,archivoD);
    end;
var
    archivo_maestro: alumno_maestro;
    archivo_detalle: alumno_detalle;
    archivo_text_alumnos: Text;
    archivo_text_detalle: Text;
begin
    Assign(archivo_text_alumnos,'alumnos.txt');
    Assign(archivo_text_detalle,'detalle.txt');
    Assign(archivo_maestro,'alumnos');
    Assign(archivo_detalle,'detalle');
    showMenu(archivo_text_alumnos,archivo_text_detalle,archivo_maestro,archivo_detalle);
end.
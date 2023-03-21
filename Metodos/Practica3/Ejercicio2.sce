clc

clear

// Metodo de la biseccion 

// Argumentos: funcion, inicio del intervalo, fin del intervalo, 
// tolerancia y cantidad maxima de iteraciones.
// SABIENDO QUE CONVERGE SIEMPRE PUEDO SACAR "i < iter"
// TODA FUNCION ES F(X) = 0; POR EJEMPLO e^x = x^2 + 2 ==> e^x-x^2-2 = 0
function salida = biseccion(fun, a, b, tol, iter)
    // cambio la funcion de string para poder evaluarla
    deff("y=f(x)", "y="+fun);
    // verifico si se cumple la hip de bolzano
    if (f(a)*f(b)>0) then
        disp("Intervalo invalido")
    else
        // primer iteracion
        i = 1;
        c = (a+b)/2;
        // itero hasta que se acaben las iteraciones o se llegue a la 
        // tolerancia pedida
        while (abs(b-c) > tol && i < iter)
            i = i + 1;
            if(f(a)*f(c) < 0) then
                b = c;
            else
                a = c;
            end
            c = (a+b)/2;
        end
        // verifico si el while termino porque se acabaron las iteraciones
        // o se llego a la tolerancia minima
        if (abs(b-c) > tol) then
            disp("Se terminaron las recursiones");
        end
    end
    disp(i);
    salida = c;
    
endfunction

/*
Ejemplos meotodo de la biseccion:

biseccion("x", -1, 2, 0.001, 500) =
x = -0.0002441
12 iteraciones

biseccion("x^2-1", -1, 2, 0.001, 500)
x = 1.0002441
12 iteraciones

biseccion("98^x-1", -1, 42, 0.001, 500)
x = 0.0005951
16 iteraciones
*/


// Ejercicio 2

// a)
disp("Raices a")
disp(biseccion("sin(x)-x.^2/2", -1, 1, 0.001, 500));
// x = 0.9990234  11 iteraciones
disp(biseccion("sin(x)-x.^2/2", 1, 2, 0.001, 500));
// x = 1.4052734  10 iteraciones
// b)
disp("Raices b")
disp(biseccion(string(%e)+".^-x-x^4", -2, -1, 0.001, 500));
// x = -1.4287109  10 iteraciones
disp(biseccion(string(%e)+".^-x-x^4", 0, 2, 0.001, 500));
// x = 0.8154297  11 iteraciones
// c)
disp("Raices c")
disp(biseccion("log10(x)-x+1", 0.01, 0.5, 0.001, 500));
// x = 0.1372852  9 iteraciones
disp(biseccion("log10(x)-x+1", 0.5, 2, 0.001, 500));
// x = 1.0002441  11 iteraciones

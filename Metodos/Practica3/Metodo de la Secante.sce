clc

clear

// Metodo de la secante.

// Argumentos: funcion, punto inicial, punto final,
// tolerancia y cantidad maxima de iteraciones.
function salida = secante(fun, x0, x1, tol, iter)
    // cambio la funcion de string para poder evaluarla
    deff("y=f(x)", "y="+fun);
    i = 1;
    // primer iteracion
    xn = x1 - (f(x1)*((x1-x0)/(f(x1)-f(x0))));
    xant = x1;
    while (abs(xn - xant) > tol && i < iter)
        i = i + 1;
        aux = xn;
        xn = xn - (f(xn)*((xn-xant)/(f(xn)-f(xant))));
        xant = aux;
    end
    // verifico si el while termino porque se acabaron las iteraciones
    // o se llego a la tolerancia minima
    if (abs(xn-xant) > tol) then
        disp("Se terminaron las recursiones");
    end
    disp(i);
    salida = xn;
    
endfunction

/*
Ejemplos meotodo de la biseccion:

secante("x", -1, 2, 0.001, 500) =
x = 0
2 iteraciones

secante("x^2-1", -1, 2, 0.001, 500) =
x = -1
2 iteraciones

secante("98^x-1", 0.5, 1, 0.001, 500) =
x = 0.0000004
9 iteraciones
*/


// Ejercicio 3

//COMO NOS PIDDE QUE SAQUEMOS LA RAIZ NO NULA, GRAFICO LA FUNCION Y VEO EN QUE INTERVALO ES LA RAIZ NO NULA
function y = dibujar()
    deff("y=f(x)", "y=(x^2)/4 - sin(x)")
    x = [-2:0.1:2];
    plot(x,f(x))
    a=gca();
    a.x_location = "origin";
    a.y_location = "origin";
    y = 0
endfunction

dibujar()
// A simple vista podemos ver que la raiz no nula esta entre 1 y 3. Por lo
// tanto elegi x0 = 1 y x1 = 3
disp(secante("(x.^2/4)-sin(x)", 1, 3, 0.001, 500));

/*
x = 1.9337575
6 iteraciones
*/
clc

clear

// Metodo de la secante.

// Argumentos: funcion, punto inicial, punto final,
// tolerancia y cantidad maxima de iteraciones.
function salida = secante(fun, x0, x1, tol, iter)
    // cambio la funcion de string para poder evaluarla
    deff("y=f(x)", "y="+fun);
    i = 1;
    // primer iteracion
    xn = x1 - (f(x1)*((x1-x0)/(f(x1)-f(x0))));
    xant = x1;
    while (abs(xn - xant) > tol && i < iter)
        i = i + 1;
        aux = xn;
        xn = xn - (f(xn)*((xn-xant)/(f(xn)-f(xant))));
        xant = aux;
    end
    // verifico si el while termino porque se acabaron las iteraciones
    // o se llego a la tolerancia minima
    if (abs(xn-xant) > tol) then
        disp("Se terminaron las recursiones");
    end
    disp(i);
    salida = xn;
    
endfunction

/*
Ejemplos meotodo de la biseccion:

secante("x", -1, 2, 0.001, 500) =
x = 0
2 iteraciones

secante("x^2-1", -1, 2, 0.001, 500) =
x = -1
2 iteraciones

secante("98^x-1", 0.5, 1, 0.001, 500) =
x = 0.0000004
9 iteraciones
*/


// Ejercicio 3

//COMO NOS PIDDE QUE SAQUEMOS LA RAIZ NO NULA, GRAFICO LA FUNCION Y VEO EN QUE INTERVALO ES LA RAIZ NO NULA
function y = dibujar()
    deff("y=f(x)", "y=(x^2)/4 - sin(x)")
    x = [-2:0.1:2];
    plot(x,f(x))
    a=gca();
    a.x_location = "origin";
    a.y_location = "origin";
    y = 0
endfunction

dibujar()
// A simple vista podemos ver que la raiz no nula esta entre 1 y 3. Por lo
// tanto elegi x0 = 1 y x1 = 3
disp(secante("(x.^2/4)-sin(x)", 1, 3, 0.001, 500));

/*
x = 1.9337575
6 iteraciones
*/

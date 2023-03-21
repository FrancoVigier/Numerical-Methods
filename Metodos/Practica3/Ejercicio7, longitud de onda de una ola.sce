clc

clear
//ABAJO ESTA MI SOLUCION

// Metodo de Newton.

// Argumentos: funcion, punto inicial, tolerancia y cantidad maxima 
// de iteraciones.
function salida = newton(fun, x0, tol, iter)
    // cambio la funcion de string para poder evaluarla
    deff("y=f(x)", "y="+fun);
    // primer iteracion
    i = 1;
    x1 = x0 - f(x0)/numderivative(f, x0);
    // itero hasta que la diferencia entre las 2 anteriores iteraciones
    // sea menor a la tolerancia pedida
    while (abs(x1-x0) > tol && i < iter)
        i = i + 1;
        x0 = x1;
        x1 = x0 - f(x0)/numderivative(f, x0);
    end
    // verifico si el while termino porque se acabaron las iteraciones
    // o se llego a la tolerancia minima
    if (abs(x1-x0) > tol) then
        disp("Se terminaron las recursiones");
    end
    // muestro la cantidad de iteraciones
    disp(i);
    salida = x1;
    
endfunction

/*
Ejemplos meotodo de la biseccion:

newton("x", -1, 0.001, 500) =
x =  -1.031D-23
2 iteraciones

newton("x^2-1",  2, 0.001, 500) =
x = 1
4 iteraciones

newton("98^x-1", 0.5, 0.001, 500) =
x = 8.628D-10
6 iteraciones
*/

// Ejercicio 7

// a)
function y=g(x)
    y = ((2.*%pi./5).^2) / (tanh(x.*4).*(9.8))
endfunction

function y=iterarG(x)
    y = x
    for i=1:20
        y = g(y)
    end
endfunction


disp(iterarG(1))

// iterarG(1) = 0.2259122

// b)

// Aplico el metodo de newton partiendo de x0 = 0.4 con la tolerancia pedida


// Agrege - x al final de la funcion para poder utilizar newton ya que el mismo 
// calcula raices no puntos fijos, entonces al restar x convierto el problema en
// una busqueda de raices.

disp(newton("(((2.*"+string(%pi)+"./5).^2) / ((9.8).*tanh(4.*x))) - x", 0.2, 0.0001, 10))

// valor de retorno 0.2249735


//ESTA ES LA MIA Y ESTA BIEN
function y = longitudOnda(x)
    y = (((5^2)*9.8)/(2*%pi)) * tanh(8*%pi/x)
endfunction

function y = iterarLongitud(lInicial)
    y = lInicial
    while (abs(y - longitudOnda(y)) > 0.1)
        y = longitudOnda(y)
    end
endfunction

disp(iterarLongitud(2*%pi))

disp(newton("(((5^2)*9.8)/(2*"+string(%pi)+")) * tanh(8*"+string(%pi)+"/x) - x",iterarLongitud(2*%pi) , 0.0001, 1000))

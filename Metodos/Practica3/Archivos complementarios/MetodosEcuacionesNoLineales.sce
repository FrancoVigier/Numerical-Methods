clc
clear

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

// Metodo de la biseccion 

// Argumentos: funcion, inicio del intervalo, fin del intervalo, 
// tolerancia y cantidad maxima de iteraciones.
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

// Metodo de la secante.

// Argumentos: funcion, punto inicial, punto inicial,
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

// Metodo de la falsa posicion.

// Argumentos: funcion, inicio del intervalo, fin del intervalo, 
// tolerancia y cantidad maxima de iteraciones.
function salida = falsa_posicion(fun, a, b, tol, iter)
    // cambio la funcion de string para poder evaluarlas
    deff("y=f(x)", "y="+fun);
    // verifico bolzano
    if (f(a)*f(b) >= 0) then
        disp("a y b mal ingresados");
    end
    i = 0;
    while i < iter
        i = i + 1;
        c = b - (f(b)*((b-a)/(f(b)-f(a))));
        if(f(a)*f(c) < 0) then
            b = c;
        else
            a = c;
        end
        // Si la funcion se acerca lo suficiente a 0 termino de iterar
        if (abs(f(c)) < tol)
            break;
        end
    end
    
    // verifico si el while termino porque se acabaron las iteraciones
    // o se llego a la tolerancia minima
    if (abs(f(c)) > tol) then
        disp("Se terminaron las recursiones");
    end
    disp(i);
    salida = c;
    
endfunction

// Metodo de Newton multivariable
/*
   El metodo es similar a Newton para una variable, pero cambia 
   la diferencia por norma euclideana y utilizo numderivative para
   aproximar la matriz jacobiana.
*/
// Argumentos: funcion, punto inicial, tolerancia y cantidad maxima 
// de iteraciones.
function y = newt_mult_variable(fn, X, eps, iter)
    y = X;
    Xn = X;
    i = 0;
      
    while((norm(y-Xn) > eps | i == 0)  && i < iter)
      Xn = y;
      J = numderivative(fn, Xn);
      // J matriz jacobiana
      y = Xn - inv(J)*fn(Xn);
      i = i+1;
    end
    // verifico si el while termino porque se acabaron las iteraciones
    // o se llego a la tolerancia minima
    if (norm(y-Xn) > eps) then
        disp("Se terminaron las recursiones");
    end
    disp(i)
    
endfunction

function y=G(x)
  f1 = x(1).^2+x(1)*x(2).^3-9
  f2 = 3*x(1).^2*x(2)-4-x(2).^3
  y = [f1; f2]
endfunction


disp("--------falsa------------");
disp(falsa_posicion("x^5 - 3*x^4 + 10*x - 8", 2, 5, 0.000001, 500));
disp("--------biseccion------------");
disp(biseccion("x^5 - 3*x^4 + 10*x - 8", 2, 5, 0.000001, 500));
disp("---------newton-----------");
disp(newton("x^5 - 3*x^4 + 10*x - 8", 5, 0.000001, 500));
disp("--------secante------------");
disp(secante("x^5 - 3*x^4 + 10*x - 8", -2, 6, 0.000001, 500));
disp("------newton multi variable----")
disp(newt_mult_variable(G, [-2; 2.5], 0.001, 100))

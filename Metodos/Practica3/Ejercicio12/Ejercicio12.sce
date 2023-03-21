clc

clear

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

function y=sistema(x)
  f1 = x(1).*%e.^x(2)+x(3)-10
  f2 = x(1).*%e.^(x(2)*2)+2.*x(3)-12
  f3 = x(1).*%e.^(x(2)*3)+3.*x(3)-15
  y = [f1; f2; f3]
endfunction

K = newt_mult_variable(sistema, [1; 2; 3], 0.001, 100)

disp(K)

// K = [8.7712864, 0.2596954, -1.3722813]

disp(sistema(K))

/*
   Resultados: 
   1.890D-11
   8.664D-11
   2.417D-10
   
   Es decir que efectivamente los k calculados son cerrectos, se llega cerca de 0.
*/

function r=radio(x)
    r=K(1).*%e.^(K(2).*x)+x*K(3)-500
endfunction

function y=dibujar(fun, intervalo)
    plot(intervalo, fun(intervalo))
    a=gca()
    a.x_location = "origin"
    a.y_location = "origin"
    y=0
    figure
endfunction

dibujar(radio, [0:0.1:20])

// En la grafica puedo ver que la raiz esta cerca de 16, ademas
// sea a = 12 y b = 17, se cumple que f(a)f(b) < 0, por lo tanto
// puedo usar el metodo de la biseccion para encontrar la solucion

radioString = "K(1).*%e.^(K(2).*x)+x*K(3)-500";
disp(biseccion(radioString , 12, 17, 0.001, 100))

// r = 15.731079


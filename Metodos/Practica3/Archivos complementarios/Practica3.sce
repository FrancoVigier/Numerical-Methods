// Metodo de Newton.

function salida = newton(fun, x0, tol, iter)
    deff("y=f(x)", "y="+fun);
    i = 0;
    x1 = x0 - f(x0)/numderivative(f, x0);
    while (abs(x1-x0) > tol && i < iter)
        i = i + 1;
        x0 = x1;
        x1 = x0 - f(x0)/numderivative(f, x0);
    end
    
    if (abs(x1-x0) > tol) then
        disp("Se terminaron las recursiones");
    end
    disp(i);
    salida = x1;
endfunction

// Metodo de la biseccion 

function salida = biseccion(fun, a, b, tol, iter)
    deff("y=f(x)", "y="+fun);
    if (f(a)*f(b)>0) then
    end
    i = 0;
    c = (a+b)/2;
   
    while (abs(b-c) > tol && i < iter)
        i = i + 1;
        if(f(a)*f(c) < 0) then
            b = c;
        else
            a = c;
        end
        c = (a+b)/2;
    end
    
    if (abs(b-c) > tol) then
        disp("Se terminaron las recursiones");
    end
    disp(i);
    salida = c;
    
endfunction

// Metodo de la secante.

function salida = secante(fun, x0, x1, tol, iter)
    deff("y=f(x)", "y="+fun);
    i = 1;
    xn = x1 - (f(x1)*((x1-x0)/(f(x1)-f(x0))));
    xant = x1;
    while (abs(xn - xant) > tol && i < iter)
        i = i + 1;
        aux = xn;
        xn = xn - (f(xn)*((xn-xant)/(f(xn)-f(xant))));
        xant = aux;
    end
    
    if (abs(xn-xant) > tol) then
        disp("Se terminaron las recursiones");
    end
    disp(i);
    salida = xn;
endfunction

// Metodo de la falsa posicion.


function salida = falsa_posicion(fun, a, b, tol, iter)
    deff("y=f(x)", "y="+fun);
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
        if (abs(f(c)) < tol)
            break;
        end
    end
   

    if (abs(f(c)) > tol) then
        disp("Se terminaron las recursiones");
    end
    disp(i);
    salida = c;
endfunction

function salida = newton(fun, x0, tol, iter)
    deff("y=f(x)", "y="+fun);
    i = 0;
    x1 = x0 - f(x0)/numderivative(f, x0);
    while (abs(x1-x0) > tol && i < iter)
        i = i + 1;
        x0 = x1;
        x1 = x0 - f(x0)/numderivative(f, x0);
    end
    
    if (abs(x1-x0) > tol) then
        disp("Se terminaron las recursiones");
    end
    disp(i);
    salida = x1;
endfunction
/*
disp("--------falsa------------");
disp(falsa_posicion("x^5 - 3*x^4 + 10*x - 8", 2, 5, 0.000001, 500));
disp("--------biseccion------------");
disp(biseccion("x^5 - 3*x^4 + 10*x - 8", 2, 5, 0.000001, 500));
disp("---------newton-----------");
disp(newton("x^5 - 3*x^4 + 10*x - 8", 5, 0.000001, 500));
disp("--------secante------------");
disp(secante("x^5 - 3*x^4 + 10*x - 8", -2, 6, 0.000001, 500));


// Ejercicio 1
function y=funcion1(x)
    y=cosh(x).*cos(x)+1;
endfunction
x = [1:2*10e-3:4];
y1 = funcion1(x);
plot(x,y1,"b");
figure

x = [4:2*10e-3:7];
y1 = funcion1(x);
plot(x,y1,"b");
figure

x = [7:2*10e-3:10];
y1 = funcion1(x);
plot(x,y1,"b");

// Las raices aproximadas son:
// 2, 4.5, 7.8

// Ejercicio 2

// a)
disp(biseccion("sin(x)-x.^2/2", -1, 1, 0.001, 500));
disp(biseccion("sin(x)-x.^2/2", 1, 2, 0.001, 500));
// b)
disp(biseccion(string(%e)+".^-x-x^4", -2, -1, 0.001, 500));
disp(biseccion(string(%e)+".^-x-x^4", 0, 2, 0.001, 500));
// c)
disp(biseccion("log10(x)-x+1", 0.01, 0.5, 0.001, 500));
disp(biseccion("log10(x)-x+1", 0.5, 2, 0.001, 500));

// Ejercicio 3

disp(secante("(x.^2/4)-sin(x)", 1, 3, 0.001, 500));

// Ejercicio 4

function y=cosenoreiterado(x)
    res = cos(x);
    for i=1:100000
        res = cos(res);
    end
    y = res;
endfunction


disp(cosenoreiterado(%pi*3/2));


// Por colorario 1, x = cos(x) tiene como solucion a = 0.739085133215160672293
// derivada de coseno evaluada en a es menor a 1 por lo tanto converge a a.

// Se obtiene 0.739 = x/ cos(x) = x
*/
// Ejercicio 5

/*
    x(k+1) = 2^(x(k)-1)
    
    Sea x(n+1) = g(x(n)) con g(x) = 2^(x-1).
    g'(x) = ln(2)*g(x)
    Veamos cuando |g'(x)| < 1:
    |ln(2)g(x)| = |ln(2)2^(x-1)| = ln(2)2^(x-1)
    ahora
    ln(2)2^(x-1) < 1 => 2^(x-1) < 1/ln(2) => x-1 < log2(1/ln(2)) =>
    => x < log2(1/ln(2)) <= 1.59
    
    sea b = 1.58 y a = -inf, (a < b)
    es facil ver que se cumple que a <= x <= b => a <= g(x) <= b
    por teorema 2 la iteracion de punto fijo converge a alpha para todo
    x0 perteneciente a [a, b]
    
    iterando con x0 = 0 llego a que:
    alpha = 1
    
*/

function y=ejercicio5(x)
    res = 2.^((x)-1);
    for i=1:1000
        res = 2.^((res)-1);
    end
    y = res;
endfunction

disp(ejercicio5(0)); // = 0.999999999999999888978

// Ejercicio 7

function y = newt_mult_fin(fn, X, eps, iter)  //Función, punto inicial, error
    y = X;
    Xn = X;
    i = 0;
   
    mprintf("X0 = %f\n", Xn)
   
    while((norm(y-Xn) > eps | i == 0)  && i < iter)      // Norma euclideana
      Xn = y;
      J = numderivative(fn, Xn);
      
      J = inv(J)
      y = Xn - J*fn(Xn);
      i = i+1;
      mprintf("X%d = %0.12f |-| %0.12f\n", i, y(1), y(2))
    end
    
    
endfunction


function y=G(x)
  f1 = x(1).^2+x(1)*x(2).^3-9
  f2 = 3*x(1).^2*x(2)-4-x(2).^3
  y = [f1; f2]
endfunction

disp(newt_mult_fin(G, [-2; 2.5], 0.001, 100))




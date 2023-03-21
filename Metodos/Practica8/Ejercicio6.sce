clc
clear

// Ejercicio 6

// Funcion que toma una funcion, un intervalo y una cantidad de subIntervalos.
function res = metodoCompTrapecio(fx, a, b, n)
    // Inicializamos h y res
    h = (b-a)/n;
    res = 0;
    // Iteramos sobre todos los subintervalos.
    for i = 0:n
        xn = a + i*h;
        // Si el intervalo es el primero o el ultimo dividimos f(xn) por 2.
        if(i == 0 | i == n)
            res = res + fx(xn)/2;
        // En caso contrario no.
        else
            res = res + fx(xn);
        end
    end
    // Multiplicamos todo por h.
    res = res * h;
endfunction


// Fucnion que calcula el metodo compuesto de Simpson.
function res = metodoCompSimpson(fx, a, b, n)
    // Inicializamos h y res.
    h = (b-a)/n
    res = 0
    
   // Primer intervalo.
    res = res + fx(a + 0*h)
    // Iteramos sobre los n subintervalos.
    for i = 1:n-1
        
        // Si el subintervalo es par.
        if (pmodulo(i,2) == 0)
            res = res + 2*fx(a + i*h);
        // Caso impar.
        else
            res = res + 4*fx(a + i*h);
        end    
        
    end
    // Ultimos intervalo.
    res = res + fx(a + n*h)
    // Multiplicamos por h/3
    res = res * h/3;
endfunction

// Funcion que calcula la integral numerica de dominio bidimensional, 
// utilizando el metodo de Simpson.
// Toma la funcion, los extremos del primer intervalo, las fucniones del segundo
// y la cntidad de subintervalos de la primer integral y la cantidad de subintervalos
// de la segunda.
function y = dominioBiSimpson(f,a,b,cx,dx,n,m)
    // Inicializamos h
    h = (b-a)/n
    deff('z=fxa1(x)','z=f(a,x)')
    deff('z=fxb(x)','z=f(b,y)')
    
    // Calculamos la segunda integral.
    temp = metodoCompSimpson(fxa,cx(a),dx(a),m) + metodoCompSimpson(fxb,cx(b),dx(b),m)
    
    // Calculamos la primera, en todos los subintervalos pedidos.
    for i=1:n-1
        xi = a+i*h
        deff('z=aux(y)','z=f(xi,y)')
        // Aplicamos el metodo como corresponde segun simpson.
        if pmodulo(i,2) == 0 then
            temp = temp + 2*(metodoCompSimpson(aux,cx(xi),dx(xi),m))
        else
            temp = temp + 4*(metodoCompSimpson(aux,cx(xi),dx(xi),m))
        end
    end
    y = (h/3) * temp
endfunction

// Funcion que calcula la integral numerica de dominio bidimensional, 
// utilizando el metodo de Trapecio.
// Toma la funcion, los extremos del primer intervalo, las fucniones del segundo
// y la cntidad de subintervalos de la primer integral y la cantidad de subintervalos
// de la segunda.
function y = dominioBiTrapecio(f,a,b,cx,dx,n,m)
    // Inicializamos h
    h = (b-a)/n
    
    deff('z=fxa(y)','z=f(a,y)')
    deff('z=fxb(y)','z=f(b,y)')
    
    // Calculamos la segunda integral.
    temp = (metodoCompTrapecio(fxa, cx(a),dx(a),m)/2) + (metodoCompTrapecio(fxb,cx(b),dx(b),m)/2)
    
    // Calculamos la primera, en todos los subintervalos pedidos.
    for i=1:n-1
        xi = a+i*h
        deff('z=aux(y)','z=f(xi,y)')
        temp = temp + (metodoCompTrapecio(aux,cx(xi),dx(xi),m))
    end
    y = h * temp
endfunction


/*
    Si vemos el dominio de la funcion, vemos que resulta ser un circulo
    centrado en (1,0), las funciones de dx y cx corresponden al mismo.
    Mientras que f es constante en 1.

*/

function y=f(x,y)
    y=1
endfunction

function y=dx(x)
    y= sqrt(2*x-x^2)
endfunction

function y=cx(x)
    y= -sqrt(2*x-x^2)
endfunction

disp(dominioBiTrapecio(f,0,2,cx,dx,2,2))
// 2

disp(dominioBiTrapecio(f,0,2,cx,dx,100,100))
// 3.1382685

disp(dominioBiTrapecio(f,0,2,cx,dx,1000,1000))
// 3.1414875


disp(dominioBiSimpson(f,0,2,cx,dx,2,2))
// 2.6666667

disp(dominioBiSimpson(f,0,2,cx,dx,100,100))
// 3.140296

disp(dominioBiSimpson(f,0,2,cx,dx,1000,1000))
// 3.1415516

// Vemos como al aumentar los subintervalos el resultado se acerca a pi



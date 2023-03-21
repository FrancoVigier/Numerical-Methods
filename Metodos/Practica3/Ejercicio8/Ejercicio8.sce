clc 

clear

function y=dibujar(fun, intervalo)
    deff("y=fx(x)", "y = x")
    plot(intervalo, fx(intervalo), "r")
    plot(intervalo, fun(intervalo))
    a=gca()
    a.x_location = "origin"
    a.y_location = "origin"
    y=0
    figure
endfunction

function y=iterar(fun, x)
    y = x
    for i=1:100
        y = fun(y)
    end
endfunction

// Ejercicio i)

function y=g1(x)
    y = (%e^x)/3
endfunction

//dibujar(g1, [-2:0.1:2])

disp("Resultado de iterar funcion g1 =");
disp(iterar(g1, 0));

// Ejercicio ii)

function y=g2(x)
    y = (%e.^x)-x/2
endfunction

//dibujar(g2, [-2:0.1:2])

disp("Resultado de iterar funcion g2 =");
disp(iterar(g2, 0));


// Ejercicio iii)

function y=g3(x)
    y = log(3.*x)
endfunction

//dibujar(g3, [-2:0.1:2])

disp("Resultado de iterar funcion g3 =");
disp(iterar(g3, 2));

// Ejercicio iv)

function y=g4(x)
    y = %e.^x-2.*x
endfunction

dibujar(g4, [-2:0.1:2])

disp("Resultado de iterar funcion g4 =");
// 0.1 <= 1 <= ln(3)-01
disp(iterar(g4, 1));

clc

clear

// Ejercicio 5


// Funcion que aplica la regla de trapecio para resolver una doble integral
// definida.

function y = trapecioExtendida(f,a,b,c,d)
    // Calculamos h.
    h = (b-a)*(d-c)/4
    // Aplicamos la regla.
    y = h* (f(c,a)+f(c,b)+f(d,a)+f(d,b)) 
endfunction

function z=f(x,y)
    z = sin(x+y)
endfunction

disp(trapecioExtendida(f,0,2,0,1))
//  0.9459442


// Ejemplos

disp("Ejemplos:")
disp("1")

function z=e1(x,y)
    z = 5
endfunction

// integral de 0 a 2 de la integral de 0 a 2 de 5
// La primer integral resulta = 10, la segundo 10 * 2 - 10 * 0 = 20
disp(trapecioExtendida(e1,0,2,0,2))
//     20.

disp("2")

function z=e2(x,y)
    z = x^2
endfunction

disp(trapecioExtendida(e2,-2,2,-2,2))
//   64.

disp("3")

function z=e3(x,y)
    z = x^2
endfunction

disp(trapecioExtendida(e3,-2,2,0,2))
//    16.

disp(trapecioExtendida(e2,-2,2,-2,2))
//   64.

disp("4")

function z=e4(x,y)
    z = x^2
endfunction

disp(trapecioExtendida(e4,-2,2,0,0))
//    0


disp("5")

function z=e5(x,y)
    z = x^2
endfunction

disp(trapecioExtendida(e5,2,2,2,4))
//    0



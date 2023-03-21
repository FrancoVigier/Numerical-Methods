clc
clear

// Ejercicio 4

disp("a)")

// Funcion que toma una funcion, un intervalo y una cantidad de subIntervalos.
function res = metodoCompTrapecio(f, a, b, n)
    // Inicializamos h y res
    h = (b-a)/n;
    res = 0;
    // Iteramos sobre todos los subintervalos.
    for i = 0:n
        xn = a + i*h;
        // Si el intervalo es el primero o el ultimo dividimos f(xn) por 2.
        if(i == 0 | i == n)
            res = res + f(xn)/2;
        // En caso contrario no.
        else
            res = res + f(xn);
        end
    end
    // Multiplicamos todo por h.
    res = res * h;
endfunction

function y=I(x)
    y = (x+1)^-1
endfunction
disp("Metodo compuesto Trapecio")
disp(metodoCompTrapecio(I, 0, 1.5, 10))

// Fucnion que calcula el metodo compuesto de Simpson.
function res = metodoCompSimpson(f, a, b, n)
    // Inicializamos h y res.
    h = (b-a)/n
    res = 0
    
   // Primer intervalo.
    res = res + f(a + 0*h)
    // Iteramos sobre los n subintervalos.
    for i = 1:n-1
        
        // Si el subintervalo es par.
        if (pmodulo(i,2) == 0)
            res = res + 2*f(a + i*h);
        // Caso impar.
        else
            res = res + 4*f(a + i*h);
        end    
        
    end
    // Ultimos intervalo.
    res = res + f(a + n*h)
    // Multiplicamos por h/3
    res = res * h/3;
endfunction

disp("Metodo compuesto Simpson")
disp(metodoCompSimpson(I, 0, 1.5, 10))

disp("Valor exacto = 0.9262907")

disp("Error Trapecio")
disp(abs(metodoCompTrapecio(I, 0, 1.5, 10)-0.9262907))
//   0.008429

disp("Error Simpson")
disp(abs(metodoCompSimpson(I, 0, 1.5, 10)-0.9262907))
//   0.0099843


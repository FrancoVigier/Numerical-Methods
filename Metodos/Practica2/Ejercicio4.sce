// Ejercicio 4.

// Derivada recursiva.
function y = deriva(f, x, n, h)
    deff("y = DF0(x)", "y="+f)
    if n == 0 then
        // Caso base.
        y = DF0(x);
    else 
        // Se calcula el cociente incremental.
        y =(deriva(f, x+h, n-1, h) - deriva(f, x-h, n-1, h))./(2*h);
    end
endfunction

// Esta derivada recursiva tiene una optimizacion a la hora de calcularla.
// Se usa la siguiente fórmula: f'(x) = (f(x+h) - f(x-h))/2h

// Derivada iterativa.
function y = deriva2(f, v, n, h)
    deff("y = DF0(x)", "y="+f)
    if n == 0 then
        y = f(v);
    else
        for i=1:(n-1)
            // Por cada derivada definimos una nueva funcion, que luego se evaluaran.
            deff("y=DF"+string(i)+"(x)","y=(DF"+string(i-1)+"(x+"+string(h)+")-DF"+string(i-1)+"(x))/"+string(h));
        end
        deff("y=DFn(x)", "y=(DF"+string(n-1)+"(x+"+string(h)+")-DF"+string(n-1)+"(x))/"+string(h));
        // Se evalua la ultima derivada que utiliza todas las anteriores.
        y = DFn(v);
    end
endfunction

// Derivada numderative
function y = deriva3(f, v, n, h)
    // El procedimiento es similar a la funcion anterior, pero no se utilizar el cociente incremental
    // sino la funcion numderivative.
    deff("y = DF0(x)", "y="+f)
    if n == 0 then
        y = DF0(v);
    else
        for i=1:(n-1)
            deff("y=DF"+string(i)+"(x)", "y=numderivative(DF"+string(i-1)+",x,"+string(h)+",4)");
        end
        deff("y=DFn(x)", "y=numderivative(DF"+string(n-1)+",x,"+string(h)+",4)");
        y = DFn(v);
    end
endfunction

/*
Ejemplos:
    deriva("x^2", 2, 1, 0.00001) = 4
    deriva2("x^2", 2, 1, 0.00001) = 4.00001
    deriva3("x^2", 2, 1, 0.00001) = 4
    
    deriva("x^3-x+6", 1, 3, 0.00001) = 5.9952038
    deriva2("x^3-x+6", 1, 3, 0.00001) = 5.3290705
    deriva3("x^3-x+6", 1, 3, 0.00001) = 5.9366085
*/

/* 4-a) 
En el cociente incremental tenemos error de suprecion de cifras 
significativas al restar f(v+h)-f(v) (al ser h pequeño).
Ademas estamos dividiendo por h, lo cual acarrea error.
Tambien estamos aplicando funciones susesivamente lo cual genera una
propagacion de error.

En la implementada con numderivative, el error que se acarrea es el 
de la funcion numderivative que se evalua tantas veces con orden de 
derivada se quiera.

4-b)
Lo que hace que crezca el error es que el error de cada evaluacion es 
mayor que el de numderivative. Lo que hace que se termine propagando
y generando un resultado con un error mayor. 
*/

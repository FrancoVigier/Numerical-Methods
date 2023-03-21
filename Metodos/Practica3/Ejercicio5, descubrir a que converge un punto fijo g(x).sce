clc

clear

// Pequeña funcion que itera sobre la funcion del ejercicio 5
function y=f(x)
    res = 2.^((x)-1);
    for i=1:1000
        res = 2.^((res)-1);
    end
    y = res;
endfunction

// en este caso 0 esta dentro del rango de convergencia.
disp(f(0)); 

// pruebo con algo que este fuera del rango osea x0 > 1/ln(2)
disp(f(6)); 
// x = inf

// la iteracion de punto fijo no converge para x0 = 6

disp(f(1)); 
// x = inf

disp(f(-1)); 
// x = inf

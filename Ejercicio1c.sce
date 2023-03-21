clc

clear

// Pequeña funcion que itera sobre la funcion del ejercicio 1
function y=f(x)
    res = (x+cos(x))/2;
    for i=1:18
        res = (x+cos(x))/2;
    end
    y = res;
endfunction

// en este caso 0.8 esta dentro del rango de convergencia.
disp(f(0.8)); 
/*Salida
   0.7483534
*/

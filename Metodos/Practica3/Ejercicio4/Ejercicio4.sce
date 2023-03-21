clc

// Ejercicio 4
/*
    Luego de demostrar la convergencia teoriacamente, hice esta pequeña
    función que le aplica reiteradamente cos(x) a un valor, y puedo concluir
    que se converge a : 0.7390851
*/

function y=cosenoreiterado(x)
    y = x
    for i=1:100
        y = cos(y);
    end
endfunction

disp(cosenoreiterado(123.513));

// Muestra 0.7390851

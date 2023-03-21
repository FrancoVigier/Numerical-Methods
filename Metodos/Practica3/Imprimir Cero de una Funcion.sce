clc

clear

// Decidi separar el grafico de la funcion en 3 intervalos para poder 
// ver facilmente las raices.

// Ejercicio 1

function y=funcion1(x)
    y=cosh(x).*cos(x)+1;
endfunction

// Referencia al eje x.
function y=cero(x)
    y=x*0;  
endfunction

x = [1:2*10e-3:4];
y1 = funcion1(x);
y2 = cero(x)
plot(x,y1,"b");
plot(x,y2,"r");
figure

x = [4:2*10e-3:7];
y1 = funcion1(x);
plot(x,y1,"b");
plot(x,y2,"r");
figure

x = [7:2*10e-3:10];
y1 = funcion1(x);
plot(x,y1,"b");
plot(x,y2,"r");

// Las raices aproximadas son:
// 2, 4.5, 7.8

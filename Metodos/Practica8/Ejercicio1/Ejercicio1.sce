
clc

clear

// Calculo de la regla del trapecio
function y=reglaTrapecio(f,x0,x1)
    y = (x1-x0)*(f(x1)-f(x0))/2
endfunction

// Calculo de la regla de Simpson
function y=reglaSimpson(f,x0,x1,x2)
    y = ((x2-x0)/6)*(f(x0)+4*f(x1)+f(x2))
endfunction

disp("Apartado a)")

disp("Valor real:")
disp(intg(1, 2, log))
disp("Valor trapecio")
disp(reglaTrapecio(log,1,2))

disp("Valor Simpson")
disp(reglaSimpson(log,1,1.5,2))

/* 
 Apartado a)

 Valor real:

   0.3862944

 Valor trapecio

   0.3465736

 Valor Simpson

   0.3858346
*/
disp("Apartado b)")
function y=f2(x)
    y = x^(1/3)
endfunction
disp("Valor real")
disp(intg(0, 0.1, f2))
disp("Valor trapecio")

disp(reglaTrapecio(f2,0,0.1))

disp("Valor Simpson")
disp(reglaSimpson(f2,0,0.05,0.1))

/*
 Apartado b)

 Valor real

   0.0348119

 Valor trapecio

   0.0232079

 Valor Simpson

   0.0322962
*/

disp("Apartado c)")
function y=f3(x)
    y = sin(x)^2
endfunction
disp("Valor real")
disp(intg(0,%pi/3, f3))
disp("Valor trapecio")

disp(reglaTrapecio(f3,0,%pi/3))

disp("Valor Simpson")
disp(reglaSimpson(f3,0,%pi/6,%pi/3))

/*
 Apartado c)

 Valor real

   0.3070924

 Valor trapecio

   0.3926991

 Valor Simpson

   0.3054326
*/

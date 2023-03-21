clc

clear

// Este algoritmo de newton es similar al implementado en el archivo
// MetodosEcuacionesNoLineales pero con las modificaciones pedidas 
// para la determinacion de la tolerancia.



// Argumentos: funcion, punto inicial, tolerancia y cantidad maxima 
// de iteraciones.
// Argumentos: funcion, punto inicial, tolerancia y cantidad maxima 
// de iteraciones.
function y = newt_mult_variable(fn, X, eps, iter)
    y = X;
    Xn = X;
    i = 0;
      
    while((norm(y-Xn) > eps | i == 0)  && i < iter)
      Xn = y;
      J = numderivative(fn, Xn);
      // J matriz jacobiana
      y = Xn - inv(J)*fn(Xn);
      i = i+1;
    end
    // verifico si el while termino porque se acabaron las iteraciones
    // o se llego a la tolerancia minima
    if (norm(y-Xn) > eps) then
        disp("Se terminaron las recursiones");
    end
    disp(i)
    
endfunction


function y=sistema(x)
  // derivadas parciales de fn
  dxf1 = 4*%e^(2*x(1)^2+x(2)^2)*x(1)+2
  dyf1 = 6*x(2)+2*%e^(2*x(1)^2+x(2)^2)*x(2)
  y = [dxf1; dyf1]
endfunction

disp(newt_mult_variable(sistema, [1; 1], 0.000000000001,100))
/*
    En 9 iteraciones:
    
    x = -0.3765446
    y = 3.574D-28
*/

// Construyo la matriz hessiana con numericative
[J, H] = numderivative(sistema, [-0.3765446;0])
disp(J)

/*
J =

   8.3238132   0.       
   0.          8.6557281
   
    Vemos que es definida positiva, por lo tanto efectivamente el punto
    encontrado es minimo local.

*/


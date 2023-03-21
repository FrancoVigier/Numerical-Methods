clc

clear

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

//Ejercicio 9

function y=G(x)
  f1 = 1+x(1).^2-x(2).^2+%e.^x(1)*cos(x(2))
  f2 = 2*x(1)*x(2)+%e^x(1)*sin(x(2))
  y = [f1; f2]
endfunction

// Baje la tolerancia para que el algoritmo termine al alcanzar 5
// iteraciones y no por alcanzar la tolerancia pedida.

disp(newt_mult_variable(G, [-1; 4], 0.00001, 5))

// x = -0.2931627
// y = 1.1726598

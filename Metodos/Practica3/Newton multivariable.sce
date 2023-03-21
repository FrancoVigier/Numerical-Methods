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

//Ejercicio 10

function y=sistema(x)
  f1 = x(1).^2+ x(1)*x(2).^3-9
  f2 = 3*x(1).^2 * x(2)-4-x(2).^3
  y = [f1; f2]
endfunction

disp(newt_mult_variable(sistema, [1.2; 2.5], 0.001, 100))

// x = 1.3363554
// y = 1.7542352

disp(newt_mult_variable(sistema, [-2; 2.5], 0.001, 100))

// x =  -0.9012662
// y = -2.0865876

disp(newt_mult_variable(sistema, [-1.2; -2.5], 0.001, 100))

// x =  -0.9012662
// y = -2.0865876

disp(newt_mult_variable(sistema, [2; 2.5], 0.001, 100))

// x = 1.3363554
// y = 1.7542352

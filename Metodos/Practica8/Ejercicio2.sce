clc

clear

// Ejercicio 2

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
disp("a")

function y=fa(x)
    y = 1/x
endfunction

disp("Metodo Trapecio")
disp(metodoCompTrapecio(fa,1,3,4))
// 1.1166667

disp("Segun scilab")
disp(intg(1,3,fa))
// 1.0986123

disp("Diferencia")
disp(abs(intg(1,3,fa)-metodoCompTrapecio(fa,1,3,4)))
// 0.0180544

disp("d")

function y=fd(x)
    y = sin(%pi*x)
endfunction

disp("Metodo Trapecio")
disp(metodoCompTrapecio(fd,0,1,8))
//   0.6284174

disp("Segun scilab")
disp(intg(0,1,fd))
//   0.6366198

disp("Diferencia")
disp(abs(intg(0,1,fd)-metodoCompTrapecio(fd,0,1,8)))

disp("e")

function y=fe(x)
    y = x*sin(x)
endfunction

disp("Metodo Trapecio")
disp(metodoCompTrapecio(fe,0,2*%pi,8))
//  -5.9568332

disp("Segun scilab")
disp(intg(0,2*%pi,fe))
//  -6.2831853

disp("Diferencia")
disp(abs(intg(0,2*%pi,fe)-metodoCompTrapecio(fe,0,2*%pi,8)))
//    0.3263521

disp("Resto de apartados, para verificar buen funcionamiento.---------")
disp("b")

function y=fb(x)
    y = x^3
endfunction

disp("Metodo Trapecio")
disp(metodoCompTrapecio(fb,0,2,4))
//   4.25

disp("Segun scilab")
disp(intg(0,2,fb))
//   4

disp("Diferencia")
disp(abs(intg(0,2,fb)-metodoCompTrapecio(fb,0,2,4)))
//   0.25
   
disp("c")

function y=fc(x)
    y = x*(1+x^2)^(1/2)
endfunction

disp("Metodo Trapecio")
disp(metodoCompTrapecio(fc,0,3,6))
//   10.312201

disp("Segun scilab")
disp(intg(0,3,fc))
//   10.207592

disp("Diferencia")
disp(abs(intg(0,3,fc)-metodoCompTrapecio(fc,0,3,6)))
//   0.104609



disp("f")

function y=ff(x)
    y = (x^2)*%e^x
endfunction

disp("Metodo Trapecio")
disp(metodoCompTrapecio(ff,0,1,8))
//   0.7288902

disp("Segun scilab")
disp(intg(0,1,ff))
//   0.7182818

disp("Diferencia")
disp(abs(intg(0,1,ff)-metodoCompTrapecio(ff,0,1,8)))
//  0.0106083




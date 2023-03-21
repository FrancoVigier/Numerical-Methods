clc

clear

// Ejercicio 2

// Fucnion que calcula el metodo compuesto de Simpson.
function res = metodoCompSimpson(f, a, b, n)
    // Inicializamos h y res.
    h = (b-a)/n
    res = 0
    
   // Primer intervalo.
    res = res + f(a + 0*h)
    // Iteramos sobre los n subintervalos.
    for i = 1:n-1
        
        // Si el subintervalo es par.
        if (pmodulo(i,2) == 0)
            res = res + 2*f(a + i*h);
        // Caso impar.
        else
            res = res + 4*f(a + i*h);
        end    
        
    end
    // Ultimos intervalo.
    res = res + f(a + n*h)
    // Multiplicamos por h/3
    res = res * h/3;
endfunction

disp("a")

function y=fa(x)
    y = 1/x
endfunction

disp("Metodo Trapecio")
disp(metodoCompSimpson(fa,1,3,4))
// 1.1166667

disp("Segun scilab")
disp(integrate("1/x","x",1,3))
// 1.0986123

disp("Diferencia")
disp(abs(integrate("1/x","x",1,3)-metodoCompSimpson(fa,1,3,4)))

disp("b")

function y=fb(x)
    y = x^3
endfunction

disp("Metodo Trapecio")
disp(metodoCompSimpson(fb,0,2,4))
//   4

disp("Segun scilab")
disp(integrate("x^3","x",0,2))
//   4

disp("Diferencia")
disp(abs(integrate("x^3","x",0,2)-metodoCompSimpson(fb,0,2,4)))

disp("c")

function y=fc(x)
    y = x*(1+x^2)^(1/2)
endfunction

disp("Metodo Trapecio")
disp(metodoCompSimpson(fc,0,3,6))
//   10.206346

disp("Segun scilab")
disp(integrate("x*(1+x^2)^(1/2)","x",0,3))
//   10.207592

disp("Diferencia")
disp(abs(integrate("x*(1+x^2)^(1/2)","x",0,3)-metodoCompSimpson(fc,0,3,6)))

disp("d")

function y=fd(x)
    y = sin(%pi*x)
endfunction

disp("Metodo Trapecio")
disp(metodoCompSimpson(fd,0,1,8))
//   0.6367055

disp("Segun Trapecio")
disp(integrate("sin(%pi*x)","x",0,1))
//   0.6366198

disp("Diferencia")
disp(abs(integrate("sin(%pi*x)","x",0,1)-metodoCompSimpson(fd,0,1,8)))

disp("e")

function y=fe(x)
    y = x*sin(x)
endfunction

disp("Metodo Trapecio")
disp(metodoCompSimpson(fe,0,2*%pi,8))
//  -6.2975102

disp("Segun scilab")
disp(integrate("x*sin(x)","x",0,2*%pi))
//  -6.2831853

disp("Diferencia")
disp(abs(integrate("x*sin(x)","x",0,2*%pi)-metodoCompSimpson(fe,0,2*%pi,8)))

disp("f")

function y=ff(x)
    y = (x^2)*%e^x
endfunction

disp("Metodo Trapecio")
disp(metodoCompSimpson(ff,0,1,8))
//   0.7183215

disp("Segun scilab")
disp(integrate("(x^2)*%e^x","x",0,1))
//   0.7182818

disp("Diferencia")
disp(abs(integrate("(x^2)*%e^x","x",0,1)-metodoCompSimpson(ff,0,1,8)))


/// Podemos observar claramente que simpson es mas preciso que trapecio


function y=f(x)
    y=cos(2*acos(x))
endfunction

disp(metodoCompSimpson(f,-1,1,2))
disp(metodoCompSimpson(f,-1,1,4))
disp(metodoCompSimpson(f,-1,1,6))
disp(intg(-1,1,f))

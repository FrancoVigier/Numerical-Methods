clc

clear

// Metodo de Lagrange, PARA OBTENER UN POLINOMIO DE GRANO N SE NECESITAN N+1 PUNTOS DE LA FUNCION QUE QUEREMOS INTERPOLAR

function y = Lk(x, k)
    [Xn,Xm] = size(x)
    
    // Se genera un vector con las raices del polinomio LK
    r = [x(1:k-1) x(k+1:Xm)]
    // Con poly generamos el polinomio cuyas raices son r
    p = poly(r,"x","roots")
    // Evaluamos
    pk = horner(p, x(k))
    y = p / pk
endfunction

function z = interpolLagrange(x,y)
    [Xn,Xm] = size(x)
    pol = 0
    // Conformamos el polinomio de lagrange.
    for k = 1:Xm
        pol = pol + (Lk(x,k)*y(k))
    end
    z = pol
endfunction
//__________________________________________
//EJEMPLO INTERPOLACION LINEAL Y CUBICA DE e^x
x1 = [0,0.6]//2 puntos entonces LINEAL
y1 = [1.0,1.8221]

xc = [0,0.2,0.4,0.6]//4 puntos  entonces CUBICA
yc = [1.0,1.2214,1.4918,1.8221]

// Calculando polinomios
lagrangeLineal = interpolLagrange(x1,y1)
lagrangeCubico = interpolLagrange(xc,yc)

// Mostrando resultados

disp("Valor real")
disp(%e^(1/3))
// e^1/3 = 1.3956124

disp("Lagrange")

// Lienal

disp("Resultado de evaluar polinomio lienal en 1/3")
disp(horner(lagrangeLineal,1/3))
// = 1.4016667
disp("Cota de error lineal:")
disp(abs((1/3-0)*(1/3-0.6)*1/2*%e^(0.6)))
// = 0.0080983
disp("Error del polinomio lineal")
disp(abs(1.395612425-horner(lagrangeLineal,1/3)))
// = 0.0060542

// Cubico

disp("Resultado de evaluar polinomio cubico en 1/3")
disp(horner(lagrangeCubico,1/3))
// = 1.3955494
disp("Cota de error cubico:")
disp((0-0)*(-0.2)*(-0.4)*(-0.6)*1/factorial(4)*%e^0.6)
// = 0.00006
disp("Error del polinomio cubico")
disp(abs(1.395612425-horner(lagrangeCubico,1/3)))
// = 0.000063


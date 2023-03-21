// Para correr este codigo, previamente debe ejecutarse el ejercicio 1-b


clc // limpia la consola

// Primera funcion
function y = P1(x)
        y = ((8+x)^(1/3))-2;
endfunction
// Segunda funci´on

function y = P2(x)
y = TaylorFun("((8+x)^(1/3))-2", 0, x, 3,0.0001);
endfunction

// figure es para que cada una de las graficas se muestre individualmente.
figure
// Para el calulo de intervalos y su paso se hizo:
// paso = (final - inicio)/100
// Intervalo 1
x = [-1e-12:2*10e-14:1e-12];
y1 = P1(x);
y2 = P2(x);
// Gr´afica de las funciones
plot(x,y1,'b');
plot(x,y2,'r','thickness',2)
legend(["Función";"Polinomio de Taylor"]);
figure
// Intervalo 2
x = [-1e-13:2*10e-15:1e-13];
y1 = P1(x);
y2 = P2(x);
plot(x,y1,'b');
plot(x,y2,'r','thickness',2)
legend(["Función";"Polinomio de Taylor"]);
figure
// Intervalo 3
x = [-1e-14:2*10e-16:1e-14];
y1 = P1(x);
y2 = P2(x);
plot(x,y1,'b');
plot(x,y2,'r','thickness',2)
legend(["Función";"Polinomio de Taylor"]);

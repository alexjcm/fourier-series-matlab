% La función "fourier_epicycles" calcula el número necesario de epicíclos
% para dibujar la curva dada, especificada por las coordenadas dadas.
% Estos epicíclos tienen diferentes radios, fases y rotaciones a diferentes
% frecuencias. Nótese que el número de epicíclos sería el mismo que
% la longitud de la curva.

% Parámetros de entrada:                                                            %
%  - curve_x:      Coordenadas X de la curva
%  - curve_y:       Coordenadas Y de la curva.                         %
%  - no_circles:   (Opcional) Número máximo de círculos. La máxima
% precisión de dibujo se alcanza si el no_circulos es exactamente el
% número de puntos de la curva (que es el valor por defecto:
%   no_circulos=longitud(curva_x);)

% Ejemplo de uso:                                                       %
% load('heart.mat'); fourier_epicycles(curve_x, curve_y);           %

function fourier_epicycles(curve_x, curve_y, no_circles)
% Círculos del número predeterminado
if nargin < 3, no_circles = length(curve_x); end
if no_circles > length(curve_x)
    warning(['El número de círculos no puede ser mayor que el número de puntos.' ...        
        'El número de círculos se ha fijado en: %i.', length(curve_x)]);
    no_circles = length(curve_x);
end

% Reducir la muestra de la curva si es necesario
if no_circles < length(curve_x)
    curve_x = resample(curve_x, no_circles, length(curve_x));
    curve_y = resample(curve_y, no_circles, length(curve_y));
    curve_x = [curve_x(:); curve_x(1)];
    curve_y = [curve_y(:); curve_y(1)];
end

% Parametros
pause_duration = 0;     % No. segundos de pausa entre los plots
periods_to_plot = 1;    % No. períodos del círculo principal hasta que se detenga

% Calcular el DFT del número complejo
Z = complex(curve_x(:), curve_y(:));
[X, freq, radius, phase] = dft_epicycles(Z,length(Z));
time_step = 2*pi/length(X);

% Dubujar el resultado
time = 0;
wave = [];
generation = 1;
h = figure;
handle = axes('Parent',h);
while generation < periods_to_plot*length(X)+2
    [x, y] = draw_epicycles(freq, radius, phase, time, wave, handle);    
    % Añade el siguiente punto calculado a la curva de la onda
    wave = [wave; [x,y]];    
    % Incremento del tiempo y la generación
    time = time + time_step;
    generation = generation + 1;
    pause(pause_duration);
end
end



%% Funciones secundarias utilizadas por la funcion principal anterior
% Calcula los parámetros DFT (Transformada de Fourier discreta) de un vector
% complejo y proporciona la frecuencia, el radio y la fase de cada uno de los ciclos.
function [X, freq, radius, phase] = dft_epicycles(Z, N)
% DFT (Transformada de Fourier discreta)
X = fft(Z, N)/N;    % DFT  de la serie compleja
freq = 0:1:N-1;     % La frecuencia de los círculos
radius = abs(X);    % Los radios de los círculos
phase = angle(X);   % Fase inicial de los círculos

% Ordenar por radio
[radius, idx] = sort(radius, 'descend');
X = X(idx);
freq = freq(idx);
phase = phase(idx);
end

% Dibuja los epiciclos y la línea de resultados en un momento dado
function [x, y] = draw_epicycles(freq, radius, phase, time, wave, handle)
%  Calcular las coordenadas
x = 0;
y = 0;
N = length(freq);
centers = NaN(N,2);
radii_lines = NaN(N,4);
for i = 1:1:N
    % Almacena las coordenadas anteriores, que serán el centro del nuevo círculo
    prevx = x;
    prevy = y;    
    % Obtener las nuevas coordenadas del punto de unión
    x = x + radius(i) * cos(freq(i)*time + phase(i));
    y = y + radius(i) * sin(freq(i)*time + phase(i));    
    % Centros de círculos
    centers(i,:) = [prevx, prevy];    
    % Líneas de radio
    radii_lines(i,:) = [prevx, x, prevy, y];
end

% PLOTTEO
cla; % Despejando los axes
% Note that viscircles do not clear the axes and thus, they
% should be cleared in order to avoid lagging issues due to
% the amount of objects that are stacked
% CirCULOS
viscircles(handle, centers, radius, 'Color', 0.5 * [1, 1, 1], 'LineWidth', 0.1);
hold on;
% Las líneas que unen el centro con los puntos tangentes
plot(handle, radii_lines(:,1:2), radii_lines(:,3:4), 'Color', 0.5*[1 1 1], 'LineWidth', 0.1);
hold on;
% Línea resultado
if ~isempty(wave), plot(handle, wave(:,1), wave(:,2), 'k', 'LineWidth', 2); hold on; end

% Puntero
plot(handle, x, y, 'or', 'MarkerFaceColor', 'r');
hold off;
% Limites del Plot
%xmax = sum(radius);
%axis([-xmax xmax -xmax xmax]);

axis equal;
axis off;
drawnow;
end
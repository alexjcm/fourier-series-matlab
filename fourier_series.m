function varargout = fourier_series(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @fourier_series_OpeningFcn, ...
    'gui_OutputFcn',  @fourier_series_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Se ejecuta justo antes de que fourier_series se haga visible.
function fourier_series_OpeningFcn(hObject, ~, handles, varargin)
set(handles.input_function,'visible','off');
set(handles.txt_function,'visible','off');
% componentes para el trazado manual
set(handles.draw_axes,'visible','off');
set(handles.button_draw_reset,'visible','off');
set(handles.button_draw_ok,'visible','off');
set(handles.button_minus,'visible','off');
set(handles.text_num_circles,'visible','off');
set(handles.button_add,'visible','off');

% Choose default command line output for fourier_series
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes fourier_series wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% Inicializa la opcion de trazar a mano
set_up_the_drawing(handles);


% --- Executes during object creation, after setting all properties.
function input_iterations_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function input_function_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function menu_waves_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Outputs from this function are returned to the command line.
function varargout = fourier_series_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


%%
% --- Executes on selection change in menu_waves.
function menu_waves_Callback(hObject, eventdata, handles)
index = handles.menu_waves.Value;
% si se selecciona el index 4 los componetes respectivos se activaran
if index == 4
    cla(handles.draw_axes);
    set(handles.draw_axes,'visible','off');
    set(handles.button_draw_reset,'visible','off');
    set(handles.button_draw_ok,'visible','off');
    set(handles.button_minus,'visible','off');
    set(handles.text_num_circles,'visible','off');
    set(handles.button_add,'visible','off');
    set(handles.dinamic_axes,'visible','on');
    set(handles.input_function,'visible','on');
    set(handles.txt_function,'visible','on');
    set(handles.static_axes,'visible','on');
    set(handles.txt_iterations,'visible','on');
    set(handles.input_iterations,'visible','on');
    set(handles.button_calculate,'visible','on');
elseif index == 5 % Prepara la interfaz para Dibujar una onda
    cla(handles.static_axes);
    cla(handles.dinamic_axes);
    set(handles.dinamic_axes,'visible','off');
    set(handles.txt_iterations,'visible','off');
    set(handles.input_iterations,'visible','off');
    set(handles.button_calculate,'visible','off');
    set(handles.input_function,'visible','off');
    set(handles.txt_function,'visible','off');
    set(handles.static_axes,'visible','off');
    set(handles.draw_axes,'visible','on');
    set(handles.button_draw_reset,'visible','on');
    set(handles.button_draw_ok,'visible','on');
    set(handles.button_draw_ok,'Enable','off')
    set(handles.button_minus,'visible','on');
    set(handles.text_num_circles,'visible','on');
    set(handles.button_add,'visible','on');    
else
    cla(handles.draw_axes);
    set(handles.input_function,'visible','off');
    set(handles.txt_function,'visible','off');
    set(handles.draw_axes,'visible','off');
    set(handles.button_draw_reset,'visible','off');
    set(handles.button_draw_ok,'visible','off');
    set(handles.button_minus,'visible','off');
    set(handles.text_num_circles,'visible','off');
    set(handles.button_add,'visible','off');
    set(handles.dinamic_axes,'visible','on');
    set(handles.txt_iterations,'visible','on');
    set(handles.input_iterations,'visible','on');
    set(handles.button_calculate,'visible','on');
    set(handles.static_axes,'visible','on');
end


% --- Esta función se  ejecuta al presionar el boton calcular.
function button_calculate_Callback(hObject, eventdata, handles)
allItems = handles.menu_waves.String;
index = handles.menu_waves.Value;
func = allItems{index};
txt_n = get(handles.input_iterations,'String');

n = str2num(txt_n);
L = 0.5; % L es horizontal
% L indica los limites del intervalo, por ejemplo de -pi hasta pi, ó -1
% hasta 1 siendo respectivamente L: pi y 1
% a0, an, bn son coeficientes
h =  0.0001; % incremento o salto horizontalmente
% k ó n indica cuantos terminos de la serie fourier vamos a graficar
switch index
    case 1
        %% Gráfico estático de la onda cuadrada
        t = 0:h:L; % 0, 0.0001, 0.0002,..., 0.5
        y = square(2*pi*5*t);%  1, 1.., -1, -1.., 1, 1
        % Seleccione el eje sobre el que desea trazar.
        axes(handles.static_axes)
        plot(t,y) %plot(X, Y) grafica lineas 2D
        axis([0 0.5 -1.5 1.5])
        grid on
        
        % Diagrama de la aproximación de las series de Fourier.
        % Gráfico dinamico de la onda cuadrada
        x = 0:h:L;
        y = zeros(size(x));
        for k=1:n(1)
            for i=1:length(x)
                % Realizamos las sumatorias correspondientes
                y(i) = y(i) + (2/pi)*(1-(-1)^k)*sin(2*pi*5*k*x(i))/k;
                %y(i) = y(i) +  (4/pi) * (1/k) * sin(2*pi*5*k*t(i));
            end
        end
        
        axes(handles.dinamic_axes);
        axis([0 0.5 -1.5 1.5]);
        plot(x, y);
        grid on
        axis([0 0.5 -1.5 1.5]);
        
    case 2
        %% GRAFICO ESTÁTICO DE LA ONDA DE DIENTES DE SIERRA
        t = 0:h:L; % 0, 0.0001, 0.0002,..., 0.5
        y = sawtooth(2*pi*5*t);
        % Seleccione el eje sobre el que desea trazar.
        axes(handles.static_axes);
        plot(t,y)
        grid on
        axis([0 0.5 -1.5 1.5])
        
        % GRAFICO DINAMICO DE LA ONDA DE DIENTES DE SIERRA
        % Diagrama de la aproximación de las series de Fourier.
        y = zeros(size(t));
        % FIXME
        for k=1:n(1)
            for i=1:length(t)
                y(i) = y(i) - (1/(k*pi)) * sin(2*pi*5*k*t(i));
            end
        end
        y(i) = y(i) + 1/2;
        axes(handles.dinamic_axes);
        plot(t,y)
        grid on
        axis([0 0.5 -1.5 1.5])
        
        
    case 3
        %% Gráfico estático de la onda triangular
        t = 0:h:L; % 0, 0.0001, 0.0002,..., 0.5
        y = sawtooth(2*pi*5*t, 1/2); % 1/2 convierte en triangular al dividir
        % Seleccione el eje sobre el que desea trazar.
        axes(handles.static_axes);
        plot(t,y)
        grid on
        axis([0 0.5 -1.5 1.5])
        
        % Gráfico dinamico de la onda triangular
        % Diagrama de la aproximación de las series de Fourier.
        y = zeros(size(t));
        
        for k=1:n(1)
            for i=1:length(t)
                y(i) = y(i) + 8 * ((-1)^((k-1)/2))/(pi^2*k^2) * sin(2*pi*5*k*t(i));
            end
        end
        
        axes(handles.dinamic_axes);
        plot(t,y)
        grid on
        axis([0 0.5 -1.5 1.5])
        
        
    case 4
        %% Gráfico de una onda personalizada
        myedit3 = get(handles.input_function,'String');
        if myedit3 == ""
            msg = msgbox('Ingrese una función', 'Empty Value', 'error');
            th = findall(msg, 'Type', 'Text');    %get handle to text within msgbox
            th.FontSize = 12;
        else
            syms x s
            fun = get(handles.input_function, 'string');% obtiene la función desde la GUI
            fun = str2sym(fun);
            % fun = abs(x);
            % fun = cos(2*x) - 2;
            per = 2; % periodo de la funcion
            lmin = 0; % inicio de la funcion
            A0 =((2/per)*int((fun*cos(2*pi*0*1/per)), x, lmin, per+lmin)) / 2;
            s = A0;
            
            for i=1:n
                An = (2/per)*int((fun*cos(2*pi*i*x/per)),x,lmin,per+lmin);
                Bn = (2/per)*int((fun*sin(2*pi*i*x/per)),x,lmin,per+lmin);
                as = An * cos(2*pi*i*x/per);
                bs = Bn * sin(2*pi*i*x/per);
                s = s + as + bs;
            end
            
            axes(handles.dinamic_axes);
            fplot(s,[lmin, 4*per + lmin]);
            grid on
            
        end %
        
    otherwise
end


% --- Se ejecuta cuando se presiona el boton Dinujar.
function button_draw_ok_Callback(hObject, eventdata, handles)
global xy;
if ~isempty(xy)
    n = str2num(get(handles.text_num_circles,'String'));
    fourier_epicycles(xy(:,1), xy(:,2), n);
end

% --- Se ejecuta cuando se presiona el boton Restablecer.
function button_draw_reset_Callback(hObject, eventdata, handles)
global xy;
cla(handles.draw_axes);
set(handles.text_num_circles,'String', num2str(0));
xy = [];
set_up_the_drawing(handles);

% --- Executes on button press in button_minus.
function button_minus_Callback(hObject, eventdata, handles)
value = str2num(get(handles.text_num_circles,'String'))-1;
if value > 1
    set(handles.text_num_circles,'String', num2str(value));
end


% --- Executes on button press in button_add.
function button_add_Callback(hObject, eventdata, handles)
global xy;
value = str2num(get(handles.text_num_circles,'String'))+1;
if value <= size(xy,1)
    set(handles.text_num_circles,'String', num2str(value));
end

% --- Establece el espacio de dibujo
function set_up_the_drawing(handles)
% Coordenadas del futuro dibujo
global xy;
xy = [];
try
    % Funcionalidad dibujar
    title(handles.draw_axes,'Dibuje una figura', 'Color', 'b');
    hFH = imfreehand();
    if isempty(hFH)
        return; % Saltar...
    end
    
    xy = hFH.getPosition;
    xy = [xy; xy(1,:)];
    delete(hFH);
    xCoordinates = xy(:, 1);
    yCoordinates = xy(:, 2);
    plot(xCoordinates, yCoordinates, 'b', 'LineWidth', 2);
    hold off;
    % Establece el numero de círculos por defecto.
    set(handles.text_num_circles,'String', size(xy,1));
    % Habilita el boton Dibujar
    set(handles.button_draw_ok,'Enable','on')
catch me
end

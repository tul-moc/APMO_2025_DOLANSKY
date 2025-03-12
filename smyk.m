function pdemodel
[pde_fig,ax]=pdeinit;
pdetool('appl_cb',3);
set(ax,'DataAspectRatio',[1 1 1]);
set(ax,'PlotBoxAspectRatio',[2.1428571428571428 1 1.4285714285714284]);
set(ax,'XLimMode','auto');
set(ax,'YLimMode','auto');
set(ax,'XTickMode','auto');
set(ax,'YTickMode','auto');

% Geometry description:
pderect([0 2 0 1],'box');
set(findobj(get(pde_fig,'Children'),'Tag','PDEEval'),'String','box')

% Boundary conditions:
pdetool('changemode',0)
pdesetbd(4,...
'neu',...
2,...
char('0','0','0','0'),...
char('0','-1e5'))
pdesetbd(3,...
'neu',...
2,...
char('0','0','0','0'),...
char('1e5','0'))
pdesetbd(2,...
'neu',...
2,...
char('0','0','0','0'),...
char('0','1e5'))
pdesetbd(1,...
'neu',...
2,...
char('0','0','0','0'),...
char('-1e5','0'))

% Mesh generation:
setappdata(pde_fig,'Hgrad',1.3);
setappdata(pde_fig,'refinemethod','regular');
setappdata(pde_fig,'jiggle',char('on','mean',''));
setappdata(pde_fig,'MesherVersion','preR2013a');
pdetool('initmesh')
pdetool('refine')

% PDE coefficients:
pdeseteq(1,...
char('2*((1E3)./(2*(1+(0.3))))+(2*((1E3)./(2*(1+(0.3)))).*(0.3)./(1-(0.3)))','0','(1E3)./(2*(1+(0.3)))','0','(1E3)./(2*(1+(0.3)))','2*((1E3)./(2*(1+(0.3)))).*(0.3)./(1-(0.3))','0','(1E3)./(2*(1+(0.3)))','0','2*((1E3)./(2*(1+(0.3))))+(2*((1E3)./(2*(1+(0.3)))).*(0.3)./(1-(0.3)))'),...
char('0.0','0.0','0.0','0.0'),...
char('0.0','0.0'),...
char('1.0','0','0','1.0'),...
'0:10',...
'0.0',...
'0.0',...
'[0 100]')
setappdata(pde_fig,'currparam',...
['1E3';...
'0.3';...
'0.0';...
'0.0';...
'1.0'])

% Solve parameters:
setappdata(pde_fig,'solveparam',...
char('0','1000','10','pdeadworst',...
'0.5','longest','0','1E-4','','fixed','Inf'))

% Plotflags and user data strings:
setappdata(pde_fig,'plotflags',[8 1 1 1 1 1 1 1 0 0 0 1 1 0 0 0 1 1]);
setappdata(pde_fig,'colstring','');
setappdata(pde_fig,'arrowstring','');
setappdata(pde_fig,'deformstring','');
setappdata(pde_fig,'heightstring','');

% Solve PDE:
pdetool('solve')

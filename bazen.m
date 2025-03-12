function pdemodel
[pde_fig,ax]=pdeinit;
pdetool('appl_cb',9);
set(ax,'DataAspectRatio',[1 1 1]);
set(ax,'PlotBoxAspectRatio',[3 2 1]);
set(ax,'XLimMode','auto');
set(ax,'YLimMode','auto');
set(ax,'XTickMode','auto');
set(ax,'YTickMode','auto');

% Geometry description:
pderect([0 2 0 -1],'voda');
pderect([0 2.2999999999999998 0 -1.3],'plast');
pderect([0 6 0 -4],'zem');
set(findobj(get(pde_fig,'Children'),'Tag','PDEEval'),'String','voda+plast+zem')

% Boundary conditions:
pdetool('changemode',0)
pdesetbd(12,...
'neu',...
1,...
'0',...
'0')
pdesetbd(11,...
'neu',...
1,...
'0',...
'0')
pdesetbd(10,...
'neu',...
1,...
'0',...
'0')
pdesetbd(9,...
'neu',...
1,...
'0',...
'0')
pdesetbd(8,...
'neu',...
1,...
'0',...
'0')
pdesetbd(7,...
'neu',...
1,...
'0',...
'0')
pdesetbd(6,...
'dir',...
1,...
'1',...
'0')
pdesetbd(5,...
'dir',...
1,...
'1',...
'0')

% Mesh generation:
setappdata(pde_fig,'Hgrad',1.3);
setappdata(pde_fig,'refinemethod','regular');
setappdata(pde_fig,'jiggle',char('on','mean',''));
setappdata(pde_fig,'MesherVersion','preR2013a');
pdetool('initmesh')

% PDE coefficients:
pdeseteq(2,...
'0.6*2*pi*x!1.0!1.0',...
'0!1.0!1.0',...
'(1000*x)+(0).*(0)!(1.0)+(1.0).*(0.0)!(1.0)+(1.0).*(0.0)',...
'(1000).*(4200*2*pi*x)!(1.0).*(1.0)!(1.0).*(1.0)',...
'0:1000:100000',...
'0.0',...
'0.0',...
'[0 100]')
setappdata(pde_fig,'currparam',...
['1000!1.0!1.0       ';...
'4200*2*pi*x!1.0!1.0';...
'0.6*2*pi*x!1.0!1.0 ';...
'1000*x!1.0!1.0     ';...
'0!1.0!1.0          ';...
'0!0.0!0.0          '])

% Solve parameters:
setappdata(pde_fig,'solveparam',...
char('0','1000','10','pdeadworst',...
'0.5','longest','0','1E-4','','fixed','Inf'))

% Plotflags and user data strings:
setappdata(pde_fig,'plotflags',[1 1 1 1 1 1 1 1 0 0 0 101 1 0 0 0 0 1]);
setappdata(pde_fig,'colstring','');
setappdata(pde_fig,'arrowstring','');
setappdata(pde_fig,'deformstring','');
setappdata(pde_fig,'heightstring','');

% Solve PDE:
pdetool('solve')

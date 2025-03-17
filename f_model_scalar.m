% pridani tepla na pravou stranu
function f_model_scalar(gd,sf,ns)
model = createpde;
g=decsg(gd,sf,ns);
geometryFromEdges(model,g);

applyBoundaryCondition(model,'dirichlet','Edge',1:3,'u',0);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',10);
generateMesh(model);
results = solvepde(model);
pdeplot(model,'XYData',results.NodalSolution,'Mesh','on')


% pdegplot(g,'EdgeLabels', 'on');
% pdegplot(model,'EdgeLabels','on')

end

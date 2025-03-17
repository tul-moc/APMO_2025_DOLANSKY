clc;
clear;
close all;
model = femodel(AnalysisType="structuralStatic", ...
                Geometry="Cactus.stl");
model.MaterialProperties = ...
        materialProperties(YoungsModulus=200e9, ...
                           PoissonsRatio=0.005);
model.FaceBC(4) = faceBC(Constraint="fixed");
model.FaceLoad(8) = faceLoad(SurfaceTraction=[0;0;-1e4]);
model = generateMesh(model);
result = solve(model);
figure
pdeplot3D(result.Mesh,ColorMapData=result.Displacement.ux);
title("x-displacement")
colormap("jet")
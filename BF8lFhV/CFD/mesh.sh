./Allclean
cd constant/polyMesh
m4 -P blockMeshDict.m4 > blockMeshDict
cd ../..
blockMesh
#cp -r orig.0/ 0
topoSet -dict system/topoSetDict
createPatch -overwrite
#rm -r 0
cp -r orig.0/ 0
foamToSurface surface.stl
surfaceSplitByPatch surface.stl
mv surface_*.stl ../DEM/stl_files/

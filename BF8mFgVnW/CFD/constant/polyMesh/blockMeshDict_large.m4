// Parametrized test case for a BF geometry


//Run using:
//m4 -P blockMeshDict.m4 > blockMeshDict

//m4 definitions:
m4_changecom(//)m4_changequote([,])
m4_define(calc, [m4_esyscmd(perl -e 'use Math::Trig; printf ($1)')])
m4_define(VCOUNT, 0)
m4_define(vlabel, [[// ]Vertex $1 = VCOUNT m4_define($1, VCOUNT)m4_define([VCOUNT], m4_incr(VCOUNT))])

//Mathematical constants:
m4_define(pi, 3.1415926536)

//Geometry
// radii of blast furnace
m4_define(rBF1, 5.8)
m4_define(rBF2, 7.37)
// number of tuyeres
m4_define(ntuy, 32)
m4_define(hOpeningAngle, calc(pi/ntuy))
m4_define(x1, 2)
m4_define(z1, -1)
m4_define(z2, 0.75)
m4_define(z3, 3.9)
m4_define(z4, 4.5)

m4_define(y1,calc(tan(hOpeningAngle)*(rBF1-x1)))
m4_define(y2,calc(tan(hOpeningAngle)*rBF1))
m4_define(y3,calc(tan(hOpeningAngle)*rBF2))




//Grid points (integers!):
m4_define(rNumberOfCells, 10)
m4_define(tNumberOfCells, 28)
m4_define(zNumberOfCells, 8)
m4_define(rGrading, 0.5)




/*---------------------------------------------------------------------------*\
| =========                 |                                                 |
| \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox           |
|  \\    /   O peration     | Version:  1.4.1                                 |
|   \\  /    A nd           | Web:      http://www.openfoam.org               |
|    \\/     M anipulation  |                                                 |
\*---------------------------------------------------------------------------*/

FoamFile
{
    version         2.0;
    format          ascii;

    root            "";
    case            "";
    instance        "";
    local           "";

    class           dictionary;
    object          blockMeshDict;
}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

convertToMeters 1;

vertices
(
//Plane A:
(0 -calc(y2) z1) vlabel(V0)
(x1 -calc(y1) z1) vlabel(V1)
(x1 y1 z1) vlabel(V2)
(0 y2 z1) vlabel(V3)

//Plane B:
(0 -calc(y2) z2) vlabel(V4)
(x1 -calc(y1) z2) vlabel(V5)
(x1 y1 z2) vlabel(V6)
(0 y2 z2) vlabel(V7)

//Plane C:
(calc(rBF1-rBF2) -calc(y3) z3) vlabel(V8)
(x1 -calc(y1) z3) vlabel(V9)
(x1 y1 z3) vlabel(V10)
(calc(rBF1-rBF2) y3 z3) vlabel(V11)

//Plane D:
(calc(rBF1-rBF2) -calc(y3) z4) vlabel(V12)
(x1 -calc(y1) z4) vlabel(V13)
(x1 y1 z4) vlabel(V14)
(calc(rBF1-rBF2) y3 z4) vlabel(V15)


);

// Defining blocks:
blocks
(
    //Block between plane A and plane B:
    hex ( V0 V1 V2 V3 V4 V5 V6 V7 ) AB
    (rNumberOfCells tNumberOfCells zNumberOfCells)
    simpleGrading (rGrading 1 1)

    //Block between plane B and plane C:
    hex ( V4 V5 V6 V7 V8 V9 V10 V11) BC
    (rNumberOfCells tNumberOfCells zNumberOfCells)
    simpleGrading (rGrading 1 1)

    //Block between plane C and plane D:
    hex ( V8 V9 V10 V11 V12 V13 V14 V15) CD
    (rNumberOfCells tNumberOfCells zNumberOfCells)
    simpleGrading (rGrading 1 1)
);

// Defining patches:
boundary
(
    bottom
    {
        type wall;
        faces
        (
         (V0 V1 V2 V3)
         (V0 V4 V7 V3)
         (V4 V8 V11 V7)
         (V8 V12 V15 V11)
        );
    }
    top
    {
        type wall;
        faces
        (
         (V12 V13 V14 V15)
        );
    }
    side
    { 
        type wall;
        faces
        (
         (V0 V1 V5 V4)
         (V4 V5 V9 V8)
         (V8 V9 V13 V12)
         (V3 V2 V6 V7)
         (V7 V6 V10 V11)
         (V11 V10 V14 V15)
        );
    }
    inner
    { 
        type wall;
        faces
        (
         (V1 V2 V6 V5)
         (V5 V6 V10 V9)
         (V9 V10 V14 V13)
        );
    }
);

mergePatchPairs 
(
);

// ************************************************************************* //

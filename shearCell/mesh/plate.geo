cl1 = 0.1;
Point(1) = {0, 0, 0, cl1};
Point(2) = {1, 0, 0, cl1};

Rotate {{0, 0, 1}, {0, 0, 0}, Pi/2} {
  Duplicata { Point{2}; }
}
Rotate {{0, 0, 1}, {0, 0, 0}, Pi/2} {
  Duplicata { Point{3}; }
}
Rotate {{0, 0, 1}, {0, 0, 0}, Pi/2} {
  Duplicata { Point{4}; }
}
Circle(1) = {2, 1, 3};
Circle(2) = {3, 1, 4};
Circle(3) = {4, 1, 5};
Circle(4) = {5, 1, 2};
Line Loop(5) = {1, 2, 3, 4};
Plane Surface(6) = {5};

-- Humam Rashid
-- CISC 7120X, Fall 2019.
-- Haskell Homework.

import Data.List

-- 1. Get volume of a sphere given radius r.
sphere r = (4/3) * pi * (r**3)

-- 2. Get real roots of quadratic equation of the form ax^2+bx+c=0.
quadratic_eq (a, b, c) =
    if d < 0 then error "discriminant < 0" else (r1, r2)
        where
            r1 = e + (sqrt d) / (2*a)
            r2 = e - (sqrt d) / (2*a)
            d = (b**2) - (4*a*c)
            e = -b / (2*a)

-- 3. Get number of zeroes in a list of numbers.
num_of_zeroes [] = 0
num_of_zeroes (h:t)
    | h == 0 = 1 + (num_of_zeroes t)
    | otherwise = num_of_zeroes t

-- 4. Print N rows of Pascal's triangle.
pascal = iterate (\row -> zipWith (+) ([0] ++ row) (row ++ [0])) [1]
pascal_printer = mapM_ (putStrLn . unwords . map show)
draw_pascal n = pascal_printer $ take n pascal

-- 5. Find unique positive integer N whose square is 1_2_3_4_5_6_7_8_9_0 and
-- each '_' is a single digit.
judge n = s!!0=='1'  && s!!2=='2'  && s!!4=='3'  &&
          s!!6=='4'  && s!!8=='5'  && s!!10=='6' &&
          s!!12=='7' && s!!14=='8' && s!!16=='9' &&
          s!!18=='0'
    where s = show n
euler206 = find (\n->judge$n^2) [1010101010,1010101020..1389026623]
-- Helper functions:
qsort [] = []
qsort (x:xs) = qsort [y | y <- xs, y <= x]  ++ [x] ++ qsort [y | y <- xs, y > x]

-- EOF.

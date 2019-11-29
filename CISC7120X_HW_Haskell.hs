-- Humam Rashid
-- CISC 7120X, Fall 2019.
-- Haskell Homework.

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

-- EOF.

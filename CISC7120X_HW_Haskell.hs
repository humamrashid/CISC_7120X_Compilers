-- Humam Rashid
-- CISC 7120X, Fall 2019.
-- Haskell Homework.

import Data.List
import Data.Ord
--import Data.Time.Calendar

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

-- 6. Get number of days between two dates given in some format; assuming format
-- is: (MM, DD, YYYY), i.e., a date is a tuple of three positive integers each
-- representing the month, day and year, respectively, in the Gregorian
-- calendar.
--days :: Day -> Day  -> Integer
--days day1 day2 = diffDays day1 day2

-- 7. Remove consecutive duplicates of elements from given list.
remove_consecutive_dups (x:ys@(y:_))
    | x == y = remove_consecutive_dups ys
    | otherwise = x : remove_consecutive_dups ys
remove_consecutive_dups ys = ys

-- 8. Remove all duplicate elements; uses quicksort (implemented) to sort the
-- list then remove consecutive duplicates.
qsort [] = []
qsort (x:xs) = qsort [y | y <- xs, y <= x]  ++ [x] ++ qsort [y | y <- xs, y > x]
remove_dups xs = remove_consecutive_dups (qsort xs)

-- 9. Replicate the elements of a list a given number of times.
-- 'replicate' is a Haskell standard library function, so this version is called
-- 'my_replicate'.
my_replicate (xs, n) = concatMap (take n . repeat) xs

-- 10. Split a given list into 2 parts, the first part having the given n number
-- of elements.
split [] _ = ([], [])
split lst@(x:xs) n
    | n > 0 = (x:ys,zs)
    | otherwise = ([],lst)
    where (ys,zs) = split xs (n-1)

-- 11. Get the min, max, median of a given list of numbers.
my_sum [] = 0
my_sum (h:t) = h + (my_sum t)
my_len [] = 0
my_len (h:t) = 1 + (my_len t)
my_avg [] = error "empty list"
my_avg xs = my_sum xs / (my_len xs)
min_max_median [] = error "empty list"
min_max_median [x] = (x, x, x)
min_max_median xs = (head ss, last ss, my_avg ss)
    where ss = qsort xs

-- 12. Get the binomial coefficient.
bc n k = product [k+1..n] `div` product [1..n-k]

-- 13. Get all n-element subsets of a given set.
powerset [] = [[]]
powerset (h:t) = acc ++ (map (h:) acc) where acc = powerset t
subsets xs n = [ys | ys <- powerset xs, length ys == n]

-- 14. Get contiguous sublist which has largest sum.
sublists [] = []
sublists xs = tail $ inits xs ++ sublists (tail xs)
max_sublist = last . sortBy (comparing sum) . sublists

-- EOF.

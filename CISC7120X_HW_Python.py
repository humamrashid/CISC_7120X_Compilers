#!/usr/bin/python3

# Humam Rashid
# CISC 7120X, Fall 2019.

import math

# 1. Get volume of a sphere given radius r.
def sphere(r):
    return (4/3) * math.pi * (r**3)

# 2. Get real roots of quadratic equation of the form ax^2+bx+c=0.
def quadratic_equation(a,b,c):
    d = math.sqrt(b*b - 4*a*c)
    if d < 0:
        raise ValueError('Negative Discriminant!')
    r1 = (-b+d) / (2*a)
    r2 = (-b-d) / (2*a)
    return (r1, r2)

# 3. Get number of zeroes in a list of numbers.
def number_of_zeroes(lst):
    return sum([1 for e in lst if e == 0])

# 4. Print first n rows of Pascal's triangle.
def next_row(row):
    row1 = [1]
    for i in range(len(row)-1):
        row1.append(row[i]+row[i+1])
    row1.append(1)
    return row1

def draw_pascal(n):
    row = [1]
    rows = [row]
    for i in range(n-1):
        row = next_row(row)
        rows.append(row)
    return rows

print(sphere(5))
print(quadratic_equation(2,5,2))
print(number_of_zeroes([0,1,2,4,0,4,0,25,0]))
print(draw_pascal(5))

# EOF.

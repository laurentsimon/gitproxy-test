#!/usr/bin/env python3
"""A simple mathematical utility script to solve quadratic equations.

This script calculates the real roots of a quadratic equation of the form
ax^2 + bx + c = 0.
"""

import math
import sys


def solve_quadratic(a, b, c):
    """Solves the quadratic equation ax^2 + bx + c = 0 and returns real roots."""
    # Calculate the discriminant: b^2 - 4ac
    discriminant = b**2 - 4 * a * c

    if discriminant < 0:
        # No real roots
        return []
    elif discriminant == 0:
        # One double root
        x = -b / (2 * a)
        return [x]
    else:
        # Two distinct real roots
        x1 = (-b + math.sqrt(discriminant)) / (2 * a)
        x2 = (-b - math.sqrt(discriminant)) / (2 * a)
        return [x1, x2]


def main():
    print("=========================================")
    print("       QUADRATIC EQUATION SOLVER         ")
    print("       Solves: ax^2 + bx + c = 0         ")
    print("=========================================")

    try:
        a = float(input("Enter coefficient a: "))
        b = float(input("Enter coefficient b: "))
        c = float(input("Enter coefficient c: "))
    except ValueError:
        print("Error: Please enter valid numeric coefficients.")
        sys.exit(1)

    if a == 0:
        print("Error: Coefficient 'a' cannot be 0 in a quadratic equation.")
        sys.exit(1)

    roots = solve_quadratic(a, b, c)

    print("\n-----------------------------------------")
    if not roots:
        print("Result: No real roots exist.")
    elif len(roots) == 1:
        print(f"Result: Single root found x = {roots[0]:.4f}")
    else:
        print(f"Result: Two real roots found:")
        print(f"  x1 = {roots[0]:.4f}")
        print(f"  x2 = {roots[1]:.4f}")
    print("=========================================")


if __name__ == "__main__":
    main()


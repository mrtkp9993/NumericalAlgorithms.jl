using LinearAlgebra

"""
    FindRoot1D(f::Function, p0::Float64, p1::Float64, NMAX::UInt64, tol::Float64)

Compute one-dimensional root of a function with secant method. Secant method is defined
by the difference equation:

```math
x_{n}=x_{n-1}-f(x_{n-1}){\\frac {x_{n-1}-x_{n-2)){f(x_{n-1})-f(x_{n-2})))={\\frac {x_{n-2}f(x_{n-1})-x_{n-1}f(x_{n-2})}{f(x_{n-1})-f(x_{n-2})))
```
"""
function FindRoot1D(f::Function, p0::Float64, p1::Float64, NMAX::UInt64, tol::Float64)
    i = 1
    while i <= NMAX
        p2 = p0 - f(p0) * ((p1 - p0) / (f(p1) - f(p0)))
        if abs(p2 - p1) < tol
            println("Root found after $i iterations, root: $p2")
            return p2
        end
        i += 1
        p0 = p1
        p1 = p2
    end
    println("Method failed after $i iterations.")
    return NaN
end

"""
    FindRootND(f::Function, jb::Function, p0::Array{Float64,1}, NMAX::UInt64, tol::Float64)

    Compute n-dimensional root of a system of equations with Broyden's method.
"""
function FindRootND(f::Function, jb::Function, p0::Array{Float64,1}, NMAX::UInt64, tol::Float64)
    i = 1
    while i <= NMAX
        J = jb(p0)
        fo = f(p0)
        dx = -J \ fo
        p0 = p0 + dx
        fn = f(p0)
        df = fn - fo
        J = J + (df - J * dx) * dx' / (dx' * dx)
        if norm(fn) < tol
            println("Root found after $i iterations, root: $p0")
            return p0
        end
        i += 1
    end
    println("Method failed after $i iterations.")
    return NaN
end

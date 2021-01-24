using LinearAlgebra

function FindRoot1D(f::Function, p0::Float64, p1::Float64, N0::Int64, tol::Float64)
    i = 1
    while i <= N0
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

function FindRootND(f::Function, jb::Function, p0::Array{Float64,1}, N0::Int64, tol::Float64)
    i = 1
    while i <= N0
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

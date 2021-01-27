"""
    CalcSingleIntegral(f::Function, a::Real, b::Real, n::UInt64)

Compute integral of f function from a to b (Composite Simpson method).
"""
function CalcSingleIntegral(f::Function, a::Real, b::Real, n::UInt64)
    xi = 0.0
    h = (b - a) / n
    xi0 = f(a) + f(b)
    xi1 = 0.0
    xi2 = 0.0
    for i = 1:(n - 1)
        x = a + i * h;
        if mod(i, 2) == 0
            xi2 = xi2 + f(x)
        else
            xi1 = xi1 + f(x)
        end
    end
    xi = h * (xi0 + 2 * xi2 + 4 * xi1) / 3;
    println("Approximation to integral: $xi")
    return xi
end

"""
    CalcDoubleIntegral(f::Function, a::Real, b::Real, c::Real, d::Real, NMAX::UInt64)

Compute double integral of f function over domain D=[a, b] x [c, d]
(Double Simpson's method).
"""
function CalcDoubleIntegral(f::Function, a::Real, b::Real, c::Real, d::Real, NMAX::UInt64)
    
end
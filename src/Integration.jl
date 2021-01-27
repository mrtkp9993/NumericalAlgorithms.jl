"""
    CalcSingleIntegral(f::Function, a::Real, b::Real, NMAX::UInt64)

Compute integral of f function from a to b.
"""
function CalcSingleIntegral(f::Function, a::Real, b::Real, NMAX::UInt64)
    xi = 0.0
    h = (b - a) / NMAX
    xi0 = f(a) + f(b)
    xi1 = 0.0
    xi2 = 0.0
    for i = 1:NMAX
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

using NumericalAlgorithms
using Test

@testset "Root finding" begin
    f1(x::Float64)::Float64 = x * x - x - 1
    p0 = 1.5
    p1 = 2.0
    tol = 1e-5
    N0 = 100
    res = NumericalAlgorithms.FindRoot1D(f1, p0, p1, N0, tol)
    @test round(res, digits=5) == 1.61803

    g1(x) = 3x[1] - cos(x[2] * x[3]) - 1 / 2
    g2(x) = x[1]^2 - 81(x[2] + 0.1)^2 + sin(x[3]) + 1.06
    g3(x) = exp(-x[1] * x[2]) + 20x[3] + (10pi - 3) / 3
    s1(x) = [g1(x), g2(x), g3(x)]

    g1x1(x) = 3
    g1x2(x) = x[3] * sin(x[2] * x[3])
    g1x3(x) = x[2] * sin(x[2] * x[3])
    g2x1(x) = 2x[1]
    g2x2(x) = -162(x[2] + 0.1)
    g2x3(x) = cos(x[3])
    g3x1(x) = -x[2] * exp(-x[1] * x[2])
    g3x2(x) = -x[1] * exp(-x[1] * x[2])
    g3x3(x) = 20
    grads1(x) = [
        g1x1(x) g1x2(x) g1x3(x);
        g2x1(x) g2x2(x) g2x3(x);
        g3x1(x) g3x2(x) g3x3(x)
                 ]

    p0 = [0.1, 0.1, -0.1]
    tol = 1e-5
    N0 = 100
    res = NumericalAlgorithms.FindRootND(s1, grads1, p0, N0, tol)
    @test round(res[1], digits=5) == 0.5 && 
          round(res[2], digits=5) == 0.0 &&
          round(res[3], digits=5) == -0.5236
end;

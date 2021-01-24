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
end;

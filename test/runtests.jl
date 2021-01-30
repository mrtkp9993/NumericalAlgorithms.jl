using NumericalAlgorithms
using Statistics
using Test

@testset "Root finding" begin
    f1(x::Float64)::Float64 = x * x - x - 1
    p0 = 1.5
    p1 = 2.0
    tol = 1e-5
    NMAX::UInt64 = 100
    res = FindRoot1D(f1, p0, p1, NMAX, tol)
    @test res ≈ 1.61803 atol = 1e-5

    f2(x::Float64)::Float64 = sqrt(x + 2) / x
    p0 = -0.5
    p1 = 2.0
    tol = 1e-5
    # NMAX::UInt64 = 100
    res = FindRoot1D(f2, p0, p1, NMAX, tol)
    @test isnan(res)

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
    # NMAX::UInt64 = 100
    res = FindRootND(s1, grads1, p0, NMAX, tol)
    @test res[1] ≈ 0.5 atol = 1e-5
    @test res[2] ≈ 0.0 atol = 1e-5
    @test res[3] ≈ -0.5236 atol = 1e-5
end;

@testset "Differentiation" begin
    x1::Dual = Dual(4, 1)
    y1::Dual = x1 * Dual(3) + Dual(2)
    @test y1.d == 3

    x2::Dual = Dual(10, 1)
    y2::Dual = Dual(5) * x2^2.0 + x2 * Dual(4) + Dual(1)
    @test y2.d == 104

    x3::Dual = Dual(1, 1)
    y3::Dual = Dual(0.5)
    z3::Dual = Dual(2.0)
    f::Dual = z3 * (x3 + y3)^2.0
    @test f.d == 6

    x4::Dual = Dual(1.0, [1,0,0])
    y4::Dual = Dual(0.5, [0,1,0])
    z4::Dual = Dual(2.0, [0,0,1])
    f2::Dual = z4 * (x4 + y4)^2.0
    @test f2.d[1] == 6.0 
    @test f2.d[2] == 6.0
    @test f2.d[3] == 2.25

    x5::Dual = Dual(5, 1)
    f3::Dual = Dual(1) - (Dual(1) / x5) + exp(sqrt(x5))
    @test f3.d ≈ 2.13217 atol = 1e-5

    x6::Dual = Dual(2, 1)
    f4::Dual = log(x6) - sin(x6) * tan(x6) + cos(x6)
    @test f4.d ≈ -6.56924 atol = 1e-5

    x7::Dual = Dual(0, 1)
    f5::Dual = asin(x7) - acos(x7) * atan(x7)
    @test f5.d ≈ -0.57080 atol = 1e-5
end

@testset "Integration" begin
    a = 0.0
    b = C_PI
    n::UInt64 = 10
    f1(x::Float64)::Float64 = x^2 + cos(x)
    res = CalcSingleIntegral(f1, a, b, n)
    @test res ≈ 10.335 atol = 1e-3

    m1::UInt64 = 10
    n1::UInt64 = 10
    a1 = 0
    b1 = 1
    c1(x) = x
    d1(x) = 2 * x
    f2(x, y) = y^2 + x^3
    res = CalcDoubleIntegral(f2, a1, b1, c1, d1, m1, n1)
    @test res ≈ 0.783346 atol = 1e-6
end

@testset "Random" begin
    p = 3
    q = 7
    m = 10
    s = [6,4,2,1,8,9,3]
    rng1 = LFG(p, q, m, s, +)
    @test rand(rng1, 25) == [5, 6, 4, 3, 6, 1, 7, 1, 4, 0, 1, 8, 9, 3, 3, 4, 2, 1, 4, 7, 1, 3, 4, 8, 5]

    p = 3
    q = 7
    m = 256
    s = [8,6,7,5,3,0,9]
    rng2 = LFG(p, q, m, s, +)
    @test rand(rng2) == 16
end

@testset "Runs test for randomness" begin
    rng1 = LFG()
    rndnums_rng1 = rand(rng1, 20000)
    z1 = RunsTest(rndnums_rng1)
    z1 = round(z1, digits=2)
    @test -2.58 < z1 < 2.58

    rng2 = RANMAR()
    rndnums_rng2 = [rand(rng2) for i = 1:20000]
    z2 = RunsTest(rndnums_rng2)
    z2 = round(z2, digits=2)
    @test -2.58 < z1 < 2.58    
end
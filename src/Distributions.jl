include("Random.jl")

abstract type AbstractDistribution end

mutable struct UniformDistribution <: AbstractDistribution
    "lower support"
    a
    "upper support"
    b
    "rng"
    rng
end

UniformDistribution() = UniformDistribution(0, 1, LFG(9739, 23209, 2^32 - 1))
UniformDistribution(a, b) = UniformDistribution(a, b, LFG(9739, 23209, 2^32 - 1))

function punif(unifd::UniformDistribution, x)
    a = unifd.a
    b = unifd.b
    return a <= x <= b ? 1 / (b-a) : 0
end

function runif(unifd::UniformDistribution)
    return unifd.a + ((unifd.b - unifd.a) / unifd.rng.m) * rand(unifd.rng)
end

function runif(unifd::UniformDistribution, n)
    rndNums = [rand(unifd.rng) for i = 1:n]
    rndNums = unifd.a .+ ((unifd.b - unifd.a) / (maximum(rndNums) - minimum(rndNums))) .* (rndNums .- minimum(rndNums))
    return rndNums
end

abstract type RNG end

mutable struct LFG <: RNG # Lagged Fibonacci generator
    p
    q
    m
    s
end

LFG() = LFG(24, 55, 2^32, [rand(Int) % 2^32 for i = 1:55])
LFG(p, q, m) = LPG(p, q, m, [rand(Int) % m for i = 1:q])

function Base.rand(rng::LFG)
    i = length(rng.s)
    new = (rng.s[rng.p] + rng.s[rng.q]) % rng.m
    popfirst!(rng.s)
    push!(rng.s, new)
    new
end

function Base.rand(rng::LFG, n::Int)
    rnd = []
    for j = 1:n
        new = (rng.s[rng.p] + rng.s[rng.q]) % rng.m
        popfirst!(rng.s)
        push!(rng.s, new)
        push!(rnd, new)
    end
    rnd
end

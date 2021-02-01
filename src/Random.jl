include("Misc.jl")

abstract type RNG end

"Struct for Lagged Fibonacci Generator"
mutable struct LFG <: RNG 
    "first lag"
    p
    "second lag"
    q
    "modulo"
    m
    "state of RNG"
    s
    "Operation (+,-,*)"
    op
end

"Constructor for LFG with default parameter values"
LFG() = LFG(24, 55, 2^32, [rand(UInt) % 2^32 for i = 1:55], +)
"Constructor for LFG with user supplied values, p, q, m"
LFG(p, q, m) = LPG(p, q, m, [rand(UInt) % m for i = 1:q], +)


function Base.rand(rng::LFG)
    new = rng.op(rng.s[rng.p], rng.s[rng.q]) % rng.m
    popfirst!(rng.s)
    push!(rng.s, new)
    new
end

function Base.rand(rng::LFG, n::Int)
    rnd = []
    for j = 1:n
        new = rng.op(rng.s[rng.p], rng.s[rng.q]) % rng.m
        popfirst!(rng.s)
        push!(rng.s, new)
        push!(rnd, new)
    end
    rnd
end

"Struct for RANMAR composite rng"
mutable struct RANMAR <: RNG # RANMAR 
    r::LFG
    t
    s
end

function RANMAR()
    r = LFG(97, 33, 2^24, [rand(UInt) % 2^32 for i = 1:97], -)
    t = [rand(UInt) % 2^24]
    for i = 2:97
        push!(t, ranseq(t[i - 1]))
    end
    s = []
    for i = 1:97
        push!(s, (r.s[i] - t[i]) % 2^24)
    end
    t = t[97]
    RANMAR(r, t, s)
end
    
function Base.rand(rng::RANMAR)
    rnew = rand(rng.r)
    tnew = ranseq(rng.t)
    rng.t = tnew
    snew = (rnew - tnew) % 2^24
    push!(rng.s, snew)
    snew
end

"van der Corput sequence, simplest one-dimensional low-discrepancy sequence over the unit interval."
function vanderCorputSeq(i, b)
    bi = 0
    j = 0
    while i != 0
        bi += mod(i, b) / (b^(j + 1))
        i = floor(i / b)
        j += 1
    end
    bi
end

"Halton sequence"
function haltonSeq(i, m)
    hseq = [vanderCorputSeq(i, primes_1000[j]) for j = 1:m]
    hseq
end

"Faure sequence"
function faureSeq(nb, m, b)
    bn = zeros(nb, 2)
    for l = 1:nb
        a = decompose(l, b)
        sm = size(a, 1)

        matTrans = zeros(sm, sm)
        for i = 1:sm
            for j = 1:sm
                matTrans[j,i] = binomial(i - 1, j - 1)
            end
        end

        a = (matTrans^(m - 1) * a) .% b
        aplus1 = (matTrans * a) .% b

        for f = 1:sm
            bn[l,1] = bn[l,1] + a[f,1] / b^(f)
            bn[l,2] = bn[l,2] + aplus1[f,1] / b^(f)
        end
    end
    bn
end
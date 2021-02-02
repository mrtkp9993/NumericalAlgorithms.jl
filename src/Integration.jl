"""
    CalcSingleIntegral(f::Function, a::Real, b::Real, n::UInt64)

Compute integral of f function from a to b (Composite Simpson method).

    b          
    ⌠          
    ⌡ f(x) ⋅ dx
    a          
      
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
    CalcDoubleIntegral(f::Function, a::Real, b::Real, c::Real, d::Real, n::UInt64)

Compute double integral of f(x,y) function over domain D=[a, b] x [c(a), d(b)]
(Double Simpson's method).

    b                        
    .- d(x)                  
    |    .-                  
    |    |                   
    |   -'  f(x, y) . dy . dx
    -'  c(x)                  
    a                        
                 
"""
function CalcDoubleIntegral(f::Function, a::Real, b::Real, c::Function, d::Function, m::UInt64, n::UInt64)
    @assert rem(m, 2) == 0
    @assert rem(n, 2) == 0
    hx = (b - a) / m
    t = 0.0
    for i = 0:m
        x = a + (i * hx)
        cx = c(x)
        dx = d(x)
        hy = (dx - cx) / n;
        s = 0.0
        for j = 0:n
            y = cx + (j * hy)
            fxy = f(x, y)
            w = 4.0
            if rem(j, 2) == 0
                w = 2.0
            end
            if (j == 0) | (j == n)
                w = 1.0
            end
            s = s + (w * fxy);
        end
        s = s * hy / 3.0
        w = 4.0
        if rem(i, 2) == 0
            w = 2.0
        end
        if (i == 0) | (i == m)
            w = 1.0
        end
        t = t + (w * s)
    end
    t = t * hx / 3.0
    println("Approximation to integral: $t")
    return t
end

function CalcMonteCarloIntegral(f::Function, an, bn, n::UInt64)
    @assert length(an) == length(bn)
    rndNums = zeros(n, length(an))
    mult = 1
    for i = 1:length(an)
        ani = an[i]
        bni = bn[i]
        rndNums[:, i] = uniformSeq(ani, bni, n)
        mult *= bni - ani
    end
    mult /= n
    intt = 0
    for j = 1:n
        intt += f(rndNums[j,:]...)
    end
    mult * intt
end
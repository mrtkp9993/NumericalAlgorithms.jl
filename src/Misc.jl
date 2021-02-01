"t_i sequence for RANMAR"
function ranseq(t) 
    if t - 7654321 >= 0
        t = t - 7654321
    else
        t = t - 7654321 + 2^24 - 3
    end
    return t
end

function decompose(n, b)
    rep = []
    temp = 1
    while n != 0
        push!(rep, n % b)
        n = floor(n / b)
        temp += 1
    end
    rep
end

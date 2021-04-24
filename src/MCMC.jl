include("Random.jl")

function MCMC(f::Function, count::UInt64, burnInPer::UInt64)
    x = zeros(count + burnInPer)
    x[1] = 1.0

    for i = 2:(count + burnInPer)
        currx = x[i - 1]
        # TODO: Replace randn and rand with my own implementation
        propx = currx + randn(1)[1]
        a = f(propx) / f(currx)
        if (rand() < a)
            x[i] = propx
        else
            x[i] = currx
        end
    end

    return x[(burnInPer+1):end]
end

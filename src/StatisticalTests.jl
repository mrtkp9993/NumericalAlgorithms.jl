using Statistics

function RunsTest(rndNums)
    medv = median(rndNums)
    nrun = 0
    npos = 0
    nneg = 0
    for i = 1:length(rndNums)
        if rndNums[i] >= medv
            npos += 1
        else
            nneg += 1
        end
    end
    for i = 2:length(rndNums)
        if ((rndNums[i] >= medv) & (rndNums[i - 1] < medv)) | ((rndNums[i] < medv) & (rndNums[i - 1] >= medv))
            nrun += 1
        end
    end
    mu = (2 * npos * nneg) / (length(rndNums)) + 1
    sigmasqr = ((mu - 1) * (mu - 2)) / (length(rndNums) - 1)
    zscore = (nrun - mu) / sigmasqr
    return zscore
end
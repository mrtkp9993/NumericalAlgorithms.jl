using Statistics

"""
    RunsTest(rndNums)

The Wald–Wolfowitz runs test (or simply runs test), named after statisticians Abraham Wald and Jacob Wolfowitz is 
a non-parametric statistical test that checks a randomness hypothesis for a two-valued data sequence. More precisely, 
it can be used to test the hypothesis that the elements of the sequence are mutually independent.

Runs tests can be used to test:
1.the randomness of a distribution, by taking the data in the given order and marking with + the data greater than the median, 
and with – the data less than the median (numbers equalling the median are omitted.)
2. whether a function fits well to a data set, by marking the data exceeding the function value with + and the other data with −. 
For this use, the runs test, which takes into account the signs but not the distances, is complementary to the chi square test, 
which takes into account the distances but not the signs.

Source: Wikipedia.
"""
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
__precompile__(true)
"""
Numerical Algorithms in Julia

Copyright 2021 Murat Koptur.

Licensed under GPL License, see LICENSE.md

"""
module NumericalAlgorithms

include("Differentiation.jl")
include("Integration.jl")
include("RootFinding.jl")

export FindRoot1D, FindRootND, Dual, CalcSingleIntegral

end # module

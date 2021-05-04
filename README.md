**DEPRECATED: I'm giving up with Julia and I'll implement similar algorithms in another language. If you want to develop further, please fork this repository.**

Why I gave up with Julia:

1. Lack of OOP
2. Lack of static type checking: most errors were encountered in runtime
3. Unreadable library source codes (due to lack of OOP and type system) 
4. ...

---

# NumericalAlgorithms.jl

[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)
![CI](https://github.com/mrtkp9993/NumericalAlgorithms.jl/workflows/CI/badge.svg)
[![codecov](https://codecov.io/gh/mrtkp9993/NumericalAlgorithms.jl/branch/main/graph/badge.svg?token=7MBMLCFILV)](https://codecov.io/gh/mrtkp9993/NumericalAlgorithms.jl)
[![GitHub license](https://img.shields.io/github/license/mrtkp9993/NumericalAlgorithms.jl)](https://github.com/mrtkp9993/NumericalAlgorithms.jl/blob/main/LICENSE)

Numerical algorithms implemented in Julia.

## Installation

Install the package with ```add https://github.com/mrtkp9993/NumericalAlgorithms.jl``` in package mode (```]```).

## Algorithms

Currently implemented:

* Root finding algorithms
  * Secant method
  * Broyden's method
* Differentation
  * Automatic differentiation via dual numbers
* Integration
  * Composite Simpson - One dim.
  * Double Simpson - Two dim.
  * Monte Carlo Integration - Arbitrary dimension
* Random Number Generators (RNGs)
  * Pseudo-random numbers
    * Lagged Fibonacci generator
    * RANMAR
  * Quasi-random numbers
    * van der Corput sequences
    * Halton sequences
    * Faure sequences
    * Sobol sequences
* Markov Chain Monte Carlo (MCMC) for sampling
* Statistical Tests
  * Wald–Wolfowitz runs test

## License

Distributed under the GPL License. See ```LICENSE``` for more information.

## Contact

Murat Koptur, [LinkedIn](https://www.linkedin.com/in/muratkoptur/)

Email: [muratkoptur@yandex.com](mailto:muratkoptur@yandex.com?subject=NumericalAlgorithms.jl)

## References

* Press, William H., Teukolsky, S. A., Vetterling, W. T., & Flannery, B. P. (2007). Numerical Recipes 3rd Edition: The Art of Scientific Computing (3rd ed.). Cambridge, England: Cambridge University Press.
* Kochenderfer, M. J., & Wheeler, T. A. (2019). Algorithms for Optimization (The MIT Press) (Illustrated ed.). The MIT Press.
* Burden, R. L., & Faires, D. J. (2010). Numerical Analysis (9th ed.). Cengage Learning.
* Zwillinger, D. (2018). CRC Standard Mathematical Tables and Formulas, 33rd Edition. Amsterdam University Press.
* Stoop, R., Hardy, A., Hardy, Y., & Steeb, W. (2004). Problems and Solutions in Scientific Computing with C++ and Java Simulations. World Scientific Publishing Company.
* Weinzierl, S. (2000, June 23). Introduction to Monte Carlo methods. ArXiv.Org. https://arxiv.org/abs/hep-ph/0006269.
* Lists of small primes. (2020). The PrimePages: Prime Number Research & Records. https://primes.utm.edu/lists/small/.

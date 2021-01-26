struct Dual
    r # Real part
    d # Dual part
end

Dual(r) = Dual(r, 0)

Base.:+(a::Dual, b::Dual) = Dual(a.r + b.r, a.d + b.d)
Base.:-(a::Dual, b::Dual) = Dual(a.r - b.r, a.d - b.d)
Base.:*(a::Dual, b::Dual) = Dual(a.r * b.r, a.d * b.r + a.r * b.d)
Base.:/(a::Dual, b::Dual) = Dual(a.r / b.r, (a.d * b.r - a.r * b.d) / (b.r * b.r))
Base.:^(a::Dual, p::Float64) = Dual(a.r^p, p * a.d * a.r^(p - 1))
Base.sqrt(a::Dual) = Dual(sqrt(a.r), a.d / (2 * sqrt(a.r)))
Base.exp(a::Dual) = Dual(exp(a.r), a.d * exp(a.r))
Base.log(a::Dual) = Dual(log(a.r), a.d / a.r)
Base.sin(a::Dual) = Dual(sin(a.r), a.d * cos(a.r))
Base.cos(a::Dual) = Dual(cos(a.r), -a.d * sin(a.r))
Base.tan(a::Dual) = Dual(tan(a.r), a.d / (cos(a.r)^2))
Base.asin(a::Dual) = Dual(asin(a.r), a.d / sqrt(1 - a.r^2))
Base.acos(a::Dual) = Dual(acos(a.r), -a.d / sqrt(1 - a.r^2))
Base.atan(a::Dual) = Dual(atan(a.r), a.d / (1 + a.r^2))
Base.sinh(a::Dual) = Dual(sinh(a.r), a.d * cosh(a.r))
Base.cosh(a::Dual) = Dual(cosh(a.r), a.d * sinh(a.r))
Base.tanh(a::Dual) = Dual(tanh(a.r), a.d / (cosh(a.r)^2))

Base.show(io::IO,x::Dual) = print(io, "$(x.r) + ϵ $(x.d)")

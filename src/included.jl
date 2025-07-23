function hello(s::AbstractString)
    hello1(Object(s))
end

function hello1(x::Object)
    "Hello, " * x.who
end

# undefined variable (global) and unused variable
function hello2(x::Object)
    "Hello, " * y.who
end

# undefined variable (local)
function hello3(x::Object)
    if isempty(x.who)
        # return nothing
    else
        y = x
    end
    "Hello, " * y.who
end

# method error (`::String + ::String` is not defined)
function hello4(x::Object)
    "Hello, " + x.who
end

domath(x::Float64) = domath(x, :dict)

function domath(x::Float64, ret::Symbol)
    # TODO Input validation

    x½, x², x³ = sqrt(abs(x)), x^2, x^3
    # FIXME # γ == 1 + 0.5x - 0.25x²
    # γ = @evalpoly             # 1 + 0.5x - 0.25x²
    γ = 0.0

    if isinf(x)
        # TODO
    elseif x ≥ 0
        δ = log(x + 1)
    else
        δ = -log(-x + 1)
    end

    if ret === :dict
        res = Dict{String, Float64}()

        res["x½"] = x½
        res["x²"] = x²
        res["x³"] = x³

        res["γ"] = γ
        res["δ"] = δ

        return res

    elseif ret === :vec
        return SVector(x½, x², x³, γ, δ)

    elseif ret === :x½
        return x½

    elseif ret === :x²
        return x²

    elseif ret === :x³
        return x³

    elseif ret === :γ
        return γ

    elseif ret === :δ
        return δ
    end

    error("Unknown return value specified: $ret")
end

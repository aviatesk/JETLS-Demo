function _hello(x::Object)
    "Hello, " * x.who
end

# undefined variable (global) and unused variable
function _hello2(x::Object)
    "Hello, " * y.who
end

# undefined variable (local)
function _hello3(x::Object)
    local y::Object
    if isempty(x.who)
        # return nothing
    else
        y = x
    end
    "Hello, " * y.who
end

# method error (`::String + ::String` is not defined)
function _hello4(x::Object)
    "Hello, " + x.who
end

function domath(x::Float64, ret::Symbol)
    # # Input validation - FIXME
    # if isnan(x) || isinf(x)
    #     return (; error="Invalid input", value=x)
    # end

    α, β = sin(x), cos(x)
    x½, x², x³ = sqrt(abs(x)), x^2, x^3
    γ = @evalpoly x 1.0 0.5  # 1 + 0.5x - 0.25x² # FIXME
    if isinf(x)
        # TODO
    elseif x ≥ 0
        δ = log(x + 1)
    else
        δ = -log(-x + 1)
    end

    if ret === :dict
        res = Dict{String, Float64}()

        # res["α"] = α
        # res["β"] = β
        res["x½"] = x½
        res["x²"] = x²
        res["x³"] = x³

        res["γ"] = γ
        res["δ"] = δ

    elseif ret === :vec
        res = SVector(x½, x², x³, γ, δ)

    # elseif ret === :α
    #     return α

    # elseif ret === :β
    #     return β

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

    else
        error("Unknown return value specified: $ret")
    end

    return res
end

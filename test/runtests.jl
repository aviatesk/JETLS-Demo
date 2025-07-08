using Test, DemoPkg

@testset "hello" begin
    @test hello("Julia") == "Hello, Julia"
    @test hello("world") == "Hello, world"
end

funcsin(x) = sin(x[])
# @inferred funcsin(Ref{Any}(42))

@testset "domath" begin
    res = domath(2.0, :dict)
    @test res isa Dict{String, Float64}
    @test res["α"] ≈ sin(2.0)
    @test res["β"] ≈ cos(2.0)
    @test res["x²"] == 4.0
    @test res["x³"] == 8.0
    @test res["γ"] == 1.0

    @test domath(2.0, :x²) == 4.0

    @testset "Edge case" begin
        @test domath(-1.0, :x½) == 1.0  # sqrt(abs(-1))
        @test domath(-1.0, :δ) ≈ -log(2.0)  # -log(-(-1) + 1)
    end

    @testset "Error case" begin
        let res_nan = domath(NaN, :dict)
            @test res_nan isa NamedTuple{(:error, :value), Tuple{String, Float64}}
            @test res_nan.error == "Invalid input"
        end
        let res_inf = domath(Inf, :dict)
            @test res_inf isa NamedTuple{(:error, :value), Tuple{String, Float64}}
            @test res_inf.error == "Invalid input"
        end
    end
end

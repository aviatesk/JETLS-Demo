using Test, DemoPkg

@testset "hello" begin
    @test hello("Julia") == "Hello, Julia"
    @test hello("world") == "Hello, world"
end

funcsin(x) = sin(x[])
@inferred funcsin(Ref{Any}(42))

@testset "fib" begin
    fib(n) = n ≤ 2 ? n : fib(n-1) + fib(n-2)
    @test fib(50) > 0 # long running (>20sec)
end

@testset "domath" begin
    res = domath(2.0)
    @test res isa Dict{String, Float64}
    @test res["x½"] == √2.0
    @test res["x²"] == 4.0
    @test res["x³"] == 8.0
    @test res["γ"] == 1.0

    @test domath(2.0, :x²) == 4.0

    @test domath(2.0, :vec)[1] == √2.0

    @testset "Edge case" begin
        @test domath(-1.0, :x½) == 1.0  # sqrt(abs(-1))
        @test domath(-1.0, :δ) ≈ -log(2.0)  # -log(-(-1) + 1)
    end

    @testset "Error case" begin
        @test_throws ArgumentError domath(NaN)
        @test_throws ArgumentError domath(Inf)
    end
end

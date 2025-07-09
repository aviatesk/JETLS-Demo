# Adapted from Julia's trimming test suite:
# https://github.com/JuliaLang/julia/blob/c3282ceaacb3a41dad6da853b7677e404e603c9a/test/trimming/basic_jll.jl

using Libdl
using Zstd_jll
using DemoPkg

# JLL usage at build-time should function as expected
Zstd_jll.__init__()
const build_ver = unsafe_string(ccall((:ZSTD_versionString, libzstd), Cstring, ()))

function print_string(fptr::Ptr{Cvoid})
    println(Core.stdout, unsafe_string(ccall(fptr, Cstring, ())))
end

function safeprintln(s)
    println(s) # FIXME
end

function sayhello(s::AbstractString)
    hello(s)
end

function (@main)(args::Vector{String})
    # Test the basic "Hello, world"
    safeprintln(sayhello("world"))

    # JLL usage at run-time should function as expected
    ver = unsafe_string(ccall((:ZSTD_versionString, libzstd), Cstring, ()))
    safeprintln(ver)
    @assert ver == build_ver

    sleep(0.01)

    # Add an indirection via `@cfunction` / 1-arg ccall
    cfunc = @cfunction(print_string, Cvoid, (Ptr{Cvoid},))
    fptr = dlsym(Zstd_jll.libzstd_handle, :ZSTD_versionString)
    ccall(cfunc, Cvoid, (Ptr{Cvoid},), fptr)

    return 0
end

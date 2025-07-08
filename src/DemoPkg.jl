module DemoPkg

using StaticArrays

export hello, domath

struct Object
    who::String
end

function hello(s::AbstractString)
    _hello(Object(s))
end

function domath end

include("included.jl")

end

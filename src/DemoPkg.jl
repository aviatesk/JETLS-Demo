module DemoPkg

using StaticArrays

export hello, Object, domath

struct Object
    who::String
end

include("included.jl")

end

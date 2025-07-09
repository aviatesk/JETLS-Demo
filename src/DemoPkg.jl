module DemoPkg

using StaticArrays

export hello, domath

struct Object
    who::String
end

function hello end
function domath end

include("included.jl")

end

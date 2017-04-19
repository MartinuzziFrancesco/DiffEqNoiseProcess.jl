module DiffEqNoiseProcess

using DiffEqBase, DataStructures, ResettableStacks, StochasticDiffEq

import DiffEqBase: isinplace

include("types.jl")
include("interface.jl")

export WienerProcess, adaptive_alg

export accept_step!, reject_step!, calculate_step!

end # module
module Simulation

include("worldRule.jl")
include("worldCorrection.jl")
include("worldRead&Write.jl")
using .Rule
using .Correction
using .ReadWrite

    # A function for evolving the world
function worldSimulation(A0::Array, Nt::Int64, neighborMode::String, r::Int64)
    """
    Input:
        | A0    : The Initial world (configuration)
        | Nt    : The number of time-steps
    Output:
        | A 3D array consist of World Array and the time-step
    """
        # World Array of Arrays Initialization
    worldTimeArray = zeros(size(A0)[1], size(A0)[2], Nt)
        # Initial Configuration in the World Array of Arrays
    worldTimeArray[:, :, 1] = A0
    println(1) 
        # Updating
    G  = Rule.worldRule(A0, neighborMode, r)
    Ai = Correction.worldCorrection(A0 + G)
    worldTimeArray[:, :, 2] = Ai
    for i in 3:Nt
        G   = Rule.worldRule(Ai, neighborMode, r)
        Ai  = Correction.worldCorrection(Ai + G)
        worldTimeArray[:, :, i] = Ai
    end
    println(2)
    println("Do you want to save The Last Configuration?")
    print("(y/n)> ")
    ans = readline()
    if ans == "y" # Saving the last frame
        print("What name do you prefer saving the Last Configuration file:\n> "); name = readline()
        ReadWrite.worldWrite(worldTimeArray[:, :, end], name)
    elseif ans == "n"
        println("Bye!!!")
    end
    return worldTimeArray
end

end

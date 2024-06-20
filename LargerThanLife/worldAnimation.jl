module Animation

import REPL
using Plots
terminal = REPL.Terminals.TTYTerminal(string(), stdin, stdout, stderr)

include("worldPrint.jl")
using .Print

    # The Terminal Animation
function worldTerminalAnime(worldTimeArray::Array, time::Float64, shape::String, Nt::Int64)
    for t in 1:Nt
        world = worldTimeArray[:, :, t]
        Print.worldPrint(world, time, shape)
    end
end

    # The Heatmap Animation
function worldHeatmapAnime(worldTimeArray::Array, time::Float64, Nt::Int64, name::String)
    """
    Input:
        | worldTimeArray  : The world array of Arrays, World-Time
        | time            : The time between each frame
        | Nt              : The number of time-steps
        | name            : The name of the file saving as 'name.gif'
    Output:
        | A 'name.gif' which is saved inside the current directory 
    """

    # The Animation Saving part
    anim = @animate for t in 1:Nt
        Plots.heatmap(worldTimeArray[end:-1:1, :, t], aspect_ratio=:equal) # For visualization purpose, The row sections should be reversed

    end

    gif(anim, name, fps = 1/time)  # Number of frames per seconds = 1 / the time between each frame

end


end

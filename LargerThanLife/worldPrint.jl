module Print

import REPL
terminal = REPL.Terminals.TTYTerminal(string(), stdin, stdout, stderr)

    # The function for printing the world status
function worldPrint(world::Array, time::Float64, shape = "3.txt")
    """
    Input:
        world: 
            | An array which consist of 1 for full cell and 0 for empty cell
        shape:
            | An argument which is a file consisting of the shapes using for printing them.
    Output:
        
    """
    # Make it an animation
    sleep(time)
    REPL.Terminals.clear(terminal)

    # Printing the number of Alive and Dead Cells 
    aliveCells = floor(Int64, sum(world))
    deadCells  = floor(Int64, size(world)[1] * size(world)[2] - aliveCells)
    print("Alive: $aliveCells \t\tDead: $deadCells\n")
    print("--------------------------------------\n")

    shapeFile = readlines(shape)
    shapes = Dict(0 => "ERROR", 1 => "ERROR")
    for i in shapeFile
        state, char = split(i, " ")
        if parse(Int64, state) in keys(shapes)
            shapes[parse(Int64, state)] = char
        end
    end

    for row in 1:size(world)[1]

        for col in 1:size(world)[2]
            print("$(shapes[world[row, col]]) ")
        end

        print("\n")
    end
end


end

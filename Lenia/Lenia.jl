import REPL
using Plots
terminal = REPL.Terminals.TTYTerminal(string(), stdin, stdout, stderr)

# A 2D world with GoL Rules

    # Initializations
K = [1 1 1 
     1 0 1
     1 1 1] # The weight distribution of the neighbors

A0 = [0 1 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 1 0 
      0 0 1 1 1 0 0 0 0
      0 0 1 1 1 0 0 0 0
      0 0 0 1 0 0 0 0 0
      0 0 1 1 1 0 0 0 0 
      0 0 0 1 0 0 0 0 0
      0 0 0 0 0 0 0 0 0
      1 0 0 0 0 0 0 0 1]# The world!

Nt = 50 # The number of time-steps

    # The function for initializing a world as an Array
worldIni(nx::Int64, ny::Int64) = zeros(Int64, nx, ny)

# A = worldIni(10, 10) # The world! 


    # A funciton for Reading the world from a txt file 
function worldRead(file)
    """
    Input:
        | A file consisting of 0 and 1s like this:
        1 0 0 0
        0 1 1 1
        0 1 0 0
        1 1 0 0
        * Each rows is seperated by space and each columns is seperated by "ENTER" or the next line
        * Not reading the empty lines
    Output:
        | An array consisting of the world
    """
    inp = readlines(file) # Reading the file    
    println(inp)
    rowN = length(inp)    # Number of rows
    colN = length(split(inp[1], " ")) # Number of columns
    world = zeros(Int64, rowN, colN) # World initialization

    for r in 1:length(inp)
        row = split(inp[r], " ")
        for c in 1:length(row)
            world[r, c] = parse(Int64, row[c])
        end
    end
    return world
end

function worldWrite(A::Array, name)
    """
    Input:
        | A world Array
    Output:
        | Save the Array in the format of 0 and 1s. For example:
        1 0 0 0
        0 1 1 1
        0 1 0 0
        1 1 0 0
    """
    file = open(name, "w")

    row, col = size(A)
    for r in 1:row
        for c in 1:col
            write(file, "$(A[r, c])")
            if c != col
                write(file, " ")
            end
        end
        if r != row
            write(file, "\n")
        end
    end

    close(file)
end


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

    # The Terminal Animation
function worldTerminalAnime(worldTimeArray::Array, time::Float64, shape::String, Nt::Int64)
    for t in 1:Nt
        world = worldTimeArray[:, :, t]
        worldPrint(world, time, shape)
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
        Plots.heatmap(worldTimeArray[end:-1:1, :, t]) # For visualization purpose, The row sections should be reversed

    end

    gif(anim, name, fps = 1/time)  # Number of frames per seconds = 1 / the time between each frame

end


    # The Update function
function worldRule(A::Array, K::Array)
    """
    Input:
        | A: is the world Array.
    Output:
        | K: is the weight distribution of the neighbors
    """
    G = zeros(size(A)[1], size(A)[2])

    for i in 1:size(A)[1]
        for j in 1:size(A)[2]
            
            # A neighbor array (3, 3)
            neighbor = zeros(Int64, 3, 3) 
            
            # Neighbor positions in the world's positions relative to the calculated cell
            iLow  = i - 1
            iHigh = i + 1
            jLow  = j - 1
            jHigh = j + 1
            
            neighborRow = 1 # The position of rows in neighbor array
            for worldRow in iLow:iHigh # The row position in world's position
                neighborCol = 1 # The postion of columns in neighbor array
                for worldCol in jLow:jHigh # The Columns postions in world's postion
                    
                    worldRowCopy = copy(worldRow)
                    worldColCopy = copy(worldCol)

                    # The periodic condition        
                    if worldRow < 1
                        worldRowCopy += size(A)[1]
                    end
                    if worldCol < 1
                        worldColCopy += size(A)[2]
                    end
                    if worldRow > size(A)[1]
                        worldRowCopy -= size(A)[1]
                    end
                    if worldCol > size(A)[2]
                        worldColCopy -= size(A)[2]
                    end

                    neighbor[neighborRow, neighborCol] = A[worldRowCopy, worldColCopy]

                    neighborCol += 1
                end
                neighborRow += 1
            end
            
            # The total number of live cells in the neighbors
            S = sum(neighbor .* K)

            Gij = Dict(0 => -1, 1 => -1, 2 => 0, 3 => 1, 4 => -1, 5 => -1, 6 => -1, 7 => -1, 8 => -1) # The Dictionary for G value (Like a discrete function) 
            G[i, j] = Gij[S]
        end
    end
    
    return [floor(Int64, x) for x in G]
end

    # The correction function
function worldCorrection(A::Array)
    """
    Input:
        | The World which consist of numbers other than 0 or 1
    Output:
        | Set the numbers bigger than 1 => 1, and Set the number less than 0 => 0
    * This set up is just for descrete Game of Life cellular Automaton
    """
    for i in 1:size(A)[1]
        for j in 1:size(A)[2]
            if A[i, j] < 0
                A[i, j] = 0
            elseif A[i, j] > 1
                A[i, j] = 1
            end
        end
    end
    return A
end


    # A function for evolving the world
function worldSimulation(A0::Array, K::Array, Nt::Int64)
    """
    Input:
        | A0    : The Initial world (configuration)
        | K     : The Neighbor's distribution
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
    G  = worldRule(A0, K)
    Ai = worldCorrection(A0 + G)
    for i in 2:Nt
        G   = worldRule(Ai, K)
        Ai  = worldCorrection(Ai + G)
        worldTimeArray[:, :, i] = Ai
    end
    println(2)
    println("Do you want to save The Last Configuration?")
    print("(y/n)> ")
    ans = readline()
    if ans == "y" # Saving the last frame
        print("What name do you prefer saving the Last Configuration file:\n> "); name = readline()
        worldWrite(worldTimeArray[:, :, end], name)
    elseif ans == "n"
        println("Bye!!!")
    end
    return worldTimeArray
end


    # User Interface in terminal
function main()
    """
    The Running function (The User-Interface)
    """
    print("Hello and Welcome to my little GoL.jl program.\n")
    print("There are three main ways to make initialize your first world's configuration (By world I mean an array consisting of alive, 1, and dead, 0, cells.)\n")
    print("\t\t1. You change the configuration inside the file which the variable name is 'A' (1)\n")
    print("\t\t2. Initialize a NxM array consisting of zeros and change the numbers manually (2)\n")
    print("\t\t3. You have a file from the before and want to implement it as initial configuration (3)\n\n")
    print("* The number of time-steps and K, are in the source file, change them in the GoL.jl file.\n\n")
    print("Which one do you want to perform?\n(1/2/3)> "); ans = readline()


        # Choosing between Heatmap animation or Termianl Animation

    print("How much time do you prefer between each frames? (Recommendation: 0.1, how lower you set, faster it get!!!)\n> "); speed = parse(Float64, readline())

        # The Options for performing simulation
    if ans == "1"
        world = worldSimulation(A0, K, Nt)
        
        print("Terminal Animation or Heatmap Animation:\n(t/h)> "); anime = readline()
        if anime == "t"
            worldTerminalAnime(world, speed, "2.txt", Nt)
        elseif anime == "h"
            worldHeatmapAnime(world, speed, Nt, "InProgram.gif")
        end

    elseif ans == "2"
        print("The number of rows    : "); rowN = parse(Int64, readline()); print("\n")
        print("The number of columns : "); colN = parse(Int64, readline()); print("\n")
        A = worldIni(rowN, colN)
        print("What name do you prefer?\n> "); file = readline()
        worldWrite(A, file)
        println("!!! Wait a second, Change the created file and then for running it, press on 'ENTER' !!!\n\n")
        
        ans = readline()
        if ans == ""    # If pressing 'ENTER', it proceeds.
            A = worldRead(file)
            world = worldSimulation(A, K, Nt)
            print("Terminal Animation or Heatmap Animation:\n(t/h)> "); anime = readline()
            if anime == "t"
                worldTerminalAnime(world, speed, "2.txt", Nt)
            elseif anime == "h"
                worldHeatmapAnime(world, speed, Nt, "$(file).gif")
            end
        end
    elseif ans == "3"
        print("Which file do you want to perform Game of Life on it?\n> "); name = readline()
        A = worldRead(name)
        world = worldSimulation(A, K, Nt)
        print("Terminal Animation or Heatmap Animation:\n(t/h)> "); anime = readline()
        if anime == "t"
            worldTerminalAnime(world, speed, "2.txt", Nt)
        elseif anime == "h"
            worldHeatmapAnime(world, speed, Nt, "$(name).gif")
        end
    end
end

# worldSimulation(A0, K, Nt)

main()


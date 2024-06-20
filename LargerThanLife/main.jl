include("./worldSimulation.jl")
include("./worldInitialization.jl")
include("./worldAnimation.jl")
include("./worldRead&Write.jl")

    # User Interface in terminal
function main()
    """
    The Running function (The User-Interface)
    """
    print("Hello and Welcome to The Larger than Life program.\n")
    print("There are three main ways to make initialize your first world's configuration (By world I mean an array consisting of alive, 1, and dead, 0, cells.)\n")
    print("\t\t1. You change the configuration inside the file which the variable name is 'A' (1)\n")
    print("\t\t2. Initialize a NxM array consisting of zeros and change the numbers manually (2)\n")
    print("\t\t3. You have a file from the before and want to implement it as initial configuration (3)\n\n")
    
    print("Which one do you want to perform?\n(1/2/3)> "); ans = readline()

        # The Amount of the time-steps
    print("How many time-steps do you want to use?\n> "); Nt = parse(Int64, readline()) 

        # The neighbor modes
    print("Which neighbor mode do you want?")
    print("
    circle: [0 0 0 1 0 0 0     ---> For example for r = 3
             0 1 1 1 1 1 0     ---> m: The main cell
             0 1 1 1 1 1 0
             1 1 1 m 1 1 1
             0 1 1 1 1 1 0
             0 1 1 1 1 1 0
             0 0 0 1 0 0 0]
    square: [0 0 0 0 0 0 0     ---> For example for r = 2
             0 1 1 1 1 1 0     ---> m: The main cell
             0 1 1 1 1 1 0
             0 1 1 m 1 1 0
             0 1 1 1 1 1 0
             0 1 1 1 1 1 0
             0 0 0 0 0 0 0]\n\n(square/circle)> "); neighborMode = readline()

        # The radius or distance
    print("What distance do you want to contain your neighbor list?\n(1 for Game of Life)> "); r = parse(Int64, readline())
        # Choosing between Heatmap animation or Termianl Animation
    print("How much time do you prefer between each frames? (Recommendation: 0.1, how lower you set, faster it get!!!)\n> "); speed = parse(Float64, readline())

        # The Options for performing simulation
    if ans == "1"
        world = Simulation.worldSimulation(Initialization.A0, Nt, neighborMode, r)
        
        print("Terminal Animation or Heatmap Animation:\n(t/h)> "); anime = readline()
        if anime == "t"
            Animation.worldTerminalAnime(world, speed, "2.txt", Nt)
        elseif anime == "h"
            Animation.worldHeatmapAnime(world, speed, Nt, "InProgram.gif")
        end

    elseif ans == "2"
        print("The number of rows    : "); rowN = parse(Int64, readline()); print("\n")
        print("The number of columns : "); colN = parse(Int64, readline()); print("\n")
        A = Initialization.worldIni(rowN, colN)
        print("What name do you prefer?\n> "); file = readline()
        ReadWrite.worldWrite(A, file)
        println("!!! Wait a second, Change the created file and then for running it, press on 'ENTER' !!!\n\n")
        
        ans = readline()
        if ans == ""    # If pressing 'ENTER', it proceeds.
            A = ReadWrite.worldRead(file)
            world = Simulation.worldSimulation(A, Nt, neighborMode, r)
            print("Terminal Animation or Heatmap Animation:\n(t/h)> "); anime = readline()
            if anime == "t"
                Animation.worldTerminalAnime(world, speed, "2.txt", Nt)
            elseif anime == "h"
                Animation.worldHeatmapAnime(world, speed, Nt, "$(file).gif")
            end
        end

    elseif ans == "3"
        print("Which file do you want to perform Game of Life on it?\n> "); name = readline()
        A = ReadWrite.worldRead(name)
        world = Simulation.worldSimulation(A, Nt, neighborMode, r)
        print("Terminal Animation or Heatmap Animation:\n(t/h)> "); anime = readline()
        if anime == "t"
            Animation.worldTerminalAnime(world, speed, "2.txt", Nt)
        elseif anime == "h"
            Animation.worldHeatmapAnime(world, speed, Nt, "$(name).gif")
        end
    end
end


main()

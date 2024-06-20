module Rule

include("worldNeighbor.jl")
using .Neighbors

    # The G function (Growth mapping function)
function worldG(Sum)
    Gij = Dict(0 => -1, 1 => -1, 2 => 0, 3 => 1, 4 => -1, 5 => -1, 6 => -1, 7 => -1, 8 => -1) # The Dictionary for G value (Like a discrete function)
    return Gij[Sum]
end

    # The Update function
function worldRule(A::Array, neighborMode::String, r::Int64)
    """
    Input:
        | A             : is the world Array.
        | neighborMode  : How recognize the neighbors:
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
                                     0 0 0 0 0 0 0]
        | r             : The distance a cell recognizes as its neighbor ()
    Output:
        | G             : The growth mapping function which determine if the cell is dead or alive after applying the rule
    """
    G = zeros(Int64, size(A)[1], size(A)[2])

    for i in 1:size(A)[1]
        for j in 1:size(A)[2]
            
            Kij = Neighbors.worldKellner(A, i, j, neighborMode, r)
            
            # The total number of live cells in the neighbors
            Sij = sum(A .* Kij)

             
            G[i, j] = worldG(Sij)
        end
    end
    
    return G
end


end

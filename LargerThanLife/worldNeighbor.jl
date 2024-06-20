module Neighbors

    # The Kellner funciton
function worldKellner(A::Array, row::Int64, col::Int64, neighborMode::String, r::Int64)
    """
    Input:
        | A: The array of the world
        | row: The row of the main cell
        | col: The column of the main cell
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
        | K: The kellner which is shown the influencing cells in the neighbor of the main cell (which has the same size of the world)
    """
    K = zeros(Int64, size(A)[1], size(A)[2])
    
        # Neighbor positions in the world's positions relative to the calculated cell, or at least the neighbors that are calculated to be in the kellner or not.
    if neighborMode == "square"
        rowLow  = row - r
        rowHigh = row + r
        colLow  = col - r
        colHigh = col + r
            
        for worldRow in rowLow:rowHigh # The row position in world's position
            for worldCol in colLow:colHigh # The Columns postions in world's postion
                
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

                K[worldRowCopy, worldColCopy] = 1

            end
        end
        K[row, col] = 0
    elseif neighborMode == "circle"
        K = 1
    end
    return K
end


end

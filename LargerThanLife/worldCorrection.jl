module Correction

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

end

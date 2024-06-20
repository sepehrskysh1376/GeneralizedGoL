module ReadWrite


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



end

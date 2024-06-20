module Initialization

    # Initialization of Kellner
# K = [1 1 1 1 1
#      1 1 1 1 1 
#      1 1 0 1 1
#      1 1 1 1 1
#      1 1 1 1 1] # The weight distribution of the neighbors (Kernel)


A0 = [0 0 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 0 0 
      0 0 0 0 0 0 0 0 0
      0 0 1 1 1 1 1 0 0
      0 0 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 0 0 
      0 0 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 0 0]# The world!
      

    # The function for initializing a world as an Array
worldIni(nx::Int64, ny::Int64) = zeros(Int64, nx, ny)

# A = worldIni(10, 10) # The world!


end

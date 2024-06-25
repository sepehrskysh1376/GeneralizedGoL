# Larger than Life simulation
- An algorithm based on higher-range neighborhood cellular automata with the exact rules of Game of Life (Extendable neighborhood)
- Defined by Kellie Michele Evans (1996)


## Files and Folders

| Files | Description |
| ----- | ----------- |
| LTL.jl | Whole program in one file |
| main.jl | The user interface program |
| ltl.sh | Installation run |
| install.jl | Installation code |
| 1.txt, 2.txt, 3.txt | text files that contain the Unicode characters for each types of cells (Alive or Dead) which are like this |
    ```
    1 <the Alive character> 
    0 <the Dead character>
    ```
| Files | Description |
| ----- | ----------- |
| 2005.03742.pdf, 1111.1564v2.pdf | which is the Article (From Bert Wang-Chak Chan and Stephan Rafler) that inspire me to implement this unique kind of algorithm for Game of Life simulation. |
| final.txt, glider.txt, input.txt, input2.txt | The input examples which works for both GoL_CV.jl and GoL.IV.jl |
| README.md | The MarkDown file for explaining all these things. |

## How to use it (Install-ish)
- Install Julia and the packages needed by: (For now this part is working just for Ubuntu users)
    ```
    $ bash ./ltl.sh
    ```
- run it like this:
    ```
    $ julia main.jl
    ```
- The program give you some descriptions:
    ```
    Hello and Welcome to The Larger than Life program.
    There are three main ways to make initialize your first world's configuration (By world I mean an array consisting of alive, 1, and dead, 0, cells.)
            1. You change the configuration inside the file which the variable name is 'A' (1)
            2. Initialize a NxM array consisting of zeros and change the numbers manually (2)
            3. You have a file from the before and want to implement it as initial configuration (3)

    Which one do you want to perform?
    (1/2/3)> 
    ```
- If you select the first option, ask you about the time-step:
    ```
    How many time-steps do you want to use?
    > 
    ```
    - Then ask you about the type of Neighbor mode (square or circle) you want to use:
        ```
        Which neighbor mode do you want?
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

        (square/circle)> 
        ```
    - Then ask you about the **Radius** or **Distance**:
        ```
        What distance do you want to contain your neighbor list?
        (1 for Game of Life)> 
        ```
    - Then ask you about the time between each two frames (related to the speed of animation)
        ```
        How much time do you prefer between each frames? (Recommendation: 0.1, how lower you set, faster it get!!!)
        > 
        ```
    - Asking you if you want to save the last frame in a file which you give it its name:
        ```
        Do you want to save The Last Configuration?
        (y/n)> 
        ```
    - And at last, ask you if you want to see the simulation in **Terminal** or as a **Heatmap** plot:
        ```
        Terminal Animation or Heatmap Animation:
        (t/h)> 
        ```
- If you use the second option, ask you about the time-step:
        ```
        How many time-steps do you want to use?
        > 
        ```
    - Then ask you about the type of Neighbor mode (square or circle) you want to use:
        ```
        Which neighbor mode do you want?
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

        (square/circle)> 
        ```
    - Then ask you about the **Radius** or **Distance**:
        ```
        What distance do you want to contain your neighbor list?
        (1 for Game of Life)> 
        ```
    - Then ask you about the time between each two frames (related to the speed of animation)
        ```
        How much time do you prefer between each frames? (Recommendation: 0.1, how lower you set, faster it get!!!)
        > 
        ```
    - Then, it will ask you about the size of the world you want:
        ```
        The number of rows    : 

        The number of columns : 
        ```
    - And get a name file from you:
        ```
        What name do you prefer?
        > 
        ```
    - It will wait to change the file that it creates (which just contain **0** with the number of rows and columns that you set.) and continue the simulation with an *ENTER*:
        ```
        !!! Wait a second, Change the created file and then for running it, press on 'ENTER' !!!
        
        
        
        ```
    - By Pressing *ENTER*, it start the simulation and then ask you about saving the last configuration:
        ```
        Do you want to save The Last Configuration?
        (y/n)> 
        ```
    - And at last, ask you if you want to see the simulation in **Terminal** or as a **Heatmap** plot:
        ```
        Terminal Animation or Heatmap Animation:
        (t/h)> 
        ```
- If you select the third option, ask you about the time-step:
        ```
        How many time-steps do you want to use?
        > 
        ```
    - Then ask you about the type of Neighbor mode (square or circle) you want to use:
        ```
        Which neighbor mode do you want?
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

        (square/circle)> 
        ```
    - Then ask you about the **Radius** or **Distance**:
        ```
        What distance do you want to contain your neighbor list?
        (1 for Game of Life)> 
        ```
    - Then ask you about the time between each two frames (related to the speed of animation)
        ```
        How much time do you prefer between each frames? (Recommendation: 0.1, how lower you set, faster it get!!!)
        > 
        ``` 
    - Ask you about the initial configuration file that you want to give to the program
        ```
        Which file do you want to perform Game of Life on it?
        > 
        ```
    - By Pressing *ENTER*, it start the simulation and then ask you about saving the last configuration:
        ```
        Do you want to save The Last Configuration?
        (y/n)> 
        ```
    - And at last, ask you if you want to see the simulation in **Terminal** or as a **Heatmap** plot:
        ```
        Terminal Animation or Heatmap Animation:
        (t/h)> 
        ```

    

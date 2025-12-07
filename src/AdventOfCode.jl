module AdventOfCode

export getinput, load

inputdirpath = normpath(joinpath(@__FILE__, "..", "..", "inputs"))
getinput(d, fn) = joinpath(inputdirpath, lpad(d, 2, "0"), "$fn.txt")

const DAYMODRE = r"Day\d{2}.jl$"
function load()
    for (root, _, files) in walkdir(@__DIR__)
        for file in files
            filepath = joinpath(root, file)
            occursin(DAYMODRE, filepath) && include(filepath)
        end
    end
end

end

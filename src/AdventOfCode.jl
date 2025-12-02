module AdventOfCode

inputdirpath = normpath(joinpath(@__FILE__, "..", "..", "inputs"))
getinput(d, fn) = joinpath(inputdirpath, lpad(d, 2, "0"), "$fn.txt")
export getinput

const DAYMODRE = r"Day\d{2}.jl$"
for (root, _, files) in walkdir(@__DIR__)
    for file in files
        filepath = joinpath(root, file)
        if occursin(DAYMODRE, filepath)
            include(filepath)
        end
    end
end

end # module

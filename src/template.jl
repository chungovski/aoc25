using ArgParse
using HTTP

#=------------------------------------------------------------------------------
| ArgParse Settings
------------------------------------------------------------------------------=#

settings = ArgParseSettings()

@add_arg_table! settings begin
    "--day", "-d"
    help = "Day to generate template for"
    arg_type = Int
    default = 0
end

parsed_args = parse_args(settings)
day = parsed_args["day"]


#=------------------------------------------------------------------------------
| Generate Templated Puzzle Folder
------------------------------------------------------------------------------=#

dayname = "Day" * lpad(day, 2, "0")
puzzlepath = joinpath(@__DIR__, dayname)

# Don't try to create the template if a puzzle directory already exists
isdir(puzzlepath) && error("$puzzlepath already exists!")
mkpath(puzzlepath)


modpath = joinpath(puzzlepath, dayname * ".jl")

# Write the module file
println("Writing module file...")
open(modpath, create = true, write = true) do f
    contents = """
    module $dayname
    include("../AdventOfCode.jl")
    using .AdventOfCode: getinput

    export run
    function run()
        inpath  = getinput($day, "input")
        input   = ingest(inpath)
        println(input)
        answer1 = part1(input)
        answer2 = part2(input)

        #@assert answer1 == missing "answer1 was $answer1"
        #@assert answer2 == missing "answer2 was $answer2"

        println("\\n  Day $(lpad(day, 2, "0"))")
        println("  ├─ Part 01: \$(answer1)")
        println("  └─ Part 02: \$(answer2)")
    end

    function ingest(path)
        output = []
        open(path) do f
            for line in eachline(f)
                push!(output, line)
            end
        end
        return output
    end

    function part1(input)
        missing
    end

    function part2(input)
        missing
    end

    end # module
    """
    write(f, contents)
end

# Fetch the input, if possible
println("Downloading input...")
cookie = readline("$(@__DIR__)/.cookie")
input_path = joinpath(@__DIR__, "..", "inputs", lpad(day, 2, "0"), "input.txt")
input_url = "https://adventofcode.com/2025/day/$day/input"
headers = Dict("cookie" => "session=$cookie")

try
    r = HTTP.request("GET", input_url, headers)
    touch(input_path)
    write(input_path, String(r.body))
catch e
    @warn "Could not download input, you'll have to do it manually."
    @warn e
end

println("All done. The template has been created at $puzzlepath")

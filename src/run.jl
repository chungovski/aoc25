using ArgParse
using Revise
include("AdventOfCode.jl")
using .AdventOfCode

#=------------------------------------------------------------------------------
| Load days dynamically
------------------------------------------------------------------------------=#
load()

#=------------------------------------------------------------------------------
| ArgParse Settings
------------------------------------------------------------------------------=#
settings = ArgParseSettings()
@add_arg_table! settings begin
    "--day", "-d"
    help = "Day to run"
    arg_type = Int
    default = 0
end

parsed_args = parse_args(settings)
day = parsed_args["day"]


#=------------------------------------------------------------------------------
| Run a specific Day puzzle and display output
------------------------------------------------------------------------------=#
function start_day(day)
    daymodname = Symbol("Day", lpad(day, 2, "0"))
    if isdefined(AdventOfCode, daymodname)
        daymod = getfield(AdventOfCode, daymodname)
        daymod.run()
    else
        println("\n Day $day has not been solved yet!")
    end
end

println("\nAdvent of Code Results:")
if day == 0
    for d in 1:24
        (isdir ∘ normpath ∘ joinpath)(@__FILE__, "../../inputs", lpad(d, 2, "0")) &&
        start_day(d) || break
    end
else
    @time start_day(day)
end
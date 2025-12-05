using ArgParse
using Revise
import AdventOfCode

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
| Run the indicated Day puzzle and display output
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
        if isdir(normpath(joinpath(@__FILE__, "../../inputs", lpad(d, 2, "0"))))
            start_day(d)
            
        else
            break
        end
    end
else
    start_day(day)
end
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
println("\nAdvent of Code Results:")
daymodname = Symbol("Day", lpad(day, 2, "0"))
if isdefined(AdventOfCode, daymodname)
    println("Running day $day")
    daymod = getfield(AdventOfCode, daymodname)
    daymod.run()
else
    println("\n Day $day has not been solved yet!")
end

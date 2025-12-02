module Day01
using AdventOfCode: getinput

export run
function run()
    inpath = getinput(1, "input")
    input = ingest(inpath)
    answer1 = part1(input)
    answer2 = part2(input)

    println("\n  Day 01")
    println("  ├─ Part 01: $(answer1)")
    println("  └─ Part 02: $(answer2)")
end

ingest(path) = [parse(Int, line[2:end]) * (startswith(line, "L") ? -1 : 1) for line in readlines(path)]
part1(input) = rotate(input, 50)[1]
part2(input) = rotate(input, 50)[2]

function rotate(rotations, start_pos)
    zero_ends, zero_clicks, range = 0, 0, 100
    for rotation = rotations
        end_pos = rotation + start_pos
        zero_clicks +=  rotation > 0 ? div(end_pos, range) : div(range - end_pos, range) - iszero(start_pos)
        start_pos = mod(end_pos, range)
        zero_ends += iszero(start_pos)
    end
    return zero_ends, zero_clicks
end

end # module
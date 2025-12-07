module Day07
include("../AdventOfCode.jl")
using .AdventOfCode: getinput

export run
function run()
    inpath = getinput(7, "input")
    input = ingest(inpath)
    answer1 = part1(input)
    answer2 = part2(input)

    @assert answer1 == 1570
    @assert answer2 == 15118009521693

    println("\n  Day 07")
    println("  ├─ Part 01: $(answer1)")
    println("  └─ Part 02: $(answer2)")
end

function ingest(path)
    lines = readlines(path)
    finds = map(i -> findall(x -> x == '^', lines[i]), 3:2:length(lines))
    finds, length(lines[1])
end

part1(input) = launch(input)[1]
part2(input) = launch(input)[2]

function launch(map)
    splits, start, max = 1, map[1][1][1], map[2]
    beams = Dict(start - 1 => 1, start + 1 => 1)
    for splitters in map[1][begin+1:end]
        next_beams = Dict()
        for (beam, timelines) in beams
            if beam in splitters
                beam - 1 > 0 &&
                    (next_beams[beam-1] = get(next_beams, beam - 1, 0) + timelines)
                beam + 1 <= max &&
                    (next_beams[beam+1] = get(next_beams, beam + 1, 0) + timelines)
                splits += 1
            else # beams that pass through
                next_beams[beam] = get(next_beams, beam, 0) + timelines
            end
        end
        beams = next_beams
    end
    splits, sum(values(beams))
end


end

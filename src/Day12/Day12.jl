module Day12
include("../AdventOfCode.jl")
using .AdventOfCode: getinput

export run
function run()
    inpath = getinput(12, "input")
    input = ingest(inpath)
    answer1 = part1(input)

    @assert answer1 == 460

    println("\n  Day 12")
    println("  ├─ Part 01: $(answer1)")
end

function ingest(path)
    blocks = [split(b, "\n") for b in split(read(path, String), "\n\n")]
    shapes = [[(i, y) for (y, row) in enumerate(block[2:end]) for (i, c) in enumerate(row) if c == '#']
              for block in blocks[begin:6]]
    regs = [(Tuple(parse.(Int, split(grid, "x"))), parse.(Int, split(quants)))
            for block in blocks[7:end] for (grid, quants) in map(l -> split(l, ": "), block)]
    shapes, regs
end

function part1(secs)
    blocks, regs = secs
    fit, not, maybe = 0, 0, 0
    for ((x, y), quants) in regs
        if x * y < sum(quant * length(blocks[i]) for (i, quant) in enumerate(quants))
            not += 1
        elseif div(x, 3) * div(y, 3) >= sum(quants)
            fit += 1
        else
            maybe += 1
        end
    end
    fit
end

end
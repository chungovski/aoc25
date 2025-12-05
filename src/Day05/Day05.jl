module Day05
using AdventOfCode: getinput

export run
function run()
    inpath = getinput(5, "input")
    input = ingest(inpath)
    answer1 = part1(input)
    answer2 = part2(input[1])

    @assert answer1 == 505
    @assert answer2 == 344423158480189

    println("\n  Day 05")
    println("  ├─ Part 01: $(answer1)")
    println("  └─ Part 02: $(answer2)")
end

function ingest(path)
    lines = readlines(path)
    blank = findfirst(isempty, lines)
    @views first, second = lines[begin:blank-1], lines[blank+1:end]
    [parse.(Int, range) for range in split.(first, "-")], parse.(Int, second)
end

function part1(input)
    fresh = Set{Int}()
    for range in input[1], fruit in input[2]
        range[1] ≤ fruit ≤ range[2] && push!(fresh, fruit)
    end
    length(fresh)
end

function part2(ranges)
    sorted, total = sort(ranges), 0
    lo, hi = sorted[1]
    for (a, b) in sorted[2:end]
        if a ≤ hi + 1
            hi = max(hi, b)
        else
            total += hi - lo + 1
            lo, hi = a, b
        end
    end
    total + hi - lo + 1
end

end

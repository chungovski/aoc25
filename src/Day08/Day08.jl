module Day08
include("../AdventOfCode.jl")
using .AdventOfCode: getinput

export run
function run()
    inpath = getinput(8, "input")
    input = ingest(inpath)
    answer1 = part1(input)
    answer2 = part2(input)

    @assert answer1 == 115885
    @assert answer2 == 274150525

    println("\n  Day 08")
    println("  ├─ Part 01: $(answer1)")
    println("  └─ Part 02: $(answer2)")
end

ingest(path) = map(coords -> parse.(Int, split(coords, ",")) |> Tuple, readlines(path))

function part1(points, limit=1000)
    groups = []
    [merge!(groups, a, b) for (a, b) in pair(points)[1:limit]]
    prod(last(sort(length.(groups)), 3))
end

function part2(points)
    groups = []
    for (a, b) in pair(points)
        merge!(groups, a, b)
        if (length ∘ first)(groups) == length(points)
            return a[1] * b[1]
        end
    end
end

dist(a, b) = sum((a[i] - b[i])^2 for i in 1:3)

function pair(points)
    n = length(points)
    pairs = [(points[a], points[b]) for a in 1:n-1 for b in a+1:n]
    sort(pairs, by=p -> dist(p[1], p[2]))
end

function merge!(groups, a, b)
    matches = filter(group -> (a in group || b in group), groups)
    if length(matches) == 2
        union!(matches[1], matches[2])
        deleteat!(groups, findfirst(==(matches[2]), groups))
    elseif length(matches) == 1
        union!(matches[1], [a, b])
    else
        push!(groups, [a, b])
    end
end

end
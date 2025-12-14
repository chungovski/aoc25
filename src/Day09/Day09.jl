module Day09
include("../AdventOfCode.jl")
using .AdventOfCode: getinput

export run
function run()
    inpath = getinput(9, "input")
    input = ingest(inpath)
    answer1 = part1(input)
    answer2 = part2(input)

    @assert answer1 == 4772103936
    @assert answer2 == 1529675217

    println("\n  Day 09")
    println("  ├─ Part 01: $(answer1)")
    println("  └─ Part 02: $(answer2)")
end

ingest(path) = map(coords -> parse.(Int, split(coords, ",")) |> Tuple, readlines(path))

part1(points) = (first ∘ first)(pairs(points))

function part2(points)
    lines = [(minmax(la[1], lb[1]), minmax(la[2], lb[2]))
             for (la, lb) in zip(points, vcat(points[2:end], points[1]))]
    for (area, (a, b)) in pairs(points)
        (xmin, xmax), (ymin, ymax) = minmax(a[1], b[1]), minmax(a[2], b[2])
        all(l -> begin
                (lxmin, lxmax), (lymin, lymax) = l
                xmin >= lxmax || xmax <= lxmin || ymin >= lymax || ymax <= lymin
            end, lines) && return area
    end
end

function pairs(points)
    pairs, l = [], length(points)
    for a in 1:l-1, b in a+1:l
        pa, pb = points[a], points[b]
        push!(pairs, (area(pa, pb), (pa, pb)))
    end
    sort!(pairs, by=first, rev=true)
end

area(a, b) = (abs(a[1] - b[1]) + 1) * (abs(a[2] - b[2]) + 1)

end
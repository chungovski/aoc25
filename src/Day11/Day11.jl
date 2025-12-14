module Day11
include("../AdventOfCode.jl")
using .AdventOfCode: getinput

export run
function run()
    inpath = getinput(11, "input")
    input = ingest(inpath)
    answer1 = part1(input)
    answer2 = part2(input)

    @assert answer1 == 500
    @assert answer2 == 287039700129600

    println("\n  Day 11")
    println("  ├─ Part 01: $(answer1)")
    println("  └─ Part 02: $(answer2)")
end

ingest(path) = Dict(k => split(v) for (k, v) in split.(readlines(path), ": "))

part1(devs) = dfs(devs, "you", "out", Dict())

function part2(devs)
    memo = Dict()
    prod([dfs(devs, "svr", "dac", memo), dfs(devs, "dac", "fft", memo), dfs(devs, "fft", "out", memo)]) +
    prod([dfs(devs, "svr", "fft", memo), dfs(devs, "fft", "dac", memo), dfs(devs, "dac", "out", memo)])
end

function dfs(devs, start, goal, memo)
    if !haskey(memo, (start, goal))
        memo[(start, goal)] = start == goal ? 1 : sum(dfs(devs, nxt, goal, memo) for nxt in get(devs, start, []); init=0)
    end
    memo[(start, goal)]
end

end
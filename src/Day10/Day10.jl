module Day10
include("../AdventOfCode.jl")
using .AdventOfCode: getinput
using DataStructures
using Base.Threads
using JuMP, HiGHS

export run
function run()
    inpath = getinput(10, "input")
    input = ingest(inpath)
    answer1 = part1(input)
    answer2 = part2(input)

    @assert answer1 == 512
    @assert answer2 == 19857

    println("\n  Day 10")
    println("  ├─ Part 01: $(answer1)")
    println("  └─ Part 02: $(answer2)")
end

ingest(path) = [(
    [c == '#' for c in s[1][2:end-1]],
    Tuple(parse.(Int, split(t[2:end-1], ",")) .+ 1 for t in s[2:end-1]),
    Tuple(parse.(Int, split(s[end][2:end-1], ",")))
) for s in split.(readlines(path), " ")]

part1(machs) = sum(minpresslights, machs)
part2(machs) = sum(minpressjolts, machs)

function minpresslights(mach)
    goal, butts = mach
    start = fill(false, length(goal))
    pressed, q = [start], Queue{Tuple{Vector{Bool},Int}}()
    push!(q, (start, 0))
    while !isempty(q)
        curr, press = popfirst!(q)
        curr == goal && return press
        for butt in butts
            if (nxt = toggle(curr, butt)) ∉ pressed
                push!(pressed, nxt)
                push!(q, (nxt, press + 1))
            end
        end
    end
end

function toggle(lights, butt)
    nxt = copy(lights)
    nxt[butt] = .!nxt[butt]
    nxt
end

function minpressjolts(mach)
    _, butts, goal = mach
    model = Model(HiGHS.Optimizer)
    set_silent(model)
    @variable(model, 0 <= x[eachindex(butts)], Int)
    @objective(model, Min, sum(x))
    for (i, jolt) in enumerate(goal)
        pb = [p for (butt, p) in zip(butts, x) if i in butt]
        @constraint(model, sum(pb) == jolt)
    end
    optimize!(model)
    round(Int, objective_value(model))
end

end
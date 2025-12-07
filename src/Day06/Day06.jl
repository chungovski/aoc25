module Day06
include("../AdventOfCode.jl")
using .AdventOfCode: getinput
using DelimitedFiles: readdlm

export run
function run()
    inpath = getinput(6, "input")
    input = ingest(inpath)
    answer1 = part1(input)
    answer2 = part2(input)

    @assert answer1 == 8108520669952
    @assert answer2 == 11708563470209

    println("\n  Day 06")
    println("  ├─ Part 01: $(answer1)")
    println("  └─ Part 02: $(answer2)")
end

function ingest(path)
    lines = readlines(path)
    maxlen = maximum(length.(lines))
    ops_i = [(c, i) for (i, c) in enumerate(lines[end]) if !isspace(c)]
    ops_r = map(enumerate(ops_i)) do (k, (op, i))
        next_i = k < length(ops_i) ? ops_i[k+1][2] : maxlen + 2
        (eval ∘ Symbol)(op), i:(next_i-2)
    end
    ops_r, stack(rpad.(lines[begin:end-1], maxlen); dims=1)
end

function part1(man)
    ops, chars = man
    matrix = hcat([parse.(Int, getfield.(eachmatch(r"\d+", String(row)), :match))
                   for row in eachrow(chars)]...)
    sum(op(matrix[i, :]...) for (i, (op, _)) in enumerate(ops))
end

function part2(man)
    (ops, chars), sum = man, 0
    for (op, range) in ops
        sum += op(map(col -> parse(Int, String(col)), eachcol(chars[:, range]))...)
    end
    sum
end

end

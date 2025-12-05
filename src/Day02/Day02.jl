module Day02
using AdventOfCode: getinput

export run
function run()
    inpath = getinput(2, "input")
    input = ingest(inpath)
    answer1 = part1(input)
    answer2 = part2(input)

    @assert answer1 == 24157613387
    @assert answer2 == 33832678380

    println("\n  Day 02")
    println("  ├─ Part 01: $(answer1)")
    println("  └─ Part 02: $(answer2)")
end

ingest(path) = [(parse.(Int, split(range, "-"))) for range in split(readline(path), ",")]
part1(ranges) = find(ranges, (l, i) -> div(l, 2) == i && mod(l, 2) == 0)
part2(ranges) = find(ranges)

find(ranges, pred=(_, _) -> true) = sum(Set(n for range in ranges for n in range[1]:range[2] if is_valid(n, pred)))

function is_valid(n, pred)
    s, l = string(n), length(s)
    any(i -> mod(l, i) == 0 && count(first(s, i), s) == div(l, i) && pred(l, i), 1:div(l, 2))
end

end
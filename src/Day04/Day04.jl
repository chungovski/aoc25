module Day04
using AdventOfCode: getinput

export run
function run()
    inpath = getinput(4, "input")
    input = ingest(inpath)
    answer1 = part1(input)
    answer2 = part2(input)

    @assert answer1 == 1540
    @assert answer2 == 8972

    println("\n  Day 04")
    println("  ├─ Part 01: $(answer1)")
    println("  └─ Part 02: $(answer2)")
end

ingest(path) = map(collect, readlines(path))

part1(mat) = picktp(mat)
part2(mat) = picktp(mat, true)

offsets = [
    (-1, -1), (-1, 0), (-1, 1),
    (0, -1), (0, 1),
    (1, -1), (1, 0), (1, 1)
]

function picktp(mat, repeat=false)
    rows, cols, finds = length(mat), (length ∘ first)(mat), Set{Tuple{Int,Int}}()
    while true
        fresh = Set{Tuple{Int,Int}}()
        for y in 1:rows, x in 1:cols
            mat[y][x] == '@' && (y, x) ∉ finds && sum(
                    0 < (neigh_y = y + off_y) ≤ rows && 0 < (neigh_x = x + off_x) ≤ cols &&
                        mat[neigh_y][neigh_x] == '@' && (neigh_y, neigh_x) ∉ finds
                    for (off_y, off_x) in offsets
                ) < 4 && push!(fresh, (y, x))
        end
        union!(finds, fresh)
        (!repeat || isempty(fresh)) && break
    end
    length(finds)
end

end

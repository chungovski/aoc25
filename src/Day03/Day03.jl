module Day03
using AdventOfCode: getinput

export run
function run()
    inpath = getinput(3, "input")
    input = ingest(inpath)
    answer1 = part1(input)
    answer2 = part2(input)

    @assert answer1 == 17432
    @assert answer2 == 173065202451341

    println("\n  Day 03")
    println("  ├─ Part 01: $(answer1)")
    println("  └─ Part 02: $(answer2)")
end

ingest(path) = readlines(path)
part1(lines) = turnbatteries(lines, 2)
part2(lines) = turnbatteries(lines, 12)

function turnbatteries(lines, batts)
    sum = 0
    for line in lines
        result, next_index = 0, 0
        for batts_left in batts-1:-1:0
            for i in 9:-1:0
                find = findfirst(string(i), chop(line, head=next_index, tail=batts_left))
                if find !== nothing
                    result = result * 10 + i
                    next_index += first(find)
                    break
                end
            end
        end
        sum += result
    end
    sum
end

end

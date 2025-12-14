This project is a small Julia Advent of Code repository. Use these project-specific
notes to stay productive when authoring or modifying solutions.

- **Project layout**: `src/` contains a `DayXX` module per puzzle and `run.jl` to drive runs; `inputs/` stores per-day input folders like `inputs/01/input.txt` and `inputs/01/test.txt`.
- **Entry points**: `src/run.jl` (CLI) and `src/AdventOfCode.jl` (helpers). `run.jl` uses ArgParse; run a single day with `julia --project=. src/run.jl -d 1` or all detected days with `julia --project=. src/run.jl`.

- **Module pattern**: Each day follows the pattern in `src/Day01/Day01.jl` and `src/Day10/Day10.jl`:
  - `module DayNN` with `include("../AdventOfCode.jl")` and `using .AdventOfCode: getinput`.
  - `export run()` which calls `ingest`, `part1`, and `part2` and prints results.
  - `ingest(path)`, `part1(input)`, `part2(input)` functions are the expected shapes and help keep consistent day implementations.

- **Inputs helpers**: Use `getinput(day, "input")` or `getinput(day, "test")` (see [src/AdventOfCode.jl](src/AdventOfCode.jl#L1)) — it returns `inputs/NN/NAME.txt` with padded 2-digit day number.

- **Create new days**: Use the templating helper `julia --project=. src/template.jl -d 1` which creates `src/Day01` with template files and optionally will download your input when you supply a `src/.cookie` session cookie.

- **Loading days**: `AdventOfCode.load()` scans `src` and includes any file matching `Day\d{2}.jl`. Name your file `DayNN.jl` inside `src/DayNN/` to register automatically.

- **Assertions & results**: Day `run()` functions commonly assert expected answers against the repository `inputs/NN/input.txt`. Keep those asserts (or manage them intentionally) — they serve as the project's lightweight tests.

- **Running & iterative dev**: `src/run.jl` requires the Julia project. Use `julia --project=. src/run.jl` or add the startup activation snippet from `README.md` in your `~/.julia/config/startup.jl` for convenience. `run.jl` includes `Revise` for fast edit-and-run cycles.

- **Adding dependencies**: Use the package manager in project mode. From project root:
  - `julia --project=. -e 'using Pkg; Pkg.add("PackageName")'`
  - or use the REPL `] activate .; add PackageName` which updates `Project.toml` and `Manifest.toml`.

- **Note about Z3**: The project uses `Z3` in `src/Day10/Day10.jl`. Z3.jl depends on a system Z3 library — install it via your OS package manager if you hit native errors (e.g., `brew install z3` on macOS).

- **Conventions you should follow**:
  - Keep the `DayNN` module focused and return both parts from `part1`/`part2` functions for easy asserts.
  - Use `getinput` to read files; don’t hardcode input paths.
  - Keep the formatting used in `run()` for consistent outputs: the run script prints `Day NN` and part results similarly to other days.

- **No unit test harness**: This repository uses asserts in `run()` as the primary verification method (no `test/` folder or CI). That means careful assert management and consistent expected outputs are the test strategy here.

- **Extra patterns**: Some day solutions use packages like `DataStructures` and `Base.Threads` — inspect `Project.toml` for available deps and follow their use as-is.

If this summary missed a project detail you need automated instructions for, tell me which part and I’ll expand the guidance.

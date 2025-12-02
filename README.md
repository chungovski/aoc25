### Julia Project

The project structure looks like this:

```
AdventOfCode
├─inputs
│ └─DD
│   ├─input.txt
│   └─test.txt
├─src
│ │─DayXX
│ │ ├─DayXX.jl
│ ├─AdventOfCode.jl
│ ├─run.jl
│ └─template.jl
├─Manifest.toml
└─Project.toml
```

With the `AdventOfCode` package activated (see below):

- Get the results for a particular day with `julia src/run.jl -d 1`
- Template a new day with `julia src/template.jl -d 1`

Templating a new day entails creating a 'Day' folder with template scripts for
`ingest.jl`, `part01.jl`, and `part02.jl`. You can copy your session cookie into a
`src/.cookie` file, and the template script will also download your input into
`inputs` for your. Otherwise, it'll tell you to do it yourself.


**Note on Julia project activation**

To conveniently use the commands listed above, add the following to your `/.julia/config/startup.jl`:

```julia
using Pkg
if isfile("Project.toml") && isfile("Manifest.toml")
    Pkg.activate(".")
end
```

Julia boilerplate copied from [ericwburden][source]

[source]: https://github.com/ericwburden/advent_of_code_legacy


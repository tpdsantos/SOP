
using Documenter, SOP

DOCUMENTER_DEBUG = true

makedocs(
    format = :html,
    sitename = "Package name",
    pages = [
        "index.md",
        "Page title" => "index.md",
        "Subsection" => [] ]
)

deploydocs(
    repo   = "github.com/tpdsantos/Aulas-SOP.jl.git",
    target = "build",
    deps   = nothing,
    make   = nothing,
    julia  = "0.7"
)

using Documenter, SOP

ENV["DOCUMENTER_DEBUG"] = true

makedocs(
    format = :html,
    sitename = "Aulas de SOP",
    pages = [
        "index.md",
    ]
)

deploydocs(
    repo   = "github.com/tpdsantos/SOP.git",
    target = "build",
    deps   = nothing,
    make   = nothing,
    julia  = "0.6",
    osname = "linux",
    branch = "master"
)

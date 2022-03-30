# what is the path?
_BASE_PATH = pwd()
_PATH_TO_SRC = joinpath(_BASE_PATH, "src")
_PATH_TO_MODEL = joinpath(_BASE_PATH, "model")

# load external packages -
using DifferentialEquations
using CSV
using DataFrames
using Tables
using Plots

# load my codes -
include(joinpath(_PATH_TO_SRC, "Balances.jl"))
include(joinpath(_PATH_TO_SRC, "Kinetics.jl"))
include(joinpath(_PATH_TO_SRC, "Parser.jl"))
include(joinpath(_PATH_TO_SRC, "Stoichiometry.jl"))
include(joinpath(_PATH_TO_SRC, "Factory.jl"))

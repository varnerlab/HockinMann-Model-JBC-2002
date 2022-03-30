# load required packages and codes -
include("Include.jl")

# set the path to the test model file -
path_to_model_file = joinpath(_PATH_TO_MODEL, "Test.vff")

# build the default model -
model = build_default_model(path_to_model_file)

# the order of the species will be in the species_symbol_array -> E, E_S, P and S
# update the default initial conditions (default: zeros)
xₒ = model["initial_conditions_array"]
xₒ[1] = 10.0    # 1 E
xₒ[4] = 100.0   # 4 S
xₒ[2] = 0.0    

# set up rate constants - order of rates in the reaction_symbol_array -
κ = model["κ"]
κ[1] = 1.0
κ[2] = 0.2
κ[1] = 0.5

# solve the model -
tspan = (0.0,20.0)
Δt = 0.01
prob = ODEProblem(balances, xₒ, tspan, model; saveat = Δt)
soln = solve(prob)

# get the results from the solver -
T = soln.t
Xₘ = hcat(soln.u...)

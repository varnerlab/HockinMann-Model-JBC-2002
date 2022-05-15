# load required packages and codes -
include("Include.jl")

# set the path to the test model file -
path_to_model_file = joinpath(_PATH_TO_MODEL, "Test_unsplit.vff")

# build the default model -
model = build_default_model(path_to_model_file)

# the order of the species will be in the species_symbol_array -> E, E_S, P and S
# update the default initial conditions (default: zeros)
#all xₒ units are nM
xₒ = model["initial_conditions_array"]
xₒ[1] = 3.4e3
xₒ[2] = 1.4e3
xₒ[5] = 90
xₒ[10] = 0
xₒ[11] = 2.5
xₒ[19] = 20
xₒ[20] = 10
xₒ[21] = 0.7
xₒ[25] = 0.1
xₒ[27] = 1.6e2

# set up rate constants - order of rates in the reaction_symbol_array -
#κ have been converted to nM-1s-1 where there is a second order reaction
κ = model["κ"]
κ[1] = 3.2e-3 #
κ[2] = 3.1e-3 #
κ[3] = 2.3e-2
κ[4] = 3.1e-3
κ[5] = 4.4e-4
κ[6] = 1.3e-2
κ[7] = 2.3e-5
κ[8] = 2.5e-2
κ[9] = 1.05 
κ[10] = 6
κ[11] = 5e-3 #
κ[12] = 1 #
κ[13] = 1e-1
κ[14] = 2.4 
κ[15] = 0.47 
κ[16] = 7.5e-6 
κ[17] = 2e-2
κ[18] = 1e-2
κ[19] = 5e-3
κ[20] = 1e-1
κ[21] = 1e-3
κ[22] = 8.2
κ[23] = 6e-3
κ[24] = 2.2e-5
κ[25] = 1e-3
κ[26] = 1e-3
κ[27] = 2e-2
κ[28] = 4e-1
κ[29] = 0.2 
κ[30] = 1e-1 #*
κ[31] = 1 #*
κ[32] = 4.3e-2 #*
κ[33] = 1.5e-2
κ[34] = 1.6e-3
κ[35] = 3.6e-4
κ[36] = 3.2e-1
κ[37] = 1.1e-4
κ[38] = 5e-2
κ[39] = 1.5e-6
κ[40] = 7.1e-6
κ[41] = 4.9e-7
κ[42] = 7.1e-6
κ[43] = 2.3e-7

# solve the model -
tspan = (0.0,1200.0)
Δt = 0.1
prob = ODEProblem(balances, xₒ, tspan, model; saveat = Δt)
soln = solve(prob)

# get the results from the solver -
T = soln.t
Xₘ = hcat(soln.u...)
Thrombin = Xₘ[3,:]+1.2*Xₘ[33,:] #FIIa is the 3rd species in species_symbol_array
plot(T[1:7501],Thrombin[1:7501])


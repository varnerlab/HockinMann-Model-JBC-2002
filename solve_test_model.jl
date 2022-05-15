# load required packages and codes -
include("Include.jl")

# set the path to the test model file -
path_to_model_file = joinpath(_PATH_TO_MODEL, "Test.vff")

# build the default model -
model = build_default_model(path_to_model_file)

# the order of the species will be in the species_symbol_array -> E, E_S, P and S
# update the default initial conditions (default: zeros)
#all xₒ units are nM
xₒ = model["initial_conditions_array"]
#xₒ[1] = 3.4e3
xₒ[2] = 1.4e3
xₒ[8] = 9e1
xₒ[13] = 1e-3
#xₒ[16] = 1.0
xₒ[14] = 2.5
xₒ[23] = 2e1
xₒ[24] = 1e1
xₒ[25] = 0.7
xₒ[29] = 1e-1
xₒ[31] = 1.6e2

# set up rate constants - order of rates in the reaction_symbol_array -
#κ have been converted to nM-1s-1 where there is a second order reaction
κ = model["κ"]
κ[1] = 3.1e-3
κ[2] = 3.1e-3
κ[3] = 2.5e-2
κ[4] = 2e-3
κ[5] = 9e-2 #Anand* - indicates where i got the value from, * indicates that i'm not convinced with the values because it wasnt the exact same reaction
κ[6] = 5e-3 #Anand*
κ[7] = 0.5 #Anand*
κ[8] = 0.1 #Varner et al.
κ[9] = 1. #Varner et al.
κ[10] = 0.5 #Varner et al.
κ[11] = 0.1 #Varner et al.
κ[12] = 10. #Varner et al.
κ[13] = 0.5 #Varner et al.
κ[14] = 0.1 #Varner et al.
κ[15] = 5.5 #Varner et al.
κ[16] = 19. #Varner et al.
κ[17] = 2.2e-2 
κ[18] = 19
κ[19] = 0.01
κ[20] = 2.4
κ[21] = 1.8
κ[22] = 12e-6 #Varner et al.
κ[23] = 1e-9 #Varner et al.
κ[24] = 30e-4 #Varner et al.
κ[25] = 0.1 #Varner et al.
κ[26] = 15. #Varner et al.
κ[27] = 0.9 #Varner et al.
κ[28] = 1e7*1e-9
κ[29] = 5e-3
κ[30] = 1e8*1e-9
κ[31] = 1e-3
κ[32] = 8.2
κ[33] = 6e-3
κ[34] = 2.2e-5
κ[35] = 1e-3
κ[36] = 1e-3
κ[37] = 0.1 #Varner et al.
κ[38] = 7.2 #Varner et al.
κ[39] = 4.2 #Varner et al.
κ[40] = 4e-1
κ[41] = 0.2
κ[42] = 1e-1
κ[43] = 103
κ[44] = 75.
κ[45] = 0.01 #Varner et al.*
κ[46] = 1.1 #Varner et al.*
κ[47] = 0.15 #Varner et al.*
κ[48] = 0.3
κ[49] = 3.6e-2
κ[50] = 0.32
κ[51] = 1.1e-3
κ[52] = 5e-2
κ[53] = 10e-6
κ[54] = 7.1e-6
κ[55] = 4.9e-7
κ[56] = 7e-6
κ[57] = 3e-7

# solve the model -
tspan = (0.0,1200.0)
Δt = 0.1
prob = ODEProblem(balances, xₒ, tspan, model; saveat = Δt)
soln = solve(prob)

# get the results from the solver -
T = soln.t
Xₘ = hcat(soln.u...)
Thrombin = Xₘ[3,:]+1.2*Xₘ[39,:] #FIIa is the 3rd species in species_symbol_array
#p = CSV.read("data\\15pmTF_TFPIAT.csv",DataFrame)
#plot(T[1:7001],Thrombin[1:7001])
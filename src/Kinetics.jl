function compute_kinetics_vector(x,m,t)::Array{Float64,1}

    # initialize -
    κ = m["κ"]
    S = m["S"]
    number_of_rates = m["number_of_rates"]
    rate_vector = zeros(number_of_rates)
    
    # main loop -
    tmp_set = Set{Float64}()
    for j ∈ 1:number_of_rates

        # TODO: we should cache the index vectors for each rate in the model dictionary -
        idx_reactants = findall(x->x<0.0, S[:,j]) 
        for index ∈ idx_reactants
            
            σ = S[index,j]
            term = x[index]^(-σ)
            push!(tmp_set,term)
        end

        # compute the rate -
        rate_vector[j] = κ[j]*prod(tmp_set)

        # clean-up
        empty!(tmp_set)
    end

    # return -
    return rate_vector
end
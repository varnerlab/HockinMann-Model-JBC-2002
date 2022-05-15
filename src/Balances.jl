function balances(dx, x, m, t)

    # get data from the m (model) dictionary -
    S = m["S"]
    number_of_dynamic_states = m["number_of_dynamic_states"]

    # compute the kinetics - powerlaw
    rV = compute_kinetics_vector(x,m,t)

    # compute the rhs -> store in a temp vector
    tmp = S*rV

    # populate the dx vector with the tmp vector -
    for i ∈ 1:number_of_dynamic_states
        dx[i] = tmp[i]
    end
end
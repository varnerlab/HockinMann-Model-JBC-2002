function build_default_model(path_to_reaction_file::String)::Dict{String,Any}
    
    # initialize -
    model_dictionary = Dict{String,Any}()
    
    # read the model file -
    reaction_file_buffer = read_reaction_file(path_to_reaction_file)

    # build the stoichiometric_matrix et al -
    (S, species_array, reaction_array) = build_stoichiometric_matrix(reaction_file_buffer; 
        expand=true)

    # what is the dimension of our system?
    (R,C) = size(S)

    # add stuff to the model dictionary -
    model_dictionary["S"] = S
    model_dictionary["number_of_dynamic_states"] = R
    model_dictionary["number_of_rates"] = C
    model_dictionary["κ"] = ones(C)
    model_dictionary["species_symbol_array"] = species_array
    model_dictionary["reaction_symbol_array"] = reaction_array
    model_dictionary["initial_conditions_array"] = zeros(R)

    # return -
    return model_dictionary
end


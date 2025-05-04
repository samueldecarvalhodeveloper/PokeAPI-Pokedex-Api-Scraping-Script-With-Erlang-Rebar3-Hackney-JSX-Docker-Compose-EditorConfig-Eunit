-module(pokemon_data_access_object).

-include("src/constants/domains/pokemon_constants.hrl").

-export([get_list_of_pokemons/0, get_list_of_pokemons_image_blob/0]).

get_list_of_pokemons() ->
    ListOfPokemonsIdFromTheFirstGeneration = lists:seq(
        ?FIRST_GENERATION_FIRST_POKEMON_ID,
        ?FIRST_GENERATION_LAST_POKEMON_ID
    ),

    ListOfRawPokemonsDataFromTheFirstGeneration = lists:map(
        fun(PokemonId) ->
            pokemon_mapper:get_mapped_pokemon_data(
                pokemon_gateway:get_raw_pokemon_data(integer_to_list(PokemonId))
            )
        end,
        ListOfPokemonsIdFromTheFirstGeneration
    ),

    io:fwrite("Pokemon Fetching And Mapping Process Finished!~n"),

    ListOfRawPokemonsDataFromTheFirstGeneration.

get_list_of_pokemons_image_blob() ->
    ListOfPokemonsIdFromTheFirstGeneration = lists:seq(?FIRST_GENERATION_FIRST_POKEMON_ID, ?FIRST_GENERATION_LAST_POKEMON_ID),

    ListOfPokemonsImage = lists:map(
        fun(PokemonId) ->
            pokemon_gateway:get_pokemon_image_blob(integer_to_list(PokemonId))
        end,
        ListOfPokemonsIdFromTheFirstGeneration
    ),

    io:fwrite("Pokemon Image Blob Fetching Process Finished!~n"),

    ListOfPokemonsImage .

-module(pokemon_mapper_test).

-include_lib("eunit/include/eunit.hrl").

-include("src/constants/domains/pokemon_constants.hrl").

function_get_mapped_pokemon_data_returning_pokemon_data_able_to_be_write_of_json_test() ->
    RawPokemonData = pokemon_gateway:get_raw_pokemon_data(?BULBASAUR_ID),

    TransformedPokemonData = pokemon_mapper:get_mapped_pokemon_data(RawPokemonData),

    ?assertEqual(?INTEGER_OF_BULBASAUR_ID, maps:get(?POKEMON_DATA_MAP_ID_KEY,TransformedPokemonData)),
    ?assertEqual(<<?CAPITALIZE_BULBASAUR_NAME>>, maps:get(?POKEMON_DATA_MAP_NAME_KEY,TransformedPokemonData)),
    ?assertEqual(<<?GRASS_TYPE>>, lists:nth(1, maps:get(?POKEMON_DATA_MAP_TYPES_KEY,TransformedPokemonData))),
    ?assertEqual(<<?POISON_TYPE>>, lists:nth(2, maps:get(?POKEMON_DATA_MAP_TYPES_KEY,TransformedPokemonData))).

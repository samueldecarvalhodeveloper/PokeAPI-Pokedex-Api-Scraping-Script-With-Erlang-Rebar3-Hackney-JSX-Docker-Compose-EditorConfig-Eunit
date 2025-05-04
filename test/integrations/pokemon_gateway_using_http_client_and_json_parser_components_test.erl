-module(pokemon_gateway_using_http_client_and_json_parser_components_test).

-include_lib("eunit/include/eunit.hrl").

-include("src/constants/domains/pokemon_constants.hrl").

pokemon_gateway_fetching_data_from_server_pokemon_data_and_parsing_its_response_json_integration_test() ->
    RawPokemonData = pokemon_gateway:get_raw_pokemon_data(?BULBASAUR_ID),

    ?assertEqual(?BULBASAUR_ID, lists:flatten(io_lib:format("~p",[maps:get(?POKEMON_DATA_MAP_ID_KEY, RawPokemonData)]))),
    ?assertEqual(?BULBASAUR_NAME, binary_to_list(maps:get(?POKEMON_DATA_MAP_NAME_KEY, RawPokemonData))).

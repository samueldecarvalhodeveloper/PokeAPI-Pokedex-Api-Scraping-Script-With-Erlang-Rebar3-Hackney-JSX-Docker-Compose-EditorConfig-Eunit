-module(pokemon_gateway_test).

-include_lib("eunit/include/eunit.hrl").

-include("src/constants/domains/pokemon_constants.hrl").
-include("src/constants/domains/file_writer_constants.hrl").

function_get_raw_pokemon_data_returning_api_scraped_raw_data_test() ->
    RawPokemonData = pokemon_gateway:get_raw_pokemon_data(?BULBASAUR_ID),

    ?assertEqual(?BULBASAUR_ID, lists:flatten(io_lib:format("~p",[maps:get(?POKEMON_DATA_MAP_ID_KEY, RawPokemonData)]))),
    ?assertEqual(?BULBASAUR_NAME, binary_to_list(maps:get(?POKEMON_DATA_MAP_NAME_KEY, RawPokemonData))).

function_get_pokemon_image_blob_returning_pokemon_image_binary_long_object_test() ->
    RawPokemonData = pokemon_gateway:get_pokemon_image_blob(?BULBASAUR_ID),

    {_, BulbasaurImageMock} = file:read_file(?BULBASAUR_IMAGE_MOCK_PATH),

    ?assertEqual(BulbasaurImageMock, RawPokemonData),

    file:close(BulbasaurImageMock).

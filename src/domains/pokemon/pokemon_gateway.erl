-module(pokemon_gateway).

-export([get_raw_pokemon_data/1, get_pokemon_image_blob/1]).

-include("src/constants/domains/pokemon_constants.hrl").

get_raw_pokemon_data(Id) ->
    PokemonUrl = string:concat(?POKEMON_DATA_URL, Id),

    NotParsedJsonOfPokemonData = http_client:get_request_response_body(PokemonUrl),

    ParsedPokemonData = json_parser:get_parsed_json(NotParsedJsonOfPokemonData),

    PokemonName = string:titlecase(maps:get(?POKEMON_DATA_MAP_NAME_KEY, ParsedPokemonData)),

    io:fwrite("~p: Data Fetched...~n", [binary_to_list(PokemonName)]),

    ParsedPokemonData.

get_pokemon_image_blob(Id) ->
    PokemonImageUrl = string:concat(string:concat(?POKEMON_IMAGE_BASE_URL, Id), ?POKEMON_IMAGE_FILE_EXTENSION),
    PokemonUrl = string:concat(?POKEMON_DATA_URL, Id),

    PokemonImage = http_client:get_request_response_body(PokemonImageUrl),

    NotParsedJsonOfPokemonData = http_client:get_request_response_body(PokemonUrl),

    ParsedPokemonData = json_parser:get_parsed_json(NotParsedJsonOfPokemonData),

    PokemonName = string:titlecase(maps:get(?POKEMON_DATA_MAP_NAME_KEY, ParsedPokemonData)),

    io:fwrite("~p: Image Fetched...~n", [binary_to_list(PokemonName)]),

    PokemonImage.

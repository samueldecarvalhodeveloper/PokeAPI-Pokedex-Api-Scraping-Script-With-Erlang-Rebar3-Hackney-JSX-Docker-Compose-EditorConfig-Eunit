-module(pokemon_mapper).

-include("src/constants/domains/pokemon_constants.hrl").

-export([get_mapped_pokemon_data/1]).

get_mapped_pokemon_data(RawPokemonData) ->
    PokemonId = maps:get(?POKEMON_DATA_MAP_ID_KEY, RawPokemonData),
    PokemonName = string:titlecase(maps:get(?POKEMON_DATA_MAP_NAME_KEY, RawPokemonData)),
    ListOfPokemonTypes = lists:map(
        fun(Type) ->
            string:titlecase(maps:get(
                <<"name">>,
                maps:get(<<"type">>,Type)
            )) end,
            maps:get(?POKEMON_DATA_MAP_TYPES_KEY, RawPokemonData)
    ),

    PokemonName = string:titlecase(maps:get(?POKEMON_DATA_MAP_NAME_KEY, RawPokemonData)),

    io:fwrite("~p: Pokemon Data Mapped.~n", [binary_to_list(PokemonName)]),

    #{?POKEMON_DATA_MAP_ID_KEY => PokemonId, ?POKEMON_DATA_MAP_NAME_KEY => PokemonName, ?POKEMON_DATA_MAP_TYPES_KEY => ListOfPokemonTypes}.

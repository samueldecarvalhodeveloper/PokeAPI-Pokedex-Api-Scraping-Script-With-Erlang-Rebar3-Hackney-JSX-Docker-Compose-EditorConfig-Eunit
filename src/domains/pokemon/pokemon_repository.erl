-module(pokemon_repository).

-export([get_pokemons_data/0, get_pokemons_image/0]).

get_pokemons_data() ->
    pokemon_data_access_object:get_list_of_pokemons().

get_pokemons_image() ->
    pokemon_data_access_object:get_list_of_pokemons_image_blob().

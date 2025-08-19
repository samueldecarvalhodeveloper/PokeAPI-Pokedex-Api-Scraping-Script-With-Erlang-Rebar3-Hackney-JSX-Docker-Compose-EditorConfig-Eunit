-module(web_scraping_script).

-include("src/constants/domains/file_writer_constants.hrl").
-include("src/constants/domains/pokemon_constants.hrl").

-export([execute_web_scraping_script/0]).

execute_web_scraping_script() ->
    io:fwrite("Starting Pokemons Data Fetching And Storing Json On The Disk:~n"),

    io:fwrite("Starting Pokemons Data Fetching...~n"),

    PokemonsData = pokemon_repository:get_pokemons_data(),

    io:fwrite("Ending Pokemons Data Fetching!~n"),

    io:fwrite("Starting Pokemons Data Json Storing On The Disk...~n"),

    SerializedJsonOfPokemonsData = json_parser:get_serialized_json(PokemonsData),

    io:fwrite("Pokemons Data Json Writing On Disk Process Starting~n"),

    file_writer:write_file(
        SerializedJsonOfPokemonsData,
        ?POKEMONS_DATA_JSON_FILE_NAME,
        ?POKEMONS_SCRAPED_DATA_DIRECTORY
    ),

    io:fwrite("Ending Pokemons Data Json Storing On The Disk!~n"),

    io:fwrite("Starting Pokemons Image Fetching From Server...~n"),

    PokemonsImage = pokemon_repository:get_pokemons_image(),

    io:fwrite("Ending Pokemons Image Fetching From Server!~n"),

    ListOfPokemonsIdFromTheFirstGeneration = lists:seq(
        ?FIRST_GENERATION_FIRST_POKEMON_ID,
        ?FIRST_GENERATION_LAST_POKEMON_ID
    ),

    io:fwrite("Pokemons Image On Disk Writing Process Starting:~n"),

    lists:map(
        fun(PokemonId) ->
            PokemonName = maps:get(?POKEMON_DATA_MAP_NAME_KEY, lists:nth(PokemonId ,PokemonsData)),

            io:fwrite("~p: Pokemon Data Writing On Disk Process Started...~n", [binary_to_list(PokemonName)]),

            file_writer:write_binary_file(
                lists:nth(PokemonId, PokemonsImage),
                string:concat(integer_to_list(PokemonId), ?POKEMON_IMAGE_FILE_EXTENSION),
                string:concat(?POKEMONS_SCRAPED_DATA_DIRECTORY, string:concat(?DIRECTORY_DIVISOR_CHARACTER, ?POKEMONS_IMAGE_SUBDIRECTORY))
            ),

            io:fwrite("~p: Pokemon Data Writing On Disk Process Finished!~n", [binary_to_list(PokemonName)])
        end,
        ListOfPokemonsIdFromTheFirstGeneration
    ),

    io:fwrite("Pokemons Image On Disk Writing Process Finished!~n"),

    io:fwrite("Process Of Pokemons Data Fetching And Storing Json On The Disk Ended!~n").

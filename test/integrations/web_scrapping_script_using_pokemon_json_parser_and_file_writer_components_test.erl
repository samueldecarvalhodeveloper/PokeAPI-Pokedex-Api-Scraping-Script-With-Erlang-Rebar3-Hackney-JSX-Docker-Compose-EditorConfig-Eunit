-module(web_scrapping_script_using_pokemon_json_parser_and_file_writer_components_test).

-include_lib("eunit/include/eunit.hrl").

-include("src/constants/domains/file_writer_constants.hrl").
-include("src/constants/domains/pokemon_constants.hrl").
-include("src/constants/script_constants.hrl").

web_scrapping_script_fetching_pokemons_data_and_image_throught_pokemon_repository_serializing_its_content_and_writing_on_disk_integration_test_() ->
    {timeout,
        ?LARGER_TIMEOUT,
        fun() ->
            web_scraping_script:execute_web_scraping_script(),

            {_, PokemonDataJsonContent} = file:read_file(?POKEMONS_DATA_MOCK_PATH),

            {_, PokemonDataMock} = file:read_file(
                    string:concat(
                        ?POKEMONS_SCRAPED_DATA_DIRECTORY,
                        string:concat(
                            ?DIRECTORY_DIVISOR_CHARACTER,
                            ?POKEMONS_DATA_JSON_FILE_NAME
                        )
                    )
                ),


            ?assertEqual(PokemonDataMock, PokemonDataJsonContent),

            BulbasaurImageBlobFromServer = pokemon_gateway:get_pokemon_image_blob(?BULBASAUR_ID),

            {ok, BulbasaurImageBlobFromDisk} = file:read_file(
                string:concat(
                    ?POKEMONS_SCRAPED_DATA_DIRECTORY,
                    string:concat(
                        ?DIRECTORY_DIVISOR_CHARACTER,
                        string:concat(
                            ?POKEMONS_IMAGE_SUBDIRECTORY,
                            string:concat(
                                ?DIRECTORY_DIVISOR_CHARACTER,
                                string:concat(
                                    ?BULBASAUR_ID,
                                    ?POKEMON_IMAGE_FILE_EXTENSION
                                )
                            )
                        )
                    )
                )
            ),

            ?assertEqual(BulbasaurImageBlobFromServer, BulbasaurImageBlobFromDisk),

            file:close(BulbasaurImageBlobFromDisk),

            os:cmd(string:concat(?DIRECTORY_DELETING_UNIX_COMMAND, ?POKEMONS_SCRAPED_DATA_DIRECTORY))
        end
    }.

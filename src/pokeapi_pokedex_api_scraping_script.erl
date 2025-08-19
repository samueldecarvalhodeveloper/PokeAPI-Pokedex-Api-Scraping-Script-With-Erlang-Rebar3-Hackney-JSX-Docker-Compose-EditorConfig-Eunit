-module(pokeapi_pokedex_api_scraping_script).

-export([main/1]).

-include("src/constants/domains/file_writer_constants.hrl").

main(Args) ->
    web_scraping_script:execute_web_scraping_script(),

    erlang:halt(0).

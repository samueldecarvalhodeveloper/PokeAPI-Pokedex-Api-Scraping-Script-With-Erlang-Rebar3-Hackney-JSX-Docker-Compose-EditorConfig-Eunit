-module(file_writer_component_test).

-include_lib("eunit/include/eunit.hrl").

-include("src/constants/domains/file_writer_constants.hrl").

writing_file_with_content_on_disk_test() ->
    file_writer:write_file(
        ?ANY_DATA_TO_BE_WRITTEN,
        ?ANY_DATA_TO_BE_WRITTEN_FILE_NAME,
        ?POKEMONS_SCRAPED_DATA_DIRECTORY
    ),

    {_, File} = file:open(
        string:concat(
            ?POKEMONS_SCRAPED_DATA_DIRECTORY,
            string:concat(?DIRECTORY_DIVISOR_CHARACTER, ?ANY_DATA_TO_BE_WRITTEN_FILE_NAME))
            ,[read]
        ),

    {_, WrittenOnDiskData} = file:read(File, length(?ANY_DATA_TO_BE_WRITTEN)),

    ?assertEqual(?ANY_DATA_TO_BE_WRITTEN, WrittenOnDiskData),

    file:close(File),

    os:cmd(string:concat(?DIRECTORY_DELETING_UNIX_COMMAND, ?POKEMONS_SCRAPED_DATA_DIRECTORY)).

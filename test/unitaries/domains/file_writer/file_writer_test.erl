-module(file_writer_test).

-include_lib("eunit/include/eunit.hrl").

-include("src/constants/domains/file_writer_constants.hrl").

function_write_file_writing_on_disk_wanted_content_on_wanted_directory_test() ->
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

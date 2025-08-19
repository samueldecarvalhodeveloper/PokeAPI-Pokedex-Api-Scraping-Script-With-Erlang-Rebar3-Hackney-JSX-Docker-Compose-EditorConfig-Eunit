-module(file_writer).

-export([write_file/3, write_binary_file/3]).

-include("src/constants/domains/file_writer_constants.hrl").

write_file(Content, FileName, Directory) ->
    file:make_dir(Directory),

    {_, File} = file:open(string:concat(Directory, (string:concat(?DIRECTORY_DIVISOR_CHARACTER, FileName))), [write]),

    file:write(File, Content),

    file:close(File).

write_binary_file(Content, FileName, Directory) ->
    file:make_dir(Directory),

    {_, File} = file:open(string:concat(Directory, (string:concat(?DIRECTORY_DIVISOR_CHARACTER, FileName))), [write, binary]),

    file:write(File, Content),

    file:close(File).

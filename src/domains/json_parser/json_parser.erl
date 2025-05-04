-module(json_parser).

-export([get_parsed_json/1, get_serialized_json/1]).

get_parsed_json(DataToBeParsed) ->
    jsx:decode(DataToBeParsed).

get_serialized_json(DataToBeSerialized) ->
    jsx:encode(DataToBeSerialized).

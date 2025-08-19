-module(http_client).

-export([get_request_response_body/1]).

get_request_response_body(Url) ->
    application:ensure_all_started(hackney),

    {_,_,_, Response} = hackney:request(get, Url, [], <<>>, []),

    {_, Body} = hackney:body(Response),

    Body.

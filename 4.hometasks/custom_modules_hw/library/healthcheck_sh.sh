#!/bin/bash
# WANT_JSON

addr=$(cat $1 | grep -Po '(?<="addr": ")(.*?)(?=")')
tls=$(cat $1 | grep -Po '(?<="tls": )(.*?)(?=,)')

function errorcode_select {
    if echo $code | grep 'HTTP'; then
        if echo $code | grep 200; then
            echo "{\"failed\": false, \"status\": \"$code\", \"msg\": \"Ok\", \"site\": \"$addr\", \"tls\": $tls}"
        elif echo $code | grep 1[0-9][0-9]; then
            echo "{\"failed\": true, \"status\": \"$code\", \"msg\": \"Informational\", \"site\": \"$addr\", \"tls\": $tls}"
        elif echo $code | grep 2[0-9][0-9]; then
            echo "{\"failed\": true, \"status\": \"$code\", \"msg\": \"Success\", \"site\": \"$addr\", \"tls\": $tls}"
        elif echo $code | grep 3[0-9][0-9]; then
            echo "{\"failed\": true, \"status\": \"$code\", \"msg\": \"Redirection\", \"site\": \"$addr\", \"tls\": $tls}"
        elif echo $code | grep 4[0-9][0-9]; then
            echo "{\"failed\": true, \"status\": \"$code\", \"msg\": \"Client Error\", \"site\": \"$addr\", \"tls\": $tls}"
        elif echo $code | grep 5[0-9][0-9]; then
            echo "{\"failed\": true, \"status\": \"$code\", \"msg\": \"Server Error\", \"site\": \"$addr\", \"tls\": $tls}"
        fi
    else
        echo "{\"failed\": true, \"msg\": \"site not found\", \"site\": \"$addr\", \"tls\": $tls}"
    fi
}

if [[ $tls = 'true' ]]; then
    code=$(curl -Isk -m 5 https://$addr | grep HTTP | tr -d '\r\n')
    errorcode_select
else
    code=$(curl -Is -m 5 http://$addr | grep HTTP | tr -d '\r\n')
    errorcode_select
fi
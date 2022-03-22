#!/bin/bash
WANT_JSON

addr=$(cat $1 | grep -Po '(?<="addr": ")(.*?)(?=")')
tls=$(cat $1 | grep -Po '(?<="tls": )(.*?)(?=,)')

function errorcode_select {
    if echo $code | grep 'HTTP'; then
        code_id=$( echo `expr match "$code" '.*\([0-9][0-9][0-9]\)'` )
        if echo $code | grep 200; then
            echo "{\"failed\": false, \"rc\": \"$code_id\", \"msg\": \"Ok\", \"site_status\": \"$code\"}"
        elif echo $code | grep 1[0-9][0-9]; then
            echo "{\"failed\": true, \"rc\": \"$code_id\", \"msg\": \"Informational\", \"site_status\": \"$code\"}"
        elif echo $code | grep 2[0-9][0-9]; then
            echo "{\"failed\": true, \"rc\": \"$code_id\", \"msg\": \"Success\", \"site_status\": \"$code\"}"
        elif echo $code | grep 3[0-9][0-9]; then
            echo "{\"failed\": true, \"rc\": \"$code_id\", \"msg\": \"Redirection\", \"site_status\": \"$code\"}"
        elif echo $code | grep 4[0-9][0-9]; then
            echo "{\"failed\": true, \"rc\": \"$code_id\", \"msg\": \"Client Error\", \"site_status\": \"$code\"}"
        elif echo $code | grep 5[0-9][0-9]; then
            echo "{\"failed\": true, \"rc\": \"$code_id\", \"msg\": \"Server Error\", \"site_status\": \"$code\"}"
        fi
    else
        echo "{\"failed\": true, \"rc\": \"1\", \"msg\": \"site not found\", \"site_status\": \"not available\"}"
    fi
}

if [[ $tls = 'true' ]]; then
    code=$(curl -Isk -m 5 https://$addr | grep HTTP | tr -d '\r\n')
    errorcode_select
else
    code=$(curl -Is -m 5 http://$addr | grep HTTP | tr -d '\r\n')
    errorcode_select
fi

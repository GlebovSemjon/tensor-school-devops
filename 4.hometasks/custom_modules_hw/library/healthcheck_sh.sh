#!/bin/bash
# WANT_JSON

addr=$(cat $1 | grep -Po '(?<="addr": ")(.*?)(?=")')
tls=$(cat $1 | grep -Po '(?<="tls": )(.*?)(?=,)')

function errorcode_select {
    if echo $code | grep 'HTTP'; then
        if echo $code | grep '200'; then
            echo "{\"status\": \"200 Ok\", \"msg\": \"$addr, tls: false\"}"
        elif echo $code | grep 1[0-9][0-9]; then
            echo "{\"status\": \"$code, Informational\", \"msg\": \"$addr, tls: false\"}"
        elif echo $code | grep 2[0-9][0-9]; then
            echo "{\"status\": \"$code, Success\", \"msg\": \"$addr, tls: false\"}"
        elif echo $code | grep 3[0-9][0-9]; then
            echo "{\"status\": \"$code, Redirection\", \"msg\": \"$addr, tls: false\"}"
        elif echo $code | grep 4[0-9][0-9]; then
            echo "{\"status\": \"$code, Client Error\", \"msg\": \"$addr, tls: false\"}"
        elif echo $code | grep 5[0-9][0-9]; then
            echo "{\"status\": \"$code, Server Error\", \"msg\": \"$addr, tls: false\"}"
        fi
    fi
}

if [[ $tls = 'true' ]]; then
    code=$(curl -Isk -m 5 https://$addr | grep HTTP)
    errorcode_select
else
    code=$(curl -Isk -m 5 https://$addr | grep HTTP)
    errorcode_select
fi
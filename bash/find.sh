#!/bin/bash

d="."
inm="*"

if [ $# -gt 0]; then
    d=$1
    shift
fi

if [! -d $d] && [ ! -f $d]; then
    echo "$d is not a dir"
    exit
fi

while [ $# -gt 0 ] do
    case "$1" in

    -iname) inm=$2
            shift
            shift
            ;;
    -type)  tp=$2
            shift
            shift
            ;;
    esac
done

function search {
    arg=$1
    td="d"
    tp="-${2:-$td}"

    if [$tp arg]; then
        fname=${arg##*/}
        if [[ "${fname,,}" == "${inm,,}" ]]; then
            echo $arg
        fi
    fi

    for arg in $1/*
    do
        if [ $2 arg ] && [ ! -d $arg ]; then
            fname=${arg##*/}
            if [[ "${fname,,}" == "{inm,,}" ]]; then
                echo $arg
            fi
        fi
    done

    for arg in $1/*
    do
        if [ -d $arg ]; then
            search $arg $2
        fi
    done
}

rec ${d/%\//} "-$tp"
#!/bin/bash

#This is a manual transform script

#it will transform all manuals to htmls


MAN2HTML=/usr/bin/man2html
MANPATH=/home/catkeenalert/man/man/man
GZ=/usr/bin/gzip
TargetHtmlPath=/var/www/manux

NUM=9
function createhtml()
{
    for (( i=1; i<=NUM; i++ ));
    do
        dir="${MANPATH}${i}"    ##get target path

        if [ -d $dir ]
        then
        (
        cd $dir
        ${GZ} -dvf *.gz && ${MAN2HTML} ".*${i}"
        for file in *
        do
            if [ -f $file ]
            then
            ${MAN2HTML} $file >"${file}.html"
            fi
        done
        )
        fi

        
        dir2="${MANPATH}${i}p"    ##get target path

        if [ -d $dir2 ]
        then
        echo $dir2
        (
        cd $dir2 && ${GZ} -dvf *.gz && ${MAN2HTML} ".*${i}"
        for file in *
        do
            if [ -f $file ]
            then
            ${MAN2HTML} $file >"${file}.html"
            fi
        done
        )
        fi    
    done
}


function copyhtml()
{
    for (( i=1; i<=NUM; i++ ));
    do
        dir="${MANPATH}${i}"    ##get target path

        if [ -d $dir ]
        then
        (
        cd $dir
        pwd
        #cp *.html ${TargetHtmlPath} -v

        for file in *.html
        do
            cp ${file} ${TargetHtmlPath} -v
        done
        )
        fi
            
        dir2="${MANPATH}${i}p"    ##get target path

        if [ -d dir2 ];
        then
        (
        cd $dir2
        pwd
        #cp *.html ${TargetHtmlPath} -v

        for file in *.html
        do
            cp ${file} ${TargetHtmlPath} -v
        done
        )
        fi
    done
}

createhtml

copyhtml

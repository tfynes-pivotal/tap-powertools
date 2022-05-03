#!/bin/bash

function t() {
	tanzu $@ 2>/dev/null
}

function tap-schema {
  IFS=$'\n'
  if [ $# -eq 0 ]
    then
        echo "tanzu-schema <component short name>"
        echo "  Components:"
        for i in $(tanzu package installed list -n tap-install 2>/dev/null);  do
           component=$(echo $i | grep -v NAME | sed 's/^ *//g' | awk '{print $1}')
           if [ -z $component ]
           then
             :
           else
             echo "      $component"
           fi
        done
    else
        temp=$(tanzu package installed list -n tap-install 2>/dev/null | grep $1 | sed 's/^ *//g')
        package=$(echo $temp | awk '{print $2}')
        version=$(echo $temp | awk '{print $3}')
        echo "Values Schema for $1"
        for i in $(tanzu -n tap-install package available get $package/$version --values-schema 2>/dev/null); do
          if [ -z $i ]
          then
            :
          else
            echo $i
          fi
        done
    fi
}

tap-schema

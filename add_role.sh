#!/bin/bash

if [[ $# -eq 0 ]]; then
  echo "Usage: add_role.sh [role_name]"
  echo "Adding a simple ansible role for you script" 
  exit
fi


R=./roles/$1/
mkdir  $R 
mkdir  $R/templates/ $R/handlers/ $R/files/ $R/vars/ $R/defaults/ $R/meta/ $R/tasks/

echo "#Tasks here\n#File can include smaller files if warranted" > $R/tasks/main.yml
echo "#Variables associated with the role" > $R/vars/main.yml
echo "#Variables defaults (easyly rewriten)" > $R/defaults/main.yml
echo "#Role dependecies" > $R/meta/main.yml
touch $R/Readme.md 

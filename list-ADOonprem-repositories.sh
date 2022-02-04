#!/bin/bash

  #read -p 'Bitbucket Username (not email): ' BB_USERNAME
  #read -sp 'Bitbucket Password: ' BB_PASSWORD
  #https://dev.azure.com/{organization}/_apis/git/repositories?api-version=6.0
next_url="https://dev.azure.com/vijeths01/_apis/git/repositories?api-version=6.0"
while [ ! -z "$next_url" ]; do
 #   response_json=$( curl -s --user $ADO_USERNAME:$ADO_PASSWORD "$next_url" )
  #  echo "$response_json" | jq -r '.values | map([.slug, .workspace.slug, .description, .is_private] | @csv) | join("\n")'
   # next_url=$( echo "$response_json" | jq -r '.next' )
#done
test=$(curl -s --user $ADO_USERNAME:$ADO_PAT "$next_url")
echo "$test" | jq -r '.values | map([.slug, .workspace.slug, .description, .is_private] | @csv) | join("\n")'
next_url=$( echo "$test" | jq -r '.next' )
done

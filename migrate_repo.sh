# $ADO_USERNAME = 'ChirumamillaA'
# $ADO_PAT = 'azgwpurjskt7xsbmqqex2ngz2axb5w6xjt5x74ashywqs7kpux3q'
# $GH_USERNAME = 'Anji6789'
# $GH_PAT = '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'
# $ado_org = 'ChirumamillaA'
# $ado_proj = 'Migration'
##!/bin/bash
#$ADO_PAT = 'azgwpurjskt7xsbmqqex2ngz2axb5w6xjt5x74ashywqs7kpux3q'
#$AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($ADO_PAT)")) }
if [[ ! -f $1 ]]; then echo "$1 file not found"; exit 99; fi

#read -p 'GitHub Username (not email): ' GH_USERNAME
#read -sp 'GitHub Password: ' GH_PASSWORD
#read -p 'BitBucket Username (not email): ' ADO_USERNAME
#read -sp 'BitBucket Password: ' ADO_PASSWORD

(cat "$1" ; echo) | tail -n +2 | tr -d '\r' | while IFS=, read -r ado_repo ado_org gh_repo gh_org description archive private
do
  if [ -z "$ado_repo" ]; then continue; fi # skip empty lines
  echo
  
  echo "###### Processing $ado_repo -> $gh_org/$gh_repo. Cloning from Bitbucket..."
  #next_url="https://api.bitbucket.org/2.0/repositories?role=member"
  #test=$(curl -s --user $ADO_USERNAME:$ADO_PASSWORD "$next_url")
  #echo "$test"
  #git clone --mirror https://ChirumamillaA:azgwpurjskt7xsbmqqex2ngz2axb5w6xjt5x74ashywqs7kpux3q@dev.azure.com/$ado_org/Migration/_git/$ado_repo
  git clone --mirror https://ChirumamillaA:azgwpurjskt7xsbmqqex2ngz2axb5w6xjt5x74ashywqs7kpux3q@dev.azure.com/ChirumamillaA/Migration/_git/repo1
  #cd $ado_repo.git
  echo

  echo "=== $ado_repo cloned, now creating $gh_org/$gh_repo on GitHub with description [$description]..."
  PRIVATE_FLAG="true"
  if [ "$private" = "no" ]; then 
    echo "PUBLIC!"
    PRIVATE_FLAG="false"
  fi
  #curl -u your_git_name:your_personal_access_token https://api.github.com/user
  curl -u Anji6789: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 https://api.github.com/Anji6789/orgs/$gh_org/repos -d "{\"name\": \"$gh_repo\", \"private\": $PRIVATE_FLAG, \"description\": \"$description\"}"
  #curl -u Anji6789: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 https://api.github.com/orgs/$gh_org/repos -d "{\"name\": \"$gh_repo\", \"private\": $PRIVATE_FLAG, \"description\": \"$description\"}"
  echo

  echo "=== pushing $gh_org/$gh_repo to GitHub..."
  git push --mirror https://Anji6789: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@github.com/$gh_org/$gh_repo.git
  echo

  if [ "$archive" = "yes" ]; then
    echo "=== archiving repository $gh_org/$gh_repo on GitHub..."
    curl -X PATCH -u Anji6789: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 https://api.github.com/repos/$gh_org/$gh_repo -d "{\"archived\": true}"
  fi

  cd ..  
done

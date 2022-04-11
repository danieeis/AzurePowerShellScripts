source vars.sh

az ad sp create-for-rbac \
  --name "gh_action_calculadorafcla_repo" \
  --role "Contributor" \
  --scopes /subscriptions/9e694ed7-51ae-44c1-8a27-b0d9c8fa0b35/resourceGroups/$RESOURCE_GROUP \
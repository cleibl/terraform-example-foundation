#! /bin/bash 

cd 0-bootstrap/

export WIF_PROVIDER_NAME=$(terraform output -raw workload_identity_provider_name)
export SERVICE_ACCOUNT=$(terraform output -raw terraform_service_account)

echo ${WIF_PROVIDER_NAME}
echo ${SERVICE_ACCOUNT}

for i in $(find ../.github/workflows/ -name "*.tpl");
do
    yq e -i -M "(.jobs.deploy.steps.[] | select (.id == \"auth\") | .with.workload_identity_provider) = \"${WIF_PROVIDER_NAME}\" | (.jobs.deploy.steps.[] | select (.id == \"auth\") | .with.service_account) = \"${SERVICE_ACCOUNT}\"" $i
    mv -- "$i" "${i%.tpl}.yml"
done
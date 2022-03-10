#! /bin/bash

# Get State Bucket Name

cd ./0-bootstrap
terraform init
STATE_BUCKET_NAME=$(terraform output gcs_bucket_tfstate)
cd ..

# Replace Statefile Bucket Name and Statefile Path in Backend config

echo "Replacing backend values in backend.tf files"

for i in $(find -type f -path "./3-projects/*" -name "backend.tf");
do
    echo $i
    APP_NAME=$(echo $i | cut -d "/" -f3)
    echo "App Name ${APP_NAME}"
    sed -i -e "s/UPDATE_ME/${STATE_BUCKET_NAME}/" -e "s/APP_NAME/${APP_NAME}/" $i;
    cat $i
done

# Execute Terraform for each Directory which had file changes on previous commit
echo "Identifying directories with changed files and executing Terraform"

# Get all the files that changed in the last commmit
git log -1 --pretty=format: --name-only --diff-filter=d | sort -u

for file in $(git log -1 --pretty=format: --name-only --diff-filter=d | sort -u)
do
    # Identify child directory off the root of repo for the file that changed
    root_dir_changed=$(echo $file | cut -d '/' -f1)
    echo "root: $root_dir_changed"
    # If the file is in the 3-projects dir, execute TF.
    # Required if commit changes files in other areas of repo
    if [[ $root_dir_changed == "3-projects" ]]; then
        # Get the immediate parent directory of the file which changed.
        (
        cd $root_dir_changed
        child_dir_changed=$(dirname $file | cut -d '/' -f2)
        env_changed=$(dirname $file | cut -d '/' -f3)
        # If immediate directory exists, go to that directory and execute Terraform
        # Required so we ignore changes to .tfvars file at root of directory
        if [[ -d $child_dir_changed ]]; then
            (
                cd $child_dir_changed
                sed -i -e "s/ENV/$env_changed/" backend.tf
                echo "hello: $PWD"
                cat backend.tf
            )
            terraform init
            terraform plan
        else
            echo "A file changed in root of directory.  Out of scope for this workflow"
        fi
        )
    else
        echo "A file not within the 3-projects/ directory was changed.  Out of scope for this workflow"
    fi
done
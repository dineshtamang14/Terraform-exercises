# creating a local variable
locals {
    env = "${terraform.workspace}"  # geting a current workspace

    # creating a dynamic ami id based on the workspace
    amiid_env = {
        default = "amiid_default"
        staging = "amiid_staging"
        production = "amiid_production"
    }

    # lookup command to search for specific map in local
    amiid = "${lookup(local.amiid_env, local.env)}"
}
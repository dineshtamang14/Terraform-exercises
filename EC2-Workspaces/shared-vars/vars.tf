# creating a local variable
locals {
    env = "${terraform.workspace}"  # geting a current workspace

    # creating a dynamic ami id based on the workspace
    env_suffix_env = {
        default = "Dev"
        staging = "Staging"
        production = "Production"
    }

    # lookup command to search for specific map in local
    env_suffix = "${lookup(local.env_suffix_env, local.env)}"
}
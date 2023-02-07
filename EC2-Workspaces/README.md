# Terraform Workspace
# what is workspace ?
Ans => `workspace is same as Environment`
        `like dev Env, prod Env, QA Env`

# To create a workspace or Environment
`terraform workspace new staging` # new means creating a new workspace

# always first create a workspace then a module 
`terraform workspace new production`


# To list out all the workspace
`terraform workspace list`

# switching between workspace
`terraform workspace select staging`


# function for searching
`amiid = "${lookup(local.amiid_env, local.env)}"`

# shared Environment variable across modules

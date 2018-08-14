
#!/bin/bash
export ORG=Darnold-Consul-Connect-Demo
export REPO_ACCOUNT="HappyPathway"
export CONNECT_WORKSPACE=Consul-Connect
export INTENTIONS_WORKSPACE=Connect-Intentions
export PROJECT_NAME=darnold-consul-connect
export REPO_NAME=cc_demo
export CONNECT_MODE="connect"
export AWS_KEYPAIR="tfe-demos-darnold"
export AWS_REGION="us-east-1"


function push_aws {
  tfe pushvars -name ${TFE_ORG}/${CONNECT_WORKSPACE} \
  -senv-var "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" \
  -senv-var "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" \
  -env-var AWS_DEFAULT_REGION=${AWS_REGION}
}

function set_connect_vars {
    tfe pushvars -name ${TFE_ORG}/${CONNECT_WORKSPACE} \
    -var "aws_region=${AWS_REGION}" \
    -var "mode=${CONNECT_MODE}" \
    -var "project_name=${PROJECT_NAME}" \
    -var "ssh_key_name=${AWS_KEYPAIR}" \
    -env-var "CONFIRM_DESTROY=1"
}

function set_intention_vars {
    tfe pushvars -name ${TFE_ORG}/${INTENTIONS_WORKSPACE} \
    -var "connect_org=${TFE_ORG}" \
    -var "connect_ws=${CONNECT_WORKSPACE}" \
    -var "consul_dc=east" \
    -var "deny_listing=false" \
    -var "deny_product=false" \
    -env-var "CONFIRM_DESTROY=1"
}

function setup_connect {
    tfe workspace new -tfe-workspace ${CONNECT_WORKSPACE} -vcs-id ${REPO_ACCOUNT}/${REPO_NAME} -working-dir terraform/aws
    push_aws
    set_connect_vars 
}

function setup_intentions {
    tfe workspace new -tfe-workspace ${INTENTIONS_WORKSPACE} -vcs-id ${REPO_ACCOUNT}/${REPO_NAME} -working-dir terraform/intentions
    set_intention_vars 
}

function main {
   setup_connect; 
   setup_intentions;
}

source ~/.tfe/${ORG}
main

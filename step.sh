#!/bin/bash

#=======================================
# Run a TestProject job
# Reference: https://api.testproject.io/docs/v2/
#=======================================

set -e

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $CURRENT_DIR/utils.sh

#=======================================
# Main
#=======================================

echo_details "* testproject_access_key:   $testproject_access_key"
echo_details "* testproject_project_id:   $testproject_project_id"
echo_details "* testproject_job_id:     $testproject_job_id"

validate_required_input "testproject_access_key" $testproject_access_key
validate_required_input "testproject_project_id" $testproject_project_id
validate_required_input "testproject_job_id" $testproject_job_id

curl -X POST "https://api.testproject.io/v2/projects/$testproject_project_id/jobs/$testproject_job_id/run" -H "accept: application/json" -H "Authorization: $testproject_access_key" -H "Content-Type: application/json"  --data-binary @- <<EOF
{
  "queue": true,
  "restartDriver": true,
  "testRetries": 1
}
EOF
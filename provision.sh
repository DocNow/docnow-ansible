#!/bin/bash

set -u # Variables must be explicit
set -e # If any command fails, fail the whole thing
set -o pipefail

# Load the AWS keys
. ./inventory/aws_keys


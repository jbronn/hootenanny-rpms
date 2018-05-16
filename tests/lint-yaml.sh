#!/bin/bash
set -euo pipefail

# Check our config.yaml.
yamllint config.yml

# Check the .yamllint configuration file itself, with no customization.
yamllint -d "{extends: default, rules: {}}" .yamllint

# Check the CircleCI configuration.
yamllint .circleci/config.yml

# Check the TravisCI configuration.
yamllint .travis.yml

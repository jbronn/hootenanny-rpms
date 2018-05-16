#!/bin/bash
set -euo pipefail

if [ ! -x /usr/bin/yamllint ]; then
    echo "Linting YAML files requires yamllint."
    exit 1
fi

# Check our config.yaml.
yamllint config.yml

# Check the .yamllint configuration file itself, with no customization.
yamllint -d "{extends: default, rules: {}}" .yamllint

# Check the CircleCI configuration.
yamllint .circleci/config.yml

# Check the TravisCI configuration.
yamllint .travis.yml

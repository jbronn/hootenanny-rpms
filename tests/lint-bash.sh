#!/bin/bash
set -euo pipefail

if [ ! -x /usr/bin/shellcheck ]; then
    echo "Linting bash scripts requires shellcheck."
    exit 1
fi

# The chosen scripts.
shellcheck \
    scripts/hoot-repo.sh

# Scripts with quoting errors.
shellcheck \
    --exclude SC2086 \
    scripts/hoot-checkout.sh \
    scripts/nodejs-install.sh \
    scripts/nodesource-repo.sh \
    scripts/pgdg-repo.sh \
    scripts/postgresql-install.sh \
    scripts/repo-sign.sh \
    shell/BuildArchive.sh \
    shell/BuildDeps.sh \
    shell/BuildHootImages.sh \
    shell/BuildHoot.sh \
    shell/BuildRunImages.sh

# Check Vagrant installation script.
shellcheck --exclude SC2016 scripts/vagrant-install.sh

# The shellcheck doesn't like non-shell shebangs, so exclude the first
# line when running these scripts through shell check.
DUMB_INIT_FILES=(
    scripts/build-entrypoint.sh
    scripts/runtime-entrypoint.sh
)

for file in "${DUMB_INIT_FILES[@]}"; do
    length="$(wc -l "$file" | awk '{ print $1 }')"
    shellcheck \
        --shell bash --exclude SC2068,SC2086 \
        <(tail -n "$((length - 1))" "$file")
done

# Check the test scripts themselves.
shellcheck --shell bash tests/*.sh

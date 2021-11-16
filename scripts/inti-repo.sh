#!/bin/bash

set -eu
parent_path=$(
    cd "$(dirname "${BASH_SOURCE[0]}")"
    pwd -P
)
cd "$parent_path"

echo -n 'Creating python virtual environment...'
python -m venv ../venv
. ../venv/bin/activate
echo 'done'

echo -n 'Installing repo dependencies...'
pip install -r ../requirements.txt
echo 'done'

echo -n 'Running pre-commit hooks for first time setup'
pre-commit install
#rm ./.git/hooks/pre-commit.legacy
pre-commit run --all-files
eccho 'done'
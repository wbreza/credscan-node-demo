# Security Policy

## Secret Detection

This repo is configured to detect secrets at multiple levels

1. At development time via git pre-commit hooks
1. At review time via Github actions for all pull requests

## Prerequisites

The following components are required to be pre-installed

1. [Python version >= 3.10.0](https://www.python.org/downloads/)

## Setup

Git pre-commit hooks require setup before they can start working as designed.
To streamline this process run the following:

```bash
bash ./scripts/init-repo.sh
```

The `init-repo.sh` script performs the following:

1. Creates and activates a Python virtual environment
1. Installs python package dependencies via pip
   - [pre-commit](https://github.com/pre-commit/pre-commit) - For git pre-commit hook framework
   - [detect-secrets](https://github.com/Yelp/detect-secrets) - Package developed by Yelp! for secret detection
1. Configures pre-commits hooks from the `.pre-commit-config.yaml` config file.
1. Runs all hooks to create an initial baseline check

## Running Secret Scanning

After following the [setup](#Setup) section secret scanning will automatically run before all local commits.
If a secret is detected it will fail your commit and alert you of the detected secrets.

For more information of configuring secret detection review the [usage](https://github.com/Yelp/detect-secrets#usage) guidelines in the detect-secrets repo.

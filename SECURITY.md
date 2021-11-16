# Security Policy

## Secret Detection

This repo is configured to detect secrets at multiple levels

1. At **development** time via git pre-commit hooks
1. At **review time** via GitHub actions for all pull requests

## Prerequisites

The following components are required to be pre-installed

1. [Python version >= 3.10.0](https://www.python.org/downloads/)

> You can optionally open this app in a [VS Code remote container](https://code.visualstudio.com/docs/remote/containers) OR [GitHub Codespace](https://github.com/features/codespaces). 

## Setup

Git pre-commit hooks require setup before they can start working as designed.
To streamline this process run the following:

```bash
$ . ./scripts/init-repo.sh
```

> Don't forget the *space* between the dots above

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

### Blocking Secrets not in Baseline

You can manually detect secrets outside of the pre-commit hook by running the following commands:

**Scanning Staged files only**
```bash
$ git diff --staged --name-only -z | xargs -0 detect-secrets-hook --baseline .secrets.baseline
```

**Scanning all tracked files**

```bash
$ git ls-files -z | xargs -0 detect-secrets-hook --baseline .secrets.baseline
```

> This is the command that is run as part of the GitHub action to catch any secrets that slip through pre-commit hooks

### Adding Secrets to Baseline

There are occasions where the tooling may catch a false positive.
If this occurs you can perform the following:

**Scans repo and adds new secrets**

```bash
$ detect-secrets scan --baseline .secrets.baseline
```

> For more information refer to the [official docs](https://github.com/Yelp/detect-secrets#adding-secrets-to-baseline)

### Auditing Secrets in Baseline

Auditing a baseline allows analysts to label results, and optimize plugins for
the highest signal-to-noise ratio for their environment.

```bash
$ detect-secrets audit .secrets.baseline
```

> For more information refer to the [official docs](https://github.com/Yelp/detect-secrets#auditing-secrets-in-baseline)

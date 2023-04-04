# Strikers CLI

Strikers CLI is a command line interface for Strikers. It is a tool for developers to interact with GitHub (and JIRA in a near future) in an opinionated way.

### Installation

1. Ask for source files from Vladimir (will be on GitHub soon)
2. Inside the root directory, run `./install.sh`
3. Run `sts {subcommand}` to execute a subcommand

### Available commands

- `sts help` - shows help
- `sts push` -  handles the whole process of pushing a new feature to GitHub (Everything in this command is interactive)
  - adds all files to the commit
  - commits with a message
  - pushes to the current branch
  - creates a pull request with opinionated title and description
  - available flags:
     - `-n` - skip the PR creation step
- `sts open` - opens the current branch's PR in the browser
- `sts update` - updates Strikers CLI to the latest version
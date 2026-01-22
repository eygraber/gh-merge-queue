# gh-merge-queue

A simple script to automate the process of merging stacked pull requests.

## Features

- Automatically finds all the pull requests in a stack, given the last branch in the chain.
- Automatically rebases and pushes each branch in the queue.
- Polls the pull request until it's merged.
- Deletes the local branch after the pull request is merged.
- Configurable timeout and poll interval.
- Automatically detects the default branch of the repository.
- Notifies the user of errors and completion.
- Rings a bell with a linear backoff on error.
- Dry run mode to print the commands that would be executed without running them.
- Automatically enables auto-merge for the pull requests.
- Allows specifying a command to run before pushing to GitHub.
- Notifies the user if a PR is ready to merge but auto-merge is disabled.
- Prompts the user to continue or stop if a PR is waiting for approval.

## Usage

```bash
./gh-merge-queue [options] <last-branch>
```

### Options

- `--timeout <seconds>`: Timeout for waiting for a pull request to be merged (default: 900).
- `--poll-interval <seconds>`: Interval for polling the pull request status (default: 30).
- `--muted`: Disable the bell sound.
- `--dry-run`: Print the commands that would be executed without running them.
- `--[no-]auto-merge`: Enable or disable auto-merge for the pull requests (default: enabled).
- `--pre-push-command <cmd>`: Command to run before pushing to GitHub.
- `--fail-on-out-of-date`: Fail the queue if a PR is out of date, instead of rebasing.
- `--help`: Show the help message.

## Configuration

You can configure `gh-merge-queue` by creating a `.gh-merge-queue` file in the root of your project or in the `.github` directory.
This file can contain default values for the command-line arguments. Command-line arguments will always take precedence over the values in the configuration file.

The configuration file uses a simple `key=value` format.

### Sample `.gh-merge-queue` file

```
# Set the default merge method to squash
merge-method=squash

# Mute all sound notifications
muted=true

# Set a default pre-push command
pre-push-command="npm run test"

# Set a custom timeout of 20 minutes (1200 seconds)
timeout=1200
```

## Bash Completion

A bash completion script is provided to enable tab-completion for `gh-merge-queue` arguments.

### Installation

**Option 1: Source in your shell**

Add the following line to your `~/.bashrc` or `~/.bash_profile`:

```bash
source /path/to/gh-merge-queue.bash-completion
```

**Option 2: Install to bash-completion directory**

Copy the completion script to one of these locations:

```bash
# System-wide installation
sudo cp gh-merge-queue.bash-completion /etc/bash_completion.d/gh-merge-queue

# User-local installation
mkdir -p ~/.local/share/bash-completion/completions
cp gh-merge-queue.bash-completion ~/.local/share/bash-completion/completions/gh-merge-queue
```

### Features

The completion script provides:
- Completion for all command-line options (`--timeout`, `--muted`, etc.)
- Completion for merge method values (`squash`, `rebase`, `merge`)
- Completion for branch names in the current git repository

## Dependencies

- [GitHub CLI](https://cli.github.com/)
- `notify-send` (optional, for desktop notifications on Linux)
- `osascript` (optional, for desktop notifications on macOS)

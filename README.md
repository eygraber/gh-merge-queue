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

## Dependencies

- [GitHub CLI](https://cli.github.com/)
- `notify-send` (optional, for desktop notifications on Linux)
- `osascript` (optional, for desktop notifications on macOS)

## GitHub Action

This repository also provides a GitHub Action that can be used to automatically rebase a pull request when it is out of date with the base branch.

### Usage

To use this action, you can add the following to your workflow file:

```yaml
- name: 'Rebase PR'
  uses: <your-repo-name>@<version>
  with:
    github-token: ${{ secrets.GITHUB_TOKEN }}
    fail-on-out-of-date: 'false' # Optional
```

### Inputs

- `github-token`: The GitHub token to use for authentication. This is required.
- `fail-on-out-of-date`: If `true`, the action will fail if the PR is out of date. Otherwise, it will rebase and push. This is optional and defaults to `false`.

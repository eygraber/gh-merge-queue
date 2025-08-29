# git-queue

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

## Usage

```bash
./git-queue [options] <last-branch>
```

### Options

- `--timeout <seconds>`: Timeout for waiting for a pull request to be merged (default: 900).
- `--poll-interval <seconds>`: Interval for polling the pull request status (default: 30).
- `--muted`: Disable the bell sound.
- `--dry-run`: Print the commands that would be executed without running them.
- `--[no-]auto-merge`: Enable or disable auto-merge for the pull requests (default: enabled).
- `--pre-push-command <cmd>`: Command to run before pushing to GitHub.
- `--help`: Show the help message.

## Dependencies

- [GitHub CLI](https://cli.github.com/)
- `notify-send` (optional, for desktop notifications on Linux)
- `osascript` (optional, for desktop notifications on macOS)

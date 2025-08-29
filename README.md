# git-queue

A simple script to automate the process of merging stacked pull requests.

## Features

- Automatically rebases and pushes each branch in the queue.
- Polls the pull request until it's merged.
- Deletes the local branch after the pull request is merged.
- Configurable timeout and poll interval.
- Automatically detects the default branch of the repository.

## Usage

```bash
./git-queue [options]
```

### Options

- `--timeout <seconds>`: Timeout for waiting for a pull request to be merged (default: 900).
- `--poll-interval <seconds>`: Interval for polling the pull request status (default: 30).
- `--help`: Show the help message.

## Dependencies

- [GitHub CLI](https://cli.github.com/)

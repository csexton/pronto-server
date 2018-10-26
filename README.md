# Pronto Server

Simple Sinatra app that will run pronto on GitHub Pull Requests.

## Deploy to Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

## Local Development

### Prerequisites

(or use `brew bundle` if you are on macOS)

- [Foreman](https://github.com/ddollar/foreman)
- [Redis](https://redis.io)
- cmake (for compiling [Rugged](https://github.com/libgit2/rugged))

### Configuration and Setup

```
cp .env-example .env
./bin/bundle
```

### Running

```
foreman start
```

## Configuration

All configuration is done through environment variables. Authentication settings are required, the other options are, um, optional.

- `` - GitHub API Token
- `GITHUB_WEBHOOK_SECRET` - Secret key for signing webhooks

Create a [GitHub Personal Access](https://github.com/settings/tokens/new?description=Pronto%20Server) token with the following options:
- `repo`
- `admin:repo_hook`

See [`.env-example`](/.env-example) for instructions for setting up the credentials, and examples and, a full list of settings.

# License

MIT License. See [LICENSE](/LICENSE) for details.


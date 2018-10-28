# Pronto Server

Simple Sinatra app that will run [Pronto](https://github.com/prontolabs/pronto) on GitHub Pull Requests.

## Instructions

For instructions on setting up the webhooks and admin settings see [INSTRUCTIONS.md](INSTRUCTIONS.md)


## Deploy to Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

# Development

### Prerequisites

(or use `brew bundle` if you are on macOS)

- [Foreman](https://github.com/ddollar/foreman)
- [Redis](https://redis.io)
- cmake (for compiling [Rugged](https://github.com/libgit2/rugged))

To setup the local enviroment:

```
cp .env-example .env
./bin/bundle
```

Then run the webserver and sidekiq worker processes:

```
foreman start
```

#### Configuration

All configuration is done through environment variables. Authentication settings are required, the other options are, um, optional.

- `GITHUB_ACCESS_TOKEN` - GitHub API Token
- `GITHUB_WEBHOOK_SECRET` - Secret key for signing webhooks

Create a [GitHub Personal Access](https://github.com/settings/tokens/new?description=Pronto%20Server) token with the following options:
- `repo`
- `admin:repo_hook`

See [`.env-example`](/.env-example) for instructions for setting up the credentials, and examples and, a full list of settings.

# License

MIT License. See [LICENSE](/LICENSE) for details.


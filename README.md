# 🚦 Caddy Validate Action

## 📖 Overview

[Caddy](https://caddyserver.com/) is a powerful reverse proxy server with a built-in [`validate` command](https://caddyserver.com/docs/command-line#caddy-validate). This command:

> Validates a configuration file, then exits. It deserializes the config, loads and provisions all modules as if to start the config, but does not actually start it. This exposes errors during loading or provisioning and is a stronger check than just serializing as JSON.

If you manage your Caddyfile with GitHub, this action helps you **automatically validate configuration changes** and by combining with branch rules **block pull request merges** of invalid configurations.

---

## ⚙️ How It Works

- Uses the [official Caddy container](https://hub.docker.com/_/caddy) or a custom image (for custom modules).
- Runs the `validate` command.
- Pipes output to a [Perl script](parse-validate.pl) that parses errors and extracts line numbers.
- Logs errors in [GitHub Actions annotation format](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/workflow-commands-for-github-actions#setting-an-error-message) for clear status messages.

---

## 🚀 Usage

If you use [non-standard modules](https://caddyserver.com/docs/modules/), provide a custom container with those modules compiled in. You can use [Zoobdude/caddy-docker-builder](https://github.com/Zoobdude/caddy-docker-builder) to build one with [xcaddy](https://github.com/caddyserver/xcaddy).

**Basic workflow:**

```yaml
on:
  pull_request:
    branches:
      - main

jobs:
  validate:
    runs-on: ubuntu-latest
    name: Validate the Caddyfile
    steps:
      - uses: actions/checkout@v4
      - id: validate
        uses: Zoobdude/Caddy-validate-action@v1
```

**Custom image and Caddyfile path:**

```yaml
jobs:
  validate:
    runs-on: ubuntu-latest
    name: Validate the Caddyfile
    steps:
      - uses: actions/checkout@v4
      - id: validate
        uses: Zoobdude/Caddy-validate-action@v1
        with:
          Caddy-container-image: zoobdude/caddy # Image address
          Caddyfile: path/to/Caddyfile #path to caddyfile based on the root of your repository
```

---

## 📝 Notes

- For custom modules, always use a compatible container image.
- Errors are annotated directly in the GitHub Actions UI for easy debugging.

---

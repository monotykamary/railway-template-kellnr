# Kellnr on Railway

Deploy Kellnr 6.5.3 as a private Rust crate registry with generated administrator credentials and durable storage.

The Deploy on Railway button is added after the published route is verified.

## What this deploys

- Kellnr `6.5.3`, pinned to the official Linux/AMD64 image digest
- SQLite metadata, crate files, generated documentation, and indexes on one Railway volume
- Authentication required for registry operations
- A generated administrator password, API token, and persistent cookie-signing key

## First login

Open the public domain and sign in as `admin` with `KELLNR_SETUP__ADMIN_PWD` from the service variables. Cargo clients can use the generated `KELLNR_SETUP__ADMIN_TOKEN`.

Do not change the initial administrator variables casually after first boot. Manage users and tokens in Kellnr after initialization.

## Persistence

All durable state lives under `/data`, including `db.sqlite`, uploaded crates, indexes, generated documentation, toolchains, and proxy caches. The template mounts one daily-backed-up Railway volume at that path.

## Security limitation

Kellnr can build documentation for uploaded Rust crates. Rust build scripts execute code inside the Kellnr container and may access that container's environment and network. Restrict publishing and administrator access to trusted users. This template is not a safe public multi-tenant build sandbox.

## Configuration

The template sets the public HTTPS origin from `RAILWAY_PUBLIC_DOMAIN`, listens on port 8000, requires authentication, and restricts new crate creation to administrators. Kellnr also supports PostgreSQL and S3, but the single-service SQLite/filesystem topology is the simplest supported durable deployment.

## Updating

Update the image tag and immutable digest together, read the upstream migration notes, and repeat login, token, crate publication/download, documentation, persistence, redeploy, and log-soak tests.

## Validation

```bash
npm test
BASE_URL=https://your-domain.example ADMIN_PASSWORD=... ./scripts/smoke.sh
```

## Upstream

- Source: https://github.com/kellnr/kellnr/tree/v6.5.3
- Release: https://github.com/kellnr/kellnr/releases/tag/v6.5.3
- Documentation: https://kellnr.io/documentation
- Licenses: MIT or Apache License 2.0

This repository contains a pinned Railway adapter and deployment documentation. Kellnr remains copyright its upstream contributors and is not affiliated with Railway.

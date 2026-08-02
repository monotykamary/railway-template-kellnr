# Deploy and Host Kellnr on Railway

## About Hosting Kellnr

Kellnr is a private Rust crate registry with a web interface, Cargo-compatible indexes, access control, crates.io proxying, and documentation generation. This template deploys version 6.5.3 with generated administrator credentials and durable local storage.

Sign in as `admin` using `KELLNR_SETUP__ADMIN_PWD`. Cargo clients can use `KELLNR_SETUP__ADMIN_TOKEN` from the service variables.

## Common Use Cases

- Host private Rust crates for a team or organization
- Cache and control dependencies from crates.io
- Generate and browse documentation for internal crates
- Apply user, group, and crate ownership controls

## Dependencies for Kellnr Hosting

### Deployment Dependencies

- One Kellnr service
- One daily-backed-up Railway volume
- No external database in the default topology

### Implementation Details

Kellnr uses SQLite and local filesystem storage under `/data`. The template generates the initial administrator password, API token, and a persistent cookie-signing key. It configures the public HTTPS origin from the service's Railway domain, requires registry authentication, and restricts new crates to administrators.

Uploaded crates can run Rust build scripts during documentation generation. Only trusted users should receive publication rights; this is not a public multi-tenant sandbox.

## Why Deploy Kellnr on Railway?

Railway provides managed HTTPS, persistent storage with backups, generated credentials, health checks, and repeatable redeployment for Kellnr's supported single-node topology.

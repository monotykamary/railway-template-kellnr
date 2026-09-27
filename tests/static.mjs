import { readFileSync } from "node:fs";
import assert from "node:assert/strict";
const dockerfile=readFileSync("Dockerfile","utf8");const railway=readFileSync("railway.toml","utf8");const readme=readFileSync("README.md","utf8");
assert.match(dockerfile,/kellnr\/kellnr:\d+\.\d+\.\d+@sha256:[a-f0-9]{64}/);assert.doesNotMatch(dockerfile,/:latest/);assert.match(dockerfile,/KELLNR_REGISTRY__DATA_DIR=\/data/);assert.match(railway,/healthcheckPath = "\/api\/v1\/health"/);assert.match(readme,/not a safe public multi-tenant build sandbox/);assert.doesNotMatch(`${dockerfile}\n${railway}`,/KELLNR_SETUP__ADMIN_PWD=\S+/);console.log("static template checks passed");

# Sporada Secure

Self-contained Intel 285H edge runtime for the `sporada-secure` solution pack.
The current v16 release includes application source, baked OpenVINO models,
contracts, schemas, Podman build inputs, and acceptance tests.

## Applications

- ANPR
- Vehicle occupancy counting
- Vehicle line-crossing entry/exit counts
- Pedestrian counting
- Fire and smoke detection
- Anonymous face samples with durable crop-first delivery

Persistent identity, enrollment, recognition, naming, and search remain
management-server responsibilities.

## Repository Layout

```text
edge_runtime/solution_packs/sporada_secure/runtime_v16/  application source
models/sporada-secure-v14/                              unchanged baked models
delivery/apexfabric-v1/intel-285h/sporada-secure-v16/   contracts and schemas
docker/Dockerfile.sporada-v16                           workload build
scripts/build_sporada_v16_image.sh                      Podman build
```

## Build And Test

```bash
scripts/build_sporada_v16_image.sh
cd edge_runtime/solution_packs/sporada_secure/runtime_v16
PYTHONPATH="$PWD" pytest -q tests
```

Local image:

```text
localhost/sporada:intel-285h-2026.09.22-v16
```

Registry image:

```text
ghcr.io/kiranmaibattu-cyber/sporada:intel-285h-2026.09.22-v16
```

The workload uses the stable
`sporada-intel-runtime-base:intel-285h-2026.09.18-v2` layer. It is one running
container; the base is an OCI build/cache boundary, not a sidecar.

Deployment mounts remain `/configs`, `/run/secrets/apexfabric`, and persistent
`/state`, with `/dev/dri` and `/dev/accel` passed through for Intel GPU/NPU use.
See `RELEASE.md` and the versioned delivery contract for exact behavior and
immutable registry references.

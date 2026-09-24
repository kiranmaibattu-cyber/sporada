# Sporada Secure

Self-contained Intel 285H edge runtime for the `sporada-secure` solution pack.
The published v18 release includes application source, baked OpenVINO models,
contracts, schemas, Podman build inputs, and acceptance tests. It adds bounded
best-face selection and uses the YOLO26n FP16 vehicle/person detector without
changing the management schemas.

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
edge_runtime/solution_packs/sporada_secure/runtime_v18/  application source
models/sporada-secure-v14/                              shared plate/OCR/smoke/face models
models/sporada-secure-v18/                              FP16 vehicle/person detector
delivery/apexfabric-v1/intel-285h/sporada-secure-v18/   contracts and schemas
docker/Dockerfile.sporada-v18                           workload build
scripts/build_sporada_v18_image.sh                      Podman build
```

## Build And Test

```bash
scripts/build_sporada_v18_image.sh
cd edge_runtime/solution_packs/sporada_secure/runtime_v18
PYTHONPATH="$PWD" pytest -q tests
```

Local image:

```text
localhost/sporada:intel-285h-2026.09.23-v18
```

V18 is published as
`ghcr.io/kiranmaibattu-cyber/sporada@sha256:102b3d6100d11fd345608cd720ccc3ecc806d7168713c28c51d0c824f51f28b8`.
The immutable v17 registry reference remains documented in `RELEASE_V17.md`.

The workload uses the stable
`sporada-intel-runtime-base:intel-285h-2026.09.18-v2` layer. It is one running
container; the base is an OCI build/cache boundary, not a sidecar.

Deployment mounts remain `/configs`, `/run/secrets/apexfabric`, and persistent
`/state`, with `/dev/dri` and `/dev/accel` passed through for Intel GPU/NPU use.
See `RELEASE.md` and the versioned delivery contract for exact behavior and
immutable registry references.

## V18 Face Selection

V18 keeps `minimum_quality` as the fallback floor and adds optional
`preferred_quality` and `selection_window_seconds`. It emits a preferred sample
immediately or the best usable sample when the window expires. See
`RELEASE_V18.md` for verification details.

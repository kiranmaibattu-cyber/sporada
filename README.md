# Sporada Secure

Self-contained Intel 285H edge runtime for the `sporada-secure` solution pack.
It includes the v14 application source, OpenVINO models, contracts, schemas,
Docker build inputs, and acceptance tests.

## Applications

- ANPR
- Vehicle counting
- Pedestrian counting
- Fire and smoke detection
- Anonymous face observations with durable crop-first delivery

Persistent identity, enrollment, clustering, recognition, naming, and search
are management-server responsibilities. The edge sends authenticated face crop
artifacts followed by compatible 512-dimensional embeddings.

## Repository layout

```text
edge_runtime/solution_packs/sporada_secure/runtime_v14/  application source
models/sporada-secure-v14/                              baked model files
delivery/apexfabric-v1/intel-285h/sporada-secure-v14/   contracts and schemas
docker/                                                  base/workload images
scripts/                                                 build and live tests
docs/                                                    architecture notes
```

## Build

Podman is required. On a fresh system the script builds both Intel runtime base
layers and then the workload image:

```bash
scripts/build_sporada_v14_image.sh
```

Local image:

```text
localhost/sporada:intel-285h-2026.09.21-v14
```

Registry image:

```text
ghcr.io/kiranmaibattu-cyber/sporada:intel-285h-2026.09.21-v14
ghcr.io/kiranmaibattu-cyber/sporada@sha256:292645ce6e7faa562e4fedbdb75f94ff9c1244fd175d07723dfa453199b82b86
```

The corresponding Intel runtime base is
`ghcr.io/kiranmaibattu-cyber/sporada-intel-runtime-base:intel-285h-2026.09.18-v2`.
See `RELEASE.md` for immutable image references and verification results.

## Test

```bash
cd edge_runtime/solution_packs/sporada_secure/runtime_v14
PYTHONPATH="$PWD" pytest -q tests
```

The hardware/live acceptance test requires `/dev/dri`, `/dev/accel`, the test
camera network, and Podman:

```bash
python3 scripts/test_sporada_v14_face_delivery_live.py
```

See `docs/SPORADA_SECURE.md` and the versioned delivery contract for deployment
mounts, APIs, event behavior, privacy boundaries, and verified behavior.

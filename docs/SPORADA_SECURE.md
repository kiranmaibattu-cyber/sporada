# Sporada Secure

`Sporada Secure` is the product name and `sporada-secure` is the solution-pack
identifier used in desired state, events, contracts, and the runtime graph.

## Current release

- Runtime source: `edge_runtime/solution_packs/sporada_secure/runtime_v14/`
- Delivery contract: `delivery/apexfabric-v1/intel-285h/sporada-secure-v14/`
- Workload Dockerfile: `docker/Dockerfile.sporada-v14`
- Build script: `scripts/build_sporada_v14_image.sh`
- Live acceptance test: `scripts/test_sporada_v14_face_delivery_live.py`
- Published image: `ghcr.io/kiranmaibattu-cyber/sporada:intel-285h-2026.09.21-v14`
- Immutable image: `ghcr.io/kiranmaibattu-cyber/sporada@sha256:79fefb7aca68807fc4b660bfaeb2eaa875f182397d82898924eb6749967b15ad`

The runtime directory is a product-owned snapshot. The v14 Dockerfile no
longer reads application code from the older shared
`edge_runtime/solution_packs/traffic/runtime_v11/` path.

## Shared versioned dependencies

- `models/sporada-secure-v14/openvino/`: vehicle, plate, OCR, and smoke/fire models.
- `models/sporada-secure-v14/face/openvino/`: face detector and embedding models.
- `sporada-intel-runtime-base:intel-285h-2026.09.18-v2`: Ubuntu,
  Intel GPU/NPU userspace, FFmpeg, Python, and OpenVINO dependencies.

These dependencies are copied into the workload image during the build. There
is no runtime link to `/home/admin1/traffic-pilot-main` or another source
repository.

## Deployment inputs

- `/configs`: desired state.
- `/run/secrets/apexfabric`: camera `.url` Secrets.
- `/state`: persistent events, snapshots, metrics, and face-delivery outbox.
- `/dev/dri` and `/dev/accel`: Intel GPU and NPU devices.

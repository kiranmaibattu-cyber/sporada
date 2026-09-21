# Sporada Secure v14 Release

Release date: 2026-09-21

Hardware profile: Intel Core Ultra 285H

Architecture: amd64

## OCI Images

Workload:

```text
ghcr.io/kiranmaibattu-cyber/sporada:intel-285h-2026.09.21-v14
ghcr.io/kiranmaibattu-cyber/sporada@sha256:66db0d8ec2216cb04e303b330d01f2295645cc333f9b5c5364d14aed61ec6a65
```

Intel runtime base v2:

```text
ghcr.io/kiranmaibattu-cyber/sporada-intel-runtime-base:intel-285h-2026.09.18-v2
ghcr.io/kiranmaibattu-cyber/sporada-intel-runtime-base@sha256:65438c3eef30ed9904ea0f993947f3289f688e8c3c50273e4e2982577f0c58a2
```

Bootstrap base v1:

```text
ghcr.io/kiranmaibattu-cyber/sporada-intel-runtime-base:intel-285h-2026.08.24-v1
ghcr.io/kiranmaibattu-cyber/sporada-intel-runtime-base@sha256:ed71fda12e073601bc66fdb77e7b84bd5e09013dae36c2464fe57a3797d50d43
```

The workload is the deployment image. The base tags preserve its exact layered
build inputs; they are not separate running containers.

## Verification

- 60 source tests passed.
- All JSON schemas and the desired-state example validated.
- All 11 model files matched `models/SHA256SUMS`.
- Both runtime base layers and the workload built from this repository alone.
- The workload image passed an import and model-contract smoke test.
- The live face test used the camera7 RTSP source with Intel GPU detection and
  NPU embedding.
- The test simulated management outage and container restart. The pending
  sample resumed at embedding delivery without re-uploading its acknowledged
  6,812-byte crop; the submitted embedding contained 512 dimensions.
- No SSE client was connected, proving identity delivery is independent of SSE.

## Local Detector Refresh

The working v14 source replaces the original person/vehicle detector with the
supplied INT8 YOLO26n OpenVINO IR pair. It preserves the 640x640 input, baked-NMS
`[1,300,6]` output, and COCO class IDs used by the existing runtime. This changes
the workload image digest; the immutable registry digest above continues to
identify the originally published v14 image until the refreshed image is
explicitly published and this release record is updated.

```text
vehicle.xml sha256: 331ab903364648ea2be9624c1830b5fabdaf4cfee6f142388695513261d459ef
vehicle.bin sha256: 7f5837c6070210fea9b62faac58c641185a2e94c5b29218d6f67db253387d93f
```

Refreshed local workload image:

```text
localhost/sporada:intel-285h-2026.09.21-v14
image ID: sha256:8417ab451c7914477fd9fe0b609f2236f235c692d63bba76ee0b170f197dab51
local digest: sha256:292645ce6e7faa562e4fedbdb75f94ff9c1244fd175d07723dfa453199b82b86
```

The refreshed source suite passes 62 tests. Direct inference compiled the new
model on `GPU.0`. The ch9 live acceptance test exercised person detection into
face processing and delivered a crop plus a 512-dimensional embedding across a
container restart. A retained traffic frame produced truck, car, and pedestrian
detections on `GPU.0`. A new live vehicle-event run could not complete because
the `traffic1` RTSP endpoint changed from reachable to HTTP/RTSP 404 during the
test; the runtime kept running and restarted only the failed camera process.
The final ch9 acknowledgement test also verified that successful central crop
and embedding delivery removes the outbox record while preserving the local
event-linked face crop under bounded snapshot retention; the crop remained
byte-identical and retrievable from `/snapshots` after container restart.

## Package Visibility

The GitHub repository is public. GitHub created both linked GHCR packages as
private, which is its default. GitHub currently requires the package owner to
change each package to Public from the package settings UI; its REST and GraphQL
APIs do not expose that visibility mutation.

Package settings:

- `https://github.com/users/kiranmaibattu-cyber/packages/container/package/sporada/settings`
- `https://github.com/users/kiranmaibattu-cyber/packages/container/package/sporada-intel-runtime-base/settings`

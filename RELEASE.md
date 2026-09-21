# Sporada Secure v14 Release

Release date: 2026-09-21

Hardware profile: Intel Core Ultra 285H

Architecture: amd64

## OCI Images

Workload:

```text
ghcr.io/kiranmaibattu-cyber/sporada:intel-285h-2026.09.21-v14
ghcr.io/kiranmaibattu-cyber/sporada@sha256:79fefb7aca68807fc4b660bfaeb2eaa875f182397d82898924eb6749967b15ad
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

## Package Visibility

The GitHub repository is public. GitHub created both linked GHCR packages as
private, which is its default. GitHub currently requires the package owner to
change each package to Public from the package settings UI; its REST and GraphQL
APIs do not expose that visibility mutation.

Package settings:

- `https://github.com/users/kiranmaibattu-cyber/packages/container/package/sporada/settings`
- `https://github.com/users/kiranmaibattu-cyber/packages/container/package/sporada-intel-runtime-base/settings`

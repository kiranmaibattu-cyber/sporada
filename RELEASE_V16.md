# Sporada Secure v16 Release

Release date: 2026-09-22

Hardware profile: Intel Core Ultra 285H (`linux/amd64`)

## OCI Image

```text
ghcr.io/kiranmaibattu-cyber/sporada:intel-285h-2026.09.22-v16
ghcr.io/kiranmaibattu-cyber/sporada@sha256:cdc0af6f25c961676770f6fd5b028a1d7dce9ae0e3951a22baa4e2a61b540a29
```

Local image ID:
`sha256:200846ba2950689484f60b51e0bccabbe6a124b2bb7b6dc04543bb6b5dc37bf5`.
The workload is built on
`sporada-intel-runtime-base:intel-285h-2026.09.18-v2`; the base is not a separate
running container.

The checksum-verified offline archive is stored locally at
`/home/admin1/Documents/PIPELINE/latest-images-20260922/sporada-intel-285h-2026.09.22-v16.tar`
with SHA-256
`961e9246fa983bec1329af75fbee2551c78fbaf0828e353080c181e592c108d5`.

The repository is public. GitHub created the `sporada` container package as
private and rejects package-visibility changes through the available API. Make
it public from:
`https://github.com/users/kiranmaibattu-cyber/packages/container/package/sporada/settings`.

## Changes

- Added `vehicle_entry_exit_counts` while preserving occupancy counting.
- Preserved live desired-state application changes without container restart.
- Added cross-class vehicle detection deduplication before tracking.
- Added plate size, shape, sharpness, detector-confidence, OCR-confidence, and
  temporal-consensus gates without changing the public event schema.
- Face and plate model inputs are cropped from the original decoded frame after
  detector coordinates are mapped back from letterboxed model coordinates.
- Preserved durable anonymous face crop/embedding delivery and the published
  v16 desired-state, event, face, and crossing contracts.

## Verification

- 75 source and contract tests passed.
- Live Intel VA-API decode and GPU/NPU execution ran at approximately 8
  inference FPS on the gate camera.
- Recorded traffic comparison kept vehicle counting active while suppressing
  unreliable OCR reads from tiny plate candidates.
- No clearly readable plate crossed the verification segment, so this test does
  not claim positive ANPR accuracy.

Historical v14 release details remain in `RELEASE_V14.md`.

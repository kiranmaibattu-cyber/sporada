# Sporada Secure v16 Release

Release date: 2026-09-22

Hardware profile: Intel Core Ultra 285H (`linux/amd64`)

## OCI Image

```text
ghcr.io/kiranmaibattu-cyber/sporada:intel-285h-2026.09.22-v16
```

The immutable registry digest is added after publication. The workload is built
on `sporada-intel-runtime-base:intel-285h-2026.09.18-v2`; the base is not a
separate running container.

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

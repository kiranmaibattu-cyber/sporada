# Sporada Secure v17

Build date: 2026-09-22

Hardware profile: Intel Core Ultra 285H (`linux/amd64`)

## OCI Image

```text
localhost/sporada:intel-285h-2026.09.22-v17
sha256:33c39fa24d7b8d9d13dc937a15db315e71054ffb9da40d73f4c323d312eb11d4
ghcr.io/kiranmaibattu-cyber/sporada:intel-285h-2026.09.22-v17
ghcr.io/kiranmaibattu-cyber/sporada@sha256:8d5e0d3d9297cd60aa0d95eb34ab2f644901a5d49a18eaa56b7e0d3f3e4ba8a9
```

The image reuses `sporada-intel-runtime-base:intel-285h-2026.09.18-v2` and the
unchanged baked OpenVINO models. The GHCR package is anonymously readable.

The checksum-verified offline archive is stored at
`/home/admin1/Documents/PIPELINE/latest-images-20260922/sporada-intel-285h-2026.09.22-v17.tar`.
Its SHA-256 is
`9372e1cb5f3cda6bd7531dabc0c66075df5b04090e380c839d20b939a45d09f1`.

## V17 Contract Changes

- Management no longer supplies `vehicle_classes` for entry/exit lines.
- CV owns the internal detector-class policy and reports the resulting bounded
  string in `vehicle.class`.
- `vehicle_entry_exit_crossed` is explicitly durable-only and suppressed from
  SSE to prevent duplicate ingestion.
- Crossing JSON and evidence are persisted before submission, retried with the
  same event ID, and deleted only after a matching Management acknowledgement.
- Added outbox-depth, acknowledgement, submission-failure, and accidental-SSE
  suppression metrics.
- Enforced 15-second upload timeout, contract retry statuses, exponential
  jittered backoff, and evidence/request size limits.

## Verification

- `80` source and contract tests pass in both repositories.
- All bundled v17 schemas and examples validate.
- The final canonical-image test used `rtsp://192.168.1.95:8554/traffic1` and
  received five schema-valid crossings through authenticated multipart upload.
- Every received crossing was acknowledged, the durable outbox drained to zero,
  and no crossing was duplicated into SSE.
- Earlier runs observed both `in` and `out` directions and car, truck, bus, and
  motorcycle class outputs.
- A combined live traffic run produced 346 vehicle-count events, 346 pedestrian
  count events, and one ANPR event with retrievable evidence.
- A live face run delivered a crop and 512-dimensional embedding, emitted a
  schema-valid `face_seen` SSE event without a raw vector, and recovered a
  pending transaction after restart.
- A positive HTTP fire stream produced nine schema-valid fire/smoke events with
  retrievable evidence. A different low-resolution flame clip produced no
  alert, so this is functional coverage rather than an accuracy claim.

Test artifacts are under ignored `run/sporada-v17-crossing-*` directories.
Published v16 details remain in `RELEASE_V16.md`.

# Sporada Secure v18 Release

Build date: 2026-09-23

Hardware profile: Intel Core Ultra 285H (`linux/amd64`)

## Images

```text
localhost/sporada:intel-285h-2026.09.23-v18
sha256:0b3f1ab601a71e0296ed91956e7428377a90de22c510c01bd5d9902512dbafed
```

The image reuses the unchanged v2 Intel runtime base and all previous v18
runtime code. Only the vehicle/person detector IR is replaced with the
compatible YOLO26n FP16 model. The anonymously readable canonical OCI image is:

```text
ghcr.io/kiranmaibattu-cyber/sporada:intel-285h-2026.09.23-v18
ghcr.io/kiranmaibattu-cyber/sporada@sha256:102b3d6100d11fd345608cd720ccc3ecc806d7168713c28c51d0c824f51f28b8
```

No duplicate PIPELINE package is published; both source repositories reference
this same immutable image.

## Face Selection

- `minimum_quality` remains the usability floor; lower samples are discarded.
- `preferred_quality` defaults to `0.65` and can be set by Management.
- `selection_window_seconds` defaults to `1.5` seconds.
- A preferred sample is emitted immediately.
- If preferred quality is never reached, the best sample at or above the floor
  is emitted when the window expires.
- Candidate event-frame and contextual face-crop JPEGs are captured from the
  same exact original-resolution frame and retained compressed in memory only
  for the bounded window.
- Existing crop context remains two times the detected face extent. No invented
  padding or detector-resolution crop is used.

## Verification

- `83` source and contract tests passed.
- All bundled schemas and desired-state examples validated.
- A real 1920x1080 RTSP run delivered a fallback sample with quality `0.341127`
  and an `86x86` contextual crop, proving that a face below preferred quality
  is not lost.
- A separate run selected quality `0.466132` with a `124x124` crop.
- The final live run verified one identical `sample_id` across crop upload,
  512-dimensional embedding submission and `face_seen` SSE event.
- Artifact acknowledgement survived container restart; only the pending
  embedding was retried, and no raw embedding appeared in SSE.

Small or motion-blurred source faces can still look blurred when enlarged by
Management. Selection improves which available frame is sent; it does not
create source detail that the camera did not capture.

## FP16 Detector Verification

- The baked model has input `[1,3,640,640]`, output `[1,300,6]`, and the same
  COCO class IDs consumed by the existing worker.
- Direct OpenVINO inference passed on `GPU.0`.
- A live traffic run produced 721 schema-valid events across vehicle counting,
  pedestrian counting, ANPR, and fire/smoke paths, with retrievable evidence.
- Face-sample and durable vehicle-crossing delivery passed live tests.
- A zone-only desired-state revision applied without restarting the container
  or OpenVINO worker.
- No `CL_OUT_OF_RESOURCES` occurred in the tested single-camera workload.

See `V18_FP16_REBUILD.md` and `validation/v18-fp16/exact-overlay/`.

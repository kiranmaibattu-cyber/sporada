#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if ! command -v podman >/dev/null 2>&1; then
  echo "ERROR: Podman is required" >&2
  exit 1
fi

BASE_V1_TAG="${SPORADA_V18_BASE_V1_TAG:-localhost/sporada-intel-runtime-base:intel-285h-2026.08.24-v1}"
BASE_TAG="${SPORADA_V18_BASE_TAG:-localhost/sporada-intel-runtime-base:intel-285h-2026.09.18-v2}"
IMAGE_VERSION="${APEXFABRIC_IMAGE_VERSION:-2026.09.23-v18}"
IMAGE_TAG="localhost/sporada:intel-285h-${IMAGE_VERSION}"

if [[ "${BUILD_SPORADA_V18_BASE:-0}" == "1" ]] || ! podman image inspect "$BASE_TAG" >/dev/null 2>&1; then
  if ! podman image inspect "$BASE_V1_TAG" >/dev/null 2>&1; then
    podman build --platform linux/amd64 \
      -f docker/Dockerfile.sporada-base \
      -t "$BASE_V1_TAG" .
  fi
  podman build --platform linux/amd64 \
    --build-arg "INTEL_TRAFFIC_PARENT_BASE=${BASE_V1_TAG}" \
    -f docker/Dockerfile.sporada-base-v2 \
    -t "$BASE_TAG" .
fi

if ! podman image inspect "$BASE_TAG" >/dev/null 2>&1; then
  echo "ERROR: base image not found: $BASE_TAG" >&2
  echo "Build the Intel base with BUILD_SPORADA_V18_BASE=1." >&2
  exit 1
fi

base_id="$(podman image inspect "$BASE_TAG" --format '{{.Id}}')"
podman build --platform linux/amd64 \
  --build-arg "INTEL_TRAFFIC_RUNTIME_BASE=${BASE_TAG}" \
  --build-arg "INTEL_TRAFFIC_RUNTIME_BASE_DIGEST=${base_id}" \
  --build-arg "IMAGE_VERSION=${IMAGE_VERSION}" \
  -f docker/Dockerfile.sporada-v18 \
  -t "$IMAGE_TAG" .

echo "built runtime base: $BASE_TAG@$base_id"
echo "built workload:     $IMAGE_TAG"

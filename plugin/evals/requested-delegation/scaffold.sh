#!/usr/bin/env bash
# Seeds the shared ledger fixture.
set -euo pipefail
bash "$(dirname "${BASH_SOURCE[0]}")/../fixtures/ledger.sh"

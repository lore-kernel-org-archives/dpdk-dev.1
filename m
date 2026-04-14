Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE957F9D0F6
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 21:10:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2AEC40671;
	Tue, 14 Apr 2026 23:10:22 +0200 (CEST)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42]) by mails.dpdk.org (Postfix) with ESMTP id 56B614060A
 for <dev@dpdk.org>; Tue, 14 Apr 2026 23:10:20 +0200 (CEST)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-40f0e14b9f9so3811558fac.1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 14:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776201019;
 x=1776805819; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3+7VMmxpIoWEtjsOv0Qg+VIoQuoLKwcnFwPXnX3c2w=;
 b=wfUN7+zwewpwEvUAjZJ5+8nd8EXKwCoDY7JIYhFSuIBRNuE/zjXv5UvUrYFNWIEJXx
 JfPjQTldjCeNOlJYJjV0J5W235KcpRl8awuOiY2SYVj7cKg52NEyC0h69a7aCovRJ70j
 xfMiuwkqEe4f5Uv26JSfHtayktdLsnb/5iXxjXQppDkpSFiMpCWXlnvxC3fPi3x/czph
 W9jIpkoR6xl3WPnCoqR6je7yl+EC3L4k1Q61D+Z05E6Dm9cvCq6rAMb52+zBvyo4+xO+
 iWatcDWJRqZPpvdngXGyIv9j+ataoTxXOzEPY7wUJVyKo7MlmGMjN8rMOyNe0k2Ddski
 oW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776201019; x=1776805819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q3+7VMmxpIoWEtjsOv0Qg+VIoQuoLKwcnFwPXnX3c2w=;
 b=CCpn51imeHFjQ71ahNWvazE10kkrMW/BZO6fdX85ribnyHOF+FnFhySRnWvaiAE3Zw
 rGYLOi7X5maooafapAzaAWhNhuGA2UZ4uQYZgCBO6gSAVdiqp/E8+SNCJ4skBP3ElGa6
 HH4HdvcshoayrFbqmOV3Wl5rvgKCR8h7GLE8DOGjbCIjjGiHkPo8O+YPX7/ZS/AUXkw6
 lRiJEUTZJUlEdnYY6HdUwnkERhrD0p8In/bFsT/wMNPhB6a7wSz4j0IO8jgA0cr6iDTy
 4tHOFmxHRSVZOLN/KqpbRxHIXoPobQQ6UXXKvxHMsYU+ZP97kpM3m3PAlwMl+AA8ZG9W
 +phA==
X-Gm-Message-State: AOJu0YznS2fhRt81Kx1bR3de6M6Q+KToNVeBBFEa3f1r1jvoWuNc6diC
 BJZtRh7S2o09Iz8OIs/BqEC3cHLITRFRu05ldfH72ZsWjZats+WGoD6KcPUW2TlSbW18hyJ+iI9
 JFMwm
X-Gm-Gg: AeBDiet7VEmZHJPaVyEx1hq9A+YB3Q8BK9jYb0mFihK+IfirozOP9/96wkxaU72fXOx
 1vBsmVxT4bUNXKHY8EXcGyAan494oTdPuRv+Xxo6KMwP6zNpDgs5CTs9PSXx9JsVzG9a3BLwgy1
 dpKQKxaRqoBh8Ttq5AKlzFc3ZByoR+IFMGIa0hwRiMK1OgEq2rJ1wKPSrlAO5Cj2ROafpCqfP15
 x7jA8+XzH6PMn5D1nYcHpRWKRq/JbL//x1JbVfSTFSvWksZd2IGX7Ava9SbZXQ76oSWQJkTU5VH
 /iTw6eqY/o5Xdk3dz3kMRBZY3WiwQEmu8t7U2VhuMM2GRF14NCG9QA/vUU6a/c700S7cZsgX2tj
 TG3hpGQKGpd3YvfsHtlFV6k7KPTP9v+uBAWiGmdFBKRGJpSMwqZA/YkoCjFzhbb5qIAawLnBzWF
 oZEfzyQCUCcRMbZFnQwgHSV2y5oTZLSwQYB2/gOJ6p67W4Gh/Q3LLXkQ==
X-Received: by 2002:a4a:e902:0:b0:68c:3d8e:7904 with SMTP id
 006d021491bc7-68c3d8e7af5mr9453840eaf.45.1776201019366; 
 Tue, 14 Apr 2026 14:10:19 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68bc82ea711sm7770224eaf.4.2026.04.14.14.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 14:10:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>
Subject: [PATCH v14 3/6] devtools: add compare-reviews.sh for multi-provider
 analysis
Date: Tue, 14 Apr 2026 14:08:40 -0700
Message-ID: <20260414211012.951613-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414211012.951613-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260414211012.951613-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Add script to run patch reviews across multiple AI providers for
comparison purposes.

The script automatically detects which providers have API keys
configured and runs analyze-patch.py for each one. This allows
users to compare review quality and feedback across different
AI models.

Features:
  - Auto-detects available providers based on environment variables
  - Optional provider selection via -p/--providers option
  - Saves individual reviews to separate files with -o/--output
  - Verbose mode passes through to underlying analyze-patch.py

Usage:
  ./devtools/compare-reviews.sh my-patch.patch
  ./devtools/compare-reviews.sh -p anthropic,xai my-patch.patch
  ./devtools/compare-reviews.sh -o ./reviews my-patch.patch

Output files are named <patch>-<provider>.txt when using the
output directory option.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Aaron Conole <aconole@redhat.com>
---
 devtools/compare-reviews.sh | 263 ++++++++++++++++++++++++++++++++++++
 1 file changed, 263 insertions(+)
 create mode 100755 devtools/compare-reviews.sh

diff --git a/devtools/compare-reviews.sh b/devtools/compare-reviews.sh
new file mode 100755
index 0000000000..b4813cb6a7
--- /dev/null
+++ b/devtools/compare-reviews.sh
@@ -0,0 +1,263 @@
+#!/bin/bash
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Stephen Hemminger
+
+# Compare DPDK patch reviews across multiple AI providers
+# Runs analyze-patch.py with each available provider
+
+set -o pipefail
+
+SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
+ANALYZE_SCRIPT="${SCRIPT_DIR}/analyze-patch.py"
+AGENTS_FILE="AGENTS.md"
+OUTPUT_DIR=""
+PROVIDERS=""
+FORMAT="text"
+VERBOSE=""
+EXTRA_ARGS=()
+
+usage() {
+    cat <<EOF
+Usage: $(basename "$0") [OPTIONS] <patch-file>
+
+Compare DPDK patch reviews across multiple AI providers.
+
+Options:
+    -a, --agents FILE      Path to AGENTS.md file (default: AGENTS.md)
+    -o, --output DIR       Save individual reviews to directory
+    -p, --providers LIST   Comma-separated list of providers to use
+                           (default: all providers with API keys set)
+    -f, --format FORMAT    Output format: text, markdown, html, json
+                           (default: text)
+    -t, --tokens N         Max tokens for response
+    -D, --date DATE        Review date context (YYYY-MM-DD)
+    -r, --release VERSION  Target DPDK release (e.g., 24.11, 23.11-lts)
+    --split-patches        Split mbox into individual patches
+    --patch-range N-M      Review only patches N through M
+    --large-file MODE      Handle large files: error, truncate, chunk,
+                           commits-only, summary
+    --max-tokens N         Max input tokens
+    -v, --verbose          Show verbose output from each provider
+    -h, --help             Show this help message
+
+Environment Variables:
+    Set API keys for providers you want to use:
+    ANTHROPIC_API_KEY, OPENAI_API_KEY, XAI_API_KEY, GOOGLE_API_KEY
+
+Examples:
+    $(basename "$0") my-patch.patch
+    $(basename "$0") -p anthropic,openai my-patch.patch
+    $(basename "$0") -o ./reviews -f markdown my-patch.patch
+    $(basename "$0") -r 24.11 --split-patches series.mbox
+EOF
+    exit "${1:-0}"
+}
+
+error() {
+    echo "Error: $1" >&2
+    exit 1
+}
+
+# Check which providers have API keys configured
+get_available_providers() {
+    local available=""
+
+    [[ -n "$ANTHROPIC_API_KEY" ]] && available="${available}anthropic,"
+    [[ -n "$OPENAI_API_KEY" ]] && available="${available}openai,"
+    [[ -n "$XAI_API_KEY" ]] && available="${available}xai,"
+    [[ -n "$GOOGLE_API_KEY" ]] && available="${available}google,"
+
+    # Remove trailing comma
+    echo "${available%,}"
+}
+
+# Get file extension for format
+get_extension() {
+    case "$1" in
+        text)     echo "txt" ;;
+        markdown) echo "md" ;;
+        html)     echo "html" ;;
+        json)     echo "json" ;;
+        *)        echo "txt" ;;
+    esac
+}
+
+# Parse command line options
+while [[ $# -gt 0 ]]; do
+    case "$1" in
+        -a|--agents)
+            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
+            AGENTS_FILE="$2"
+            shift 2
+            ;;
+        -o|--output)
+            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
+            OUTPUT_DIR="$2"
+            shift 2
+            ;;
+        -p|--providers)
+            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
+            PROVIDERS="$2"
+            shift 2
+            ;;
+        -f|--format)
+            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
+            FORMAT="$2"
+            shift 2
+            ;;
+        -t|--tokens)
+            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
+            EXTRA_ARGS+=("-t" "$2")
+            shift 2
+            ;;
+        -D|--date)
+            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
+            EXTRA_ARGS+=("-D" "$2")
+            shift 2
+            ;;
+        -r|--release)
+            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
+            EXTRA_ARGS+=("-r" "$2")
+            shift 2
+            ;;
+        --split-patches)
+            EXTRA_ARGS+=("--split-patches")
+            shift
+            ;;
+        --patch-range)
+            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
+            EXTRA_ARGS+=("--patch-range" "$2")
+            shift 2
+            ;;
+        --large-file)
+            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
+            EXTRA_ARGS+=("--large-file" "$2")
+            shift 2
+            ;;
+        --large-file=*)
+            EXTRA_ARGS+=("$1")
+            shift
+            ;;
+        --max-tokens)
+            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
+            EXTRA_ARGS+=("--max-tokens" "$2")
+            shift 2
+            ;;
+        -v|--verbose)
+            VERBOSE="-v"
+            shift
+            ;;
+        -h|--help)
+            usage 0
+            ;;
+        -*)
+            error "Unknown option: $1"
+            ;;
+        *)
+            break
+            ;;
+    esac
+done
+
+# Check for required arguments
+if [[ $# -lt 1 ]]; then
+    echo "Error: No patch file specified" >&2
+    usage 1
+fi
+
+PATCH_FILE="$1"
+
+if [[ ! -f "$PATCH_FILE" ]]; then
+    error "Patch file not found: $PATCH_FILE"
+fi
+
+if [[ ! -f "$ANALYZE_SCRIPT" ]]; then
+    error "analyze-patch.py not found: $ANALYZE_SCRIPT"
+fi
+
+if [[ ! -f "$AGENTS_FILE" ]]; then
+    error "AGENTS.md not found: $AGENTS_FILE"
+fi
+
+# Validate format
+case "$FORMAT" in
+    text|markdown|html|json) ;;
+    *) error "Invalid format: $FORMAT (must be text, markdown, html, or json)" ;;
+esac
+
+# Get providers to use
+if [[ -z "$PROVIDERS" ]]; then
+    PROVIDERS=$(get_available_providers)
+fi
+
+if [[ -z "$PROVIDERS" ]]; then
+    error "No API keys configured. Set at least one of: "\
+"ANTHROPIC_API_KEY, OPENAI_API_KEY, XAI_API_KEY, GOOGLE_API_KEY"
+fi
+
+# Create output directory if specified
+if [[ -n "$OUTPUT_DIR" ]]; then
+    mkdir -p "$OUTPUT_DIR"
+fi
+
+PATCH_BASENAME=$(basename "$PATCH_FILE")
+PATCH_STEM="${PATCH_BASENAME%.*}"
+EXT=$(get_extension "$FORMAT")
+
+echo "Reviewing patch: $PATCH_BASENAME"
+echo "Providers: $PROVIDERS"
+echo "Format: $FORMAT"
+echo "========================================"
+echo ""
+
+# Run review for each provider, continue on failure
+IFS=',' read -ra PROVIDER_LIST <<< "$PROVIDERS"
+failures=0
+for provider in "${PROVIDER_LIST[@]}"; do
+    echo ">>> Running review with: $provider"
+    echo ""
+
+    if [[ -n "$OUTPUT_DIR" ]]; then
+        OUTPUT_FILE="${OUTPUT_DIR}/${PATCH_STEM}-${provider}.${EXT}"
+        if python3 "$ANALYZE_SCRIPT" \
+            -p "$provider" \
+            -a "$AGENTS_FILE" \
+            -f "$FORMAT" \
+            ${VERBOSE:+"$VERBOSE"} \
+            "${EXTRA_ARGS[@]}" \
+            "$PATCH_FILE" | tee "$OUTPUT_FILE"; then
+            echo ""
+            echo "Saved to: $OUTPUT_FILE"
+        else
+            echo "FAILED: $provider review failed" >&2
+            rm -f "$OUTPUT_FILE"
+            ((failures++)) || true
+        fi
+    else
+        if ! python3 "$ANALYZE_SCRIPT" \
+            -p "$provider" \
+            -a "$AGENTS_FILE" \
+            -f "$FORMAT" \
+            ${VERBOSE:+"$VERBOSE"} \
+            "${EXTRA_ARGS[@]}" \
+            "$PATCH_FILE"; then
+            echo "FAILED: $provider review failed" >&2
+            ((failures++)) || true
+        fi
+    fi
+
+    echo ""
+    echo "========================================"
+    echo ""
+done
+
+echo "Review comparison complete."
+
+if [[ -n "$OUTPUT_DIR" ]]; then
+    echo "All reviews saved to: $OUTPUT_DIR"
+fi
+
+if [[ $failures -gt 0 ]]; then
+    echo "$failures provider(s) failed." >&2
+    exit 1
+fi
-- 
2.53.0


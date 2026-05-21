Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C5ECD5BAF
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 22:46:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B48A4066C;
	Fri, 22 May 2026 00:46:00 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 4EC9540661
 for <dev@dpdk.org>; Fri, 22 May 2026 00:45:58 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2f7ca62a3c4so6939613eec.0
 for <dev@dpdk.org>; Thu, 21 May 2026 15:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779403557;
 x=1780008357; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkVhL0SPNZ0ypwLziuRxpsMHTeuCxDRkCjE2J+59+68=;
 b=iTf0jq9b6wyVTDYHT535Xnr4FrYDCtrThxjsQHCT9UD2AzqWugzRS2qyh9Hbvalfah
 Yl2zLwfUtvZLm2BWpSsFGnzDRek98oIZ8Vg89I6sENJ+ujag4BUg4A13r42SVgDEf9Lr
 g5oO0v+CBOzG0A94PIDOxCMNP178BU7Ebh3R+lat/5oUQ18O0cOwRB3pI/ej23uYbiDD
 SX+yuEWGMXC4vuKl4D077aDe+MLIeS6i/2Hu6O0oghLxBi5v232pbkF3X3LTzXhhay4u
 aAyiUWxLf5TLp+0OYPXuhcd95a5ai6R5weip15cFxJkZv0YBt9VuVF1CN6436W9rdDcA
 JC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779403557; x=1780008357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xkVhL0SPNZ0ypwLziuRxpsMHTeuCxDRkCjE2J+59+68=;
 b=k47jEqmY7Us0qWlduHPlCebaQHrohFAWfgyd0kIIUN7U8NTW1ETY3sP6gonZCZ2G7r
 RYieRde1dlTnjYoVLl1u52ics751RF0XEO2+wm7Mra/Rw2G8FeLz2d9G5sUsyzueB4vd
 AvTU+Fovjt0JqiZKBMhVNuJdiOUAgRVj2xu0pNAJ6EvdMcC2b/oXhFB6RXlKoWiLFNDf
 h9io8xkVJ5bPfmmg+5On0TE4rcBTiPe7K3DEuyUX83KU/7gXQt3CBgiiEllmX2+si6FF
 TwkDPbhh6mBBlQe1u0HXdudoS7JUiYtW5DsszqV8/AjWK53BASDTBs63Q4Kq7v4EmKlp
 sBmw==
X-Gm-Message-State: AOJu0Yx8cvFW1T3A4L/aSFwJYl9do3vAnBXUItdRoIGWrM7iYnYgaq/9
 jashRJxnxKNcU85PUrF7P0bXOJCruqh/lB6xnDmKc6vGAhdzMM4kV38rSpE4diWye3UfXCLGnfl
 mraDQ
X-Gm-Gg: Acq92OGZ97E8WtjRDfMv22CMhE5bi39v7+eEiOIQEYlMWhBw+AkqvIZHcFNZu37VRpJ
 DzutbWcsYgx/BdLTR4kdHovSHjPONXw4GupzgeNgkJ0nCcPe2WzbBIKWNeFiRSyCPkie9hEIf6D
 zrhH4NAtsj46nz1UT1zF7IXck0oFNXSBdmHw1lLjfQCeJ9HCuv50MudDtR9AsOzN0QXWqcm5EDU
 mPgpinNB4vvC2ELR9rJlb0xyVbpDAS/T14beiY8rUPHt1Nr9Vec+JlN9UFcCzmhZvEX0W/YyIdR
 llOc23+SEo5vnT3HqnH6FGZdUjPF6L62XdSIIgldWnSi1ZzxzW8LFI7gZ/xnB6lQSJKKZQkof1x
 db8R5VPZWsd5L9C0Tglu/Gdu3oL8ksX2XbB39s0LJjMYSic+zuLlhC6fOQx+CgibkaDBPHz3jMi
 M7xkKjSK6cIJ2YFLXjvpACAzpWOJBY+TOnXCSqG3pvQO/gF+3JhweoEyKB01VVHRkB48RmDWW1
X-Received: by 2002:a05:7300:a903:b0:304:2af3:5ff2 with SMTP id
 5a478bee46e88-3044905c53fmr634022eec.21.1779403557258; 
 Thu, 21 May 2026 15:45:57 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-136621d3ae9sm496044c88.5.2026.05.21.15.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 15:45:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>
Subject: [PATCH v15 4/7] devtools: add compare-patch-reviews.sh for
 multi-provider analysis
Date: Thu, 21 May 2026 15:44:36 -0700
Message-ID: <20260521224550.927338-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521224550.927338-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260521224550.927338-1-stephen@networkplumber.org>
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
  ./devtools/ai/compare-patch-reviews.sh my-patch.patch
  ./devtools/ai/compare-patch-reviews.sh -p anthropic,xai my-patch.patch
  ./devtools/ai/compare-patch-reviews.sh -o ./reviews my-patch.patch

Output files are named <patch>-<provider>.txt when using the
output directory option.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Aaron Conole <aconole@redhat.com>
---
 devtools/ai/compare-patch-reviews.sh | 306 +++++++++++++++++++++++++++
 1 file changed, 306 insertions(+)
 create mode 100755 devtools/ai/compare-patch-reviews.sh

diff --git a/devtools/ai/compare-patch-reviews.sh b/devtools/ai/compare-patch-reviews.sh
new file mode 100755
index 0000000000..ba6d3a3eba
--- /dev/null
+++ b/devtools/ai/compare-patch-reviews.sh
@@ -0,0 +1,306 @@
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
+
+Exit code from analyze-patch.py is interpreted as:
+    0    clean review
+    2    review found warnings (output preserved)
+    3    review found errors   (output preserved)
+    1/*  operational failure   (output removed, counted as failure)
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
+# Run review for each provider; continue on failure of any one provider.
+#
+# analyze-patch.py exit codes:
+#   0 - clean review (no issues)
+#   1 - operational failure (missing key, file not found, network error, etc.)
+#   2 - review found warnings
+#   3 - review found errors
+# Exit 2 and 3 mean the review SUCCEEDED and produced output the user wants
+# to read. Only 1 (and unexpected codes) indicate a failed run.
+IFS=',' read -ra PROVIDER_LIST <<< "$PROVIDERS"
+failures=0
+warnings_count=0
+errors_count=0
+for provider in "${PROVIDER_LIST[@]}"; do
+    echo ">>> Running review with: $provider"
+    echo ""
+
+    OUTPUT_FILE=""
+    if [[ -n "$OUTPUT_DIR" ]]; then
+        OUTPUT_FILE="${OUTPUT_DIR}/${PATCH_STEM}-${provider}.${EXT}"
+        python3 "$ANALYZE_SCRIPT" \
+            -p "$provider" \
+            -a "$AGENTS_FILE" \
+            -f "$FORMAT" \
+            ${VERBOSE:+"$VERBOSE"} \
+            "${EXTRA_ARGS[@]}" \
+            "$PATCH_FILE" | tee "$OUTPUT_FILE"
+        rc=${PIPESTATUS[0]}
+    else
+        python3 "$ANALYZE_SCRIPT" \
+            -p "$provider" \
+            -a "$AGENTS_FILE" \
+            -f "$FORMAT" \
+            ${VERBOSE:+"$VERBOSE"} \
+            "${EXTRA_ARGS[@]}" \
+            "$PATCH_FILE"
+        rc=$?
+    fi
+
+    case "$rc" in
+        0)
+            if [[ -n "$OUTPUT_FILE" ]]; then
+                echo ""
+                echo "Saved to: $OUTPUT_FILE"
+            fi
+            ;;
+        2)
+            ((warnings_count++)) || true
+            echo "($provider: review reported warnings)" >&2
+            if [[ -n "$OUTPUT_FILE" ]]; then
+                echo ""
+                echo "Saved to: $OUTPUT_FILE"
+            fi
+            ;;
+        3)
+            ((errors_count++)) || true
+            echo "($provider: review reported errors)" >&2
+            if [[ -n "$OUTPUT_FILE" ]]; then
+                echo ""
+                echo "Saved to: $OUTPUT_FILE"
+            fi
+            ;;
+        *)
+            echo "FAILED: $provider review failed (exit $rc)" >&2
+            [[ -n "$OUTPUT_FILE" ]] && rm -f "$OUTPUT_FILE"
+            ((failures++)) || true
+            ;;
+    esac
+
+    echo ""
+    echo "========================================"
+    echo ""
+done
+
+total=${#PROVIDER_LIST[@]}
+clean_count=$((total - warnings_count - errors_count - failures))
+
+echo "Review comparison complete."
+echo "Summary across $total provider(s): clean=$clean_count" \
+     "warnings=$warnings_count errors=$errors_count failed=$failures"
+
+if [[ -n "$OUTPUT_DIR" ]]; then
+    echo "Reviews saved to: $OUTPUT_DIR"
+fi
+
+if [[ $failures -gt 0 ]]; then
+    exit 1
+fi
-- 
2.53.0


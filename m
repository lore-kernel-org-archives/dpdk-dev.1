Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82C0D46BE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:24:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFDF340668;
	Wed, 28 Jan 2026 19:24:31 +0100 (CET)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65]) by mails.dpdk.org (Postfix) with ESMTP id 8B1AA4066A
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:24:30 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so1168385e9.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769624670;
 x=1770229470; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79UJnlcq7hKI3GPfGnmJujQs9dghnw0mBN1qViGrAx8=;
 b=XiwVMEJGjnHWPzD8mdKDooEmprKVwJN+TWLOkWcRTM6IDeFSCJ4W/iTjqmRMYJ3Kp2
 z/DEca8EgPI4YgMFovZOok0hwKdDy3E4VdFkzWNS26HSqvdPKbEnNd8g9BTXDpaXSgHC
 X0BUYEaCOM84tgbkUHlWjWZ8O8coqewTIa4WBmT77G0ioxyL8800AnoWaTTNGKARjmVt
 LT0MrB7MUq0jHN4xjNb2AN2Zx6SUH3zOXRDoOeCLVYLHujEh/B/Y39dN7u+OvG+GyBwm
 HNL7z3fSS6pTpxqfHhB9JppJDba3Xl927wNSOcpMf8AlaRwM0nYQXkdcT+/XXh7i77Dv
 yUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769624670; x=1770229470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=79UJnlcq7hKI3GPfGnmJujQs9dghnw0mBN1qViGrAx8=;
 b=Wg3nLvOPpftjtKi2YnlYc/1BXBcN7wrkqx0tA6yOvQOZn9k+hmTxh2xkxclR4NZrE5
 RmPsIEiT1gTBxLoJp+8wL7DTUCv+QHxZuL9xKU8baJV+50OMXOnBtBL0C2NFveUidyeM
 1KWjuc2/9jiX1NTSJi/xiXTLykg7VDZ9hkc0MmX8Repr7F1TIZYP+O27ysjHUiwkj/og
 k1+Zxy5RzAp/PXreZXsJBgOAzdUhK2nVY04mavWPxIis03oIK7RaVoBf6uCaPxUiKHil
 cEEV+TO1m6KbNKousiJyy9ETM6j0q/n/ka+E5z5Mp7U/DIzir9sDFWLaaAgLRY4+HF3i
 EF4g==
X-Gm-Message-State: AOJu0YzsJHQgGrD1UAIxTsZrzmehn1gTUhbFochJbCIF1FW7VFSR11cd
 iiiVZ1HuYkWYQa2K17gAa1fZ+qoErMCu44yDYdisiZP/MsQkfaZjWNrIgNhRV/l0DfigW+Cxz0+
 3JpO0pCw=
X-Gm-Gg: AZuq6aK57z0RPMFRw15EgUIUU7w87mP4m3wl+TNStMCtvdmxrXeVvpC5A4yqNGlLUrA
 3i2znGyoHvUDY8ouP3pMWZN8rYOkPaULj6JDCZTXzlY2NrvnjEXmE5J1+yMaCpyvJlfDculwXIs
 opjpXqAYtsUDRhbYcBHhZn+Ut40Zp/+DJ0VMvNNUo7eG0j2d+Uew9w6ijrHmcYUrrC/Y2SgFHsP
 tQDEyETmFZ9rAfqa+VB5/f4EHCERYmvdL272+te32Fk8RRIi1CxeOzX7a6zymMAwgz3lxKlrz4i
 /cA9hfe4LHHXJxXVpLX1OeL81jil6Wb/mcLdtAHxgajHfyGC9dcxVQGBsZnvS21CUH1vVVjqJjm
 8uZgJG/zSRjfOe55HpqII5q9g7HT3lSO+BP36AsKBmGK5pDV64aBBwcqlwAJP3kLmdWmt708Hmj
 sE8jo05tGErjoujqzG+9RswvEwlGkb+8ZvNmrPsoP1HJ5P5LWZ0Q==
X-Received: by 2002:a05:600c:524c:b0:477:b0b9:312a with SMTP id
 5b1f17b1804b1-48069c2c45amr88275515e9.7.1769624670057; 
 Wed, 28 Jan 2026 10:24:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806d883b12sm1017245e9.1.2026.01.28.10.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 10:24:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 3/4] devtools: add compare-reviews.sh for multi-provider
 analysis
Date: Wed, 28 Jan 2026 10:21:52 -0800
Message-ID: <20260128182401.384530-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128182401.384530-1-stephen@networkplumber.org>
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <20260128182401.384530-1-stephen@networkplumber.org>
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
---
 devtools/compare-reviews.sh | 192 ++++++++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)
 create mode 100644 devtools/compare-reviews.sh

diff --git a/devtools/compare-reviews.sh b/devtools/compare-reviews.sh
new file mode 100644
index 0000000000..a63eeffb71
--- /dev/null
+++ b/devtools/compare-reviews.sh
@@ -0,0 +1,192 @@
+#!/bin/bash
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Stephen Hemminger
+
+# Compare DPDK patch reviews across multiple AI providers
+# Runs analyze-patch.py with each available provider
+
+set -e
+
+SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
+ANALYZE_SCRIPT="${SCRIPT_DIR}/analyze-patch.py"
+AGENTS_FILE="AGENTS.md"
+OUTPUT_DIR=""
+PROVIDERS=""
+FORMAT="text"
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
+VERBOSE=""
+
+while [[ $# -gt 0 ]]; do
+    case "$1" in
+        -a|--agents)
+            AGENTS_FILE="$2"
+            shift 2
+            ;;
+        -o|--output)
+            OUTPUT_DIR="$2"
+            shift 2
+            ;;
+        -p|--providers)
+            PROVIDERS="$2"
+            shift 2
+            ;;
+        -f|--format)
+            FORMAT="$2"
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
+# Run review for each provider
+IFS=',' read -ra PROVIDER_LIST <<< "$PROVIDERS"
+for provider in "${PROVIDER_LIST[@]}"; do
+    echo ">>> Running review with: $provider"
+    echo ""
+
+    if [[ -n "$OUTPUT_DIR" ]]; then
+        OUTPUT_FILE="${OUTPUT_DIR}/${PATCH_STEM}-${provider}.${EXT}"
+        python3 "$ANALYZE_SCRIPT" \
+            -p "$provider" \
+            -a "$AGENTS_FILE" \
+            -f "$FORMAT" \
+            $VERBOSE \
+            "$PATCH_FILE" | tee "$OUTPUT_FILE"
+        echo ""
+        echo "Saved to: $OUTPUT_FILE"
+    else
+        python3 "$ANALYZE_SCRIPT" \
+            -p "$provider" \
+            -a "$AGENTS_FILE" \
+            -f "$FORMAT" \
+            $VERBOSE \
+            "$PATCH_FILE"
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
-- 
2.51.0


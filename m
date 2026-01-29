Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDC9D73E87
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 20:41:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D13D840664;
	Thu, 29 Jan 2026 21:41:27 +0100 (CET)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67]) by mails.dpdk.org (Postfix) with ESMTP id E2C6240609
 for <dev@dpdk.org>; Thu, 29 Jan 2026 21:41:22 +0100 (CET)
Received: by mail-wm1-f67.google.com with SMTP id
 5b1f17b1804b1-4806f9e61f9so7601765e9.1
 for <dev@dpdk.org>; Thu, 29 Jan 2026 12:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769719282;
 x=1770324082; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79UJnlcq7hKI3GPfGnmJujQs9dghnw0mBN1qViGrAx8=;
 b=xlgV9tQdLrKyuQg0QQrV8wjPgYchlNv7nv5f74NYIsbrmT2EIPqscxub1R6cMPoBrZ
 rO+WBlovrCdy1zgTJHH9qJfcPkXdmZIlrtgOpUCneTOdXCTiNESerBlvbQZfq2bgANZ+
 MHnDwOs6eGRyCHSWcYBDqsySTYBuVMFClWStMu3q41gRfzlIRF6+Uok59jJzfWGkfHaB
 G8He74vbTLXhvkpOGEnm5tUsc92n0CId94gagQFnsGjVOtBSB1Ih9MAhIxHw+9DJOtvH
 tNbvFmLPP4fbqEFEaUO8WmK66gW0AJdJxTYood9naEzkNGKY8SE49/PrfBvpwyxY+F4k
 kUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769719282; x=1770324082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=79UJnlcq7hKI3GPfGnmJujQs9dghnw0mBN1qViGrAx8=;
 b=cX8j3Yshfrup8h8JUTyUutYwYSxU3Om11ftNmBgeI4Xw2YkRpCnHbx914zpE606sTe
 ra1udgRRjNA+aq5IjNSWHcyp75M/vNURGNtOOadC2+0DhmNA8QDax2pPQsog6Q3PjVHo
 y4WHUSeIrYGp+hina5GY+gOoXsim7fa2MC0RymcETJZ3wAfeSW8e/yePUlfUZbFTsnqX
 TiieUtbrAh5wiTxK8SyZHbPf7ip0enkG0J4aHV231eqrV4wxL2XsvkYlzWMxmucwx7OK
 EGEXVNs+wclBU+155hwFmkMNCGAdyQBW+zakdp2b09NpmlAzdLde0hkZoVzvp7Y5hSlV
 0YTw==
X-Gm-Message-State: AOJu0YzYRobh8GzzkOjf+3Z9LEZdPfBA6IS7AZHoW4CxluXMMQiSRlAS
 TLqXOgPM+4ANV1SQHgB4PRmXlxAj+HAbIK5yb7aNXQBGQ+u6ZjnjrML6LMNqehbytTcOWes8CpQ
 U6dHfD14=
X-Gm-Gg: AZuq6aIshSpYqPk+WlkKpekfmSqaFzrFPSaC5+kigtVTd3LjFLz+G9Nplghmi/1GMEz
 YHztI+h6PjRGSsBII7zyQ0T00b5husNnIqZqZm2w0emFp8vifD0c1wz8XPwyq6N0tHHRUmRvMVm
 OrUluEgkaahizQ4a0vMaWyNVAAHlR9vJqu57WlT1XunBtA5/WrYyinF4YjL6xZXc8o2ucDGXePU
 E5TYWWytpSK0LcpfYJU+f6Su3A6kw+XUMrnM4o/l/uFYSkiBAl3zZZvhja60zAmFdj8mHSQwlQq
 eO6kZ8etnQ/ZMvC6hxA0GBDBs4yEr+P4KU/eJ4d6z8yHUHU8S8Bc7BX1o+D+3eUeSg+FEJOC8jF
 +lQD/YlA/9HOkkzxU3VSFow3x3P9/Kx1A7RgLRwyjN+xl+xUbsq6GL4aBFfBYhSzCGU/60Kx5zA
 FDu4eBk8AcnIrBtqJWaIHcm9xmH2Y+AcPcsDrZJWn4ymrdPQxBxw==
X-Received: by 2002:a05:600c:350c:b0:47f:8c05:786b with SMTP id
 5b1f17b1804b1-482db48d476mr4560155e9.28.1769719282481; 
 Thu, 29 Jan 2026 12:41:22 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cde00e8sm157551375e9.6.2026.01.29.12.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 12:41:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 3/4] devtools: add compare-reviews.sh for multi-provider
 analysis
Date: Thu, 29 Jan 2026 12:38:17 -0800
Message-ID: <20260129204112.174523-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129204112.174523-1-stephen@networkplumber.org>
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <20260129204112.174523-1-stephen@networkplumber.org>
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


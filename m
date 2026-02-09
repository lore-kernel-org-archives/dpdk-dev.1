Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9571EE7E0D5
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 19:51:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D918B4066E;
	Mon,  9 Feb 2026 20:51:07 +0100 (CET)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65]) by mails.dpdk.org (Postfix) with ESMTP id DF77640691
 for <dev@dpdk.org>; Mon,  9 Feb 2026 20:51:05 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so1019415e9.1
 for <dev@dpdk.org>; Mon, 09 Feb 2026 11:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770666665;
 x=1771271465; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r92brlExUYKOZR+gJ8q0fvZd2nGwHIe81/wDVg0BwBo=;
 b=vSURhr8JReughwnQFnlhQXIwzkx7nAuBs1IM5LMZ4lG8H+9uv1+SaDbt+5LWIDf6h9
 eeq5mY9f4ih2gfz8BE3tXHbcOyp6jp0vXeoPqGxLJ/MkLMy1/fbJI5i8IvK0kIpnr0RB
 Iq0/Kzd67FnksR7zmLvhyhCTBbQR3GSUW4FZpsQgdnY3vT7d/Ouy2LLCr3ozqXoYC1ng
 9dkEdjvVLMiaZH6L63pu8y2K7FpQ/qLoKT90FxughDHaRRsUSU1OVAwwW/IiAGy3274Y
 TcuOU4mguP1Tk/tKzUYbnPX/bODRl7+KjQH8DE1WfLaP1LwHlAYaShU5T9HIO9CRJTLy
 5rIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770666665; x=1771271465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r92brlExUYKOZR+gJ8q0fvZd2nGwHIe81/wDVg0BwBo=;
 b=m/j8Xt1ZgXFLw9KknosjnGmVtBZDWmqSpW4YR0RGoKsS8NL4JRuj1KCwJSOhr+0RNs
 0wWn2XoYyLlbTUM8Q/h6mPkelkn53WPmFNSm94R4VF5nHKOSyK6XCrHhgkbmNwW3UNys
 XSJqJTFtYspHa/44R7jjLBrh5oeOvEQzkEt9kRSjbTszAD6UzrhP8OMmsnnL5Kaz3H5M
 5H22qc1QqpturrUWDNvx9VBRvzL+ft9YvJRBFkxCJ8AwnkbHC3xGf+NmEBsSm5vvlyT7
 tYlI+5PSsEXAhp5cBQLePUdKjPh1KdtZvTwX7N6bz9+eYdrWhiOLUrcoxernFh3QGv3k
 7czg==
X-Gm-Message-State: AOJu0YwU40e3aIDy+IO38k4qNMFdKWG+Q+BdKuRbfmei8jlkAKf4P1+Q
 753PSRD2HWySdhpUIy4eWh2mu6RSQTMOnN0+XJrFJEXJhNObxLMVbH/CkkByULhRdoJO2NP5bzX
 urP1v7Ww=
X-Gm-Gg: AZuq6aKOjIMjMmHHstmbLGjLpWz+icjGhWCCd2LuUkVUY5KXYv7a7I2gXQQDEpWMdqL
 3PoblYKqQMg5WXuUFZwpGSFulQfqvbmipWuQc7/mcTSJoSNiJ8ytMVDP42fi67V/ou6MWdsYCKe
 SwKgwTBCT/TAN4cTvpOxiWuVrZAb6oJkCHJgOurZjCSHY9tSaC7acwPrh3RnBx8b4//N6mbuJDz
 vXcZ8aroUy7nN2FuenEIU3rkLwOcmfbXAcSMkJq7OZCnGBctPEUJk4SX+BYnqKPvdSy1PGJteh3
 O2WriHY+U6iGlfJZHaewoHeWlYe10IFZoHtUwLsW1BxU987ndJzBU58oScTr2cpcEfz8rNZGQDM
 VRBVt1OjqEJKyD/mS6jT2KTr1xD6C635jVGjEcfvIyXiAFf2S8ZIp2h4surGG/hz6JdWzvHZ1i+
 fQw0rgQj4NxGbD3QbNVZo+0uDutvHv27paUxzz1PEfUPN+O4BfhdrKf4OzS3K0iA==
X-Received: by 2002:a05:600c:6217:b0:47e:e91d:73c0 with SMTP id
 5b1f17b1804b1-483202310a5mr170629795e9.19.1770666665390; 
 Mon, 09 Feb 2026 11:51:05 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm10178345e9.3.2026.02.09.11.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 11:51:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>
Subject: [PATCH v8 3/6] devtools: add compare-reviews.sh for multi-provider
 analysis
Date: Mon,  9 Feb 2026 11:48:51 -0800
Message-ID: <20260209195055.142484-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209195055.142484-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260209195055.142484-1-stephen@networkplumber.org>
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
 create mode 100755 devtools/compare-reviews.sh

diff --git a/devtools/compare-reviews.sh b/devtools/compare-reviews.sh
new file mode 100755
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


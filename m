Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18747D1950F
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 18:42:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E88F94060C;
	Mon, 26 Jan 2026 19:42:17 +0100 (CET)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67]) by mails.dpdk.org (Postfix) with ESMTP id 829964060C
 for <dev@dpdk.org>; Mon, 26 Jan 2026 19:42:15 +0100 (CET)
Received: by mail-wr1-f67.google.com with SMTP id
 ffacd0b85a97d-435903c4040so2962566f8f.3
 for <dev@dpdk.org>; Mon, 26 Jan 2026 10:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769452935;
 x=1770057735; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79UJnlcq7hKI3GPfGnmJujQs9dghnw0mBN1qViGrAx8=;
 b=AFvPs3Goi/K45Yq6j/+0SMxDnZk7S6YyymVzR54P/zY5R6Hrp7VpcGTLGRUv+K16oH
 ojI6TxBOt0mwf0VPaYrGtQi1LJ01jSLmxJBGWNOHqG6HbQ/R6/OuulptjU8KQHbYjGpo
 3K4VaMToMrQZFA9XPcYCbuZ/hhsUlFcWvAtAqwbLIZMVJbi1w2FBlMEAXL5D4gz22fW/
 I+oIh9PzCTNH6pVk7eK4t+dS7pWGCBgmz1BvngchU3ql6SdDxNFSXpQIWjzU16V69E82
 be1iqG/X16N81ejxLlXtQIaKW8VzrTCt+Duk3rathaOK6NRDXQ/7MSBZx89LExjh6KJ9
 kVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769452935; x=1770057735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=79UJnlcq7hKI3GPfGnmJujQs9dghnw0mBN1qViGrAx8=;
 b=BGyWzGcrS5TvxXb89NnmtxVCU8sMFXwMPFvSkHHdIJgi3sXkATobdHJwP3Q/HQKCtl
 mW2AmrinS71gc513J8u4W6YFEiNrB6cGF3vk2ul9H2gkiwSexbhuO6r+m3xrvHBogf1p
 eWpfay00ZrNv8fJUFRA8XAELTdss4K08dCSkq/5R4SUVbgkZUbfW4A6izlVckoy/0Ifd
 RS2muuw7AKPppl9jLg4oNqiaIPGql3XcyELTv0NefVxDivFclKjtxSjt358GfrEyyAnX
 OGFHW5hYwaY8vY9ePJCoLDg9LqBs+o1bhgN4NEhR8GPpdrURHMU/kzZVJIPOv0q6I24x
 2YTA==
X-Gm-Message-State: AOJu0YzYz4+MglKbIs+NaJ3L1OpiTWvGwSDmpIRJn2lX0K5luwnRGrvH
 qm51taxNMZuXXa040xh98ttsb0uh6w4QDdlatyRKERZwUX3cNuAk51o3RoQuW9Wq8gotRlEeAvY
 /Qj9ef34=
X-Gm-Gg: AZuq6aLGLAi0+GZGh+lyNhF+qik3MBczFugYL3acNPBu4iyxhL0+S2a0fe9M6lggZHO
 gjsTvUxHiJp7roFCvcsxIL8YuwlW3QhSBZ2mBJV8rBxWmTGKbaRbZmhmGzPYAso4EwClpgN3Y3l
 ZtH1L3qSRkP1A3Ofqq6SQUHsqZD41POumOEO/3X+xlUWuxch5/6742wFSowVVSbK8WRsgCOpc4r
 riwdtF9OTGNDHE2Qt6r8FgBeOEhBw62BbiNKFWm+bqJ1tSKCiTs6ZLWxSd4KW11r+3pXMHkS50v
 B+PWodiFlPZIkqo9x8csH+UIO+Z+yJaeYnza9lD0w+kqXe9l6sekpcd/6XdUlbnWdKG024QjmMh
 4k6NTB0jC7Pv43RnLXvDDZvQv9s7lbuwy+DZmTLWSUXfEjGc8rMLUOLiG6+Bpj7AyJXn4K4rNRH
 jNo8Begppws3d/nQphOLi/4Bru6Ktpn5zrr5/EQayyygTUrFs232OwjhjxwwEM
X-Received: by 2002:a05:6000:430a:b0:432:a9db:f99c with SMTP id
 ffacd0b85a97d-435ca19f4f9mr8480545f8f.31.1769452935027; 
 Mon, 26 Jan 2026 10:42:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24acdsm33210429f8f.13.2026.01.26.10.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 10:42:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 3/4] devtools: add compare-reviews.sh for multi-provider
 analysis
Date: Mon, 26 Jan 2026 10:40:20 -0800
Message-ID: <20260126184205.104629-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126184205.104629-1-stephen@networkplumber.org>
References: <0260109014106.398156-1-stephen@networkplumber.org>
 <20260126184205.104629-1-stephen@networkplumber.org>
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


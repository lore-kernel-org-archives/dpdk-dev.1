Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529F2EF99DF
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 21:41:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B5BB4066E;
	Fri, 13 Feb 2026 22:41:21 +0100 (CET)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66]) by mails.dpdk.org (Postfix) with ESMTP id 9C74D40653
 for <dev@dpdk.org>; Fri, 13 Feb 2026 22:41:18 +0100 (CET)
Received: by mail-wr1-f66.google.com with SMTP id
 ffacd0b85a97d-4362197d174so924485f8f.3
 for <dev@dpdk.org>; Fri, 13 Feb 2026 13:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771018878;
 x=1771623678; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r92brlExUYKOZR+gJ8q0fvZd2nGwHIe81/wDVg0BwBo=;
 b=cbzBW48LPlu1ubWie7qUPNW54n3JvoYpHFTw8tIN/p9kY+nxdMLZ5DCRuBCbN5kQ3k
 2+As62mGEXz+ZL0YdbWZwwr4R0eDvrTakSnboCTvcWq8QIWaSiPGjdhXx+SdTOXRycrX
 YpWEWu+5DLA11s67jvosqsZKze+FsvPaHE7LUpASEbesd3MRK3r8wpEx2XxmDJTiAVTb
 q0Csj5c7AvbiOlbj9Qskht9lAEmUeAsqUWNLWRVR4kGk4l1qofkbUsF2XkwBWYY9CCnr
 nL7Ieppq5w5M9DyvCPUU+pPX4vVulRIXcpEj2zkAKLZUuSAhxFLeQzMLRj9CXDyoqQ58
 m8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771018878; x=1771623678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r92brlExUYKOZR+gJ8q0fvZd2nGwHIe81/wDVg0BwBo=;
 b=MtqwCxOKZOPm80V9hpaz9qZnT7s+iejIo6bZz9RZy8TK0B9V16EfRggSYuM9OGXrIy
 P3WENBRvbJiX5m3X6VcIpPEzxwTTig73Rx/e6AvQXGkYCCYh9ZkSeqSkq5cRUtNJlBg6
 jogA3EtvDNb3AkqIB4s/uMWRIzyADqmM9OjHBkwW8OMBtELHBq3JJmADo3aQ8zMIpfYh
 rlP4VTZvIaMi/khRAjMBfs87JQPo2qR/LpG0L2Dre40L+S4ZszXgUDY8Igfljt3yj+A3
 8MeP72Wz2JGMTcZKsVtBMM3x/noGGQPfZA5ym5sLjt59Yj4gwDtTAy5ahLA4q13Mq8lL
 2mOg==
X-Gm-Message-State: AOJu0YwKOKzi24ydxEbjeH3hAjdHxwQPVcLYAlXMje3idhpttVTGBIcL
 nH+O6FEOOYDgOCiJO1EnFAWWPdgZNM+G4jb8zS4be0sT2qA73n4WZOTZ0uq7B8+sO6mrNfvrK1H
 K1scTDcE=
X-Gm-Gg: AZuq6aLUXmAfDqMb+g7K/xHrsqgSHC3iWjT721/U1bA3rKB8ldbwF5ER9YftG9LIPJr
 E+LeoGAwEuBBmGYc+3VxunSPFw+MON68r9oo1R9sv9dQDYsEFxOWhWeM1iOg2hB0IzH6mlc4/Vn
 qj1uFkAfRpfw2/WmIvhdozL7Yuvak4JdrSTEv48gbn36bVM+R+jBEQS1jDU2rZxA2RntAgJBFAE
 l58kq+zcZfJcsgRbcoclfu5k1OvBTMuFCcGtwj1ATdFWu+69VhO4Hh/gK5BVTeDSNFSpBl+BRbC
 fDzydOyPIl8UdEB/WMXLAStz1zH51Q+lv035TfnkwSTYmFSkhXBmLxhISwHuPYz4OL5c8hek+9J
 f2Uy+zi77RSudsmqWde4ckdfl20os1ezNwygKfJFbUcS1afekPFZdUY/28+YMNBhk1q6Wd93nSM
 PiurZUj9Fu6IMrvSQ+Cey3akQc37PFmSmtgFt8IPhPLMo1Qo9D5ydbNPWQhDhDxQlZm0TFAUZ1
X-Received: by 2002:a05:6000:2dc7:b0:432:5b81:498 with SMTP id
 ffacd0b85a97d-437978dc4f9mr6430939f8f.23.1771018878359; 
 Fri, 13 Feb 2026 13:41:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac9d77sm8346895f8f.33.2026.02.13.13.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 13:41:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>
Subject: [PATCH v9 3/6] devtools: add compare-reviews.sh for multi-provider
 analysis
Date: Fri, 13 Feb 2026 13:39:08 -0800
Message-ID: <20260213214107.234072-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213214107.234072-1-stephen@networkplumber.org>
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <20260213214107.234072-1-stephen@networkplumber.org>
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


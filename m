Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95951EFCE33
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 18:03:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1334A410D4;
	Wed,  4 Mar 2026 19:03:15 +0100 (CET)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54]) by mails.dpdk.org (Postfix) with ESMTP id E087B40A6B
 for <dev@dpdk.org>; Wed,  4 Mar 2026 19:03:13 +0100 (CET)
Received: by mail-ua1-f54.google.com with SMTP id
 a1e0cc1a2514c-94de63dea9aso4507249241.3
 for <dev@dpdk.org>; Wed, 04 Mar 2026 10:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772647393;
 x=1773252193; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r92brlExUYKOZR+gJ8q0fvZd2nGwHIe81/wDVg0BwBo=;
 b=Shyp+B2aL0qWrUn3SYbF6bA8kmhAuugk7QLQn7Awmpuo87cfbePr3llUe4rdBsXGPF
 DsU9Tdvch0XCuoNZlSuISJkEfjaOuXvVhaup/sxxFs/5wLU25NqroMDzw1BBpPTBHBVd
 KubG6fIxOHfiNZLLhelLznqdzhtbbYuBaSLrljFCyGDC8n0KQivdeNDfXZSDo5p5tOi1
 7R7OUWeuTtHCs+/A2l6pGMx09p93WAhlQfqi4Fy0atVHSfUJa0frS+E0dg4rFbgxmOGE
 lteIJfgm/NEzWtWGw4k90QxtRgPmh6LaG69YqCtaui7RZ2kqsX0V2uw0H0J+G1l9xDBi
 qBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772647393; x=1773252193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r92brlExUYKOZR+gJ8q0fvZd2nGwHIe81/wDVg0BwBo=;
 b=ODq7P1qWMQGvxGZOb9XZ4StDNlfPLOL6Cx9NZ9zcEHZaQbmNePPpbDsDvZIv57zLB0
 82NoHS1AGGon5CFwRmrDdPtLDLsiKQ5gC9en7kwh/06poQE2lF1j6Z/q8zs+JtpQAXrH
 fYg5Y2BJeppHYNyD/wK5WoX1FTbEwapbejRlV6q0XaHvd0MCrmRCO+BbdpzveWDzE2y1
 wbU0BAEwE184DfBKrqKteclDjKDbTaUny86BAvekek1F75Wuca1bIJO7AcMYX18JyT8M
 VFmXrtOYQ7TF5waFiUJSNqSTwfDWqPcpMycyN976MmCb8xWRX42y2IBZU2Q98b19JfIl
 azqg==
X-Gm-Message-State: AOJu0YwahnTQVOD+MXc8otoxNNNpoYiUmpf5vyXo+RC1yD8d2k344DbR
 9XcGX+6jDjXS1ZaJ5Gm0xnOdyo+criwEa7qRehuF1V8+H4GxvDTLLWs3eYl5WJAc1dJB3fQfiON
 gvKgl3ZY=
X-Gm-Gg: ATEYQzzTkJphkNtpUk3m4JGiN5SM02+Lot+ITe6heBlKb1tDrfFA+nlX7AhxiU5/qRW
 f9RtVLWyvpzInoXtyzMDutksCJJWBaptb+ovocQTzpm/jmDKYkY3eUnyspFIWwFgqZwgPDi3qEf
 nLOra9SESB3cXWeIxO3F67g4rmn/azcRuflZqq21L2aCjiMTSnlSCVZbsnyvsJwQ6wNKME6iTwR
 8rT8bEtyiULcwttJR5su2nNdN7caswx+7SjVWTrZKQKTpTR5u09Xo5LQoK8RPgybUXZPLOI9ku+
 aiXezwuWCH8i3S39gFrJuijFcHnKMDBM49ctyka38SJVsqWXApCtrs2sPR64czd7qlqiXi2Ijzl
 LuABjjWUt1AaS7rOrPQp6h92cjByGk7TxQNG/QkkVjxWcjNClZS8ASoBXw610koJ+914XU3Kxc4
 jKjMoErDYsIZMZkEXg4EpiWiJ3F6+VvPQGI6AyXzxLf4Yr1xXhV/UpUZagZ8XSs91v6vJHA71F
X-Received: by 2002:a05:6102:c0f:b0:5fd:a537:a777 with SMTP id
 ada2fe7eead31-5ffaac97a3bmr1445814137.10.1772647391646; 
 Wed, 04 Mar 2026 10:03:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a083a95fbsm51698626d6.38.2026.03.04.10.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 10:03:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>
Subject: [PATCH v9 3/6] devtools: add compare-reviews.sh for multi-provider
 analysis
Date: Wed,  4 Mar 2026 09:59:39 -0800
Message-ID: <20260304180303.436779-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304180303.436779-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260304180303.436779-1-stephen@networkplumber.org>
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


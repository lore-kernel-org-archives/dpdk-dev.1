Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF37E9A057
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 17:51:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F4A14065A;
	Thu, 19 Feb 2026 18:51:20 +0100 (CET)
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 by mails.dpdk.org (Postfix) with ESMTP id A53F04064E
 for <dev@dpdk.org>; Thu, 19 Feb 2026 18:51:17 +0100 (CET)
Received: by mail-oi1-f194.google.com with SMTP id
 5614622812f47-463208653d6so751880b6e.3
 for <dev@dpdk.org>; Thu, 19 Feb 2026 09:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771523477;
 x=1772128277; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r92brlExUYKOZR+gJ8q0fvZd2nGwHIe81/wDVg0BwBo=;
 b=Sy5KV+bNDDI/ktDEnwNn4BEEuh32+hgn4fx0UE6pJM+Wm8D4b1pVr+zO6yA/M/RV/A
 PeNeie7hpP302SXtUrdCUuxN2vXH8vi8dDaS7oA6AOo6RjJDqG0eoCZYif0mFfpWlYkz
 5JQkncxupz7JY5g60HUTziNKzactKwdNW/eZ5zidPySEuCmo+7AJguC7eVDt3TC+TylC
 +hIYWQjn76I7T46DDvJ37pegcmviIiPsLNRRTVbX2oHafA2tGz4yegMqPmJRDzSCEQyu
 H0srTNgKNw1UMzrRREnCle6GHT8v6jQyYrOBc3/DPAzJ3tpAK1fFaAAfu/wBb+HAAmy8
 4xKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771523477; x=1772128277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r92brlExUYKOZR+gJ8q0fvZd2nGwHIe81/wDVg0BwBo=;
 b=a+giy/1rZxoFoz89nTENMd9Gu2UwK8MSYJbW/xCHUbAkrHhaja87uYdFDOAxuyD+Im
 ZQ517eEcT0pcGpuU8JVrHEAnY7+HnauOCJl3m2zlDfMlr77zxSl9A5LtIe3zIPIoXPoE
 thdm9zM6SE2O822cvSp9jaWFhriynaOqcZhDuyVeOR5l3vwkYlUHYJx4+hGGNTJA6zGG
 uhvy4aMg+Y0sJvE7WIgQl1kJx8kLkV/Atlh1+DslUrrJy0IAIk57lbORH+4RQu1s5B3v
 7wPsvbSyvhV+Mq9pIJ6M4+bGhI/Y0lElkzCOPZhksKI3dP/ahO1npBb9Jsq6oOAMJxiB
 2Adg==
X-Gm-Message-State: AOJu0YwNh+1qigfR6x7EulcKtgXI6n2sl1VdwmaspWYgPBaq8+Oxuu2Z
 Y8F7kyurG/23yItVqpzdFXr6zILfqvJFOQI/iVUYQiEp+yfB38IoYRVLB2WnLK4wLa867LNiAzb
 3oDA+JSg=
X-Gm-Gg: AZuq6aI9irS/csntjWXw3hDGLt7Wnl9u5TaKGAkwTuoM+9zj4ZLqLBnaUTUZiNl2t8j
 C5avNtZBqJIRq8g3OGL1vTA+9rVqx1bajoj9GvmNlLv9SUQIQy7+P8b+96oB3vT0QbOAS38U4pN
 3cRddkYDFJq12uY/EkY798JQ93f/UR2s4DSYGfGD/lJbDHuQcNM5+cwMpSEKzo4tNaeq6USqgzP
 RnhW5kcy0Wu5ycC2GVc0OwUyq1RGKn3MJXLgnb/YR99w9TJ7KQcrUWdWSAG2fbiTLONiF2jziSr
 Eqs6qU8Qxtq0KK0oboiI9jijc6k7THV/oCEuwUUg/bZGZAhFVWP3Gei2xc2sxDw/mJSn4lMD9Tj
 W10y6pnLMZYJvtC9iCA/ye9HF1yXU4XwL/dGS9nbXpxxC0+eu/5fa3D0C5NwP+bM6apprxX9g5F
 2+1MSHBYXtVFbSxEgplYQyLbD29dtXny/h0aXs8SyzkXPsFyDm04mdhbSTdybwDw==
X-Received: by 2002:a4a:ec41:0:b0:65f:1012:69c5 with SMTP id
 006d021491bc7-679aef3c6f9mr1872980eaf.76.1771523476830; 
 Thu, 19 Feb 2026 09:51:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67985df6ffcsm10261701eaf.4.2026.02.19.09.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:51:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 3/6] devtools: add compare-reviews.sh for multi-provider
 analysis
Date: Thu, 19 Feb 2026 09:48:48 -0800
Message-ID: <20260219175110.287747-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219175110.287747-1-stephen@networkplumber.org>
References: <20260213214107.234072-1-stephen@networkplumber.org>
 <20260219175110.287747-1-stephen@networkplumber.org>
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


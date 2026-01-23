Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7798D6CFAA
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 00:45:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7677E40652;
	Fri, 23 Jan 2026 01:44:46 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id BEDBA402E2
 for <dev@dpdk.org>; Fri, 23 Jan 2026 01:44:42 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4801d98cf39so11868065e9.1
 for <dev@dpdk.org>; Thu, 22 Jan 2026 16:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769129082;
 x=1769733882; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=90WmJJrOnWmjdDGMxfJ56XJhrtyHCB0HILaeoSbESK8=;
 b=UfnUDBl8Pjvwa2jzKTP9jzy0e3c9s4PiTreyPRCbrUjElwPabiu/Fkfl9ONhFHqGzU
 PnGZzor4CQUusQj56kVyu+b/z1pL6/0uhv/K2RmAZB9bM8LAC8wyJy8INQ6ZUz4AGQx0
 +rWXE2W6czuu9NOiHmU3yO2Ap/AeBOyNNOaafv6YwQqW1oEvoVgZYfm6WmV7i0XBbQ9Z
 U+ETx+p0YGrlQNaF3k1DbLmEW8WqctuQE6qAN39tkfvD1ubQuZpm1YRz2e61Ypj9Q+hM
 ppR2Jl46g6KXqFF/yyJBgLpehLPII/Hs5+TB1QjZYzus0Om7KnzLDRO9QBv8pg6RjYCk
 T1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769129082; x=1769733882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=90WmJJrOnWmjdDGMxfJ56XJhrtyHCB0HILaeoSbESK8=;
 b=Vd7ECbqBJalDbqGAa6l4p1493A/IfzNGMb03stGhBfbpH3VTsehR33mz6cAA/4pMu4
 ExfyOlK95x7aVFobLV5twe2H+zJtYVl4oXzM/ACcQih+5Km/k07N7+2HNDviJMf5RZ03
 XlhJAQgB+vAyZQW2zxcDK2KG8bCpFKE3+6LcDgrlzkkS6AlzcRhilKsD4KWKXWZPbR3+
 NhLIypEcLrPqPck0hV1NZ0dqihjNclOK0W8py7heIpqzOKmzB+mp9nCAH15uZtbeF+s2
 towrXm0fErW2SyPb840wgZWnoqE3n9olecd3xDazStYNaK3DuecjD2oEbAN2sJjziEZI
 Zj/A==
X-Gm-Message-State: AOJu0Yw38RIO3QZJ/SPbuqC5Kq5ZbAGZt7c7/bF0v97gVmPl9TLix5Yy
 UHMumXdNn78I4Js8DpEOJkaDOYqudJWSwLShQGsMK1lDsq40BLMrWI3b3UjksO2sbMuC+6Q03/F
 dBFJU
X-Gm-Gg: AZuq6aKCUw1oRBcikKP3NsfjURQVrGIV112Flt91GCOtTGdR1syft6AEwVQEiYcYTYF
 xfLP72sWMrAIN3oAf6X6AE/rFFy8o+RvNC39/EBbg22puujb6PXRtgj1iBRu4NBnDesrfckhrSt
 TH1YJWXgdAPkPn3rGe5v0HNN8p/JJJCDTnveit2XWrr6a1FbpvN6cdnOYkzbnajH22+mZWc8lq3
 jJppCZTjJSy1nruguAzUm9Q7qobjg/LIB8AHH+5LV5Sym6upJwpzAEc2C8oqzCFIkvIaByKZXZw
 Vr+iCl8wsnM8WbJJ65Bzn2ySTYktWHGe3xZJ110GrZNYxiezT0CF15Suy8ZADZnaJ1JmlAnW1Lf
 J/MQd5Sn0sb6AAIh/P/Ig0/mnSFW01LOaIE1UvkOjJpv6vhxTf74u9RQrAWaHalqv0RaC+thSaA
 hRmLuRs46M5AJtKYGscc66lNwer4Psr2NCnl2rFnk+6+ayO63oTQ==
X-Received: by 2002:a05:600c:3f12:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-4804c9c87bfmr22797525e9.29.1769129082334; 
 Thu, 22 Jan 2026 16:44:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804dbda9edsm5668955e9.19.2026.01.22.16.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 16:44:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 3/4] devtools: add script to compare AI reviews across
 providers
Date: Thu, 22 Jan 2026 16:42:21 -0800
Message-ID: <20260123004430.10951-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123004430.10951-1-stephen@networkplumber.org>
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <20260123004430.10951-1-stephen@networkplumber.org>
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

Add AI generated script to compare-reviews.sh script that
runs patch reviews across multiple AI providers for comparison purposes.

The script automatically detects which providers have API keys
configured and runs analyze-patch.sh for each one. This allows
users to compare review quality and feedback across different
AI models.

Features:
  - Auto-detects available providers based on environment variables
  - Optional provider selection via -p/--providers option
  - Saves individual reviews to separate files with -o/--output
  - Verbose mode passes through to underlying analyze-patch.sh

Usage:
  ./devtools/compare-reviews.sh my-patch.patch
  ./devtools/compare-reviews.sh -p anthropic,xai my-patch.patch
  ./devtools/compare-reviews.sh -o ./reviews my-patch.patch

Output files are named <patch>-<provider>.txt when using the
output directory option.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/compare-reviews.sh | 153 ++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100755 devtools/compare-reviews.sh

diff --git a/devtools/compare-reviews.sh b/devtools/compare-reviews.sh
new file mode 100755
index 0000000000..41a05a66c5
--- /dev/null
+++ b/devtools/compare-reviews.sh
@@ -0,0 +1,153 @@
+#!/bin/bash
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Stephen Hemminger
+
+# Compare DPDK patch reviews across multiple AI providers
+# Runs analyze-patch.sh with each available provider
+
+set -e
+
+SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
+ANALYZE_SCRIPT="${SCRIPT_DIR}/analyze-patch.sh"
+AGENTS_FILE="AGENTS.md"
+OUTPUT_DIR=""
+PROVIDERS=""
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
+    $(basename "$0") -o ./reviews my-patch.patch
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
+    error "analyze-patch.sh not found: $ANALYZE_SCRIPT"
+fi
+
+# Get providers to use
+if [[ -z "$PROVIDERS" ]]; then
+    PROVIDERS=$(get_available_providers)
+fi
+
+if [[ -z "$PROVIDERS" ]]; then
+    error "No API keys configured. Set at least one of: ANTHROPIC_API_KEY, OPENAI_API_KEY, XAI_API_KEY, GOOGLE_API_KEY"
+fi
+
+# Create output directory if specified
+if [[ -n "$OUTPUT_DIR" ]]; then
+    mkdir -p "$OUTPUT_DIR"
+fi
+
+PATCH_BASENAME=$(basename "$PATCH_FILE")
+echo "Reviewing patch: $PATCH_BASENAME"
+echo "Providers: $PROVIDERS"
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
+        OUTPUT_FILE="${OUTPUT_DIR}/${PATCH_BASENAME%.patch}-${provider}.txt"
+        "$ANALYZE_SCRIPT" -p "$provider" -a "$AGENTS_FILE" $VERBOSE "$PATCH_FILE" | tee "$OUTPUT_FILE"
+        echo ""
+        echo "Saved to: $OUTPUT_FILE"
+    else
+        "$ANALYZE_SCRIPT" -p "$provider" -a "$AGENTS_FILE" $VERBOSE "$PATCH_FILE"
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


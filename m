Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A2210F2846
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 15:43:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 802C842E5A;
	Fri, 27 Mar 2026 16:43:40 +0100 (CET)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 0992B42E5F
 for <dev@dpdk.org>; Fri, 27 Mar 2026 16:43:38 +0100 (CET)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-829ac4670c4so1718419b3a.0
 for <dev@dpdk.org>; Fri, 27 Mar 2026 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774626217;
 x=1775231017; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zkur96phBkhacDSBqbI8pwPlDVmFcvSsayyvHWpXhxo=;
 b=EDFN6e4+Z2srwI3ALw8a4UvZcyZ0rql8cNO7F9sWWjHel35TVzWDWfTQ3/YhA0q3qI
 X7SCYdD+35IVC5iaZ5XcRGvYDS/hDXQ1rxMqrDUH+cbGayjTItsHTUHG+XlB3o7noWKb
 tRhN60c84Ej0qdQUuJuJcuTwg6t8lUFM29ZgP4aACpy0HOi+vSmNwoFcREnGFutXiiUe
 HTjgpC3a0A0yVZVLaRMw89mVAJxOIHP7Cy813Ply35zEY7fczsxKFnCrKBQNMQ/AHocj
 9Jl2XRjVoelfv4Qt/K26izYfBPFSI6wkObGLB+2osa0NXolVmUY5oKIsulP6/fWuiPvk
 aIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774626217; x=1775231017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zkur96phBkhacDSBqbI8pwPlDVmFcvSsayyvHWpXhxo=;
 b=Iyq+bi6SoJGaEW23ZhPvAN9FGD9dhvI0+Z06h2U9VNJ+vzOWJR38RBqdtMWpsBT6cZ
 osT6CDisPfpAcf75NYIYWhq8akIdJJ+qy94eTYaS/oHHBoQ3jg+rCt1KoLm7gf2iO3hI
 lh8HVCk1WFCoIDcChb0YOk7CT98L39jTDU+3/npavPy7opylaVckywSC7RnSvUtEmP+h
 Jn/MqCbXllyn626bkGmltqmJnQnDSVN3Piw1L3BfrTujdoMyfZbdueeaJtXemiWnHuz3
 mp3l4zd5WP2H5+L2PcCFk0V47D3slf7fIFsWT78ZYI9hiN/PTsjcSwIGBTMpAY4+2v17
 slKg==
X-Gm-Message-State: AOJu0YziFZEyOji5AXHnNg7EKS504PtqFhtV7U7miUTZCtMXZwoWeIXT
 yCyG/qcbtDq9/ad56z7oOgHU4yieKV5sLhQSGgcorZl0lKVdxnCdclmanZdPZfnS7+QQNZC8pXB
 pAJsM
X-Gm-Gg: ATEYQzyFwcfUo7AtowYZd2QTDSOK6Xu0qQMkBr+Pn/fTKVvhI35S2tKzVd53YzQ9b9c
 qETU47J72mgMfqlR80vWl8LJO5m+SM7YhjU6Jg3z1zoldeLyLFg0Ae/vsJVZAIIq/iA/lzCFzij
 VlxEFaxz9MM5jwDDRu4Ay3AgKmq0dSaA8Sm1YHGzisUMxdgJHsRPwDLeCVl+uoqs6H+ZZkoCmgQ
 Ql04hfvS71ZIYIUodLUplLxzegAcF3n/IZhggVpAoD4Yrj702mdKfQSvmRH7zJeokVzBDirLF6U
 vPdMm3uvgXCZMuJyxVIrtEk5g96ACU9dlLAoYZSvkJVvs2m4qFW4ZhIStWJpnIpdeOF1+ameN/s
 k7hL8ri+FluGI3e10M6KjfY/7IBIvilTBndHHQ79mCEHtuh29GeriW6tP88rnQs/wpiM1Mmk2qP
 GEBUaXA0tS5XzCFg4x325cXGyJGHmaDofl
X-Received: by 2002:a05:6a00:4291:b0:82a:1044:356a with SMTP id
 d2e1a72fcca58-82c95d4905cmr3246611b3a.26.1774626217063; 
 Fri, 27 Mar 2026 08:43:37 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d390a4csm7508304b3a.31.2026.03.27.08.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 08:43:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 3/6] devtools: add compare-reviews.sh for multi-provider
 analysis
Date: Fri, 27 Mar 2026 08:41:54 -0700
Message-ID: <20260327154321.25800-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327154321.25800-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260327154321.25800-1-stephen@networkplumber.org>
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
2.53.0


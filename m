Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530C8D715E4
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Jan 2026 19:03:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F9AF4060F;
	Sat, 24 Jan 2026 20:03:09 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 411E4402CE
 for <dev@dpdk.org>; Sat, 24 Jan 2026 20:03:04 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4801d24d91bso35150535e9.2
 for <dev@dpdk.org>; Sat, 24 Jan 2026 11:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769281384;
 x=1769886184; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1YBguka7ApWSg+mr0YC6VH1wIMEBlPSy+obxgCL59kk=;
 b=XOdUSSiMMSEitfvUfedgXreHHPDGJKug9D9BGLo390hs56Tl5UhsDG2Eu6woJmG/Qa
 pF4L+E6tAQgua83ZQkWlpTSPco3qjiTAQzkaZQy55iL2Lf/cyTH2sR36lmFMLRExSMRk
 zp8NYDfoXrZtqKGL9SKS0DzXNpj+H1mk8OJT7bcT4bY/4Q/ku2snjGw4mT2n1uSvJtJi
 6YHFVao8pNv5Vw45apUhdQdqEmJ5o95ArkOzdsJKpg92pqy8eajtoP+p6HcMPbqgpvyn
 LG+FOE3XZFpWn1meQKy+yd+Jy/5JnORbSm3mNWS4OSov+f44vd+j2mRRLN91exaAJXbn
 Ty/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769281384; x=1769886184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1YBguka7ApWSg+mr0YC6VH1wIMEBlPSy+obxgCL59kk=;
 b=rlntnwtjrA1NddCm6JWYVCFXAoHKbVJ5+BJee6nZS/ojZRPBTpIH3CI/zisusBRm5n
 aSl0Vib3gNjWhuTWIRXVT6zg0Q+rWjBqwptevqjz43BBso1DUsrKe2S/p36K0VSsfJNY
 9eHG60umYnYNEbHSKKNHfUT0OD1KXcMpbDGWQO7JaZ8eU+zh0NoDGzPYnghui0zO5U8R
 T++iiWeYpz25HX7gPRIvaZhknxf5yr1pbUXzqu/4MflmdFL3+YyEJkwv6YQzbllYZisc
 nwdT7lmjvyQ0h9SK4s9j/4/TlYifcCiMKi3uzjaC3oxyt8jd+yFqBP8XUFvy7hVh6v+w
 yTig==
X-Gm-Message-State: AOJu0YziUreqUclycSPW+g4zjHdOLObriYSwSGmdzwnIbdT2a+bktg05
 BtsbwWii/Qir2nMIGMQ+WPio04noGIBmyd8w4anNNUk21B17byZReW2PI4qS/jfOeOOhsyxTRam
 UM/Xc
X-Gm-Gg: AZuq6aJ57wgPRjaceU9J/8QMpsxwHvgbVDnklTkwhB4DfszGYnjZKFGZx9d04oBpZoc
 JkC9eCPRDDw+ftcFR0lnakkvBBDISdkf2efX7jYrSkGmkwQZTA3ugfUV0BQbGG7jrEt74NY9lgB
 uFm76bl0PYIWB5wYMUFIwPRXobNWm/xpThM3F07veaZwyKMOTAEyWUq/7FYzHeHan2cx6PDLMRR
 /1r182k8r5AC396wkivZ5jYkKnIS0cplEx68WNDF/SvzFTFrhZc62rR5eAs28bAJAQ6BuN0MeMX
 /ClzqT+JjAXx1Jfwq9ksEVJhnyqoa9vNxt4522lOfoXwxruzx5QlEg4ZwtI5Aqse/mrJ8mOU490
 K5qRFI9TCDDrWNBillRf0OXBAc5adw8lkn53pt2frwySWhAT/ZqMRcFs/ztPwIa/6pR0+GE9Wzd
 T/EgQ8zVqnjG5HwFoqQ2IFtNUttcxOjJ5Vrfm5ToMsrRs3rkXv875IUMfEs/Ra
X-Received: by 2002:a05:600c:a18e:b0:480:3b4e:41ba with SMTP id
 5b1f17b1804b1-4804f8235damr81211575e9.18.1769281383802; 
 Sat, 24 Jan 2026 11:03:03 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745e6sm15661277f8f.33.2026.01.24.11.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 11:03:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 3/4] devtools: add script to compare AI reviews across
 providers
Date: Sat, 24 Jan 2026 11:00:32 -0800
Message-ID: <20260124190253.216424-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260124190253.216424-1-stephen@networkplumber.org>
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <20260124190253.216424-1-stephen@networkplumber.org>
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


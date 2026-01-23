Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247D7D6CFAB
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 00:45:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A6B340666;
	Fri, 23 Jan 2026 01:44:47 +0100 (CET)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66]) by mails.dpdk.org (Postfix) with ESMTP id AFBC7402F0
 for <dev@dpdk.org>; Fri, 23 Jan 2026 01:44:44 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so19174775e9.0
 for <dev@dpdk.org>; Thu, 22 Jan 2026 16:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769129084;
 x=1769733884; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VdOfMelAH3lPf8MX5DWaDzak5eOPXtlx2KWLSvAbBF0=;
 b=sdtCzO9n6F4d5axJgD/MX12AHqxJFtvi2gFmDuGJnbhVfLb8RZPE89W+ressl99sg/
 yi9qnJ9RONFyiqjdL90FDGrgaU7R8Y5XiNaGbuu9x4XZHKb5q4P+qNzQ2tNPfokoM2ZT
 iZRgYIpoIUBLCu2TP1MDBZ3PnnZG7At0+z6IDPytYNZ4kbEo81sU8UlIbPmtpJSbvI1d
 NMZswyzIP3QfaM3//l6qGT7bGgtnumJOhAK4O5t7jO1M6Nfbzx1fOQF5QqepP7l/yPNE
 zayxbTP2elQ7Ly7riRahPW4KUHqeciLSQhP0S34epQywdRGau1Q0HT9Dy672auZPq8hJ
 DY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769129084; x=1769733884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VdOfMelAH3lPf8MX5DWaDzak5eOPXtlx2KWLSvAbBF0=;
 b=vzvZ9IPYTzVi59PB+9lKhj80n1uls//+O6idt9A8iT9tsKNeZ29o93BSLPlysQV5Fk
 NUP334uz6iW+/cryLnYntb5EiXCSt/lcNLTuk7O+mCd7X/ozISXXTa4fbU4q6QTUMpUf
 JLzZCDLfR9F1CBDnHMXx00VR5xfAfHOfdzpUC4U8XmfHvjy/Z2Q+IPRII5TDV4pcq3L6
 hcRLIp8nQBa6JLxFL8xOtSRqhSCSNEKR+17vyPa2KPxNAsdlOLeZFmwcXx4Xo6lzI2s/
 i2RAT9kDAJbFpSYOQ1t6I2BW2hBKUNtELdOhdHCtIHL7Mb+8ncC5m1oLPeitvZB4on5D
 HgdA==
X-Gm-Message-State: AOJu0YwEZGajpWClO1HTelVoi6Xm4ZYojCmzGBWDWuQ9BhY8m6SMTfT8
 nlVkIx9f5KajjjzclUl5b9AKRD0fVgy4nPQgv+WYQMP4l9CBaxIY6mPuTfhBem9cl6p11+JbM8G
 lic2fMrw=
X-Gm-Gg: AZuq6aLzo0HuPhczUBQl8ajAUZgMCzkAY3TSzdCjojXOeFTkPZxzvw0FPbTmBFBpyiP
 wk+ulSIPzykFqURmNTFaWJ0a3qDKZJ8mAJq4eGD1tQyrgJIwD/Zh9CFg0P2sWjYYvXKxz+iM3mW
 BVUtyXLHFAMgSCFpB0cY8aBYQjm3LArDggbvPzit00UrTBN0Y6/OJGSfRI85h/n5VfauAG8lDie
 DzdA3g1UR0QSQuHDVvBIZ682QVjGbPB3sPphWjcpjnkN87fRJ6pcNILW0VXSVu/rTKG3lo9+EMb
 TviK0EN/jMihfF9S+cjxTs5L5pMEoCO6GSOFe6zeFJ22ZOm9w98urYFSI8a84fRhz39lzhnS5ED
 aZbVpnILL24vZf5pBhDqPRchxTbnyV/jgy3Y3GsAIhxr9uvr+16iFtH+BGnVon0/vlUAXPf9apd
 6D8VqF0lX/UR74FRi/5RswtsA7D3bUHXApLI/omU84T/qnb89Dyg==
X-Received: by 2002:a05:600c:628c:b0:471:13dd:bae7 with SMTP id
 5b1f17b1804b1-4804c9ca8bemr21576885e9.30.1769129084168; 
 Thu, 22 Jan 2026 16:44:44 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804dbda9edsm5668955e9.19.2026.01.22.16.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 16:44:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 4/4] devtools: add multi-provider AI documentation review
 script
Date: Thu, 22 Jan 2026 16:42:22 -0800
Message-ID: <20260123004430.10951-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123004430.10951-1-stephen@networkplumber.org>
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <20260123004430.10951-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add review-doc.sh script that reviews DPDK documentation files for
spelling, grammar, technical correctness, and clarity using AI
language models.

Supported AI providers:
  - Anthropic Claude (default)
  - OpenAI ChatGPT
  - xAI Grok
  - Google Gemini

The script produces two output files:
  - A unified diff with suggested changes
  - A commit message following DPDK standards

The commit message prefix is automatically determined from the
file path (e.g., doc/guides/prog_guide: for programmer's guide
files).

Features:
  - Provider selection via -p/--provider option
  - Custom model selection via -m/--model option
  - Configurable output directory via -o/--output option
  - Verbose mode shows token usage statistics
  - Uses temporary files for API requests to handle large documents
  - Prompt caching support for Anthropic to reduce costs

Usage:
  ./devtools/review-doc.sh doc/guides/prog_guide/mempool_lib.rst
  ./devtools/review-doc.sh -p xai doc/guides/nics/ixgbe.rst
  git apply mempool_lib.diff && git commit -sF mempool_lib.msg

Requires the appropriate API key environment variable to be set
for the chosen provider (ANTHROPIC_API_KEY, OPENAI_API_KEY,
XAI_API_KEY, or GOOGLE_API_KEY).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/review-doc.sh | 734 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 734 insertions(+)
 create mode 100755 devtools/review-doc.sh

diff --git a/devtools/review-doc.sh b/devtools/review-doc.sh
new file mode 100755
index 0000000000..c3b7cefca6
--- /dev/null
+++ b/devtools/review-doc.sh
@@ -0,0 +1,734 @@
+#!/bin/bash
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Stephen Hemminger
+
+# Review DPDK documentation files using AI providers with prompt caching
+# Outputs a diff file and commit message compliant with DPDK standards
+# Supported providers: anthropic (Claude), openai (ChatGPT), xai (Grok), google (Gemini)
+
+set -e
+
+# Default paths and settings
+AGENTS_FILE="AGENTS.md"
+MAX_TOKENS=8192
+OUTPUT_DIR="."
+PROVIDER="anthropic"
+
+# Temporary file for API requests (cleaned up on exit)
+REQUEST_FILE=""
+cleanup() {
+    [[ -n "$REQUEST_FILE" && -f "$REQUEST_FILE" ]] && rm -f "$REQUEST_FILE"
+}
+trap cleanup EXIT
+
+# Default models per provider
+declare -A DEFAULT_MODELS=(
+    ["anthropic"]="claude-sonnet-4-5-20250929"
+    ["openai"]="gpt-4o"
+    ["xai"]="grok-3"
+    ["google"]="gemini-2.0-flash"
+)
+
+# API endpoints per provider
+declare -A API_ENDPOINTS=(
+    ["anthropic"]="https://api.anthropic.com/v1/messages"
+    ["openai"]="https://api.openai.com/v1/chat/completions"
+    ["xai"]="https://api.x.ai/v1/chat/completions"
+    ["google"]="https://generativelanguage.googleapis.com/v1beta/models"
+)
+
+# Environment variable names for API keys
+declare -A API_KEY_VARS=(
+    ["anthropic"]="ANTHROPIC_API_KEY"
+    ["openai"]="OPENAI_API_KEY"
+    ["xai"]="XAI_API_KEY"
+    ["google"]="GOOGLE_API_KEY"
+)
+
+usage() {
+    cat <<- END_OF_HELP
+	usage: $(basename "$0") [OPTIONS] <doc-file>
+
+	Review a DPDK documentation file for spelling, grammar, correctness and clarity.
+	Produces a diff file and commit message compliant with DPDK standards.
+
+	Options:
+	    -p, --provider NAME  AI provider: anthropic, openai, xai, google
+	                         (default: anthropic)
+	    -a, --agents FILE    Path to AGENTS.md file (default: AGENTS.md)
+	    -m, --model MODEL    Model to use (provider-specific, see defaults below)
+	    -t, --tokens NUM     Max tokens for response (default: $MAX_TOKENS)
+	    -o, --output DIR     Output directory for diff and commit msg (default: .)
+	    -v, --verbose        Show API request details
+	    -l, --list-providers List available providers and their defaults
+	    -h, --help           Show this help message
+
+	Providers and Default Models:
+	    anthropic    Claude (claude-sonnet-4-5-20250929)
+	    openai       ChatGPT (gpt-4o)
+	    xai          Grok (grok-3)
+	    google       Gemini (gemini-2.0-flash)
+
+	Environment Variables (set the one for your chosen provider):
+	    ANTHROPIC_API_KEY    For Anthropic Claude
+	    OPENAI_API_KEY       For OpenAI ChatGPT
+	    XAI_API_KEY          For xAI Grok
+	    GOOGLE_API_KEY       For Google Gemini
+
+	Output files:
+	    <basename>.diff      Unified diff with suggested changes
+	    <basename>.msg       Commit message (without Signed-off-by)
+
+	Examples:
+	    $(basename "$0") doc/guides/prog_guide/mempool_lib.rst
+	    $(basename "$0") -p openai -o /tmp doc/guides/nics/ixgbe.rst
+	    $(basename "$0") -p xai doc/guides/cryptodevs/qat.rst
+	    git apply <basename>.diff && git commit -sF <basename>.msg
+	END_OF_HELP
+    exit "${1:-0}"
+}
+
+list_providers() {
+    echo "Available AI Providers:"
+    echo ""
+    printf "%-12s %-35s %s\n" "Provider" "Default Model" "API Key Variable"
+    printf "%-12s %-35s %s\n" "--------" "-------------" "----------------"
+    for provider in anthropic openai xai google; do
+        printf "%-12s %-35s %s\n" "$provider" "${DEFAULT_MODELS[$provider]}" "${API_KEY_VARS[$provider]}"
+    done
+    exit 0
+}
+
+error() {
+    echo "Error: $1" >&2
+    exit 1
+}
+
+# Read file contents, escaping for JSON
+read_json_escaped() {
+    local file="$1"
+    python3 -c "
+import json
+with open('$file', 'r') as f:
+    print(json.dumps(f.read()))
+"
+}
+
+# Determine commit message prefix from file path
+get_commit_prefix() {
+    local filepath="$1"
+    case "$filepath" in
+        doc/guides/prog_guide/*)
+            echo "doc/guides/prog_guide:" ;;
+        doc/guides/sample_app_ug/*)
+            echo "doc/guides/sample_app:" ;;
+        doc/guides/nics/*)
+            echo "doc/guides/nics:" ;;
+        doc/guides/cryptodevs/*)
+            echo "doc/guides/cryptodevs:" ;;
+        doc/guides/compressdevs/*)
+            echo "doc/guides/compressdevs:" ;;
+        doc/guides/eventdevs/*)
+            echo "doc/guides/eventdevs:" ;;
+        doc/guides/rawdevs/*)
+            echo "doc/guides/rawdevs:" ;;
+        doc/guides/bbdevs/*)
+            echo "doc/guides/bbdevs:" ;;
+        doc/guides/gpus/*)
+            echo "doc/guides/gpus:" ;;
+        doc/guides/dmadevs/*)
+            echo "doc/guides/dmadevs:" ;;
+        doc/guides/regexdevs/*)
+            echo "doc/guides/regexdevs:" ;;
+        doc/guides/mldevs/*)
+            echo "doc/guides/mldevs:" ;;
+        doc/guides/rel_notes/*)
+            echo "doc/guides/rel_notes:" ;;
+        doc/guides/linux_gsg/*)
+            echo "doc/guides/linux_gsg:" ;;
+        doc/guides/freebsd_gsg/*)
+            echo "doc/guides/freebsd_gsg:" ;;
+        doc/guides/windows_gsg/*)
+            echo "doc/guides/windows_gsg:" ;;
+        doc/guides/tools/*)
+            echo "doc/guides/tools:" ;;
+        doc/guides/testpmd_app_ug/*)
+            echo "doc/guides/testpmd:" ;;
+        doc/guides/howto/*)
+            echo "doc/guides/howto:" ;;
+        doc/guides/contributing/*)
+            echo "doc/guides/contributing:" ;;
+        doc/guides/platform/*)
+            echo "doc/guides/platform:" ;;
+        doc/guides/*)
+            echo "doc:" ;;
+        doc/api/*)
+            echo "doc/api:" ;;
+        doc/*)
+            echo "doc:" ;;
+        *)
+            echo "doc:" ;;
+    esac
+}
+
+# System prompt for documentation review
+SYSTEM_PROMPT='You are an expert technical documentation reviewer for DPDK (Data Plane Development Kit).
+Your task is to review documentation files and suggest improvements for:
+- Spelling errors
+- Grammar issues
+- Technical correctness
+- Clarity and readability
+- Consistency with DPDK terminology
+
+IMPORTANT COMMIT MESSAGE RULES (from check-git-log.sh):
+- Subject line MUST be ≤60 characters
+- Format: "prefix: lowercase description"
+- First word after colon must be lowercase (except acronyms like Rx, Tx, VF, MAC, API)
+- Use imperative mood (e.g., "fix typo" not "fixed typo" or "fixes typo")
+- NO trailing period on subject line
+- NO punctuation marks: , ; ! ? & |
+- NO underscores in subject after colon
+- Body lines wrapped at 75 characters
+- Body must NOT start with "It"
+- Do NOT include Signed-off-by (user adds via git commit --sign)
+- Only use "Fixes:" tag for actual errors in documentation, not style improvements
+
+Case-sensitive terms (must use exact case):
+- Rx, Tx (not RX, TX, rx, tx)
+- VF, PF (not vf, pf)
+- MAC, VLAN, RSS, API
+- Linux, Windows, FreeBSD
+
+For style/clarity improvements, do NOT use Fixes tag.
+For actual errors (wrong information, broken examples), include Fixes tag if you can identify the commit.
+
+OUTPUT FORMAT:
+You must output exactly two sections:
+
+1. COMMIT_MESSAGE section containing the complete commit message
+2. UNIFIED_DIFF section containing the unified diff
+
+Use these exact markers:
+---COMMIT_MESSAGE_START---
+(commit message here)
+---COMMIT_MESSAGE_END---
+
+---UNIFIED_DIFF_START---
+(unified diff here)
+---UNIFIED_DIFF_END---
+
+The diff should be in unified format that can be applied with "git apply".
+If no changes are needed, output empty sections with a note.'
+
+# Build request for Anthropic Claude API
+build_anthropic_request() {
+    local model="$1"
+    local max_tokens="$2"
+    local agents_content="$3"
+    local doc_content="$4"
+    local doc_file="$5"
+    local commit_prefix="$6"
+    local system_prompt_escaped
+    system_prompt_escaped=$(echo "$SYSTEM_PROMPT" | python3 -c "import json,sys; print(json.dumps(sys.stdin.read()))")
+
+    cat <<EOF
+{
+    "model": "$model",
+    "max_tokens": $max_tokens,
+    "system": [
+        {
+            "type": "text",
+            "text": $system_prompt_escaped
+        },
+        {
+            "type": "text",
+            "text": $agents_content,
+            "cache_control": {"type": "ephemeral"}
+        }
+    ],
+    "messages": [
+        {
+            "role": "user",
+            "content": "Review the following DPDK documentation file and provide improvements.\n\nFile path: $doc_file\nCommit message prefix to use: $commit_prefix\n\nProvide a unified diff and commit message following DPDK standards.\n\n---DOCUMENT CONTENT---"
+        },
+        {
+            "role": "user",
+            "content": $doc_content
+        }
+    ]
+}
+EOF
+}
+
+# Build request for OpenAI-compatible APIs (OpenAI, xAI)
+build_openai_request() {
+    local model="$1"
+    local max_tokens="$2"
+    local agents_content="$3"
+    local doc_content="$4"
+    local doc_file="$5"
+    local commit_prefix="$6"
+    local system_prompt_escaped
+    system_prompt_escaped=$(echo "$SYSTEM_PROMPT" | python3 -c "import json,sys; print(json.dumps(sys.stdin.read()))")
+
+    cat <<EOF
+{
+    "model": "$model",
+    "max_tokens": $max_tokens,
+    "messages": [
+        {
+            "role": "system",
+            "content": $system_prompt_escaped
+        },
+        {
+            "role": "system",
+            "content": $agents_content
+        },
+        {
+            "role": "user",
+            "content": "Review the following DPDK documentation file and provide improvements.\n\nFile path: $doc_file\nCommit message prefix to use: $commit_prefix\n\nProvide a unified diff and commit message following DPDK standards.\n\n---DOCUMENT CONTENT---"
+        },
+        {
+            "role": "user",
+            "content": $doc_content
+        }
+    ]
+}
+EOF
+}
+
+# Build request for Google Gemini API
+build_google_request() {
+    local max_tokens="$1"
+    local agents_content="$2"
+    local doc_content="$3"
+    local doc_file="$4"
+    local commit_prefix="$5"
+    local system_prompt_escaped
+    system_prompt_escaped=$(echo "$SYSTEM_PROMPT" | python3 -c "import json,sys; print(json.dumps(sys.stdin.read()))")
+
+    cat <<EOF
+{
+    "contents": [
+        {
+            "role": "user",
+            "parts": [
+                {
+                    "text": $system_prompt_escaped
+                }
+            ]
+        },
+        {
+            "role": "user",
+            "parts": [
+                {
+                    "text": $agents_content
+                }
+            ]
+        },
+        {
+            "role": "user",
+            "parts": [
+                {
+                    "text": "Review the following DPDK documentation file and provide improvements.\n\nFile path: $doc_file\nCommit message prefix to use: $commit_prefix\n\nProvide a unified diff and commit message following DPDK standards.\n\n---DOCUMENT CONTENT---"
+                }
+            ]
+        },
+        {
+            "role": "user",
+            "parts": [
+                {
+                    "text": $doc_content
+                }
+            ]
+        }
+    ],
+    "generationConfig": {
+        "maxOutputTokens": $max_tokens
+    }
+}
+EOF
+}
+
+# Make API request for Anthropic
+call_anthropic_api() {
+    local request="$1"
+    local api_key="$2"
+
+    REQUEST_FILE=$(mktemp)
+    echo "$request" > "$REQUEST_FILE"
+
+    curl -s "${API_ENDPOINTS[anthropic]}" \
+        -H "content-type: application/json" \
+        -H "x-api-key: $api_key" \
+        -H "anthropic-version: 2023-06-01" \
+        -d "@$REQUEST_FILE"
+}
+
+# Make API request for OpenAI
+call_openai_api() {
+    local request="$1"
+    local api_key="$2"
+
+    REQUEST_FILE=$(mktemp)
+    echo "$request" > "$REQUEST_FILE"
+
+    curl -s "${API_ENDPOINTS[openai]}" \
+        -H "Content-Type: application/json" \
+        -H "Authorization: Bearer $api_key" \
+        -d "@$REQUEST_FILE"
+}
+
+# Make API request for xAI (Grok)
+call_xai_api() {
+    local request="$1"
+    local api_key="$2"
+
+    REQUEST_FILE=$(mktemp)
+    echo "$request" > "$REQUEST_FILE"
+
+    curl -s "${API_ENDPOINTS[xai]}" \
+        -H "Content-Type: application/json" \
+        -H "Authorization: Bearer $api_key" \
+        -d "@$REQUEST_FILE"
+}
+
+# Make API request for Google Gemini
+call_google_api() {
+    local request="$1"
+    local api_key="$2"
+    local model="$3"
+
+    REQUEST_FILE=$(mktemp)
+    echo "$request" > "$REQUEST_FILE"
+
+    curl -s "${API_ENDPOINTS[google]}/${model}:generateContent?key=${api_key}" \
+        -H "Content-Type: application/json" \
+        -d "@$REQUEST_FILE"
+}
+
+# Extract response text from Anthropic response
+extract_anthropic_response() {
+    python3 -c "
+import json
+import sys
+data = json.load(sys.stdin)
+if 'error' in data:
+    err = data['error']
+    print(f\"Error type: {err.get('type', 'unknown')}\", file=sys.stderr)
+    print(f\"Error message: {err.get('message', 'unknown')}\", file=sys.stderr)
+    sys.exit(1)
+text = ''
+for block in data.get('content', []):
+    if block.get('type') == 'text':
+        text += block.get('text', '')
+print(text)
+"
+}
+
+# Extract response text from OpenAI/xAI response
+extract_openai_response() {
+    python3 -c "
+import json
+import sys
+data = json.load(sys.stdin)
+if 'error' in data:
+    err = data['error']
+    print(f\"Error type: {err.get('type', 'unknown')}\", file=sys.stderr)
+    print(f\"Error message: {err.get('message', 'unknown')}\", file=sys.stderr)
+    print(f\"Error code: {err.get('code', 'unknown')}\", file=sys.stderr)
+    sys.exit(1)
+choices = data.get('choices', [])
+if choices:
+    message = choices[0].get('message', {})
+    print(message.get('content', ''))
+else:
+    print('No response content received', file=sys.stderr)
+"
+}
+
+# Extract response text from Google Gemini response
+extract_google_response() {
+    python3 -c "
+import json
+import sys
+data = json.load(sys.stdin)
+if 'error' in data:
+    err = data['error']
+    print(f\"Error code: {err.get('code', 'unknown')}\", file=sys.stderr)
+    print(f\"Error message: {err.get('message', 'unknown')}\", file=sys.stderr)
+    print(f\"Error status: {err.get('status', 'unknown')}\", file=sys.stderr)
+    sys.exit(1)
+candidates = data.get('candidates', [])
+if candidates:
+    content = candidates[0].get('content', {})
+    parts = content.get('parts', [])
+    for part in parts:
+        print(part.get('text', ''))
+else:
+    print('No response candidates received', file=sys.stderr)
+"
+}
+
+# Show verbose info for Anthropic
+show_anthropic_verbose() {
+    python3 -c "
+import json
+import sys
+data = json.load(sys.stdin)
+usage = data.get('usage', {})
+print(f\"Input tokens: {usage.get('input_tokens', 'N/A')}\")
+print(f\"Cache creation: {usage.get('cache_creation_input_tokens', 0)}\")
+print(f\"Cache read: {usage.get('cache_read_input_tokens', 0)}\")
+print(f\"Output tokens: {usage.get('output_tokens', 'N/A')}\")
+"
+}
+
+# Show verbose info for OpenAI/xAI
+show_openai_verbose() {
+    python3 -c "
+import json
+import sys
+data = json.load(sys.stdin)
+usage = data.get('usage', {})
+print(f\"Prompt tokens: {usage.get('prompt_tokens', 'N/A')}\")
+print(f\"Completion tokens: {usage.get('completion_tokens', 'N/A')}\")
+print(f\"Total tokens: {usage.get('total_tokens', 'N/A')}\")
+"
+}
+
+# Show verbose info for Google
+show_google_verbose() {
+    python3 -c "
+import json
+import sys
+data = json.load(sys.stdin)
+usage = data.get('usageMetadata', {})
+print(f\"Prompt tokens: {usage.get('promptTokenCount', 'N/A')}\")
+print(f\"Output tokens: {usage.get('candidatesTokenCount', 'N/A')}\")
+print(f\"Total tokens: {usage.get('totalTokenCount', 'N/A')}\")
+"
+}
+
+# Parse the response and write output files
+parse_and_write_output() {
+    local text="$1"
+    local msg_file="$2"
+    local diff_file="$3"
+
+    python3 -c "
+import re
+import sys
+
+text = '''$text'''
+
+# Extract commit message
+msg_match = re.search(r'---COMMIT_MESSAGE_START---\s*\n(.*?)\n---COMMIT_MESSAGE_END---', text, re.DOTALL)
+if msg_match:
+    msg = msg_match.group(1).strip()
+    with open('$msg_file', 'w') as f:
+        f.write(msg + '\n')
+    print(f'Commit message written to: $msg_file', file=sys.stderr)
+else:
+    print('Warning: Could not extract commit message', file=sys.stderr)
+    with open('$msg_file', 'w') as f:
+        f.write('# No commit message generated\n')
+
+# Extract unified diff
+diff_match = re.search(r'---UNIFIED_DIFF_START---\s*\n(.*?)\n---UNIFIED_DIFF_END---', text, re.DOTALL)
+if diff_match:
+    diff = diff_match.group(1).strip()
+    # Clean up any markdown code fence if present
+    diff = re.sub(r'^\`\`\`diff\s*\n?', '', diff)
+    diff = re.sub(r'\n?\`\`\`\s*$', '', diff)
+    with open('$diff_file', 'w') as f:
+        f.write(diff + '\n')
+    print(f'Diff written to: $diff_file', file=sys.stderr)
+else:
+    print('Warning: Could not extract diff', file=sys.stderr)
+    with open('$diff_file', 'w') as f:
+        f.write('# No changes suggested\n')
+
+# Also print full response for review
+print('\n=== Full Review ===')
+print(text)
+"
+}
+
+# Parse command line options
+VERBOSE=0
+MODEL=""
+
+while [[ $# -gt 0 ]]; do
+    case "$1" in
+        -p|--provider)
+            PROVIDER="$2"
+            shift 2
+            ;;
+        -a|--agents)
+            AGENTS_FILE="$2"
+            shift 2
+            ;;
+        -m|--model)
+            MODEL="$2"
+            shift 2
+            ;;
+        -t|--tokens)
+            MAX_TOKENS="$2"
+            shift 2
+            ;;
+        -o|--output)
+            OUTPUT_DIR="$2"
+            shift 2
+            ;;
+        -v|--verbose)
+            VERBOSE=1
+            shift
+            ;;
+        -l|--list-providers)
+            list_providers
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
+# Validate provider
+if [[ ! -v "DEFAULT_MODELS[$PROVIDER]" ]]; then
+    error "Unknown provider: $PROVIDER. Use -l to list available providers."
+fi
+
+# Set default model if not specified
+if [[ -z "$MODEL" ]]; then
+    MODEL="${DEFAULT_MODELS[$PROVIDER]}"
+fi
+
+# Check for required arguments
+if [[ $# -lt 1 ]]; then
+    echo "Error: No documentation file specified" >&2
+    usage 1
+fi
+
+DOC_FILE="$1"
+
+# Get the API key variable name and check it's set
+API_KEY_VAR="${API_KEY_VARS[$PROVIDER]}"
+API_KEY="${!API_KEY_VAR}"
+
+if [[ -z "$API_KEY" ]]; then
+    error "$API_KEY_VAR environment variable not set"
+fi
+
+# Validate files exist
+if [[ ! -f "$AGENTS_FILE" ]]; then
+    error "AGENTS.md not found: $AGENTS_FILE"
+fi
+
+if [[ ! -f "$DOC_FILE" ]]; then
+    error "Documentation file not found: $DOC_FILE"
+fi
+
+# Create output directory if needed
+mkdir -p "$OUTPUT_DIR"
+
+# Derive output filenames
+DOC_BASENAME=$(basename "$DOC_FILE" | sed 's/\.[^.]*$//')
+DIFF_FILE="$OUTPUT_DIR/${DOC_BASENAME}.diff"
+MSG_FILE="$OUTPUT_DIR/${DOC_BASENAME}.msg"
+
+# Get commit prefix
+COMMIT_PREFIX=$(get_commit_prefix "$DOC_FILE")
+
+# Read file contents
+AGENTS_CONTENT=$(read_json_escaped "$AGENTS_FILE")
+DOC_CONTENT=$(read_json_escaped "$DOC_FILE")
+
+if [[ $VERBOSE -eq 1 ]]; then
+    echo "=== Request ===" >&2
+    echo "Provider: $PROVIDER" >&2
+    echo "Model: $MODEL" >&2
+    echo "AGENTS file: $AGENTS_FILE" >&2
+    echo "Doc file: $DOC_FILE" >&2
+    echo "Commit prefix: $COMMIT_PREFIX" >&2
+    echo "Output dir: $OUTPUT_DIR" >&2
+    echo "===============" >&2
+fi
+
+# Build and send request based on provider
+case "$PROVIDER" in
+    anthropic)
+        REQUEST=$(build_anthropic_request "$MODEL" "$MAX_TOKENS" "$AGENTS_CONTENT" "$DOC_CONTENT" "$DOC_FILE" "$COMMIT_PREFIX")
+        RESPONSE=$(call_anthropic_api "$REQUEST" "$API_KEY")
+
+        if [[ $VERBOSE -eq 1 ]]; then
+            echo "=== Token Usage ===" >&2
+            echo "$RESPONSE" | show_anthropic_verbose >&2
+            echo "===================" >&2
+        fi
+
+        RESPONSE_TEXT=$(echo "$RESPONSE" | extract_anthropic_response)
+        ;;
+
+    openai)
+        REQUEST=$(build_openai_request "$MODEL" "$MAX_TOKENS" "$AGENTS_CONTENT" "$DOC_CONTENT" "$DOC_FILE" "$COMMIT_PREFIX")
+        RESPONSE=$(call_openai_api "$REQUEST" "$API_KEY")
+
+        if [[ $VERBOSE -eq 1 ]]; then
+            echo "=== Token Usage ===" >&2
+            echo "$RESPONSE" | show_openai_verbose >&2
+            echo "===================" >&2
+        fi
+
+        RESPONSE_TEXT=$(echo "$RESPONSE" | extract_openai_response)
+        ;;
+
+    xai)
+        REQUEST=$(build_openai_request "$MODEL" "$MAX_TOKENS" "$AGENTS_CONTENT" "$DOC_CONTENT" "$DOC_FILE" "$COMMIT_PREFIX")
+        RESPONSE=$(call_xai_api "$REQUEST" "$API_KEY")
+
+        if [[ $VERBOSE -eq 1 ]]; then
+            echo "=== Token Usage ===" >&2
+            echo "$RESPONSE" | show_openai_verbose >&2
+            echo "===================" >&2
+        fi
+
+        RESPONSE_TEXT=$(echo "$RESPONSE" | extract_openai_response)
+        ;;
+
+    google)
+        REQUEST=$(build_google_request "$MAX_TOKENS" "$AGENTS_CONTENT" "$DOC_CONTENT" "$DOC_FILE" "$COMMIT_PREFIX")
+        RESPONSE=$(call_google_api "$REQUEST" "$API_KEY" "$MODEL")
+
+        if [[ $VERBOSE -eq 1 ]]; then
+            echo "=== Token Usage ===" >&2
+            echo "$RESPONSE" | show_google_verbose >&2
+            echo "===================" >&2
+        fi
+
+        RESPONSE_TEXT=$(echo "$RESPONSE" | extract_google_response)
+        ;;
+esac
+
+# Check if we got a response
+if [[ -z "$RESPONSE_TEXT" ]]; then
+    error "No response received from $PROVIDER"
+fi
+
+# Parse response and write output files
+parse_and_write_output "$RESPONSE_TEXT" "$MSG_FILE" "$DIFF_FILE"
+
+echo ""
+echo "=== Output Files ==="
+echo "Commit message: $MSG_FILE"
+echo "Diff file:      $DIFF_FILE"
+echo ""
+echo "To apply changes:"
+echo "  git apply $DIFF_FILE"
+echo "  git commit -sF $MSG_FILE"
-- 
2.51.0


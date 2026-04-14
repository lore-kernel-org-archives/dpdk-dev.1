Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614F9F9D0F1
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 19:58:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E5434028F;
	Tue, 14 Apr 2026 21:58:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 278044028D
 for <dev@dpdk.org>; Tue, 14 Apr 2026 21:58:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776196727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xXHCyNizpAgy+zcsqSvEATQfk/psUru3RfeysAPvEkM=;
 b=dXBn3d8FCRoRy5BSuZk5JrypkF5cytRWKBRDlZKCVSsP7Pvf5tiONU82gsTDBPXuIAxH0q
 NfG+IMEY7CZvZYcLi5/c23kKJ0PRqgdy8YDsUUu4Y2ZUTIR//dBE/ydLHDVDNBAK7uE3V4
 75GUvnAUk82N0npLc5ASs7puLHN/jxE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-NDlXVB15NFedgB96658QXQ-1; Tue,
 14 Apr 2026 15:58:45 -0400
X-MC-Unique: NDlXVB15NFedgB96658QXQ-1
X-Mimecast-MFC-AGG-ID: NDlXVB15NFedgB96658QXQ_1776196725
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E9FF1955DD1; Tue, 14 Apr 2026 19:58:45 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.47])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5623A195608E; Tue, 14 Apr 2026 19:58:44 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v13 3/6] devtools: add compare-reviews.sh for
 multi-provider analysis
In-Reply-To: <20260402194618.134002-4-stephen@networkplumber.org> (Stephen
 Hemminger's message of "Thu, 2 Apr 2026 12:44:33 -0700")
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260402194618.134002-1-stephen@networkplumber.org>
 <20260402194618.134002-4-stephen@networkplumber.org>
Date: Tue, 14 Apr 2026 15:58:42 -0400
Message-ID: <f7t340x9uvh.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FSM0k0TO2jHCL88msI9odsMjBtWstKJXGT-6vO5hoLg_1776196725
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Stephen Hemminger <stephen@networkplumber.org> writes:

> Add script to run patch reviews across multiple AI providers for
> comparison purposes.
>
> The script automatically detects which providers have API keys
> configured and runs analyze-patch.py for each one. This allows
> users to compare review quality and feedback across different
> AI models.
>
> Features:
>   - Auto-detects available providers based on environment variables
>   - Optional provider selection via -p/--providers option
>   - Saves individual reviews to separate files with -o/--output
>   - Verbose mode passes through to underlying analyze-patch.py
>
> Usage:
>   ./devtools/compare-reviews.sh my-patch.patch
>   ./devtools/compare-reviews.sh -p anthropic,xai my-patch.patch
>   ./devtools/compare-reviews.sh -o ./reviews my-patch.patch
>
> Output files are named <patch>-<provider>.txt when using the
> output directory option.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Way cool!

Acked-by: Aaron Conole <aconole@redhat.com>

>  devtools/compare-reviews.sh | 263 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 263 insertions(+)
>  create mode 100755 devtools/compare-reviews.sh
>
> diff --git a/devtools/compare-reviews.sh b/devtools/compare-reviews.sh
> new file mode 100755
> index 0000000000..b4813cb6a7
> --- /dev/null
> +++ b/devtools/compare-reviews.sh
> @@ -0,0 +1,263 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2026 Stephen Hemminger
> +
> +# Compare DPDK patch reviews across multiple AI providers
> +# Runs analyze-patch.py with each available provider
> +
> +set -o pipefail
> +
> +SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
> +ANALYZE_SCRIPT="${SCRIPT_DIR}/analyze-patch.py"
> +AGENTS_FILE="AGENTS.md"
> +OUTPUT_DIR=""
> +PROVIDERS=""
> +FORMAT="text"
> +VERBOSE=""
> +EXTRA_ARGS=()
> +
> +usage() {
> +    cat <<EOF
> +Usage: $(basename "$0") [OPTIONS] <patch-file>
> +
> +Compare DPDK patch reviews across multiple AI providers.
> +
> +Options:
> +    -a, --agents FILE      Path to AGENTS.md file (default: AGENTS.md)
> +    -o, --output DIR       Save individual reviews to directory
> +    -p, --providers LIST   Comma-separated list of providers to use
> +                           (default: all providers with API keys set)
> +    -f, --format FORMAT    Output format: text, markdown, html, json
> +                           (default: text)
> +    -t, --tokens N         Max tokens for response
> +    -D, --date DATE        Review date context (YYYY-MM-DD)
> +    -r, --release VERSION  Target DPDK release (e.g., 24.11, 23.11-lts)
> +    --split-patches        Split mbox into individual patches
> +    --patch-range N-M      Review only patches N through M
> +    --large-file MODE      Handle large files: error, truncate, chunk,
> +                           commits-only, summary
> +    --max-tokens N         Max input tokens
> +    -v, --verbose          Show verbose output from each provider
> +    -h, --help             Show this help message
> +
> +Environment Variables:
> +    Set API keys for providers you want to use:
> +    ANTHROPIC_API_KEY, OPENAI_API_KEY, XAI_API_KEY, GOOGLE_API_KEY
> +
> +Examples:
> +    $(basename "$0") my-patch.patch
> +    $(basename "$0") -p anthropic,openai my-patch.patch
> +    $(basename "$0") -o ./reviews -f markdown my-patch.patch
> +    $(basename "$0") -r 24.11 --split-patches series.mbox
> +EOF
> +    exit "${1:-0}"
> +}
> +
> +error() {
> +    echo "Error: $1" >&2
> +    exit 1
> +}
> +
> +# Check which providers have API keys configured
> +get_available_providers() {
> +    local available=""
> +
> +    [[ -n "$ANTHROPIC_API_KEY" ]] && available="${available}anthropic,"
> +    [[ -n "$OPENAI_API_KEY" ]] && available="${available}openai,"
> +    [[ -n "$XAI_API_KEY" ]] && available="${available}xai,"
> +    [[ -n "$GOOGLE_API_KEY" ]] && available="${available}google,"
> +
> +    # Remove trailing comma
> +    echo "${available%,}"
> +}
> +
> +# Get file extension for format
> +get_extension() {
> +    case "$1" in
> +        text)     echo "txt" ;;
> +        markdown) echo "md" ;;
> +        html)     echo "html" ;;
> +        json)     echo "json" ;;
> +        *)        echo "txt" ;;
> +    esac
> +}
> +
> +# Parse command line options
> +while [[ $# -gt 0 ]]; do
> +    case "$1" in
> +        -a|--agents)
> +            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
> +            AGENTS_FILE="$2"
> +            shift 2
> +            ;;
> +        -o|--output)
> +            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
> +            OUTPUT_DIR="$2"
> +            shift 2
> +            ;;
> +        -p|--providers)
> +            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
> +            PROVIDERS="$2"
> +            shift 2
> +            ;;
> +        -f|--format)
> +            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
> +            FORMAT="$2"
> +            shift 2
> +            ;;
> +        -t|--tokens)
> +            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
> +            EXTRA_ARGS+=("-t" "$2")
> +            shift 2
> +            ;;
> +        -D|--date)
> +            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
> +            EXTRA_ARGS+=("-D" "$2")
> +            shift 2
> +            ;;
> +        -r|--release)
> +            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
> +            EXTRA_ARGS+=("-r" "$2")
> +            shift 2
> +            ;;
> +        --split-patches)
> +            EXTRA_ARGS+=("--split-patches")
> +            shift
> +            ;;
> +        --patch-range)
> +            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
> +            EXTRA_ARGS+=("--patch-range" "$2")
> +            shift 2
> +            ;;
> +        --large-file)
> +            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
> +            EXTRA_ARGS+=("--large-file" "$2")
> +            shift 2
> +            ;;
> +        --large-file=*)
> +            EXTRA_ARGS+=("$1")
> +            shift
> +            ;;
> +        --max-tokens)
> +            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"
> +            EXTRA_ARGS+=("--max-tokens" "$2")
> +            shift 2
> +            ;;
> +        -v|--verbose)
> +            VERBOSE="-v"
> +            shift
> +            ;;
> +        -h|--help)
> +            usage 0
> +            ;;
> +        -*)
> +            error "Unknown option: $1"
> +            ;;
> +        *)
> +            break
> +            ;;
> +    esac
> +done
> +
> +# Check for required arguments
> +if [[ $# -lt 1 ]]; then
> +    echo "Error: No patch file specified" >&2
> +    usage 1
> +fi
> +
> +PATCH_FILE="$1"
> +
> +if [[ ! -f "$PATCH_FILE" ]]; then
> +    error "Patch file not found: $PATCH_FILE"
> +fi
> +
> +if [[ ! -f "$ANALYZE_SCRIPT" ]]; then
> +    error "analyze-patch.py not found: $ANALYZE_SCRIPT"
> +fi
> +
> +if [[ ! -f "$AGENTS_FILE" ]]; then
> +    error "AGENTS.md not found: $AGENTS_FILE"
> +fi
> +
> +# Validate format
> +case "$FORMAT" in
> +    text|markdown|html|json) ;;
> +    *) error "Invalid format: $FORMAT (must be text, markdown, html, or json)" ;;
> +esac
> +
> +# Get providers to use
> +if [[ -z "$PROVIDERS" ]]; then
> +    PROVIDERS=$(get_available_providers)
> +fi
> +
> +if [[ -z "$PROVIDERS" ]]; then
> +    error "No API keys configured. Set at least one of: "\
> +"ANTHROPIC_API_KEY, OPENAI_API_KEY, XAI_API_KEY, GOOGLE_API_KEY"
> +fi
> +
> +# Create output directory if specified
> +if [[ -n "$OUTPUT_DIR" ]]; then
> +    mkdir -p "$OUTPUT_DIR"
> +fi
> +
> +PATCH_BASENAME=$(basename "$PATCH_FILE")
> +PATCH_STEM="${PATCH_BASENAME%.*}"
> +EXT=$(get_extension "$FORMAT")
> +
> +echo "Reviewing patch: $PATCH_BASENAME"
> +echo "Providers: $PROVIDERS"
> +echo "Format: $FORMAT"
> +echo "========================================"
> +echo ""
> +
> +# Run review for each provider, continue on failure
> +IFS=',' read -ra PROVIDER_LIST <<< "$PROVIDERS"
> +failures=0
> +for provider in "${PROVIDER_LIST[@]}"; do
> +    echo ">>> Running review with: $provider"
> +    echo ""
> +
> +    if [[ -n "$OUTPUT_DIR" ]]; then
> +        OUTPUT_FILE="${OUTPUT_DIR}/${PATCH_STEM}-${provider}.${EXT}"
> +        if python3 "$ANALYZE_SCRIPT" \
> +            -p "$provider" \
> +            -a "$AGENTS_FILE" \
> +            -f "$FORMAT" \
> +            ${VERBOSE:+"$VERBOSE"} \
> +            "${EXTRA_ARGS[@]}" \
> +            "$PATCH_FILE" | tee "$OUTPUT_FILE"; then
> +            echo ""
> +            echo "Saved to: $OUTPUT_FILE"
> +        else
> +            echo "FAILED: $provider review failed" >&2
> +            rm -f "$OUTPUT_FILE"
> +            ((failures++)) || true
> +        fi
> +    else
> +        if ! python3 "$ANALYZE_SCRIPT" \
> +            -p "$provider" \
> +            -a "$AGENTS_FILE" \
> +            -f "$FORMAT" \
> +            ${VERBOSE:+"$VERBOSE"} \
> +            "${EXTRA_ARGS[@]}" \
> +            "$PATCH_FILE"; then
> +            echo "FAILED: $provider review failed" >&2
> +            ((failures++)) || true
> +        fi
> +    fi
> +
> +    echo ""
> +    echo "========================================"
> +    echo ""
> +done
> +
> +echo "Review comparison complete."
> +
> +if [[ -n "$OUTPUT_DIR" ]]; then
> +    echo "All reviews saved to: $OUTPUT_DIR"
> +fi
> +
> +if [[ $failures -gt 0 ]]; then
> +    echo "$failures provider(s) failed." >&2
> +    exit 1
> +fi


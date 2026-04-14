Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07321F9D0F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 20:05:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F19E4028F;
	Tue, 14 Apr 2026 22:05:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3A5B64028D
 for <dev@dpdk.org>; Tue, 14 Apr 2026 22:05:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776197112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GuloveWaP4+wnNSNoLd/XNbQW0V89SDUlqBpIgZZesA=;
 b=amdsK57XFieuEdkRDnvXo+PKS6OcXJ6GLuCnl13S6bYMxiZItk5sLhBz+ThSsohLAIYsMJ
 OnVcZtwkBqnbTyrNI9OnAZGKjucz5DC2f53bZ6N8sk14Z+U0ythspNsXH8mowPJDManYwe
 gf3/lqEHvNzIW6pk5qGZugeRMP8Op7o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-PK_rEJBCNiqlxNnLgjrIbA-1; Tue,
 14 Apr 2026 16:05:11 -0400
X-MC-Unique: PK_rEJBCNiqlxNnLgjrIbA-1
X-Mimecast-MFC-AGG-ID: PK_rEJBCNiqlxNnLgjrIbA_1776197110
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 298731955D9C; Tue, 14 Apr 2026 20:05:10 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.47])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34A971955F42; Tue, 14 Apr 2026 20:05:09 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v13 4/6] devtools: add multi-provider AI documentation
 review script
In-Reply-To: <20260402194618.134002-5-stephen@networkplumber.org> (Stephen
 Hemminger's message of "Thu, 2 Apr 2026 12:44:34 -0700")
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260402194618.134002-1-stephen@networkplumber.org>
 <20260402194618.134002-5-stephen@networkplumber.org>
Date: Tue, 14 Apr 2026 16:05:07 -0400
Message-ID: <f7ty0ip8g0c.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i2qjC4ByFrOlf2NhpsrvgiiI1ALSAmh0FMOxy0c8DH8_1776197110
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

> Add review-doc.py script that reviews DPDK documentation files for
> spelling, grammar, technical correctness, and clarity using AI
> language models. Supports batch processing of multiple files.
>
> Supported AI providers:
>   - Anthropic Claude (default)
>   - OpenAI ChatGPT
>   - xAI Grok
>   - Google Gemini
>
> Output formats (-f/--format):
>   - text: plain text with extractable diff/msg markers (default)
>   - markdown: formatted review document
>   - html: complete HTML document with styling
>   - json: structured data with metadata
>
> For each input file, the script produces:
>   - <basename>.{txt,md,html,json}: review in selected format
>   - <basename>.diff: unified diff (text/json, or with -d flag)
>   - <basename>.msg: commit message (text/json, or with -d flag)
>
> The commit message prefix is automatically determined from the
> file path (e.g., doc/guides/prog_guide: for programmer's guide).
>
> Features:
>   - Multiple file processing with glob support
>   - Provider selection via -p/--provider option
>   - Custom model selection via -m/--model option
>   - Configurable output directory via -o/--output-dir option
>   - Output format selection via -f/--format option
>   - Force diff/msg generation via -d/--diff option
>   - Quiet mode (-q) suppresses stdout output
>   - Verbose mode (-v) shows token usage and API details
>   - Email integration using git sendemail configuration
>   - Prompt caching support for Anthropic to reduce costs
>
> Usage:
>   ./devtools/review-doc.py doc/guides/prog_guide/mempool_lib.rst
>   ./devtools/review-doc.py doc/guides/nics/*.rst
>   ./devtools/review-doc.py -f html -d -o /tmp doc/guides/nics/*.rst
>   ./devtools/review-doc.py --send-email --to dev@dpdk.org file.rst
>
> Requires the appropriate API key environment variable to be set
> for the chosen provider (ANTHROPIC_API_KEY, OPENAI_API_KEY,
> XAI_API_KEY, or GOOGLE_API_KEY).
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Same comment on pricing, but also

>  devtools/review-doc.py | 1341 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 1341 insertions(+)
>  create mode 100755 devtools/review-doc.py
>
> diff --git a/devtools/review-doc.py b/devtools/review-doc.py
> new file mode 100755
> index 0000000000..901a2d9f42
> --- /dev/null
> +++ b/devtools/review-doc.py
> @@ -0,0 +1,1341 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2026 Stephen Hemminger
> +
> +"""
> +Review DPDK documentation files using AI providers.
> +
> +Produces a diff file and commit message compliant with DPDK standards.
> +Accepts multiple documentation files and generates output for each.
> +Supported providers: Anthropic Claude, OpenAI ChatGPT, xAI Grok, Google =
Gemini
> +"""
> +
> +import argparse
> +import getpass
> +import json
> +import os
> +import re
> +import smtplib
> +import ssl
> +import subprocess
> +import sys
> +import time
> +from dataclasses import dataclass
> +from email.message import EmailMessage
> +from pathlib import Path
> +from typing import Any, NoReturn
> +from urllib.request import Request, urlopen
> +from urllib.error import URLError, HTTPError
> +
> +# Map output format to file extension
> +FORMAT_EXTENSIONS =3D {
> +    "text": ".txt",
> +    "markdown": ".md",
> +    "html": ".html",
> +    "json": ".json",
> +}
> +
> +# Additional markers for extracting diff/msg (used with --diff flag)
> +DIFF_MARKERS_INSTRUCTION =3D """
> +
> +ADDITIONALLY, at the end of your response, include these exact markers f=
or automated extraction:
> +---COMMIT_MESSAGE_START---
> +(same commit message as above)
> +---COMMIT_MESSAGE_END---
> +
> +---UNIFIED_DIFF_START---
> +(same unified diff as above)
> +---UNIFIED_DIFF_END---
> +"""
> +
> +# Provider configurations
> +PROVIDERS =3D {
> +    "anthropic": {
> +        "name": "Claude",
> +        "endpoint": "https://api.anthropic.com/v1/messages",
> +        "default_model": "claude-sonnet-4-5-20250929",
> +        "env_var": "ANTHROPIC_API_KEY",
> +    },
> +    "openai": {
> +        "name": "ChatGPT",
> +        "endpoint": "https://api.openai.com/v1/chat/completions",
> +        "default_model": "gpt-4.1",
> +        "env_var": "OPENAI_API_KEY",
> +    },
> +    "xai": {
> +        "name": "Grok",
> +        "endpoint": "https://api.x.ai/v1/chat/completions",
> +        "default_model": "grok-4-1-fast-non-reasoning",
> +        "env_var": "XAI_API_KEY",
> +    },
> +    "google": {
> +        "name": "Gemini",
> +        "endpoint": "https://generativelanguage.googleapis.com/v1beta/mo=
dels",
> +        "default_model": "gemini-3-flash-preview",
> +        "env_var": "GOOGLE_API_KEY",
> +    },
> +}
> +
> +
> +@dataclass
> +class TokenUsage:
> +    """Accumulated token usage across API calls."""
> +
> +    input_tokens: int =3D 0
> +    output_tokens: int =3D 0
> +    cache_creation_tokens: int =3D 0
> +    cache_read_tokens: int =3D 0
> +    api_calls: int =3D 0
> +
> +    def add(self, other: "TokenUsage") -> None:
> +        """Accumulate usage from another TokenUsage."""
> +        self.input_tokens +=3D other.input_tokens
> +        self.output_tokens +=3D other.output_tokens
> +        self.cache_creation_tokens +=3D other.cache_creation_tokens
> +        self.cache_read_tokens +=3D other.cache_read_tokens
> +        self.api_calls +=3D other.api_calls
> +
> +
> +# Pricing per million tokens (USD) - update as prices change.
> +# Keys are (provider, model-prefix) tuples; first prefix match wins.
> +# "default" key is fallback for unknown models within a provider.
> +PRICING: dict[str, dict[str, dict[str, float]]] =3D {
> +    "anthropic": {
> +        "claude-opus-4": {
> +            "input": 15.0, "output": 75.0,
> +            "cache_write": 18.75, "cache_read": 1.50,
> +        },
> +        "claude-sonnet-4": {
> +            "input": 3.0, "output": 15.0,
> +            "cache_write": 3.75, "cache_read": 0.30,
> +        },
> +        "claude-haiku-4": {
> +            "input": 0.80, "output": 4.0,
> +            "cache_write": 1.0, "cache_read": 0.08,
> +        },
> +        "default": {
> +            "input": 3.0, "output": 15.0,
> +            "cache_write": 3.75, "cache_read": 0.30,
> +        },
> +    },
> +    "openai": {
> +        "gpt-4.1": {
> +            "input": 2.0, "output": 8.0,
> +            "cache_write": 2.0, "cache_read": 0.50,
> +        },
> +        "gpt-4.1-mini": {
> +            "input": 0.40, "output": 1.60,
> +            "cache_write": 0.40, "cache_read": 0.10,
> +        },
> +        "gpt-4.1-nano": {
> +            "input": 0.10, "output": 0.40,
> +            "cache_write": 0.10, "cache_read": 0.025,
> +        },
> +        "default": {
> +            "input": 2.0, "output": 8.0,
> +            "cache_write": 2.0, "cache_read": 0.50,
> +        },
> +    },
> +    "xai": {
> +        "grok-4": {
> +            "input": 3.0, "output": 15.0,
> +            "cache_write": 3.0, "cache_read": 0.75,
> +        },
> +        "default": {
> +            "input": 3.0, "output": 15.0,
> +            "cache_write": 3.0, "cache_read": 0.75,
> +        },
> +    },
> +    "google": {
> +        "gemini-3-flash": {
> +            "input": 0.15, "output": 0.60,
> +            "cache_write": 0.15, "cache_read": 0.0375,
> +        },
> +        "default": {
> +            "input": 0.15, "output": 0.60,
> +            "cache_write": 0.15, "cache_read": 0.0375,
> +        },
> +    },
> +}
> +
> +
> +def get_pricing(provider: str, model: str) -> dict[str, float]:
> +    """Look up per-million-token pricing for a provider/model."""
> +    provider_prices =3D PRICING.get(provider, {})
> +    # Sort by prefix length descending so longer prefixes match first
> +    # (e.g., "gpt-4.1-mini" before "gpt-4.1")
> +    for prefix, prices in sorted(
> +        provider_prices.items(), key=3Dlambda x: len(x[0]), reverse=3DTr=
ue
> +    ):
> +        if prefix !=3D "default" and model.startswith(prefix):
> +            return prices
> +    return provider_prices.get(
> +        "default", {"input": 0, "output": 0, "cache_write": 0, "cache_re=
ad": 0}
> +    )
> +
> +
> +def estimate_cost(usage: TokenUsage, provider: str, model: str) -> float=
:
> +    """Estimate cost in USD from token usage."""
> +    prices =3D get_pricing(provider, model)
> +    cost =3D 0.0
> +    # Non-cached input tokens =3D total input - cache_read
> +    regular_input =3D max(0, usage.input_tokens - usage.cache_read_token=
s)
> +    cost +=3D regular_input * prices.get("input", 0) / 1_000_000
> +    cost +=3D usage.output_tokens * prices.get("output", 0) / 1_000_000
> +    cost +=3D usage.cache_creation_tokens * prices.get("cache_write", 0)=
 / 1_000_000
> +    cost +=3D usage.cache_read_tokens * prices.get("cache_read", 0) / 1_=
000_000
> +    return cost
> +
> +
> +def format_token_summary(
> +    usage: TokenUsage, provider: str, model: str, show_costs: bool
> +) -> str:
> +    """Format a token usage summary string."""
> +    lines =3D ["=3D=3D=3D Token Usage Summary =3D=3D=3D"]
> +    lines.append(f"API calls:     {usage.api_calls}")
> +    lines.append(f"Input tokens:  {usage.input_tokens:,}")
> +    lines.append(f"Output tokens: {usage.output_tokens:,}")
> +    if usage.cache_creation_tokens:
> +        lines.append(f"Cache write:   {usage.cache_creation_tokens:,}")
> +    if usage.cache_read_tokens:
> +        lines.append(f"Cache read:    {usage.cache_read_tokens:,}")
> +    total =3D usage.input_tokens + usage.output_tokens
> +    lines.append(f"Total tokens:  {total:,}")
> +    if show_costs:
> +        cost =3D estimate_cost(usage, provider, model)
> +        lines.append(f"Est. cost:     ${cost:.4f}")
> +    lines.append("=3D" * 27)
> +    return "\n".join(lines)
> +
> +
> +# Commit prefix mappings based on file path
> +COMMIT_PREFIX_MAP =3D [
> +    ("doc/guides/prog_guide/", "doc/guides/prog_guide:"),
> +    ("doc/guides/sample_app_ug/", "doc/guides/sample_app:"),
> +    ("doc/guides/nics/", "doc/guides/nics:"),
> +    ("doc/guides/cryptodevs/", "doc/guides/cryptodevs:"),
> +    ("doc/guides/compressdevs/", "doc/guides/compressdevs:"),
> +    ("doc/guides/eventdevs/", "doc/guides/eventdevs:"),
> +    ("doc/guides/rawdevs/", "doc/guides/rawdevs:"),
> +    ("doc/guides/bbdevs/", "doc/guides/bbdevs:"),
> +    ("doc/guides/gpus/", "doc/guides/gpus:"),
> +    ("doc/guides/dmadevs/", "doc/guides/dmadevs:"),
> +    ("doc/guides/regexdevs/", "doc/guides/regexdevs:"),
> +    ("doc/guides/mldevs/", "doc/guides/mldevs:"),
> +    ("doc/guides/rel_notes/", "doc/guides/rel_notes:"),
> +    ("doc/guides/linux_gsg/", "doc/guides/linux_gsg:"),
> +    ("doc/guides/freebsd_gsg/", "doc/guides/freebsd_gsg:"),
> +    ("doc/guides/windows_gsg/", "doc/guides/windows_gsg:"),
> +    ("doc/guides/tools/", "doc/guides/tools:"),
> +    ("doc/guides/testpmd_app_ug/", "doc/guides/testpmd:"),
> +    ("doc/guides/howto/", "doc/guides/howto:"),
> +    ("doc/guides/contributing/", "doc/guides/contributing:"),
> +    ("doc/guides/platform/", "doc/guides/platform:"),
> +    ("doc/guides/", "doc:"),
> +    ("doc/api/", "doc/api:"),
> +    ("doc/", "doc:"),
> +]
> +
> +SYSTEM_PROMPT =3D """\
> +You are an expert technical documentation reviewer for DPDK.
> +Your task is to review documentation files and suggest improvements for:
> +- Spelling errors
> +- Grammar issues
> +- Technical correctness
> +- Clarity and readability
> +- Consistency with DPDK terminology
> +
> +IMPORTANT COMMIT MESSAGE RULES (from check-git-log.sh):
> +- Subject line MUST be =C3=A2=E2=80=B0=C2=A460 characters
> +- Format: "prefix: lowercase description"
> +- First word after colon must be lowercase (except acronyms like Rx, Tx,=
 VF, MAC, API)
> +- Use imperative mood (e.g., "fix typo" not "fixed typo" or "fixes typo"=
)
> +- NO trailing period on subject line
> +- NO punctuation marks: , ; ! ? & |
> +- NO underscores in subject after colon
> +- Body lines wrapped at 75 characters
> +- Body must NOT start with "It"
> +- Do NOT include Signed-off-by (user adds via git commit --sign)
> +- Only use "Fixes:" tag for actual errors in documentation, not style im=
provements
> +
> +Case-sensitive terms (must use exact case):
> +- Rx, Tx (not RX, TX, rx, tx)
> +- VF, PF (not vf, pf)
> +- MAC, VLAN, RSS, API
> +- Linux, Windows, FreeBSD
> +
> +For style/clarity improvements, do NOT use Fixes tag.
> +For actual errors (wrong information, broken examples), include Fixes ta=
g \
> +if you can identify the commit."""
> +
> +FORMAT_INSTRUCTIONS =3D {
> +    "text": """
> +OUTPUT FORMAT:
> +You must output exactly two sections:
> +
> +1. COMMIT_MESSAGE section containing the complete commit message
> +2. UNIFIED_DIFF section containing the unified diff
> +
> +Use these exact markers:
> +---COMMIT_MESSAGE_START---
> +(commit message here)
> +---COMMIT_MESSAGE_END---
> +
> +---UNIFIED_DIFF_START---
> +(unified diff here)
> +---UNIFIED_DIFF_END---
> +
> +The diff should be in unified format that can be applied with "git apply=
".
> +If no changes are needed, output empty sections with a note.""",
> +    "markdown": """
> +OUTPUT FORMAT:
> +Provide your review in Markdown format with:
> +
> +## Summary
> +Brief description of changes
> +
> +## Commit Message
> +```
> +(complete commit message here, ready to use)
> +```
> +
> +## Changes
> +For each change:
> +### Issue N: Brief title
> +- **Location**: file path and line
> +- **Problem**: description
> +- **Fix**: suggested correction
> +
> +## Unified Diff
> +```diff
> +(unified diff here)
> +```""",
> +    "html": """
> +OUTPUT FORMAT:
> +Provide your review in HTML format with:
> +- <h2> for sections (Summary, Commit Message, Changes, Diff)
> +- <pre><code> for commit message and diff
> +- <ul>/<li> for individual issues
> +- Do NOT include <html>, <head>, or <body> tags - just the content
> +
> +Include sections for: Summary, Commit Message, Changes, Unified Diff""",
> +    "json": """
> +OUTPUT FORMAT:
> +Provide your review as JSON with this structure:
> +{
> +  "summary": "Brief description of changes",
> +  "commit_message": "Complete commit message ready to use",
> +  "changes": [
> +    {
> +      "type": "spelling|grammar|technical|clarity|style",
> +      "location": "line number or section",
> +      "original": "original text",
> +      "suggested": "corrected text",
> +      "reason": "why this change"
> +    }
> +  ],
> +  "diff": "unified diff as a string",
> +  "stats": {
> +    "total_issues": 0,
> +    "spelling": 0,
> +    "grammar": 0,
> +    "technical": 0,
> +    "clarity": 0
> +  }
> +}
> +Output ONLY valid JSON, no markdown code fences or other text.""",
> +}
> +
> +USER_PROMPT =3D """\
> +Review the following DPDK documentation file and provide improvements.
> +
> +File path: {doc_file}
> +Commit message prefix to use: {commit_prefix}
> +
> +{format_instruction}
> +
> +---DOCUMENT CONTENT---
> +"""


This seems like it could be folded into the earlier review script and
made a single utility with the option to do doc (or even file-based)
review vs. code review based on a flag.  Unless I misunderstand the
idea.  My understanding is that this should run against a specific file
and the prompt makes it guaranteed to be for a doc file.

If we can make it so the analyze script can also be used in 'file' mode
and we can set the prompt up, then an end user who wants to start
getting involved could run it against whatever files they'd like and get
the benefits, not just on docs but on any code files.  WDYT?

> +
> +def error(msg: str) -> NoReturn:
> +    """Print error message and exit."""
> +    print(f"Error: {msg}", file=3Dsys.stderr)
> +    sys.exit(1)
> +
> +
> +def get_git_config(key: str) -> str | None:
> +    """Get a value from git config."""
> +    try:
> +        result =3D subprocess.run(
> +            ["git", "config", "--get", key],
> +            capture_output=3DTrue,
> +            text=3DTrue,
> +            check=3DTrue,
> +        )
> +        return result.stdout.strip()
> +    except (subprocess.CalledProcessError, FileNotFoundError):
> +        return None
> +
> +
> +def get_smtp_config() -> dict[str, Any]:
> +    """Get SMTP configuration from git config sendemail settings."""
> +    config =3D {
> +        "server": get_git_config("sendemail.smtpserver"),
> +        "port": get_git_config("sendemail.smtpserverport"),
> +        "user": get_git_config("sendemail.smtpuser"),
> +        "encryption": get_git_config("sendemail.smtpencryption"),
> +        "password": get_git_config("sendemail.smtppass"),
> +    }
> +
> +    # Set defaults
> +    if not config["port"]:
> +        if config["encryption"] =3D=3D "ssl":
> +            config["port"] =3D "465"
> +        else:
> +            config["port"] =3D "587"
> +
> +    # Convert port to int
> +    try:
> +        config["port"] =3D int(config["port"])
> +    except (ValueError, TypeError):
> +        error(f"Invalid SMTP port in git config: {config['port']}")
> +
> +    return config
> +
> +
> +def get_commit_prefix(filepath: str) -> str:
> +    """Determine commit message prefix from file path."""
> +    for prefix_path, prefix in COMMIT_PREFIX_MAP:
> +        if filepath.startswith(prefix_path):
> +            return prefix
> +    return "doc:"
> +
> +
> +def build_user_prompt(
> +    doc_file: str,
> +    commit_prefix: str,
> +    output_format: str =3D "text",
> +    include_diff_markers: bool =3D False,
> +) -> str:
> +    """Build the user prompt with format instructions."""
> +    format_instruction =3D FORMAT_INSTRUCTIONS.get(output_format, "")
> +    if include_diff_markers and output_format not in ("text", "json"):
> +        format_instruction +=3D DIFF_MARKERS_INSTRUCTION
> +    return USER_PROMPT.format(
> +        doc_file=3Ddoc_file,
> +        commit_prefix=3Dcommit_prefix,
> +        format_instruction=3Dformat_instruction,
> +    )
> +
> +
> +def build_anthropic_request(
> +    model: str,
> +    max_tokens: int,
> +    agents_content: str,
> +    doc_content: str,
> +    doc_file: str,
> +    commit_prefix: str,
> +    output_format: str =3D "text",
> +    include_diff_markers: bool =3D False,
> +) -> dict[str, Any]:
> +    """Build request payload for Anthropic API."""
> +    user_prompt =3D build_user_prompt(
> +        doc_file, commit_prefix, output_format, include_diff_markers
> +    )
> +    return {
> +        "model": model,
> +        "max_tokens": max_tokens,
> +        "system": [
> +            {"type": "text", "text": SYSTEM_PROMPT},
> +            {
> +                "type": "text",
> +                "text": agents_content,
> +                "cache_control": {"type": "ephemeral"},
> +            },
> +        ],
> +        "messages": [
> +            {
> +                "role": "user",
> +                "content": user_prompt + doc_content,
> +            }
> +        ],
> +    }
> +
> +
> +def build_openai_request(
> +    model: str,
> +    max_tokens: int,
> +    agents_content: str,
> +    doc_content: str,
> +    doc_file: str,
> +    commit_prefix: str,
> +    output_format: str =3D "text",
> +    include_diff_markers: bool =3D False,
> +) -> dict[str, Any]:
> +    """Build request payload for OpenAI-compatible APIs."""
> +    user_prompt =3D build_user_prompt(
> +        doc_file, commit_prefix, output_format, include_diff_markers
> +    )
> +    return {
> +        "model": model,
> +        "max_tokens": max_tokens,
> +        "messages": [
> +            {"role": "system", "content": SYSTEM_PROMPT},
> +            {"role": "system", "content": agents_content},
> +            {
> +                "role": "user",
> +                "content": user_prompt + doc_content,
> +            },
> +        ],
> +    }
> +
> +
> +def build_google_request(
> +    max_tokens: int,
> +    agents_content: str,
> +    doc_content: str,
> +    doc_file: str,
> +    commit_prefix: str,
> +    output_format: str =3D "text",
> +    include_diff_markers: bool =3D False,
> +) -> dict[str, Any]:
> +    """Build request payload for Google Gemini API."""
> +    user_prompt =3D build_user_prompt(
> +        doc_file, commit_prefix, output_format, include_diff_markers
> +    )
> +    return {
> +        "systemInstruction": {
> +            "parts": [
> +                {"text": SYSTEM_PROMPT},
> +                {"text": agents_content},
> +            ],
> +        },
> +        "contents": [
> +            {
> +                "role": "user",
> +                "parts": [{"text": user_prompt + doc_content}],
> +            },
> +        ],
> +        "generationConfig": {"maxOutputTokens": max_tokens},
> +    }
> +
> +
> +def call_api(
> +    provider: str,
> +    api_key: str,
> +    model: str,
> +    max_tokens: int,
> +    agents_content: str,
> +    doc_content: str,
> +    doc_file: str,
> +    commit_prefix: str,
> +    output_format: str =3D "text",
> +    include_diff_markers: bool =3D False,
> +    verbose: bool =3D False,
> +    timeout: int =3D 120,
> +) -> tuple[str, TokenUsage]:
> +    """Make API request to the specified provider.
> +
> +    Returns a tuple of (response_text, token_usage).
> +    """
> +    config =3D PROVIDERS[provider]
> +
> +    # Build request based on provider
> +    if provider =3D=3D "anthropic":
> +        request_data =3D build_anthropic_request(
> +            model,
> +            max_tokens,
> +            agents_content,
> +            doc_content,
> +            doc_file,
> +            commit_prefix,
> +            output_format,
> +            include_diff_markers,
> +        )
> +        headers =3D {
> +            "Content-Type": "application/json",
> +            "x-api-key": api_key,
> +            "anthropic-version": "2023-06-01",
> +        }
> +        url =3D config["endpoint"]
> +    elif provider =3D=3D "google":
> +        request_data =3D build_google_request(
> +            max_tokens,
> +            agents_content,
> +            doc_content,
> +            doc_file,
> +            commit_prefix,
> +            output_format,
> +            include_diff_markers,
> +        )
> +        headers =3D {
> +            "Content-Type": "application/json",
> +            "x-goog-api-key": api_key,
> +        }
> +        url =3D f"{config['endpoint']}/{model}:generateContent"
> +    else:  # openai, xai
> +        request_data =3D build_openai_request(
> +            model,
> +            max_tokens,
> +            agents_content,
> +            doc_content,
> +            doc_file,
> +            commit_prefix,
> +            output_format,
> +            include_diff_markers,
> +        )
> +        headers =3D {
> +            "Content-Type": "application/json",
> +            "Authorization": f"Bearer {api_key}",
> +        }
> +        url =3D config["endpoint"]
> +
> +    # Make request with retries for transient errors
> +    request_body =3D json.dumps(request_data).encode("utf-8")
> +    max_retries =3D 3
> +    result =3D None
> +
> +    for attempt in range(max_retries + 1):
> +        req =3D Request(url, data=3Drequest_body, headers=3Dheaders, met=
hod=3D"POST")
> +        try:
> +            with urlopen(req, timeout=3Dtimeout) as response:
> +                result =3D json.loads(response.read().decode("utf-8"))
> +            break  # Success
> +        except HTTPError as e:
> +            if e.code in (429, 503, 529) and attempt < max_retries:
> +                delay =3D 2 ** (attempt + 1)  # 2, 4, 8 seconds
> +                # Check for Retry-After header
> +                retry_after =3D e.headers.get("Retry-After")
> +                if retry_after:
> +                    try:
> +                        delay =3D max(delay, int(retry_after))
> +                    except ValueError:
> +                        pass
> +                print(
> +                    f"API returned {e.code}, retrying in {delay}s "
> +                    f"(attempt {attempt + 1}/{max_retries})...",
> +                    file=3Dsys.stderr,
> +                )
> +                e.read()  # Drain the response body
> +                time.sleep(delay)
> +                continue
> +            error_body =3D e.read().decode("utf-8")
> +            try:
> +                error_data =3D json.loads(error_body)
> +                error(f"API error: {error_data.get('error', error_body)}=
")
> +            except json.JSONDecodeError:
> +                error(f"API error ({e.code}): {error_body}")
> +        except URLError as e:
> +            if isinstance(e.reason, TimeoutError):
> +                error(f"Request timed out after {timeout} seconds")
> +            error(f"Connection error: {e.reason}")
> +        except TimeoutError:
> +            error(f"Request timed out after {timeout} seconds")
> +
> +    if result is None:
> +        error("API request failed after all retries")
> +
> +    # Extract token usage
> +    usage =3D TokenUsage(api_calls=3D1)
> +    if provider =3D=3D "anthropic":
> +        raw_usage =3D result.get("usage", {})
> +        usage.input_tokens =3D raw_usage.get("input_tokens", 0)
> +        usage.output_tokens =3D raw_usage.get("output_tokens", 0)
> +        usage.cache_creation_tokens =3D raw_usage.get(
> +            "cache_creation_input_tokens", 0
> +        )
> +        usage.cache_read_tokens =3D raw_usage.get("cache_read_input_toke=
ns", 0)
> +    elif provider =3D=3D "google":
> +        raw_usage =3D result.get("usageMetadata", {})
> +        usage.input_tokens =3D raw_usage.get("promptTokenCount", 0)
> +        usage.output_tokens =3D raw_usage.get("candidatesTokenCount", 0)
> +    else:  # openai, xai
> +        raw_usage =3D result.get("usage", {})
> +        usage.input_tokens =3D raw_usage.get("prompt_tokens", 0)
> +        usage.output_tokens =3D raw_usage.get("completion_tokens", 0)
> +        # OpenAI cache details (if available)
> +        cache_details =3D raw_usage.get("prompt_tokens_details", {})
> +        if cache_details:
> +            usage.cache_read_tokens =3D cache_details.get("cached_tokens=
", 0)
> +
> +    # Show per-call details in verbose mode
> +    if verbose:
> +        print("=3D=3D=3D Token Usage =3D=3D=3D", file=3Dsys.stderr)
> +        print(f"Input tokens: {usage.input_tokens:,}", file=3Dsys.stderr=
)
> +        print(f"Output tokens: {usage.output_tokens:,}", file=3Dsys.stde=
rr)
> +        if usage.cache_creation_tokens:
> +            print(
> +                f"Cache creation: {usage.cache_creation_tokens:,}",
> +                file=3Dsys.stderr,
> +            )
> +        if usage.cache_read_tokens:
> +            print(
> +                f"Cache read: {usage.cache_read_tokens:,}",
> +                file=3Dsys.stderr,
> +            )
> +        print("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
", file=3Dsys.stderr)
> +
> +    # Extract response text
> +    if provider =3D=3D "anthropic":
> +        if "error" in result:
> +            error(f"API error: {result['error'].get('message', result)}"=
)
> +        content =3D result.get("content", [])
> +        text =3D "".join(
> +            block.get("text", "") for block in content if block.get("typ=
e") =3D=3D "text"
> +        )
> +        return text, usage
> +    elif provider =3D=3D "google":
> +        if "error" in result:
> +            error(f"API error: {result['error'].get('message', result)}"=
)
> +        candidates =3D result.get("candidates", [])
> +        if not candidates:
> +            error("No response from Gemini")
> +        parts =3D candidates[0].get("content", {}).get("parts", [])
> +        text =3D "".join(part.get("text", "") for part in parts)
> +        return text, usage
> +    else:  # openai, xai
> +        if "error" in result:
> +            error(f"API error: {result['error'].get('message', result)}"=
)
> +        choices =3D result.get("choices", [])
> +        if not choices:
> +            error("No response from API")
> +        text =3D choices[0].get("message", {}).get("content", "")
> +        return text, usage
> +
> +
> +def parse_review_text(review_text: str) -> tuple[str, str]:
> +    """Extract commit message and diff from text format response."""
> +    commit_msg =3D ""
> +    diff =3D ""
> +
> +    # Extract commit message
> +    msg_match =3D re.search(
> +        r"---COMMIT_MESSAGE_START---\s*\n(.*?)\n---COMMIT_MESSAGE_END---=
",
> +        review_text,
> +        re.DOTALL,
> +    )
> +    if msg_match:
> +        commit_msg =3D msg_match.group(1).strip()
> +
> +    # Extract unified diff
> +    diff_match =3D re.search(
> +        r"---UNIFIED_DIFF_START---\s*\n(.*?)\n---UNIFIED_DIFF_END---",
> +        review_text,
> +        re.DOTALL,
> +    )
> +    if diff_match:
> +        diff =3D diff_match.group(1).strip()
> +        # Clean up any markdown code fence if present
> +        diff =3D re.sub(r"^```diff\s*\n?", "", diff)
> +        diff =3D re.sub(r"\n?```\s*$", "", diff)
> +
> +    return commit_msg, diff
> +
> +
> +def strip_diff_markers(text: str) -> str:
> +    """Remove the diff/msg extraction markers from text."""
> +    # Remove commit message markers and content
> +    text =3D re.sub(
> +        r"\n*---COMMIT_MESSAGE_START---\s*\n.*?\n---COMMIT_MESSAGE_END--=
-\s*",
> +        "",
> +        text,
> +        flags=3Dre.DOTALL,
> +    )
> +    # Remove unified diff markers and content
> +    text =3D re.sub(
> +        r"\n*---UNIFIED_DIFF_START---\s*\n.*?\n---UNIFIED_DIFF_END---\s*=
",
> +        "",
> +        text,
> +        flags=3Dre.DOTALL,
> +    )
> +    return text.strip()
> +
> +
> +def send_email(
> +    to_addrs: list[str],
> +    cc_addrs: list[str],
> +    from_addr: str,
> +    subject: str,
> +    in_reply_to: str | None,
> +    body: str,
> +    dry_run: bool =3D False,
> +    verbose: bool =3D False,
> +) -> None:
> +    """Send review email via SMTP using git sendemail config."""
> +    # Build email message
> +    msg =3D EmailMessage()
> +    msg["From"] =3D from_addr
> +    msg["To"] =3D ", ".join(to_addrs)
> +    if cc_addrs:
> +        msg["Cc"] =3D ", ".join(cc_addrs)
> +    msg["Subject"] =3D subject
> +    if in_reply_to:
> +        msg["In-Reply-To"] =3D in_reply_to
> +        msg["References"] =3D in_reply_to
> +    msg.set_content(body)
> +
> +    if dry_run:
> +        print("=3D=3D=3D Email Preview (dry-run) =3D=3D=3D", file=3Dsys.=
stderr)
> +        print(msg.as_string(), file=3Dsys.stderr)
> +        print("=3D=3D=3D End Preview =3D=3D=3D", file=3Dsys.stderr)
> +        return
> +
> +    # Get SMTP configuration from git config
> +    smtp_config =3D get_smtp_config()
> +
> +    if not smtp_config["server"]:
> +        error("No SMTP server configured. Set git config sendemail.smtps=
erver")
> +
> +    server =3D smtp_config["server"]
> +    port =3D smtp_config["port"]
> +    user =3D smtp_config["user"]
> +    encryption =3D smtp_config["encryption"]
> +
> +    # Get password from environment or git config, or prompt
> +    password =3D os.environ.get("SMTP_PASSWORD") or smtp_config["passwor=
d"]
> +    if user and not password:
> +        password =3D getpass.getpass(f"SMTP password for {user}@{server}=
: ")
> +
> +    if verbose:
> +        print(f"SMTP server: {server}:{port}", file=3Dsys.stderr)
> +        print(f"SMTP user: {user or '(none)'}", file=3Dsys.stderr)
> +        print(f"Encryption: {encryption or 'starttls'}", file=3Dsys.stde=
rr)
> +
> +    # Collect all recipients
> +    all_recipients =3D list(to_addrs)
> +    if cc_addrs:
> +        all_recipients.extend(cc_addrs)
> +
> +    try:
> +        if encryption =3D=3D "ssl":
> +            # SSL/TLS connection from the start (port 465)
> +            context =3D ssl.create_default_context()
> +            with smtplib.SMTP_SSL(server, port, context=3Dcontext) as sm=
tp:
> +                if user and password:
> +                    smtp.login(user, password)
> +                smtp.send_message(msg, from_addr, all_recipients)
> +        else:
> +            # STARTTLS (port 587) or plain (port 25)
> +            with smtplib.SMTP(server, port) as smtp:
> +                smtp.ehlo()
> +                if encryption =3D=3D "tls" or port =3D=3D 587:
> +                    context =3D ssl.create_default_context()
> +                    smtp.starttls(context=3Dcontext)
> +                    smtp.ehlo()
> +                if user and password:
> +                    smtp.login(user, password)
> +                smtp.send_message(msg, from_addr, all_recipients)
> +
> +        print(f"Email sent via SMTP ({server}:{port})", file=3Dsys.stder=
r)
> +
> +    except smtplib.SMTPAuthenticationError as e:
> +        error(f"SMTP authentication failed: {e}")
> +    except smtplib.SMTPException as e:
> +        error(f"SMTP error: {e}")
> +    except OSError as e:
> +        error(f"Connection error to {server}:{port}: {e}")
> +
> +
> +def list_providers() -> None:
> +    """Print available providers and exit."""
> +    print("Available AI Providers:\n")
> +    print(f"{'Provider':<12} {'Default Model':<30} {'API Key Variable'}"=
)
> +    print(f"{'--------':<12} {'-------------':<30} {'----------------'}"=
)
> +    for name, config in PROVIDERS.items():
> +        print(f"{name:<12} {config['default_model']:<30} {config['env_va=
r']}")
> +    sys.exit(0)
> +
> +
> +def main() -> None:
> +    parser =3D argparse.ArgumentParser(
> +        description=3D"Review DPDK documentation files using AI provider=
s. "
> +        "Accepts multiple files and generates output for each.",
> +        formatter_class=3Dargparse.RawDescriptionHelpFormatter,
> +        epilog=3D"""
> +Examples:
> +    %(prog)s doc/guides/prog_guide/mempool_lib.rst
> +    %(prog)s doc/guides/nics/*.rst              # Review all NIC docs
> +    %(prog)s -p openai -o /tmp doc/guides/nics/ixgbe.rst doc/guides/nics=
/i40e.rst
> +    %(prog)s -f html -d -o /tmp/reviews doc/guides/nics/*.rst  # HTML + =
diff files
> +    %(prog)s -f json -o /tmp doc/guides/howto/flow_bifurcation.rst
> +    %(prog)s --send-email --to dev@dpdk.org doc/guides/nics/ixgbe.rst
> +
> +Output files (in output-dir):
> +    <basename>.txt|.md|.html|.json  Review in selected format
> +    <basename>.diff                  Unified diff (text/json, or with --=
diff)
> +    <basename>.msg                   Commit message (text/json, or with =
--diff)
> +
> +After review:
> +    git apply <basename>.diff
> +    git commit -sF <basename>.msg
> +
> +SMTP Configuration (from git config):
> +    sendemail.smtpserver      SMTP server hostname
> +    sendemail.smtpserverport  SMTP port (default: 587 for TLS, 465 for S=
SL)
> +    sendemail.smtpuser        SMTP username
> +    sendemail.smtpencryption  'tls' for STARTTLS, 'ssl' for SSL/TLS
> +    sendemail.smtppass        SMTP password (or set SMTP_PASSWORD env va=
r)
> +
> +Example git config:
> +    git config --global sendemail.smtpserver smtp.gmail.com
> +    git config --global sendemail.smtpserverport 587
> +    git config --global sendemail.smtpuser yourname@gmail.com
> +    git config --global sendemail.smtpencryption tls
> +
> +Token Usage:
> +    Token counts are always printed to stderr after each run.
> +    %(prog)s -c doc/guides/nics/ixgbe.rst    # Include estimated cost
> +    %(prog)s -c -f json doc/guides/nics/*.rst # Cost in JSON metadata to=
o
> +        """,
> +    )
> +
> +    parser.add_argument(
> +        "doc_files",
> +        nargs=3D"*",
> +        metavar=3D"doc_file",
> +        help=3D"Documentation file(s) to review",
> +    )
> +    parser.add_argument(
> +        "-p",
> +        "--provider",
> +        choices=3DPROVIDERS.keys(),
> +        default=3D"anthropic",
> +        help=3D"AI provider (default: anthropic)",
> +    )
> +    parser.add_argument(
> +        "-a",
> +        "--agents",
> +        default=3D"AGENTS.md",
> +        help=3D"Path to AGENTS.md file (default: AGENTS.md)",
> +    )
> +    parser.add_argument(
> +        "-m",
> +        "--model",
> +        help=3D"Model to use (default: provider-specific)",
> +    )
> +    parser.add_argument(
> +        "-t",
> +        "--tokens",
> +        type=3Dint,
> +        default=3D8192,
> +        help=3D"Max tokens for response (default: 8192)",
> +    )
> +    parser.add_argument(
> +        "-o",
> +        "--output-dir",
> +        default=3D".",
> +        help=3D"Output directory for all output files (default: .)",
> +    )
> +    parser.add_argument(
> +        "-v",
> +        "--verbose",
> +        action=3D"store_true",
> +        help=3D"Show API request details",
> +    )
> +    parser.add_argument(
> +        "-q",
> +        "--quiet",
> +        action=3D"store_true",
> +        help=3D"Suppress review output to stdout (only write files)",
> +    )
> +    parser.add_argument(
> +        "-f",
> +        "--format",
> +        choices=3DFORMAT_EXTENSIONS,
> +        default=3D"text",
> +        dest=3D"output_format",
> +        help=3D"Output format: text, markdown, html, json (default: text=
)",
> +    )
> +    parser.add_argument(
> +        "-d",
> +        "--diff",
> +        action=3D"store_true",
> +        help=3D"Always produce .diff and .msg files (automatic for text/=
json)",
> +    )
> +    parser.add_argument(
> +        "-l",
> +        "--list-providers",
> +        action=3D"store_true",
> +        help=3D"List available providers and exit",
> +    )
> +    parser.add_argument(
> +        "-c",
> +        "--show-costs",
> +        action=3D"store_true",
> +        help=3D"Show estimated cost alongside token usage summary",
> +    )
> +    parser.add_argument(
> +        "--timeout",
> +        type=3Dint,
> +        default=3D120,
> +        metavar=3D"SECONDS",
> +        help=3D"API request timeout in seconds (default: 120)",
> +    )
> +
> +    # Email options
> +    email_group =3D parser.add_argument_group("Email Options")
> +    email_group.add_argument(
> +        "--send-email",
> +        action=3D"store_true",
> +        help=3D"Send review via email",
> +    )
> +    email_group.add_argument(
> +        "--to",
> +        action=3D"append",
> +        dest=3D"to_addrs",
> +        default=3D[],
> +        metavar=3D"ADDRESS",
> +        help=3D"Email recipient (can be specified multiple times)",
> +    )
> +    email_group.add_argument(
> +        "--cc",
> +        action=3D"append",
> +        dest=3D"cc_addrs",
> +        default=3D[],
> +        metavar=3D"ADDRESS",
> +        help=3D"CC recipient (can be specified multiple times)",
> +    )
> +    email_group.add_argument(
> +        "--from",
> +        dest=3D"from_addr",
> +        metavar=3D"ADDRESS",
> +        help=3D"From address (default: from git config)",
> +    )
> +    email_group.add_argument(
> +        "--dry-run",
> +        action=3D"store_true",
> +        help=3D"Show email without sending",
> +    )
> +
> +    args =3D parser.parse_args()
> +
> +    if args.list_providers:
> +        list_providers()
> +
> +    # Check doc files provided (after list_providers so that flag works =
alone)
> +    if not args.doc_files:
> +        parser.error("at least one doc_file is required")
> +
> +    # Get provider config
> +    config =3D PROVIDERS[args.provider]
> +    model =3D args.model or config["default_model"]
> +
> +    # Get API key
> +    api_key =3D os.environ.get(config["env_var"])
> +    if not api_key:
> +        error(f"{config['env_var']} environment variable not set")
> +
> +    # Validate files
> +    agents_path =3D Path(args.agents)
> +    if not agents_path.exists():
> +        error(f"AGENTS.md not found: {args.agents}")
> +
> +    # Validate all doc files exist before processing
> +    doc_paths =3D []
> +    for doc_file in args.doc_files:
> +        doc_path =3D Path(doc_file)
> +        if not doc_path.exists():
> +            error(f"Documentation file not found: {doc_file}")
> +        doc_paths.append((doc_file, doc_path))
> +
> +    # Validate email options
> +    if args.send_email and not args.to_addrs:
> +        error("--send-email requires at least one --to address")
> +
> +    # Get from address for email
> +    from_addr =3D args.from_addr
> +    if args.send_email and not from_addr:
> +        git_name =3D get_git_config("user.name")
> +        git_email =3D get_git_config("user.email")
> +        if git_email:
> +            from_addr =3D f"{git_name} <{git_email}>" if git_name else g=
it_email
> +        else:
> +            error("No --from specified and git user.email not configured=
")
> +
> +    # Read AGENTS.md once
> +    agents_content =3D agents_path.read_text()
> +    output_dir =3D Path(args.output_dir)
> +    output_dir.mkdir(parents=3DTrue, exist_ok=3DTrue)
> +    provider_name =3D config["name"]
> +
> +    # Detect duplicate stems to disambiguate output filenames
> +    stem_counts: dict[str, int] =3D {}
> +    for _, doc_path in doc_paths:
> +        stem =3D doc_path.stem
> +        stem_counts[stem] =3D stem_counts.get(stem, 0) + 1
> +    duplicate_stems =3D {s for s, c in stem_counts.items() if c > 1}
> +
> +    # Accumulate token usage across all API calls
> +    total_usage =3D TokenUsage()
> +
> +    # Process each file
> +    num_files =3D len(doc_paths)
> +    for file_idx, (doc_file, doc_path) in enumerate(doc_paths, 1):
> +        if num_files > 1:
> +            print(
> +                f"\n{'=3D' * 60}",
> +                file=3Dsys.stderr,
> +            )
> +            print(
> +                f"Processing file {file_idx}/{num_files}: {doc_file}",
> +                file=3Dsys.stderr,
> +            )
> +            print(
> +                f"{'=3D' * 60}",
> +                file=3Dsys.stderr,
> +            )
> +
> +        # Determine output filenames (disambiguate if stems collide)
> +        doc_basename =3D doc_path.stem
> +        if doc_basename in duplicate_stems:
> +            # Prefix with parent directory name to avoid clobbering
> +            parent =3D doc_path.parent.name or "root"
> +            doc_basename =3D f"{parent}-{doc_basename}"
> +        diff_file =3D output_dir / f"{doc_basename}.diff"
> +        msg_file =3D output_dir / f"{doc_basename}.msg"
> +
> +        # Get commit prefix
> +        commit_prefix =3D get_commit_prefix(doc_file)
> +
> +        # Read doc content
> +        doc_content =3D doc_path.read_text()
> +
> +        if args.verbose:
> +            print("=3D=3D=3D Request =3D=3D=3D", file=3Dsys.stderr)
> +            print(f"Provider: {args.provider}", file=3Dsys.stderr)
> +            print(f"Model: {model}", file=3Dsys.stderr)
> +            print(f"Output format: {args.output_format}", file=3Dsys.std=
err)
> +            print(f"AGENTS file: {args.agents}", file=3Dsys.stderr)
> +            print(f"Doc file: {doc_file}", file=3Dsys.stderr)
> +            print(f"Commit prefix: {commit_prefix}", file=3Dsys.stderr)
> +            print(f"Output dir: {args.output_dir}", file=3Dsys.stderr)
> +            if args.send_email:
> +                print("Send email: yes", file=3Dsys.stderr)
> +                print(f"To: {', '.join(args.to_addrs)}", file=3Dsys.stde=
rr)
> +                if args.cc_addrs:
> +                    print(f"Cc: {', '.join(args.cc_addrs)}", file=3Dsys.=
stderr)
> +                print(f"From: {from_addr}", file=3Dsys.stderr)
> +            print("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D", file=
=3Dsys.stderr)
> +
> +        # Call API
> +        review_text, call_usage =3D call_api(
> +            args.provider,
> +            api_key,
> +            model,
> +            args.tokens,
> +            agents_content,
> +            doc_content,
> +            doc_file,
> +            commit_prefix,
> +            args.output_format,
> +            args.diff,
> +            args.verbose,
> +            args.timeout,
> +        )
> +        total_usage.add(call_usage)
> +
> +        if not review_text:
> +            print(
> +                f"Warning: No response received for {doc_file}",
> +                file=3Dsys.stderr,
> +            )
> +            continue
> +
> +        # Determine review output file
> +        format_ext =3D FORMAT_EXTENSIONS[args.output_format]
> +        review_file =3D output_dir / f"{doc_basename}{format_ext}"
> +
> +        # Determine if we should write diff/msg files
> +        write_diff_msg =3D args.diff or args.output_format in ("text", "=
json")
> +
> +        # Extract commit message and diff first (before stripping marker=
s)
> +        commit_msg, diff =3D "", ""
> +        if write_diff_msg:
> +            if args.output_format =3D=3D "json":
> +                # Will extract from JSON below
> +                pass
> +            else:
> +                # Parse from text format markers
> +                commit_msg, diff =3D parse_review_text(review_text)
> +
> +        # For non-text formats with --diff, strip the markers from displ=
ay output
> +        display_text =3D review_text
> +        if args.diff and args.output_format in ("markdown", "html"):
> +            display_text =3D strip_diff_markers(review_text)
> +
> +        # Build formatted output text
> +        if args.output_format =3D=3D "text":
> +            output_text =3D review_text
> +        elif args.output_format =3D=3D "json":
> +            # Try to parse JSON response
> +            try:
> +                review_data =3D json.loads(review_text)
> +            except json.JSONDecodeError:
> +                print("Warning: Response is not valid JSON", file=3Dsys.=
stderr)
> +                review_data =3D {"raw_response": review_text}
> +
> +            # Extract diff/msg from JSON if present
> +            if write_diff_msg:
> +                if isinstance(review_data, dict) and "raw_response" not =
in review_data:
> +                    commit_msg =3D review_data.get("commit_message", "")
> +                    diff =3D review_data.get("diff", "")
> +
> +            # Add metadata
> +            usage_data =3D {
> +                "api_calls": call_usage.api_calls,
> +                "input_tokens": call_usage.input_tokens,
> +                "output_tokens": call_usage.output_tokens,
> +                "total_tokens": call_usage.input_tokens + call_usage.out=
put_tokens,
> +            }
> +            if call_usage.cache_creation_tokens:
> +                usage_data["cache_creation_tokens"] =3D call_usage.cache=
_creation_tokens
> +            if call_usage.cache_read_tokens:
> +                usage_data["cache_read_tokens"] =3D call_usage.cache_rea=
d_tokens
> +            if args.show_costs:
> +                usage_data["estimated_cost_usd"] =3D round(
> +                    estimate_cost(call_usage, args.provider, model), 6
> +                )
> +
> +            output_data =3D {
> +                "metadata": {
> +                    "doc_file": doc_file,
> +                    "provider": args.provider,
> +                    "provider_name": provider_name,
> +                    "model": model,
> +                    "commit_prefix": commit_prefix,
> +                    "token_usage": usage_data,
> +                },
> +                "review": review_data,
> +            }
> +            output_text =3D json.dumps(output_data, indent=3D2)
> +        elif args.output_format =3D=3D "markdown":
> +            output_text =3D f"""# Documentation Review: {doc_path.name}
> +
> +*Reviewed by {provider_name} ({model})*
> +
> +{display_text}
> +"""
> +        elif args.output_format =3D=3D "html":
> +            output_text =3D f"""<!DOCTYPE html>
> +<html>
> +<head>
> +<meta charset=3D"utf-8">
> +<title>Review: {doc_path.name}</title>
> +<style>
> +body {{ font-family: system-ui, sans-serif; max-width: 900px; margin: 2e=
m auto; padding: 0 1em; }}
> +h1 {{ color: #333; }}
> +.review-meta {{ color: #666; font-style: italic; }}
> +pre {{ background: #f5f5f5; padding: 1em; overflow-x: auto; }}
> +</style>
> +</head>
> +<body>
> +<h1>Documentation Review: {doc_path.name}</h1>
> +<p class=3D"review-meta">Reviewed by {provider_name} ({model})</p>
> +<div class=3D"review-content">
> +{display_text}
> +</div>
> +</body>
> +</html>
> +"""
> +
> +        # Write formatted review to file
> +        review_file.write_text(output_text)
> +        print(f"Review written to: {review_file}", file=3Dsys.stderr)
> +
> +        # Write diff/msg files
> +        if write_diff_msg:
> +            if commit_msg:
> +                msg_file.write_text(commit_msg + "\n")
> +                print(f"Commit message written to: {msg_file}", file=3Ds=
ys.stderr)
> +            else:
> +                msg_file.write_text("# No commit message generated\n")
> +                print("Warning: Could not extract commit message", file=
=3Dsys.stderr)
> +
> +            if diff:
> +                diff_file.write_text(diff + "\n")
> +                print(f"Diff written to: {diff_file}", file=3Dsys.stderr=
)
> +            else:
> +                diff_file.write_text("# No changes suggested\n")
> +                print("Warning: Could not extract diff", file=3Dsys.stde=
rr)
> +
> +        # Print to stdout unless quiet (or multiple files without verbos=
e)
> +        show_stdout =3D not args.quiet and (num_files =3D=3D 1 or args.v=
erbose)
> +        if show_stdout:
> +            print(
> +                f"\n=3D=3D=3D Documentation Review: {doc_path.name} "
> +                f"(via {provider_name}) =3D=3D=3D"
> +            )
> +            print(output_text)
> +
> +            # Print usage instructions for text format
> +            if args.output_format =3D=3D "text":
> +                print("\n=3D=3D=3D Output Files =3D=3D=3D")
> +                print(f"Commit message: {msg_file}")
> +                print(f"Diff file:      {diff_file}")
> +                print("\nTo apply changes:")
> +                print(f"  git apply {diff_file}")
> +                print(f"  git commit -sF {msg_file}")
> +
> +        # Send email if requested
> +        if args.send_email:
> +            if args.output_format !=3D "text":
> +                print(
> +                    f"Note: Email will be sent as plain text regardless =
of "
> +                    f"--format=3D{args.output_format}",
> +                    file=3Dsys.stderr,
> +                )
> +
> +            review_subject =3D f"[REVIEW] {commit_prefix} {doc_path.name=
}"
> +
> +            # Build email body
> +            email_body =3D f"""AI-generated documentation review of {doc=
_file}
> +Reviewed using {provider_name} ({model})
> +
> +This is an automated review. Please verify all suggestions.
> +
> +---
> +
> +{review_text}
> +"""
> +
> +            if args.verbose:
> +                print("", file=3Dsys.stderr)
> +                print("=3D=3D=3D Email Details =3D=3D=3D", file=3Dsys.st=
derr)
> +                print(f"Subject: {review_subject}", file=3Dsys.stderr)
> +                print("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D", file=3Dsys.stderr)
> +
> +            send_email(
> +                args.to_addrs,
> +                args.cc_addrs,
> +                from_addr,
> +                review_subject,
> +                None,
> +                email_body,
> +                args.dry_run,
> +                args.verbose,
> +            )
> +
> +            if not args.dry_run:
> +                print("", file=3Dsys.stderr)
> +                print(f"Review sent to: {', '.join(args.to_addrs)}", fil=
e=3Dsys.stderr)
> +
> +    # Print summary for multiple files
> +    if num_files > 1:
> +        print(f"\n{'=3D' * 60}", file=3Dsys.stderr)
> +        print(f"Processed {num_files} files", file=3Dsys.stderr)
> +        print(f"Output directory: {output_dir}", file=3Dsys.stderr)
> +
> +    # Print token usage summary
> +    if total_usage.api_calls > 0:
> +        print("", file=3Dsys.stderr)
> +        print(
> +            format_token_summary(
> +                total_usage, args.provider, model, args.show_costs
> +            ),
> +            file=3Dsys.stderr,
> +        )
> +
> +
> +if __name__ =3D=3D "__main__":
> +    main()


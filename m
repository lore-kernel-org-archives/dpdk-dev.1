Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA938CD5BAB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 22:46:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 451AF40652;
	Fri, 22 May 2026 00:45:57 +0200 (CEST)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by mails.dpdk.org (Postfix) with ESMTP id 0F4AB40430
 for <dev@dpdk.org>; Fri, 22 May 2026 00:45:56 +0200 (CEST)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1357c851a48so8192472c88.1
 for <dev@dpdk.org>; Thu, 21 May 2026 15:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779403555;
 x=1780008355; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NMUEX+ohzSzGnFRd6NuHCcVBI1vUEJ3p3pE+ZLLszgM=;
 b=ljSSUABvZNUyyI3IsDnng4mYcsV+wrD/d37DfQKltPVfkjJlyKCqoomwb6QpZAOm6j
 RszKicifD3OBSI14fDpx0e0o02J2s23J6dftBkYzZ5lI4Ct4TsNQ6Ke1mMNymke82b/T
 KN3lsw7F8Kl6iP0A7d65q5cK0lNL4quS9pQ0DEw4j0AB7sAn/bUCxQfecNeWGhaMnUAh
 2dv7R5VVSTBQyPbPIv0VU1aUHky2o/VfEKZvaBmxYgvV8sScEztPmWtCpE1E+9TMbu5D
 F7jBSzisjxqARzgvhNlV7EWaNYAxwKyBjxLqiegDNUzeHyWmueuoRVxSE4aTIR1liu7Y
 XZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779403555; x=1780008355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NMUEX+ohzSzGnFRd6NuHCcVBI1vUEJ3p3pE+ZLLszgM=;
 b=DYB1jqck9hPK0UtpPuzDgso5aLsQLoF8kZ0J0zQlnM2+BlCKksP9frE+LR0WqO33wT
 irzjsXg+f1GvRVAXM0Sjsi2XbzY8jNKgOWO8T+lNMoYIsSWokE7ngRVU4cnyZgOQJiVy
 qWEdtya9VNZ2S+6dOaPGvJjHCRJS2VrwnMkwkqiFO9PT1+z2ORQgJmvi7C9U3Nnq+kTs
 piShWW0JblX0Q5eE6PBzVYkq/79AndEko+/vUETGkbcXKPy1wNbS+ZkMblQRWWfEBrJh
 Ehj5a8rTwJZYfNXMDmrWzf6wjNK0TUw6vDlLf6HiaXKgp4VJf0fSs7hDsdXiRPJPKyIq
 SWig==
X-Gm-Message-State: AOJu0YzKyC0djDiPKaZJlChdOOBzf4m+ZGcnkxxWiYXTaAE2wM9kPpJw
 310T58NGKdVa0DZ0aWG5o1UDysme34dgzaVOQOVvdn7ywYkrthvPmr5hr+IbrR484ziM5FhZ74l
 dRXqA
X-Gm-Gg: Acq92OFUfLyoW7oOuQ4+ZaEGWTuToi8oahItST/Lcm0ouMtjYDgC184Ag/5H4WGYZLk
 9f4xMMjDx8PET2fRINQWAOwtPoUKwrVVEhVJxPgggk1m+t8QTn20PgD+aGRKTCiFXpr/eg24sw4
 dTxChJkAzn6mcgmWRUncHZXZzBgu/vM2rdxEO5BMcpYfzMpw5rBsQm2BWj9zf9KCoS/LSxP2zVl
 YsmpTbCJifi82j1InktXDvKyysifrvI/vbIyPxjClmU0Lb7Wh1nBV+yqiEpR+31j9/ESfW6P9/Z
 xfKtoHWc4WZhbXlv2MWlYTEDXCsBageQagFaNkLUJ5X0mbrPzXzaxx2u5luhKOOXOG6LDQsI5gz
 BLFqhWvgfRBZ3y/qGU5O7aHV1GsFo3ERQ6J/2s2Sr23RX0TlbHsDxhu7X2gMBit3tEnjZbhykD/
 wXvBG/PhDD1f5F5NaCUkzO+c79a+JdZxlTvayKjHRmgft4n3Bm3thVVLOT83FhlQ==
X-Received: by 2002:a05:7022:699f:b0:135:608a:2860 with SMTP id
 a92af1059eb24-1365fa44335mr409529c88.21.1779403555010; 
 Thu, 21 May 2026 15:45:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-136621d3ae9sm496044c88.5.2026.05.21.15.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 15:45:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>
Subject: [PATCH v15 2/7] devtools: add common infrastructure for AI review
 scripts
Date: Thu, 21 May 2026 15:44:34 -0700
Message-ID: <20260521224550.927338-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521224550.927338-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260521224550.927338-1-stephen@networkplumber.org>
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

The AI review scripts share similar options and infrastructure.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/ai/_common.py | 246 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 246 insertions(+)
 create mode 100644 devtools/ai/_common.py

diff --git a/devtools/ai/_common.py b/devtools/ai/_common.py
new file mode 100644
index 0000000000..69982cbda5
--- /dev/null
+++ b/devtools/ai/_common.py
@@ -0,0 +1,246 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Stephen Hemminger
+
+"""Common utilities shared by the DPDK AI review scripts."""
+
+import argparse
+import json
+import subprocess
+import sys
+from dataclasses import dataclass
+from typing import Any, NoReturn
+from urllib.error import HTTPError, URLError
+from urllib.request import Request, urlopen
+
+# Provider configurations (model defaults; override with --model).
+PROVIDERS: dict[str, dict[str, str]] = {
+    "anthropic": {
+        "name": "Claude",
+        "endpoint": "https://api.anthropic.com/v1/messages",
+        "default_model": "claude-sonnet-4-5-20250929",
+        "env_var": "ANTHROPIC_API_KEY",
+    },
+    "openai": {
+        "name": "ChatGPT",
+        "endpoint": "https://api.openai.com/v1/chat/completions",
+        "default_model": "gpt-4.1",
+        "env_var": "OPENAI_API_KEY",
+    },
+    "xai": {
+        "name": "Grok",
+        "endpoint": "https://api.x.ai/v1/chat/completions",
+        "default_model": "grok-4-1-fast-non-reasoning",
+        "env_var": "XAI_API_KEY",
+    },
+    "google": {
+        "name": "Gemini",
+        "endpoint": "https://generativelanguage.googleapis.com/v1beta/models",
+        "default_model": "gemini-3-flash-preview",
+        "env_var": "GOOGLE_API_KEY",
+    },
+}
+
+
+def error(msg: str) -> NoReturn:
+    """Print error message to stderr and exit with status 1."""
+    print(f"Error: {msg}", file=sys.stderr)
+    sys.exit(1)
+
+
+def get_git_config(key: str) -> str | None:
+    """Return the value of a git config key, or None if unset/git missing."""
+    try:
+        result = subprocess.run(
+            ["git", "config", "--get", key],
+            capture_output=True,
+            text=True,
+            check=True,
+        )
+        return result.stdout.strip()
+    except (subprocess.CalledProcessError, FileNotFoundError):
+        return None
+
+
+def list_providers() -> NoReturn:
+    """Print available providers and exit."""
+    print("Available AI Providers:\n")
+    print(f"{'Provider':<12} {'Default Model':<30} {'API Key Variable'}")
+    print(f"{'--------':<12} {'-------------':<30} {'----------------'}")
+    for name, config in PROVIDERS.items():
+        print(f"{name:<12} {config['default_model']:<30} {config['env_var']}")
+    sys.exit(0)
+
+
+@dataclass
+class TokenUsage:
+    """Accumulated token usage across API calls."""
+
+    input_tokens: int = 0
+    output_tokens: int = 0
+    cache_creation_tokens: int = 0
+    cache_read_tokens: int = 0
+    api_calls: int = 0
+
+    def add(self, other: "TokenUsage") -> None:
+        """Accumulate usage from another TokenUsage."""
+        self.input_tokens += other.input_tokens
+        self.output_tokens += other.output_tokens
+        self.cache_creation_tokens += other.cache_creation_tokens
+        self.cache_read_tokens += other.cache_read_tokens
+        self.api_calls += other.api_calls
+
+
+def format_token_summary(usage: TokenUsage, provider: str, model: str) -> str:
+    """Format a token usage summary string."""
+    provider_label = PROVIDERS.get(provider, {}).get("name", provider)
+    lines = ["=== Token Usage Summary ==="]
+    lines.append(f"Provider:      {provider_label} ({model})")
+    lines.append(f"API calls:     {usage.api_calls}")
+    lines.append(f"Input tokens:  {usage.input_tokens:,}")
+    lines.append(f"Output tokens: {usage.output_tokens:,}")
+    if usage.cache_creation_tokens:
+        lines.append(f"Cache write:   {usage.cache_creation_tokens:,}")
+    if usage.cache_read_tokens:
+        lines.append(f"Cache read:    {usage.cache_read_tokens:,}")
+    total = usage.input_tokens + usage.output_tokens
+    lines.append(f"Total tokens:  {total:,}")
+    lines.append("=" * 27)
+    return "\n".join(lines)
+
+
+def add_token_args(parser: argparse.ArgumentParser) -> None:
+    """Add the --show-tokens flag to an ArgumentParser."""
+    parser.add_argument(
+        "--show-tokens",
+        action="store_true",
+        help="Show token usage summary on stderr after the run",
+    )
+
+
+def print_token_summary(
+    usage: TokenUsage, provider: str, model: str, show: bool
+) -> None:
+    """Print token usage summary to stderr if requested and any calls were made."""
+    if not show or usage.api_calls == 0:
+        return
+    print("", file=sys.stderr)
+    print(format_token_summary(usage, provider, model), file=sys.stderr)
+
+
+def _build_request_meta(
+    provider: str, api_key: str, model: str
+) -> tuple[str, dict[str, str]]:
+    """Return (url, headers) for a provider request."""
+    config = PROVIDERS[provider]
+    if provider == "anthropic":
+        return config["endpoint"], {
+            "Content-Type": "application/json",
+            "x-api-key": api_key,
+            "anthropic-version": "2023-06-01",
+        }
+    if provider == "google":
+        url = f"{config['endpoint']}/{model}:generateContent?key={api_key}"
+        return url, {"Content-Type": "application/json"}
+    # openai, xai
+    return config["endpoint"], {
+        "Content-Type": "application/json",
+        "Authorization": f"Bearer {api_key}",
+    }
+
+
+def _extract_usage(provider: str, result: dict[str, Any]) -> TokenUsage:
+    """Extract TokenUsage from a provider response."""
+    usage = TokenUsage(api_calls=1)
+    if provider == "anthropic":
+        raw = result.get("usage", {})
+        usage.input_tokens = raw.get("input_tokens", 0)
+        usage.output_tokens = raw.get("output_tokens", 0)
+        usage.cache_creation_tokens = raw.get("cache_creation_input_tokens", 0)
+        usage.cache_read_tokens = raw.get("cache_read_input_tokens", 0)
+    elif provider == "google":
+        raw = result.get("usageMetadata", {})
+        usage.input_tokens = raw.get("promptTokenCount", 0)
+        usage.output_tokens = raw.get("candidatesTokenCount", 0)
+    else:  # openai, xai
+        raw = result.get("usage", {})
+        usage.input_tokens = raw.get("prompt_tokens", 0)
+        usage.output_tokens = raw.get("completion_tokens", 0)
+        cache_details = raw.get("prompt_tokens_details", {})
+        if cache_details:
+            usage.cache_read_tokens = cache_details.get("cached_tokens", 0)
+    return usage
+
+
+def _extract_text(provider: str, result: dict[str, Any]) -> str:
+    """Extract response text from a provider response. Calls error() on failure."""
+    if "error" in result:
+        error(f"API error: {result['error'].get('message', result)}")
+    if provider == "anthropic":
+        content = result.get("content", [])
+        return "".join(
+            block.get("text", "") for block in content if block.get("type") == "text"
+        )
+    if provider == "google":
+        candidates = result.get("candidates", [])
+        if not candidates:
+            error("No response from Gemini")
+        parts = candidates[0].get("content", {}).get("parts", [])
+        return "".join(part.get("text", "") for part in parts)
+    # openai, xai
+    choices = result.get("choices", [])
+    if not choices:
+        error("No response from API")
+    return choices[0].get("message", {}).get("content", "")
+
+
+def _print_verbose_usage(usage: TokenUsage) -> None:
+    """Print per-call token details to stderr."""
+    print("=== Token Usage ===", file=sys.stderr)
+    print(f"Input tokens: {usage.input_tokens:,}", file=sys.stderr)
+    print(f"Output tokens: {usage.output_tokens:,}", file=sys.stderr)
+    if usage.cache_creation_tokens:
+        print(f"Cache creation: {usage.cache_creation_tokens:,}", file=sys.stderr)
+    if usage.cache_read_tokens:
+        print(f"Cache read: {usage.cache_read_tokens:,}", file=sys.stderr)
+    print("===================", file=sys.stderr)
+
+
+def send_request(
+    provider: str,
+    api_key: str,
+    model: str,
+    request_data: dict[str, Any],
+    *,
+    timeout: int = 120,
+    verbose: bool = False,
+) -> tuple[str, TokenUsage]:
+    """Send a prebuilt request to a provider and return (response_text, usage).
+
+    The caller assembles the provider-specific request body via its own
+    build_*_request helpers (the prompts differ per script). This function
+    handles transport, error reporting, and token-usage extraction.
+    """
+    url, headers = _build_request_meta(provider, api_key, model)
+    body = json.dumps(request_data).encode("utf-8")
+    req = Request(url, data=body, headers=headers)
+
+    try:
+        with urlopen(req, timeout=timeout) as response:
+            result = json.loads(response.read().decode("utf-8"))
+    except HTTPError as e:
+        error_body = e.read().decode("utf-8")
+        try:
+            error_data = json.loads(error_body)
+            error(f"API error: {error_data.get('error', error_body)}")
+        except json.JSONDecodeError:
+            error(f"API error ({e.code}): {error_body}")
+    except URLError as e:
+        if isinstance(e.reason, TimeoutError):
+            error(f"Request timed out after {timeout} seconds")
+        error(f"Connection error: {e.reason}")
+
+    usage = _extract_usage(provider, result)
+    if verbose:
+        _print_verbose_usage(usage)
+    return _extract_text(provider, result), usage
-- 
2.53.0


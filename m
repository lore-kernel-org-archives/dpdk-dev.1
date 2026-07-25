Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3880FC531C9
	for <dpdk-dev@archiver.kernel.org>; Sat, 25 Jul 2026 08:43:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0375940280;
	Sat, 25 Jul 2026 10:43:55 +0200 (CEST)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 86C0040276
 for <dev@dpdk.org>; Sat, 25 Jul 2026 10:43:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1784969029; bh=8mhcgkRd+e5Ea0Z8RGSv2TXixHl2VdcWvACfDxttPkA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lhJ9mUPEV/KalDhKZCrZFetZekRBwQYo4MkhP8dNwfEWn5JuEjt4Bl7jtiyPrJ+vS
 M8DojQ4BZXEEN5B5vXVdTGehj/hyFMOaVWXEGMrHiiDn8jRW8StaZsp1KsnQ/h0eZV
 apzlbxrwS2GQXu95LW+gWQ71ZTZorFcL/ma7Vpd8=
Received: from fedora.tail0f0cf3.ts.net ([139.159.170.83])
 by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
 id AEFB0A5A; Sat, 25 Jul 2026 16:43:47 +0800
X-QQ-mid: xmsmtpt1784969027tp51fu0ll
Message-ID: <tencent_CFE5ECAF36405DFD2FB29DB7319B04E72C08@qq.com>
X-QQ-XMAILINFO: M2SvzgchpLqf4IQ8PsTBVTrZkMJq7Yn+o6mcSJ3IhVjETMRdIwUVa0IGWMdijI
 feM2D8w4scrmOoWHxEX5IrhEF5n8BSB7a4ee3H+CtVKWjviaZ5+11uKcvA4N5mdQQqNbvgSjshUs
 YshAiibq5GMG5NQjCg34hU1DYadiXQukQT69fiXvKaMf1/oUGf2ePU+rro4flwQ1ZzB7GjxSJoTP
 Ug6Fcu+fqd4H00S72iDk9HBLmFWuZmA8VD5dn5zszsmNnSS/3EZM9/zFgT2m0GFdkcr8USTgbPxV
 vmbuKr2dxm48m951zWu/915zlwJu4bA23Sxny9hLsL3hjYcu1my3v9kdTeyoQjYHb3jBgG/Ns5ki
 LlxhF19bUHZM8owhw2rTufbPFDWkpMzL7KY6u278YCd/icqIKsHFT69lClH1idajnUZVMSIStwQU
 WytI5f8yW1H1XbxhgRNz6MuHoHSfBBbFs073Pr7EmaMav7Xmk3mhmkJSBHyPEN6kpRlvMSqMqQtL
 GqW+RDxJEVSxPjgcNsaXhwr2qxNSQ9c1sUGP5M3Dhi76AaDmzRkBFDULv4FsvSKm+pD7AFH9jYoC
 Pl8PDO8Is7CJbixb15eYIi4FZBeubc0aLdZSZLTq8xzxSIh2tpcUBkcy8rIFxGfolPjsomoax5XZ
 jAT1Q+5Ies3RJIVALZEKGeO0aXr2q3/Iw758v8YiWsVx71sC+sRate/Ki9CkZN7JGaG+0TF6FjwJ
 mJmdOwCC3A8uX8lSwIUU9krCfRLm331izKERjrT07inHDc1L1iXdKSE96VOQKAoRKk29nGv5jnIS
 /4tlMzbeG0E48tVsAhdJMsKvqbHch8P8jGCsiHhHv7jknKTGhDz/LxrUGOhLQfjUU9e91UMwiyKp
 26XSTfoq7YSSHS5f8qquU1yBAdj53i/VdnoqveDIZ2COz6oX0e0zU5/iKzHxVOxFbZVcvnFXnWGY
 KGY6u72Q35i9/0oKvLBu66pTk/YNRpGKdiClNGMryXXiD4vqmWOhYLtsfMdabW3e32HyNj84c1XP
 dG3wuAETnC7IIVgtioe/C2UqFMPXSRSRgSlgkeZQ4sxH+SKaTX0Stt9N4n/6L9o0Y45le0Gw==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: datshan@qq.com
To: thomas@monjalon.net,
	stephen@networkplumber.org
Cc: aconole@redhat.com,
	dev@dpdk.org
Subject: [PATCH v3] devtools: support local opencode agent for patch review
Date: Sat, 25 Jul 2026 16:43:45 +0800
X-OQ-MSGID: <20260725084345.96177-1-datshan@qq.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703091902.525837-1-datshan@qq.com>
References: <20260703091902.525837-1-datshan@qq.com>
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

From: Chengwen Feng <fengchengwen@huawei.com>

Currently review-patch.py only supports cloud AI providers
(Anthropic, OpenAI, xAI, Google) via REST API, requiring API keys.

Add a --via option that invokes the locally installed opencode CLI as
the review runner instead of making HTTP calls. opencode reads
AGENTS.md from the DPDK project directory automatically, needing no
configuration beyond opencode on PATH.

The --via and -p/--provider options are independent -- via routes to
the local agent mode while -p continues to use the cloud API path.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

---
v3: Rebase main to fix apply error
v2: Address comments from Stephen, including: not arise
FileNotFoundError and more clarify.
---
 devtools/ai/review-patch.py | 229 ++++++++++++++++++++++++++----------
 1 file changed, 168 insertions(+), 61 deletions(-)

diff --git a/devtools/ai/review-patch.py b/devtools/ai/review-patch.py
index 5f8d9ed772..7ee34cfe6d 100755
--- a/devtools/ai/review-patch.py
+++ b/devtools/ai/review-patch.py
@@ -3,9 +3,10 @@
 # Copyright(c) 2026 Stephen Hemminger
 
 """
-Review DPDK patches using AI providers.
+Review DPDK patches using AI providers or a local agent tool.
 
 Supported providers: Anthropic Claude, OpenAI ChatGPT, xAI Grok, Google Gemini
+Supported agent: OpenCode (--via opencode)
 """
 
 import argparse
@@ -577,6 +578,109 @@ def build_google_request(
     }
 
 
+def _call_opencode(
+    model: str,
+    system_prompt: str,
+    patch_content: str,
+    patch_name: str,
+    agents_path: str = "",
+    output_format: str = "text",
+    verbose: bool = False,
+    timeout: int = 300,
+) -> tuple[str, TokenUsage]:
+    """Call local opencode CLI for review."""
+    format_instruction = FORMAT_INSTRUCTIONS.get(output_format, "")
+    user_prompt = (
+        f"Review the attached DPDK patch file '{patch_name}'.\n\n"
+        f"Focus on correctness bugs, C coding style, API requirements, "
+        f"and other guideline violations. "
+        f"Commit message format and SPDX/copyright are checked by "
+        f"checkpatches.sh -- do NOT flag those.\n\n"
+        f"{format_instruction}"
+    )
+
+    with tempfile.NamedTemporaryFile(
+        mode="w", suffix=".patch", delete=False, prefix="review_"
+    ) as f:
+        f.write(patch_content)
+        patch_temp = f.name
+
+    try:
+        full_message = system_prompt + "\n\n" + user_prompt
+
+        cmd = [
+            "opencode", "run", "--format", "json",
+            "--dir", str(Path(__file__).resolve().parent.parent.parent),
+        ]
+        if model:
+            cmd.extend(["--model", model])
+        if verbose:
+            cmd.append("--print-logs")
+        cmd.append(full_message)
+        cmd.extend(["--file", patch_temp])
+        if agents_path:
+            cmd.extend(["--file", agents_path])
+
+        if verbose:
+            print(f"Running: {' '.join(cmd)}", file=sys.stderr)
+
+        try:
+            result = subprocess.run(
+                cmd,
+                capture_output=True,
+                text=True,
+                timeout=timeout,
+            )
+        except FileNotFoundError:
+            error("opencode not found. Install from https://opencode.ai")
+        except subprocess.TimeoutExpired:
+            error(f"opencode timed out after {timeout} seconds")
+
+        if result.returncode != 0:
+            error(
+                f"opencode exited with code {result.returncode}: "
+                f"{result.stderr[:500]}"
+            )
+
+    finally:
+        os.unlink(patch_temp)
+
+    text_parts = []
+    usage = TokenUsage()
+    steps = 0
+    for line in result.stdout.splitlines():
+        stripped = line.strip()
+        if not stripped:
+            continue
+        try:
+            event = json.loads(stripped)
+        except json.JSONDecodeError:
+            continue
+
+        event_type = event.get("type", "")
+        if event_type == "text":
+            part_text = event.get("part", {}).get("text", "")
+            if part_text:
+                text_parts.append(part_text)
+        elif event_type == "step_finish":
+            steps += 1
+            tokens = event.get("part", {}).get("tokens", {})
+            if tokens:
+                usage.input_tokens += tokens.get("input", 0)
+                usage.output_tokens += tokens.get("output", 0)
+                cache = tokens.get("cache", {})
+                usage.cache_creation_tokens += cache.get("write", 0)
+                usage.cache_read_tokens += cache.get("read", 0)
+
+    usage.api_calls = 1 if steps > 0 else 0
+    review_text = "\n".join(text_parts)
+
+    if not review_text:
+        error("No review text received from opencode")
+
+    return review_text, usage
+
+
 def call_api(
     provider: str,
     auth: str,
@@ -764,6 +868,7 @@ def main() -> None:
 Examples:
     %(prog)s patch.patch                    # Review with default settings
     %(prog)s -p openai my-patch.patch       # Use OpenAI ChatGPT
+    %(prog)s --via opencode my-patch.patch  # Use local opencode agent
     %(prog)s -f markdown patch.patch        # Output as Markdown
     %(prog)s -f json -o review.json patch.patch  # Save JSON to file
     %(prog)s -f html -o review.html patch.patch  # Save HTML to file
@@ -810,7 +915,13 @@ def main() -> None:
         "--provider",
         choices=PROVIDERS.keys(),
         default="anthropic",
-        help="AI provider (default: anthropic)",
+        help="Cloud AI provider (default: anthropic)",
+    )
+    parser.add_argument(
+        "--via",
+        choices=["opencode"],
+        default=None,
+        help="Use a local agent tool instead of a cloud API (e.g. --via opencode)",
     )
     parser.add_argument(
         "-a",
@@ -956,12 +1067,17 @@ def main() -> None:
     if not args.patch_file:
         parser.error("patch_file is required")
 
-    # Get provider config
-    config = PROVIDERS[args.provider]
-    model = args.model or config["default_model"]
-
-    # Get authentication string
-    auth = get_auth_string(args.auth, args.provider)
+    # Get provider config or set up local agent runner
+    via = args.via
+    if via:
+        model = args.model or ""
+        auth = ""
+        provider_name = "OpenCode"
+    else:
+        config = PROVIDERS[args.provider]
+        model = args.model or config["default_model"]
+        auth = get_auth_string(args.auth, args.provider)
+        provider_name = config["name"]
 
     # Validate files
     agents_path = Path(args.agents)
@@ -999,17 +1115,42 @@ def main() -> None:
     patch_content = patch_path.read_text(encoding="utf-8", errors="replace")
     patch_name = patch_path.name
 
-    # Determine max tokens for this provider
-    max_input_tokens = args.max_tokens or PROVIDER_INPUT_LIMITS.get(
-        args.provider, 100000
-    )
+    # Dispatch to agent or provider
+    def _run_review(patch_body: str, patch_label: str) -> tuple[str, TokenUsage]:
+        if via:
+            return _call_opencode(
+                model, system_prompt,
+                patch_body, patch_label,
+                str(agents_path),
+                args.output_format, args.verbose, args.timeout,
+            )
+        return call_api(
+            args.provider, auth, model, args.tokens,
+            system_prompt, agents_content,
+            patch_body, patch_label,
+            args.output_format, args.verbose, args.timeout,
+        )
 
-    # Estimate token count
-    estimated_tokens = estimate_tokens(patch_content + agents_content)
+    # Determine max tokens (cloud API only)
+    max_input_tokens = 0
+    if via:
+        estimated_tokens = 1
+    else:
+        max_input_tokens = args.max_tokens or PROVIDER_INPUT_LIMITS.get(
+            args.provider, 100000
+        )
+        estimated_tokens = estimate_tokens(patch_content + agents_content)
 
     # Accumulate token usage across all API calls
     total_usage = TokenUsage()
 
+    if via and args.large_file != "error":
+        print(
+            "Warning: --large-file is ignored in --via mode; "
+            "opencode handles large files automatically",
+            file=sys.stderr,
+        )
+
     # Parse patch range if specified
     patch_start, patch_end = None, None
     if args.patch_range:
@@ -1067,19 +1208,7 @@ def main() -> None:
                 patch_label = f"Patch {i}/{total_patches}"
                 print(f"\nReviewing {patch_label}...", file=sys.stderr)
 
-                review_text, call_usage = call_api(
-                    args.provider,
-                    auth,
-                    model,
-                    args.tokens,
-                    system_prompt,
-                    agents_content,
-                    patch,
-                    f"{patch_name} ({patch_label})",
-                    args.output_format,
-                    args.verbose,
-                    args.timeout,
-                )
+                review_text, call_usage = _run_review(patch, f"{patch_name} ({patch_label})")
                 total_usage.add(call_usage)
                 all_reviews.append((patch_label, review_text))
 
@@ -1091,10 +1220,10 @@ def main() -> None:
             # Skip the normal API call
             estimated_tokens = 0  # Bypass size check since we've already processed
 
-    # Check if content is too large
+    # Check if content is too large (cloud API only)
     is_large = estimated_tokens > max_input_tokens
 
-    if is_large:
+    if is_large and not via:
         print(
             f"Warning: Estimated {estimated_tokens:,} tokens exceeds limit of "
             f"{max_input_tokens:,}",
@@ -1137,19 +1266,7 @@ def main() -> None:
                 chunk_label = f"Chunk {chunk_num}/{total_chunks}"
                 print(f"Reviewing {chunk_label}...", file=sys.stderr)
 
-                review_text, call_usage = call_api(
-                    args.provider,
-                    auth,
-                    model,
-                    args.tokens,
-                    system_prompt,
-                    agents_content,
-                    chunk,
-                    f"{patch_name} ({chunk_label})",
-                    args.output_format,
-                    args.verbose,
-                    args.timeout,
-                )
+                review_text, call_usage = _run_review(chunk, f"{patch_name} ({chunk_label})")
                 total_usage.add(call_usage)
                 all_reviews.append((chunk_label, review_text))
 
@@ -1163,8 +1280,11 @@ def main() -> None:
 
     if args.verbose:
         print("=== Request ===", file=sys.stderr)
-        print(f"Provider: {args.provider}", file=sys.stderr)
-        print(f"Auth method: {'vertex' if auth == 'vertex' else 'direct'}", file=sys.stderr)
+        if via:
+            print(f"Runner: {args.via}", file=sys.stderr)
+        else:
+            print(f"Provider: {args.provider}", file=sys.stderr)
+            print(f"Auth method: {'vertex' if auth == 'vertex' else 'direct'}", file=sys.stderr)
         print(f"Model: {model}", file=sys.stderr)
         print(f"Review date: {review_date}", file=sys.stderr)
         if args.release:
@@ -1191,26 +1311,13 @@ def main() -> None:
 
     # Call API (unless already processed via chunks/split)
     if estimated_tokens > 0:  # Not already processed
-        review_text, call_usage = call_api(
-            args.provider,
-            auth,
-            model,
-            args.tokens,
-            system_prompt,
-            agents_content,
-            patch_content,
-            patch_name,
-            args.output_format,
-            args.verbose,
-            args.timeout,
-        )
+        review_text, call_usage = _run_review(patch_content, patch_name)
         total_usage.add(call_usage)
 
     if not review_text:
-        error(f"No response received from {args.provider}")
+        error(f"No response received from {provider_name}")
 
     # Format output based on requested format
-    provider_name = config["name"]
 
     if args.output_format == "json":
         # For JSON, try to parse and add metadata
@@ -1234,7 +1341,7 @@ def main() -> None:
         output_data = {
             "metadata": {
                 "patch_file": patch_name,
-                "provider": args.provider,
+                "provider": args.via or args.provider,
                 "provider_name": provider_name,
                 "model": model,
                 "review_date": review_date,
@@ -1289,7 +1396,7 @@ def main() -> None:
 
     print_token_summary(
         total_usage,
-        args.provider,
+        args.via or args.provider,
         model,
         args.show_tokens or args.verbose,
     )
-- 
2.54.0


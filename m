Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2222CC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 09:19:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44300402DF;
	Fri,  3 Jul 2026 11:19:13 +0200 (CEST)
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com
 [162.62.57.210])
 by mails.dpdk.org (Postfix) with UTF8SMTP id AAC63402D4
 for <dev@dpdk.org>; Fri,  3 Jul 2026 11:19:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1783070345; bh=WhrSA4p1G/rRwJurAQuTkbwEn3kgXx+OR7m74h9DmUc=;
 h=From:To:Cc:Subject:Date;
 b=rCq8xrslKIsL2cCS+lx4mjShJKDyJA1SOeyytahKpIqkUQ2QqZ11mglFQ4HMrR9qB
 Gi7BAQgZBlOgIhsz/Zq0Tn6yovvJL2PYkKXxUOb8HiBVfOtElVW1NdlrO1/8MNts3f
 y/2I8XPNy9MMq8tzsCbFn8/3inhmsgCZuroRd/pg=
Received: from fedora.tail0f0cf3.ts.net ([139.159.170.83])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id 4C3B1480; Fri, 03 Jul 2026 17:19:03 +0800
X-QQ-mid: xmsmtpt1783070343twg4sdo3d
Message-ID: <tencent_4A299B76E71AE508AF5D403AFDA4B248B708@qq.com>
X-QQ-XMAILINFO: NJEIVRXLMI4pwP+dmkdN+9i0ybzd0Ez1a//ZbX7y4xiodBOkZffaP3uNTnmUT0
 m3ME0uCQLd0EDLbt5T/RcncwmU9IEbvo2MawtBG8S4TQlkLR/MPUj8mXZf+K1DkQWFHvDuPDQXdn
 PDbkMecd8JN5S3xCvFX3cs3uQ1spXMMlOGDfDTF5v4Rl0y02X0UfAqID5Fo2na8GpQ+Ab28R4sMG
 XqEsRoz1IqIZMFUn1KJos1nmGbTsSJlXHH2SphF/6jcXXDWbtbLpWERsxo7ihHl3HLoDuCtsm8uI
 fERTJZp76XKtjpW/i5DSxgxsYG4jvfEpC6KEdP8425EbdwKOjXvFWobpkNXXJLm5MVLZZ29nBmFV
 H8cezVEtI4S9IcgF09TvE4Jk5zp/kPGZ6q6FqBj2l/IIw1Zl7ZnB4Y3qiO7QZDR/+WHhEFLMwi3r
 sWG367cIxnWtXkIC15D5VXxAUaNIUDVqh93ia6Xoj2uc9HuCu754B7NR9qVWWZTEZpzL1k/vha/9
 iYXhTHpiBnGb/MK5NGT8lrKpahVZPKzzPBKn4PdNnxU12HFRL55jLVtVHe4DzldEu3EJdEDH+iJd
 5RPP7pThfWsx9tTnQVEzt2xjt3f+5UmX2Xp/gXySYHNtoI+ol/loBhFOhzZhz/zJDowO9909GBZm
 gcE0xT0g720eih4eZfYqBS9XjqqTgIHZpozWDOH6Ov1ajXS94gHMun+y5bgHtsYLeeICD5Ah0GAU
 Qj4AO5qWWc+i3do4thnfaSo/fmPLDlVPKUJGGgMx312uYLYq9veg19rAfTRL0npjkaCFLHi+SXes
 4PZ5ihBbdjoFQeUMrCzvYpn915FyAA78OIKXW4hke4HgC08oNnaIkFUkzpUyjeHictqG4cdKkUEg
 2EqOXmR63iW8p3h10u6vEg4wfIFp//SYg8sFXqDiFnlhkCkauJh0vGuETTYPClnsimOJAbtdyG9U
 6MBRAiUnn3Yv825C/YU54tz+E6sib0FCd5nI2v9yWtC2VKtjzaqEaSmWqPltiHuOxMH5gHm2o0uo
 1SKLCJ+BxGvEfEk7MrjiQ5mRyU53mpFRDU1W1bIgchJHad5uI3KL5DuaEUcJCOcIcO4XLJFKaOxX
 RGK7zyx3GfJL9KqsVikYXxL+5mOXT+ZpLfGrH1nfxc12rWhyaFc76r+LgmIg==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: datshan@qq.com
To: thomas@monjalon.net,
	stephen@networkplumber.org
Cc: aconole@redhat.com,
	dev@dpdk.org
Subject: [PATCH] devtools: support local opencode agent for patch review
Date: Fri,  3 Jul 2026 17:19:02 +0800
X-OQ-MSGID: <20260703091902.525837-1-datshan@qq.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
 devtools/ai/review-patch.py | 223 ++++++++++++++++++++++++++----------
 1 file changed, 162 insertions(+), 61 deletions(-)

diff --git a/devtools/ai/review-patch.py b/devtools/ai/review-patch.py
index 52601ac156..a05c1e81df 100755
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
@@ -551,6 +552,111 @@ def build_google_request(
     }
 
 
+def _call_opencode(
+    model: str,
+    max_tokens: int,
+    system_prompt: str,
+    patch_content: str,
+    patch_name: str,
+    output_format: str = "text",
+    verbose: bool = False,
+    timeout: int = 300,
+) -> tuple[str, TokenUsage]:
+    """Call local opencode CLI for review."""
+    import tempfile
+
+    format_instruction = FORMAT_INSTRUCTIONS.get(output_format, "")
+    user_prompt = (
+        f"Review the attached DPDK patch file '{patch_name}'.\n\n"
+        f"Focus on correctness bugs, C coding style, API requirements, "
+        f"and other guideline violations. "
+        f"Commit message format and SPDX/copyright are checked by "
+        f"checkpatches.sh — do NOT flag those.\n\n"
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
+        full_message = (
+            f"{system_prompt}\n\n{user_prompt}"
+        )
+
+        cmd = [
+            "opencode", "run", "--format", "json",
+            "--dir", str(Path(__file__).resolve().parent.parent.parent),
+            "--file", patch_temp,
+        ]
+        if model:
+            cmd.extend(["--model", model])
+        if verbose:
+            cmd.append("--print-logs")
+        cmd.append("--")
+        cmd.append(full_message)
+
+        if verbose:
+            print(f"Running: {' '.join(cmd[:-1])} '...'", file=sys.stderr)
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
+
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
+        error(f"No review text received from opencode")
+
+    return review_text, usage
+
+
 def call_api(
     provider: str,
     api_key: str,
@@ -740,6 +846,7 @@ def main() -> None:
 Examples:
     %(prog)s patch.patch                    # Review with default settings
     %(prog)s -p openai my-patch.patch       # Use OpenAI ChatGPT
+    %(prog)s --via opencode my-patch.patch  # Use local opencode agent
     %(prog)s -f markdown patch.patch        # Output as Markdown
     %(prog)s -f json -o review.json patch.patch  # Save JSON to file
     %(prog)s -f html -o review.html patch.patch  # Save HTML to file
@@ -786,7 +893,13 @@ def main() -> None:
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
@@ -926,14 +1039,19 @@ def main() -> None:
     if not args.patch_file:
         parser.error("patch_file is required")
 
-    # Get provider config
-    config = PROVIDERS[args.provider]
-    model = args.model or config["default_model"]
-
-    # Get API key
-    api_key = os.environ.get(config["env_var"])
-    if not api_key:
-        error(f"{config['env_var']} environment variable not set")
+    # Get provider config or set up local agent runner
+    via = args.via
+    if via:
+        model = args.model or ""
+        api_key = ""
+        provider_name = "OpenCode"
+    else:
+        config = PROVIDERS[args.provider]
+        model = args.model or config["default_model"]
+        api_key = os.environ.get(config["env_var"])
+        if not api_key:
+            error(f"{config['env_var']} environment variable not set")
+        provider_name = config["name"]
 
     # Validate files
     agents_path = Path(args.agents)
@@ -971,13 +1089,30 @@ def main() -> None:
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
+                model, args.tokens, system_prompt,
+                patch_body, patch_label,
+                args.output_format, args.verbose, args.timeout,
+            )
+        return call_api(
+            args.provider, api_key, model, args.tokens,
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
@@ -1039,19 +1174,7 @@ def main() -> None:
                 patch_label = f"Patch {i}/{total_patches}"
                 print(f"\nReviewing {patch_label}...", file=sys.stderr)
 
-                review_text, call_usage = call_api(
-                    args.provider,
-                    api_key,
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
 
@@ -1063,10 +1186,10 @@ def main() -> None:
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
@@ -1109,19 +1232,7 @@ def main() -> None:
                 chunk_label = f"Chunk {chunk_num}/{total_chunks}"
                 print(f"Reviewing {chunk_label}...", file=sys.stderr)
 
-                review_text, call_usage = call_api(
-                    args.provider,
-                    api_key,
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
 
@@ -1135,7 +1246,10 @@ def main() -> None:
 
     if args.verbose:
         print("=== Request ===", file=sys.stderr)
-        print(f"Provider: {args.provider}", file=sys.stderr)
+        if via:
+            print(f"Runner: {args.via}", file=sys.stderr)
+        else:
+            print(f"Provider: {args.provider}", file=sys.stderr)
         print(f"Model: {model}", file=sys.stderr)
         print(f"Review date: {review_date}", file=sys.stderr)
         if args.release:
@@ -1162,26 +1276,13 @@ def main() -> None:
 
     # Call API (unless already processed via chunks/split)
     if estimated_tokens > 0:  # Not already processed
-        review_text, call_usage = call_api(
-            args.provider,
-            api_key,
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
@@ -1260,7 +1361,7 @@ def main() -> None:
 
     print_token_summary(
         total_usage,
-        args.provider,
+        args.via or args.provider,
         model,
         args.show_tokens or args.verbose,
     )
-- 
2.54.0


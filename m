Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCADC5AC7A
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 03:11:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93E3440279;
	Fri,  7 Aug 2026 05:11:40 +0200 (CEST)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com
 [91.218.175.185])
 by mails.dpdk.org (Postfix) with ESMTP id 706E440275
 for <dev@dpdk.org>; Fri,  7 Aug 2026 05:11:39 +0200 (CEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1786072298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zn6pSgFfFr6dxegvzejJAq6+IwviL3WkX18DirmcO6k=;
 b=fkxrNkFhYWUMIU0Jr8XVS5QbCAcSd3AyQd/DPErT7IJRxNEQN++I2sTUakG/AlfPTKDmsn
 /IufAcOCas5RCounkbx9dr0ax8hN8rql4svfo2uIWgacgBIdky0uIbpJxPt0Qld942+LE6
 FWpNP1HjMzDq72xydLPH6jdHGcH0wmM=
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	stephen@networkplumber.org
Cc: aconole@redhat.com,
	dev@dpdk.org
Subject: [PATCH v5] devtools: support local opencode agent for patch review
Date: Fri,  7 Aug 2026 11:11:04 +0800
Message-ID: <20260807031104.2503404-1-chengwen.feng@linux.dev>
In-Reply-To: <20260703091902.525837-1-datshan@qq.com>
References: <20260703091902.525837-1-datshan@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
v5: Use linux.dev mailbox to send email and update mailmap
v4: Fix AI review comments with Claude Opus which provided by Stephen
v3: Rebase main to fix apply error
v2: Address comments from Stephen, including: not arise
FileNotFoundError and more clarify.

---
 .mailmap                            |   2 +-
 devtools/ai/review-patch.py         | 305 ++++++++++++++++++++++------
 doc/guides/contributing/patches.rst |  10 +
 3 files changed, 249 insertions(+), 68 deletions(-)

diff --git a/.mailmap b/.mailmap
index fcb3d1bb3f..d86a09b5b3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -270,7 +270,7 @@ Chengfei Han <han.chengfei@zte.com.cn>
 Chengfeng Ye <cyeaa@connect.ust.hk>
 Chenghu Yao <yao.chenghu@zte.com.cn>
 Chenglian Sun <sunchenglian@loongson.cn>
-Chengwen Feng <fengchengwen@huawei.com>
+Chengwen Feng <fengchengwen@huawei.com> <chengwen.feng@linux.dev>
 Chenmin Sun <chenmin.sun@intel.com>
 Chenming Chang <ccm@ccm.ink>
 Chenna Arnoori <chenna.arnoori@broadcom.com>
diff --git a/devtools/ai/review-patch.py b/devtools/ai/review-patch.py
index 5f8d9ed772..c8d81a3333 100755
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
@@ -577,6 +578,160 @@ def build_google_request(
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
+    """Call local opencode CLI for review.
+
+    Note: opencode runs with its default agent toolset, which includes
+    write/edit/bash against the working tree (--dir points at the DPDK
+    root). A review should ideally be read-only; restricting the toolset
+    requires opencode to gain a --read-only or --agent flag, which it
+    does not currently expose. Until then, be aware that the reviewing
+    agent can in principle modify the tree it is reviewing.
+    """
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
+        # opencode auto-loads AGENTS.md from --dir; -a is only meaningful
+        # when pointing at a non-default file. Resolve to an absolute
+        # path because --dir differs from the caller's cwd.
+        agents_abs = str(Path(agents_path).resolve()) if agents_path else ""
+
+        cmd = [
+            "opencode",
+            "run",
+            "--format",
+            "json",
+            "--dir",
+            str(Path(__file__).resolve().parent.parent.parent),
+        ]
+        if model:
+            cmd.extend(["--model", model])
+        # In verbose mode, let opencode's own logs reach the user
+        # instead of capturing and discarding them.
+        if verbose:
+            cmd.append("--print-logs")
+        cmd.append(full_message)
+        cmd.extend(["--file", patch_temp])
+        if agents_abs:
+            cmd.extend(["--file", agents_abs])
+
+        if verbose:
+            print(f"Running: {' '.join(cmd)}", file=sys.stderr)
+
+        try:
+            result = subprocess.run(
+                cmd,
+                stdout=subprocess.PIPE,
+                stderr=None if verbose else subprocess.PIPE,
+                text=True,
+                timeout=timeout,
+            )
+        except FileNotFoundError:
+            error("opencode not found. Install from https://opencode.ai")
+        except subprocess.TimeoutExpired:
+            error(f"opencode timed out after {timeout} seconds")
+
+        if result.returncode != 0:
+            stderr = result.stderr or ""
+            error(
+                f"opencode exited with code {result.returncode}: "
+                f"{stderr[:500]}"
+            )
+
+    finally:
+        os.unlink(patch_temp)
+
+    stdout = result.stdout or ""
+    # Buffer text per messageID so we can keep only the final assistant
+    # turn (the actual review) and drop intermediate narration such as
+    # "Let me read AGENTS.md first...".
+    message_text: dict[str, list[str]] = {}
+    message_order: list[str] = []
+    final_message_id = ""
+    usage = TokenUsage()
+    steps = 0
+
+    for line in stdout.splitlines():
+        stripped = line.strip()
+        if not stripped:
+            continue
+        try:
+            event = json.loads(stripped)
+        except json.JSONDecodeError:
+            continue
+
+        event_type = event.get("type", "")
+        part = event.get("part", {})
+        if event_type == "text":
+            mid = part.get("messageID", "")
+            if mid:
+                if mid not in message_text:
+                    message_text[mid] = []
+                    message_order.append(mid)
+                message_text[mid].append(part.get("text", ""))
+        elif event_type == "step_finish":
+            steps += 1
+            if part.get("reason") == "stop":
+                final_message_id = part.get("messageID", "") or final_message_id
+            tokens = part.get("tokens", {})
+            if tokens:
+                usage.input_tokens += tokens.get("input", 0)
+                usage.output_tokens += tokens.get("output", 0)
+                cache = tokens.get("cache", {})
+                usage.cache_creation_tokens += cache.get("write", 0)
+                usage.cache_read_tokens += cache.get("read", 0)
+        elif event_type == "error":
+            err = event.get("error", {})
+            err_name = err.get("name", "unknown")
+            err_msg = err.get("data", {}).get("message", "")
+            error(f"opencode: {err_name}: {err_msg}")
+
+    usage.api_calls = steps
+
+    if final_message_id and final_message_id in message_text:
+        review_text = "\n".join(message_text[final_message_id])
+    elif message_order:
+        # No explicit stop marker; fall back to the last message that
+        # produced text.
+        review_text = "\n".join(message_text[message_order[-1]])
+    else:
+        review_text = ""
+
+    if not review_text:
+        snippet = stdout[:300].replace("\n", " ")
+        error(
+            f"No review text received from opencode; "
+            f"stdout begins: {snippet!r}"
+        )
+
+    return review_text, usage
+
+
 def call_api(
     provider: str,
     auth: str,
@@ -764,6 +919,7 @@ def main() -> None:
 Examples:
     %(prog)s patch.patch                    # Review with default settings
     %(prog)s -p openai my-patch.patch       # Use OpenAI ChatGPT
+    %(prog)s --via opencode my-patch.patch  # Use local opencode agent
     %(prog)s -f markdown patch.patch        # Output as Markdown
     %(prog)s -f json -o review.json patch.patch  # Save JSON to file
     %(prog)s -f html -o review.html patch.patch  # Save HTML to file
@@ -809,8 +965,14 @@ def main() -> None:
         "-p",
         "--provider",
         choices=PROVIDERS.keys(),
-        default="anthropic",
-        help="AI provider (default: anthropic)",
+        default=None,
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
@@ -956,12 +1118,26 @@ def main() -> None:
     if not args.patch_file:
         parser.error("patch_file is required")
 
-    # Get provider config
-    config = PROVIDERS[args.provider]
-    model = args.model or config["default_model"]
-
-    # Get authentication string
-    auth = get_auth_string(args.auth, args.provider)
+    # --via and -p/--auth are mutually exclusive; -p defaults to anthropic
+    # when neither --via nor -p is given. Detect explicit -p/--auth by
+    # comparing against the original parser default of None.
+    via = args.via
+    if via and args.provider is not None:
+        parser.error("--via and -p/--provider are mutually exclusive")
+    if via and args.auth != "auto":
+        parser.error("--via and --auth are mutually exclusive")
+    provider = args.provider or "anthropic"
+
+    # Get provider config or set up local agent runner
+    if via:
+        model = args.model or ""
+        auth = ""
+        provider_name = "OpenCode"
+    else:
+        config = PROVIDERS[provider]
+        model = args.model or config["default_model"]
+        auth = get_auth_string(args.auth, provider)
+        provider_name = config["name"]
 
     # Validate files
     agents_path = Path(args.agents)
@@ -999,17 +1175,45 @@ def main() -> None:
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
+            provider, auth, model, args.tokens,
+            system_prompt, agents_content,
+            patch_body, patch_label,
+            args.output_format, args.verbose, args.timeout,
+        )
 
-    # Estimate token count
-    estimated_tokens = estimate_tokens(patch_content + agents_content)
+    # Determine max tokens (cloud API only)
+    max_input_tokens = 0
+    estimated_tokens = 0
+    if via:
+        pass
+    else:
+        max_input_tokens = args.max_tokens or PROVIDER_INPUT_LIMITS.get(
+            provider, 100000
+        )
+        estimated_tokens = estimate_tokens(patch_content + agents_content)
+
+    already_reviewed = False
 
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
@@ -1067,19 +1271,8 @@ def main() -> None:
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
+                label = f"{patch_name} ({patch_label})"
+                review_text, call_usage = _run_review(patch, label)
                 total_usage.add(call_usage)
                 all_reviews.append((patch_label, review_text))
 
@@ -1088,13 +1281,12 @@ def main() -> None:
                 all_reviews, args.output_format, patch_name
             )
 
-            # Skip the normal API call
-            estimated_tokens = 0  # Bypass size check since we've already processed
+            already_reviewed = True
 
-    # Check if content is too large
+    # Check if content is too large (cloud API only)
     is_large = estimated_tokens > max_input_tokens
 
-    if is_large:
+    if is_large and not via:
         print(
             f"Warning: Estimated {estimated_tokens:,} tokens exceeds limit of "
             f"{max_input_tokens:,}",
@@ -1137,19 +1329,8 @@ def main() -> None:
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
+                label = f"{patch_name} ({chunk_label})"
+                review_text, call_usage = _run_review(chunk, label)
                 total_usage.add(call_usage)
                 all_reviews.append((chunk_label, review_text))
 
@@ -1158,13 +1339,16 @@ def main() -> None:
                 all_reviews, args.output_format, patch_name
             )
 
-            # Skip the normal single API call below
-            estimated_tokens = 0
+            already_reviewed = True
 
     if args.verbose:
         print("=== Request ===", file=sys.stderr)
-        print(f"Provider: {args.provider}", file=sys.stderr)
-        print(f"Auth method: {'vertex' if auth == 'vertex' else 'direct'}", file=sys.stderr)
+        if via:
+            print(f"Runner: {args.via}", file=sys.stderr)
+        else:
+            print(f"Provider: {provider}", file=sys.stderr)
+            method = "vertex" if auth == "vertex" else "direct"
+            print(f"Auth method: {method}", file=sys.stderr)
         print(f"Model: {model}", file=sys.stderr)
         print(f"Review date: {review_date}", file=sys.stderr)
         if args.release:
@@ -1190,27 +1374,14 @@ def main() -> None:
         print("===============", file=sys.stderr)
 
     # Call API (unless already processed via chunks/split)
-    if estimated_tokens > 0:  # Not already processed
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
+    if not already_reviewed:
+        review_text, call_usage = _run_review(patch_content, patch_name)
         total_usage.add(call_usage)
 
     if not review_text:
-        error(f"No response received from {args.provider}")
+        error(f"No response received from {provider_name}")
 
     # Format output based on requested format
-    provider_name = config["name"]
 
     if args.output_format == "json":
         # For JSON, try to parse and add metadata
@@ -1234,7 +1405,7 @@ def main() -> None:
         output_data = {
             "metadata": {
                 "patch_file": patch_name,
-                "provider": args.provider,
+                "provider": args.via or provider,
                 "provider_name": provider_name,
                 "model": model,
                 "review_date": review_date,
@@ -1289,7 +1460,7 @@ def main() -> None:
 
     print_token_summary(
         total_usage,
-        args.provider,
+        args.via or provider,
         model,
         args.show_tokens or args.verbose,
     )
diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
index f4996fd195..bae0a8217a 100644
--- a/doc/guides/contributing/patches.rst
+++ b/doc/guides/contributing/patches.rst
@@ -533,6 +533,13 @@ The script supports multiple AI providers
 An API key for the chosen provider must be set
 in the corresponding environment variable (see ``--list-providers``).
 
+Alternatively, the ``--via opencode`` option uses the locally installed
+`opencode <https://opencode.ai>`_ CLI as the review runner instead of
+calling a cloud API directly.
+opencode reads ``AGENTS.md`` from the DPDK project directory
+and selects the model from its own configuration,
+so no API key needs to be set in the environment.
+
 Basic usage::
 
    # Review a single patch (default provider: Anthropic Claude)
@@ -541,6 +548,9 @@ Basic usage::
    # Use a different provider
    devtools/ai/review-patch.py -p openai my-patch.patch
 
+   # Use the local opencode agent instead of a cloud API
+   devtools/ai/review-patch.py --via opencode my-patch.patch
+
    # Review for an LTS branch (enables stricter rules)
    devtools/ai/review-patch.py -r 24.11 my-patch.patch
 
-- 
2.55.0


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5824CCD8CB2
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 18:27:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00EB740151;
	Tue,  9 Jun 2026 20:27:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 28440400D5
 for <dev@dpdk.org>; Tue,  9 Jun 2026 20:27:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781029619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZIzNpZq6EFY0UteJvAhBSDHBfiRilRPhty5ruZ7a5CA=;
 b=SYi8uWt/R2vab2hy+XqpLAUttcavWI7PhRhQIrkioAAAFJyernt/esw5pW2UbEpKT3yAio
 DXug1EGCf0SS/EuSQeJr/UZCG7IaU0+eY9eZEZPQ9fd9OCzRauUFtSJXcQ6i6QC/XvzHoO
 Um0oqKK30wAXKE1VdlXbIkWxY2csL/U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-mRlUUbD2OxO_9K3s_YV-ZA-1; Tue,
 09 Jun 2026 14:26:55 -0400
X-MC-Unique: mRlUUbD2OxO_9K3s_YV-ZA-1
X-Mimecast-MFC-AGG-ID: mRlUUbD2OxO_9K3s_YV-ZA_1781029614
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B8BE1955F19; Tue,  9 Jun 2026 18:26:54 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.65.94])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 57D7136920; Tue,  9 Jun 2026 18:26:53 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 David Marchand <david.marchand@redhat.com>
Subject: [RFC] devtools: add tool calling support to review-patch.py
Date: Tue,  9 Jun 2026 14:26:47 -0400
Message-ID: <20260609182652.1053422-1-aconole@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dn0_0qSARfj9z7e0dE6sCj_8x0IYCCzaR1otEeT4c_c_1781029614
X-Mimecast-Originator: redhat.com
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

Add an iterative tool-use loop to review-patch.py for the Anthropic
and OpenAI providers. The reviewer can now look up additional context
from the DPDK source tree when the patch alone is insufficient,
rather than having to guess at surrounding code, API contracts, or
function signatures.

Tool calling is enabled by default with a limit of 10 rounds. Pass
'--tool-rounds 0' to disable it and restore the previous single-shot
behavior.  The round limit prevents runaway cost on large patches
that when reached will force the model to deliver a final judgement.

Initial tool set:
  - grep           Searches for regex across the file system with
                   optional path restrictions and case-insensitive
                   matches.
  - file_read      Line range read of a specific path.

Both tools are limited to the repository root to prevent path
traversal.  Path outputs are relative to the repo root.

The system prompt is extended when tool calling is active to
encourage the model to use tools only when genuinely needed,
keeping unnecessary round trips and token costs under control
and to a minimum.

Internally, _common.py gains send_request_raw() (returning the
raw response dict) so the tool-calling loops can inspect
stop_reason / finish_reason before extracting text.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 devtools/ai/_common.py      |  66 ++++-
 devtools/ai/review-patch.py | 552 +++++++++++++++++++++++++++++++++++-
 2 files changed, 602 insertions(+), 16 deletions(-)

diff --git a/devtools/ai/_common.py b/devtools/ai/_common.py
index 69982cbda5..e9fb25557b 100644
--- a/devtools/ai/_common.py
+++ b/devtools/ai/_common.py
@@ -121,7 +121,8 @@ def add_token_args(parser: argparse.ArgumentParser) -> None:
 def print_token_summary(
     usage: TokenUsage, provider: str, model: str, show: bool
 ) -> None:
-    """Print token usage summary to stderr if requested and any calls were made."""
+    """Print token usage summary to stderr if requested and any calls were
+    made."""
     if not show or usage.api_calls == 0:
         return
     print("", file=sys.stderr)
@@ -173,13 +174,15 @@ def _extract_usage(provider: str, result: dict[str, Any]) -> TokenUsage:
 
 
 def _extract_text(provider: str, result: dict[str, Any]) -> str:
-    """Extract response text from a provider response. Calls error() on failure."""
+    """Extract response text from a provider response. Calls error() on
+    failure."""
     if "error" in result:
         error(f"API error: {result['error'].get('message', result)}")
     if provider == "anthropic":
         content = result.get("content", [])
         return "".join(
-            block.get("text", "") for block in content if block.get("type") == "text"
+            block.get("text", "") for block in content
+            if block.get("type") == "text"
         )
     if provider == "google":
         candidates = result.get("candidates", [])
@@ -200,13 +203,14 @@ def _print_verbose_usage(usage: TokenUsage) -> None:
     print(f"Input tokens: {usage.input_tokens:,}", file=sys.stderr)
     print(f"Output tokens: {usage.output_tokens:,}", file=sys.stderr)
     if usage.cache_creation_tokens:
-        print(f"Cache creation: {usage.cache_creation_tokens:,}", file=sys.stderr)
+        print(f"Cache creation: {usage.cache_creation_tokens:,}",
+              file=sys.stderr)
     if usage.cache_read_tokens:
         print(f"Cache read: {usage.cache_read_tokens:,}", file=sys.stderr)
     print("===================", file=sys.stderr)
 
 
-def send_request(
+def _send_http_raw(
     provider: str,
     api_key: str,
     model: str,
@@ -214,13 +218,9 @@ def send_request(
     *,
     timeout: int = 120,
     verbose: bool = False,
-) -> tuple[str, TokenUsage]:
-    """Send a prebuilt request to a provider and return (response_text, usage).
-
-    The caller assembles the provider-specific request body via its own
-    build_*_request helpers (the prompts differ per script). This function
-    handles transport, error reporting, and token-usage extraction.
-    """
+) -> tuple[dict[str, Any], TokenUsage]:
+    """Shared HTTP transport layer. Returns (response_dict, usage). Calls
+    error() on failure."""
     url, headers = _build_request_meta(provider, api_key, model)
     body = json.dumps(request_data).encode("utf-8")
     req = Request(url, data=body, headers=headers)
@@ -243,4 +243,46 @@ def send_request(
     usage = _extract_usage(provider, result)
     if verbose:
         _print_verbose_usage(usage)
+    return result, usage
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
+    result, usage = _send_http_raw(
+        provider, api_key, model, request_data, timeout=timeout,
+        verbose=verbose
+    )
     return _extract_text(provider, result), usage
+
+
+def send_request_raw(
+    provider: str,
+    api_key: str,
+    model: str,
+    request_data: dict[str, Any],
+    *,
+    timeout: int = 120,
+    verbose: bool = False,
+) -> tuple[dict[str, Any], TokenUsage]:
+    """Send a prebuilt request and return the raw response dict plus usage.
+
+    Used by tool-calling loops that need to inspect stop_reason / finish_reason
+    before extracting text.
+    """
+    return _send_http_raw(
+        provider, api_key, model, request_data, timeout=timeout,
+        verbose=verbose
+    )
diff --git a/devtools/ai/review-patch.py b/devtools/ai/review-patch.py
index 52601ac156..18ed445afe 100755
--- a/devtools/ai/review-patch.py
+++ b/devtools/ai/review-patch.py
@@ -29,6 +29,7 @@
     list_providers,
     print_token_summary,
     send_request,
+    send_request_raw,
 )
 
 # Output formats
@@ -114,6 +115,152 @@
 --- PATCH CONTENT ---
 """
 
+TOOL_PROMPT_EXTENSION = """\
+Use tools to gather context that improves the review. Specifically:
+
+- New files or scripts: use grep to find similar existing files and compare \
+structure, naming conventions, and patterns (e.g. for a new CI script, check \
+other scripts under .ci/).
+- Modified or called functions: use grep to find their declaration and \
+file_read to inspect the header or implementation.
+- New symbols, macros, or config keys: use grep to check whether similar names \
+already exist and whether naming conventions are consistent.
+- MAINTAINERS or documentation changes: use file_read to verify the surrounding \
+context is consistent.
+
+Each tool call costs tokens, so skip lookups that clearly add no value. But \
+when in doubt about an existing pattern or convention, look it up."""
+
+TOOLS_ANTHROPIC: list[dict] = [
+    {
+        "name": "grep",
+        "description": (
+            "Search the DPDK source tree for a pattern. Returns matching lines "
+            "with file paths and line numbers. Use to find API definitions, "
+            "usage examples, or code referenced by the patch."
+        ),
+        "input_schema": {
+            "type": "object",
+            "properties": {
+                "pattern": {
+                    "type": "string",
+                    "description": "Regular expression or literal string to "
+                    "search for",
+                },
+                "path": {
+                    "type": "string",
+                    "description": (
+                        "Directory or file path to search, relative to the "
+                        "repo root. Defaults to '.' (entire tree)."
+                    ),
+                },
+                "case_insensitive": {
+                    "type": "boolean",
+                    "description": "Ignore case when matching (default: false)",
+                },
+            },
+            "required": ["pattern"],
+        },
+    },
+    {
+        "name": "file_read",
+        "description": (
+            "Read lines from a file in the DPDK source tree. "
+            "Use to inspect headers, existing implementations, or files "
+            "referenced in the patch."
+        ),
+        "input_schema": {
+            "type": "object",
+            "properties": {
+                "path": {
+                    "type": "string",
+                    "description": "File path relative to the repository root",
+                },
+                "offset": {
+                    "type": "integer",
+                    "description": "First line to return, 1-indexed "
+                    "(default: 1)",
+                },
+                "limit": {
+                    "type": "integer",
+                    "description": "Maximum lines to return (default: 100, "
+                    "max: 500)",
+                },
+            },
+            "required": ["path"],
+        },
+    },
+]
+
+TOOLS_OPENAI: list[dict] = [
+    {
+        "type": "function",
+        "function": {
+            "name": "grep",
+            "description": (
+                "Search the DPDK source tree for a pattern. Returns matching "
+                "lines with file paths and line numbers. Use to find API "
+                "definitions, usage examples, or code referenced by the patch."
+            ),
+            "parameters": {
+                "type": "object",
+                "properties": {
+                    "pattern": {
+                        "type": "string",
+                        "description": "Regular expression or literal string "
+                        "to search for",
+                    },
+                    "path": {
+                        "type": "string",
+                        "description": (
+                            "Directory or file path to search, relative to the "
+                            "repo root. Defaults to '.' (entire tree)."
+                        ),
+                    },
+                    "case_insensitive": {
+                        "type": "boolean",
+                        "description": "Ignore case when matching (default: "
+                        "false)",
+                    },
+                },
+                "required": ["pattern"],
+            },
+        },
+    },
+    {
+        "type": "function",
+        "function": {
+            "name": "file_read",
+            "description": (
+                "Read lines from a file in the DPDK source tree. "
+                "Use to inspect headers, existing implementations, or files "
+                "referenced in the patch."
+            ),
+            "parameters": {
+                "type": "object",
+                "properties": {
+                    "path": {
+                        "type": "string",
+                        "description": "File path relative to the repository "
+                        "root",
+                    },
+                    "offset": {
+                        "type": "integer",
+                        "description": "First line to return, 1-indexed "
+                        "(default: 1)",
+                    },
+                    "limit": {
+                        "type": "integer",
+                        "description": "Maximum lines to return (default: 100, "
+                        "max: 500)",
+                    },
+                },
+                "required": ["path"],
+            },
+        },
+    },
+]
+
 # Exit codes for review results
 EXIT_CLEAN = 0
 EXIT_WARNINGS = 2
@@ -158,9 +305,8 @@ def classify_review(review_text: str, output_format: str) -> int:
                 r"^<h[1-3]>\s*error", stripped
             ):
                 has_errors = True
-            elif re.match(r"^(#{1,3}\s+)?(\*{0,2})warning", stripped) or re.match(
-                r"^<h[1-3]>\s*warning", stripped
-            ):
+            elif re.match(r"^(#{1,3}\s+)?(\*{0,2})warning", stripped) or \
+                 re.match(r"^<h[1-3]>\s*warning", stripped):
                 has_warnings = True
 
     if has_errors:
@@ -551,6 +697,340 @@ def build_google_request(
     }
 
 
+def get_repo_root() -> str:
+    """Return the git repository root, falling back to cwd."""
+    try:
+        result = subprocess.run(
+            ["git", "rev-parse", "--show-toplevel"],
+            capture_output=True,
+            text=True,
+            check=True,
+        )
+        return result.stdout.strip()
+    except (subprocess.CalledProcessError, FileNotFoundError):
+        return os.getcwd()
+
+
+def _tool_grep(tool_input: dict[str, Any], repo_root: str) -> str:
+    """Execute a grep tool call against the repository."""
+    pattern = tool_input.get("pattern", "")
+    rel_path = tool_input.get("path", ".")
+    case_insensitive = tool_input.get("case_insensitive", False)
+
+    repo_resolved = Path(repo_root).resolve()
+    search_path = (repo_resolved / rel_path).resolve()
+    if not str(search_path).startswith(str(repo_resolved)):
+        return "Error: path is outside the repository"
+    if not search_path.exists():
+        return f"Error: path not found: {rel_path}"
+
+    cmd = ["grep", "-nH"]
+    if case_insensitive:
+        cmd.append("-i")
+    if search_path.is_dir():
+        cmd.extend(
+            [
+                "-r",
+                "--include=*.[ch]",
+                "--include=*.py",
+                "--include=*.rst",
+                "--include=*.ini",
+            ]
+        )
+    cmd.extend(["--", pattern, str(search_path)])
+
+    try:
+        proc = subprocess.run(
+            cmd, capture_output=True, text=True, timeout=30, errors="replace"
+        )
+        output = proc.stdout
+        if not output:
+            return "No matches found."
+        # Make paths relative to repo root for readability
+        prefix = str(repo_resolved) + "/"
+        output = output.replace(prefix, "")
+        lines = output.splitlines()
+        if len(lines) > 100:
+            truncated = "\n".join(lines[:100])
+            return f"{truncated}\n... ({len(lines) - 100} more lines truncated)"
+        return output.rstrip()
+    except subprocess.TimeoutExpired:
+        return "Error: grep timed out after 30 seconds"
+    except Exception as e:
+        return f"Error: grep failed: {e}"
+
+
+def _tool_file_read(tool_input: dict[str, Any], repo_root: str) -> str:
+    """Execute a file_read tool call against the repository."""
+    rel_path = tool_input.get("path", "")
+    offset = max(1, int(tool_input.get("offset", 1)))
+    limit = min(500, max(1, int(tool_input.get("limit", 100))))
+
+    repo_resolved = Path(repo_root).resolve()
+    file_path = (repo_resolved / rel_path).resolve()
+    if not str(file_path).startswith(str(repo_resolved)):
+        return "Error: path is outside the repository"
+    if not file_path.exists():
+        return f"Error: file not found: {rel_path}"
+    if not file_path.is_file():
+        return f"Error: not a file: {rel_path}"
+
+    try:
+        content = file_path.read_text(encoding="utf-8", errors="replace")
+        lines = content.splitlines()
+        total = len(lines)
+        start = offset - 1  # convert to 0-indexed
+        end = start + limit
+        selected = lines[start:end]
+        numbered = "\n".join(f"{offset + i}: {line}" for i, line in enumerate(selected))
+        if end < total:
+            numbered += f"\n... ({total - end} more lines; use offset={end + 1} to continue)"
+        return numbered
+    except Exception as e:
+        return f"Error reading file: {e}"
+
+
+def execute_tool(name: str, tool_input: dict[str, Any], repo_root: str) -> str:
+    """Dispatch a tool call by name and return the result string."""
+    if name == "grep":
+        return _tool_grep(tool_input, repo_root)
+    if name == "file_read":
+        return _tool_file_read(tool_input, repo_root)
+    return f"Error: unknown tool '{name}'"
+
+
+def call_api_with_tools_anthropic(
+    api_key: str,
+    model: str,
+    max_tokens: int,
+    system_prompt: str,
+    agents_content: str,
+    patch_content: str,
+    patch_name: str,
+    output_format: str,
+    verbose: bool,
+    timeout: int,
+    max_tool_rounds: int,
+    repo_root: str,
+) -> tuple[str, TokenUsage]:
+    """Anthropic API call with an iterative tool-use loop."""
+    format_instruction = FORMAT_INSTRUCTIONS.get(output_format, "")
+    user_prompt = USER_PROMPT.format(
+        patch_name=patch_name,
+        format_instruction=format_instruction + "\n\n" + TOOL_PROMPT_EXTENSION,
+    )
+
+    system: list[dict[str, Any]] = [
+        {"type": "text", "text": system_prompt},
+        {
+            "type": "text",
+            "text": agents_content,
+            "cache_control": {"type": "ephemeral"},
+        },
+    ]
+    messages: list[dict[str, Any]] = [
+        {"role": "user", "content": user_prompt + patch_content}
+    ]
+    total_usage = TokenUsage()
+
+    for _ in range(max_tool_rounds):
+        request_data: dict[str, Any] = {
+            "model": model,
+            "max_tokens": max_tokens,
+            "system": system,
+            "messages": messages,
+            "tools": TOOLS_ANTHROPIC,
+        }
+        api_result, usage = send_request_raw(
+            "anthropic", api_key, model, request_data, timeout=timeout, verbose=verbose
+        )
+        total_usage.add(usage)
+
+        stop_reason = api_result.get("stop_reason", "end_turn")
+        content_blocks = api_result.get("content", [])
+
+        if stop_reason != "tool_use":
+            text = "".join(
+                b.get("text", "") for b in content_blocks if b.get("type") == "text"
+            )
+            return text, total_usage
+
+        tool_use_blocks = [b for b in content_blocks if b.get("type") == "tool_use"]
+        if verbose:
+            for b in tool_use_blocks:
+                args_str = json.dumps(b.get("input", {}), separators=(",", ":"))
+                print(f"Tool call: {b['name']}({args_str})", file=sys.stderr)
+
+        messages.append({"role": "assistant", "content": content_blocks})
+        tool_results = [
+            {
+                "type": "tool_result",
+                "tool_use_id": b["id"],
+                "content": execute_tool(b["name"], b.get("input", {}), repo_root),
+            }
+            for b in tool_use_blocks
+        ]
+        messages.append({"role": "user", "content": tool_results})
+
+    # Exhausted rounds — append a text instruction to the last user message so
+    # the model understands it must switch from tool-calling to text-generation,
+    # then send with tool_choice:none to prevent further tool use.
+    if verbose:
+        print(
+            f"Tool round limit ({max_tool_rounds}) reached, forcing final judgment",
+            file=sys.stderr,
+        )
+    judgment_text = (
+        "You have reached the maximum number of tool call rounds. "
+        "Do not call any more tools. Based on all information gathered, "
+        "provide your complete final review now."
+    )
+    if messages and messages[-1].get("role") == "user":
+        last_content = messages[-1].get("content", [])
+        if isinstance(last_content, list):
+            messages[-1] = {
+                "role": "user",
+                "content": last_content + [{"type": "text", "text": judgment_text}],
+            }
+    request_data = {
+        "model": model,
+        "max_tokens": max_tokens,
+        "system": system,
+        "messages": messages,
+        "tools": TOOLS_ANTHROPIC,
+        "tool_choice": {"type": "none"},
+    }
+    api_result, usage = send_request_raw(
+        "anthropic", api_key, model, request_data, timeout=timeout, verbose=verbose
+    )
+    total_usage.add(usage)
+    content_blocks = api_result.get("content", [])
+    text = "".join(
+        b.get("text", "") for b in content_blocks if b.get("type") == "text"
+    )
+    if not text:
+        text = "(Review incomplete: tool call limit reached without a final response.)"
+    return text, total_usage
+
+
+def call_api_with_tools_openai(
+    api_key: str,
+    model: str,
+    max_tokens: int,
+    system_prompt: str,
+    agents_content: str,
+    patch_content: str,
+    patch_name: str,
+    output_format: str,
+    verbose: bool,
+    timeout: int,
+    max_tool_rounds: int,
+    repo_root: str,
+) -> tuple[str, TokenUsage]:
+    """OpenAI API call with an iterative tool-use loop."""
+    format_instruction = FORMAT_INSTRUCTIONS.get(output_format, "")
+    user_prompt = USER_PROMPT.format(
+        patch_name=patch_name,
+        format_instruction=format_instruction + "\n\n" + TOOL_PROMPT_EXTENSION,
+    )
+
+    messages: list[dict[str, Any]] = [
+        {"role": "system", "content": system_prompt},
+        {"role": "system", "content": agents_content},
+        {"role": "user", "content": user_prompt + patch_content},
+    ]
+    total_usage = TokenUsage()
+
+    for _ in range(max_tool_rounds):
+        request_data: dict[str, Any] = {
+            "model": model,
+            "max_tokens": max_tokens,
+            "messages": messages,
+            "tools": TOOLS_OPENAI,
+        }
+        api_result, usage = send_request_raw(
+            "openai", api_key, model, request_data, timeout=timeout, verbose=verbose
+        )
+        total_usage.add(usage)
+
+        choices = api_result.get("choices", [])
+        if not choices:
+            return "", total_usage
+
+        choice = choices[0]
+        finish_reason = choice.get("finish_reason", "stop")
+        message = choice.get("message", {})
+
+        if finish_reason != "tool_calls":
+            return message.get("content") or "", total_usage
+
+        tool_calls = message.get("tool_calls", [])
+        if verbose:
+            for tc in tool_calls:
+                fn = tc.get("function", {})
+                print(f"Tool call: {fn.get('name')}({fn.get('arguments', '')})", file=sys.stderr)
+
+        messages.append(
+            {
+                "role": "assistant",
+                "content": message.get("content"),
+                "tool_calls": tool_calls,
+            }
+        )
+
+        for tc in tool_calls:
+            fn = tc.get("function", {})
+            tool_name = fn.get("name", "")
+            try:
+                tool_input = json.loads(fn.get("arguments", "{}"))
+            except json.JSONDecodeError:
+                tool_input = {}
+            result_text = execute_tool(tool_name, tool_input, repo_root)
+            messages.append(
+                {
+                    "role": "tool",
+                    "tool_call_id": tc["id"],
+                    "content": result_text,
+                }
+            )
+
+    # Exhausted rounds — add a user message directing the model to stop calling
+    # tools and deliver its final review, then send with tool_choice:none.
+    if verbose:
+        print(
+            f"Tool round limit ({max_tool_rounds}) reached, forcing final judgment",
+            file=sys.stderr,
+        )
+    messages.append(
+        {
+            "role": "user",
+            "content": (
+                "You have reached the maximum number of tool call rounds. "
+                "Do not call any more tools. Based on all information gathered, "
+                "provide your complete final review now."
+            ),
+        }
+    )
+    request_data = {
+        "model": model,
+        "max_tokens": max_tokens,
+        "messages": messages,
+        "tools": TOOLS_OPENAI,
+        "tool_choice": "none",
+    }
+    api_result, usage = send_request_raw(
+        "openai", api_key, model, request_data, timeout=timeout, verbose=verbose
+    )
+    total_usage.add(usage)
+    choices = api_result.get("choices", [])
+    if not choices:
+        return "(Review incomplete: tool call limit reached without a final response.)", total_usage
+    text = choices[0].get("message", {}).get("content") or ""
+    if not text:
+        text = "(Review incomplete: tool call limit reached without a final response.)"
+    return text, total_usage
+
+
 def call_api(
     provider: str,
     api_key: str,
@@ -563,8 +1043,45 @@ def call_api(
     output_format: str = "text",
     verbose: bool = False,
     timeout: int = 300,
+    max_tool_rounds: int = 0,
+    repo_root: str = "",
 ) -> tuple[str, TokenUsage]:
-    """Build the per-provider request body and dispatch via _common."""
+    """Build the per-provider request body and dispatch via _common.
+
+    When max_tool_rounds > 0 and the provider is anthropic or openai, runs an
+    iterative tool-use loop before returning the final review text.
+    """
+    if max_tool_rounds > 0 and provider == "anthropic":
+        return call_api_with_tools_anthropic(
+            api_key,
+            model,
+            max_tokens,
+            system_prompt,
+            agents_content,
+            patch_content,
+            patch_name,
+            output_format,
+            verbose,
+            timeout,
+            max_tool_rounds,
+            repo_root,
+        )
+    if max_tool_rounds > 0 and provider == "openai":
+        return call_api_with_tools_openai(
+            api_key,
+            model,
+            max_tokens,
+            system_prompt,
+            agents_content,
+            patch_content,
+            patch_name,
+            output_format,
+            verbose,
+            timeout,
+            max_tool_rounds,
+            repo_root,
+        )
+
     if provider == "anthropic":
         request_data = build_anthropic_request(
             model,
@@ -768,6 +1285,11 @@ def main() -> None:
     stricter review rules: bug fixes only, no new features or APIs.
     Any DPDK release with minor version .11 is an LTS release.
 
+Tool Calling (Anthropic and OpenAI only):
+    By default, the reviewer can call grep and file_read tools to look up
+    additional context from the source tree (up to 10 rounds). Use
+    --tool-rounds to change the limit or pass 0 to disable tool use.
+
 Token Usage:
     Use --show-tokens (or -v/--verbose) to print a token usage summary
     on stderr after the run. Off by default.
@@ -840,6 +1362,14 @@ def main() -> None:
         metavar="SECONDS",
         help="API request timeout in seconds (default: 300)",
     )
+    parser.add_argument(
+        "--tool-rounds",
+        type=int,
+        default=10,
+        metavar="N",
+        help="Max tool call rounds for Anthropic/OpenAI providers "
+        "(default: 10, 0 to disable tool calling)",
+    )
 
     # Date and release options
     parser.add_argument(
@@ -971,6 +1501,9 @@ def main() -> None:
     patch_content = patch_path.read_text(encoding="utf-8", errors="replace")
     patch_name = patch_path.name
 
+    # Repo root is used by tool calls (grep, file_read) to locate source files
+    repo_root = get_repo_root()
+
     # Determine max tokens for this provider
     max_input_tokens = args.max_tokens or PROVIDER_INPUT_LIMITS.get(
         args.provider, 100000
@@ -1051,6 +1584,8 @@ def main() -> None:
                     args.output_format,
                     args.verbose,
                     args.timeout,
+                    args.tool_rounds,
+                    repo_root,
                 )
                 total_usage.add(call_usage)
                 all_reviews.append((patch_label, review_text))
@@ -1121,6 +1656,8 @@ def main() -> None:
                     args.output_format,
                     args.verbose,
                     args.timeout,
+                    args.tool_rounds,
+                    repo_root,
                 )
                 total_usage.add(call_usage)
                 all_reviews.append((chunk_label, review_text))
@@ -1150,6 +1687,11 @@ def main() -> None:
             print(f"Large file mode: {args.large_file}", file=sys.stderr)
         if args.split_patches:
             print("Split patches: yes", file=sys.stderr)
+        if args.provider in ("anthropic", "openai"):
+            if args.tool_rounds > 0:
+                print(f"Tool calling: enabled (max {args.tool_rounds} rounds)", file=sys.stderr)
+            else:
+                print("Tool calling: disabled", file=sys.stderr)
         if args.output:
             print(f"Output file: {args.output}", file=sys.stderr)
         if args.send_email:
@@ -1174,6 +1716,8 @@ def main() -> None:
             args.output_format,
             args.verbose,
             args.timeout,
+            args.tool_rounds,
+            repo_root,
         )
         total_usage.add(call_usage)
 
-- 
2.51.0


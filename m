Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60296CD6E57
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 13:39:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8120D4025F;
	Mon,  1 Jun 2026 15:39:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 133464025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 15:39:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780321179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7YokX9qDXfGSkdREtRTB7CH/ioz/fbM6451cqyrO7wY=;
 b=FaV+bXBIdofu3s1uiTJtuWuyc6AxZzWSQZWx10+bPMWd6goqD879yg1mUUBpAqx7M8lEFj
 I22nH+J/np7v1bUxbSS2UA+vtuqZkzKlWgcgihCaQciFPK9cyKjw7aXrT5Auh0p2pCzYRE
 6bqvAJQT/OM0m8SMsRPpiK6rV2Ir+eE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-Q6fx-GBmOjSZTymZ0325RQ-1; Mon,
 01 Jun 2026 09:24:18 -0400
X-MC-Unique: Q6fx-GBmOjSZTymZ0325RQ-1
X-Mimecast-MFC-AGG-ID: Q6fx-GBmOjSZTymZ0325RQ_1780320257
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D87721956095; Mon,  1 Jun 2026 13:24:16 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 192DF180034E; Mon,  1 Jun 2026 13:24:14 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>
Subject: [PATCH] devtools: add Vertex AI to review scripts
Date: Mon,  1 Jun 2026 15:24:01 +0200
Message-ID: <20260601132402.1125588-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Wsi1E1OKMYj5tm15VbhDpvBRCG9Ct8VrccqgOLbpHls_1780320257
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Add support for Google Vertex AI authentication as an alternative to
direct API key authentication. All four providers (Anthropic, Google,
OpenAI, xAI) can now use Vertex AI with Application Default Credentials.

This requires a python dependency google-auth but it is left as
optional.

Key features:
- Auto-detection of authentication method based on environment
- Manual override via --auth flag (auto, direct, vertex)
- Automatic model name translation for Vertex format
- Support for both global and regional Vertex endpoints
- Proper error handling for Vertex API responses

Provider-specific implementations:
- Anthropic: Uses /publishers/anthropic/models/{model}:rawPredict
  with model name format claude-sonnet-4-5@20250929
- Google: Uses /publishers/google/models/{model}:generateContent
- OpenAI/xAI: Use /endpoints/openapi/chat/completions
  with publisher prefix (e.g., openai/gpt-oss-120b-maas)

Authentication detection logic:
- Vertex: Requires google-auth library and ADC configured
- Direct: Falls back to API key from environment variables

Available models on Vertex AI:
- Anthropic: All Claude models
- Google: All Gemini models
- OpenAI: gpt-oss-120b-maas, gpt-oss-20b-maas (open-weight only)
- xAI: grok-4.20-*, grok-4.1-fast-* variants

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Note: I only tested Vertex work.
I have no API key to double check the "direct" method is still working.

---
 devtools/ai/_common.py      | 166 ++++++++++++++++++++++++++++++++----
 devtools/ai/review-doc.py   |  35 ++++++--
 devtools/ai/review-patch.py |  39 ++++++---
 3 files changed, 205 insertions(+), 35 deletions(-)

diff --git a/devtools/ai/_common.py b/devtools/ai/_common.py
index 69982cbda5..0c1257842f 100644
--- a/devtools/ai/_common.py
+++ b/devtools/ai/_common.py
@@ -6,6 +6,7 @@
 
 import argparse
 import json
+import os
 import subprocess
 import sys
 from dataclasses import dataclass
@@ -13,6 +14,14 @@
 from urllib.error import HTTPError, URLError
 from urllib.request import Request, urlopen
 
+# Optional dependency for Vertex AI
+try:
+    from google.auth import default as google_auth_default
+    from google.auth.transport.requests import Request as GoogleAuthRequest
+    VERTEX_AI_AVAILABLE = True
+except ImportError:
+    VERTEX_AI_AVAILABLE = False
+
 # Provider configurations (model defaults; override with --model).
 PROVIDERS: dict[str, dict[str, str]] = {
     "anthropic": {
@@ -128,25 +137,137 @@ def print_token_summary(
     print(format_token_summary(usage, provider, model), file=sys.stderr)
 
 
+def get_vertex_credentials() -> tuple[str, str]:
+    """Get Google Cloud access token and project for Vertex AI.
+
+    Uses Application Default Credentials (ADC).
+    Requires: gcloud auth application-default login
+
+    Returns: (access_token, project_id)
+    """
+    credentials, project = google_auth_default()
+
+    # Refresh credentials to get access token
+    auth_request = GoogleAuthRequest()
+    credentials.refresh(auth_request)
+
+    if not project:
+        error("Could not detect GCP project. Set GOOGLE_CLOUD_PROJECT environment variable or run: gcloud config set project PROJECT_ID")
+
+    return credentials.token, project
+
+
+def model_to_vertex(model: str, provider: str) -> str:
+    """Convert model name to Vertex AI format.
+
+    Anthropic models use @ for version dates:
+    - API format: claude-sonnet-4-5-20250929
+    - Vertex format: claude-sonnet-4-5@20250929
+
+    OpenAI/xAI models need publisher prefix:
+    - Vertex requires: openai/gpt-oss-120b-maas
+
+    Other providers use the same format for both.
+    """
+    if provider == "anthropic":
+        # Match pattern: ends with -YYYYMMDD (8 digits)
+        if model.count('-') >= 3:
+            parts = model.rsplit('-', 1)
+            if len(parts) == 2 and len(parts[1]) == 8 and parts[1].isdigit():
+                return f"{parts[0]}@{parts[1]}"
+    elif provider in ("openai", "xai"):
+        # Add publisher prefix if not already present
+        if "/" not in model:
+            return f"{provider}/{model}"
+    return model
+
+
+def detect_auth_method(provider: str) -> str:
+    """Detect authentication method for a provider.
+
+    Args:
+        provider: The provider name (e.g., "anthropic", "openai")
+
+    Returns:
+        "direct" or "vertex"
+    """
+    env_var = PROVIDERS[provider]["env_var"]
+    if os.environ.get(env_var):
+        return "direct"
+    if VERTEX_AI_AVAILABLE:
+        try:
+            credentials, project = google_auth_default()
+            if credentials and project:
+                return "vertex"
+        except Exception:
+            pass
+    return "direct"
+
+
 def _build_request_meta(
-    provider: str, api_key: str, model: str
-) -> tuple[str, dict[str, str]]:
-    """Return (url, headers) for a provider request."""
+    provider: str, auth: str, model: str, request_data: dict[str, Any]
+) -> tuple[str, dict[str, str], dict[str, Any]]:
+    """Return (url, headers, request_data) for a provider request.
+
+    Args:
+        provider: Provider name
+        auth: Authentication string - either "direct:<api_key>" or "vertex"
+        model: Model identifier
+        request_data: The request payload (may be modified for Vertex)
+
+    Returns:
+        Tuple of (url, headers, modified_request_data)
+    """
     config = PROVIDERS[provider]
-    if provider == "anthropic":
+
+    if auth.startswith("direct:"):
+        api_key = auth[7:]
+        if provider == "anthropic":
+            request_data["model"] = model
+            return config["endpoint"], {
+                "Content-Type": "application/json",
+                "x-api-key": api_key,
+                "anthropic-version": "2023-06-01",
+            }, request_data
+        if provider == "google":
+            url = f"{config['endpoint']}/{model}:generateContent?key={api_key}"
+            return url, {"Content-Type": "application/json"}, request_data
+        # openai, xai
+        request_data["model"] = model
         return config["endpoint"], {
             "Content-Type": "application/json",
-            "x-api-key": api_key,
-            "anthropic-version": "2023-06-01",
-        }
-    if provider == "google":
-        url = f"{config['endpoint']}/{model}:generateContent?key={api_key}"
-        return url, {"Content-Type": "application/json"}
-    # openai, xai
-    return config["endpoint"], {
+            "Authorization": f"Bearer {api_key}",
+        }, request_data
+
+    # Vertex AI authentication
+    if auth != "vertex":
+        error(f"Invalid auth format: {auth}")
+
+    access_token, project_id = get_vertex_credentials()
+    project_id = os.environ.get("GOOGLE_CLOUD_PROJECT") or os.environ.get("GCP_PROJECT") or project_id
+    location = os.environ.get("CLOUD_ML_REGION", "global")
+
+    if location == "global":
+        vertex_base = f"https://aiplatform.googleapis.com/v1/projects/{project_id}/locations/{location}"
+    else:
+        vertex_base = f"https://{location}-aiplatform.googleapis.com/v1/projects/{project_id}/locations/{location}"
+
+    headers = {
         "Content-Type": "application/json",
-        "Authorization": f"Bearer {api_key}",
+        "Authorization": f"Bearer {access_token}",
     }
+    vertex_model = model_to_vertex(model, provider)
+
+    if provider == "anthropic":
+        request_data["anthropic_version"] = "vertex-2023-10-16"
+        url = f"{vertex_base}/publishers/anthropic/models/{vertex_model}:rawPredict"
+    elif provider == "google":
+        url = f"{vertex_base}/publishers/google/models/{vertex_model}:generateContent"
+    else:  # openai, xai
+        request_data["model"] = vertex_model
+        url = f"{vertex_base}/endpoints/openapi/chat/completions"
+
+    return url, headers, request_data
 
 
 def _extract_usage(provider: str, result: dict[str, Any]) -> TokenUsage:
@@ -208,7 +329,7 @@ def _print_verbose_usage(usage: TokenUsage) -> None:
 
 def send_request(
     provider: str,
-    api_key: str,
+    auth: str,
     model: str,
     request_data: dict[str, Any],
     *,
@@ -220,8 +341,19 @@ def send_request(
     The caller assembles the provider-specific request body via its own
     build_*_request helpers (the prompts differ per script). This function
     handles transport, error reporting, and token-usage extraction.
+
+    Args:
+        provider: Provider name (anthropic, openai, xai, google)
+        auth: Authentication string - either "direct:<api_key>" or "vertex"
+        model: Model identifier
+        request_data: Provider-specific request payload
+        timeout: Request timeout in seconds
+        verbose: Show detailed token usage
+
+    Returns:
+        Tuple of (response_text, token_usage)
     """
-    url, headers = _build_request_meta(provider, api_key, model)
+    url, headers, request_data = _build_request_meta(provider, auth, model, request_data)
     body = json.dumps(request_data).encode("utf-8")
     req = Request(url, data=body, headers=headers)
 
@@ -232,6 +364,8 @@ def send_request(
         error_body = e.read().decode("utf-8")
         try:
             error_data = json.loads(error_body)
+            if isinstance(error_data, list) and error_data:
+                error_data = error_data[0]
             error(f"API error: {error_data.get('error', error_body)}")
         except json.JSONDecodeError:
             error(f"API error ({e.code}): {error_body}")
@@ -239,6 +373,8 @@ def send_request(
         if isinstance(e.reason, TimeoutError):
             error(f"Request timed out after {timeout} seconds")
         error(f"Connection error: {e.reason}")
+    except TimeoutError:
+        error(f"Request timed out after {timeout} seconds")
 
     usage = _extract_usage(provider, result)
     if verbose:
diff --git a/devtools/ai/review-doc.py b/devtools/ai/review-doc.py
index 24e70ae06b..ee02c7ee40 100755
--- a/devtools/ai/review-doc.py
+++ b/devtools/ai/review-doc.py
@@ -24,8 +24,10 @@
 
 from _common import (
     PROVIDERS,
+    VERTEX_AI_AVAILABLE,
     TokenUsage,
     add_token_args,
+    detect_auth_method,
     error,
     get_git_config,
     list_providers,
@@ -273,7 +275,6 @@ def build_anthropic_request(
         doc_file, commit_prefix, output_format, include_diff_markers
     )
     return {
-        "model": model,
         "max_tokens": max_tokens,
         "system": [
             {"type": "text", "text": SYSTEM_PROMPT},
@@ -307,7 +308,6 @@ def build_openai_request(
         doc_file, commit_prefix, output_format, include_diff_markers
     )
     return {
-        "model": model,
         "max_tokens": max_tokens,
         "messages": [
             {"role": "system", "content": SYSTEM_PROMPT},
@@ -352,7 +352,7 @@ def build_google_request(
 
 def call_api(
     provider: str,
-    api_key: str,
+    auth: str,
     model: str,
     max_tokens: int,
     agents_content: str,
@@ -399,7 +399,7 @@ def call_api(
         )
     return send_request(
         provider,
-        api_key,
+        auth,
         model,
         request_data,
         timeout=timeout,
@@ -631,6 +631,12 @@ def main() -> None:
         help="Show API request details",
     )
     add_token_args(parser)
+    parser.add_argument(
+        "--auth",
+        choices=["auto", "direct", "vertex"],
+        default="auto",
+        help="Authentication method: auto (default), direct (API key), vertex (Google Cloud)",
+    )
     parser.add_argument(
         "-q",
         "--quiet",
@@ -709,10 +715,20 @@ def main() -> None:
     config = PROVIDERS[args.provider]
     model = args.model or config["default_model"]
 
-    # Get API key
-    api_key = os.environ.get(config["env_var"])
-    if not api_key:
-        error(f"{config['env_var']} environment variable not set")
+    if args.auth == "auto":
+        auth_method = detect_auth_method(args.provider)
+    else:
+        auth_method = args.auth
+
+    if auth_method == "vertex":
+        if not VERTEX_AI_AVAILABLE:
+            error("Vertex AI support requires 'google-auth' library. Install with: pip install google-auth")
+        auth = "vertex"
+    else:
+        api_key = os.environ.get(config["env_var"])
+        if not api_key:
+            error(f"{config['env_var']} environment variable not set")
+        auth = f"direct:{api_key}"
 
     # Validate files
     agents_path = Path(args.agents)
@@ -783,6 +799,7 @@ def main() -> None:
         if args.verbose:
             print("=== Request ===", file=sys.stderr)
             print(f"Provider: {args.provider}", file=sys.stderr)
+            print(f"Auth method: {auth_method}", file=sys.stderr)
             print(f"Model: {model}", file=sys.stderr)
             print(f"Output format: {args.output_format}", file=sys.stderr)
             print(f"AGENTS file: {args.agents}", file=sys.stderr)
@@ -800,7 +817,7 @@ def main() -> None:
         # Call API
         review_text, call_usage = call_api(
             args.provider,
-            api_key,
+            auth,
             model,
             args.tokens,
             agents_content,
diff --git a/devtools/ai/review-patch.py b/devtools/ai/review-patch.py
index 52601ac156..8f2ce85a12 100755
--- a/devtools/ai/review-patch.py
+++ b/devtools/ai/review-patch.py
@@ -22,8 +22,10 @@
 
 from _common import (
     PROVIDERS,
+    VERTEX_AI_AVAILABLE,
     TokenUsage,
     add_token_args,
+    detect_auth_method,
     error,
     get_git_config,
     list_providers,
@@ -474,7 +476,6 @@ def build_anthropic_request(
         patch_name=patch_name, format_instruction=format_instruction
     )
     return {
-        "model": model,
         "max_tokens": max_tokens,
         "system": [
             {"type": "text", "text": system_prompt},
@@ -508,7 +509,6 @@ def build_openai_request(
         patch_name=patch_name, format_instruction=format_instruction
     )
     return {
-        "model": model,
         "max_tokens": max_tokens,
         "messages": [
             {"role": "system", "content": system_prompt},
@@ -553,7 +553,7 @@ def build_google_request(
 
 def call_api(
     provider: str,
-    api_key: str,
+    auth: str,
     model: str,
     max_tokens: int,
     system_prompt: str,
@@ -596,7 +596,7 @@ def call_api(
         )
     return send_request(
         provider,
-        api_key,
+        auth,
         model,
         request_data,
         timeout=timeout,
@@ -813,6 +813,12 @@ def main() -> None:
         help="Show API request details",
     )
     add_token_args(parser)
+    parser.add_argument(
+        "--auth",
+        choices=["auto", "direct", "vertex"],
+        default="auto",
+        help="Authentication method: auto (default), direct (API key), vertex (Google Cloud)",
+    )
     parser.add_argument(
         "-f",
         "--format",
@@ -930,10 +936,20 @@ def main() -> None:
     config = PROVIDERS[args.provider]
     model = args.model or config["default_model"]
 
-    # Get API key
-    api_key = os.environ.get(config["env_var"])
-    if not api_key:
-        error(f"{config['env_var']} environment variable not set")
+    if args.auth == "auto":
+        auth_method = detect_auth_method(args.provider)
+    else:
+        auth_method = args.auth
+
+    if auth_method == "vertex":
+        if not VERTEX_AI_AVAILABLE:
+            error("Vertex AI support requires 'google-auth' library. Install with: pip install google-auth")
+        auth = "vertex"
+    else:
+        api_key = os.environ.get(config["env_var"])
+        if not api_key:
+            error(f"{config['env_var']} environment variable not set")
+        auth = f"direct:{api_key}"
 
     # Validate files
     agents_path = Path(args.agents)
@@ -1041,7 +1057,7 @@ def main() -> None:
 
                 review_text, call_usage = call_api(
                     args.provider,
-                    api_key,
+                    auth,
                     model,
                     args.tokens,
                     system_prompt,
@@ -1111,7 +1127,7 @@ def main() -> None:
 
                 review_text, call_usage = call_api(
                     args.provider,
-                    api_key,
+                    auth,
                     model,
                     args.tokens,
                     system_prompt,
@@ -1136,6 +1152,7 @@ def main() -> None:
     if args.verbose:
         print("=== Request ===", file=sys.stderr)
         print(f"Provider: {args.provider}", file=sys.stderr)
+        print(f"Auth method: {auth_method}", file=sys.stderr)
         print(f"Model: {model}", file=sys.stderr)
         print(f"Review date: {review_date}", file=sys.stderr)
         if args.release:
@@ -1164,7 +1181,7 @@ def main() -> None:
     if estimated_tokens > 0:  # Not already processed
         review_text, call_usage = call_api(
             args.provider,
-            api_key,
+            auth,
             model,
             args.tokens,
             system_prompt,
-- 
2.53.0


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0D4C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 15:03:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A3C04026F;
	Fri,  3 Jul 2026 17:03:10 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 586A84003C
 for <dev@dpdk.org>; Fri,  3 Jul 2026 17:03:08 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso288118a91.2
 for <dev@dpdk.org>; Fri, 03 Jul 2026 08:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783090987;
 x=1783695787; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=q4htJTS15iIL9oOoGLfw/TPlleJLLynVbEcite1MMqc=;
 b=uK5fchWgo8HFhTXujoAcBfbYuV6DdoBZ2vQkjAboawUi/PhauHAgRwKCWZGxA+z0Tr
 awn1IhJO5OmSisuWKYbbCvn2AnIyEsZIV5IpMhe+JCtmrhZgeJCfGjN0/VpJ5X33c58B
 5Yq/SF+LvCsAHYmvFCSBTz/LVwjtoTs5PKO4yipI55CuIiSaral4LVzxwqpgnrqreGaz
 f7pWDsURKjN0vJkHh8w3vff1kfGtNuehWrncU0hrjy+H7yOZyymO/KJmRkd7TF3RAIdO
 jiZLiKTw8FTM/gpqvM1YxTeuKH44Mkp71MHcpkqK3B6hiOb3uABjQ4z9tlTTxphPdQIj
 B9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783090987; x=1783695787;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q4htJTS15iIL9oOoGLfw/TPlleJLLynVbEcite1MMqc=;
 b=gJY3fUh5IkecKZCaEqZZZJ1W8h3hhBqcwto9xP/EX+CIAn8sYkRhUjNLJMpS8WzLUE
 lRs/79lkAGxbFiJ3xD7EH4tIk3kQ68/EQolcIom09JbZ4J/aUh784TBWNLkZ3+Z7Mi+6
 xiw41Z6G/KBG8B9ccNK5NchPf8kKKjMLPwk0q+xgieKva0gR2xhBkI6DWN10bHCu2eBz
 jzZiNtepXUeVZQFSVIvraV3APDGnWvY0RPQTCM0Dk/KA735rNrucjg83umnSLbWEQFNR
 Kbs1Ugzs3j5tLsg+Us5OBOIf3HKITqj/FAKTwZ8xZiKhbyPcTrm56fWxVJYQnpO9nDQH
 iTdg==
X-Gm-Message-State: AOJu0YzygsNHmSX0j75kqMmWNbIFH2o96BU2M7XG7DuU2Ph9U+S9MOSN
 deCN1uQQcYBiqgjO348Ie+1x9qINU0PDg2RFPKWCodq19aDjF+Moqd0Rxc6rBgS0AqSyql67XE1
 fw2aV
X-Gm-Gg: AfdE7cnRcnUDTgg2AHTAZXj4WUScJV0zggIhWmnselkAxYHolYljBFiOldw3ggUi6Qr
 tqQf++xuMEGJwFvBPWr3FTxRvi20HGCLvK1ysH0xzpi8NIvC3vTVJYRL8kgr0MRFm6sD/HBMVnp
 JH4JBboAwc9ll+GRcPFSju98jbKOBvDGjBBYkaetR+i9Jmg/5yB+xUSnWOj13+0t4FnD28tpch+
 96ZPCwopRCCXBZvvh7B68StLryXMzx3ksL9yWIDG0xKy0n+6LgNCVWRl7b/n7rJrfVnJ29ZSMds
 Ii1/frhzFaPMfEtXuxH4EqkfLdfFtaf/HjeDB64tvJvI4jtLg+kBQoDYbqBMALbLqmuJfp04iQ/
 EPh5aw22gk+2rOSqQxp3fOUrcaq3lCnUfvrpxa9664tsREk/qTbwoylFgvGpoFqHTyhLM3A6ABt
 TDDvTYYtKoyLAYoEZ7h/s3wU+gPr5dAQm7OG5w4Mftrm3c3DVjNQs=
X-Received: by 2002:a17:90b:5648:b0:380:f34a:6ff1 with SMTP id
 98e67ed59e1d1-380f34a72a9mr7612874a91.17.1783090986648; 
 Fri, 03 Jul 2026 08:03:06 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bbd221bsm22394188eec.22.2026.07.03.08.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 08:03:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC] review-patch: verify structured findings against the patch
Date: Fri,  3 Jul 2026 08:03:00 -0700
Message-ID: <20260703150300.353751-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Recent AI reviews have lots of extraneous warnings.

Reviews were misclassified in two ways: findings from a stale
patch revision were reported as current, and classify_review()
pattern-matched prose so a "### Errors" header above a discarded
item counted as an error.

Require the model to return a single JSON object where each error
and warning quotes one line verbatim from the patch. Drop findings
whose evidence or file is not in the diff into a separate
unverified section. Derive the exit code from verified counts
only. Render text/markdown/html locally from the findings.

Stamp output with git patch-id --stable and a final
"X-AI-Review:" verdict line for CI to parse. Retry once on
invalid JSON, then report a contract violation at warning level.

Add --replay for offline testing and tests/run-tests.sh.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 AGENTS.md                   |  52 ++-
 devtools/ai/review-patch.py | 661 ++++++++++++++++++++++++++----------
 2 files changed, 521 insertions(+), 192 deletions(-)

diff --git a/AGENTS.md b/AGENTS.md
index af9a7e0772..47a4636307 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -1836,20 +1836,58 @@ devtools/get-maintainer.sh <patch-file>
 
 ---
 
-# Response Format
+# Output Contract
 
-When you identify an issue:
-1. **State the problem** (1 sentence)
-2. **Why it matters** (1 sentence, only if not obvious)
-3. **Suggested fix** (code snippet or specific action)
+**Deliberation is private.** Work through candidate findings, trace error
+paths, and apply the final checks below BEFORE writing any output. The
+output must contain ONLY findings that survived. Never output:
+- candidate findings followed by "Discard this item" or "(Correction: ...)"
+- reasoning such as "Wait, reviewing the code more carefully..."
+- section headers for severities that have no findings
+- prose verdicts ("No issues found" prose, "all patches are correct")
 
-Example: This could panic if the string is NULL.
+The output is a single JSON object - no markdown fences, no text before or
+after it:
+
+```
+{
+  "summary": "one line",
+  "errors": [
+    {"issue": "what is wrong", "location": "file:line",
+     "evidence": "one line copied exactly from the patch",
+     "suggestion": "specific fix"}
+  ],
+  "warnings": [same fields as errors],
+  "info": [{"issue": "...", "location": "file:line", "suggestion": "..."}]
+}
+```
+
+**Evidence is mandatory for errors and warnings.** Copy one line verbatim
+from the patch (the added `+` line for new code). For missing-cleanup or
+missing-check findings, quote the line that allocates, opens, or calls.
+The harness verifies evidence against the patch under review: findings
+whose evidence does not appear in the patch are discarded as unverifiable
+(this catches reviews of a stale patch revision and hallucinated line
+references), so quote precisely.
+
+The `issue` field should state the problem in one sentence, add one
+sentence on why it matters only if not obvious, and `suggestion` should be
+a specific fix.
+
+If there are no findings, the entire output is:
+
+```
+{"summary": "No issues found.", "errors": [], "warnings": [], "info": []}
+```
 
 ---
 
 ## FINAL CHECK BEFORE SUBMITTING REVIEW
 
-Before outputting your review, do two separate passes:
+Before outputting your review, do two separate passes.
+Both passes are private deliberation:
+the JSON output contains only the findings that survive them,
+with no trace of items that were considered and removed.
 
 ### Pass 1: Verify correctness bugs are included
 
diff --git a/devtools/ai/review-patch.py b/devtools/ai/review-patch.py
index 52601ac156..6623b3d8c2 100755
--- a/devtools/ai/review-patch.py
+++ b/devtools/ai/review-patch.py
@@ -15,8 +15,10 @@
 import subprocess
 import sys
 import tempfile
+from dataclasses import dataclass, field
 from datetime import date
 from email.message import EmailMessage
+from html import escape
 from pathlib import Path
 from typing import Any, Iterator
 
@@ -66,37 +68,31 @@
 - Copyright years should reflect when the code was originally written
 - Be conservative: reject changes that aren't clearly bug fixes"""
 
-FORMAT_INSTRUCTIONS = {
-    "text": """Provide your review in plain text format.""",
-    "markdown": """Provide your review in Markdown format with:
-- Headers (##) for each severity level (Errors, Warnings, Info)
-- Bullet points for individual issues
-- Code blocks (```) for code references
-- Bold (**) for emphasis on key points""",
-    "html": """Provide your review in HTML format with:
-- <h2> tags for each severity level (Errors, Warnings, Info)
-- <ul>/<li> for individual issues
-- <pre><code> for code references
-- <strong> for emphasis on key points
-- Use appropriate semantic HTML tags
-- Do NOT include <html>, <head>, or <body> tags - just the content""",
-    "json": """Provide your review in JSON format with this structure:
+REVIEW_JSON_INSTRUCTION = """\
+Respond with a single JSON object and nothing else - no markdown fences, \
+no prose before or after, no section headers:
 {
-  "summary": "Brief one-line summary of the review",
+  "summary": "one line",
   "errors": [
-    {"issue": "description", "location": "file:line", "suggestion": "fix"}
+    {"issue": "what is wrong", "location": "file:line",
+     "evidence": "one line copied exactly from the patch",
+     "suggestion": "specific fix"}
   ],
-  "warnings": [
-    {"issue": "description", "location": "file:line", "suggestion": "fix"}
-  ],
-  "info": [
-    {"issue": "description", "location": "file:line", "suggestion": "fix"}
-  ],
-  "passed_checks": ["list of checks that passed"],
-  "overall_status": "PASS|WARN|FAIL"
-}
-Output ONLY valid JSON, no markdown code fences or other text.""",
+  "warnings": [same fields as errors],
+  "info": [{"issue": "...", "location": "file:line", "suggestion": "..."}]
 }
+Rules:
+- Deliberation is private. Output ONLY findings that survive your final
+  checks; never output candidate findings, "Discard this item", or
+  corrections.
+- Empty severities are empty arrays, never prose.
+- "evidence" must be copied verbatim from the patch (the added '+' line for
+  new code). For missing-cleanup or missing-check findings, quote the line
+  that allocates or calls. Findings whose evidence does not appear in the
+  patch are discarded by the harness as unverifiable.
+- If there are no findings:
+  {"summary": "No issues found.", "errors": [], "warnings": [], "info": []}
+"""
 
 USER_PROMPT = """Please review the following DPDK patch file '{patch_name}' \
 against the AGENTS.md guidelines. Focus on:
@@ -119,57 +115,213 @@
 EXIT_WARNINGS = 2
 EXIT_ERRORS = 3
 
+# Appended to the prompt when the first response was not valid JSON.
+RETRY_NOTE = (
+    "\n\nREMINDER: the previous response was not a single valid JSON "
+    "object. Respond again with ONLY the JSON object in the required schema."
+)
 
-def classify_review(review_text: str, output_format: str) -> int:
-    """Classify review result and return appropriate exit code.
 
-    Returns:
-        0 - clean (no errors or warnings)
-        2 - warnings found (no errors)
-        3 - errors found
-    """
-    has_errors = False
-    has_warnings = False
+@dataclass
+class ReviewSection:
+    """One reviewed unit (whole patch file, one patch, or one chunk)."""
+
+    label: str
+    data: dict[str, Any] | None = None
+    unverified: list[dict[str, Any]] = field(default_factory=list)
+    raw: str | None = None
+
+    @property
+    def contract_violation(self) -> bool:
+        """True when the model response could not be parsed as JSON."""
+        return self.data is None
 
-    if output_format == "json":
+
+def extract_json(text: str) -> dict[str, Any] | None:
+    """Parse a JSON object from model output, tolerating code fences."""
+    candidate = text.strip()
+    if candidate.startswith("```"):
+        candidate = re.sub(r"^```[a-zA-Z]*\n", "", candidate)
+        candidate = re.sub(r"\n```\s*$", "", candidate)
+    try:
+        data = json.loads(candidate)
+        if isinstance(data, dict):
+            return data
+    except json.JSONDecodeError:
+        pass
+    # Fall back to the outermost braces
+    first = candidate.find("{")
+    last = candidate.rfind("}")
+    if first != -1 and last > first:
         try:
-            data = json.loads(review_text)
-            if data.get("errors"):
-                has_errors = True
-            if data.get("warnings"):
-                has_warnings = True
-            status = data.get("overall_status", "").upper()
-            if status == "FAIL":
-                has_errors = True
-            elif status == "WARN":
-                has_warnings = True
-        except (json.JSONDecodeError, AttributeError):
-            pass  # Fall through to text scanning
-
-    if not has_errors and not has_warnings:
-        # Scan review text for severity indicators.
-        # Match section headers and inline markers across text/markdown/html.
-        for line in review_text.splitlines():
-            stripped = line.strip().lower()
-            # Skip quoted patch context lines
-            if stripped.startswith(">") or stripped.startswith("diff --git"):
+            data = json.loads(candidate[first : last + 1])
+            if isinstance(data, dict):
+                return data
+        except json.JSONDecodeError:
+            pass
+    return None
+
+
+def get_patch_ids(patch_content: str) -> list[str]:
+    """Return stable patch ids for the content under review.
+
+    Uses `git patch-id --stable`, which is invariant to format-patch
+    regeneration (timestamps, commit hashes, version prefixes) but changes
+    whenever the diff content changes. This pins a review to the exact
+    revision it reviewed. Returns an empty list if git is unavailable.
+    """
+    try:
+        result = subprocess.run(
+            ["git", "patch-id", "--stable"],
+            input=patch_content,
+            capture_output=True,
+            text=True,
+            check=True,
+        )
+    except (subprocess.CalledProcessError, FileNotFoundError):
+        return []
+    ids = []
+    for line in result.stdout.splitlines():
+        fields = line.split()
+        if fields:
+            ids.append(fields[0])
+    return ids
+
+
+def _normalize_line(line: str) -> str:
+    """Collapse whitespace; drop a leading diff marker if present."""
+    if line[:1] in "+- ":
+        line = line[1:]
+    return " ".join(line.split())
+
+
+def build_patch_line_index(patch_content: str) -> set[str]:
+    """Set of normalized lines appearing in the patch."""
+    index = set()
+    for line in patch_content.splitlines():
+        norm = _normalize_line(line)
+        if norm:
+            index.add(norm)
+    return index
+
+
+def finding_is_verified(
+    finding: dict[str, Any], line_index: set[str], patch_content: str
+) -> bool:
+    """Check a finding's evidence and location against the patch content.
+
+    Guards against stale reviews (findings quoted from a different revision
+    of the patch) and hallucinated line references: every evidence line must
+    appear in the patch, and the file named in location must be part of it.
+    """
+    evidence = str(finding.get("evidence", "")).strip()
+    if not evidence:
+        return False
+    for line in evidence.splitlines():
+        norm = _normalize_line(line)
+        if norm and norm not in line_index:
+            return False
+    location = str(finding.get("location", ""))
+    fname = location.rsplit(":", 1)[0].strip()
+    if fname:
+        # Lenient: the model may shorten the path, so match the basename
+        base = fname.rsplit("/", 1)[-1]
+        if base and base not in patch_content:
+            return False
+    return True
+
+
+def verify_findings(
+    data: dict[str, Any], patch_content: str
+) -> tuple[dict[str, Any], list[dict[str, Any]]]:
+    """Split errors/warnings into verified and unverified findings.
+
+    Info findings pass through unchecked; they are often general
+    suggestions with no specific line to quote.
+    """
+    line_index = build_patch_line_index(patch_content)
+    unverified = []
+    verified = dict(data)
+    for severity in ("errors", "warnings"):
+        kept = []
+        for finding in data.get(severity) or []:
+            if not isinstance(finding, dict):
                 continue
-            if re.match(r"^(#{1,3}\s+)?(\*{0,2})error", stripped) or re.match(
-                r"^<h[1-3]>\s*error", stripped
-            ):
-                has_errors = True
-            elif re.match(r"^(#{1,3}\s+)?(\*{0,2})warning", stripped) or re.match(
-                r"^<h[1-3]>\s*warning", stripped
-            ):
-                has_warnings = True
+            if finding_is_verified(finding, line_index, patch_content):
+                kept.append(finding)
+            else:
+                dropped = dict(finding)
+                dropped["severity"] = severity[:-1]
+                unverified.append(dropped)
+        verified[severity] = kept
+    verified["info"] = [f for f in (data.get("info") or []) if isinstance(f, dict)]
+    return verified, unverified
+
+
+def process_review_text(
+    review_text: str, patch_content: str, label: str
+) -> ReviewSection:
+    """Parse and verify one model response into a ReviewSection."""
+    data = extract_json(review_text)
+    if data is None:
+        return ReviewSection(label=label, raw=review_text)
+    verified, unverified = verify_findings(data, patch_content)
+    return ReviewSection(label=label, data=verified, unverified=unverified)
+
+
+def section_counts(sections: list[ReviewSection]) -> dict[str, int]:
+    """Aggregate finding counts across sections."""
+    counts = {
+        "errors": 0,
+        "warnings": 0,
+        "info": 0,
+        "unverified": 0,
+        "violations": 0,
+    }
+    for sec in sections:
+        if sec.contract_violation:
+            counts["violations"] += 1
+            continue
+        counts["errors"] += len(sec.data.get("errors", []))
+        counts["warnings"] += len(sec.data.get("warnings", []))
+        counts["info"] += len(sec.data.get("info", []))
+        counts["unverified"] += len(sec.unverified)
+    return counts
+
+
+def classify_review(counts: dict[str, int]) -> int:
+    """Exit code from verified finding counts.
+
+    Status is derived ONLY from the parsed, verified findings - never from
+    pattern matching on prose (a "### Errors" header above "None found"
+    must not trip the classifier).
 
-    if has_errors:
+    Returns:
+        0 - clean (no errors or warnings)
+        2 - warnings, unverified findings, or output-contract violations
+        3 - errors found
+    """
+    if counts["errors"]:
         return EXIT_ERRORS
-    if has_warnings:
+    if counts["warnings"] or counts["unverified"] or counts["violations"]:
         return EXIT_WARNINGS
     return EXIT_CLEAN
 
 
+def summary_trailer(counts: dict[str, int], patch_ids: list[str]) -> str:
+    """One-line machine-readable verdict for CI to parse.
+
+    CI labelers should parse this line (or the JSON output), not the prose.
+    """
+    ids = ",".join(pid[:16] for pid in patch_ids) or "unknown"
+    return (
+        f"X-AI-Review: errors={counts['errors']} "
+        f"warnings={counts['warnings']} info={counts['info']} "
+        f"unverified={counts['unverified']} "
+        f"contract-violations={counts['violations']} patch-id={ids}"
+    )
+
+
 def is_lts_release(release: str | None) -> bool:
     """Check if a release is an LTS release.
 
@@ -413,34 +565,82 @@ def get_summary_prompt() -> str:
 """
 
 
-def format_combined_reviews(
-    reviews: list[tuple[str, str]], output_format: str, patch_name: str
-) -> str:
-    """Combine multiple chunk/patch reviews into a single output."""
-    if output_format == "json":
-        combined = {
-            "patch_file": patch_name,
-            "sections": [
-                {"label": label, "review": review} for label, review in reviews
-            ],
-        }
-        return json.dumps(combined, indent=2)
-    elif output_format == "html":
-        sections = []
-        for label, review in reviews:
-            sections.append(f"<h2>{label}</h2>\n{review}")
-        return "\n<hr>\n".join(sections)
-    elif output_format == "markdown":
-        sections = []
-        for label, review in reviews:
-            sections.append(f"## {label}\n\n{review}")
-        return "\n\n---\n\n".join(sections)
-    else:  # text
-        sections = []
-        for label, review in reviews:
-            sections.append(f"=== {label} ===\n\n{review}")
-        separator = "\n\n" + "=" * 60 + "\n\n"
-        return separator.join(sections)
+def _finding_lines(num: int, finding: dict[str, Any]) -> list[str]:
+    """Render one finding as indented text lines."""
+    lines = [f"  {num}. {finding.get('location') or 'unspecified location'}"]
+    issue = str(finding.get("issue", "")).strip()
+    if issue:
+        lines.append(f"     {issue}")
+    for ev_line in str(finding.get("evidence", "")).strip().splitlines():
+        lines.append(f"     > {ev_line}")
+    suggestion = str(finding.get("suggestion", "")).strip()
+    if suggestion:
+        lines.append(f"     Fix: {suggestion}")
+    return lines
+
+
+def render_section_text(sec: ReviewSection) -> str:
+    """Render one ReviewSection as plain text."""
+    if sec.contract_violation:
+        return (
+            "Output contract violation: the model response was not a valid "
+            "JSON review.\nRaw response follows (unparsed, counted as a "
+            f"warning):\n\n{sec.raw}"
+        )
+    lines: list[str] = []
+    summary = str(sec.data.get("summary", "")).strip()
+    if summary:
+        lines.append(summary)
+    titles = (("errors", "Errors"), ("warnings", "Warnings"), ("info", "Info"))
+    for key, title in titles:
+        findings = sec.data.get(key, [])
+        if not findings:
+            continue
+        lines.append("")
+        lines.append(f"{title}:")
+        for i, finding in enumerate(findings, 1):
+            lines.extend(_finding_lines(i, finding))
+    if sec.unverified:
+        lines.append("")
+        lines.append(
+            "Unverified findings (evidence not found in this patch "
+            "revision; possibly from a stale review - not counted):"
+        )
+        for i, finding in enumerate(sec.unverified, 1):
+            lines.extend(_finding_lines(i, finding))
+    if len(lines) <= 1 and not sec.unverified:
+        return summary or "No issues found."
+    return "\n".join(lines)
+
+
+def render_sections(sections: list[ReviewSection], output_format: str) -> str:
+    """Render all sections in the requested format.
+
+    Markdown and HTML are simple wrappings of the text rendering; findings
+    content comes from the verified structure in all formats.
+    """
+    parts = []
+    for sec in sections:
+        body = render_section_text(sec)
+        if output_format == "markdown":
+            if len(sections) > 1:
+                parts.append(f"## {sec.label}\n\n```\n{body}\n```")
+            else:
+                parts.append(f"```\n{body}\n```")
+        elif output_format == "html":
+            title = f"<h2>{escape(sec.label)}</h2>\n" if len(sections) > 1 else ""
+            parts.append(f"{title}<pre>{escape(body)}</pre>")
+        else:  # text
+            if len(sections) > 1:
+                parts.append(f"=== {sec.label} ===\n\n{body}")
+            else:
+                parts.append(body)
+    if output_format == "markdown":
+        return "\n\n---\n\n".join(parts)
+    if output_format == "html":
+        return "\n<hr>\n".join(parts)
+    separator = "\n\n" + "=" * 60 + "\n\n"
+    return separator.join(parts)
 
 
 def build_system_prompt(review_date: str, release: str | None) -> str:
@@ -466,10 +666,10 @@ def build_anthropic_request(
     agents_content: str,
     patch_content: str,
     patch_name: str,
-    output_format: str = "text",
+    retry_note: str = "",
 ) -> dict[str, Any]:
     """Build request payload for Anthropic API."""
-    format_instruction = FORMAT_INSTRUCTIONS.get(output_format, "")
+    format_instruction = REVIEW_JSON_INSTRUCTION + retry_note
     user_prompt = USER_PROMPT.format(
         patch_name=patch_name, format_instruction=format_instruction
     )
@@ -500,10 +700,10 @@ def build_openai_request(
     agents_content: str,
     patch_content: str,
     patch_name: str,
-    output_format: str = "text",
+    retry_note: str = "",
 ) -> dict[str, Any]:
     """Build request payload for OpenAI-compatible APIs."""
-    format_instruction = FORMAT_INSTRUCTIONS.get(output_format, "")
+    format_instruction = REVIEW_JSON_INSTRUCTION + retry_note
     user_prompt = USER_PROMPT.format(
         patch_name=patch_name, format_instruction=format_instruction
     )
@@ -527,10 +727,10 @@ def build_google_request(
     agents_content: str,
     patch_content: str,
     patch_name: str,
-    output_format: str = "text",
+    retry_note: str = "",
 ) -> dict[str, Any]:
     """Build request payload for Google Gemini API."""
-    format_instruction = FORMAT_INSTRUCTIONS.get(output_format, "")
+    format_instruction = REVIEW_JSON_INSTRUCTION + retry_note
     user_prompt = USER_PROMPT.format(
         patch_name=patch_name, format_instruction=format_instruction
     )
@@ -560,7 +760,7 @@ def call_api(
     agents_content: str,
     patch_content: str,
     patch_name: str,
-    output_format: str = "text",
+    retry_note: str = "",
     verbose: bool = False,
     timeout: int = 300,
 ) -> tuple[str, TokenUsage]:
@@ -573,7 +773,7 @@ def call_api(
             agents_content,
             patch_content,
             patch_name,
-            output_format,
+            retry_note,
         )
     elif provider == "google":
         request_data = build_google_request(
@@ -582,7 +782,7 @@ def call_api(
             agents_content,
             patch_content,
             patch_name,
-            output_format,
+            retry_note,
         )
     else:  # openai, xai
         request_data = build_openai_request(
@@ -592,7 +792,7 @@ def call_api(
             agents_content,
             patch_content,
             patch_name,
-            output_format,
+            retry_note,
         )
     return send_request(
         provider,
@@ -604,6 +804,59 @@ def call_api(
     )
 
 
+def reviewed_section(
+    provider: str,
+    api_key: str,
+    model: str,
+    max_tokens: int,
+    system_prompt: str,
+    agents_content: str,
+    content: str,
+    name: str,
+    label: str,
+    verbose: bool,
+    timeout: int,
+    usage: TokenUsage,
+) -> ReviewSection:
+    """Run one review call, retrying once if the response is not valid JSON."""
+    review_text, call_usage = call_api(
+        provider,
+        api_key,
+        model,
+        max_tokens,
+        system_prompt,
+        agents_content,
+        content,
+        name,
+        "",
+        verbose,
+        timeout,
+    )
+    usage.add(call_usage)
+    section = process_review_text(review_text, content, label)
+    if section.contract_violation:
+        print(
+            f"{label}: response was not valid JSON, retrying once...",
+            file=sys.stderr,
+        )
+        review_text, call_usage = call_api(
+            provider,
+            api_key,
+            model,
+            max_tokens,
+            system_prompt,
+            agents_content,
+            content,
+            name,
+            RETRY_NOTE,
+            verbose,
+            timeout,
+        )
+        usage.add(call_usage)
+        section = process_review_text(review_text, content, label)
+    return section
+
+
 def get_last_message_id(patch_content: str) -> str | None:
     """Extract Message-ID from the last patch in an mbox."""
     msg_ids = re.findall(
@@ -772,10 +1025,23 @@ def main() -> None:
     Use --show-tokens (or -v/--verbose) to print a token usage summary
     on stderr after the run. Off by default.
 
+Review Integrity:
+    The model must return structured JSON findings; text/markdown/html are
+    rendered locally from the verified findings. Each error/warning must
+    quote an exact line from the patch as evidence; findings whose evidence
+    is not present in the patch (e.g. review of a stale revision) are
+    reported as unverified and do not affect the error count. Every output
+    carries the `git patch-id --stable` of the reviewed content and a final
+    "X-AI-Review: ..." verdict line for CI to parse.
+
+Testing:
+    %(prog)s --replay saved-response.txt patch.patch   # no API call
+
 Exit Codes:
     0 - Clean review (no errors or warnings)
     1 - Operational failure (missing API key, file not found, etc.)
-    2 - Review found warnings (no errors)
+    2 - Review found warnings, unverified findings, or the model violated
+        the output contract (no errors)
     3 - Review found errors
         """,
     )
@@ -840,6 +1106,12 @@ def main() -> None:
         metavar="SECONDS",
         help="API request timeout in seconds (default: 300)",
     )
+    parser.add_argument(
+        "--replay",
+        metavar="FILE",
+        help="Testing aid: process a saved model response instead of "
+        "calling the API (reviews the patch file as a single unit)",
+    )
 
     # Date and release options
     parser.add_argument(
@@ -930,9 +1202,9 @@ def main() -> None:
     config = PROVIDERS[args.provider]
     model = args.model or config["default_model"]
 
-    # Get API key
-    api_key = os.environ.get(config["env_var"])
-    if not api_key:
+    # Get API key (not needed when replaying a saved response)
+    api_key = os.environ.get(config["env_var"], "")
+    if not api_key and not args.replay:
         error(f"{config['env_var']} environment variable not set")
 
     # Validate files
@@ -1000,9 +1272,11 @@ def main() -> None:
                 file=sys.stderr,
             )
 
+    # Reviewed sections accumulate here in all modes
+    sections: list[ReviewSection] = []
+
     # Handle --split-patches mode
-    review_text = ""
-    if args.split_patches:
+    if args.split_patches and not args.replay:
         patches = split_mbox_patches(patch_content)
         total_patches = len(patches)
 
@@ -1034,37 +1308,32 @@ def main() -> None:
                 )
 
             # Review each patch separately
-            all_reviews = []
             for i, patch in enumerate(patches, patch_start or 1):
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
+                sections.append(
+                    reviewed_section(
+                        args.provider,
+                        api_key,
+                        model,
+                        args.tokens,
+                        system_prompt,
+                        agents_content,
+                        patch,
+                        f"{patch_name} ({patch_label})",
+                        patch_label,
+                        args.verbose,
+                        args.timeout,
+                        total_usage,
+                    )
                 )
-                total_usage.add(call_usage)
-                all_reviews.append((patch_label, review_text))
-
-            # Combine reviews
-            review_text = format_combined_reviews(
-                all_reviews, args.output_format, patch_name
-            )
 
             # Skip the normal API call
             estimated_tokens = 0  # Bypass size check since we've already processed
 
-    # Check if content is too large
-    is_large = estimated_tokens > max_input_tokens
+    # Check if content is too large (replay skips API size limits)
+    is_large = estimated_tokens > max_input_tokens and not args.replay
 
     if is_large:
         print(
@@ -1102,33 +1371,28 @@ def main() -> None:
             patch_content, _ = truncate_content(patch_content, max_input_tokens)
         elif args.large_file == "chunk":
             print("Processing in chunks...", file=sys.stderr)
-            all_reviews = []
             for chunk, chunk_num, total_chunks in chunk_content(
                 patch_content, max_input_tokens
             ):
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
+                sections.append(
+                    reviewed_section(
+                        args.provider,
+                        api_key,
+                        model,
+                        args.tokens,
+                        system_prompt,
+                        agents_content,
+                        chunk,
+                        f"{patch_name} ({chunk_label})",
+                        chunk_label,
+                        args.verbose,
+                        args.timeout,
+                        total_usage,
+                    )
                 )
-                total_usage.add(call_usage)
-                all_reviews.append((chunk_label, review_text))
-
-            # Combine chunk reviews
-            review_text = format_combined_reviews(
-                all_reviews, args.output_format, patch_name
-            )
 
             # Skip the normal single API call below
             estimated_tokens = 0
@@ -1160,37 +1424,45 @@ def main() -> None:
             print(f"From: {from_addr}", file=sys.stderr)
         print("===============", file=sys.stderr)
 
-    # Call API (unless already processed via chunks/split)
-    if estimated_tokens > 0:  # Not already processed
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
+    # Review the whole file (unless already processed via chunks/split)
+    if args.replay:
+        replay_path = Path(args.replay)
+        if not replay_path.exists():
+            error(f"Replay file not found: {args.replay}")
+        review_text = replay_path.read_text(encoding="utf-8", errors="replace")
+        sections = [process_review_text(review_text, patch_content, patch_name)]
+    elif not sections:
+        sections.append(
+            reviewed_section(
+                args.provider,
+                api_key,
+                model,
+                args.tokens,
+                system_prompt,
+                agents_content,
+                patch_content,
+                patch_name,
+                patch_name,
+                args.verbose,
+                args.timeout,
+                total_usage,
+            )
         )
-        total_usage.add(call_usage)
 
-    if not review_text:
+    if not sections:
         error(f"No response received from {args.provider}")
 
+    # Verify identity of the reviewed content and derive the verdict
+    patch_ids = get_patch_ids(patch_content)
+    counts = section_counts(sections)
+    trailer = summary_trailer(counts, patch_ids)
+    review_body = render_sections(sections, args.output_format)
+
     # Format output based on requested format
     provider_name = config["name"]
+    patch_id_label = ",".join(pid[:16] for pid in patch_ids) or "unknown"
 
     if args.output_format == "json":
-        # For JSON, try to parse and add metadata
-        try:
-            review_data = json.loads(review_text)
-        except json.JSONDecodeError:
-            # If AI didn't return valid JSON, wrap the text
-            review_data = {"raw_review": review_text}
-
         usage_data = {
             "api_calls": total_usage.api_calls,
             "input_tokens": total_usage.input_tokens,
@@ -1205,19 +1477,29 @@ def main() -> None:
         output_data = {
             "metadata": {
                 "patch_file": patch_name,
+                "patch_ids": patch_ids,
                 "provider": args.provider,
                 "provider_name": provider_name,
                 "model": model,
                 "review_date": review_date,
                 "target_release": args.release,
                 "is_lts": is_lts_release(args.release) if args.release else False,
+                "counts": counts,
                 "token_usage": usage_data,
             },
-            "review": review_data,
+            "sections": [
+                {
+                    "label": sec.label,
+                    "contract_violation": sec.contract_violation,
+                    "review": sec.data,
+                    "unverified_findings": sec.unverified,
+                    **({"raw_response": sec.raw} if sec.raw else {}),
+                }
+                for sec in sections
+            ],
         }
         output_text = json.dumps(output_data, indent=2)
     elif args.output_format == "html":
-        # Wrap HTML content with header
         release_info = ""
         if args.release:
             lts_badge = " (LTS)" if is_lts_release(args.release) else ""
@@ -1226,8 +1508,9 @@ def main() -> None:
 <!-- Reviewed using {provider_name} ({model}) on {review_date} -->
 <div class="patch-review">
 <h1>Patch Review: {patch_name}</h1>
-<p class="review-meta">Reviewed by {provider_name} ({model}) on {review_date}{release_info}</p>
-{review_text}
+<p class="review-meta">Reviewed by {provider_name} ({model}) on {review_date}{release_info}<br>Patch-Id: {patch_id_label}</p>
+{review_body}
+<p class="review-verdict">{escape(trailer)}</p>
 </div>
 """
     elif args.output_format == "markdown":
@@ -1238,8 +1521,11 @@ def main() -> None:
         output_text = f"""# Patch Review: {patch_name}
 
 *Reviewed by {provider_name} ({model}) on {review_date}*
+*Patch-Id: {patch_id_label}*
 {release_info}
-{review_text}
+{review_body}
+
+{trailer}
 """
     else:  # text
         release_info = ""
@@ -1248,8 +1534,10 @@ def main() -> None:
             release_info = f"Target release: {args.release}{lts_badge}\n"
         output_text = f"=== Patch Review: {patch_name} (via {provider_name}) ===\n"
         output_text += f"Review date: {review_date}\n"
+        output_text += f"Patch-Id: {patch_id_label}\n"
         output_text += release_info
-        output_text += "\n" + review_text
+        output_text += "\n" + review_body
+        output_text += "\n\n" + trailer + "\n"
 
     # Write output
     if args.output:
@@ -1293,12 +1581,15 @@ def main() -> None:
 
         email_body = f"""AI-generated review of {patch_name}
 Reviewed using {provider_name} ({model}) on {review_date}
+Patch-Id: {patch_id_label}
 {release_info}
 This is an automated review. Please verify all suggestions.
 
 ---
 
-{review_text}
+{render_sections(sections, "text")}
+
+{trailer}
 """
 
         if args.verbose:
@@ -1322,8 +1613,8 @@ def main() -> None:
             print("", file=sys.stderr)
             print(f"Review sent to: {', '.join(args.to_addrs)}", file=sys.stderr)
 
-    # Exit with code based on review severity
-    sys.exit(classify_review(review_text, args.output_format))
+    # Exit with code based on verified review severity
+    sys.exit(classify_review(counts))
 
 
 if __name__ == "__main__":
-- 
2.53.0


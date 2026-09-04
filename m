Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC72DC79F80
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 16:25:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B90B542DD1;
	Fri,  4 Sep 2026 18:25:10 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 71E1642DC1
 for <dev@dpdk.org>; Fri,  4 Sep 2026 18:25:09 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cc1bc88a20eso1587577a12.3
 for <dev@dpdk.org>; Fri, 04 Sep 2026 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788539108;
 x=1789143908; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tx5JZr3AD+Q0BkyVVkzQO/uWfK8SDScH1MNhoYB03ho=;
 b=sKRPW5OZ8PakGdM3OcTzFs8Hgu7Yk2U+l1igLU4gfrUCPYdqKGgbawMEf/WE3++SrA
 azfbr6QqkrgLSnZ5ivQkvfDoAa3bHu+Q0hPzpUSw0wfxWksZceMbQPh9czYwdwmwD9nX
 uv/cJGWn/3YLW1svI9ZuYcAoxM8O9jFqjx75wDI2C53zcl6E1lNAVmYQ73/djDLGvjF3
 xkZrsg5LEJP4RxbI2ZV+vnoccYMYnOSzDkL1ci0frF/4l0KSM1ayBtF6G3kX2HULzoYq
 Jcdrwdh/R93869ZimQjhPOdB60pGpPYiTQV6WeRSeuWymPVYrF0HwajiXav1GLhyfLUp
 IErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788539108; x=1789143908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tx5JZr3AD+Q0BkyVVkzQO/uWfK8SDScH1MNhoYB03ho=;
 b=oC4Etuyus8/P28GjQ5BeSYMa/ujm/EK9hyCcJnWoBKIbLBF9MHPICVUg/hot+qFRqj
 YbQ0iRrzySg7aAqRv+jp+vUyo4qMPEdoPFhV7AQ7GLmoXWfRoaj2rkNEbtm1ivP18wyE
 khDZBMYo7HolS8XYbLQnabHsM6ew/Dby1SazSKFdG9k0DWDaCC3xFPHPQQV3oTq4D9VO
 Br/rSYnHl0LmY6+L1JWIFnnobWMb1h1H+0Ba+f+LJ/CffhLvbAnd51+5Jv1p4WqACz4b
 +80DmUUUQVEIw/18Cqsz7PiPM36sF6oxbkxs3tk9l2+BT/aBq0tGFqsPy/E15JJeGcTz
 0m2Q==
X-Gm-Message-State: AFuF++lRRoA7ldkpD3h49yP36Y7w4PYFyxebkh/3aeKUs9d2bSZP85vj
 dzpfpWnL9cutaU4hze66fEfdRtLBDTDt6y3rUbAG6TfCLhX65tkl1qcyH6H7cdSuBsa2UMjv43L
 OYF28
X-Gm-Gg: AYBFou3mHQTn0h89k8aHZpeJoxwpAo/M8LVjCySaODszbm8sj8U6my1ye85w8KU7pZ8
 bBTX2H8697HAR5DWtypdTAVTe0zSpDQctuMt+r0dhWYb6cRIPPa2CtQiXdU/k7c+E9RUB/le4Gr
 EFeaqTPQuI82fnSMUkpwGIiu1zhnG+rl6xlqzZ5NGGOJmt3c9mIi6VJ1igrSGW+VYYQOAKYf4GO
 eRAuyUM7l4HX6md1q33POXALBTDK3uSOcm05fT72u5HErxdgamVVD5aRSD5ODK43gE0MYOu8tgG
 LsDkRQ6XjXVX0AChb1HxFHhkbE23vu4WXvfGaGpH0qktL5A4g/JZTu/jbku2Bqqd9eROmO6L2K5
 Ykhc9UaPr1XdwGtvtNW6RY3VPFoKtjz9U+mmbij0BwG4fBhwmXqAC5W8lpmiJs0Aiugdzvulaph
 v8A5TqF7boiJw4Pz3HG5ux6RXrdjmCz1vgRYS6UZfaDQote9d6rpIThGjJ4FOgurxpeGYDfUCZL
 Rb31W21bIB607hFgzuosd+KAsM=
X-Received: by 2002:a05:6a20:cfa8:b0:3d0:7a2e:f827 with SMTP id
 adf61e73a8af0-3da3a0aaa67mr9609823637.16.1788539108331; 
 Fri, 04 Sep 2026 09:25:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8615203e041sm1405772b3a.17.2026.09.04.09.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 09:25:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>
Subject: [PATCH v2 2/2] devtools/ai/review-patch: reduce spurious warnings
Date: Fri,  4 Sep 2026 09:23:08 -0700
Message-ID: <20260904162454.218213-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904162454.218213-1-stephen@networkplumber.org>
References: <20260829171822.305500-1-stephen@networkplumber.org>
 <20260904162454.218213-1-stephen@networkplumber.org>
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

Improve the logic for reporting warnings and errors to
avoid flagging good patches as suspicious.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/ai/review-patch.py | 232 +++++++++++++++++++++++++++++-------
 1 file changed, 186 insertions(+), 46 deletions(-)

diff --git a/devtools/ai/review-patch.py b/devtools/ai/review-patch.py
index 5f8d9ed772..9b5b36f40d 100755
--- a/devtools/ai/review-patch.py
+++ b/devtools/ai/review-patch.py
@@ -19,7 +19,6 @@
 from email.message import EmailMessage
 from pathlib import Path
 from typing import Any, Iterator
-from enum import Flag, auto
 
 from _common import (
     PROVIDERS,
@@ -69,19 +68,31 @@
 - Be conservative: reject changes that aren't clearly bug fixes"""
 
 FORMAT_INSTRUCTIONS = {
-    "text": """Provide your review in plain text format.""",
+    "text": """Provide your review in plain text format.
+
+End the review with a single final line, exactly:
+Review-Result: CLEAN|WARNING|ERROR
+CLEAN means no Errors and no Warnings. This line is parsed by CI.""",
     "markdown": """Provide your review in Markdown format with:
 - Headers (##) for each severity level (Errors, Warnings, Info)
 - Bullet points for individual issues
 - Code blocks (```) for code references
-- Bold (**) for emphasis on key points""",
+- Bold (**) for emphasis on key points
+
+End the review with a single final line, exactly:
+Review-Result: CLEAN|WARNING|ERROR
+CLEAN means no Errors and no Warnings. This line is parsed by CI.""",
     "html": """Provide your review in HTML format with:
 - <h2> tags for each severity level (Errors, Warnings, Info)
 - <ul>/<li> for individual issues
 - <pre><code> for code references
 - <strong> for emphasis on key points
 - Use appropriate semantic HTML tags
-- Do NOT include <html>, <head>, or <body> tags - just the content""",
+- Do NOT include <html>, <head>, or <body> tags - just the content
+
+End the review with a single final line, exactly:
+Review-Result: CLEAN|WARNING|ERROR
+CLEAN means no Errors and no Warnings. This line is parsed by CI.""",
     "json": """Provide your review in JSON format with this structure:
 {
   "summary": "Brief one-line summary of the review",
@@ -122,10 +133,134 @@
 EXIT_ERRORS = 3
 
 
-class ReviewParseState(Flag):
-    NORMAL = auto()
-    IN_ERROR = auto()
-    IN_WARNING = auto()
+# Explicit machine-readable verdict; authoritative when present.
+# Quoted lines ('>') are excluded: a patch that adds a Review-Result line to a
+# document or test fixture must not be able to dictate its own verdict.
+_RESULT_RE = re.compile(
+    r"^[\s*#-]*review-result:\s*[*`\s]*(clean|warning|error)s?\b", re.MULTILINE
+)
+_RESULT_EXIT = {"clean": EXIT_CLEAN, "warning": EXIT_WARNINGS, "error": EXIT_ERRORS}
+
+# A severity section header: the whole line is the word plus decoration.
+#   "## Errors"  "**Warnings**"  "<h2>Errors</h2>"  "ERRORS:"  "Error (must fix):"
+_HEADER_RE = re.compile(
+    r"^(?:#{1,6}\s*)?(?:<h[1-6]>\s*)?[*_`]{0,2}"
+    r"(error|warning)s?"
+    r"[*_`]{0,2}\s*(?:\((?:must|should) fix\))?\s*:?\s*(?:</h[1-6]>)?$"
+)
+
+# An inline finding marker: "Error: foo", "- **Warning** - bar".
+# The remainder is captured so that "Errors: none" is recognised as filler
+# rather than counted as a finding.
+_INLINE_RE = re.compile(
+    r"^[-*\s]*[*_`]{0,2}(error|warning)s?[*_`]{0,2}\s*[:\u2013-]\s*(\S.*)$"
+)
+
+# Text meaning "this section is empty". Deliberately a closed vocabulary:
+# anything else under a severity header counts as a finding.
+_EMPTY_RE = re.compile(
+    r"^[-*\s]*[*_`(\[]*\s*"
+    r"(?:none|nil|n/?a"
+    r"|no\s+(?:errors?|warnings?|issues?|problems?|findings?|concerns?"
+    r"|correctness\s+bugs?|changes?\s+(?:required|needed)))"
+    r"[\w\s]{0,24}[.!]?\s*[*_`)\]]*$"
+)
+
+_RULE_CHARS = set("-=_*# \t")
+
+# Code block delimiters. The markdown instructions ask for code references, so a
+# quoted compiler diagnostic or RTE_LOG(WARNING, ...) must not read as a finding.
+_FENCE_RE = re.compile(r"^(?:```|~~~)")
+
+
+def _asserted_lines(review_text: str) -> Iterator[str]:
+    """Yield the lines a review asserts, dropping the ones it quotes.
+
+    Code fences and '>' context carry text the review is talking *about*
+    rather than claiming, so neither may open a section or supply a verdict.
+    Indentation is left to the caller: an indented line may be a code sample,
+    but it may equally be a finding nested under a severity header.
+    """
+    in_fence = False
+
+    for line in review_text.splitlines():
+        if _FENCE_RE.match(line.strip()):
+            in_fence = not in_fence
+            continue
+        if in_fence:
+            continue
+        if line.lstrip().startswith(">"):
+            continue
+        yield line
+
+
+def strip_quoted_blocks(review_text: str) -> str:
+    """Return the text that may supply a verdict line.
+
+    Indented blocks are dropped here: a review that shows an example
+    Review-Result line must not be able to dictate its own verdict.
+    """
+    return "\n".join(
+        line
+        for line in _asserted_lines(review_text)
+        if not line.startswith("    ") and not line.startswith("\t")
+    )
+
+
+def scan_review_prose(review_text: str) -> tuple[bool, bool]:
+    """Scan free-form review text for findings.
+
+    A severity header only counts if the section under it holds something
+    other than "none". Returns (has_errors, has_warnings).
+    """
+    has_errors = False
+    has_warnings = False
+    section: str | None = None
+
+    for line in _asserted_lines(review_text):
+        stripped = line.strip().lower()
+
+        # Blank lines, horizontal rules and patch context are inert:
+        # they neither open nor close a section.
+        if (
+            not stripped
+            or set(stripped) <= _RULE_CHARS
+            or stripped.startswith("diff --git")
+        ):
+            continue
+
+        # An indented line may be an unfenced code sample, so it cannot open
+        # a section or stand alone as a finding.  Under an open header it is
+        # still content: a bullet nested under "## Errors" is a finding.
+        if not line.startswith("    ") and not line.startswith("\t"):
+            match = _INLINE_RE.match(stripped)
+            if match:
+                if not _EMPTY_RE.match(match.group(2)):
+                    if match.group(1) == "error":
+                        has_errors = True
+                    else:
+                        has_warnings = True
+                section = None
+                continue
+
+            match = _HEADER_RE.match(stripped)
+            if match:
+                section = match.group(1)
+                continue
+
+        if section is None:
+            continue
+
+        # Strip HTML tags so "<p>None identified.</p>" reads as filler.
+        text = re.sub(r"<[^>]+>", " ", stripped).strip()
+        if not _EMPTY_RE.match(text):
+            if section == "error":
+                has_errors = True
+            else:
+                has_warnings = True
+        section = None
+
+    return has_errors, has_warnings
 
 
 def classify_review(review_text: str, output_format: str) -> int:
@@ -136,12 +271,37 @@ def classify_review(review_text: str, output_format: str) -> int:
         2 - warnings found (no errors)
         3 - errors found
     """
+    # 1. Explicit verdict line wins. Combined reviews carry one per section;
+    #    the worst result decides. Quoted material cannot supply one.
+    verdicts = _RESULT_RE.findall(strip_quoted_blocks(review_text).lower())
+    if verdicts:
+        return max(_RESULT_EXIT[v] for v in verdicts)
+
     has_errors = False
     has_warnings = False
 
+    # 2. Structured JSON.
     if output_format == "json":
         try:
             data = json.loads(review_text)
+            # Combined reviews nest one sub-review per patch or chunk, each
+            # still in its own format. Classify each and keep the worst.
+            sections = data.get("sections")
+            if isinstance(sections, list):
+                worst = EXIT_CLEAN
+                classified = False
+                for entry in sections:
+                    if not isinstance(entry, dict):
+                        continue
+                    review = entry.get("review")
+                    if isinstance(review, str):
+                        classified = True
+                        worst = max(worst, classify_review(review, output_format))
+                # An empty or unrecognised "sections" value is not a verdict;
+                # fall through to the top-level keys rather than report clean.
+                if classified:
+                    return worst
+
             if data.get("errors"):
                 has_errors = True
             if data.get("warnings"):
@@ -154,44 +314,9 @@ def classify_review(review_text: str, output_format: str) -> int:
         except (json.JSONDecodeError, AttributeError):
             pass  # Fall through to text scanning
 
+    # 3. Fallback: scan prose.
     if not has_errors and not has_warnings:
-        # Matches against error or warning section headers
-        rgx_header_match: str = r"(#+\s)?(\*+)?(<h[1-3]>)?{err_or_warn}"
-        # Matches against observed filler text
-        rgx_filler_match: str = r"(none(.)?$|\(must fix\)$|$)"
-        curr_state: ReviewParseState = ReviewParseState.NORMAL
-
-        curr_line: str
-        for curr_line in review_text.splitlines():
-            stripped: str = curr_line.strip().lower()
-
-            if (
-                stripped.startswith(">")
-                or stripped.startswith("diff --git")
-                or stripped == ""
-            ):
-                continue
-
-            elif re.match(rgx_header_match.format(err_or_warn="error"), stripped):
-                curr_state = ReviewParseState.IN_ERROR
-
-            elif re.match(rgx_header_match.format(err_or_warn="warning"), stripped):
-                curr_state = ReviewParseState.IN_WARNING
-
-            elif curr_state == ReviewParseState.IN_ERROR and not re.match(
-                rgx_filler_match, stripped
-            ):
-                curr_state = ReviewParseState.NORMAL
-                has_errors = True
-
-            elif curr_state == ReviewParseState.IN_WARNING and not re.match(
-                rgx_filler_match, stripped
-            ):
-                curr_state = ReviewParseState.NORMAL
-                has_warnings = True
-
-            else:
-                curr_state = ReviewParseState.NORMAL
+        has_errors, has_warnings = scan_review_prose(review_text)
 
     if has_errors:
         return EXIT_ERRORS
@@ -1164,7 +1289,10 @@ def main() -> None:
     if args.verbose:
         print("=== Request ===", file=sys.stderr)
         print(f"Provider: {args.provider}", file=sys.stderr)
-        print(f"Auth method: {'vertex' if auth == 'vertex' else 'direct'}", file=sys.stderr)
+        print(
+            f"Auth method: {'vertex' if auth == 'vertex' else 'direct'}",
+            file=sys.stderr,
+        )
         print(f"Model: {model}", file=sys.stderr)
         print(f"Review date: {review_date}", file=sys.stderr)
         if args.release:
@@ -1351,6 +1479,18 @@ def main() -> None:
             print("", file=sys.stderr)
             print(f"Review sent to: {', '.join(args.to_addrs)}", file=sys.stderr)
 
+    # The format instructions require a final Review-Result line.  Without it
+    # the severity below is inferred from prose, which is a guess -- and the
+    # usual cause is a response truncated before the review was finished.
+    if args.output_format != "json" and not _RESULT_RE.search(
+        strip_quoted_blocks(review_text).lower()
+    ):
+        print(
+            "warning: review has no Review-Result line, "
+            "severity inferred from prose (response may be truncated)",
+            file=sys.stderr,
+        )
+
     # Exit with code based on review severity
     sys.exit(classify_review(review_text, args.output_format))
 
-- 
2.53.0


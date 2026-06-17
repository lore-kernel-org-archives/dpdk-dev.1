Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CDFCD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 17:44:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9ADC840276;
	Wed, 17 Jun 2026 19:44:49 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id DF63740268
 for <dev@dpdk.org>; Wed, 17 Jun 2026 19:44:47 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-91574384cc2so8969685a.2
 for <dev@dpdk.org>; Wed, 17 Jun 2026 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1781718287; x=1782323087; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvRNe0xV1UJs8HNAbU4sfVBg+jku4SpUyQZsVip/Z2U=;
 b=fB66pD23ewm2sHTILwgK0f10V1MctGaVQ6rhREp8EvW+/ZmJjAF19ZOpmDw5ukndRy
 FLXWLS2wwTllDxShx5JiVUFOL6AQ0wEFxqi2mgRdpLvYkw8EXpMJ8s+apRNFGmyN71BU
 aAm1biYWdzp0JJA8WeEFnmKx5H9YcdNKA6E/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781718287; x=1782323087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RvRNe0xV1UJs8HNAbU4sfVBg+jku4SpUyQZsVip/Z2U=;
 b=s8QM+jNkG49VY4Wy/4p5vHZbnvScKCXS48LID7fPofjyA2sSoD4TUdhfSvXkKaTRR8
 WBuSbyn4lY/2nW9GHShVqKG7XBEE+DS0OzM8gVfY9mqN3hdzVM31tL/l0EiZo2PQ+Lh7
 pcuqpYBTJriyqsS1Y9yHfnDodlIWpRfhO2EdvhzRjt5Het/DZvlTSBwL292vBXsAIguR
 QCZ1q3IK92XvwbEZU3zAgN/+8qmo5nsJjgoE/axuPoAHARkVhGUCmU15mN3b+QVUFlaZ
 Rq5bA1WOZnSkbv/Cp1gzHEX3tysO5ThWeeC+dmPwbXs0BOhmGUDzPMI3Sf+qCd3m9GAm
 VxIg==
X-Gm-Message-State: AOJu0Yybckf8MTbDQM5p2BMmZmlDfyoox6b+Bf3dROh/F/o8Z5Kd4mXU
 KDQHqvIWNFHi78lmTBK2xhnoHwHyOjWKpWVRnD4vqTC9nshZYqoYU6KKfVslban0ll64lC1oazS
 ftYmxbcoNCgFvCVWlOMvHOI48VmSVfoHhNuD8WlEbX92zuxJY9PkOlT2l0dmoL/GB2Oax/cpr/R
 NhPpqbNf5tub55gr/gIMw1Zl9zlw==
X-Gm-Gg: Acq92OGqGXJMxLFqi1Y62fHfuCkajjs7oQLhvKbcwI1aWDjiOjb29ZAyoa5btJHgPNx
 RqvfwZygYPNSqyUTivDTInmvFbLa3f50BshoGOT32A6ggsy0lrevdUzNo3eW2EZoQZoi9YJDW3J
 8FEBWatetWJtvPDF6Cwke2SZ406/LherT4a9nyWlYs/B/OOx+k+c3hy3OiIz9GFxVuPWwJHfDMp
 yJNWd0+LQ9VHRdaSocFoZ+nuFNZCsOhe4mBFAsF1Ko19/4tnjUNuQfz0ERM4st7ojLfwj5tzGMH
 jpemst0/jLDvDcowGtHRRGQ76Ih3UhlUeT2m2M8DpWNbn/tm6Rgg+uXM1azDVohRGKMU2tVOEh0
 sGB8beqvjvbxnxXjaqQDOtMTTa4hNAApcc4KaMYtL2wEd3DB+9G5/WoHGNajUhTMJTOhbtKMNPw
 Y52fM42pwjRVoM5vNQz62tnionXk+wSzGnjeuCYyq2s/ny7t794ns=
X-Received: by 2002:a05:620a:698c:b0:915:d5cd:8ce5 with SMTP id
 af79cd13be357-91d8952d7a1mr835634185a.20.1781718287116; 
 Wed, 17 Jun 2026 10:44:47 -0700 (PDT)
Received: from d122153.iol.unh.edu ([2606:4100:3880:1220:e309:5f72:1c4b:9e64])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91619ed8aa6sm1792702685a.2.2026.06.17.10.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 10:44:46 -0700 (PDT)
From: Matthew Gee <mgee@iol.unh.edu>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, aconole@redhat.com, lylavoie@iol.unh.edu,
 Matthew Gee <mgee@iol.unh.edu>
Subject: [PATCH v3] tools: AI review handle empty Error sections
Date: Wed, 17 Jun 2026 13:44:02 -0400
Message-ID: <20260617174402.2123568-1-mgee@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612190225.1016275-1-mgee@iol.unh.edu>
References: <20260612190225.1016275-1-mgee@iol.unh.edu>
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

This patch fixes a bug where review-patch.py would detect and report an
error or warning only based off of the occurrence of the headers of the
error and warning sections. This led to consistent false positives as
often AI reviewers will create the header but put "none" or similar
filler text within the following body.

This patch updates the code in order to check if the AI review has a
body with error or warnings to fix and not just filler text. This is
done by keeping track of whether the for loop parser is within an error
or warning section; analyzing the first non-whitespace line within the
section. If the first non-whitespace line matches known filler then the
section can be ignored.  It has been observed that if the AI includes
filler then there is no actual concern.

These changes were tested against 10+ markdown AI review outputs with
several variations in formatting and filler text. The changes caught
error or warning sections with actual concerns and successfully ignored
sections containing only filler.

Signed-off-by: Matthew Gee <mgee@iol.unh.edu>
---
 devtools/ai/review-patch.py | 48 +++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/devtools/ai/review-patch.py b/devtools/ai/review-patch.py
index 52601ac156..53ae7e6a4f 100755
--- a/devtools/ai/review-patch.py
+++ b/devtools/ai/review-patch.py
@@ -19,6 +19,7 @@
 from email.message import EmailMessage
 from pathlib import Path
 from typing import Any, Iterator
+from enum import Flag, auto
 
 from _common import (
     PROVIDERS,
@@ -120,6 +121,12 @@
 EXIT_ERRORS = 3
 
 
+class ReviewParseState(Flag):
+    NORMAL = auto()
+    IN_ERROR = auto()
+    IN_WARNING = auto()
+
+
 def classify_review(review_text: str, output_format: str) -> int:
     """Classify review result and return appropriate exit code.
 
@@ -147,22 +154,43 @@ def classify_review(review_text: str, output_format: str) -> int:
             pass  # Fall through to text scanning
 
     if not has_errors and not has_warnings:
-        # Scan review text for severity indicators.
-        # Match section headers and inline markers across text/markdown/html.
-        for line in review_text.splitlines():
-            stripped = line.strip().lower()
-            # Skip quoted patch context lines
-            if stripped.startswith(">") or stripped.startswith("diff --git"):
+        # Matches against error or warning section headers
+        rgx_header_match: str = r"(#+\s)?(\*+)?(<h[1-3]>)?{err_or_warn}"
+        # Matches against observed filler text
+        rgx_filler_match: str = r"(none(.)?$|\(must fix\)$|$)"
+
+        curr_line: str
+        for curr_line in review_text.splitlines():
+            stripped: str = curr_line.strip().lower()
+
+            if (
+                stripped.startswith(">")
+                or stripped.startswith("diff --git")
+                or stripped == ""
+            ):
                 continue
-            if re.match(r"^(#{1,3}\s+)?(\*{0,2})error", stripped) or re.match(
-                r"^<h[1-3]>\s*error", stripped
+
+            elif re.match(rgx_header_match.format(err_or_warn="error"), stripped):
+                curr_state = ReviewParseState.IN_ERROR
+
+            elif re.match(rgx_header_match.format(err_or_warn="warning"), stripped):
+                curr_state = ReviewParseState.IN_WARNING
+
+            elif curr_state == ReviewParseState.IN_ERROR and not re.match(
+                rgx_filler_match, stripped
             ):
+                curr_state = ReviewParseState.NORMAL
                 has_errors = True
-            elif re.match(r"^(#{1,3}\s+)?(\*{0,2})warning", stripped) or re.match(
-                r"^<h[1-3]>\s*warning", stripped
+
+            elif curr_state == ReviewParseState.IN_WARNING and not re.match(
+                rgx_filler_match, stripped
             ):
+                curr_state = ReviewParseState.NORMAL
                 has_warnings = True
 
+            else:
+                curr_state = ReviewParseState.NORMAL
+
     if has_errors:
         return EXIT_ERRORS
     if has_warnings:
-- 
2.54.0


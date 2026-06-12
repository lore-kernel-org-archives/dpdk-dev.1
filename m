Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A41CD98D2
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 19:02:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBE2043267;
	Fri, 12 Jun 2026 21:02:44 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id 3B1F940278
 for <dev@dpdk.org>; Fri, 12 Jun 2026 21:02:43 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-5177b9a02bdso15424081cf.1
 for <dev@dpdk.org>; Fri, 12 Jun 2026 12:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1781290962; x=1781895762; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xGQTcznqPdmvlke5ZtWj3ggNMEMaMKomCQEqrhoxIp0=;
 b=feAKklvED7vPfKBNB78cUdRrB9HFFYsICkQCK3ZLqtIhEK+5IDM0n16P2F7uZRrZI8
 muvE8pZqpI7AisFF56sasJVsMB8gOSHNYVO+gcDtw7/6Fa7/TDCyVxGADbgX0axajZzY
 /KClG86bPHfK8RGta1dmhSQR8314ZcDlNmRJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781290962; x=1781895762;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGQTcznqPdmvlke5ZtWj3ggNMEMaMKomCQEqrhoxIp0=;
 b=lxC2QHmldTZkdmJ3kw6gdSNHkxJ4VP3i+cAwhQ2qo7GYorr9YC5KGMxQ5vEqYgTdSW
 kDGQ5bkBQpaLqCR9ItGo+UbxFUH75BUDh0087qEiZrNgzsptpG1PmiaIAvfzzIVy8kb8
 BhTdgqVAv1trQoCVIxys6YpzzCDMxYuplxATl2uCKtLG+hGr9iL/v+HX3Drt3jJa37R0
 YT9iBONthBFiPS9LX0aDJ9GuJBPpPPce5z4yRlj3O0eMDZPIU5oZ/EyIpvuubtGhpxyO
 7SWWvqfETfGJTi1USq3528tDp9Rgy5h8vr1fWRhpmcRxQAHLyYnYmL7DXVsXYR9DuEBi
 KNzw==
X-Gm-Message-State: AOJu0YwPCwnPAH+mDL+8zKTF2Oh/NkUmnvpaikbx3MgrdVgmmaw4qv8/
 XQOremEcAfEXRR4W2/GffAcbqH2VvpttARNINli24wS8mNa8GlMky/mfDNWNQGkqcYxwcZrZJNv
 i9r1OTkIcVJrlraQHCTNJc20sFBAvy3t/2jmFZ8LUqya9YkgJhygwl5Ov8bvHVzA/NNZvZ4dNWN
 kuoTKIK8gPajpJmZTe3hzFZzQWBw==
X-Gm-Gg: Acq92OHD5JtUfgXf6cCoWyoaaEspv84b9kw3HUMzwPCHxYeZVjcIXiLqOzpa4ULWfKj
 OAOmWGCwtM44MNYz7Fwc0fnRdCp/gV+Ohcaz7Ov0c0zE5LAstMRHlZwQJAZkxK6MdzOcTIS0LMa
 A/6Abg4sFDdsScTF/PjpEU36tb3ZLlkWE8irMGlD2XuVE9frvPYz0AHpg0bj7+PQD+CFMjz7aKO
 lW/aEDZV/+qn1dRWaOrfg5xAV7SixBMvs3m9P1T+aYOu8JgKxEIiPLFdvmX0QcI5ywYSfTo1LYF
 VUeHammOQPoEAKXtT3gXZM62ylWO4/Svf6k5jRKIJKXAVCHdEap0cefnvtYPr7Xr98MMbtJaPFy
 64rcGBSkq6FP7ByNeAPOaCRnv5RrstKoHgHT3KbhSQffO6jlUxvXBPP5W45fWDzV3JvrLOpqjrl
 tF5XeGlBBioIld5hf6DpTtqSpQv2o0CliaTlwjAi1xtlXn9jHQqRvMs7LQxEWBEg==
X-Received: by 2002:a05:622a:143:b0:509:44c3:5fe7 with SMTP id
 d75a77b69052e-519535e9887mr14325291cf.46.1781290962489; 
 Fri, 12 Jun 2026 12:02:42 -0700 (PDT)
Received: from d122153.iol.unh.edu ([2606:4100:3880:1220:e309:5f72:1c4b:9e64])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb61fb15sm29891031cf.5.2026.06.12.12.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 12:02:42 -0700 (PDT)
From: Matthew Gee <mgee@iol.unh.edu>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, aconole@redhat.com, lylavoie@iol.unh.edu,
 Matthew Gee <mgee@iol.unh.edu>
Subject: [PATCH v1] tools: AI review handle empty Error sections
Date: Fri, 12 Jun 2026 15:02:25 -0400
Message-ID: <20260612190225.1016275-1-mgee@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
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

Previous review-patch.py would detect and report and error or warning
based off of the occurrence of the headers of the error and warning
sections. This led to consistent false positives as often AI reviewers
will create the header but put "none" or similar filler text within
the following body.

This patch updates the code in order to check if the AI review has a
body with error or warnings to fix and not just filler text. This is
done by querying multiple lines at once and adjusting the regex to
filter out headers followed only by filler text or formatting in the
review.

These changes were tested against 10+ AI review outputs with several
variations in formatting and filler text in order to catch a good
variety of cases to make sure code reviews with actual errors or
warnings are caught and not missed.

Signed-off-by: Matthew Gee <mgee@iol.unh.edu>
---
 devtools/ai/review-patch.py | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/devtools/ai/review-patch.py b/devtools/ai/review-patch.py
index 52601ac156..b009368638 100755
--- a/devtools/ai/review-patch.py
+++ b/devtools/ai/review-patch.py
@@ -19,6 +19,7 @@
 from email.message import EmailMessage
 from pathlib import Path
 from typing import Any, Iterator
+from itertools import tee, islice, chain
 
 from _common import (
     PROVIDERS,
@@ -147,19 +148,37 @@ def classify_review(review_text: str, output_format: str) -> int:
             pass  # Fall through to text scanning
 
     if not has_errors and not has_warnings:
-        # Scan review text for severity indicators.
-        # Match section headers and inline markers across text/markdown/html.
-        for line in review_text.splitlines():
-            stripped = line.strip().lower()
+        # Matches against error or warning section headers
+        rgx_should_match: str = r"#+\s(\*+)?{err_or_warn}"
+        # Matches against headers followed only by filler text, formatting, or no additional text
+        rgx_should_not_match: str = r"#+\s(\*+)?{err_or_warn}(s?)(\*+)?(none(.)?$| \(must fix\)$|$)"
+        
+        curr_lines: iter[str]
+        next_lines: iter[str | None]
+        next_next_lines: iter[str | None]
+        curr_lines, next_lines, next_next_lines = tee(review_text.splitlines(), 3)
+        next_lines = chain(islice(next_lines, 1, None), [None])
+        next_next_lines = chain(islice(next_next_lines, 2, None), [None, None])
+        
+        curr_lines: str
+        next_lines: str | None
+        next_next_lines: str | None
+        for curr_line, next_line, next_next_line in zip(curr_lines, next_lines, next_next_lines):
+            stripped: str = curr_line.strip().lower() + str(
+                next_line or '').strip().lower() + str(next_next_line or '').strip().lower()
             # Skip quoted patch context lines
             if stripped.startswith(">") or stripped.startswith("diff --git"):
                 continue
-            if re.match(r"^(#{1,3}\s+)?(\*{0,2})error", stripped) or re.match(
-                r"^<h[1-3]>\s*error", stripped
+
+            elif re.match(rgx_should_match.format(err_or_warn='error'),
+                          stripped) and not re.match(
+                rgx_should_not_match.format(err_or_warn='error'), stripped
             ):
                 has_errors = True
-            elif re.match(r"^(#{1,3}\s+)?(\*{0,2})warning", stripped) or re.match(
-                r"^<h[1-3]>\s*warning", stripped
+
+            elif re.match(rgx_should_match.format(err_or_warn='warning'),
+                          stripped) and not re.match(
+                rgx_should_not_match.format(err_or_warn='warning'), stripped
             ):
                 has_warnings = True
 
-- 
2.54.0


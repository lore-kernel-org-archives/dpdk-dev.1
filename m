Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C1DCD98CF
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 19:08:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5510842E8D;
	Fri, 12 Jun 2026 21:08:39 +0200 (CEST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id 2270F40278
 for <dev@dpdk.org>; Fri, 12 Jun 2026 21:08:38 +0200 (CEST)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-8d18de80b29so17905566d6.1
 for <dev@dpdk.org>; Fri, 12 Jun 2026 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1781291317; x=1781896117; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mDBAbdHtKfHIR86EIDMwiPj7/FJi4Rhuob8Db99ek2U=;
 b=iuonoxj2Eb8HzAt71zy98p+we5U+bkcuRDvmkm4O2KvxUZGZXJmXvroSAPOYNfp80w
 yYV4MtcNv6YT94dojZ0LoJAsbwLFrlnluDNm5U6nWSQqMP6kraGqzmIpIhp0gd4tyGNm
 HQIcoVMcNox3HObSAPVL0NDgWhy8WObp+zzhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781291317; x=1781896117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mDBAbdHtKfHIR86EIDMwiPj7/FJi4Rhuob8Db99ek2U=;
 b=cdEUd+203hJ/q6IKA8L7oixMe3lxkakPOp5nPhndc44XxMxjDxax2vALUX8U5AZHkS
 6PXTZ/aX0gXhe+Wwpw0WI/H716q220kNepVdQtXaODJp/0oCf9hCEFHxTaO16w5atxJA
 TN6OrzTc/YHWxFpwYhxwJclg3LwjUX/iZNA2MD2u3pstYPEIe4sOpxeuBiVJnBiVbD+y
 ieO8CRj19fZ3fKwCpLx7+DBSKhS3txWexFoJZb3l/0BSTMMD7BBFxLDgquOgg/ZX7vtE
 Ay5kNM8VRQGS75PaV39gscxseLReBUc1YpOTymujSXmlfXGUiMJAMvUu9+U3wXSGmgc2
 gksw==
X-Gm-Message-State: AOJu0Yy5PzP8z0w2Wepoot+FTh6vCJRc8vP4qDoXHXc87oZZKSc5+P34
 ImSRqgnzg6XWnDGXAEo7qZ9W72Uu7ruBUGv3/ylKas34q1LB0ohVWBErn2eXLcreUWM746qHB1I
 Y+Xayo2WhSQC7vzCnbeJ3gWeI3leY1GK09aoyh//hSunpsD81TU6mBXJsk3I262eKygbVDQ5xUs
 eK8Bi9v4n6/3gagdcLJBuVTTsMZw==
X-Gm-Gg: Acq92OEkf+wcEQ6tueG4Q4IuMZmxaRpfCZEae9GPZknkOGo+1yOP9HSz4etkZYQAre/
 Jk9R8HRThcfWC/66lA7t2m+brFeVJX5flxMNnzyHJ0J1GnohtzzfYFEW8kia9M8zLDBZnR7XkNx
 zGDH/YkxeENSCLJAOkxHLbKsCyV+d783mB5E+JFqChiYcvUucGMwJ88kSt7QSd89Ir7MM+HNfL8
 VY67H1imLn82iO07aFFOeL62fWcPrI232lw4aNhgqaqyw36ug6r9df7JQlymfxbiwDZSWt0a/mc
 c1Z70WkGL0vhjhkhLQ4KcMNBO6C0ZdgLRnPqyFDD/jc9HTUkzL1tdhEQtNPEGeMth/1PT7v6Ykn
 u0D+5cHLqLwu5Li9mjlLTcNjYUHMPMl5DrwLslnGRmcrR4gVwwuB/X5sAVuqpPPOVFon9oHSrHQ
 OmTVKNxASftH3J+WJgBPImDjuNTKoLG7TYjYpABlKLmdAfvHN72UtIK7vSsy749g==
X-Received: by 2002:a05:6214:5085:b0:8d0:3950:aa0f with SMTP id
 6a1803df08f44-8d3166caa85mr67224376d6.22.1781291317110; 
 Fri, 12 Jun 2026 12:08:37 -0700 (PDT)
Received: from d122153.iol.unh.edu ([2606:4100:3880:1220:e309:5f72:1c4b:9e64])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d304b58edesm30573516d6.37.2026.06.12.12.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 12:08:36 -0700 (PDT)
From: Matthew Gee <mgee@iol.unh.edu>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, aconole@redhat.com, lylavoie@iol.unh.edu,
 Matthew Gee <mgee@iol.unh.edu>
Subject: [PATCH v2] tools: AI review handle empty Error sections
Date: Fri, 12 Jun 2026 15:08:07 -0400
Message-ID: <20260612190807.1020863-1-mgee@iol.unh.edu>
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
index 52601ac156..eb608566d2 100755
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


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF2BC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 16:13:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE0FC402A7;
	Mon, 13 Jul 2026 18:13:40 +0200 (CEST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id B5AD740041
 for <dev@dpdk.org>; Mon, 13 Jul 2026 18:13:39 +0200 (CEST)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-51c29b46382so21332301cf.3
 for <dev@dpdk.org>; Mon, 13 Jul 2026 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783959219; x=1784564019; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+xGbi1MV2xBef/ENJbdG/kGI68Tn+A9E3YRHkiKqCRs=;
 b=VU5TLIJmXjh5wMThRU8TgFSrt/JemX/ePfGFljwvMUgyab6lsUIx4sclJ/IRFU7gfS
 35NgL0QwNE1IHRpg9Os/3zRXh6TG5cTFqBhoDWPK0ZOWyOyLhwWquWFDUE7OBJ0q9gZ9
 j3YJ5mlmM4HeuyNxQo9eTzTulWyQWbN3Fdg+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783959219; x=1784564019;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+xGbi1MV2xBef/ENJbdG/kGI68Tn+A9E3YRHkiKqCRs=;
 b=bZKjXOnYTIpsZaNwvNTk45pZTG6zjXCvLV4EZU/s08DMr9kKdqaN9AXGLESytnfgRf
 em4V9BuEj4UjG0ti8E4dNzp3nx5B/okN3LErG0P3O5bpHe88Rij8xietlGf/NGkAeTCn
 zZ+CNy4WE+HeNgfW/RzvDLdNRLlPTOBZDJ+egbI+UOZMlRRbCsz0NLXCj6pXWtpWoD9x
 6/rg5ZE0evsFop+uVLZAMMZfaS4YVxqB90fgoK1e9ejDnl5JWFPBZsqMSvC/HiLYvxOG
 Hm5VPWZzkcecZBGyQOV/XSjxgx6P5kVPwHGEQ1QquqIkcTfq0I3rN7oizZ8nCnEg82jG
 sgRA==
X-Gm-Message-State: AOJu0YycLXmIqfQLmDen1lD0CbnXfmI5rseCqLB1228VxMiUu8OTpnhV
 tYyuC38dLLuLCj3SU557fCqwbEnY40S3KyLslrhZ+lOVdJnIpenHY6T5blr5Jokvdeot86AHjm8
 v+g0idFfnUVU/sfmCUO632fbdK153lAT9JVYiihsHoHzbOuB16YQYkQsGBrjKjyVParCudj1Wdo
 07+qCmCIdVeSA75fFueCqCaWI=
X-Gm-Gg: AfdE7cmWaouVdQ3bFTLzUZxyT8u9VzCDoz0iuILWQ6PVgsd8Pbxdk4TkA1OA2Yk0f6C
 XESd0DFqDWZZa4+BaGtN+mCIwC62AFimydnoewSmUq8JiiddDZ3Op3NUQGBkjBvuFEHBVuH5BH5
 rdQ/0iMx3LzrVQ8JtMbCLoj7A4jIRyHPPXo+ukvVWYMD6Wov92TQDTyEYv5bLY7ao/upOthTRVD
 9CwPZvE6qUC7NvPzhFL8unzoFXPGaFsKO3Rkdm1EgtkEXPyb40AWLH/SlGocpYULBlEQq0f/kYp
 /ick2J6+Le1wvLrpF1dyrKdMZckklnexnfJh1kyAsy6qHUn/yj2yXvGLlh9THIiY1jgsMcCTGkl
 jmbLW9q9S+vD5IZi/oLdvZ7v0AWfasGLOH/GogrtuNyT6Wrk1N+qlGGlqI80JxZBTtQBF84+/96
 ERpNBgSVrsQGzvtgXH7PAK4iZ8zQaDSIib2P9lEJ9aQSWyBMObfAM=
X-Received: by 2002:ac8:6f16:0:b0:516:dff5:68c4 with SMTP id
 d75a77b69052e-51cbf070fccmr100584971cf.7.1783959218815; 
 Mon, 13 Jul 2026 09:13:38 -0700 (PDT)
Received: from d122160.iol.unh.edu ([2606:4100:3880:1220:b8d9:e080:4404:1782])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caacaad78sm84069401cf.7.2026.07.13.09.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:13:38 -0700 (PDT)
From: Matthew Gee <mgee@iol.unh.edu>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, aconole@redhat.com, lylavoie@iol.unh.edu,
 Matthew Gee <mgee@iol.unh.edu>
Subject: [PATCH v1] tools: ai review fix uninitialized variable
Date: Mon, 13 Jul 2026 12:11:28 -0400
Message-ID: <20260713161128.2338643-1-mgee@iol.unh.edu>
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

There was a previously introduced bug where the curr_state variable in
the classify_review function would be potentially uninitialized. This
would cause the script to crash when the variable was used during the
analysis of the AI review text.

This patch fixes the bug by initializing the variable before it is used
during the parsing of the AI review text.

Fixes: 18b85df67daa ("devtools: fix AI review result classification")

Signed-off-by: Matthew Gee <mgee@iol.unh.edu>
---
 devtools/ai/review-patch.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/devtools/ai/review-patch.py b/devtools/ai/review-patch.py
index 3705ca8209..5f8d9ed772 100755
--- a/devtools/ai/review-patch.py
+++ b/devtools/ai/review-patch.py
@@ -159,6 +159,7 @@ def classify_review(review_text: str, output_format: str) -> int:
         rgx_header_match: str = r"(#+\s)?(\*+)?(<h[1-3]>)?{err_or_warn}"
         # Matches against observed filler text
         rgx_filler_match: str = r"(none(.)?$|\(must fix\)$|$)"
+        curr_state: ReviewParseState = ReviewParseState.NORMAL
 
         curr_line: str
         for curr_line in review_text.splitlines():
-- 
2.54.0


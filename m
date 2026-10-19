Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6D0606A319
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=a/VRJRlp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7496840659;
	Mon, 19 Oct 2026 22:23:02 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id DB7944021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 22:23:00 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-9179bfa9e9cso45076096d6.1
 for <dev@dpdk.org>; Mon, 19 Oct 2026 13:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792441380; x=1793046180; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nsUjpUkprb0De2ezeywh970D5KG1ZRyKocJ9uLMfMr8=;
 b=a/VRJRlpEpgtzY22p/Pm4yW9PXEGaR1zdWF1ipqDdkp/8LFbA6Is7ezF+9/sbUT65V
 B6NyuzTWu6D06X+auTNseKgX7kkFZkvkYAGqRppKlw06aRRu7sS17/6e3k9jdLU/w1av
 SW+1pdNG4b1uJblUZYkpxU81ON3kA/C3MoMLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792441380; x=1793046180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nsUjpUkprb0De2ezeywh970D5KG1ZRyKocJ9uLMfMr8=;
 b=AP7PG4/2za+JMUOKF27ZgITWsiWt1wV04VI2oLh25yW/CYoyG2cTc5juZwpHlJzoqU
 vEAkV/YspYEHEq9/fQil59OmJu69p6kvI8bs8f1qqEL/qgsYKHRBahbN2hmrX2wxPqMr
 XKoHBEYZFNqtsVWNGCf1Ff1apYsQq5xXVHPC8zSeUyZvV10pIlstv0oB+0S91h0KAxZa
 C65NH4iSBvwXD2ShjruBvwYvBJOVmVi9Nf/3FgbsJ8QLTxqHTd82JXsNcCrr7qE2aWOt
 SgzX67ZZltMz69dfTmh/NKdmC8VWv0JoKcQLynV2s3TeaccJXrwuR4rMzFgYkbyCEsB+
 a8VQ==
X-Gm-Message-State: AFq9FYJy/+xmAxaZaGzfPulTbIuhR9vWWoEa2BLgGeISRARp8EfczRJV
 o9A8JwOHxVV8cbidqP1xvivWa+eXbrwhHJ8tFAyLM9LC92+cXpFFXqPmwmQm8/ULvqj2x3n77wq
 GOLWKFUq8dC/FeJwvOueVg80lritoxykd0LtsAywOIrDMF/CwzikvOPOE4gCEUpZP8rB5Ga1bJY
 NBr6FdxV/s0+ODEiutAhmSNjjkhAI=
X-Gm-Gg: AYBFou0JJmSYiDvJ9fDHBNb5/9U4SDIPsZ9CKuMIhrnMVDuhK3ccbwAfxPsNfKjAlpI
 DUwgpOuZwC+CAXu2QSaxeRzDy2n1ANbfeobn0QuJkRd6rcv52q56HXajyGCKee5kemkLGafk8yW
 O/Yt6zN2wEEYkyvQsVss/wUEAwOqhOQnVFjnsvh//5vNLtf2OIGcloEsTdTuzE48g22KCfdYghn
 QDV3UPWkcpv12NFHrduMSqi9XAcJ2ob8izNYevTG/QcYRrTZ684wmTvrRwnE1q41oe6q5C8vJLM
 xRchwqK5+ZqD1NwPoCxMKVtZOlHGkCOIw68nXJ1mO2sEP9LU8VRknUsLUZQZcbuAIlnha43WkvG
 GpvT7XdJ4KCAKxpzj10HB5+DcfBKFppkoqvV+Y0xySDyq9C6sUZiEGAQOLgRJKfK/eDJj94KImq
 DNVC27OKVfLayU93FOIc9S/UPWiP6+L0Or78Nw88VWfXSsniZQMaHoR8iSQLk+A+vP7ze7UZkt0
 pJiDRORF9lo0NEcw99eKT6GlGYOaeo=
X-Received: by 2002:a05:6214:2e43:b0:91b:8ee1:2212 with SMTP id
 6a1803df08f44-91bdf01eb99mr135672996d6.20.1792441380005; 
 Mon, 19 Oct 2026 13:23:00 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c040b4915sm5510666d6.26.2026.10.19.13.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 13:22:59 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org, luca.vizzarro@arm.com, patrickrobb1997@gmail.com,
 dladd@iol.unh.edu
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v4 2/3] dts: fix cryptodev verify parsing
Date: Mon, 19 Oct 2026 16:22:51 -0400
Message-ID: <20261019202252.907692-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019202252.907692-1-abailey@iol.unh.edu>
References: <20260514172553.191331-1-abailey@iol.unh.edu>
 <20261019202252.907692-1-abailey@iol.unh.edu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The previous implementation of gathering the data of verify output did
not properly gather the correct values. This commit amends the faulty
regex with working ones.

Bugzilla ID: 1945
Fixes: 8ee2df9da125 ("dts: add cryptodev package")

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/api/cryptodev/__init__.py |  1 +
 dts/api/cryptodev/types.py    | 20 ++++++++------------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/dts/api/cryptodev/__init__.py b/dts/api/cryptodev/__init__.py
index a3ad59f7f0..e91eddeef9 100644
--- a/dts/api/cryptodev/__init__.py
+++ b/dts/api/cryptodev/__init__.py
@@ -131,6 +131,7 @@ def run_app(self, num_vfs: int = 1) -> list[CryptodevResults]:
             case TestType.pmd_cyclecount:
                 parser = PmdCyclecountResults
             case TestType.verify:
+                parser_options |= re.DOTALL
                 parser = VerifyResults
 
         return [parser.parse(line) for line in re.findall(regex, result.stdout, parser_options)]
diff --git a/dts/api/cryptodev/types.py b/dts/api/cryptodev/types.py
index 7b4fd17cb6..bce577de10 100644
--- a/dts/api/cryptodev/types.py
+++ b/dts/api/cryptodev/types.py
@@ -160,26 +160,22 @@ class VerifyResults(CryptodevResults):
     """A parser for verify test output."""
 
     #:
-    lcore_id: int = field(metadata=TextParser.find_int(r"lcore\s+(?:id.*\n\s+)?(\d+)"))
+    lcore_id: int = field(metadata=TextParser.find_int(r"\s*(\d+)"))
     #: buffer size ran with app
     buffer_size: int = field(
-        metadata=TextParser.find_int(r"Buf(?:.*\n\s+(?:\d+\s+))?(?:fer size:\s+)?(\d+)"),
+        metadata=TextParser.find_int(r"\s*(?:\d+\s+)(\d+)"),
     )
     #: burst size ran with app
     burst_size: int = field(
-        metadata=TextParser.find_int(r"Burst(?:.*\n\s+(?:\d+\s+){2})?(?: size:\s+)?(\d+)"),
+        metadata=TextParser.find_int(r"\s*(?:\d+\s+){2}(\d+)"),
     )
     #: number of packets enqueued
-    enqueued: int = field(metadata=TextParser.find_int(r"Enqueued.*\n\s+(?:\d+\s+){3}(\d+)"))
+    enqueued: int = field(metadata=TextParser.find_int(r"\s*(?:\d+\s+){3}(\d+)"))
     #: number of packets dequeued
-    dequeued: int = field(metadata=TextParser.find_int(r"Dequeued.*\n\s+(?:\d+\s+){4}(\d+)"))
+    dequeued: int = field(metadata=TextParser.find_int(r"\s*(?:\d+\s+){4}(\d+)"))
     #: number of packets enqueue failed
-    failed_enqueued: int = field(
-        metadata=TextParser.find_int(r"Failed Enq.*\n\s+(?:\d+\s+){5}(\d+)")
-    )
+    failed_enqueued: int = field(metadata=TextParser.find_int(r"\s*(?:\d+\s+){5}(\d+)"))
     #: number of packets dequeue failed
-    failed_dequeued: int = field(
-        metadata=TextParser.find_int(r"Failed Deq.*\n\s+(?:\d+\s+){6}(\d+)")
-    )
+    failed_dequeued: int = field(metadata=TextParser.find_int(r"\s*(?:\d+\s+){6}(\d+)"))
     #: total number of failed operations
-    failed_ops: int = field(metadata=TextParser.find_int(r"Failed Ops.*\n\s+(?:\d+\s+){7}(\d+)"))
+    failed_ops: int = field(metadata=TextParser.find_int(r"\s*(?:\d+\s+){7}(\d+)"))
-- 
2.55.0


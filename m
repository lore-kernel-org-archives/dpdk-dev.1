Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA379606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=fTKycgoH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE10B40659;
	Mon, 26 Oct 2026 21:17:20 +0100 (CET)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by mails.dpdk.org (Postfix) with ESMTPS id 04BBF40041
 for <dev@dpdk.org>; Mon, 26 Oct 2026 21:17:19 +0100 (CET)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-91c19fc50abso19047816d6.1
 for <dev@dpdk.org>; Mon, 26 Oct 2026 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793045838; x=1793650638; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qdTx5ADtOLmr/ljJGS2cK9j5OJzHwzknl9Dpxjo2HIc=;
 b=fTKycgoH4CD7dOcwdkB/nKbnwahmytNQ3dUoQONRjLgSZs3CP//Hlt1ydfJatzc6dj
 CZ+xW38ETB+zQA/BS82ZAkeNg/FGm2uCi2G5QqLcHxhjC0TJZy8fGFgBCI16PExZRRR3
 WacnFa4EbmIXHUbPVRumlr/sN5MMvptoY9ibw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793045838; x=1793650638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qdTx5ADtOLmr/ljJGS2cK9j5OJzHwzknl9Dpxjo2HIc=;
 b=IfZ8VaxkulEFD/P7pH6r3qKm5jw6pny5mFZPZRmJi3xBKrAFQ/MBqxh8syVjGr8iOa
 +kD3/Z4kICgT9PdqhyTPkl4qcLJM0p+8fwMYxWbiOzNIQ9NC0MImA2RqP0a6kx7e3qrw
 XlNye3Bxl0VT9pqYgaPJBNbNv3lZDgIF61tqnPl8JzLPgB4LywCRwr7M0FErrqKOATZg
 HxHWwpSCjWUvnKU+tw/jwk6c4uNno3LKysHF1IggjQnQzJjSXCwJYhVguWvC8uUnBCRE
 +JvyDsuvB+bfWUdGCnpRWLVmPuLyX/3GwWVnPTw4huw0/uazWuZks11L7kryxa7PzuIk
 cu1g==
X-Gm-Message-State: AFq9FYKebMP2AkzEfksgFS7U/04oH/zKYccgoC3xHHDo4Aspxmv4l2Tg
 ixcJmGRgP7Y3SIGtoYVsncOttr/GdkWdHryDDfwdqbVWi8xBdXSEuZyvq9aPmrqMvdjExiVcEjO
 6tmJfT+jBg9v1sztJrX7kkAJbI7YKO5T6hGDFmG0DbfjXepQlxayBRCtTZ2wQvVIQbNGHS595aq
 09gJLE5Xbv1dDOCF8gaV/I0tDGxgM=
X-Gm-Gg: AYBFou2IvD3748+mF8ZbjI8kIlEwk8OUSam4pTyUBwAfnmkFQrxva/F/Fcv1q8yKm3h
 UT7639czUGecdeZNoH6mLLgJqOEVWXG2COFv1fMzyQzuic9KXrwC4evgLWIOoLmM898tM/B2nDH
 AnBTZiXHUx57pVs2Q9I+56B0MRC0R8dMIDwzah9o7p+CpRXNZeVfKjDu6bHHDR/sq2Lmy1SWCID
 RCrcNar6+kTd1c9hM7C9y/TGxPXbsZb4jbcfuKiFJ1AvdPwD5WpulBkbZ6TGYI+qk9nVm4C7JQS
 nZ5jUMXfTWRBjXk+fB9LsASfAgU4j+dp6i3DjFamHdnsQUArraLZstkAgiMVkjmFolV84tRNKj0
 l12cYuoJYkyFWcRQYyivdtdUsd8gSBdCb2oktVrzvU2cY9FbR045tfEzTQVQBytyO6rdzMqv7/N
 qMLFRrVE6Hlm9AoqnbPeDZBtmtwPmfvtdsDRWApFMLEuVlqkHH4n33pt3WMECPlrWzKnyich4Lq
 loEuZphOaGVP3HxBNwr9TvbN5MbbN1j65Y6qENR5jqMF8iobDT18QjV7OdR0ZHJxx6IdEfCNwYd
 EM1inIuUJluTcDxE0RUxCNHVFHUg8twfB4HloVX/t4L/SyPpKOuJdf4VlN5TpELYhki0XGBR
X-Received: by 2002:a05:6214:29ca:b0:91b:7656:ffea with SMTP id
 6a1803df08f44-91c48e42d9emr130569826d6.35.1793045837562; 
 Mon, 26 Oct 2026 13:17:17 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47c50e10sm81969766d6.25.2026.10.26.13.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 13:17:17 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5 2/3] dts: fix cryptodev verify parsing
Date: Mon, 26 Oct 2026 16:16:42 -0400
Message-ID: <20261026201643.72369-3-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026201643.72369-1-abailey@iol.unh.edu>
References: <20260428193541.79005-1-abailey@iol.unh.edu>
 <20261026201643.72369-1-abailey@iol.unh.edu>
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
2.56.0


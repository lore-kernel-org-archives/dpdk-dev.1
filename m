Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD57C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 15:02:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79DFA402E9;
	Mon,  6 Jul 2026 17:02:15 +0200 (CEST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com
 [209.85.221.169])
 by mails.dpdk.org (Postfix) with ESMTP id B6F0E402C3
 for <dev@dpdk.org>; Mon,  6 Jul 2026 17:02:13 +0200 (CEST)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-5bdc4fc26bfso1767418e0c.0
 for <dev@dpdk.org>; Mon, 06 Jul 2026 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783350133; x=1783954933; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRv8T0DX9QZ6YDLZzN+o+bRboCAo8BMjtaGLEJf8FW0=;
 b=T+MtFIOZGwwSr2DjsIf+hQlynaFxX3WJGDOqDtOQWOvivumDfYBnKxSYPJfBMxZ/1f
 7A6xbL10MU+cR23cOeXNhL17TzR+hl0oijPRYmj0seqD8oO5Sra2EzzAOxetVNCtlHRh
 fVEzyowS77LyH4O0rnV6+LgsKF4qBFswFnPgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783350133; x=1783954933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fRv8T0DX9QZ6YDLZzN+o+bRboCAo8BMjtaGLEJf8FW0=;
 b=JKOHAiJg56Foj7BrpVg1ET9I9koW8C+cirKlMTzN/TOBfiBdcoxeZiz7NNV89MTqgy
 nNI9FCtqTbH4ncnEUBNllzvRg+aMtYcs5RKBGBrtKUvvWV+0iLBvuAb6y2m4NDPkCUnY
 O1pLMRPXPwp47bTx2zyEG31a1KmikNI9wzSOPbAhT2KbnSFKWQSKOPjq/eyrKauQacPs
 wJdElFSuDJ6Zf08To3+ro57Un8CuM5kEW7maTL47cPz+iX/DBRAcHF87omuXIhYP77D7
 +Ecvp5dzH1lu1FqByY1BkTKCK4w6lod4ir+tf/dBlDc2DZEg4fBv/NxSSMhdH/zgSxXs
 8edA==
X-Gm-Message-State: AOJu0YyFquXiR4+67g+O2htF2YtU4cUFvjtYrtX6D2q1Wdcz0uvpjYoO
 JLxGmsQx8Q0NCBskMZ2uiQrzw3mcb7c9omQj+YAQIQfwfn/Ndf0JpRRt4beqIt0DXJhsN4XoU81
 KqLjBmaebZGYJZOEtQ26Nti0T/0IGaHjdZdPUxIeKqYU9Cf3vSUYYPUs6W1ffzQ16pqOZ5loqTs
 uKU8+zbfAU/P3dmvdi58G7nJpOckw=
X-Gm-Gg: AfdE7ck2a3pE/RiIlY9HxuTZo2yPyMOu434k6xeQqY9GiVbenidwNpYoH8k5t4PtVyN
 lDBqh53PjcnBrEJkYsrlPxQWRF5EfLvwW5Qog+UZj0YXUKP1aKvHad0ZIqtoEhuImKAVk8D48p9
 UtcHvBiJPA4JidOflKHj8uJZHMdln8eJbblVYXLafarTuE64g40Nq5/IWNaNe+od4yRpqgTOscL
 kL/9OFJQnMo4tbJqnlhiqbX7CzCbtAuABQRmQmNMHAE6YJtYJNUCnVUPTpPQTa2Skd/5mUz/UHL
 bTx1HUq/w8bIBzZ72ARcmuYsn10hQ6h0qLFsifCoNUEWSJ+DZa7V8Ouu0S1/p2PnlUag/677Wji
 c1QkBYStRhI2u5nqRR9P+F8dg3Y5jrOvDzINXBP6ODm66oF4gAvDbaFWF8kE+vxkVge/EPev++1
 BdZus5BAiSPE9/YcosO+mS/zR5WxEvCSGqHfZKzTiXDMCbbDn+fzWXGQ==
X-Received: by 2002:a05:6122:1696:b0:5a1:b296:78fc with SMTP id
 71dfb90a1353d-5be9076a42emr204842e0c.1.1783350131771; 
 Mon, 06 Jul 2026 08:02:11 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210:5d7f:246:cd51:1b62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f4726b3201sm138661976d6.46.2026.07.06.08.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 08:02:11 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v3 2/3] dts: fix cryptodev verify parsing
Date: Mon,  6 Jul 2026 11:02:04 -0400
Message-ID: <20260706150205.497924-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706150205.497924-1-abailey@iol.unh.edu>
References: <20260514172553.191331-1-abailey@iol.unh.edu>
 <20260706150205.497924-1-abailey@iol.unh.edu>
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
index 4e8ce47de1..90b847d1fb 100644
--- a/dts/api/cryptodev/__init__.py
+++ b/dts/api/cryptodev/__init__.py
@@ -132,6 +132,7 @@ def run_app(self, num_vfs: int = 1) -> list[CryptodevResults]:
             case TestType.pmd_cyclecount:
                 parser = PmdCyclecountResults
             case TestType.verify:
+                parser_options |= re.DOTALL
                 parser = VerifyResults
 
         return [parser.parse(line) for line in re.findall(regex, result.stdout, parser_options)]
diff --git a/dts/api/cryptodev/types.py b/dts/api/cryptodev/types.py
index df73a86fa4..861d46bf13 100644
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
2.54.0


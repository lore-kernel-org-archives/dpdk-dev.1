Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705A3CD4F39
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 17:26:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C23540431;
	Thu, 14 May 2026 19:26:25 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 6B49D402F1
 for <dev@dpdk.org>; Thu, 14 May 2026 19:26:23 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-90d13fa59e8so363398585a.2
 for <dev@dpdk.org>; Thu, 14 May 2026 10:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1778779583; x=1779384383; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gj/l2zXoFOsTaJWb4/ovQGVPJ3hiCfAyUBHD9vedUgA=;
 b=AbtXlsMNOpnaVw652H8rbEMBOXQ/ZEy2lsypdWM19RdnGbNOQK/SHJSsbI2RDiVQR+
 ihjAUsl49XSGc4x5Mux0E++rwOZ5PWsCuczxrkrmkdVL8GbaU076TXUz+Yyg8g8y4GSP
 PkbKBYWF4Mx2r6efdf0SUHCnhIeoqPDSp3sz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778779583; x=1779384383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gj/l2zXoFOsTaJWb4/ovQGVPJ3hiCfAyUBHD9vedUgA=;
 b=P9C+WRImO3ocxodKPr7G0OCAS3mmLsZgs+WoeaVRG2Bi52MwROOm22rep+sqfW/Zlf
 JJzqPjYDR19fU9/7FMLGAhUvxBvui35pdx82CyPyS7+IBA+w0GOzwfkvbZL3sg/pk8tP
 F5KvWuAAPQc5n9xjid1YGZsTom6vC5WeDkfTg33rg7fFY0iPojZNxB5WjlORQu6zdD/q
 js67uY9P17wCyI/G3Ehum/PhUQRTH/6RWMBPqZM9T+EOttu7JP++g6kB2VJImMmUHRoX
 fY80JbLM3ifH7paMc1zIIAGaqAZ8oTl/T1lRfQTn7Fl+JwVYXFdjU1RekmbhalxlY9kp
 1c4g==
X-Gm-Message-State: AOJu0Yz5u9eeCnH2wY0IhBcoyL6kOshTpJk9mTKjlnjETMiCYS4cvoMu
 oy/gxO7UjGeR9agyPHaXtbb2eljyZKtIVV1wIzVJT11mWSoX3NyoenSNNu18TKicYPE=
X-Gm-Gg: Acq92OGxCl+RdinN21NAp2bt0O288s722aEB4v0zteyuOYVXepc4BytHSjpylp6QBDz
 omch2k0mx2ee6W0VAr07Vb8E7lUdOG9pkHGz2NTK4Og+cTQdesw4y5JBzq4w6AdVrsa6p/JN+hj
 rzz+1pjjYPropdXBwIauSyLFkIRsp9saiG4HmJMblEt5eWDWRZ0UlRRuoUSegBSJlaTAwaRSdyE
 EFjnHp+pwd6aBMNBanRG4viTCcMlZlQY6xZDsEZsrNW83sK/n8WCoiRQH36PLoK0c/6g2lSEqo6
 7P8nUxkuBN4e8eRgvau9O1b0OF0SUvbLsn6KLPlXg3oZm/dYZWqUT+EjSUzCfQmQ1nIupGERYz0
 jpg7pPLcnE1sKap2krfBjKw3vguhLZuohdMDcNchXYmB/V7HoTP/0UwRhfIS5AzokgGytLr9nkq
 eJmgRFIpvC9X41KZPc89YduuvZRweAvmoMQY6HYqjXMqkHYPbOIAE8eplaUGgDyX3s
X-Received: by 2002:a05:620a:4449:b0:910:d4ca:4a8c with SMTP id
 af79cd13be357-911cf7e7f86mr68475285a.60.1778779582688; 
 Thu, 14 May 2026 10:26:22 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bd8211e2sm296882685a.47.2026.05.14.10.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:26:22 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, lylavoie@iol.unh.edu, ahassick@iol.unh.edu,
 knimoji@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1 2/3] dts: fix cryptodev verify parsing
Date: Thu, 14 May 2026 13:25:52 -0400
Message-ID: <20260514172553.191331-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260514172553.191331-1-abailey@iol.unh.edu>
References: <20260428193541.79005-1-abailey@iol.unh.edu>
 <20260514172553.191331-1-abailey@iol.unh.edu>
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
2.50.1


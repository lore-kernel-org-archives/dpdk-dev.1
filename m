Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F40C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 13:35:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E5E340A70;
	Mon,  6 Jul 2026 15:35:49 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 837FB402C3
 for <dev@dpdk.org>; Mon,  6 Jul 2026 15:35:48 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-8efef6533aaso23154346d6.0
 for <dev@dpdk.org>; Mon, 06 Jul 2026 06:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783344948; x=1783949748; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRv8T0DX9QZ6YDLZzN+o+bRboCAo8BMjtaGLEJf8FW0=;
 b=Og4954M2mLoEmKx572JV7Z+neP6hBxfjJAKgGfyGup7d8eTCx4neJAT5Cle1uYcieo
 1fHJk0azUM3TS+y4BKHvNmfxH3gLvtMYA2cGybrQSRHMrVLSlym4JXld/zTywfityasx
 DZYOXVjMxRLEnDXcN9AyRyV5figqbmT+zILp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783344948; x=1783949748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fRv8T0DX9QZ6YDLZzN+o+bRboCAo8BMjtaGLEJf8FW0=;
 b=SLxTryMKgLDH7wI2rPKuma9Cfei/olYWThBI/h9K0EkWacjnBMOjSbzOupgHJBS8eW
 w4F9jTynl36eVAYmKAc+5ar0PCmF4hni2jDW3qypjw2UDO+54ZNKX8AYKanm6e3X0qQL
 7MnB1Ms6gdwSivPWq6jkOLR4eDqqaIKG/wPFpnkNg8yKljEWnJqstQzf4D7/wIDqAfrl
 tYuV4/tVjW95Ahzl5GKayT2MxgkwJo+PkHxhvN41GNoPHPTrRKoyBR1iEkesZCB0pe87
 Qarh/InlXElUCYZ9s25gJf3nYJqXSnhxAb/ttegNTikJcETrj+UW+6iAjsnFN22i6uh/
 BlFg==
X-Gm-Message-State: AOJu0Yyjmf9oDhwtIfqHqMAC6dR8pXIRX2nXqientOHQ3jGFDh4T1NTX
 soNeSqkzdMnNOKTAGZVG7BDsqL/UeP9bggh2wBu7TC1W2/lls9wn4NBKkQ1SNw2q4JhqDG0smso
 MW6uJH3s4fMXQK+UNoUIHat1+vnUKRJnHZGTOfw5X0C+UFvXysQ/ZIv2OSiR8wrgVAQI0Scc6MS
 mLdjyEr91Zi6wrxrXBWJhbpLlL954=
X-Gm-Gg: AfdE7cnCcjgGSp4eGfm+xQNoo1PpFwP0vY76cNfYglPNDISSZt//22UEyuGmgni1aoy
 fSCVA3xuHIHkYLWXVt25711Z/Exo1k4dokwArXzar375AQ0q7AtXHYAvdTvL0aJmU1fYWsvLT3m
 ecigiELvg3v+32WzlsgS/M9R3vp9vQ2WNMXIJ3L/5swUAXbcM0Fh7n5s/r177eU/Hj/IlmQY3xD
 wwYBRwmhx7PT/EgRfStpWiRqWcdAHF0hvZOeXj9MocXKxwDmaVjVZTNThjhOkoiGeyvadonqWCk
 TRS0kqSfo6fAmH33vp1rZNvV5ucIsiNbeapKCCf14jiF+cP20f++HF/3DPjHeSL+Ndi9Bg3cPPz
 WGJDVh+WqxK5gugeqisS3BgdPMCME9yX+0CoCntZhIw1pBQKP5g9x/I4ioG1ftxw9HHoOCoS0hJ
 MeWea6DVamWSGA3GTGaky2H0GRF7E7ojrij0WZC7qojdKL4TFAVB+u4g==
X-Received: by 2002:a05:6214:2127:b0:8ef:e3c9:533e with SMTP id
 6a1803df08f44-8fcb19ecd06mr5137646d6.9.1783344947606; 
 Mon, 06 Jul 2026 06:35:47 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210:5d7f:246:cd51:1b62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f46e27d555sm136081246d6.7.2026.07.06.06.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 06:35:47 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2 2/3] dts: fix cryptodev verify parsing
Date: Mon,  6 Jul 2026 09:34:27 -0400
Message-ID: <20260706133428.468816-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706133428.468816-1-abailey@iol.unh.edu>
References: <20260514172553.191331-1-abailey@iol.unh.edu>
 <20260706133428.468816-1-abailey@iol.unh.edu>
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


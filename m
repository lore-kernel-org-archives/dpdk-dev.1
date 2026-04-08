Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA4F10F994F
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 15:28:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D0AC4014F;
	Wed,  8 Apr 2026 17:28:15 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 71EDC4013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 17:28:14 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2c54c68db4dso12322017eec.0
 for <dev@dpdk.org>; Wed, 08 Apr 2026 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775662093;
 x=1776266893; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JOTu1vPSP01rJ+2iT3sJ6In9WSm0S7k2EtgNdEMg7S4=;
 b=u0xPk6hyFxKP1+jb56YtysKpU/6GBf8bO3Yb0G2iht0HG5sdTGWssSSmdX0H+OgyCc
 2QWjyPZ4VuM4InMHzxHMnujiD/eFcaaFOZU8L/y/farnp7UojbXjYwqFVGlV7HgXvC5j
 YvVcXa4JogdCdgJ92tBUJQWTV/JMSRLa5ozbKT1zUSoz9d89/wX/ASdEVuwuTZPU229U
 BLNXNFFR143M7MDBD3S9EIIxeACDX/0AFLWgTGe02S8q3MoUhY9issRhiKu9ku8XZXDP
 zCJJKxpWUMP1IQ6LlJNo1m2bGC0MYgnu6SPiZGsMB/WjwD+0yFVBYpAni7kUCQYHZPoX
 KzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775662093; x=1776266893;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOTu1vPSP01rJ+2iT3sJ6In9WSm0S7k2EtgNdEMg7S4=;
 b=NhYeB0A9ux5einjEcBCGBWTtBEqSN3MuVpMsK4i2nSRXErtG1o8LPo9TiVP1ROO2Gp
 kl3Ik10tlKDRAvAOnJtxZMXxjfv+3QdVcxUQeWtS/s3+VVDDc3K45NQI3s86XVBKTXe6
 0Qnyc83QihTW2J10am6nOWrdEh6YjETr+KmRZBIjBggd0uHKXy2zqumMyAXPzfKxykyL
 n5sLig5R+yn8LPYQb9Su1C8wYnlXtDcRQSX1dPzItf7Osv5ANyedrmuZGXMacW+JQ7s2
 muYL9qUovxETU97V8zDSRyIXrfV1dYJ38gkhoD1FnpkjY2OZs085MF/psyOfrWFbyDTQ
 OHHg==
X-Gm-Message-State: AOJu0YzOQcPEgEvIscew8KP5aoQUASaPWArZEaRFGVFeTdTyclV6IAa2
 N0hCnboE5W1Aq9Dmao+KDWaN/26uzBU/p37gtX1NN0p8HRV2DFDBxxt+voZH5Pe32B/2fusBPyc
 QybkL
X-Gm-Gg: AeBDieuoGr3rQ3pSdcq0HBsnZEkDG4T5EBDTStdGnLmfQV/nJSoxs69lnrYG/ldGH+C
 lVteEU+vkbKfnxonXR4KNttnoIaj0DZRoR+dLcHqMu1NDkGEYbVL7PKkIKzeVtldV7t4lvCgHkf
 Z+YDYEjFMj15DgT/Bd+19q44fl0Ohj8dcTh++vXpXdgw62wd6CV8T1gxmplliDi93GPrVFt1giu
 Mhf5zkSe+2os8sbthEt07DoH2mHL7LLnYeH1zPfyRa0E3mgqaJY9dHtYTQ79LMennmPN8mLYuei
 kmyRFbxQ2EZwkowQ13H7kJa/2BCYc7pvrggI+lcZjY4MpZMuYRqv2UwXWHhtii9Pt7TjyjNxiVY
 mu23B6BY9Gyou5Q48LnvHZyqsfvCWRpc7xsny56XDqNACocjap2pB98tnPUGDDS2D54Gdcl7Sqc
 WNjftYDNaQmc/rFReChdc3/kFMtJaC1kGk
X-Received: by 2002:a05:7300:dc88:b0:2ca:7eb4:3e37 with SMTP id
 5a478bee46e88-2cbf9afd418mr11833858eec.6.1775662093209; 
 Wed, 08 Apr 2026 08:28:13 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cf1af62347sm14308497eec.22.2026.04.08.08.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 08:28:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] doc: update warnings about primary/secondary process
Date: Wed,  8 Apr 2026 08:28:08 -0700
Message-ID: <20260408152808.201257-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The existing documentation about primary/secondary requirements
is not strong enough; make it clear what the requirements are.
This may be obvious already to developers but not users.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/multi_proc_support.rst | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/doc/guides/prog_guide/multi_proc_support.rst b/doc/guides/prog_guide/multi_proc_support.rst
index a73918a5da..e0ba72c294 100644
--- a/doc/guides/prog_guide/multi_proc_support.rst
+++ b/doc/guides/prog_guide/multi_proc_support.rst
@@ -25,10 +25,15 @@ after a primary process has already configured the hugepage shared memory for th
 
 .. note::
 
-    Secondary processes should run alongside primary process with same DPDK version.
+    Secondary processes run alongside the primary process and:
+
+    * MUST have equivalent permissions and trust level.
+      There is no privilege separation between primary and secondary processes.
+    * MUST be running the same DPDK version.
+    * MUST be passed the same device access arguments (allow and block options).
+    * MUST share the same mount and PID namespaces. Running a secondary process
+      in a different container namespace from the primary is not supported.
 
-    Secondary processes which requires access to physical devices in Primary process, must
-    be passed with the same allow and block options.
 
 To support these two process types, and other multi-process setups described later,
 two additional command-line parameters are available to the EAL:
-- 
2.53.0


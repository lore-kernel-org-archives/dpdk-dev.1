Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5583EC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 21:21:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 466D840659;
	Wed, 26 Feb 2025 22:21:15 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id BE14D40608
 for <dev@dpdk.org>; Wed, 26 Feb 2025 22:21:12 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 0392A210C313; Wed, 26 Feb 2025 13:21:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0392A210C313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740604872;
 bh=VSYR4DcBV1kmQrrmc/pUwBf0UjzLR8n7yMe4tyagU1k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pyfmpPCUURSKmnTPw3vcE+FsbXA/pcNBmRhufGKJ60W8F67VJ4Q7Ej4Dqj6LAO77y
 uxZzj8fghn/b4bN8yU4EVghU1Ndd9DaNIccuJBm7xR2PbNankUqWpNExefgV9JJTr9
 O5InYZ8RYaAOetN6KV8rRCBrDYLXzqx4udEBC1ps=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v3 2/3] eal: only use numbers as align parameters for MSVC
Date: Wed, 26 Feb 2025 13:21:05 -0800
Message-Id: <1740604866-6184-3-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740604866-6184-1-git-send-email-andremue@linux.microsoft.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740604866-6184-1-git-send-email-andremue@linux.microsoft.com>
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

After the instruction set updates for MSVC the error below popped up:

..\lib\eal\x86\include\rte_vect.h(82): error C2059: syntax error: '('

The issue is that MSVC does not allow __rte_aligned(RTE_X86_ZMM_SIZE).
It only accepts numbers that are power of 2. So, even though
RTE_X86_ZMM_SIZE represents a number that is a power of two it cannot
be used directly.
https://learn.microsoft.com/en-us/cpp/cpp/align-cpp?view=msvc-170

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/x86/include/rte_vect.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/eal/x86/include/rte_vect.h b/lib/eal/x86/include/rte_vect.h
index 70c78e9b77..9ea158b27e 100644
--- a/lib/eal/x86/include/rte_vect.h
+++ b/lib/eal/x86/include/rte_vect.h
@@ -76,9 +76,18 @@ __extension__ ({                \
 
 #ifdef __AVX512F__
 
-#define RTE_X86_ZMM_SIZE	(sizeof(__m512i))
+#define RTE_X86_ZMM_SIZE        64
 #define RTE_X86_ZMM_MASK	(RTE_X86_ZMM_SIZE - 1)
 
+/*
+ * MSVC does not allow __rte_aligned(sizeof(__m512i)). It only accepts
+ * numbers that are power of 2. So, even though sizeof(__m512i) represents a
+ * number that is a power of two it cannot be used directly.
+ * Ref: https://learn.microsoft.com/en-us/cpp/cpp/align-cpp?view=msvc-170
+ * The static assert below ensures that the hardcoded value defined as
+ * RTE_X86_ZMM_SIZE is equal to sizeof(__m512i).
+ */
+static_assert(RTE_X86_ZMM_SIZE == (sizeof(__m512i)), "Unexpected size of __m512i");
 typedef union __rte_aligned(RTE_X86_ZMM_SIZE) __rte_x86_zmm {
 	__m512i	 z;
 	ymm_t    y[RTE_X86_ZMM_SIZE / sizeof(ymm_t)];
-- 
2.48.1.vfs.0.0


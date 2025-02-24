Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FFCC021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 21:01:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76473427C6;
	Mon, 24 Feb 2025 22:01:45 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0015240EE2
 for <dev@dpdk.org>; Mon, 24 Feb 2025 22:01:42 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 55EF9203CDE4; Mon, 24 Feb 2025 13:01:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 55EF9203CDE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740430902;
 bh=z//Y+M7t+kaPIDtMOTzBoegxFEJ4arUi+39d/uUjs48=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hvjlth/TyzqVNz/SU3AaJKQV40ek8vvppS6rxdXXcNbI6EYjVN/Ch+lKOr6yh00gF
 waea0+sSjr3a8WEpNS+92DM4WRk3M1v+SO6klAKxpo/6EZuBsO8l4Mn+G/jVc4Im4f
 fcmwxCovSjuHKG/dHTw0PojemWqD6zu9BcjCGG68=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH 2/6] eal: only use numbers as align parameters for MSVC
Date: Mon, 24 Feb 2025 13:01:15 -0800
Message-Id: <1740430879-17874-3-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
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

After the instruction set updates for MSVC the error below poped up:

..\lib\eal\x86\include\rte_vect.h(82): error C2059: syntax error: '('

The issue is that MSVC does not allow __rte_aligned(RTE_X86_ZMM_SIZE).
It only accepts numbers that are power of 2. So, even though
RTE_X86_ZMM_SIZE represents a number that is a power of two it cannot
be used directly.
https://learn.microsoft.com/en-us/cpp/cpp/align-cpp?view=msvc-170

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/eal/x86/include/rte_vect.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/eal/x86/include/rte_vect.h b/lib/eal/x86/include/rte_vect.h
index 70c78e9b77..0a51c539a4 100644
--- a/lib/eal/x86/include/rte_vect.h
+++ b/lib/eal/x86/include/rte_vect.h
@@ -79,7 +79,16 @@ __extension__ ({                \
 #define RTE_X86_ZMM_SIZE	(sizeof(__m512i))
 #define RTE_X86_ZMM_MASK	(RTE_X86_ZMM_SIZE - 1)
 
-typedef union __rte_aligned(RTE_X86_ZMM_SIZE) __rte_x86_zmm {
+/*
+ * MSVC does not allow __rte_aligned(RTE_X86_ZMM_SIZE). It only accepts
+ * numbers that are power of 2. So, even though RTE_X86_ZMM_SIZE represents a
+ * number that is a power of two it cannot be used directly.
+ * Ref: https://learn.microsoft.com/en-us/cpp/cpp/align-cpp?view=msvc-170
+ * The static assert below ensures that RTE_X86_ZMM_SIZE is equal to what is
+ * used in the __rte_aligned() expression.
+ */
+static_assert(RTE_X86_ZMM_SIZE == 64, "Unexpected size of __m512i");
+typedef union __rte_aligned(64) __rte_x86_zmm {
 	__m512i	 z;
 	ymm_t    y[RTE_X86_ZMM_SIZE / sizeof(ymm_t)];
 	xmm_t    x[RTE_X86_ZMM_SIZE / sizeof(xmm_t)];
-- 
2.48.1.vfs.0.0


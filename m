Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D6BC021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 16:32:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DE3B40687;
	Tue, 18 Feb 2025 17:32:21 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 58DE740652
 for <dev@dpdk.org>; Tue, 18 Feb 2025 17:32:15 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 4B77420376E7; Tue, 18 Feb 2025 08:32:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B77420376E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739896334;
 bh=unQasv6UXRNIjBi2YSyxPO3HBiDYlPMb/4WVTqcvVWY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OsVILPhVarBJTPLGzsRN3xK9GDlvbG+mtzR/OYW61pg0L+xKekyT6I5CFoaQyygZm
 ctF/eCPTJhtTP6ad5vwPfz4csd5KrrUulY8Ahfc0t2DhLyxZEJE85haFSeaHpVdK41
 nW0pzzFXgZmOt5bsyLgOJxI6YJ/mMJygxADqJMJo=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v2 01/10] eal: add workaround for __builtin_constant_p
Date: Tue, 18 Feb 2025 08:32:00 -0800
Message-Id: <1739896329-1946-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
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

There's no MSVC equivalent for compiler extension __builtin_constant_p.
EAL already had __rte_constant which was used as a first attempt to
workaround __builtin_constant_p when using MSVC. However, there are
pieces of code that would benefit from being able to provide a default
value to be used instead of it being always 0 like how it was done by
__rte_constant.

A new macro is added here allowing such default to be provided by the
caller.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/eal/include/generic/rte_pause.h |  2 +-
 lib/eal/include/rte_common.h        | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/eal/include/generic/rte_pause.h b/lib/eal/include/generic/rte_pause.h
index 968c0886d3..57e13807ea 100644
--- a/lib/eal/include/generic/rte_pause.h
+++ b/lib/eal/include/generic/rte_pause.h
@@ -130,7 +130,7 @@ rte_wait_until_equal_64(volatile uint64_t *addr, uint64_t expected,
  *  rte_memory_order_acquire and rte_memory_order_relaxed.
  */
 #define RTE_WAIT_UNTIL_MASKED(addr, mask, cond, expected, memorder) do { \
-	RTE_BUILD_BUG_ON(!__builtin_constant_p(memorder));               \
+	RTE_BUILD_BUG_ON(!__rte_constant_with_default(memorder, 1));     \
 	RTE_BUILD_BUG_ON((memorder) != rte_memory_order_acquire &&       \
 		(memorder) != rte_memory_order_relaxed);                 \
 	typeof(*(addr)) expected_value = (expected);                     \
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 3f77b7624e..6bdce70551 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -50,6 +50,18 @@ extern "C" {
 #define __rte_constant(e) __extension__(__builtin_constant_p(e))
 #endif
 
+/**
+ * Determine if an expression's value is constant at compile time.
+ * All compilers except MSVC will return 1 if the first argument is a
+ * compile-time constant, and 0 otherwise. MSVC will just return the second
+ * argument as a default value.
+ */
+#ifdef RTE_TOOLCHAIN_MSVC
+#define __rte_constant_with_default(e, def) def
+#else
+#define __rte_constant_with_default(e, def) __extension__(__builtin_constant_p(e))
+#endif
+
 /*
  * RTE_TOOLCHAIN_GCC is defined if the target is built with GCC,
  * while a host application (like pmdinfogen) may have another compiler.
-- 
2.48.1.vfs.0.0


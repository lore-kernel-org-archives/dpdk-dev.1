Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B2AC021A0
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 22:02:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAD9340E34;
	Tue, 11 Feb 2025 23:02:43 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 24A42402EF
 for <dev@dpdk.org>; Tue, 11 Feb 2025 23:02:41 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 5687E210D0DA; Tue, 11 Feb 2025 14:02:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5687E210D0DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739311360;
 bh=9e7VdbXsQ65jTsDup20x7KKQ/7gHG5sP3RPFVTiOAwk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QSEwt9ZGw44RxuR+FwlyZyuRSUxX8CusdTite6yXlWRVu0A4OtyhN+cRE/bLH/CvN
 r07O46Z4u8C7/AJX5PK418K3x/RrjPsRr+7qCVz7vntvsXs0dVKqUywlqAWYTCjMW4
 EBWMWmg7vLJZg+pyP9T82Bo+S+9j4TazEeUQ5aKw=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Tyler Retzlaff <roretzla@linux.microsoft.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH 01/10] eal: add workaround for __builtin_constant_p
Date: Tue, 11 Feb 2025 14:01:57 -0800
Message-Id: <1739311325-14425-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
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
2.47.2.vfs.0.1


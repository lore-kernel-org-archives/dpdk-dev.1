Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0994C021B0
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 02:01:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93779402CB;
	Thu, 20 Feb 2025 03:01:50 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2AB534014F
 for <dev@dpdk.org>; Thu, 20 Feb 2025 03:01:48 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 3C7B0204E59D; Wed, 19 Feb 2025 18:01:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C7B0204E59D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740016907;
 bh=g7NCe5SVRn2L0LVFDpbEbxvyirQX9eZcZejc8Cc7E7E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=It/OSBswDz5ztZAIcRRMqi6Hb11+aK+lTmJGRUAPkHJLwFLE+OLo/BKof9rJdAAJ+
 p/ldpkj53XllYpvmDbDpcUE4UGp8FHzee7O1bHgLq3+Owrg3tEHYh/6xctjwEMTnEJ
 1r4DYwUcjgmqJtjq05vkAYx5w46cXxHCtNSDD/10=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v3 01/10] eal: add workaround for __builtin_constant_p
Date: Wed, 19 Feb 2025 18:01:30 -0800
Message-Id: <1740016899-2817-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740016899-2817-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740016899-2817-1-git-send-email-andremue@linux.microsoft.com>
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

There's no MSVC equivalent for compiler extension __builtin_constant_p,
but the same result can be obtained though a clever expression using
_Generic.

This patch redefines the macro __rte_constant when msvc is used and uses
it as a replacement for __builtin_constant_p.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/eal/include/generic/rte_pause.h | 2 +-
 lib/eal/include/rte_common.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/eal/include/generic/rte_pause.h b/lib/eal/include/generic/rte_pause.h
index 968c0886d3..9515caadbb 100644
--- a/lib/eal/include/generic/rte_pause.h
+++ b/lib/eal/include/generic/rte_pause.h
@@ -130,7 +130,7 @@ rte_wait_until_equal_64(volatile uint64_t *addr, uint64_t expected,
  *  rte_memory_order_acquire and rte_memory_order_relaxed.
  */
 #define RTE_WAIT_UNTIL_MASKED(addr, mask, cond, expected, memorder) do { \
-	RTE_BUILD_BUG_ON(!__builtin_constant_p(memorder));               \
+	RTE_BUILD_BUG_ON(!__rte_constant(memorder));                     \
 	RTE_BUILD_BUG_ON((memorder) != rte_memory_order_acquire &&       \
 		(memorder) != rte_memory_order_relaxed);                 \
 	typeof(*(addr)) expected_value = (expected);                     \
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 3f77b7624e..0a20b6a3e3 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -45,7 +45,7 @@ extern "C" {
 #endif
 
 #ifdef RTE_TOOLCHAIN_MSVC
-#define __rte_constant(e) 0
+#define __rte_constant(e) _Generic((1 ? (void *) ((e) * 0ll) : (int *) 0), int * : 1, void * : 0)
 #else
 #define __rte_constant(e) __extension__(__builtin_constant_p(e))
 #endif
-- 
2.48.1.vfs.0.0


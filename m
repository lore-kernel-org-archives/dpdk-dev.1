Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E706C021B5
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 19:53:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F04EB427AF;
	Fri, 21 Feb 2025 20:52:54 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 8E0624279C
 for <dev@dpdk.org>; Fri, 21 Feb 2025 20:52:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 9FD7C204E5BF; Fri, 21 Feb 2025 11:52:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9FD7C204E5BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740167568;
 bh=JJGuSYYv5FRd9NzQqXBDNW0Iges3FwLABVEoJ8ghgxg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=li6H4pYIsqFXdjxbQOyFiMdVUNXJo+t2OubwX8L5rWYHRn5DpJzrugx9PIyY1D+Dp
 SA6duEuJ5NpGujnG91QLhQoA6o2GCDN5aN0wTR+dat70e/FT52i7NGeOEKVfMJMNEb
 1s+RtFcbiU8ep8GpePLlS2rNFajU/nQJn6hDF2jE=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v5 01/10] eal: add workaround for __builtin_constant_p
Date: Fri, 21 Feb 2025 11:52:34 -0800
Message-Id: <1740167563-12332-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740167563-12332-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740167563-12332-1-git-send-email-andremue@linux.microsoft.com>
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
but the same result can be obtained through a clever expression using
_Generic.

This patch redefines the macro __rte_constant when msvc is used and uses
it as a replacement for __builtin_constant_p.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/eal/include/generic/rte_pause.h |  2 +-
 lib/eal/include/rte_common.h        | 34 ++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

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
index 4be65376a5..386f11ae40 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -44,8 +44,40 @@ extern "C" {
 #endif
 #endif
 
+/*
+ * Macro __rte_constant checks if an expression's value can be determined at
+ * compile time. It takes a single argument, the expression to test, and
+ * returns 1 if the expression is a compile-time constant, and 0 otherwise.
+ * For most compilers it uses built-in function __builtin_constant_p, but for
+ * MSVC it uses a different method because MSVC does not have an equivalent
+ * to __builtin_constant_p.
+ *
+ * The trick used with MSVC relies on the way null pointer constants interact
+ * with the type of a ?: expression:
+ * An integer constant expression with the value 0, or such an expression cast
+ * to type void *, is called a null pointer constant.
+ * If both the second and third operands (of the ?: expression) are pointers or
+ * one is a null pointer constant and the other is a pointer, the result type
+ * is a pointer to a type qualified with all the type qualifiers of the types
+ * referenced by both operands. Furthermore, if both operands are pointers to
+ * compatible types or to differently qualified versions of compatible types,
+ * the result type is a pointer to an appropriately qualified version of the
+ * composite type; if one operand is a null pointer constant, the result has
+ * the type of the other operand; otherwise, one operand is a pointer to void
+ * or a qualified version of void, in which case the result type is a pointer
+ * to an appropriately qualified version of void.
+ *
+ * The _Generic keyword then checks the type of the expression
+ * (void *) ((e) * 0ll). It matches this type against the types listed in the
+ * _Generic construct:
+ *     - If the type is int *, the result is 1.
+ *     - If the type is void *, the result is 0.
+ *
+ * This explanation with some more details can be found at:
+ * https://stackoverflow.com/questions/49480442/detecting-integer-constant-expressions-in-macros
+ */
 #ifdef RTE_TOOLCHAIN_MSVC
-#define __rte_constant(e) 0
+#define __rte_constant(e) _Generic((1 ? (void *) ((e) * 0ll) : (int *) 0), int * : 1, void * : 0)
 #else
 #define __rte_constant(e) __extension__(__builtin_constant_p(e))
 #endif
-- 
2.48.1.vfs.0.0


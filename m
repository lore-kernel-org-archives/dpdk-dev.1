Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C73C36010
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 11:17:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23C7740687;
	Fri, 28 Mar 2025 12:16:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 6C0494066A;
 Fri, 28 Mar 2025 12:16:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743160598; x=1774696598;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3xoepa9QqiNxMZPc7r86JOirzXIoIjElWrylIbN40u4=;
 b=iGB8a84woHmQ7Cqj+4+dymtEl/rGx7CMBF20uJArdRivuqs7y2UGx9q8
 bOWVMVDqx+RQ/VHKWsBmoKnW53szQB2flm0vfrd7v1d3k7cjKYw/HtnNa
 wnld9jx/fU8nUYricx9H29Gg+7srAofVE8ChfZI6KyibxVuyOgZ/t9l4q
 bG+OPbCNJuWb0ewZrMCREwilk0HPdaXjyk8IWPIXRjbGHHuwlptr3zmcX
 nEx0CJRNRnJtksK5A+Coeog6KhaZLYYexGAHcC4KV0mF5t1C24eE6SBuQ
 nFPGMbF4EvoIoQRKVe7DafdRsPB2YHe/XqiyvhyENs9+wN6wdZ4O0r8vw Q==;
X-CSE-ConnectionGUID: Mf3o0fDhR2Wtluq0D2yiJw==
X-CSE-MsgGUID: PyJA1567Q3+x+gwqJuL1iA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44435470"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="44435470"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 04:16:37 -0700
X-CSE-ConnectionGUID: BWHH5dx7SCquLrlH8qMoaA==
X-CSE-MsgGUID: wGUX4ChOTXeBJPIf2a9RPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="125423300"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa006.jf.intel.com with ESMTP; 28 Mar 2025 04:16:35 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: David Marchand <david.marchand@redhat.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: [PATCH v4 5/9] net/ixgbe/base: fix lock checker errors
Date: Fri, 28 Mar 2025 11:16:17 +0000
Message-ID: <20250328111621.2665257-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328111621.2665257-1-bruce.richardson@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250328111621.2665257-1-bruce.richardson@intel.com>
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

When building on FreeBSD, errors are reported in the base code by the
lock checker (-Wthread-safety). For example:

../drivers/net/intel/ixgbe/base/ixgbe_osdep.c:42:1: error: mutex 'lock->mutex' is still held at the end of function [-Werror,-Wthread-safety-analysis]
   42 | }
      | ^

These errors are due to the checker not recognising the lock wrapper
functions. We can avoid these errors by converting these functions into
macros. While converting the lock macros, we can also convert the memory
allocation functions too, which allows us to remove the osdep.c file
entirely from the build.

Fixes: 30b19d1b5c43 ("net/ixgbe/base: add definitions for E610")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ixgbe/base/ixgbe_osdep.c | 47 ----------------------
 drivers/net/intel/ixgbe/base/ixgbe_osdep.h | 18 +++++----
 drivers/net/intel/ixgbe/base/meson.build   |  1 -
 3 files changed, 10 insertions(+), 56 deletions(-)
 delete mode 100644 drivers/net/intel/ixgbe/base/ixgbe_osdep.c

diff --git a/drivers/net/intel/ixgbe/base/ixgbe_osdep.c b/drivers/net/intel/ixgbe/base/ixgbe_osdep.c
deleted file mode 100644
index d3d7e8e116..0000000000
--- a/drivers/net/intel/ixgbe/base/ixgbe_osdep.c
+++ /dev/null
@@ -1,47 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2024 Intel Corporation
- */
-
-#include <stdlib.h>
-
-#include <rte_common.h>
-
-#include "ixgbe_osdep.h"
-
-void *
-ixgbe_calloc(struct ixgbe_hw __rte_unused *hw, size_t count, size_t size)
-{
-	return malloc(count * size);
-}
-
-void *
-ixgbe_malloc(struct ixgbe_hw __rte_unused *hw, size_t size)
-{
-	return malloc(size);
-}
-
-void
-ixgbe_free(struct ixgbe_hw __rte_unused *hw, void *addr)
-{
-	free(addr);
-}
-
-void ixgbe_init_lock(struct ixgbe_lock *lock)
-{
-	pthread_mutex_init(&lock->mutex, NULL);
-}
-
-void ixgbe_destroy_lock(struct ixgbe_lock *lock)
-{
-	pthread_mutex_destroy(&lock->mutex);
-}
-
-void ixgbe_acquire_lock(struct ixgbe_lock *lock)
-{
-	pthread_mutex_lock(&lock->mutex);
-}
-
-void ixgbe_release_lock(struct ixgbe_lock *lock)
-{
-	pthread_mutex_unlock(&lock->mutex);
-}
diff --git a/drivers/net/intel/ixgbe/base/ixgbe_osdep.h b/drivers/net/intel/ixgbe/base/ixgbe_osdep.h
index 398c38bffd..53d0422193 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_osdep.h
+++ b/drivers/net/intel/ixgbe/base/ixgbe_osdep.h
@@ -11,6 +11,8 @@
 #include <stdio.h>
 #include <stdarg.h>
 #include <stdbool.h>
+#include <malloc.h>
+
 #include <rte_common.h>
 #include <rte_debug.h>
 #include <rte_cycles.h>
@@ -50,7 +52,7 @@
 #define false               0
 #define true                1
 #ifndef RTE_EXEC_ENV_WINDOWS
-#define min(a,b)	RTE_MIN(a,b) 
+#define min(a,b)	RTE_MIN(a,b)
 #endif
 
 #define EWARN(hw, S, ...)         DEBUGOUT1(S, ##__VA_ARGS__)
@@ -163,13 +165,13 @@ struct ixgbe_lock {
 	pthread_mutex_t mutex;
 };
 
-void *ixgbe_calloc(struct ixgbe_hw *hw, size_t count, size_t size);
-void *ixgbe_malloc(struct ixgbe_hw *hw, size_t size);
-void ixgbe_free(struct ixgbe_hw *hw, void *addr);
+#define ixgbe_calloc(hw, c, s) ((void)hw, calloc(c, s))
+#define ixgbe_malloc(hw, s) ((void)hw, malloc(s))
+#define ixgbe_free(hw, a) ((void)hw, free(a))
 
-void ixgbe_init_lock(struct ixgbe_lock *lock);
-void ixgbe_destroy_lock(struct ixgbe_lock *lock);
-void ixgbe_acquire_lock(struct ixgbe_lock *lock);
-void ixgbe_release_lock(struct ixgbe_lock *lock);
+#define ixgbe_init_lock(lock) pthread_mutex_init(&(lock)->mutex, NULL)
+#define ixgbe_destroy_lock(lock) pthread_mutex_destroy(&(lock)->mutex)
+#define ixgbe_acquire_lock(lock) pthread_mutex_lock(&(lock)->mutex)
+#define ixgbe_release_lock(lock)	pthread_mutex_unlock(&(lock)->mutex)
 
 #endif /* _IXGBE_OS_H_ */
diff --git a/drivers/net/intel/ixgbe/base/meson.build b/drivers/net/intel/ixgbe/base/meson.build
index 64e0bfd7be..2af8a55e92 100644
--- a/drivers/net/intel/ixgbe/base/meson.build
+++ b/drivers/net/intel/ixgbe/base/meson.build
@@ -12,7 +12,6 @@ sources = [
         'ixgbe_e610.c',
         'ixgbe_hv_vf.c',
         'ixgbe_mbx.c',
-        'ixgbe_osdep.c',
         'ixgbe_phy.c',
         'ixgbe_vf.c',
         'ixgbe_x540.c',
-- 
2.45.2


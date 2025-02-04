Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70855C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 18:55:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B9FC402F1;
	Tue,  4 Feb 2025 19:54:42 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 926FA400D6
 for <dev@dpdk.org>; Tue,  4 Feb 2025 19:54:36 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 090AB210C317; Tue,  4 Feb 2025 10:54:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 090AB210C317
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738695275;
 bh=K9WbGzwW0u4dl4hAUaee6yoC6zWGz2mcQLNEzNM7GAM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sd/RCoBP+9yWnusrtP2MERFnaYrlsHm879uxzKZlWP2dg2MOUvBDL+o7fb2/TT0jV
 AfiVavWpttuVjrmc8Hcl8Dr0VWaW3ccMp0TLAYJKwWb3mxgOe1RerrsK7oJSb2NjRH
 kkpI/h4ZNkty3tUSDuaay5ACtoKNjr1bALMX9rg4=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v4 6/7] drivers/raw: eliminate dependency on non-portable
 __SIZEOF_LONG__
Date: Tue,  4 Feb 2025 10:54:30 -0800
Message-Id: <1738695271-29948-7-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738695271-29948-1-git-send-email-andremue@linux.microsoft.com>
References: <1733342995-3722-2-git-send-email-andremue@linux.microsoft.com>
 <1738695271-29948-1-git-send-email-andremue@linux.microsoft.com>
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

Macro __SIZEOF_LONG__ is not standardized and MSVC does not define it.
Therefore the errors below are seen with MSVC:

../lib/mldev/mldev_utils_scalar.c(465): error C2065:
    '__SIZEOF_LONG__': undeclared identifier
../lib/mldev/mldev_utils_scalar.c(478): error C2051:
    case expression not constant

../lib/mldev/mldev_utils_scalar_bfloat16.c(33): error C2065:
    '__SIZEOF_LONG__': undeclared identifier
../lib/mldev/mldev_utils_scalar_bfloat16.c(49): error C2051:
    case expression not constant

Turns out that the places where __SIZEOF_LONG__ is currently
being used can equally well use sizeof(long) instead.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/raw/ifpga/base/opae_osdep.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/raw/ifpga/base/opae_osdep.h b/drivers/raw/ifpga/base/opae_osdep.h
index e35a21c80e..af61716f61 100644
--- a/drivers/raw/ifpga/base/opae_osdep.h
+++ b/drivers/raw/ifpga/base/opae_osdep.h
@@ -9,6 +9,8 @@
 #include <stdbool.h>
 #include <pthread.h>
 
+#include <rte_common.h>
+
 #ifdef RTE_LIB_EAL
 #include "osdep_rte/osdep_generic.h"
 #else
@@ -30,12 +32,6 @@ struct uuid {
 };
 
 #ifndef LINUX_MACROS
-#ifndef BITS_PER_LONG
-#define BITS_PER_LONG	(__SIZEOF_LONG__ * 8)
-#endif
-#ifndef BITS_PER_LONG_LONG
-#define BITS_PER_LONG_LONG  (__SIZEOF_LONG_LONG__ * 8)
-#endif
 #ifndef BIT
 #define BIT(a) (1UL << (a))
 #endif /* BIT */
@@ -43,11 +39,11 @@ struct uuid {
 #define BIT_ULL(a) (1ULL << (a))
 #endif /* BIT_ULL */
 #ifndef GENMASK
-#define GENMASK(h, l)	(((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+#define GENMASK(h, l)	(((~0UL) << (l)) & (~0UL >> (RTE_BITS_PER_LONG - 1 - (h))))
 #endif /* GENMASK */
 #ifndef GENMASK_ULL
 #define GENMASK_ULL(h, l) \
-	(((~0ULL) << (l)) & (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
+	(((~0ULL) << (l)) & (~0ULL >> (RTE_BITS_PER_LONG_LONG - 1 - (h))))
 #endif /* GENMASK_ULL */
 #endif /* LINUX_MACROS */
 
-- 
2.47.2.vfs.0.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865D2C282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 14:34:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FBF4402E7;
	Fri, 14 Mar 2025 15:34:03 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id D0D0B40289
 for <dev@dpdk.org>; Fri, 14 Mar 2025 15:33:59 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 16011203344E; Fri, 14 Mar 2025 07:33:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16011203344E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741962839;
 bh=ee/G0QMm/jDAxlVpViO5MV6ZM42+EMq228m0cKfKhD8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k9t6nbZ8b6j81wU0MELvm3VaPXGL7Uk2IJiyndFuqNfJlhBZEnQ/06VGnVHsCBRxY
 +/ZdNymlmxMGp12D22NMDsPpx8N/4ppQJDC8kK/jKGEsbnPhZYdQitvLmi8W303i2t
 DmcdzNypTFrdCcJFl4kOuDiCoeTAg11vsCG4KV64=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	mb@smartsharesystems.com
Subject: [PATCH v5 2/3] net/intel: use portable version of
 __builtin_add_overflow
Date: Fri, 14 Mar 2025 07:33:39 -0700
Message-Id: <1741962820-27123-3-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741962820-27123-1-git-send-email-andremue@linux.microsoft.com>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1741962820-27123-1-git-send-email-andremue@linux.microsoft.com>
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

__builtin_add_overflow is gcc specific. It should be replaced with
a portable version that can also be used with other compilers.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/net/intel/ice/base/ice_osdep.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_osdep.h b/drivers/net/intel/ice/base/ice_osdep.h
index 7b96fcde03..e6c5512430 100644
--- a/drivers/net/intel/ice/base/ice_osdep.h
+++ b/drivers/net/intel/ice/base/ice_osdep.h
@@ -14,6 +14,7 @@
 #include <stdbool.h>
 
 #include <rte_common.h>
+#include <rte_math.h>
 #include <rte_memcpy.h>
 #include <rte_malloc.h>
 #include <rte_memzone.h>
@@ -128,6 +129,10 @@ writeq(uint64_t value, volatile void *addr)
 #define wr64(a, reg, value) writeq((value), (a)->hw_addr + (reg))
 #define rd64(a, reg)        readq((a)->hw_addr + (reg))
 
+#ifdef RTE_TOOLCHAIN_MSVC
+#define __builtin_add_overflow rte_add_overflow
+#endif
+
 #endif /* __INTEL_NET_BASE_OSDEP__ */
 
 #ifndef __always_unused
-- 
2.48.1.vfs.0.1


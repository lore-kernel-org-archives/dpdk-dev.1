Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DA5C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 18:54:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30987402EB;
	Tue,  4 Feb 2025 19:54:41 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id EB08C40288
 for <dev@dpdk.org>; Tue,  4 Feb 2025 19:54:35 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id D8AD52054925; Tue,  4 Feb 2025 10:54:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D8AD52054925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738695274;
 bh=x2D2pDb9A9yJZ/2q5mHmfZRZ1Cyf9hSLA7IJ0x8VmdA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZBx6DzugDtlaEtGrY5M00xLKk9lBfccvi0OqaggFtFuHuW90/6qNYwyrR5LTlP/z8
 nBRqNExffOfTvlmhSqD5DEB0P/+81gYiExcP2x62OokiK3bVX2oK/6jYmaBfA2SQXR
 LUrWTBm/MWBcksaqxO8JcaQzU8lwyNQbtbwfeaNs=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v4 3/7] drivers/common: eliminate dependency on non-portable
 __SIZEOF_LONG__
Date: Tue,  4 Feb 2025 10:54:27 -0800
Message-Id: <1738695271-29948-4-git-send-email-andremue@linux.microsoft.com>
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
Acked-by: Chaoyong He <chaoyong.he@corigine.com>
---
 drivers/common/cnxk/cnxk_security_ar.h |  4 ++--
 drivers/common/cnxk/roc_bits.h         | 13 ++++---------
 drivers/common/cnxk/roc_ie_ot.h        |  4 ++--
 drivers/common/cnxk/roc_ie_ot_tls.h    |  5 +++--
 drivers/common/cnxk/roc_platform.h     |  2 ++
 drivers/common/nfp/nfp_platform.h      |  8 +++-----
 6 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/common/cnxk/cnxk_security_ar.h b/drivers/common/cnxk/cnxk_security_ar.h
index d0151a752c..9e88d0063b 100644
--- a/drivers/common/cnxk/cnxk_security_ar.h
+++ b/drivers/common/cnxk/cnxk_security_ar.h
@@ -13,8 +13,8 @@
 
 /* u64 array size to fit anti replay window bits */
 #define AR_WIN_ARR_SZ                                                          \
-	(PLT_ALIGN_CEIL(CNXK_ON_AR_WIN_SIZE_MAX + 1, BITS_PER_LONG_LONG) /     \
-	 BITS_PER_LONG_LONG)
+	(PLT_ALIGN_CEIL(CNXK_ON_AR_WIN_SIZE_MAX + 1, PLT_BITS_PER_LONG_LONG) /     \
+	 PLT_BITS_PER_LONG_LONG)
 
 #define WORD_SHIFT 6
 #define WORD_SIZE  (1ULL << WORD_SHIFT)
diff --git a/drivers/common/cnxk/roc_bits.h b/drivers/common/cnxk/roc_bits.h
index 11216d9d63..654e5a85d7 100644
--- a/drivers/common/cnxk/roc_bits.h
+++ b/drivers/common/cnxk/roc_bits.h
@@ -5,6 +5,8 @@
 #ifndef _ROC_BITS_H_
 #define _ROC_BITS_H_
 
+#include <rte_common.h>
+
 #ifndef BIT_ULL
 #define BIT_ULL(nr) (1ULL << (nr))
 #endif
@@ -13,20 +15,13 @@
 #define BIT(nr) (1UL << (nr))
 #endif
 
-#ifndef BITS_PER_LONG
-#define BITS_PER_LONG (__SIZEOF_LONG__ * 8)
-#endif
-#ifndef BITS_PER_LONG_LONG
-#define BITS_PER_LONG_LONG (__SIZEOF_LONG_LONG__ * 8)
-#endif
-
 #ifndef GENMASK
-#define GENMASK(h, l) (((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+#define GENMASK(h, l) (((~0UL) << (l)) & (~0UL >> (PLT_BITS_PER_LONG - 1 - (h))))
 #endif
 #ifndef GENMASK_ULL
 #define GENMASK_ULL(h, l)                                                      \
 	(((~0ULL) - (1ULL << (l)) + 1) &                                       \
-	 (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
+	 (~0ULL >> (PLT_BITS_PER_LONG_LONG - 1 - (h))))
 #endif
 
 #endif /* _ROC_BITS_H_ */
diff --git a/drivers/common/cnxk/roc_ie_ot.h b/drivers/common/cnxk/roc_ie_ot.h
index 1420e3d586..bfefe792b0 100644
--- a/drivers/common/cnxk/roc_ie_ot.h
+++ b/drivers/common/cnxk/roc_ie_ot.h
@@ -168,8 +168,8 @@ roc_ie_ot_ucc_is_success(uint8_t ucc)
 
 /* u64 array size to fit anti replay window bits */
 #define ROC_AR_WINBITS_SZ                                                      \
-	(PLT_ALIGN_CEIL(ROC_AR_WIN_SIZE_MAX, BITS_PER_LONG_LONG) /             \
-	 BITS_PER_LONG_LONG)
+	(PLT_ALIGN_CEIL(ROC_AR_WIN_SIZE_MAX, PLT_BITS_PER_LONG_LONG) /         \
+	 PLT_BITS_PER_LONG_LONG)
 
 #define ROC_IPSEC_ERR_RING_MAX_ENTRY 65536
 
diff --git a/drivers/common/cnxk/roc_ie_ot_tls.h b/drivers/common/cnxk/roc_ie_ot_tls.h
index 2d6a290d9b..ff86bcb877 100644
--- a/drivers/common/cnxk/roc_ie_ot_tls.h
+++ b/drivers/common/cnxk/roc_ie_ot_tls.h
@@ -13,8 +13,9 @@
 #define ROC_IE_OT_TLS_LOG_MIN_AR_WIN_SIZE_M1 5
 
 /* u64 array size to fit anti replay window bits */
-#define ROC_IE_OT_TLS_AR_WINBITS_SZ                                                                \
-	(PLT_ALIGN_CEIL(ROC_IE_OT_TLS_AR_WIN_SIZE_MAX, BITS_PER_LONG_LONG) / BITS_PER_LONG_LONG)
+#define ROC_IE_OT_TLS_AR_WINBITS_SZ                                               \
+	(PLT_ALIGN_CEIL(ROC_IE_OT_TLS_AR_WIN_SIZE_MAX, PLT_BITS_PER_LONG_LONG) /  \
+	PLT_BITS_PER_LONG_LONG)
 
 /* CN10K TLS opcodes */
 #define ROC_IE_OT_TLS_MAJOR_OP_RECORD_ENC   0x16UL
diff --git a/drivers/common/cnxk/roc_platform.h b/drivers/common/cnxk/roc_platform.h
index 1eb54446a8..1ed03430f9 100644
--- a/drivers/common/cnxk/roc_platform.h
+++ b/drivers/common/cnxk/roc_platform.h
@@ -58,6 +58,8 @@
 #define PLT_ALIGN		 RTE_ALIGN
 #define PLT_ALIGN_MUL_CEIL	 RTE_ALIGN_MUL_CEIL
 #define PLT_MODEL_MZ_NAME	 "roc_model_mz"
+#define PLT_BITS_PER_LONG	 RTE_BITS_PER_LONG
+#define PLT_BITS_PER_LONG_LONG	 RTE_BITS_PER_LONG_LONG
 #define PLT_CACHE_LINE_SIZE	 RTE_CACHE_LINE_SIZE
 #define BITMASK_ULL		 GENMASK_ULL
 #define PLT_ALIGN_CEIL		 RTE_ALIGN_CEIL
diff --git a/drivers/common/nfp/nfp_platform.h b/drivers/common/nfp/nfp_platform.h
index 0b02fcf1e8..e34781a88d 100644
--- a/drivers/common/nfp/nfp_platform.h
+++ b/drivers/common/nfp/nfp_platform.h
@@ -9,19 +9,17 @@
 #include <stdint.h>
 
 #include <rte_bitops.h>
+#include <rte_common.h>
 
 #define DIV_ROUND_UP(n, d)             (((n) + (d) - 1) / (d))
 
 #define DMA_BIT_MASK(n)    ((1ULL << (n)) - 1)
 
-#define BITS_PER_LONG      (__SIZEOF_LONG__ * 8)
-#define BITS_PER_LONG_LONG (__SIZEOF_LONG_LONG__ * 8)
-
 #define GENMASK(h, l) \
-	((~0UL << (l)) & (~0UL >> (BITS_PER_LONG - (h) - 1)))
+	((~0UL << (l)) & (~0UL >> (RTE_BITS_PER_LONG - (h) - 1)))
 
 #define GENMASK_ULL(h, l) \
-	((~0ULL << (l)) & (~0ULL >> (BITS_PER_LONG_LONG - (h) - 1)))
+	((~0ULL << (l)) & (~0ULL >> (RTE_BITS_PER_LONG_LONG - (h) - 1)))
 
 #define __bf_shf(x) rte_bsf64(x)
 
-- 
2.47.2.vfs.0.1


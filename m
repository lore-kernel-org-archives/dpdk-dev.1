Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E254C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 18:54:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0931F402E6;
	Tue,  4 Feb 2025 19:54:40 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id CD53440268
 for <dev@dpdk.org>; Tue,  4 Feb 2025 19:54:35 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id E4C002054926; Tue,  4 Feb 2025 10:54:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E4C002054926
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738695274;
 bh=P1QGJoWG+spNMbHHvZcZrfxtzPUaNB6VcncOpmVpNeo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PXgTD472yIq0/wxLEGk6YhYzEB5trvQMPUTZ88LSUuXv8IJ/PdblrSQn+2+RLV8WN
 3HSsJgqSpCveReaf2yM7sB8XPruFdLomqBmnIEB8snsbTW/JcFGFqOXoWToeFTWLQr
 sKcanXxIv86nRCHAJEZrZ/riZ5r4uL5etA/AhM/w=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v4 4/7] drivers/dma: eliminate dependency on non-portable
 __SIZEOF_LONG__
Date: Tue,  4 Feb 2025 10:54:28 -0800
Message-Id: <1738695271-29948-5-git-send-email-andremue@linux.microsoft.com>
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
 drivers/dma/dpaa/dpaa_qdma.h        | 3 +--
 drivers/dma/hisilicon/hisi_dmadev.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dpaa/dpaa_qdma.h b/drivers/dma/dpaa/dpaa_qdma.h
index 0b08909221..c017bec48f 100644
--- a/drivers/dma/dpaa/dpaa_qdma.h
+++ b/drivers/dma/dpaa/dpaa_qdma.h
@@ -14,9 +14,8 @@
 #define RETRIES	5
 
 #ifndef GENMASK
-#define BITS_PER_LONG	(__SIZEOF_LONG__ * 8)
 #define GENMASK(h, l) \
-		(((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+		(((~0UL) << (l)) & (~0UL >> (RTE_BITS_PER_LONG - 1 - (h))))
 #endif
 
 #define QDMA_CTRL_REGION_OFFSET 0
diff --git a/drivers/dma/hisilicon/hisi_dmadev.h b/drivers/dma/hisilicon/hisi_dmadev.h
index 786fe3cc0e..d1b4ae7da8 100644
--- a/drivers/dma/hisilicon/hisi_dmadev.h
+++ b/drivers/dma/hisilicon/hisi_dmadev.h
@@ -12,9 +12,8 @@
 #include <rte_dmadev_pmd.h>
 
 #define BIT(x)	(1ul << (x))
-#define BITS_PER_LONG	(__SIZEOF_LONG__ * 8)
 #define GENMASK(h, l) \
-		(((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+		(((~0UL) << (l)) & (~0UL >> (RTE_BITS_PER_LONG - 1 - (h))))
 #define BF_SHF(x) rte_bsf64(x)
 #define FIELD_GET(mask, reg) \
 		((typeof(mask))(((reg) & (mask)) >> BF_SHF(mask)))
-- 
2.47.2.vfs.0.1


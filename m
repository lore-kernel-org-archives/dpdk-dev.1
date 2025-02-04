Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AABC02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 18:55:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E37D40611;
	Tue,  4 Feb 2025 19:54:44 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 92B354025F
 for <dev@dpdk.org>; Tue,  4 Feb 2025 19:54:36 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id F10DA2054928; Tue,  4 Feb 2025 10:54:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F10DA2054928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738695274;
 bh=55+mhaD2WtYTNhJJ8h7nYwLY/wVmfFrCNTIHnjV9MdI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P0LEmO8ihr3Qa5lv2u7CMOvk9t8WCw4SkhNuhXFKs8cVzwF/b/+avHgLU2MhR2uTu
 jC3lFft+hBe8m1ZsI1KDzZGJfefMYUcclmToh3JBaJ9Jgc0efqgpYNqgjJmjzxW7ES
 yB+TyLBvwYTiN38bMKjzxxLu4MmvgzPksarfGGGE=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v4 5/7] drivers/net: eliminate dependency on non-portable
 __SIZEOF_LONG__
Date: Tue,  4 Feb 2025 10:54:29 -0800
Message-Id: <1738695271-29948-6-git-send-email-andremue@linux.microsoft.com>
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
 drivers/net/ena/base/ena_plat_dpdk.h | 6 ++----
 drivers/net/hns3/hns3_ethdev.h       | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ena/base/ena_plat_dpdk.h b/drivers/net/ena/base/ena_plat_dpdk.h
index 3b574f888a..8ab1442c22 100644
--- a/drivers/net/ena/base/ena_plat_dpdk.h
+++ b/drivers/net/ena/base/ena_plat_dpdk.h
@@ -97,14 +97,12 @@ extern int ena_logtype_com;
 #define ENA_MIN16(x, y) ENA_MIN_T(uint16_t, (x), (y))
 #define ENA_MIN8(x, y) ENA_MIN_T(uint8_t, (x), (y))
 
-#define BITS_PER_LONG_LONG (__SIZEOF_LONG_LONG__ * 8)
 #define U64_C(x) x ## ULL
 #define BIT(nr)	RTE_BIT32(nr)
 #define BIT64(nr)	RTE_BIT64(nr)
-#define BITS_PER_LONG	(__SIZEOF_LONG__ * 8)
-#define GENMASK(h, l)	(((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+#define GENMASK(h, l)	(((~0UL) << (l)) & (~0UL >> (RTE_BITS_PER_LONG - 1 - (h))))
 #define GENMASK_ULL(h, l) (((~0ULL) - (1ULL << (l)) + 1) &		       \
-			  (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
+			  (~0ULL >> (RTE_BITS_PER_LONG_LONG - 1 - (h))))
 
 #define ena_trc_log(dev, level, fmt, ...)				       \
 	(								       \
diff --git a/drivers/net/hns3/hns3_ethdev.h b/drivers/net/hns3/hns3_ethdev.h
index 7824503bb8..c7ad9a61c7 100644
--- a/drivers/net/hns3/hns3_ethdev.h
+++ b/drivers/net/hns3/hns3_ethdev.h
@@ -952,9 +952,8 @@ static inline struct hns3_vf *HNS3_DEV_HW_TO_VF(struct hns3_hw *hw)
 
 #define BIT_ULL(x) (1ULL << (x))
 
-#define BITS_PER_LONG	(__SIZEOF_LONG__ * 8)
 #define GENMASK(h, l) \
-	(((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+	(((~0UL) << (l)) & (~0UL >> (RTE_BITS_PER_LONG - 1 - (h))))
 
 #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
 #define rounddown(x, y) ((x) - ((x) % (y)))
-- 
2.47.2.vfs.0.1


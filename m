Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931C6CD6E75
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 19:33:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7050D4066E;
	Thu,  4 Jun 2026 21:33:39 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 043BA4066E
 for <dev@dpdk.org>; Thu,  4 Jun 2026 21:33:38 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8203D1400129;
 Thu,  4 Jun 2026 15:33:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 04 Jun 2026 15:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780601617; x=
 1780688017; bh=AMIOLoSVj9nXqKWdQi/SDTOewxzGMrTIn2ydizdbKQw=; b=p
 mdbFYo/HQYdfms7KpeL9/RPsled553cud+h1w/WpM/wRxxk932hPZVkDBN6p++ZO
 aDxfK5cMprFkIA5ZWFdyLpwTKHcZjQh4k4OeF4CK2vxT42MeCKBAjDlLzguhIs51
 sXS0SI3SSGBqrOgirvOXfguWXLNXytOlJB8KglHKtsGOeJQtN8X8mKR/GnR24mWB
 VztVoei/rp5REm8thZeQKhqyhHIFb8gd8l1YMjMqufp8Yzml4JLEWk4L/u6Skewj
 T1MiZoQFByEBvJ7Ul/snYE0OSELI7MU5xfxA0m0CgwYwszJJq/rSurUgMZKlcO3f
 eKE4I555CFPyfHDiQOmlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780601617; x=1780688017; bh=A
 MIOLoSVj9nXqKWdQi/SDTOewxzGMrTIn2ydizdbKQw=; b=DwOJ+Vqd6kjgG4bwF
 MkYvLTpHvpoG7aVi64Cexnud/zBS8rNoxt5Q415asPD2N/DlkgwR7KoDGuX2PUvh
 ne4FbLdhYERKe0V2UCPfEEHyLLbNEz3M0vaoq2wAdxafZOTdhuAT6j631JbomsCp
 177rcfPdUDx/J5Z8N94pk4wBgwEuk9gnDrGRdFg3kr6q/PDrHdigpS0hwsPgzWH/
 kihDdjbNde/UDeOuZtxiZZBdX217GYLWI7AHwlgY42lB5KYznfKNT1VbezU9oFhH
 sLpqjlwAzMHFtYVnFsI+sv+Y//rUC87xSvdL4B4nVpk6gl8rIcZJx1Np9ma33RHH
 jNcxA==
X-ME-Sender: <xms:EdMhasTecfHkKlnZuKaZODyglChrwgu-vSFgalatZNQHDXHlmjIT2Q>
 <xme:EdMhalzvB1GVAfRHT9P1q7TssFgj2Br67-ghnCQSStBCm6Pm1FEuR8Yveq_Rlist1
 AApBZpvnDiREMz92ZzsAJD3UoiotNPd94xPkREONLsNTBxHX_LG>
X-ME-Received: <xmr:EdMhasDiAJWMAYszzJd5ZAcqga-H5uUpWvlNlf_F6n4U5BKobq1xIJJAioslrQoxj8fM419Oz0rbKH30JcqQbhVSvUKdGbU>
X-ME-Proxy-Cause: dmFkZTFTKjf70F4CfZf0i0IrcnOM4y3sOJ9HAHEu+RcmAz6p+UG1GMSF6nnV0agwB3ynt5
 QY9dd8QfgYMYr5edihn3B4MSqhoa1fvWfpml0Fv2XnT37uyTGEqeu1W/C6Bf4Nk8rPhfG8
 EHSROTbFTHO/SEZX9Tz8fjnEtZCN64hdXUUHeQKgsh/thN/gILTC0Ft9bUCeaaJU2kZft7
 ywXniMP7dv14K06hzhP26/4Mzqb+TwlYAtfBB0ltbiDBP3SclzIbLqq8BdPwvrv3e8VQYC
 YsozftbMHT5nlBTEdC0lfvGJy/OeT2TqUri7YWV+o6fnMeN6GGiTzI3ZSyyxBx5k5v95mb
 zE3sOdI62K5aZ7IiFrCzU2xqYgcNhOMsVhubO/kdVYWfm8TclUyVYu8WQHJ1G5uYY97jg+
 v7hIg6fpBxBxAkvFd6oEy/iepW6dj3IMWPledIcwnXL/U/JLwoShFcgnqdoe/+RHTNty9E
 4VW+XiPaSh21aJjdtHE5ADNhEp01DrmOHiL+2/at09fv+patcR5QFP5mGmfABVBGxMKohI
 UcZVNnpd5FfpsSVKdjNjPM35/5DYhlR2Dy5vqEugPRQUK3IKC43/SxM0qelvjgCsZkaUy/
 XhNRsjSfaFqf6TLvMZIzIwQEGP0hGrt2PZMlBwCr9/Cvv7pc4CD6kyUcoy5w
X-ME-Proxy: <xmx:EdMhahHszPigqX4ar11tLiUJhqIt3rC7VQQbjNwFOgvpBcrhlCdjkQ>
 <xmx:EdMhajOeIfAM4R9NbTLRsrrrtBVq14UJa3aHipPcSb5RGcXTA_EePQ>
 <xmx:EdMhai7jApEWg_XGuyLb0K1h1vAAr3b4Guxgaf_WxwJQ_MVhNUv73A>
 <xmx:EdMhamg-PiqtCf5gT7JojbjtIFKAuXxmhb4EjRWRezZ75929ZkorFw>
 <xmx:EdMhaiKzwk9wNsvemcWQiXuBUIhnRqsewVkOzeWoYyyyDFq1otFn_rCD>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 15:33:36 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v8 4/9] common/mlx5: add null MR functions
Date: Thu,  4 Jun 2026 21:30:56 +0200
Message-ID: <20260604193324.1996141-5-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604193324.1996141-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260604193324.1996141-1-thomas@monjalon.net>
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

From: Gregory Etelson <getelson@nvidia.com>

Add functions to allocate and free a null Memory Region (MR)
using ibverbs on Linux.

There is no implementation for DevX on Windows.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/common/mlx5/linux/mlx5_common_verbs.c | 35 +++++++++++++++++++
 drivers/common/mlx5/mlx5_common_mr.h          |  9 +++++
 drivers/common/mlx5/windows/mlx5_common_os.c  | 16 +++++++++
 3 files changed, 60 insertions(+)

diff --git a/drivers/common/mlx5/linux/mlx5_common_verbs.c b/drivers/common/mlx5/linux/mlx5_common_verbs.c
index 2322d9d033..6d44e1f566 100644
--- a/drivers/common/mlx5/linux/mlx5_common_verbs.c
+++ b/drivers/common/mlx5/linux/mlx5_common_verbs.c
@@ -161,3 +161,38 @@ mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb, mlx5_dereg_mr_t *dereg_mr_cb)
 	*reg_mr_cb = mlx5_common_verbs_reg_mr;
 	*dereg_mr_cb = mlx5_common_verbs_dereg_mr;
 }
+
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_alloc_null_mr)
+struct mlx5_pmd_mr *
+mlx5_os_alloc_null_mr(struct rte_device *dev, void *pd)
+{
+	struct ibv_mr *ibv_mr;
+	struct mlx5_pmd_mr *null_mr;
+
+	null_mr = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*null_mr), 0, dev->numa_node);
+	if (!null_mr)
+		return NULL;
+	ibv_mr = mlx5_glue->alloc_null_mr(pd);
+	if (!ibv_mr) {
+		mlx5_free(null_mr);
+		return NULL;
+	}
+	*null_mr = (struct mlx5_pmd_mr) {
+		.lkey = rte_cpu_to_be_32(ibv_mr->lkey),
+		.addr = ibv_mr->addr,
+		.len = ibv_mr->length,
+		.obj = (void *)ibv_mr,
+	};
+	return null_mr;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_free_null_mr)
+void
+mlx5_os_free_null_mr(struct mlx5_pmd_mr *null_mr)
+{
+	if (!null_mr)
+		return;
+	if (null_mr->obj)
+		claim_zero(mlx5_glue->dereg_mr(null_mr->obj));
+	mlx5_free(null_mr);
+}
diff --git a/drivers/common/mlx5/mlx5_common_mr.h b/drivers/common/mlx5/mlx5_common_mr.h
index cf7c685e9b..00f3d832c3 100644
--- a/drivers/common/mlx5/mlx5_common_mr.h
+++ b/drivers/common/mlx5/mlx5_common_mr.h
@@ -21,6 +21,8 @@
 #include "mlx5_common_mp.h"
 #include "mlx5_common_defs.h"
 
+struct rte_device;
+
 /* mlx5 PMD MR struct. */
 struct mlx5_pmd_mr {
 	uint32_t	     lkey;
@@ -258,6 +260,13 @@ __rte_internal
 void
 mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb, mlx5_dereg_mr_t *dereg_mr_cb);
 
+__rte_internal
+struct mlx5_pmd_mr *
+mlx5_os_alloc_null_mr(struct rte_device *dev, void *pd);
+__rte_internal
+void
+mlx5_os_free_null_mr(struct mlx5_pmd_mr *null_mr);
+
 __rte_internal
 int
 mlx5_mr_mempool_register(struct mlx5_common_device *cdev,
diff --git a/drivers/common/mlx5/windows/mlx5_common_os.c b/drivers/common/mlx5/windows/mlx5_common_os.c
index 16fcc5f9fc..692517a9bf 100644
--- a/drivers/common/mlx5/windows/mlx5_common_os.c
+++ b/drivers/common/mlx5/windows/mlx5_common_os.c
@@ -454,6 +454,22 @@ mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb, mlx5_dereg_mr_t *dereg_mr_cb)
 	*dereg_mr_cb = mlx5_os_dereg_mr;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_alloc_null_mr)
+struct mlx5_pmd_mr *
+mlx5_os_alloc_null_mr(struct rte_device *dev, void *pd)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(pd);
+	return NULL;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_free_null_mr)
+void
+mlx5_os_free_null_mr(struct mlx5_pmd_mr *null_mr)
+{
+	RTE_SET_USED(null_mr);
+}
+
 /*
  * In Windows, no need to wrap the MR, no known issue for it in kernel.
  * Use the regular function to create direct MR.
-- 
2.54.0


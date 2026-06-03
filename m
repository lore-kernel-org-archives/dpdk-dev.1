Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8716CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 18:45:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0969540672;
	Wed,  3 Jun 2026 20:45:21 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 0F3DE4065E
 for <dev@dpdk.org>; Wed,  3 Jun 2026 20:45:20 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 5EF171D00173;
 Wed,  3 Jun 2026 14:45:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 03 Jun 2026 14:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780512319; x=
 1780598719; bh=AMIOLoSVj9nXqKWdQi/SDTOewxzGMrTIn2ydizdbKQw=; b=V
 GgoyM/sjdmt5RMgW0W01IiEVAXJ+usb/dK2k5jtVHoQ1qlhw8rRganPOSE+dRumw
 nlfiEhQIZEyoM+okvLMp1Y/xzpmxhSmUabQobL2lTESxnD4MBBHkSLk+7t5n1Oa6
 //Ou5UXdPWGpAPkDRXTVMHvQXOi9DjHeJcGfV4hU8pQAsb2XekMnEjjRRrgrqACf
 1SUBNUHZIogkrWnkzQFCrn5UNbfJepNNbL4x4kUEkyiiOVWwYDoqdSdyDiLyGLBp
 GQI8FoTozl0iSyqn50unIQS9WOFkOzWcU5MCnxNvcyt0OO8Z4CCWGjqASUJvoo6f
 IUTKo5ZW0vd+wmumcUSJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780512319; x=1780598719; bh=A
 MIOLoSVj9nXqKWdQi/SDTOewxzGMrTIn2ydizdbKQw=; b=A/G1WSlvdqmYQi2ad
 bWu8Bzo6dk0mN//jgyRDB9W4vvc1t24z6u+9BDzSvbqVc+gnWyE2EbXCp9HGucGe
 o+S9UwyIXApIZxFtYfSSCuNvd3y0h2e6u5Awsouj3km7a+1H0sM2mFXrzDLr1Pfk
 DZWVLXz/qB3Fy5iQGRfvm+MQToEjt+mphDzjlbdZefUJ2wDO0tZLINeuCYsRitkd
 x6QyoJG+QDPuXaSuZc57pHVrL3F74GPo8TvWLORoMmWvalApxuIHifzPJWevPvr7
 uCfIFA4TmfhO9Xnp8FfeFqGgylIvqlooYTQmC4l1Z6uJEE/M7e83xi3Dx8Ys0Wqt
 2IfiA==
X-ME-Sender: <xms:P3YgaoY7E0TiTbjApWnbRkp30qPK669OwvlpFio0aI0ocP8FUeyQ2w>
 <xme:P3Ygava56jcFSXHOR0oc-M-fOQoX901bx1Ju_jeQSqxUfLq9i8EMtuQejoXXQztLt
 QAPtWBrg4EeWRqp59zZmiJlO5oUFytPt9P0_p1SkgPI_ks6a89yAQ>
X-ME-Received: <xmr:P3YgalKCj_dE6JofXQN1SJgIkkqr-MtnaFVLI2wyR1rGe9JZGW9guX5G2Cg5RNawM8dvIljGywesk1hTtl0FnZ8z5UAmeg4>
X-ME-Proxy-Cause: dmFkZTGRPVmr02ZOY6TXDg1MuQuWkDVzxAf+LyfdOZgp45gqwdcamVylbKuLph9wZ2TdlD
 xI5e28kpSkM9VWXLY5KLdG09TPzycMHsUl3ib59XLHVAcBaKlGY1iRrbXEpVCcc8lihtrx
 JKbyAU+j8UvGUhYymOUdy8mqQ/Auf7rLKeyGKlPAlSMn50VKdKXdaijnyIddCyrJ2ga6/3
 Brqd+1mQhS4koQ/PkDRqgL1TtFAlsTXQ49Q1gwlUfTkgyVfjCvgPvNeJPmuWC5lLKV+XMS
 aSsrX99LlExkhy6QtvbuchMFLc8MN6WMETJb6M2T9s8K7gGW2Jo315f1o/Jn+GtHxhQ9em
 uzk9qbWEOvZ958x8pfzTNonbrcYj+HfSUVRVF2W2KTJ92/xRJjuOiEX1UvPI2+OoXcjCQl
 /fedDMzYHJ1iawFx+rodWSwJSH3nd1Rj1WBW4uppygxH6hxqKjqWK9x2iWk4x/bwhTCsHT
 dxNM//vC9o/Q78+O0kfVlumHsOAANx9RxoLGC7R0HL/gzQuN3tPFl5A45uXhE65fjTAQOr
 5YTc1SzOimt/yYRFlJ0GmZOntJDPYtHYZljAYSTSRGYZdhkFW46dgmnjn6tRvHsJrU8xqy
 pSdckPIXrYa5rQbWf5f191Aw7OXoD3qbBturtyE119pzWSWpt3jd8H8dveYg
X-ME-Proxy: <xmx:P3YgajsJfMmUChFw6gBrEMZh_VTz7TSbb3j6fU-1c4xEwGCyVlTAEA>
 <xmx:P3YgahXFnG2DPaIkFo4URRIVgFF32leAjXDOkNrf0EejjqFdP-TojQ>
 <xmx:P3Ygamh9uXdrUjIzYhmkz7VOadNv4kqznzu8AbXB6USQR10w84LMuQ>
 <xmx:P3YgahoFBu7_2rDhnaGzxcVky8g3BB8Im_EJ4cRJ7L6hzjVo5y6zpg>
 <xmx:P3YgaowFdERqAyBCbZ7LyCOj1L2KzuLnPRV2SjpKD2J96rt64UgOM04r>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 14:45:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v7 04/10] common/mlx5: add null MR functions
Date: Wed,  3 Jun 2026 20:23:27 +0200
Message-ID: <20260603184503.652030-5-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603184503.652030-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260603184503.652030-1-thomas@monjalon.net>
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


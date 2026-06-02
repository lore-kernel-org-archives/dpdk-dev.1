Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500A0CD6E5D
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:41:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7E3D40670;
	Tue,  2 Jun 2026 23:40:54 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 090B840669
 for <dev@dpdk.org>; Tue,  2 Jun 2026 23:40:53 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5FBB67A00CB;
 Tue,  2 Jun 2026 17:40:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Tue, 02 Jun 2026 17:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780436452; x=
 1780522852; bh=AMIOLoSVj9nXqKWdQi/SDTOewxzGMrTIn2ydizdbKQw=; b=W
 pbf+YWKXUZeSh5pmyAZo1wa590LdVyQSQtm9ZXoP2IY4pCxtal3yy+N4jBTSuaIv
 VCL923v4k0Rn9J7IJWEWVNB3psm2sQXn+5+kNx1ZTnMycQXRTM8UuC7Pv3334qhw
 Lp9zBAotQfyTu/Yrbn8lG4k7qfpufncE+T4u9CRMEeR7IEkDWwR5ExK8KBDy5lWY
 6ze9IQMfbGTGZErb8N8WDucFGPsCNYs3Nt2dI9jKAVpJ8lVD4vXL+MjhZvXbbcLv
 x37T37FoyUAdn4uiQnVDD2eqY2tuXIu+ZOCO4qZZxf2l+GffF+AslHeLGGRAAe+V
 Nb/XV2xjJZ3nOsUUe6quA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780436452; x=1780522852; bh=A
 MIOLoSVj9nXqKWdQi/SDTOewxzGMrTIn2ydizdbKQw=; b=NJyHnGwvwcnghAQdc
 BkSmwqHaJIXw+PTEF8DKUAlU3oQPymH/fNbb8dw//oW9r4Lm7etXlZzLOaHybZYb
 RCmhuF8DmW+nszpbDcRaeJY832ziON10wuU5TCLXSwr93G9e8pc6cNNbPpAJJIt9
 T5zZbXr5WaH7T4DmapwyEFqsREmCYQMZ4kGqu+HzXQpI9Vd5vQ6WSVNxVwhQrXfF
 Z3mxRQMnTo5WZqprhFw+hI+pL6aMX5Y1Y9n8PdkuFiHemnfW1emqhhOn+QHs9kcU
 nmxZJ14BnXtgN9B5P42R+jTqX1aVHW723G07rQo5SvATSCGyJuYeDrBZ3HZFY1Ri
 Aq4GA==
X-ME-Sender: <xms:5E0falWfD_a3DpvTbw7YROK9nsIT7EY4tVFVJ4reQMMp2N4Hxvdh3w>
 <xme:5E0fahkz4UYnT2FhPktTm-w_Y07xUqM6it9sxbr5o7uHYXK2OulidgzLu4GD5VtFo
 BSLMwHSk4WD54d5-N-3egtC6XCp2Rlz9DF-h-se6-4WnrgqkdRN>
X-ME-Received: <xmr:5E0fajmIms2qJ6_RdSq1pfaBsP94TQuF3ZxJ5lUbij6OCvniqu9n4_MDEk6cOk0uuE0gBtN9T-movuezr6Ex6brcz6s_0OQ>
X-ME-Proxy-Cause: dmFkZTGuC7w/dWp/VaQymfNWjoUeIuXpcpj9ejmBpJFb0ZoHs5dMhWUW3+s00YOyVN4PAY
 WYMYdfwBm0w2y8xFZRYOSqD0j5vzuS84UqYOzVeI0zXbzRARalTpXFyCISVAxrVYF/sMZp
 lX8x1NnzNZucLSZYxgWwcWYraMk/nZJjeldcNQ8DGMxz0C3NmnEyAx5fQDxgAID5ZadSaf
 FY935iA3xk6A0wQVrLVyBEic2GykBSkipp3c+fE7NTS1w5j+/NWJyk4mlEJ13H7Lglv3Mo
 Ls4VhBn3HwwKu/sQq2R6gaZGc6K+v001ykAes32CY57bs7UoQfnyUfDYYLvJpvVmaKLuA6
 J+i2YEIMpTDpZV0A8+r6iEoMSC6/CQqkVH2D3U5fH9IAj5EPU4aSnEaVqvREU/o8Q9kzyD
 7yOe9a0fw4RHnVq/UP09+FNTazB9CyetbtfOdT20bSLK0j0zXZ2lYw22IzylvHnf/XNQPz
 wTJ2dk4pZfh4rClfmi/UGBeyCeSkEvzO6FeGUDaHTEPIhg9Adu3prcdTJIuRjFCbOGi9sk
 hLUzGHTG996PlhiLXlLNb/rlFaH00cviqOBSbbGOuPGJxtFXaiFcIZMRAzdBsrld+75nKE
 99/8ejRMzfQ7zAtar3xjgU/VzY7Q5+GCfLNdEdCFczddlUOHHyyYR2LsXzTA
X-ME-Proxy: <xmx:5E0fapYWb5aPQtI6RQqtVwhxSAQFlxmSneS9Z_gJUPpa3u1f6j7EAA>
 <xmx:5E0fatQ2_UhUhyIIcmyEsfEvuNHGhkFKQkSieJTfSX8fesNJjkhmRQ>
 <xmx:5E0faruFDwQkqU0dQ1KPgX8VqfS_ePlYDf8WqWezbPNRwyCA446GVw>
 <xmx:5E0fanEipqBCULUlsyu9wHpopnXCtJEfG-toAkA6JDUZQD0lIuSvjQ>
 <xmx:5E0fakf2lnaxaxZRDGwn8qJtfV4h8xa_HBBkI1K-aPaQyuIpcTSFipnh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 17:40:50 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v5 04/10] common/mlx5: add null MR functions
Date: Tue,  2 Jun 2026 23:38:35 +0200
Message-ID: <20260602214036.3606359-5-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602214036.3606359-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260602214036.3606359-1-thomas@monjalon.net>
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


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FD8CD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 13:35:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB8684065E;
	Fri, 29 May 2026 15:35:40 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id C3ED940662
 for <dev@dpdk.org>; Fri, 29 May 2026 15:35:38 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id F1E901D00089;
 Fri, 29 May 2026 09:35:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 29 May 2026 09:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1780061737; x=
 1780148137; bh=AMIOLoSVj9nXqKWdQi/SDTOewxzGMrTIn2ydizdbKQw=; b=G
 4KYVYc4QxSvrHplm4glys4Co9IxYfVWJrVuaBH8KqsrVLyntjxMxDAOyAb9BTVD9
 e6jBoHHJJYVY07Ech55rhp2mAZ51pj2sBFI9GX6Ubs5auwHpSJg93xeTKoWjL0HG
 +fGhHuiMyCHzxrOrrjUfBTbgNMu9OzxeaFtBs+fiPU/PCYq1cFq/iV4IH/XFaXDF
 Eah5uRBy3V6yy7iCdNi5p35fs1qebXyfpW7kdTH0eKjp/Pka4VRIQYPl5K1Tkrzn
 jzVyTMx6UuQdJohM+dVKDvDV+Loh6ONfEPcfgb4uVmzf2qESawmorMVJ+QBhTXbl
 qpjzSFWi2MQxhqb9vqbxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1780061737; x=1780148137; bh=A
 MIOLoSVj9nXqKWdQi/SDTOewxzGMrTIn2ydizdbKQw=; b=Q9gZwyUlp2tSPrqfy
 Ry9yGMJ3K+vDKZ95+Ls70UlBOxKfKOZ9RucFr+A7Z2PbBqp6A801Ca549FH99fp4
 L608EH9vfvyDcCtrZkr8akBexMrQPE/gh3hRgJVTQ0LYWXlXbzb/oGfacysiVVyN
 79dXSeJwRIMkcTtJ9UUb36KkNwC+uuYaqaVBx7fPn9k0TG7QqktEuVq5kaUX7YJO
 sQqbUc3Rx+v1ApLYmR9krJsy7hNemXsformmh0vevNC/7mYps22nRwzu8xEVi7n/
 q57lJeQ0a7kPGGT7swHXZTdm8rwyuspXGJ36u7SG7y8uWTT8XwEkwbteMmRc061E
 PJUAg==
X-ME-Sender: <xms:KZYZauArrJufTTdMRFOt6l5sg-IZfefkponz_zcUCBTKU-BNAEPkbA>
 <xme:KZYZakjs8YrdEbqWoGpxuF-emUPIEwADp6I0-zHrNIxlFmUIUFWualAEU3hSCqiBy
 zUDqRX2hUIgFP8ZRU036JBdKJO4DD1-VbdGxkXNBHIwvpJeixuXPg>
X-ME-Received: <xmr:KZYZajybbUic3jdSW67jsZG2EpHoEUx8HWMc7_sAwGGSidI43ZCM0iprnqVGHeUk_wZwM5uQJLrcKN_gUuCQdrp3YgqbdOU>
X-ME-Proxy-Cause: dmFkZTGXJwatrNhNqNLCRH/pLA+dHkIonuI0m+X7sFMJYKXZhDqOjvPdmT1h8NOR3lOafJ
 P2XMlC3eXPt3Y18f6P+hEkbEC+vqkS7gemTsEGriIkWdxZAjBy0DpNvOI8evypt9wVrAiO
 wbCGvmrFXeGRvJLH/32E+1K/wvsXkx1ECjRtIq1MrOQPjwIp94FhaFtPf22N3fnGORDtgs
 sF7yhAJ8yof9fqajGcg7Fp4tWdVNG9KYpNcsJWyGggubOzm48g0orQvcUYSg78K4/AedWP
 I2q2PjDjWkyJxO/47tabAJMYMSDNfUqAGca+HCuvkYtDDQbO8EinxjZ5EaMvsSQfHXM0Ig
 YzqsL8rCzBg8Ns9pMnqO35ShxvGzYGNu/wR1d27GjNL8+H/3a/2lGuqliwe3UHEWopwexV
 nT109xqhGgQIJ5yy3x1xwJA2zlOvn65ptonDsWDdl858tbQxRlUN9QSgr7VKj6Wy+ErOhn
 GBKrA+/PvD+fGpndkNVdvT0PG6DvYqEDQHdu0UncusznrBPsDbJycmr5kY32JgjSmXq0/Q
 GaLRUcEnrAqFaJ01Aqllv+uPbzir3zHgBmkYdriUCm6gSg2avDTje+zRc68rJAYze8A5ZX
 olQbdxo0/TscUR7d4TMIDwMm/Inxu0H2P9oepTahMP9myD1/H7NRWRO1aPtw
X-ME-Proxy: <xmx:KZYZat3gJqa6x4XoI8y-437WOlSXfK3WrwsdavPbpXbUgee31cQIrA>
 <xmx:KZYZag8hbiW4oy9ixHvvo6q06BE_1n0LCLErJvZGLcvJRcP_GtCLlA>
 <xmx:KZYZatpC-GoZEVayryLfZqkE-qy5FIMHsccL6bSwMZuG9KCEXnjbRw>
 <xmx:KZYZaqSCPMaond6GnIYeg0IrrQCs7_CNmcgPNkY1K5y7VnQ5zKKHow>
 <xmx:KZYZatn28TJqtyAie48-D-fAhFVIWEvVk6HISJD1YyA7cpR7a2gd9fhm>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 09:35:36 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v4 04/10] common/mlx5: add null MR functions
Date: Fri, 29 May 2026 15:33:58 +0200
Message-ID: <20260529133522.2646044-5-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529133522.2646044-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260529133522.2646044-1-thomas@monjalon.net>
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


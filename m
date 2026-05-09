Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6D8CD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 22:04:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FDA64042E;
	Sun, 10 May 2026 00:04:38 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id A4662402ED
 for <dev@dpdk.org>; Sun, 10 May 2026 00:04:36 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 01EA47A005D;
 Sat,  9 May 2026 18:04:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Sat, 09 May 2026 18:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1778364275; x=
 1778450675; bh=AMIOLoSVj9nXqKWdQi/SDTOewxzGMrTIn2ydizdbKQw=; b=l
 SIqkddfliSxEWEkSE+O3o487yfALgArgYu1F56Paxpc198MRbb1EzCpk2P/JAoGQ
 wNYG3/xomVxQOYGoXFp6OXMRZIl7QZhS5MJ6enrNkt9KI3ynQ083ZDIV8J2zf0dX
 fYzqhPEeRPteFoLzVLzayrTYn4GShn8sC/EemCCCG1Z+vNmQ8TElck7JheTi7WCL
 ECEkn799u3OWUyREjqchvmtW5JgeLl+ebt1AhurD/pdBrsqdHZ7svcErLtAMAPhd
 lCiRKCbXVglJlOpzDyza9nu1iPVFeGpACzkd4nM/OaIJRnjF7fZHsJqGS6op0phD
 ts8T5nFPCsbgS/aY1Qg7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1778364275; x=1778450675; bh=A
 MIOLoSVj9nXqKWdQi/SDTOewxzGMrTIn2ydizdbKQw=; b=ocGOoKCQahPR6m154
 K7/dceNZQ1yDFTZz9EYay3Y6eipEiMWotYImPjWbvSl56Nhd3tWbSMLgsPPnQf7i
 +sOvgoEBCwet9DfPh0GPfmnCNOy59pz4QuHlZgYuivb4cHgs3nklciFO+RKgiSIN
 GzE34O37X59JwQDRWgxGO/UyoF/sxd3yOV4A7FhzRUOVf0z2oUobcI3OKUzwWaL0
 fMF4Aik0SHwRpU7cfztoxnTl/Jrin757RrPI2tiHE1jmx3h094HtxqSColJ8XvBz
 k5+4InRZVHUfdFs5UfsY4xo4BtbEJ7G9PUZyxKhkxhnc5XF8xJpoRs1FC/wAAdUv
 SZGtA==
X-ME-Sender: <xms:c6__aYJVSeZflLkWoU0m-dhrWOV1fenKmbw-GOOC2rTKc8QFjJix2A>
 <xme:c6__aUIynGAfTtQxdutiAGTnlgLQgafH5ngPZhtwK7lbN54V0oXyOtS12aBDr1_dQ
 -jZbNQmMe3WZKofPhH7TyH8qltjT-iubkFxHWQ9WG_jk56QP1jIdQ>
X-ME-Received: <xmr:c6__aa4CRItQ0XBC_Qv9gxpbp5DEZ0fAP-HNyLGtHhR9iYrvk_Uycj0s0YoKVGo6Q-UGbz_7kT7GN6jad1EmT8lcpZBWrU0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegfeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphht
 thhopehgvghtvghlshhonhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepughsohhsnh
 hofihskhhisehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhho
 sehnvhhiughirgdrtghomhdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomh
 dprhgtphhtthhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehsuhgr
 nhhmihhnghhmsehnvhhiughirgdrtghomhdprhgtphhtthhopehmrghtrghnsehnvhhiug
 hirgdrtghomh
X-ME-Proxy: <xmx:c6__aWdYefVYwEonZIaai92snGzZsHd7oVm4F3bNz-AgDhG2UT2SXA>
 <xmx:c6__adECKeKHSRhj8BrojLRkixclgywBNL590Op0xuHaIMV9d4zZhA>
 <xmx:c6__aXSuNghGHfiQGxggtIdnBQAlAH-FRaz7ng8DdD-s18gp50yf4A>
 <xmx:c6__aTavdIxDxbWvk1Hr1bb_bme5mU77Asz9k2qGpnVsTxPME70tsg>
 <xmx:c6__aTgaWt1f4DJWr6U4ulIqsMngo-ge9tJOUfbH0RrFRN4CrnIuujes>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 18:04:34 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v2 04/10] common/mlx5: add null MR functions
Date: Sat,  9 May 2026 23:56:55 +0200
Message-ID: <20260509220356.3679114-5-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509220356.3679114-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260509220356.3679114-1-thomas@monjalon.net>
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


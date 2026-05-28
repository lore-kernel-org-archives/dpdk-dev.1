Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA657CD6E44
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 12:48:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4232F40662;
	Thu, 28 May 2026 14:48:17 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id DCAB440662
 for <dev@dpdk.org>; Thu, 28 May 2026 14:48:15 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 8356DEC00EB;
 Thu, 28 May 2026 08:48:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 28 May 2026 08:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1779972495; x=
 1780058895; bh=AMIOLoSVj9nXqKWdQi/SDTOewxzGMrTIn2ydizdbKQw=; b=n
 fL3ZRrxCWwv0SHwq/BpJfue6ggYwVItuZtWI3HuMth3iK7kUx3HKv3udIzVW0ybJ
 nHrIcN6bnrWm8wKg5XTS9kA7WPegGE76sOc3wgk0GUbTOoM3ZFqqzTCNfKvq4DOg
 NOZ/T+sJQhDHXJeqRrr7hxqdOPCxCV0weS+KIcnAxX6xpuKPFhs5Im6/cvuDvzqz
 eMSOtHIxPl+3Mqa2x0W9GSUATZHu/x0uL5e301Zkcutw41QeBkFlFbvfltDdwYXJ
 cr47DtJUzGTTbXypBbmYoWoL4Rt4lCA0NxOxo7v8bBc/kw/EM+0V2bKKaarE4wtr
 HrQpAT/mF6y3ysZu2NbwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1779972495; x=1780058895; bh=A
 MIOLoSVj9nXqKWdQi/SDTOewxzGMrTIn2ydizdbKQw=; b=Fz77ZG3C2adTWdCFC
 tw7SaPEomXXwwDoSeHuaqWICQasxWxgYwFgOkWLS62qTem+RLIOMzFEmomMfxxj1
 0eiAf67EdEEcPLxf9HNKhXVa0vqJy4d+wPC2Kux3in839CfGd98ShDM/Ap00XNX7
 jzGTgKarv9Qd1jmBm3G/iyU1PkyOtPCRgidLg/KkdQa9kfglP6G7ZDer5M3cXljy
 FgdJecLk6Jz2hpn37IPqqLUs15s7NuVJIt5ESlqqTzfX57csNFkWlZT9BhTHtE5m
 uiocwbPWR88OMoXX9n4SNV/v3ITjS6oGMqWY6KjW4BUYxFOzkHvIBjpLumUkfk9U
 ae9ZQ==
X-ME-Sender: <xms:jzkYaimOf3Zk4SqggSpnkEX9J1CnLcdi0SAwIOyzfaEkykGVloJs7Q>
 <xme:jzkYal1bjIobTgTwk3PHhcCs35PaThmrvvwfu5mZ3MbEpoiZkKvugARPEOI09HB8i
 qldNioiLaabUAoB3aRBt3iIHbfZN3tJC-G9SeZJgmm_tk3uoe7u0w>
X-ME-Received: <xmr:jzkYai3FV3o3c-f9CGiJWhXR6-UtA2hiPz-wKv4vic00xPB4K4L49KiliGEzEvQtHc0Nhr6znzvDKqqg3xoy25E5gqyjyHc>
X-ME-Proxy-Cause: dmFkZTGEI2QspuhGhOaj9hI04ApJLhnlrblkAfzs0n0v5Re6QemrmK0jNnRbJEhH+eN6Dx
 A6nmbdHQ8MjINk4+kuXqY895czNLZrsrVSBJyEfzu2OKpR2bfvXnV4Cbo82wSyfUlE+JNe
 uOgvcYGN1u4fStsbDw79EpWsHOIjcNFLPYmeJUYcFapqbbdRiF86JO/TisAup5w9bElfPy
 DRRWXDbmS59fd+2+H0GLyh/lNGp0wDmzMAgV6WBuoinPmiytapuei90F9KGSdISi2X/69V
 HbzzOHMFLi4+FHY3puRHn6wfahI9ZDjYzmINIei2AiuyJ2WtjK/Cm1wYZhPx4sFENSvnT1
 KOGNIDESUQ9iaCIEorqQN613G0Dk24Jx4DS8he6YkzgawuqqKD041t1KFyR4Aqe4HmnNN3
 evkds4vexDCLWQ4wvEE0KbZgDQ+8s/rPMinrdAu0vwed6C0ZKWm1GoAED9+/w3ETMcUtwJ
 gIcWfNrW9/RAdqUzKXfTArS9+LZHadwdCFTXymRy2DczWdFLCfZOSvB25kxp2i3unFoXKw
 rgBDhj7P3e7IvZzSAbmOOrunThBHoS2LiCqwua8Lg/4QX604DZEmyhya2CSaie+Sbh6VD4
 nSo1XNpA6eecq6Xfwb/0l7RULR/E7xqfttw5fVsXn0Qk2iw7vbK6wghLNuSw
X-ME-Proxy: <xmx:jzkYanpCtfDDNotgXA8epEAtZWbJLRtPPdzjn-fetVSH-ItzorIZEQ>
 <xmx:jzkYaui-fPKZzcbbvvcsR0GE0OAXNS4k56KRjrJb2N4XHsPetvlChw>
 <xmx:jzkYaj9uDo7rVYcfgHrPild3OCcS-32ag8chwcn6xR9uQFvCtBU95g>
 <xmx:jzkYaqW6xTi0PUigYJDPCWHVoMhL9x_jFNsYwiOQbrq8dHIkfMyP7g>
 <xmx:jzkYatI35jPGojZCHp2-dkJSoQTUF629Wk24w93ENT6Op-6QivR7wK8t>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 08:48:14 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v3 04/10] common/mlx5: add null MR functions
Date: Thu, 28 May 2026 14:46:31 +0200
Message-ID: <20260528124758.1984528-5-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528124758.1984528-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260528124758.1984528-1-thomas@monjalon.net>
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


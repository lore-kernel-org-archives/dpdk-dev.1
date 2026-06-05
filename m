Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA095CD6E7E
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 23:35:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80DFD40685;
	Sat,  6 Jun 2026 01:35:18 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id B436A40685
 for <dev@dpdk.org>; Sat,  6 Jun 2026 01:35:17 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4D65D140012B;
 Fri,  5 Jun 2026 19:35:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 05 Jun 2026 19:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780702517; x=
 1780788917; bh=hmw3dMoTuwxA/XrAy3sI+Ks+DzGP8HpOzWly7FCzsAo=; b=P
 9L4GNw80L+NlDpNqg+wmROq9/L+3jFeucF8YikExZDBzJ37icQHs4ipZBn5/twlC
 sa9uJ/LdI0fhxnENJoPHPx0roTyomds+dPc/QkTMjALFuOYsSohrUD3HtiqCHhlf
 qWiXx+jARG4F5413kQ63EmZc+HsA/oc0jPtOY/i9IfzhaU/hiv48CmKrPv8LNPv2
 AVN1QpP7UyVYoSiEiLc6xmK84DrFqxUkV6jqFiDWFx5oLgo8CMGTp1fFEnL68w5G
 YT63PtwReYDDW/l9B9RcDMh0s/1UZSrASJNWBSkthzI4ssD15wlataiCeoxVBLFK
 66xEhcPjD/nqDYRUnPcPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780702517; x=1780788917; bh=h
 mw3dMoTuwxA/XrAy3sI+Ks+DzGP8HpOzWly7FCzsAo=; b=YjO89qpFDU1LK7LVS
 ovZQ7bGa3r9DnMNez3hp8qrc4k6JA7xzAFYicwhNPrNZN/GYDNUD/cm38p0xz9AY
 3cREUhTEw7mXWoyvl8Prht6FF6pVag7ys20y+mdeG281mc9meUYPnWwRE1gkpFI5
 OQEhFrr7wsDzbE6GIzr/OQL3yMJeYaeV5GtVQBF/giJVDc1k6L/pi76RU5S7buTe
 tHJdqBdtfWaW5hesoodKRvfZJWn3a9nvyQU+jNAuoD8igpkQbcE8ZXKyNqRNvvnU
 Ya9nv2ktgpvOuzfIsBV9WACjlMdlrbgK/49TcelRDz0Q6vp/phrUZ5yb754O7zTh
 W/FoQ==
X-ME-Sender: <xms:NV0jamfy-raT8QFO3uHWBWegNPrUqa2D7GbYWZIoSeS_fhuZ7NTA8w>
 <xme:NV0jasO9TQg9YKivx53jU-qOg5bvmtnoGFmUwqmITr1bs7LXtMvHxzLxO39h4_OPg
 GhTNjhye4AnV66wj1qwOUtF6Liz-hFw5ysmMLbfz86wWwvFieZLSA>
X-ME-Received: <xmr:NV0japtOHu6NHoYf4npC7iytlOAaHrT68V9i37iMHppBZQOU0G9YidQ_2lXcJW7xq64ICnQs9GofcOC2AN74CJQXvyBo8PI>
X-ME-Proxy-Cause: dmFkZTEohfhF4JQT6K3lbd4KzlNmOFw4c71Kzeh8msZSXZrwt4LS5VL4TDIcQ3WCgjFzG0
 GqdsfWRK3to8weNrJ060oz/HR+7CxnqzkOtx+F4cEnYcSgItceW/zy4RgKVS6yYQa8JeCn
 2HKyuJK7q+JA8EyKkwKe+Sw5WWKOy/yfVH1o22WMSQjrbPzogw1z3yVPKY3z6wfCuIB1bz
 TsuBu9T36PRD9eToE4ccE/lWC6MupfgTKb1jo+6jhbigFYK2h+kFIbizE1+iXIBf2rhwmE
 2BaURcpCVOn5lwC4TfNZoxMBQAzdaWmB4kaw+YB7nSbQBUi9t8ijUaevNzVil5uPukWiEE
 B9MyLIJ8+2nXeXl+6qRTUzoIksg3vgI57OH9h6kJiYIAgOHXSllYm1yKZJo7dOE8Jjahfg
 BXrjFn422o1+SL58nNhb0oTLuMiJi4lwExOeL6I9ls7tfPbPgyKBH2cVLS3p1sGs0sXYxE
 ZBzAosY1rEg2TjkuWYQ6KSIj/1QZTkH/Qhv+/54sudZvrcZ1ZHzIUs/WUjNkqVLbaZ1nVM
 slG7slFLvfjjUuIi8fXpw4i54f9Kf8NwYYl8vChA0LgplooU/P2HpJGLFGEZqjkNB4+vmh
 jmNdskuAIBIUY7yak4ZqOw6U0dd0+4JZA667rOnC25rYjHQBkcWiMP8/874g
X-ME-Proxy: <xmx:NV0jalCaHrEtxXS5kiTxCsyil4ubKFQvtemR03IMecLMtoDEWTRXrA>
 <xmx:NV0jagZpiRGdwOz-7u0pcC5Jr-L6iWljmML8eZ6TyjH1f0_LwgyjqQ>
 <xmx:NV0jagXR8f6R2j4iZXNNq-9bOpgYC2tHfOPt2xZy6kPJZgHAsNpOnA>
 <xmx:NV0javOs3FYAPSc8n-TTbVEjmit6nZWsC6V9z0TQGIvnWuzt38u-oQ>
 <xmx:NV0jakEB3IMgCiu2qtYG6zue5kxAbyMFaWQUMDdm_YT9kZhqll6Q4Cbu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 19:35:15 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v9 04/10] common/mlx5: add null MR functions
Date: Sat,  6 Jun 2026 01:33:44 +0200
Message-ID: <20260605233456.3017423-5-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605233456.3017423-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260605233456.3017423-1-thomas@monjalon.net>
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
index a3033f5305..fb2bbae578 100644
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


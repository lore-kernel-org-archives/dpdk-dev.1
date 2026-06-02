Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99354CD6E5D
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:50:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A197F4066D;
	Tue,  2 Jun 2026 23:50:43 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 29D6040687
 for <dev@dpdk.org>; Tue,  2 Jun 2026 23:50:42 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 818091D0007D;
 Tue,  2 Jun 2026 17:50:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 02 Jun 2026 17:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780437041; x=
 1780523441; bh=AMIOLoSVj9nXqKWdQi/SDTOewxzGMrTIn2ydizdbKQw=; b=f
 9FGSCg/tYkFvad71XtMTzC86e5udiRESCda0lBMutE/ys/7QUuutTUi5OryZJZLv
 eTZAsR2/H6eI5i8yAPkCAwNA4v/c2OXEeovl2F0+68oGFxTmG8P7UV87OCxJ4uWs
 8mcTpv35yfJ4xNUSss4g9KOKdhnP2qb6Ghb+rqlnWNEifRxOEPnau3AVUz/EyPXb
 IukvL+m4U83np5TvgqQTOuvh2KxbHkMZYfdiqWUwxpDByrRg+dsvyO5foarpju54
 5aayEIEC8LC+hyXKF5nE4R4A8hPI508Ue8SNsySqkXKB6toz3Go/UadvzcXHs+qk
 46I3r1VEEt5c7t9U9s8LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780437041; x=1780523441; bh=A
 MIOLoSVj9nXqKWdQi/SDTOewxzGMrTIn2ydizdbKQw=; b=j6/sybxs4Ix3huR0S
 GKY8LB+vKOkCm/gKp6Mx8vQdDEZJZzwlDdUoGXHPw/4AaJrVPIwArknlK84M2uLc
 jleSRs1Lx+2JpmJeJsSnj+8BQz7iehiAx6AHYwNrZkmwRnSqilzOY94Z27MQDaxX
 urDJWNkv1FCzUvUaOWvoFSXLOVQlt0clrr0N5YL6C1R2VgOkL8wDSPWjo0M7bAwy
 s7jdjEbxKraDUTXldg8INTB/mdMvb/1ziVEgpIv7elBlOYGh4JEIQRgycX9FpgE7
 TsyGyQjN+Id1dhezV650X2GzPZ6/5AkY/icnwEmB8ViJ5D6E3hzWaRqjvA7d2loW
 U928Q==
X-ME-Sender: <xms:MVAfalauoVCTBynmg9n02Ven1mJDo6xpwmwrGEOB7mGyd8MZvISGsw>
 <xme:MVAfaoZ8eMOMy8yTk0wmRv4CaqfPmh1XWJAJyb817-7_tE-rwRj2wQVqowrOZjTsM
 t9JEXCHukBU2hEJGTV0_qpazCnjMYtwEplHrkABNewQJVdxBD-QfQ>
X-ME-Received: <xmr:MVAfaqK5ePxuAqB5N4g9xdl3rwsI8XrSzdkLwmykGJOSSiFsVis2PkqoGI5Js3d-GmxwnP6tQYcbMkcHwwjuZDgpAB6I4t8>
X-ME-Proxy-Cause: dmFkZTEWgN7vY0qxXSIGoPtkqbliCd07gCwDXaAFyfIadDsxG5KTXk0IG937mGINDuISj6
 8siMnQIFFhsky2ekQFCMc7UKygoaWEtPQv0YsVRVJQZTkcLj9V3JN8xn9N2mu+0IDOvEQW
 z4FwTG8ldr00xE6wkuEt636h954PV0JbuIWEJ3F4gG9WbJu14Iak4RZ5GaJ0wkh/VUYmhC
 YvOy0xVJ7ExfY7AFojsN+R4oo0qjAkVzR/cXVqIMHzaAodZeorkqRGCddtkfiBANvl+iFK
 dbTm6sVDPN4283au7Ixy9eoyX58iY90Sk4ApdtDtt/G+LdHsG8TgbrqocCeB3g3GihzIAI
 7c4+VRPIgA1g2OSXbBgX/qKw0UnUTJo1LMfrhf8JRvUwv5uxyN7CZ7qTTN9OFcpQ0q2akt
 d4Tj40OgkBFfBEw5LsutVYxFtx3pXCj+Iii3oBWAsHm4H5RM58gFNf/z6AhoolGIo5HQLh
 3DhlzniooN3n7djptILsbJfc759LWh8CgyShsdN1c7H2elQwe+NngL0x6x024TzfIhR1Sp
 pdov1BMPMHba6TwjM8PgD42a9CtMU9YuX5L1qOlw0bSpvGE54lqSNscqXCcQG/udjkvkPH
 P1rwHdzlT5CFns7XHNwGCxNsdm0XaxTZy+n60NHH59SRWnT5Jo0mINST4+Tw
X-ME-Proxy: <xmx:MVAfakt2OsbBSh_AnJADMqGwrKmbi2Lz3sOnELKPmn9FuURTyXJSGQ>
 <xmx:MVAfauWUbYtkPSGHtNfgM_06yuXvxjqka-wpk2UW9ZaH6p4Aio-rTA>
 <xmx:MVAfavjYFrjOScHhvTLQiYf5N0rUmIghBvVKL80-7MMchkDVrRW5ow>
 <xmx:MVAfamphyX6A-jq-SfEIip-6K73puUrE5jIRRMNswkFTRkF-Q2rPbw>
 <xmx:MVAfapyUityze1VhKVE3wkeNX-XroTVe8TZnED_-GcVRkgAyk8Xmx278>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 17:50:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v6 04/10] common/mlx5: add null MR functions
Date: Tue,  2 Jun 2026 23:49:16 +0200
Message-ID: <20260602215022.3698662-5-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602215022.3698662-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260602215022.3698662-1-thomas@monjalon.net>
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


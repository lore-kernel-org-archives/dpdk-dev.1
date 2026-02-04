Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AD8E9D405
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 15:53:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6553040A67;
	Wed,  4 Feb 2026 16:53:03 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
 by mails.dpdk.org (Postfix) with ESMTP id AAB0740695
 for <dev@dpdk.org>; Wed,  4 Feb 2026 16:53:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rh/9ZA7T17hJAe2swKQQr10nDScmnWcVHu8D2UPHeSAZqbxbd1Qvt+JjbnNyLgBu4VcP8zkRlZk9uU7WxU7/jUFGBqelZJKNDF0PiwaHeU+TciHmBrbOHjYHI3xpn4GczqZjlLLp4CFuzCz5CBUKrFU5aoB9dV6hTasEOAPF4zmzZLRNeRYlMP4Fz6E3LfNzJp07cNPQxKbmn19Ph/7tIiFNMu2+Axn+SQQGAKohQhqdNWmqmvuQaD9V+ujpQ4U2w1M/TvQ3DYqy3K5QZTXOE2xgusCGQio+3sPnXP9tny4L6RIPwMVxZkpSUOX9vcJPdpyRiJskwk3DEA+nT4DIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGhOiwe3bsaNCdu8DSl7lA9wc8wV3saf1ALvRCg/iaA=;
 b=UliApUXbsXi3CZymq5n1hntaR6hTh1GOv0qQmMXNHET9Ja46hxHMabAWLpBzXg7qlqyzWGFlNx6G9GdHZfnN5HUNgQN90eOJVKXPTDsRxQj9mfGNBrY2uQNIEYGlC+y9lWAu3V/oy2d08yKw++8WXbUGzcnADSyplQW2iz5IL6L/hNMj9+CqMVu/ROxMR98Pe8TOQ71J15mILW0Ublr0fsjsRY9siPof0w8hDADtmei/hZKhQEHXxOeLG++kN/etavAWvhdEVtaK5cxcHPObk3+Gknn4y0Trt018o+os+QSm8W60F1GN6f+QRzGS5tYUH3cZKA3wXZa6MskErlAIXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGhOiwe3bsaNCdu8DSl7lA9wc8wV3saf1ALvRCg/iaA=;
 b=aBCOMUIYd8zNFA9xHQ/M3sI64H0S4qlUpz89yRsELrlhohsGUuRo5kAka3VNwUdWE2UvoG3apAoTEJTXJEZ+tey9OXabRDtvFVYkpby3XS+26HZVFH1WM1jXDIJuMIbOJvbqA2flHYLS0bnN1mOCSXkr+zxfRc3M52hjgKAOvIlrq3yNlGzibKUOHz69W3keo5QZq4eWrGL+3357NusNMnnQganfFq4B9DYoDO+ykN11VUPdHXmWE1I4UJOoN4TXPDBMsUc72J/s6BtWPXFPs6LVpXb1fWvecKgL5oaIe/HbbvKEGgjxRagG3UComjVtX9vCY6szo6+aoeuhHcQSpQ==
Received: from BN9PR03CA0243.namprd03.prod.outlook.com (2603:10b6:408:ff::8)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 15:52:52 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::6d) by BN9PR03CA0243.outlook.office365.com
 (2603:10b6:408:ff::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 15:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 15:52:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 07:52:26 -0800
Received: from aerial-hp-5g-02.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Feb 2026 07:52:25 -0800
From: Cliff Burdick <cburdick@nvidia.com>
To: <dev@dpdk.org>
CC: <anatoly.burakov@intel.com>, Thomas Monjalon <thomas@monjalon.net>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH v4 2/2] common/mlx5: support dmabuf
Date: Wed, 4 Feb 2026 15:50:09 +0000
Message-ID: <20260204155206.2345189-3-cburdick@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204155206.2345189-1-cburdick@nvidia.com>
References: <20260203230338.1066297-1-cburdick@nvidia.com>
 <20260204155206.2345189-1-cburdick@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|BL1PR12MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d051db-8b9b-46c2-7712-08de640573a1
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E81y2TCpQz51e1Asa4q5XiXA90LmZkzS2/4GzdamADtUBkWBTLWsRKsBqNEp?=
 =?us-ascii?Q?0Qh8gtIWq0xf8/7LeVhY/xBVgAuSc0Q/sklE4rcmmDM5i48bD6PBtHgF27w7?=
 =?us-ascii?Q?1jf/KWpsvBIG8QA77s7Y/+ObNUlWyr2ba1b+NXcH2y6DXkOjhS6PX394fqic?=
 =?us-ascii?Q?bJMjMbi8/micEZytRvQqyUd9UGMgi2ddNYx/52XoI2r7gTrIvTAPUoUzTEK9?=
 =?us-ascii?Q?/Rv3UQbtdwZ8LBZRT09n7djwShlrsXGG7i2t14UzG9qTudSRhAZcj1Oc8t53?=
 =?us-ascii?Q?kteESJ/D/TzdDaljgd4rI2HJktBDlucwRaoCzGQZHtYwwViFvXL+1ILddyha?=
 =?us-ascii?Q?Be74zLjGnsotsoC+2FUczJhymt2t59A5IosR63UQ/+zEN6frA8ds7O+r3whm?=
 =?us-ascii?Q?UrBF68DO+NUpgixStkn96AbBau6bCQ2fBvAKzwHviVneaNF5EWPr4mz0T6N2?=
 =?us-ascii?Q?0lnd3ApWNSg4t1V2KgigsvbokjkoqKi4afbmSuaj+Xb1h+HZyKIWsI8rAk5z?=
 =?us-ascii?Q?kuYpxXrUPVaIl+NulSdRpmpLeDL2KcQjHWxNug8G+KCEg3Hm8aClotWnPWRk?=
 =?us-ascii?Q?GcWdFJL/Pe7NASbx8hCIe76MzxNRm71MwKrF1c9Clmwp42AoGEnBNxfEuZeZ?=
 =?us-ascii?Q?UOhFPXH5VWglaQuaEF65mA0V6P0fM/O5OeqAD8IhtHJ3tdB8GF//5HFWcNU/?=
 =?us-ascii?Q?JexSM65INUjMNj/P+WJuqlOZzjfSmuIiDqj3lzkoIMjy/ToQVcmrCHpyL/9A?=
 =?us-ascii?Q?eRQODQZxkc5Da9vZmCoo9zymi88mBDokdZcQ2suO0JJVKooiI/d9JPn8ixG2?=
 =?us-ascii?Q?sLQEEw6g21j3W6MLj4En3btmGabYaXGoKMLN/+xhaAXvVJ6pbXkqVT+u8rFN?=
 =?us-ascii?Q?Xfjil9X/Q4mNuPaixzseeIs2HEzU8tSdSf1HmymaCimcXIysuO7mRREojqqT?=
 =?us-ascii?Q?tFrpJL4mEph7NIImOCsSHGGTRWv0Ml3+lnOhpYjfoRfW3/hYKolM3wOqs4bN?=
 =?us-ascii?Q?Ha+pMDXxwiz+mTfIdDRNhSIh4rwlkLsdoZCSiGmnoGNWhv1kpAJvMKYq7r3C?=
 =?us-ascii?Q?jou6KCgizxVBlNywAnuuv1njp8r677U9kJ+9iGpXE8yO8/xXVN05EMS5Tz0r?=
 =?us-ascii?Q?pW642eMiesksA8NnfRwzl0r2DjJEWxaQNS9owh8FlDeAJ9CmZL7j+tqWzUCl?=
 =?us-ascii?Q?09d0Mm/G3C8/+6tGPStvp3LAJSKShbkZZxI7YabsAVnPCn8wWBJZXj3dyaQJ?=
 =?us-ascii?Q?YAlaWEq/USDFFoxhCg+6prFYU20vHFyjgYLi/H0/q0dcXGn9XK3gT58ytKqy?=
 =?us-ascii?Q?tF1Ox29DDVScKQCsa7Fhj0zCy5/XLY08yIw03O6+ZeCdrmjDbWTAZsqrYApg?=
 =?us-ascii?Q?OlPunkNctaYacAimLOJGvjioy8k+WjjIpFH9T+TPkltHzbguOfQV5W/xmLYx?=
 =?us-ascii?Q?quLAMSESYqsr1WmAMV0q8sX3N5VuOj1+3JGU3HJLHriVhgkst5sz/7shmu1X?=
 =?us-ascii?Q?tQSTcoXZzxCQyHY5HzxKxE6gn3lzI1EC7ZsE1bSZR3GfAPHL/7rKbGIuu370?=
 =?us-ascii?Q?OsKEy7H0AVGPJe5P4uP+67vVLhTxZtrilV1qGDQ10hKkHBrvrrZ2CzO5lPJW?=
 =?us-ascii?Q?Grcv0g9JS+X+gC7WY67Ey6ap8lti+TyN1bNaYyBLi+xWuh4CLwzqblgbQ2Nt?=
 =?us-ascii?Q?+cS1WA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uQuaYsKgeWWaRUMDuhs4tTzL691t7H1yGXlpnNkph62wqH0YHFM2gOrJjaarhPnCwAljHyDmlE8T/OsEZ1leZq22FJJDd8uu+MUQsccEh6tieym3oMOkTDhU6KR8tnOHDJQtVn/F8ptoH/sM/B7nmrJCHc1ey5hQYbtbqTYbZXhFl8kQ1/i8ejDan2DLMSDmsZE+LPO3ImFWusi2tXViOARu+2A4oqP97QSJRYUa6GLMC8/G7yZp2EclWjakfFJ0riCmTZ0YyzMnc61X8mBbbgmx9a1NABhzd1qqrKLm4LSTYOAWPdDNjkFmnC1wRW7lSv4MdmJoWWKZoxERySoJdegxZtQ77ItcuE/cj6jO5NSbcxDKlMsZWBaTv8mF6cjDcG5jGfpHTlrjZpKPPWgqrRZmeJzeYD0fN/CDA8iQFf23YI2OqrtS5WqNYxRzr9rV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 15:52:50.8879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d051db-8b9b-46c2-7712-08de640573a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924
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

dmabuf is a modern Linux kernel feature to allow DMA transfers between
two drivers. Common examples of usage are streaming video devices and
NIC to GPU transfers. Prior to dmabuf users had to load proprietary
drivers to expose the DMA mappings. With dmabuf the proprietary drivers
are no longer required.

Signed-off-by: Cliff Burdick <cburdick@nvidia.com>
---
 .mailmap                                      |   2 +-
 drivers/common/mlx5/linux/meson.build         |   2 +
 drivers/common/mlx5/linux/mlx5_common_verbs.c |  48 +++++++-
 drivers/common/mlx5/linux/mlx5_glue.c         |  19 +++
 drivers/common/mlx5/linux/mlx5_glue.h         |   3 +
 drivers/common/mlx5/mlx5_common.c             |  42 ++++++-
 drivers/common/mlx5/mlx5_common_mr.c          | 113 +++++++++++++++++-
 drivers/common/mlx5/mlx5_common_mr.h          |  17 ++-
 drivers/common/mlx5/windows/mlx5_common_os.c  |   8 +-
 drivers/crypto/mlx5/mlx5_crypto.h             |   1 +
 drivers/crypto/mlx5/mlx5_crypto_gcm.c         |   3 +-
 11 files changed, 249 insertions(+), 9 deletions(-)

diff --git a/.mailmap b/.mailmap
index 4c2b2f921d..0a8a67098f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -291,8 +291,8 @@ Cian Ferriter <cian.ferriter@intel.com>
 Ciara Loftus <ciara.loftus@intel.com>
 Ciara Power <ciara.power@intel.com>
 Claire Murphy <claire.k.murphy@intel.com>
-Cliff Burdick <cburdick@nvidia.com>
 Clemens Famulla-Conrad <cfamullaconrad@suse.com>
+Cliff Burdick <cburdick@nvidia.com>
 Cody Doucette <doucette@bu.edu>
 Congwen Zhang <zhang.congwen@zte.com.cn>
 Conor Fogarty <conor.fogarty@intel.com>
diff --git a/drivers/common/mlx5/linux/meson.build b/drivers/common/mlx5/linux/meson.build
index 3767e7a69b..8e83104165 100644
--- a/drivers/common/mlx5/linux/meson.build
+++ b/drivers/common/mlx5/linux/meson.build
@@ -203,6 +203,8 @@ has_sym_args = [
             'mlx5dv_dr_domain_allow_duplicate_rules' ],
         [ 'HAVE_MLX5_IBV_REG_MR_IOVA', 'infiniband/verbs.h',
             'ibv_reg_mr_iova' ],
+        [ 'HAVE_IBV_REG_DMABUF_MR', 'infiniband/verbs.h',
+            'ibv_reg_dmabuf_mr' ],
         [ 'HAVE_MLX5_IBV_IMPORT_CTX_PD_AND_MR', 'infiniband/verbs.h',
             'ibv_import_device' ],
         [ 'HAVE_MLX5DV_DR_ACTION_CREATE_DEST_ROOT_TABLE', 'infiniband/mlx5dv.h',
diff --git a/drivers/common/mlx5/linux/mlx5_common_verbs.c b/drivers/common/mlx5/linux/mlx5_common_verbs.c
index 98260df470..f6d18fd5df 100644
--- a/drivers/common/mlx5/linux/mlx5_common_verbs.c
+++ b/drivers/common/mlx5/linux/mlx5_common_verbs.c
@@ -129,6 +129,47 @@ mlx5_common_verbs_reg_mr(void *pd, void *addr, size_t length,
 	return 0;
 }
 
+/**
+ * Register mr for dma-buf backed memory. Given protection domain pointer,
+ * dma-buf fd, offset and length, register the memory region.
+ *
+ * @param[in] pd
+ *   Pointer to protection domain context.
+ * @param[in] offset
+ *   Offset within the dma-buf.
+ * @param[in] length
+ *   Length of the memory to register.
+ * @param[in] fd
+ *   File descriptor of the dma-buf.
+ * @param[out] pmd_mr
+ *   pmd_mr struct set with lkey, address, length and pointer to mr object
+ *
+ * @return
+ *   0 on successful registration, -1 otherwise
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_common_verbs_reg_dmabuf_mr)
+int
+mlx5_common_verbs_reg_dmabuf_mr(void *pd, uint64_t offset, size_t length,
+				uint64_t iova, int fd,
+				struct mlx5_pmd_mr *pmd_mr)
+{
+	struct ibv_mr *ibv_mr;
+	ibv_mr = mlx5_glue->reg_dmabuf_mr(pd, offset, length, iova, fd,
+					  IBV_ACCESS_LOCAL_WRITE |
+					  (haswell_broadwell_cpu ? 0 :
+					  IBV_ACCESS_RELAXED_ORDERING));
+	if (!ibv_mr)
+		return -1;
+
+	*pmd_mr = (struct mlx5_pmd_mr){
+		.lkey = ibv_mr->lkey,
+		.addr = ibv_mr->addr,
+		.len = ibv_mr->length,
+		.obj = (void *)ibv_mr,
+	};
+	return 0;
+}
+
 /**
  * Deregister mr. Given the mlx5 pmd MR - deregister the MR
  *
@@ -151,13 +192,18 @@ mlx5_common_verbs_dereg_mr(struct mlx5_pmd_mr *pmd_mr)
  *
  * @param[out] reg_mr_cb
  *   Pointer to reg_mr func
+ * @param[out] reg_dmabuf_mr_cb
+ *   Pointer to reg_dmabuf_mr func
  * @param[out] dereg_mr_cb
  *   Pointer to dereg_mr func
  */
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_set_reg_mr_cb)
 void
-mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb, mlx5_dereg_mr_t *dereg_mr_cb)
+mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb,
+		      mlx5_reg_dmabuf_mr_t *reg_dmabuf_mr_cb,
+		      mlx5_dereg_mr_t *dereg_mr_cb)
 {
 	*reg_mr_cb = mlx5_common_verbs_reg_mr;
+	*reg_dmabuf_mr_cb = mlx5_common_verbs_reg_dmabuf_mr;
 	*dereg_mr_cb = mlx5_common_verbs_dereg_mr;
 }
diff --git a/drivers/common/mlx5/linux/mlx5_glue.c b/drivers/common/mlx5/linux/mlx5_glue.c
index a91eaa429d..6fac7f2bcd 100644
--- a/drivers/common/mlx5/linux/mlx5_glue.c
+++ b/drivers/common/mlx5/linux/mlx5_glue.c
@@ -291,6 +291,24 @@ mlx5_glue_reg_mr_iova(struct ibv_pd *pd, void *addr, size_t length,
 #endif
 }
 
+static struct ibv_mr *
+mlx5_glue_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset, size_t length,
+			uint64_t iova, int fd, int access)
+{
+#ifdef HAVE_IBV_REG_DMABUF_MR
+	return ibv_reg_dmabuf_mr(pd, offset, length, iova, fd, access);
+#else
+	(void)pd;
+	(void)offset;
+	(void)length;
+	(void)iova;
+	(void)fd;
+	(void)access;
+	errno = ENOTSUP;
+	return NULL;
+#endif
+}
+
 static struct ibv_mr *
 mlx5_glue_alloc_null_mr(struct ibv_pd *pd)
 {
@@ -1619,6 +1637,7 @@ const struct mlx5_glue *mlx5_glue = &(const struct mlx5_glue) {
 	.modify_qp = mlx5_glue_modify_qp,
 	.reg_mr = mlx5_glue_reg_mr,
 	.reg_mr_iova = mlx5_glue_reg_mr_iova,
+	.reg_dmabuf_mr = mlx5_glue_reg_dmabuf_mr,
 	.alloc_null_mr = mlx5_glue_alloc_null_mr,
 	.dereg_mr = mlx5_glue_dereg_mr,
 	.create_counter_set = mlx5_glue_create_counter_set,
diff --git a/drivers/common/mlx5/linux/mlx5_glue.h b/drivers/common/mlx5/linux/mlx5_glue.h
index 81d6b0aaf9..66216d1194 100644
--- a/drivers/common/mlx5/linux/mlx5_glue.h
+++ b/drivers/common/mlx5/linux/mlx5_glue.h
@@ -219,6 +219,9 @@ struct mlx5_glue {
 	struct ibv_mr *(*reg_mr_iova)(struct ibv_pd *pd, void *addr,
 				      size_t length, uint64_t iova,
 				      int access);
+	struct ibv_mr *(*reg_dmabuf_mr)(struct ibv_pd *pd, uint64_t offset,
+					size_t length, uint64_t iova,
+					int fd, int access);
 	struct ibv_mr *(*alloc_null_mr)(struct ibv_pd *pd);
 	int (*dereg_mr)(struct ibv_mr *mr);
 	struct ibv_counter_set *(*create_counter_set)
diff --git a/drivers/common/mlx5/mlx5_common.c b/drivers/common/mlx5/mlx5_common.c
index 84a93e7dbd..82cf17ca78 100644
--- a/drivers/common/mlx5/mlx5_common.c
+++ b/drivers/common/mlx5/mlx5_common.c
@@ -13,6 +13,7 @@
 #include <rte_class.h>
 #include <rte_malloc.h>
 #include <rte_eal_paging.h>
+#include <rte_memory.h>
 
 #include "mlx5_common.h"
 #include "mlx5_common_os.h"
@@ -1125,6 +1126,7 @@ mlx5_common_dev_dma_map(struct rte_device *rte_dev, void *addr,
 	struct mlx5_common_device *dev;
 	struct mlx5_mr_btree *bt;
 	struct mlx5_mr *mr;
+	struct rte_memseg_list *msl;
 
 	dev = to_mlx5_device(rte_dev);
 	if (!dev) {
@@ -1134,8 +1136,44 @@ mlx5_common_dev_dma_map(struct rte_device *rte_dev, void *addr,
 		rte_errno = ENODEV;
 		return -1;
 	}
-	mr = mlx5_create_mr_ext(dev->pd, (uintptr_t)addr, len,
-				SOCKET_ID_ANY, dev->mr_scache.reg_mr_cb);
+	/* Check if this is dma-buf backed external memory */
+	msl = rte_mem_virt2memseg_list(addr);
+	if (msl != NULL && msl->external) {
+		int dmabuf_fd = rte_memseg_list_get_dmabuf_fd(msl);
+		if (dmabuf_fd >= 0) {
+			uint64_t dmabuf_off;
+			/* Get base offset from memseg list */
+			int ret = rte_memseg_list_get_dmabuf_offset(
+				msl, &dmabuf_off);
+			if (ret < 0) {
+				DRV_LOG(ERR,
+					"Failed to get dma-buf offset for memseg list %p",
+					(void *)msl);
+				return -1;
+			}
+			/* Calculate offset within dma-buf address */
+			dmabuf_off += ((uintptr_t)addr - (uintptr_t)msl->base_va);
+			/* Use dma-buf MR registration */
+			mr = mlx5_create_mr_ext_dmabuf(dev->pd,
+						       (uintptr_t)addr,
+						       len,
+						       SOCKET_ID_ANY,
+						       dmabuf_fd,
+						       dmabuf_off,
+						       dev->mr_scache.reg_dmabuf_mr_cb);
+		} else {
+			/* Use regular MR registration */
+			mr = mlx5_create_mr_ext(dev->pd,
+						(uintptr_t)addr,
+						len,
+						SOCKET_ID_ANY,
+						dev->mr_scache.reg_mr_cb);
+		}
+	} else {
+		/* Use regular MR registration */
+		mr = mlx5_create_mr_ext(dev->pd, (uintptr_t)addr, len,
+					SOCKET_ID_ANY, dev->mr_scache.reg_mr_cb);
+	}
 	if (!mr) {
 		DRV_LOG(WARNING, "Device %s unable to DMA map", rte_dev->name);
 		rte_errno = EINVAL;
diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/common/mlx5/mlx5_common_mr.c
index 8ed988dec9..8f31eaefe8 100644
--- a/drivers/common/mlx5/mlx5_common_mr.c
+++ b/drivers/common/mlx5/mlx5_common_mr.c
@@ -8,6 +8,7 @@
 #include <rte_eal_memconfig.h>
 #include <rte_eal_paging.h>
 #include <rte_errno.h>
+#include <rte_memory.h>
 #include <rte_mempool.h>
 #include <rte_malloc.h>
 #include <rte_rwlock.h>
@@ -1141,6 +1142,7 @@ mlx5_mr_create_cache(struct mlx5_mr_share_cache *share_cache, int socket)
 {
 	/* Set the reg_mr and dereg_mr callback functions */
 	mlx5_os_set_reg_mr_cb(&share_cache->reg_mr_cb,
+			      &share_cache->reg_dmabuf_mr_cb,
 			      &share_cache->dereg_mr_cb);
 	rte_rwlock_init(&share_cache->rwlock);
 	rte_rwlock_init(&share_cache->mprwlock);
@@ -1221,6 +1223,74 @@ mlx5_create_mr_ext(void *pd, uintptr_t addr, size_t len, int socket_id,
 	return mr;
 }
 
+/**
+ * Creates a memory region for dma-buf backed external memory.
+ *
+ * @param pd
+ *   Pointer to pd of a device (net, regex, vdpa,...).
+ * @param addr
+ *   Starting virtual address of memory (mmap'd address).
+ * @param len
+ *   Length of memory segment being mapped.
+ * @param socket_id
+ *   Socket to allocate heap memory for the control structures.
+ * @param dmabuf_fd
+ *   File descriptor of the dma-buf.
+ * @param dmabuf_offset
+ *   Offset within the dma-buf.
+ * @param reg_dmabuf_mr_cb
+ *   Callback function for dma-buf MR registration.
+ *
+ * @return
+ *   Pointer to MR structure on success, NULL otherwise.
+ */
+struct mlx5_mr *
+mlx5_create_mr_ext_dmabuf(void *pd, uintptr_t addr, size_t len, int socket_id,
+			  int dmabuf_fd, uint64_t dmabuf_offset,
+			  mlx5_reg_dmabuf_mr_t reg_dmabuf_mr_cb)
+{
+	struct mlx5_mr *mr = NULL;
+
+	if (reg_dmabuf_mr_cb == NULL) {
+		DRV_LOG(WARNING, "dma-buf MR registration not supported");
+		rte_errno = ENOTSUP;
+		return NULL;
+	}
+	mr = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO,
+			 RTE_ALIGN_CEIL(sizeof(*mr), RTE_CACHE_LINE_SIZE),
+			 RTE_CACHE_LINE_SIZE, socket_id);
+	if (mr == NULL)
+		return NULL;
+	if (reg_dmabuf_mr_cb(pd, dmabuf_offset, len, addr, dmabuf_fd,
+			     &mr->pmd_mr) < 0) {
+		DRV_LOG(WARNING,
+			"Fail to create dma-buf MR for address (%p) fd=%d",
+			(void *)addr, dmabuf_fd);
+		mlx5_free(mr);
+		return NULL;
+	}
+	mr->msl = NULL; /* Mark it is external memory. */
+	mr->ms_bmp = NULL;
+	mr->ms_n = 1;
+	mr->ms_bmp_n = 1;
+	/*
+	 * For dma-buf MR, the returned addr may be NULL since there's no VA
+	 * in the registration. Store the user-provided addr for cache lookup.
+	 */
+	if (mr->pmd_mr.addr == NULL)
+		mr->pmd_mr.addr = (void *)addr;
+	if (mr->pmd_mr.len == 0)
+		mr->pmd_mr.len = len;
+	DRV_LOG(DEBUG,
+		"MR CREATED (%p) for dma-buf external memory %p (fd=%d):\n"
+		"  [0x%" PRIxPTR ", 0x%" PRIxPTR "),"
+		" lkey=0x%x base_idx=%u ms_n=%u, ms_bmp_n=%u",
+		(void *)mr, (void *)addr, dmabuf_fd,
+		addr, addr + len, rte_cpu_to_be_32(mr->pmd_mr.lkey),
+		mr->ms_base_idx, mr->ms_n, mr->ms_bmp_n);
+	return mr;
+}
+
 /**
  * Callback for memory free event. Iterate freed memsegs and check whether it
  * belongs to an existing MR. If found, clear the bit from bitmap of MR. As a
@@ -1747,9 +1817,48 @@ mlx5_mr_mempool_register_primary(struct mlx5_mr_share_cache *share_cache,
 		struct mlx5_mempool_mr *mr = &new_mpr->mrs[i];
 		const struct mlx5_range *range = &ranges[i];
 		size_t len = range->end - range->start;
+		struct rte_memseg_list *msl;
+		int reg_result;
+
+		/* Check if this is dma-buf backed external memory */
+		msl = rte_mem_virt2memseg_list((void *)range->start);
+		if (msl != NULL && msl->external &&
+		    share_cache->reg_dmabuf_mr_cb != NULL) {
+			int dmabuf_fd = rte_memseg_list_get_dmabuf_fd(msl);
+			if (dmabuf_fd >= 0) {
+				uint64_t dmabuf_off;
+				/* Get base offset from memseg list */
+				ret = rte_memseg_list_get_dmabuf_offset(msl, &dmabuf_off);
+				if (ret < 0) {
+					DRV_LOG(ERR, "Failed to get dma-buf offset for memseg list %p",
+						(void *)msl);
+					goto exit;
+				}
+				/* Calculate offset within dma-buf for this specific range */
+				dmabuf_off += (range->start - (uintptr_t)msl->base_va);
+				/* Use dma-buf MR registration */
+				reg_result = share_cache->reg_dmabuf_mr_cb(pd,
+					dmabuf_off, len, range->start, dmabuf_fd,
+					&mr->pmd_mr);
+				if (reg_result == 0) {
+					/* For dma-buf MR, set addr if not set by driver */
+					if (mr->pmd_mr.addr == NULL)
+						mr->pmd_mr.addr = (void *)range->start;
+					if (mr->pmd_mr.len == 0)
+						mr->pmd_mr.len = len;
+				}
+			} else {
+				/* Use regular MR registration */
+				reg_result = share_cache->reg_mr_cb(pd,
+					(void *)range->start, len, &mr->pmd_mr);
+			}
+		} else {
+			/* Use regular MR registration */
+			reg_result = share_cache->reg_mr_cb(pd,
+				(void *)range->start, len, &mr->pmd_mr);
+		}
 
-		if (share_cache->reg_mr_cb(pd, (void *)range->start, len,
-		    &mr->pmd_mr) < 0) {
+		if (reg_result < 0) {
 			DRV_LOG(ERR,
 				"Failed to create an MR in PD %p for address range "
 				"[0x%" PRIxPTR ", 0x%" PRIxPTR "] (%zu bytes) for mempool %s",
diff --git a/drivers/common/mlx5/mlx5_common_mr.h b/drivers/common/mlx5/mlx5_common_mr.h
index cf7c685e9b..3b967b1323 100644
--- a/drivers/common/mlx5/mlx5_common_mr.h
+++ b/drivers/common/mlx5/mlx5_common_mr.h
@@ -35,6 +35,9 @@ struct mlx5_pmd_mr {
  */
 typedef int (*mlx5_reg_mr_t)(void *pd, void *addr, size_t length,
 			     struct mlx5_pmd_mr *pmd_mr);
+typedef int (*mlx5_reg_dmabuf_mr_t)(void *pd, uint64_t offset, size_t length,
+				    uint64_t iova, int fd,
+				    struct mlx5_pmd_mr *pmd_mr);
 typedef void (*mlx5_dereg_mr_t)(struct mlx5_pmd_mr *pmd_mr);
 
 /* Memory Region object. */
@@ -87,6 +90,7 @@ struct __rte_packed_begin mlx5_mr_share_cache {
 	struct mlx5_mr_list mr_free_list; /* Freed MR list. */
 	struct mlx5_mempool_reg_list mempool_reg_list; /* Mempool database. */
 	mlx5_reg_mr_t reg_mr_cb; /* Callback to reg_mr func */
+	mlx5_reg_dmabuf_mr_t reg_dmabuf_mr_cb; /* Callback to reg_dmabuf_mr func */
 	mlx5_dereg_mr_t dereg_mr_cb; /* Callback to dereg_mr func */
 } __rte_packed_end;
 
@@ -233,6 +237,10 @@ mlx5_mr_lookup_list(struct mlx5_mr_share_cache *share_cache,
 struct mlx5_mr *
 mlx5_create_mr_ext(void *pd, uintptr_t addr, size_t len, int socket_id,
 		   mlx5_reg_mr_t reg_mr_cb);
+struct mlx5_mr *
+mlx5_create_mr_ext_dmabuf(void *pd, uintptr_t addr, size_t len, int socket_id,
+			  int dmabuf_fd, uint64_t dmabuf_offset,
+			  mlx5_reg_dmabuf_mr_t reg_dmabuf_mr_cb);
 void mlx5_mr_free(struct mlx5_mr *mr, mlx5_dereg_mr_t dereg_mr_cb);
 __rte_internal
 uint32_t
@@ -251,12 +259,19 @@ int
 mlx5_common_verbs_reg_mr(void *pd, void *addr, size_t length,
 			 struct mlx5_pmd_mr *pmd_mr);
 __rte_internal
+int
+mlx5_common_verbs_reg_dmabuf_mr(void *pd, uint64_t offset, size_t length,
+				uint64_t iova, int fd,
+				struct mlx5_pmd_mr *pmd_mr);
+__rte_internal
 void
 mlx5_common_verbs_dereg_mr(struct mlx5_pmd_mr *pmd_mr);
 
 __rte_internal
 void
-mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb, mlx5_dereg_mr_t *dereg_mr_cb);
+mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb,
+		      mlx5_reg_dmabuf_mr_t *reg_dmabuf_mr_cb,
+		      mlx5_dereg_mr_t *dereg_mr_cb);
 
 __rte_internal
 int
diff --git a/drivers/common/mlx5/windows/mlx5_common_os.c b/drivers/common/mlx5/windows/mlx5_common_os.c
index 7fac361460..5e284742ab 100644
--- a/drivers/common/mlx5/windows/mlx5_common_os.c
+++ b/drivers/common/mlx5/windows/mlx5_common_os.c
@@ -17,6 +17,7 @@
 #include "mlx5_common.h"
 #include "mlx5_common_os.h"
 #include "mlx5_malloc.h"
+#include "mlx5_common_mr.h"
 
 /**
  * Initialization routine for run-time dependency on external lib.
@@ -442,15 +443,20 @@ mlx5_os_dereg_mr(struct mlx5_pmd_mr *pmd_mr)
  *
  * @param[out] reg_mr_cb
  *   Pointer to reg_mr func
+ * @param[out] reg_dmabuf_mr_cb
+ *   Pointer to reg_dmabuf_mr func (NULL on Windows - not supported)
  * @param[out] dereg_mr_cb
  *   Pointer to dereg_mr func
  *
  */
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_set_reg_mr_cb)
 void
-mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb, mlx5_dereg_mr_t *dereg_mr_cb)
+mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb,
+		      mlx5_reg_dmabuf_mr_t *reg_dmabuf_mr_cb,
+		      mlx5_dereg_mr_t *dereg_mr_cb)
 {
 	*reg_mr_cb = mlx5_os_reg_mr;
+	*reg_dmabuf_mr_cb = NULL; /* dma-buf not supported on Windows */
 	*dereg_mr_cb = mlx5_os_dereg_mr;
 }
 
diff --git a/drivers/crypto/mlx5/mlx5_crypto.h b/drivers/crypto/mlx5/mlx5_crypto.h
index f9f127e9e6..b2712c9a8d 100644
--- a/drivers/crypto/mlx5/mlx5_crypto.h
+++ b/drivers/crypto/mlx5/mlx5_crypto.h
@@ -41,6 +41,7 @@ struct mlx5_crypto_priv {
 	struct mlx5_common_device *cdev; /* Backend mlx5 device. */
 	struct rte_cryptodev *crypto_dev;
 	mlx5_reg_mr_t reg_mr_cb; /* Callback to reg_mr func */
+	mlx5_reg_dmabuf_mr_t reg_dmabuf_mr_cb; /* Callback to reg_dmabuf_mr func */
 	mlx5_dereg_mr_t dereg_mr_cb; /* Callback to dereg_mr func */
 	struct mlx5_uar uar; /* User Access Region. */
 	uint32_t max_segs_num; /* Maximum supported data segs. */
diff --git a/drivers/crypto/mlx5/mlx5_crypto_gcm.c b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
index 89f32c7722..380689cfeb 100644
--- a/drivers/crypto/mlx5/mlx5_crypto_gcm.c
+++ b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
@@ -1186,7 +1186,8 @@ mlx5_crypto_gcm_init(struct mlx5_crypto_priv *priv)
 
 	/* Override AES-GCM specified ops. */
 	dev_ops->sym_session_configure = mlx5_crypto_sym_gcm_session_configure;
-	mlx5_os_set_reg_mr_cb(&priv->reg_mr_cb, &priv->dereg_mr_cb);
+	mlx5_os_set_reg_mr_cb(&priv->reg_mr_cb,  &priv->reg_dmabuf_mr_cb,
+			&priv->dereg_mr_cb);
 	dev_ops->queue_pair_setup = mlx5_crypto_gcm_qp_setup;
 	dev_ops->queue_pair_release = mlx5_crypto_gcm_qp_release;
 	if (mlx5_crypto_is_ipsec_opt(priv)) {
-- 
2.52.0


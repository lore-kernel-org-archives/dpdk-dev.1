Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC69C3ABA9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 12:26:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EDB8402AB;
	Tue, 29 Apr 2025 14:26:39 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by mails.dpdk.org (Postfix) with ESMTP id CF1D5402A9;
 Tue, 29 Apr 2025 14:26:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUJxgzYnqNkFWwRUDyN0GXMP+okWNpgbMkbYLSjgR5zjctyRDgdfhOXyH20HRbb5x8a9okjJnvG/EC4SXe1OEux4kOmvloRbuYskA8dOf1ILupdQoKrhe8JSrUVThtNdELVS7RQyplzhhSNYAjgVTWs+yvLhqA4D7GrOPlRxOh4qCs4mqdhRV7EblqoTk3BJ136Zyfe9D+NMpdXt6zJbZ1tfF8bTVtumH2YWvVkHXP5YZMCxDBOtfOQGNIsWbVpohKFJp558iXijR80zAZc8C940JTgDknzeJFo3fTHlSS6qMWU2Sb60oByx5uhuGqTONNq7d9oNI6cfxAFA+Q/syw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4g4yEdGDlfeRVrHdf/rtdkl9xRz8N9NX04PZuqsKxzQ=;
 b=esjabqzUH3VNZHPikh1pt6Xly3a6jYlsg5fjDT5goiq9yPWxfS+iuHX/sQG/j2ke9RR3cJfktdGclLgh6GNF7LAwmqI9TnV2miyv2q/sOSpxeewH0IslitF6JQwyTcCy0gZwpjvt+QGaI3uJB8f0DKefJUIUvqBerIIH8Z+x87ZOOylVr2VfqCydNFi5vvC5kIzJCL0CBiTYFsvFQugEeMuiPwDBHEqIE8zs6rHWgIgcNhbSkPkvgzTDxH76YCslSXX+IlD+PfJX/qIYNt8xFz8uiYUsPbSggzACtlYYyarmwRbHwMwyeBjxzC3pPSsJJPyPegbXbXZznpf9gpM9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g4yEdGDlfeRVrHdf/rtdkl9xRz8N9NX04PZuqsKxzQ=;
 b=N5pxhZxr7XGUgsSM7cn5f19MmuI8rWJJzTZVvXP7/8Ur/EEG3ltnv+qp90a64h2FxNk9Agj/8YT0uVXebqf76oB6jkbxvzBqiGWUBgzgaxyuVsz44FugCjgjUqxYCDthdLqb+qREl20W2JwZYgsKPOfjcXDn2ayyqJOhF14YCHakSmeAqAiUq9g458nENTbTSorPVWwHMXh5O2hnKZuCMnt7kmtEDy0YHZBEDJBTvqj1DV0xaqIwAwlTLmMM6VgQOWdNeF7Q8uOx8u5rMutHDPBv6eHo26AHBJGyFGNY5Q42dmqfFlmnp+USlpEQdOEI0Ou/Up0+bY8B7KOmkvYjhQ==
Received: from SA9PR13CA0174.namprd13.prod.outlook.com (2603:10b6:806:28::29)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Tue, 29 Apr
 2025 12:26:32 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::52) by SA9PR13CA0174.outlook.office365.com
 (2603:10b6:806:28::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 29 Apr 2025 12:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 12:26:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Apr
 2025 05:26:18 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 29 Apr
 2025 05:26:15 -0700
From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <matan@nvidia.com>, <suanmingm@nvidia.com>,
 <stable@dpdk.org>, Edwin Brossette <edwin.brossette@6wind.com>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>
Subject: [PATCH] net/mlx5: fix the maximal queue size query
Date: Tue, 29 Apr 2025 15:25:56 +0300
Message-ID: <20250429122556.214279-1-viacheslavo@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANDF9xANRqeTnkvAk61y=2TCd2fsWDQQ4YoTFdpL-RW8ksDDGQ@mail.gmail.com>
References: <CANDF9xANRqeTnkvAk61y=2TCd2fsWDQQ4YoTFdpL-RW8ksDDGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b6cda29-b8ec-4fce-f936-08dd87191300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wy39OVvYZ6tjN5HzSXiQzzh+29PEw26cAUuD+mPHy0SOsMWkKM28o6kTZIbJ?=
 =?us-ascii?Q?ZkNEfBUWsmzOtErJRGh1um1rhd7xg2FtNPYVFjbh6hBz/iw3htEOW1nvIKAH?=
 =?us-ascii?Q?0SA9rDsRZ+qNYiUceUlY0AgV3lWvtLU4MLcxEfgMkep2QTb30/xu7RzPraq+?=
 =?us-ascii?Q?d+0cNzU40oRW0q39E+pMPMThZ09MiIL6Hq2v/eUs/LnUm78bDcSMLvtCLeET?=
 =?us-ascii?Q?Iyba3kEiS9kAJ+daAkwjDLWNQ72Jl6glm8Cj6EUjDpNGHaha4ASJUTo2SzJP?=
 =?us-ascii?Q?t3a4iOgT354SiH1mewM600S1gGpVfv0Gl1ljg7M6rxT5id4Lg7yEFKbMJpWf?=
 =?us-ascii?Q?AEDljVpu3CcT3uY+EaPvHYP/Ksn0qnXR2gsGtgnPTFBAR28ivletd2LLQZUe?=
 =?us-ascii?Q?ypy4llA3Q5cb8XB8xvIKBX7/HmXm3FQ50sUbz9rtgKJd9ZKXHcUGj5MYpFeX?=
 =?us-ascii?Q?dzLzJeDdrgrgTI+0jSasJnWlEsJdMF0y3ZGQSS+qtYx6DpGruynomE9LFqP/?=
 =?us-ascii?Q?kRkUtmQ+h6K9ARs7VvQLg6xzZJ6mbDuK60DgyxOqGS+3Y9HyqoNSmsvhSb8u?=
 =?us-ascii?Q?xNOb0Dgt+9CiEU5JI3fWENcBGFcLkzR9SJuv9SmVLjMH8mytxuvUOSyN8RmQ?=
 =?us-ascii?Q?/SKeD9FAZd/QCdZdlWf8hgxUXSoFVwSO3k684/ty5LTrHrKnazevVgz+lKmR?=
 =?us-ascii?Q?Di5INMcq3k7CTlPZ+apCHYGd+Q+2wofXE2IOjghWqTWE/dCdZ047St1scwgR?=
 =?us-ascii?Q?rlYm1tbG9NfD9CzD+CaAEypsns1u1PbSBJWgBVuiDetGzSv4KbabcB8ZdJ0P?=
 =?us-ascii?Q?BgaEJfkwrE/eQ4anBDpkgF5cChuI8KjFS4Vz4/VQdOH6v1dfGDHO+IHARYoA?=
 =?us-ascii?Q?dsQVYBTj2QAjicI53pvOPVOeg+MrpeoU8Q3MF3WJIO1Dsbl86CA/RDRWWTBk?=
 =?us-ascii?Q?5EcuiaNGTs5SYW22GShw89VaEslPOz28LD2rXmMolkZjUHr7kqvY6I99oYwi?=
 =?us-ascii?Q?Bl//RcWb3E5zJbjUMWNgFNCn43SG6kJ/pXsdtEmDbLwwQYweGqJH5N7i+s2L?=
 =?us-ascii?Q?xfisKTlBMTfLIp826HGXL9j0sWjkxZDIAdmYqb8Fk5XIcfvWwkND15mQli0Q?=
 =?us-ascii?Q?uAXbL+wJ0r1rmb1zowznrCiLAr7ofUzR56rPuEzf2LMp4J3OOFbCjq27ZjR5?=
 =?us-ascii?Q?XFg/WOVAuGBPbE3Nim/O+YtVF1Rxlff+dfFWt967NuOMreTZ4M23K2kn1+ZI?=
 =?us-ascii?Q?3t75hyrn9qaQ42rxA3R+TPTTIcDiHQCA9L6K2b0usYXo+eZirbVM+th68uoe?=
 =?us-ascii?Q?6K/ItDMSSQxiIr7nn46yAPNGV34GLYb+gQkH2lPdDh4yp5QjxPKE7ZjnkHhv?=
 =?us-ascii?Q?jxMD+VshIMIvzvWjlbM1dinZPw+k29yE5cOT+w6IjsPq/WcBOB/Ev5tQfAny?=
 =?us-ascii?Q?lWVBZ87HDilOB1nFyTzuv3bu5YoJ3LlSXbrR/0v+eByf4xvUyUM224pYsQcw?=
 =?us-ascii?Q?3mIui8PzMbiSfHRr+ziipKIYY5VjGzFi6DvM?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 12:26:31.7755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6cda29-b8ec-4fce-f936-08dd87191300
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302
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

The mlx5 PMD manages the device using two modes: the Verbs API
and the DevX API. Each API offers its own method for querying
the maximum work queue size (in descriptors).

The corrected patch enhanced the rte_eth_dev_info_get() API
support in mlx5 PMD to return the true maximum number of descriptors.
It also implemented a limit check during queue creation, but this
was applied only to "DevX mode." Consequently, the "Verbs mode"
was overlooked, leading to malfunction on legacy NICs that do
not support DevX.

This patch adds support for Verbs mode, and all limit checks are
updated accordingly.

Fixes: 4c3d7961d900 ("net/mlx5: fix reported Rx/Tx descriptor limits")
Cc: stable@dpdk.org

Reported-by: Edwin Brossette <edwin.brossette@6wind.com>
Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/common/mlx5/mlx5_prm.h  |  1 +
 drivers/net/mlx5/mlx5.h         |  1 +
 drivers/net/mlx5/mlx5_devx.c    |  2 +-
 drivers/net/mlx5/mlx5_ethdev.c  | 39 +++++++++++++++++++++++++++++----
 drivers/net/mlx5/mlx5_rxq.c     |  2 +-
 drivers/net/mlx5/mlx5_trigger.c |  4 ++--
 drivers/net/mlx5/mlx5_txq.c     | 12 +++++-----
 7 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_prm.h b/drivers/common/mlx5/mlx5_prm.h
index 742c274a85..7accdeab87 100644
--- a/drivers/common/mlx5/mlx5_prm.h
+++ b/drivers/common/mlx5/mlx5_prm.h
@@ -41,6 +41,7 @@
 /* Hardware index widths. */
 #define MLX5_CQ_INDEX_WIDTH 24
 #define MLX5_WQ_INDEX_WIDTH 16
+#define MLX5_WQ_INDEX_MAX (1u << (MLX5_WQ_INDEX_WIDTH - 1))
 
 /* WQE Segment sizes in bytes. */
 #define MLX5_WSEG_SIZE 16u
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 0194887a8b..ff182996d3 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2303,6 +2303,7 @@ int mlx5_representor_info_get(struct rte_eth_dev *dev,
 		(((repr_id) >> 12) & 3)
 uint16_t mlx5_representor_id_encode(const struct mlx5_switch_info *info,
 				    enum rte_eth_representor_type hpf_type);
+uint16_t mlx5_dev_get_max_wq_size(struct mlx5_dev_ctx_shared *sh);
 int mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info);
 int mlx5_fw_version_get(struct rte_eth_dev *dev, char *fw_ver, size_t fw_size);
 const uint32_t *mlx5_dev_supported_ptypes_get(struct rte_eth_dev *dev,
diff --git a/drivers/net/mlx5/mlx5_devx.c b/drivers/net/mlx5/mlx5_devx.c
index a12891a983..9711746edb 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -1593,7 +1593,7 @@ mlx5_txq_devx_obj_new(struct rte_eth_dev *dev, uint16_t idx)
 	wqe_size = RTE_ALIGN(wqe_size, MLX5_WQE_SIZE) / MLX5_WQE_SIZE;
 	/* Create Send Queue object with DevX. */
 	wqe_n = RTE_MIN((1UL << txq_data->elts_n) * wqe_size,
-			(uint32_t)priv->sh->dev_cap.max_qp_wr);
+			(uint32_t)mlx5_dev_get_max_wq_size(priv->sh));
 	log_desc_n = log2above(wqe_n);
 	ret = mlx5_txq_create_devx_sq_resources(dev, idx, log_desc_n);
 	if (ret) {
diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index 7708a0b808..7f12194f30 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -314,6 +314,37 @@ mlx5_set_txlimit_params(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 	info->tx_desc_lim.nb_mtu_seg_max = nb_max;
 }
 
+/**
+ * Get maximal work queue size in WQEs
+ *
+ * @param sh
+ *   Pointer to the device shared context.
+ * @return
+ *   Maximal number of WQEs in queue
+ */
+uint16_t
+mlx5_dev_get_max_wq_size(struct mlx5_dev_ctx_shared *sh)
+{
+	uint16_t max_wqe = MLX5_WQ_INDEX_MAX;
+
+	if (sh->cdev->config.devx) {
+		/* use HCA properties for DevX config */
+		MLX5_ASSERT(sh->cdev->config.hca_attr.log_max_wq_sz != 0);
+		MLX5_ASSERT(sh->cdev->config.hca_attr.log_max_wq_sz < MLX5_WQ_INDEX_WIDTH);
+		if (sh->cdev->config.hca_attr.log_max_wq_sz != 0 &&
+		    sh->cdev->config.hca_attr.log_max_wq_sz < MLX5_WQ_INDEX_WIDTH)
+			max_wqe = 1u << sh->cdev->config.hca_attr.log_max_wq_sz;
+	} else {
+		/* use IB device capabilities */
+		MLX5_ASSERT(sh->dev_cap.max_qp_wr > 0);
+		MLX5_ASSERT(sh->dev_cap.max_qp_wr <= MLX5_WQ_INDEX_MAX);
+		if (sh->dev_cap.max_qp_wr > 0 &&
+		    (uint32_t)sh->dev_cap.max_qp_wr <= MLX5_WQ_INDEX_MAX)
+			max_wqe = (uint16_t)sh->dev_cap.max_qp_wr;
+	}
+	return max_wqe;
+}
+
 /**
  * DPDK callback to get information about the device.
  *
@@ -327,6 +358,7 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	unsigned int max;
+	uint16_t max_wqe;
 
 	/* FIXME: we should ask the device for these values. */
 	info->min_rx_bufsize = 32;
@@ -359,10 +391,9 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 	info->flow_type_rss_offloads = ~MLX5_RSS_HF_MASK;
 	mlx5_set_default_params(dev, info);
 	mlx5_set_txlimit_params(dev, info);
-	info->rx_desc_lim.nb_max =
-		1 << priv->sh->cdev->config.hca_attr.log_max_wq_sz;
-	info->tx_desc_lim.nb_max =
-		1 << priv->sh->cdev->config.hca_attr.log_max_wq_sz;
+	max_wqe = mlx5_dev_get_max_wq_size(priv->sh);
+	info->rx_desc_lim.nb_max = max_wqe;
+	info->tx_desc_lim.nb_max = max_wqe;
 	if (priv->sh->cdev->config.hca_attr.mem_rq_rmp &&
 	    priv->obj_ops.rxq_obj_new == devx_obj_ops.rxq_obj_new)
 		info->dev_capa |= RTE_ETH_DEV_CAPA_RXQ_SHARE;
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 5cf7d4971b..a8aaab13c8 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -655,7 +655,7 @@ mlx5_rx_queue_pre_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t *desc,
 	struct mlx5_rxq_priv *rxq;
 	bool empty;
 
-	if (*desc > 1 << priv->sh->cdev->config.hca_attr.log_max_wq_sz) {
+	if (*desc > mlx5_dev_get_max_wq_size(priv->sh)) {
 		DRV_LOG(ERR,
 			"port %u number of descriptors requested for Rx queue"
 			" %u is more than supported",
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 4ee44e9165..8145ad4233 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -217,8 +217,8 @@ mlx5_rxq_start(struct rte_eth_dev *dev)
 		/* Should not release Rx queues but return immediately. */
 		return -rte_errno;
 	}
-	DRV_LOG(DEBUG, "Port %u dev_cap.max_qp_wr is %d.",
-		dev->data->port_id, priv->sh->dev_cap.max_qp_wr);
+	DRV_LOG(DEBUG, "Port %u max work queue size is %d.",
+		dev->data->port_id, mlx5_dev_get_max_wq_size(priv->sh));
 	DRV_LOG(DEBUG, "Port %u dev_cap.max_sge is %d.",
 		dev->data->port_id, priv->sh->dev_cap.max_sge);
 	for (i = 0; i != priv->rxqs_n; ++i) {
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index 3e93517323..b14a1a4379 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -333,7 +333,7 @@ mlx5_tx_queue_pre_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t *desc)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 
-	if (*desc > 1 << priv->sh->cdev->config.hca_attr.log_max_wq_sz) {
+	if (*desc > mlx5_dev_get_max_wq_size(priv->sh)) {
 		DRV_LOG(ERR,
 			"port %u number of descriptors requested for Tx queue"
 			" %u is more than supported",
@@ -727,7 +727,7 @@ txq_calc_inline_max(struct mlx5_txq_ctrl *txq_ctrl)
 	struct mlx5_priv *priv = txq_ctrl->priv;
 	unsigned int wqe_size;
 
-	wqe_size = priv->sh->dev_cap.max_qp_wr / desc;
+	wqe_size = mlx5_dev_get_max_wq_size(priv->sh) / desc;
 	if (!wqe_size)
 		return 0;
 	/*
@@ -1082,6 +1082,7 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_txq_ctrl *tmpl;
+	uint16_t max_wqe;
 
 	tmpl = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, sizeof(*tmpl) +
 			   desc * sizeof(struct rte_mbuf *), 0, socket);
@@ -1107,13 +1108,12 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	txq_set_params(tmpl);
 	if (txq_adjust_params(tmpl))
 		goto error;
-	if (txq_calc_wqebb_cnt(tmpl) >
-	    priv->sh->dev_cap.max_qp_wr) {
+	max_wqe = mlx5_dev_get_max_wq_size(priv->sh);
+	if (txq_calc_wqebb_cnt(tmpl) > max_wqe) {
 		DRV_LOG(ERR,
 			"port %u Tx WQEBB count (%d) exceeds the limit (%d),"
 			" try smaller queue size",
-			dev->data->port_id, txq_calc_wqebb_cnt(tmpl),
-			priv->sh->dev_cap.max_qp_wr);
+			dev->data->port_id, txq_calc_wqebb_cnt(tmpl), max_wqe);
 		rte_errno = ENOMEM;
 		goto error;
 	}
-- 
2.34.1


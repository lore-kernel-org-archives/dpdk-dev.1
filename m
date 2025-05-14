Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E54C3ABD9
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 07:56:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3390D40652;
	Wed, 14 May 2025 09:56:14 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
 by mails.dpdk.org (Postfix) with ESMTP id 904F340041;
 Wed, 14 May 2025 09:56:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKPs4LrqpQM7LdcWvUaxkPvcbEzPd/xRInQvFz9NAel1/fsTtKaCe6FKy/RTYp8VOSvz4NWcVGOBxDX0aZZ8N4XnYrbueRr29lLjQS+GkG/T7FlgXxvsb2n29mohbx4H6ayYO2MoiJqR7mYi1QIOK+XPLzYrZ/Y9nQNVZ0Q6J/HNjZrWxHpz1mlhJcN7fTZ+L5PZAUyrdaGLCLOn37jEdol/sk86ez82nU/y+Ev4kOfrlABqsU9POaMKwH6WqIbmkNeYTENoNUh2M8fRVYRKRSmgsd3liYgii1Pr5vy7R0+0iqmF7X2LL53e6uvh0V+JwhiRgdP6H/irpwjcCaW5dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMW70wMenOq2DjmSpff6sEWrkYXrwQeBQlCYEBi92xo=;
 b=YwJVE5wEheS1blFZDI4H6WkO1xhZH5yayKQCqmKMtaAYCt/CyininnNGK+djKdEv3xR2kuGPpCIwNzMSoE8BDXtemeKekZdlJDEZ27t8qQbUI/1/Z2S8CYAtZ1R/JvulYz/LSeGKek1fMs6Jlqo3/ik812/p9AnzF17MRAlMD6C6lRULaEWtqN7knx7yBy2EjxQWLxshBQM3AAC2fctCxh99bdBosZ4hC3RwsG7tN15/IhCzVZ11ir0ArfnIy6eog/ur6jRgB+emd9clxXZT58A9Q5bONBhvYamKR+pt2ZnulMQhB8+6WuAiW/kauD0sNvte20fRPX22cIum7eJveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMW70wMenOq2DjmSpff6sEWrkYXrwQeBQlCYEBi92xo=;
 b=F+Btxuv+N3jiaLaLlVMSjSXunf0Ffi7CQFs5cPCJHkKqRpyRPXomRACfbjt+hiTyVmXl2AD5Nc2rrG6gukasdqF6Mb64si+FQCVKmvlbP9u/WdaEGAEP4mODAKhXCelQfcSTo8vHuFkAoaGfC8FcDQ2JJ+MQwdNeiGxP5GVpSqQHJz+O6zgyT6P0KjLl2u2EohaQTwswaDlD23C9n7FjauNxxTG0oAiiLVyo05VAHHiME7C1DzdEc9h9wawPAFouOC2PYy8Ezyk7sI1G0tGjJ9dl5YZeOqGg9RON/llE20lSTLOX9K9scJJ2kg5WuVhA+VQpqvAZsPPa9AZ7GARJvg==
Received: from BN8PR03CA0012.namprd03.prod.outlook.com (2603:10b6:408:94::25)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 14 May
 2025 07:56:07 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:94:cafe::78) by BN8PR03CA0012.outlook.office365.com
 (2603:10b6:408:94::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Wed,
 14 May 2025 07:56:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 07:56:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 May
 2025 00:55:50 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 14 May
 2025 00:55:46 -0700
From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <matan@nvidia.com>, <suanmingm@nvidia.com>,
 <stable@dpdk.org>, Edwin Brossette <edwin.brossette@6wind.com>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>
Subject: [PATCH v2] net/mlx5: fix the maximal queue size query
Date: Wed, 14 May 2025 10:55:30 +0300
Message-ID: <20250514075530.419423-1-viacheslavo@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANDF9xANRqeTnkvAk61y=2TCd2fsWDQQ4YoTFdpL-RW8ksDDGQ@mail.gmail.com>
References: <CANDF9xANRqeTnkvAk61y=2TCd2fsWDQQ4YoTFdpL-RW8ksDDGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f00032-7c41-46d6-bee0-08dd92bcc841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HOzgtk/a1SNhFW3BYtqAPmIbP/jWyM7jWFsg2AGqc1IQoUEIHhsDRjZJrNb0?=
 =?us-ascii?Q?+qyp5j3oO8V0rO3wqjoMwFNMoLu4vkddxyx9gT62AEmabNv2uKJZy3yo3y9z?=
 =?us-ascii?Q?rzyKNZ8+LyJZdjNajKWJ1SvgIg4vfwogE1uXJBrqWh6w3Rie7Ha73Yh6Kz3Y?=
 =?us-ascii?Q?4K/vav6zPvCKS9ez1a6Cd4rRfX/GRJoLpP6DEqS2paxd2wZcYSpRrPnj32+I?=
 =?us-ascii?Q?hHsrOHs8LZBolpKfS72dpNisroUI/F0sU/NkztGVNJk1Xoo9i70M/2bmVnkS?=
 =?us-ascii?Q?lndHimP1M5hnDkpY368siJLkU6xbs//vK0/xhK2QmaO7Pt3ZUODEStDha2Gq?=
 =?us-ascii?Q?x3VkDR0r1sWy714dXxM9JuW9ebXetv4W46D9DJcZVs3KjY0A0wDilCToH0b3?=
 =?us-ascii?Q?Z1KbTwHSUs+4gAAsU7Rfl8Dnpb60ikUHEZufXZHRlBeaENsACoOvqblksbFz?=
 =?us-ascii?Q?l2drFjAu5/8uHHDW9bFsdGt93vArN9yoZ518QKBh+DwsUZHyk8w06uzJMkiL?=
 =?us-ascii?Q?EYjXsswYLYsJ2sBO7ZaE8WE7nOG2ozqzcd5qfoHmL47HZHI3CDK4bSDQ18JG?=
 =?us-ascii?Q?E6ujkcwPOn4SPFq4oOSajrD1TLEpmNXH5hByclspo6ocDg4U7nyeH1JNCkTy?=
 =?us-ascii?Q?2GeKUcAPBejZpcjQb4ChTONjFHahmuIoo/Kqy67Y4GBeIQvMLRoWh4PIdcD3?=
 =?us-ascii?Q?EHDZq4kfwlgI8xNVwLFSxS1nAI/mwHwHcyCbannye7Z6JEoji+lJIDX0mptc?=
 =?us-ascii?Q?Ph/7WBxmSjs59/CSDWnKwfo7bxwN4d9OTk4vSG9JLXtTP4aTDTZEHV7oU1RO?=
 =?us-ascii?Q?T0uWf2btdRTYD4twuMlw/LDJVvWJXWpS2J5ZRWIxfvqHlaEaAex09cRRAxNE?=
 =?us-ascii?Q?lvuXiEcPmmeOApM8PJ6kCoyi0aXdQ/H/m13INx8cDJPEzHNUshBFq9Jjw7Bc?=
 =?us-ascii?Q?MWUmbsMoIB5ramkcTd+pCKeq6lBFOFOtuKO4Wptno/FG0QCKzSnVXKl+XClu?=
 =?us-ascii?Q?Kla1e64p8ZyUiXPJ3xwi2jdO/1bucGD9xu3cMZhUd6jbJcWM0T4CkHdVpOFp?=
 =?us-ascii?Q?8pzYAj20GZQ8wtEi42w+F227Egk70V/WlZ0aEMqZHuEuZ6VJG9HEbi9VK1pp?=
 =?us-ascii?Q?ks1Y7AMw4OQ15EAvJ1bZ6LSYW6rnN4PnbDh08P2Vx8gyh2D1BpCiNZ8mr+l1?=
 =?us-ascii?Q?Cl56sT6paB1CWSTmIPKx4RstYnFqGUC7yhH7gZH3IdZKdOdhIRIxvOiF6MHu?=
 =?us-ascii?Q?uTGQvAJfOBvZQkFoQI1ldWPFGiP6CWQ2uXq1+XQ8TEUhP57KkkZBtnPfDmHQ?=
 =?us-ascii?Q?vXqHDnp+VPDT7u/xfKD3IddoGFLwp89RjwXdJSTA4XyOO5oIyBjBEypBI6lz?=
 =?us-ascii?Q?r4j41zgAGLNN8Ox3mqxe33U9u88A6V2ix2KYpmcEIV754KxxX2wxJbF4TU5y?=
 =?us-ascii?Q?pUY5BjX9Q1ofIxJpSO/XzhoHYmghQZERlykd7j3sbGsFOR2jnYprgbmQzWOS?=
 =?us-ascii?Q?dMHPCdLDV6m4d+sbzsnyZPtytXjUsLII1sSa?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 07:56:06.5744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f00032-7c41-46d6-bee0-08dd92bcc841
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354
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
v2 - minor fix for signed/unsigned comparison in debug assert
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
index 86b09b6d0b..1e3ff26e43 100644
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
index 36f11b9c51..5695d0f54a 100644
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
index 7708a0b808..a50320075c 100644
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
+		MLX5_ASSERT((unsigned int)sh->dev_cap.max_qp_wr <= MLX5_WQ_INDEX_MAX);
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
index ab29b43875..b676e5394b 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -656,7 +656,7 @@ mlx5_rx_queue_pre_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t *desc,
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
index ddd3a66282..5fee5bc4e8 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -334,7 +334,7 @@ mlx5_tx_queue_pre_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t *desc)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 
-	if (*desc > 1 << priv->sh->cdev->config.hca_attr.log_max_wq_sz) {
+	if (*desc > mlx5_dev_get_max_wq_size(priv->sh)) {
 		DRV_LOG(ERR,
 			"port %u number of descriptors requested for Tx queue"
 			" %u is more than supported",
@@ -728,7 +728,7 @@ txq_calc_inline_max(struct mlx5_txq_ctrl *txq_ctrl)
 	struct mlx5_priv *priv = txq_ctrl->priv;
 	unsigned int wqe_size;
 
-	wqe_size = priv->sh->dev_cap.max_qp_wr / desc;
+	wqe_size = mlx5_dev_get_max_wq_size(priv->sh) / desc;
 	if (!wqe_size)
 		return 0;
 	/*
@@ -1054,6 +1054,7 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_txq_ctrl *tmpl;
+	uint16_t max_wqe;
 
 	tmpl = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, sizeof(*tmpl) +
 			   desc * sizeof(struct rte_mbuf *), 0, socket);
@@ -1078,13 +1079,12 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	tmpl->txq.idx = idx;
 	txq_set_params(tmpl);
 	txq_adjust_params(tmpl);
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


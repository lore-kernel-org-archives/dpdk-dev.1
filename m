Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2475C021BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 10:14:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 337CA40A6D;
	Thu, 27 Feb 2025 11:14:40 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by mails.dpdk.org (Postfix) with ESMTP id 0D11940290;
 Thu, 27 Feb 2025 11:14:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VytWG1ofw1hc7izwZ+a0U1a0C6jNY2bU45BZJXFAffpQR/8Dwld7ShcbgkoaY6mGoAGPxCXVyq+5iup0RClfKEjDL0v9ySdD5F2Xcklu+TQr/9iu3xjWpT+aCz0VxpoMRPC5Dl8t9nq1d0qQCrEA5ATfUqdoK9knBw2J6QYdwipKILE9bf6VfTLphZWHvs3WBtkoaKXo2BEeNLE17cv247hhK4YR4TDG6SO1OXoAWtH2v8w5BsZdIqcCflpLZfXznTXBp7kBE9PYotsJ97Kt2EWB9Un1dCyarcy7U5oqnVxSQYo/h+RYfOWYBBM7xE91P6zBaPO0FSolccYxJyz3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iY8d7CeCGLqrIcr8dosLsnp57aXrUL4cpvmDtbeG6q0=;
 b=wx1qnJ0apwZvH/ZxplqdRXyx0q3QVa9nIa/fRN/1ESfMc8yEHE1/UMBvPFMAT4EjWfW8KhJ2WyyWs38+T06rAYi40ycxEU2ypQgEJxUYOopfc4lsiCC/HJtX5N3dauxiWyPUfix0V4miWWl3XnNRLUZwckB7kEhqRleA1Wszad6wpezGIaIgKE/4ZNyTeLE6JX1hQ419SinDCUsgHQF16wmYwUTCmOf1DvgqukXfHXUqIWSdiMDR+Y8vrwegQLzu/3nRXxGoeiHNgs9uIbxiaSwHg7Q/TAaq2JotSl5WP/ZS2ySS5tfs8v4V7eJxgQFuW+9JdYHzj11TczY3zaSg3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iY8d7CeCGLqrIcr8dosLsnp57aXrUL4cpvmDtbeG6q0=;
 b=ewoAjhp/be8WKqS7xBJ6UbT2agMM6hYbBRtwHjzHj2nTCCMm8WQ5JT9opgw0RhO5unU6e8r0OdUzvGL5sTRclZgKcYGik7A9qYso9++PJEqOHInEX2mOq97QUIceNtSlf1sf6mSBNEPqD3qRzj8OtbgSQVx/4Abd25rCwAG6tiIj9MiHpNZQdvjVB8Z+FcU9pedSOQhrs1mr+Vab91xI8I9SrYFtrgOmZc0MkMbh0z6elAcVqMX3tfOfD4k2/y6NQp9uQ551xZV5w16ARfxeqjFGGeWyMYwRaHpqkbrX95DcVR4tydq8slByzXw74IGWxRnRVdlvx+atWi/TIAqY6A==
Received: from BN8PR12CA0017.namprd12.prod.outlook.com (2603:10b6:408:60::30)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 10:14:34 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:60:cafe::bc) by BN8PR12CA0017.outlook.office365.com
 (2603:10b6:408:60::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Thu,
 27 Feb 2025 10:14:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 10:14:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 02:14:24 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 27 Feb
 2025 02:14:23 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 02:14:21 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>
Subject: [PATCH] net/mlx5: fix assert failure on hairpin queue release
Date: Thu, 27 Feb 2025 12:14:14 +0200
Message-ID: <20250227101415.89079-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ad3ab3-3c5f-484b-e9d0-08dd5717888e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8N4SR9Zd4hYb5Q8lQ9nOG9kjp7fxMCisfPsA673rcgbst3mLpUi5Ey0QCgnf?=
 =?us-ascii?Q?4/680DSSwB2nyqv5BESqhYvkx+u+mzYoe2cv09mHH2ALCFsXaRsnxyoI6W4j?=
 =?us-ascii?Q?KUz+msmFeVRQBXd710k2FxI6J2rQ+MblVX3tgg6NnT5naIAUHqdxKFSl8XTU?=
 =?us-ascii?Q?bky92A449gHW9O9/LoFbuWM22u9C6CJiNAVyqe1NvphSIrIKXa5NNlNWdXDC?=
 =?us-ascii?Q?/6pRLKw1fBmO42pPYitK087U3UhIcMWqhIr/utrpl+TfPOZ/PDlf+pWC/ha9?=
 =?us-ascii?Q?zdwO2B3mSZ/cYtcfQePf4FcBfOlE7inrCjooWrGSC9XvjMd3Bt2SAm2Va/sM?=
 =?us-ascii?Q?DEZ5zjkkhu43/bMUNrIrgKQHg706WFKJwK/BpeOhEfhvXjMBIi12Z2joRkMz?=
 =?us-ascii?Q?tixqnPFMTea/ndEA7J2w/O3O61A3z3L6GRe6jcQOSmjmTa2J0d7MHjkePp13?=
 =?us-ascii?Q?wAL1JfxavoElYl0+VTHKMDh9DMdDfwwpXzaCDToiyrh5Naw0lrKXpZoALfkn?=
 =?us-ascii?Q?MJoeP5iteQHJDroH6Rhk6cQBJsaNnjoaEt59dL1SaIwa+AgTUyg6WFda/VHK?=
 =?us-ascii?Q?n0HzRPaEH2cIAmoFsmRGV8ejVClupfpI6WtSEs1xlCZtZSSG7Jd+TWtUQI1z?=
 =?us-ascii?Q?4807qCSTAjv2IjrdOQBJq3S+qxTOZU6/GgWzhoYKuNQy5tjeGkf3iHPIBtx/?=
 =?us-ascii?Q?QNr9m2ac1djsXl1DcXgqNcG+xfTi+bumHT7H6cOTxC8n6fdIfMKsas57LOvJ?=
 =?us-ascii?Q?kNtp9qOfvVdyQxQSvfNgZdfiNwOPXjZLEdsLNIFgP0W2Tciw3RE/V9YSWfDD?=
 =?us-ascii?Q?6Uo5EqKApl6QrnlrQGtoW5BZe8FsNpqXAyMhFSYWIAWgeZ/phw0yFBfg4Kcz?=
 =?us-ascii?Q?vZzcVYIuqMKuZhXZjyOC8rkSznCEN0xoIi0QkqwHuTHrV8vz6bgQGQP85IQb?=
 =?us-ascii?Q?SKGgsMg0eXTuWigFLBKI56fQ0pjdYvCWQsc/E6360ROtwmCY03b0B7bHSSVM?=
 =?us-ascii?Q?s9CIrMJbBnP6rKU/RmBaqWWn6i6JkOaKYKvKweyOOqzCeakLoIniQOz7YaJ3?=
 =?us-ascii?Q?NikL/5zJeJNhaF8g9o6F3mQjOW7kbMWM0uqxneoHUQMyTMYuDsTzOQC7LuCV?=
 =?us-ascii?Q?x9WHr9OwDPEHjwh9ta3Yg4fvnFrEZTZJNJXJEbLZSZZ/c1dGhfDu//FjbGfz?=
 =?us-ascii?Q?zEMrdctaVaUjxqe+IC9FRXb3KrOBS1gsrymzihb7hTGQNbDgvas85LzFxo7I?=
 =?us-ascii?Q?ivthRcDaBMJ0enDFbDrYyJgXDFQ3wyzQrC149B95nEpur4hYVdJfv/e2YEDg?=
 =?us-ascii?Q?7v2pLOJnw5ZjEHd4n5iNbcwQGknf5t/rMgNOcxO0IA91dntxAp2Jh+ib0nbR?=
 =?us-ascii?Q?YkHad3gonlqdvRWFeWxURyo09dHOXKefbbBC9X8n3kzG1OvhN9NO7argOrzu?=
 =?us-ascii?Q?eis34sBjLp6btxKLje8LkYjrNJM0nB4AiJ172w2+efuaB5FXz+L20YqBTZxu?=
 =?us-ascii?Q?OiwQGys8ds0rsK4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 10:14:34.1535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ad3ab3-3c5f-484b-e9d0-08dd5717888e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858
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

Assert was triggered because of ctrl_ref mismatch on hairpin queue.
Fixed the mismatch.

Fixes: 09c2555 ("net/mlx5: support shared Rx queue")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5.h      |  1 +
 drivers/net/mlx5/mlx5_flow.c |  4 ++--
 drivers/net/mlx5/mlx5_rx.h   |  1 +
 drivers/net/mlx5/mlx5_rxq.c  | 12 ++++++++----
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 545ba48b3cd..6df99c25e2f 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2023,6 +2023,7 @@ struct mlx5_priv {
 	uint32_t ctrl_flows; /* Control flow rules. */
 	rte_spinlock_t flow_list_lock;
 	struct mlx5_obj_ops obj_ops; /* HW objects operations. */
+	LIST_HEAD(rxq, mlx5_rxq_ctrl) rxqsctrl; /* DPDK Rx queues. */
 	LIST_HEAD(rxqobj, mlx5_rxq_obj) rxqsobj; /* Verbs/DevX Rx queues. */
 	struct mlx5_list *hrxqs; /* Hash Rx queues. */
 	LIST_HEAD(txq, mlx5_txq_ctrl) txqsctrl; /* DPDK Tx queues. */
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index f8b3e504b35..6169ebc13f6 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -1648,13 +1648,13 @@ flow_rxq_mark_flag_set(struct rte_eth_dev *dev)
 			    opriv->domain_id != priv->domain_id ||
 			    opriv->mark_enabled)
 				continue;
-			LIST_FOREACH(rxq_ctrl, &opriv->sh->shared_rxqs, share_entry) {
+			LIST_FOREACH(rxq_ctrl, &opriv->rxqsctrl, next) {
 				rxq_ctrl->rxq.mark = 1;
 			}
 			opriv->mark_enabled = 1;
 		}
 	} else {
-		LIST_FOREACH(rxq_ctrl, &priv->sh->shared_rxqs, share_entry) {
+		LIST_FOREACH(rxq_ctrl, &priv->rxqsctrl, next) {
 			rxq_ctrl->rxq.mark = 1;
 		}
 		priv->mark_enabled = 1;
diff --git a/drivers/net/mlx5/mlx5_rx.h b/drivers/net/mlx5/mlx5_rx.h
index f80a2e32279..6380895502e 100644
--- a/drivers/net/mlx5/mlx5_rx.h
+++ b/drivers/net/mlx5/mlx5_rx.h
@@ -169,6 +169,7 @@ struct __rte_cache_aligned mlx5_rxq_data {
 /* RX queue control descriptor. */
 struct mlx5_rxq_ctrl {
 	struct mlx5_rxq_data rxq; /* Data path structure. */
+	LIST_ENTRY(mlx5_rxq_ctrl) next; /* Pointer to the next element. */
 	LIST_HEAD(priv, mlx5_rxq_priv) owners; /* Owner rxq list. */
 	struct mlx5_rxq_obj *obj; /* Verbs/DevX elements. */
 	struct mlx5_dev_ctx_shared *sh; /* Shared context. */
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index a5971b5cdda..5cf7d4971b3 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -1037,6 +1037,7 @@ mlx5_rx_hairpin_queue_setup(struct rte_eth_dev *dev, uint16_t idx,
 		rte_errno = ENOMEM;
 		return -rte_errno;
 	}
+	rte_atomic_fetch_add_explicit(&rxq_ctrl->ctrl_ref, 1, rte_memory_order_relaxed);
 	DRV_LOG(DEBUG, "port %u adding hairpin Rx queue %u to list",
 		dev->data->port_id, idx);
 	dev->data->rx_queues[idx] = &rxq_ctrl->rxq;
@@ -2006,8 +2007,9 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 		tmpl->rxq.shared = 1;
 		tmpl->share_group = conf->share_group;
 		tmpl->share_qid = conf->share_qid;
+		LIST_INSERT_HEAD(&priv->sh->shared_rxqs, tmpl, share_entry);
 	}
-	LIST_INSERT_HEAD(&priv->sh->shared_rxqs, tmpl, share_entry);
+	LIST_INSERT_HEAD(&priv->rxqsctrl, tmpl, next);
 	rte_atomic_store_explicit(&tmpl->ctrl_ref, 1, rte_memory_order_relaxed);
 	return tmpl;
 error:
@@ -2061,7 +2063,7 @@ mlx5_rxq_hairpin_new(struct rte_eth_dev *dev, struct mlx5_rxq_priv *rxq,
 	tmpl->rxq.idx = idx;
 	rxq->hairpin_conf = *hairpin_conf;
 	mlx5_rxq_ref(dev, idx);
-	LIST_INSERT_HEAD(&priv->sh->shared_rxqs, tmpl, share_entry);
+	LIST_INSERT_HEAD(&priv->rxqsctrl, tmpl, next);
 	rte_atomic_store_explicit(&tmpl->ctrl_ref, 1, rte_memory_order_relaxed);
 	return tmpl;
 }
@@ -2336,7 +2338,9 @@ mlx5_rxq_release(struct rte_eth_dev *dev, uint16_t idx)
 			if (!rxq_ctrl->is_hairpin)
 				mlx5_mr_btree_free
 					(&rxq_ctrl->rxq.mr_ctrl.cache_bh);
-			LIST_REMOVE(rxq_ctrl, share_entry);
+			if (rxq_ctrl->rxq.shared)
+				LIST_REMOVE(rxq_ctrl, share_entry);
+			LIST_REMOVE(rxq_ctrl, next);
 			mlx5_free(rxq_ctrl);
 		}
 		dev->data->rx_queues[idx] = NULL;
@@ -2362,7 +2366,7 @@ mlx5_rxq_verify(struct rte_eth_dev *dev)
 	struct mlx5_rxq_ctrl *rxq_ctrl;
 	int ret = 0;
 
-	LIST_FOREACH(rxq_ctrl, &priv->sh->shared_rxqs, share_entry) {
+	LIST_FOREACH(rxq_ctrl, &priv->rxqsctrl, next) {
 		DRV_LOG(DEBUG, "port %u Rx Queue %u still referenced",
 			dev->data->port_id, rxq_ctrl->rxq.idx);
 		++ret;
-- 
2.21.0


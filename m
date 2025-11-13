Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AC1CD98D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 19:37:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF53540BA4;
	Thu, 13 Nov 2025 20:37:47 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
 by mails.dpdk.org (Postfix) with ESMTP id 4DED640151;
 Thu, 13 Nov 2025 20:37:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrcPdkqYMxMK78S6ub1zuAc2lH+KsZZ1rHkOFPiy7/f+dysoom0dkn25eZuOpJoud/F8IZ/2Dzxq6Vez6WnqR4ub/jDhZq265oWJhSE50bo7GHN7p8JenA7TQaImO8rGDvgmKWJ7QyKzX5Vil4qOoia4OErCrs7sUp1jQgTef5qgB9woH6oS+uofxxh2C3MgpXVsZtmUDSU26g/16skkSeotAi1HSMre4j6BdatUftxnqcaCKcZ4/1H1UA8oSLe7TTAQ7sbhHKzMEqo5xoqZY98yY+mkInu/0LId5+cYD3isnUDX/bYEhAPfI+P3ANN/klykxigdEYwou2fENoRE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90AaW0oaQrL/V6JprIkSlBVBtFO8AYwDSNYYaP3yUkY=;
 b=TdTVHCWQgV18KxAybSJw5JuU17Z/maTr82MFAzGWKJbXfpykniH22joQD8L5RsLhQ7AIniDAAs4kNpurwbOtLrpvWiWrCM5MBbrecgTtDIZxnoSuNaMCHscLbQQqFuQg1xaiNcyOj2aMBjLteBWz/Zi9nKf5eO2qEXIfc5jnzGJM2affgu685Ndtr5x56OM+hWoieBHLKNr6RvxWM/c6prLSu+0usaP2hSX/ELwH1bWi5UzYuaGRGXFfe66+ROpVG2kavE87Sdyju8TzGA7Cl2mAv8y0C2//KTsPeGonKHGGK7lAjlYHmx2SYvS26tLArLm6afzOtu1CCrzWkQ2eng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90AaW0oaQrL/V6JprIkSlBVBtFO8AYwDSNYYaP3yUkY=;
 b=M20iwOgmUc4Pdj1f0qnFdjXhUbPv4oVqbmpSixLVuGLM+guw7f92GZCZd8xtKSZ6vOjyGQF0/kEatXshElnrmWB2vyp2faAg2aygncGDp86kJymwz7T4glHKShImPSfn9Hqn8T5YplYLqhKfBeI1A3mXPSl7hGwhM+CkU/HfRF1qv89IUmn/2FraLmNMKnJXZ5YreGj2QHzQfE86PBTheN9uQBaC06lYzHh22cTYS8QBfwZpnv+IK6GyVf9fCC95kbC/JVyY6BJr5V2eO38T3bf2OWygBwVWSq8jgaJ3i9YPg8j5lmjdpsEMe4Ct39+Y+S1b6WOUwvxuqBt4lEOAeQ==
Received: from BY1P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::8)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 19:37:40 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:59d:cafe::1) by BY1P220CA0012.outlook.office365.com
 (2603:10b6:a03:59d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 19:37:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 19:37:39 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 11:37:18 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 11:37:17 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 11:37:15 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix state corruption in dev start error path
Date: Thu, 13 Nov 2025 21:37:11 +0200
Message-ID: <20251113193711.7883-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 39bdaa72-8453-4a03-6af6-08de22ec1af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ftovi+VEeZ2my/SfpPULilJDe0y3ZH6Ms374qzVP4adgS+fjDwXHEgm0q8jw?=
 =?us-ascii?Q?RFzWOu+TzhMAk6aHeNUeTbAFsrA8sP29TYH9ly1Z8A2SG4/Lx0Ba5nhfjWel?=
 =?us-ascii?Q?k++crjwthBnISuGMpNFundNTVCmY+HPt6n0d5dEcaJTf1/wsiewQ4R+vxRnq?=
 =?us-ascii?Q?D/wxUDDcctcZwQRp+y1IS2nMsQxAnJAlQ+M1djBt01IcPJ5WMFJJR8eIP99+?=
 =?us-ascii?Q?wCLID76OsvQjM8r21ycxfBauL5yAmDVmlrXxEM1tiZNtjIJV685W9MzDwp2/?=
 =?us-ascii?Q?xW+qwf5HuvGzAb3wmorfiFV6OOgZw05QwITirydcCaLSiLzKhQ1WeUxsOVsC?=
 =?us-ascii?Q?ZBJcg5etExcQyQPvPfYf2bY1Whdrn4sUeVPyyYaoMmhhfJGny2XwXKRNPq+i?=
 =?us-ascii?Q?aqoA/btOkXrR7G8JEb2uubV0fpWJZcW1i4iQFO30bjmkEBjYw5CSJSV9UCLY?=
 =?us-ascii?Q?VbmKv39lHB+k5bva/nSR3K9IDRAI0mF4OBeTLfB/UatvjM8SAB0UzzzHkUC6?=
 =?us-ascii?Q?3HHUXBQJFrujI9DwA9kyGHDNlB9bDd/j4tnv4M3pyh2e9KuQXlBmCFOTR2AP?=
 =?us-ascii?Q?KT3Re8T9D/1yA0JKNytgBQmRLfL0ftyAvEtpD1ggyZxAHuTE3XaRdxQV9x8Q?=
 =?us-ascii?Q?il+NIGaLMCynFKzRzmH6pQW37itrESMdSwJsj4Z6l4CZ1g+sEkGyM9TITAqW?=
 =?us-ascii?Q?eJE++fDIchb5sdOOMV/N0KpHmksswDkeeULTUzQTi+pWDnbDIit++r5A99DE?=
 =?us-ascii?Q?WKIdQwhRfKiYiCI6WE5vasIDC4xJCUwK/lJI4R+CeZBAWaL1Vw/B5V5Qqpw4?=
 =?us-ascii?Q?qP3AinbSOs8azgpJfIJrLnAzUD896QmLDVL+M44C0cf8vBcYdrb9unMjBEQo?=
 =?us-ascii?Q?TE1O+rdoGtagm02DMUirNIv5b1ydVxUUGp1rH9EapqWG9XYyds4HenbRUGo+?=
 =?us-ascii?Q?p10nB3vu0L6iLFU9hf82AfRgKIRBbKPKX0TtnGlX8s1aW1jvK0LexSYRGoGR?=
 =?us-ascii?Q?ACFsWlKryvBIJYra4QOnMnhlwXCZFTKTYYjI5BKKcnLAuwX9N1SJreMaP6Am?=
 =?us-ascii?Q?q+Yqa9p5uI75HNPB5i8oypqtCm7osdbUxHIZJ0IepCajpsEqfvIvUBv1fwPz?=
 =?us-ascii?Q?mGw3vMypGDjPjMOeCAY5Cn6diDEC9rpFMqW8DRz34b6EFMWFMnDARebyHBZb?=
 =?us-ascii?Q?Q/IU1cF0vy/DZD2DYifUJ8TrdZajUVTXFwWbBWEgBOQa/VCccHYddfpYZZya?=
 =?us-ascii?Q?cC1BHXagsG44/gOLzxghY36Tj57M51V34cTO9Fi+zzp32dzSLA8kbf33Bkxz?=
 =?us-ascii?Q?6fsunZChAduRsg8CZftcRGckhmr0N4MNPx7rtTqvX0c1qnO/kT77q/alZc1y?=
 =?us-ascii?Q?1pWdhgefVg3Sqv0LEhCQ+q1nrZ/rmGniyl2WDHg+38Nki9wFAndN20Qp3UMo?=
 =?us-ascii?Q?f+iZNNt3Hb0G9h3wBoXTRVmKd05w1/ZLeS5sgTH/omHa6SsfuEP40CILtPAw?=
 =?us-ascii?Q?QnvDiPeDA9xW+2hQTFB+bmcXs0c4u7/s74sQdpHZFNcURtWjni+lYLz0Al8h?=
 =?us-ascii?Q?dcoif5KqF4APdN/Wg6M=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 19:37:39.1484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bdaa72-8453-4a03-6af6-08de22ec1af3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
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

When mlx5_dev_start() fails partway through initialization, the error
cleanup code unconditionally calls cleanup functions for all steps,
including those that were never successfully initialized. This causes
state corruption leading to incorrect behavior on subsequent start
attempts.

The issue manifests as:
1. First start attempt fails with -ENOMEM (expected)
2. Second start attempt returns -EINVAL instead of -ENOMEM
3. With flow isolated mode, second attempt incorrectly succeeds,
   leading to segfault in rte_eth_rx_burst()

Root cause: The single error label cleanup path calls functions like
mlx5_traffic_disable() and mlx5_flow_stop_default() even when their
corresponding initialization functions (mlx5_traffic_enable() and
mlx5_flow_start_default()) were never called due to earlier failure.

For example, when mlx5_rxq_start() fails:
- mlx5_traffic_enable() at line 1403 never executes
- mlx5_flow_start_default() at line 1420 never executes
- But cleanup unconditionally calls:
  * mlx5_traffic_disable() - destroys control flows list
  * mlx5_flow_stop_default() - corrupts flow metadata state

This corrupts the device state, causing subsequent start attempts to
fail with different errors or, in isolated mode, to incorrectly succeed
with an improperly initialized device.

Fix by replacing the single error label with cascading error labels
(Linux kernel style). Each label cleans up only its corresponding step,
then falls through to clean up earlier steps.
This ensures only successfully initialized steps are cleaned up,
maintaining device state consistency across failed start attempts.

Bugzilla ID: 1419
Fixes: 8db7e3b69822 ("net/mlx5: change operations for non-cached flows")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_trigger.c | 66 +++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 916ac03c164..afe3cb32a89 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1226,6 +1226,11 @@ static void mlx5_dev_free_consec_tx_mem(struct rte_eth_dev *dev, bool on_stop)
 	}
 }
 
+#define SAVE_RTE_ERRNO_AND_STOP(ret, dev) do {	\
+	ret = rte_errno;			\
+	(dev)->data->dev_started = 0;		\
+} while (0)
+
 /**
  * DPDK callback to start the device.
  *
@@ -1316,25 +1321,30 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 	if (ret) {
 		DRV_LOG(ERR, "port %u Tx packet pacing init failed: %s",
 			dev->data->port_id, strerror(rte_errno));
+		SAVE_RTE_ERRNO_AND_STOP(ret, dev);
 		goto error;
 	}
 	if (mlx5_devx_obj_ops_en(priv->sh) &&
 	    priv->obj_ops.lb_dummy_queue_create) {
 		ret = priv->obj_ops.lb_dummy_queue_create(dev);
-		if (ret)
-			goto error;
+		if (ret) {
+			SAVE_RTE_ERRNO_AND_STOP(ret, dev);
+			goto txpp_stop;
+		}
 	}
 	ret = mlx5_dev_allocate_consec_tx_mem(dev);
 	if (ret) {
 		DRV_LOG(ERR, "port %u Tx queues memory allocation failed: %s",
 			dev->data->port_id, strerror(rte_errno));
-		goto error;
+		SAVE_RTE_ERRNO_AND_STOP(ret, dev);
+		goto lb_dummy_queue_release;
 	}
 	ret = mlx5_txq_start(dev);
 	if (ret) {
 		DRV_LOG(ERR, "port %u Tx queue allocation failed: %s",
 			dev->data->port_id, strerror(rte_errno));
-		goto error;
+		SAVE_RTE_ERRNO_AND_STOP(ret, dev);
+		goto free_consec_tx_mem;
 	}
 	if (priv->config.std_delay_drop || priv->config.hp_delay_drop) {
 		if (!priv->sh->dev_cap.vf && !priv->sh->dev_cap.sf &&
@@ -1358,7 +1368,8 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 	if (ret) {
 		DRV_LOG(ERR, "port %u Rx queue allocation failed: %s",
 			dev->data->port_id, strerror(rte_errno));
-		goto error;
+		SAVE_RTE_ERRNO_AND_STOP(ret, dev);
+		goto txq_stop;
 	}
 	/*
 	 * Such step will be skipped if there is no hairpin TX queue configured
@@ -1368,7 +1379,8 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 	if (ret) {
 		DRV_LOG(ERR, "port %u hairpin auto binding failed: %s",
 			dev->data->port_id, strerror(rte_errno));
-		goto error;
+		SAVE_RTE_ERRNO_AND_STOP(ret, dev);
+		goto rxq_stop;
 	}
 	/* Set started flag here for the following steps like control flow. */
 	dev->data->dev_started = 1;
@@ -1376,7 +1388,8 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 	if (ret) {
 		DRV_LOG(ERR, "port %u Rx interrupt vector creation failed",
 			dev->data->port_id);
-		goto error;
+		SAVE_RTE_ERRNO_AND_STOP(ret, dev);
+		goto rxq_stop;
 	}
 	mlx5_os_stats_init(dev);
 	/*
@@ -1388,7 +1401,8 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 		DRV_LOG(ERR,
 			"port %u failed to attach indirect actions: %s",
 			dev->data->port_id, rte_strerror(rte_errno));
-		goto error;
+		SAVE_RTE_ERRNO_AND_STOP(ret, dev);
+		goto rx_intr_vec_disable;
 	}
 #ifdef HAVE_MLX5_HWS_SUPPORT
 	if (priv->sh->config.dv_flow_en == 2) {
@@ -1396,7 +1410,8 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 		if (ret) {
 			DRV_LOG(ERR, "port %u failed to update HWS tables",
 				dev->data->port_id);
-			goto error;
+			SAVE_RTE_ERRNO_AND_STOP(ret, dev);
+			goto action_handle_detach;
 		}
 	}
 #endif
@@ -1404,7 +1419,8 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 	if (ret) {
 		DRV_LOG(ERR, "port %u failed to set defaults flows",
 			dev->data->port_id);
-		goto error;
+		SAVE_RTE_ERRNO_AND_STOP(ret, dev);
+		goto action_handle_detach;
 	}
 	/* Set dynamic fields and flags into Rx queues. */
 	mlx5_flow_rxq_dynf_set(dev);
@@ -1421,12 +1437,14 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 	if (ret) {
 		DRV_LOG(DEBUG, "port %u failed to start default actions: %s",
 			dev->data->port_id, strerror(rte_errno));
-		goto error;
+		SAVE_RTE_ERRNO_AND_STOP(ret, dev);
+		goto traffic_disable;
 	}
 	if (mlx5_dev_ctx_shared_mempool_subscribe(dev) != 0) {
 		DRV_LOG(ERR, "port %u failed to subscribe for mempool life cycle: %s",
 			dev->data->port_id, rte_strerror(rte_errno));
-		goto error;
+		SAVE_RTE_ERRNO_AND_STOP(ret, dev);
+		goto stop_default;
 	}
 	if (mlx5_flow_is_steering_disabled())
 		mlx5_flow_rxq_mark_flag_set(dev);
@@ -1455,19 +1473,27 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 		priv->sh->port[priv->dev_port - 1].devx_ih_port_id =
 					(uint32_t)dev->data->port_id;
 	return 0;
-error:
-	ret = rte_errno; /* Save rte_errno before cleanup. */
-	/* Rollback. */
-	dev->data->dev_started = 0;
+stop_default:
 	mlx5_flow_stop_default(dev);
+traffic_disable:
 	mlx5_traffic_disable(dev);
-	mlx5_txq_stop(dev);
+action_handle_detach:
+	mlx5_action_handle_detach(dev);
+rx_intr_vec_disable:
+	mlx5_rx_intr_vec_disable(dev);
+rxq_stop:
 	mlx5_rxq_stop(dev);
+txq_stop:
+	mlx5_txq_stop(dev);
+free_consec_tx_mem:
+	mlx5_dev_free_consec_tx_mem(dev, false);
+lb_dummy_queue_release:
 	if (priv->obj_ops.lb_dummy_queue_release)
 		priv->obj_ops.lb_dummy_queue_release(dev);
-	mlx5_dev_free_consec_tx_mem(dev, false);
-	mlx5_txpp_stop(dev); /* Stop last. */
-	rte_errno = ret; /* Restore rte_errno. */
+txpp_stop:
+	mlx5_txpp_stop(dev);
+error:
+	rte_errno = ret;
 	return -rte_errno;
 }
 
-- 
2.21.0


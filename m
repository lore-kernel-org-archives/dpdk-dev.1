Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AB8606A337
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nvLYPHIk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E364940297;
	Tue, 20 Oct 2026 13:59:34 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
 by mails.dpdk.org (Postfix) with ESMTP id 020A640144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 13:59:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xu70jzuWe1AzqjnuCRv2Bj5IUF6gYcrulHk7RrJ3+deCFE/4PZBQT2UbLTIEp9uNquMluzjndUuEpahRSRDTfMWG8B1Tkk/YKgyASVXHfxhF4kbtT9y5hzENoZcXUgoaX2uKmZALC5c56yOSGSQW72OOceBvMvE0oYeZfVlFxyCVmczM5OBXjDxUhuz8CZ9ivC8GFQEaSWNPWmDtx4UEgtc9A/gxNnNRsC33HG3gELjg8p7IKorePSe3lNqz6ghcjyIJKNAx2bqCNgmthX4ukhYu3MQ2mLxTFlIskeqhCeegcnb+9pCR758/dmFb3U6SsZgxfVhnC4oMbb4oGQcfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDDXJN8qxyE8W34k9mw1ajltHc8A2+jbqiG1RLQvGhc=;
 b=lzxrSKoeZPPN0ZLhFKzq481RibELtv7ziogUuMyn0HBnAGB4IbZpFVfAPwE9cfVTFPCbVGl8yxxhZltTdNUVnPYaPfXggseKU5ZXfjKJAQ2pxOJlpEU9mJ1VxE/7C92KGlnuXicsE0823y7f5Q/CvJKXWoNmPr0X6Z4NbIGRuDKUBFiu8OjZjT9noV22fFCZyqQmiJJxGpEl2sNTkXSCIzSZgGYMRNmYmOEf6/VA72d/812+zTxbmFuxzVa2OqaIHA/2Vvw4rO4Tuzb3RzsMBy5HGl5pIrq2+BmRpwXuDaxilMovnxBGoGnPCKm35nDDRJnv7uJACFRUn2EvyL0qtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDDXJN8qxyE8W34k9mw1ajltHc8A2+jbqiG1RLQvGhc=;
 b=nvLYPHIkTheQ8Hv/DL36QX2hPYleFLzk6XgPv72PRc1oGSbcw0Zo4vpmEeBPwFGOSgTGmRQGZxDrwKwQtqK5skGe8TCPnqTxqzTuN5DSxCD80TlMZ2LgfPWD6G58CE3hbaj0oeGpjkxqPw97yTfnQFJMAmwtIw5yTzhuXIzQr7HwQeui8vzVZcu62ewBxLZMaVa0AGn91DWABcr9BiAjYPSEF8MWx/tdMivgZ2l6bGzpfmsmg45TYULGK3BlA93bxEkHA39mX4kyLfiCIweI6XS5+9Ws8FlnV5WVs+6BjvD21xWOJKixg7+CwfDIZN/Jmqp0lrrHT/PEwf4ACaJqzA==
Received: from BL1P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::12)
 by SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 11:59:25 +0000
Received: from IA0PEPF00000046.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::6a) by BL1P222CA0007.outlook.office365.com
 (2603:10b6:208:2c7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 20
 Oct 2026 11:59:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 IA0PEPF00000046.mail.protection.outlook.com (10.167.249.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 11:59:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 04:59:06 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 20 Oct 2026 04:59:06 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 20 Oct 2026 04:59:04 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH 1/2] net/mlx5: distinguish DevX availability from DevX use
Date: Tue, 20 Oct 2026 14:58:58 +0300
Message-ID: <20261020115859.96750-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000046:EE_|SJ2PR12MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: b882c74a-0c6f-4234-5669-08df2ea19588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|261009223027099003|11063799006|18002099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: XdXnPWF5PgVfNAbs02aoa1TZ+TrvaaaGs38il8BFQWT4UUQrZcHTKLySGiPW3gtucY8Qwzr5jhGquPrkIitRePaY/gddpQKAdVsrM/FJZYu1hOYBBfRRm4nKsIqeOV4FnHgrH4CDidQKj4a0Plv2/1aXzKcn0NBq0tfJAnGmh+vdB3iyWtJa0BJVVgoO3A0OE4WX5P0oQASPjYbqCXd0Ow/ju7tHykd0VSHJfu26RfLLpaqj6y7vWsvl4ugZGYdTd8dc7+Gw8MYkc6E2KCIQNmHzbmDrWCxjw+PN2fqIWKpD3Mt8ZFdl0ZJkJPOCqBYZ8+xrrtjFVz+uvam2fTGHb6DWdZmNldhHcJZHaveQT1k8/IcDhJSEwqCrWjSYVs6YdHz+ozt72/2ulTDWcZz5GsGzArSO8g5WkgbpRfH2aGF6I+tfXDDjqFC3ITt4DHmUe/44q3Wq3oyg1Lv6B+6RVEEu2sAP+CRwIfG3WhTfhO55zYsrZKECPT6HAwUfmd+2XR482cVNvp3YvpVTwzWtIZ5Oa/aPqPyV9g1kOS7krkNfLYmQvPj9veHZlOL5AK1Rxc3R9viVFTL1rxyG5RqswfVMF2uYaLdvNj+BhgrONvX1IT2GBJhx3K/JySjVoH3Y80cJUoHCAvdbR4T8uLO+K16oOEjp1ci+2cPTR/Aku7+uZIb989w6imZc0+SuxLLuQgysjylH1a2TCVyFP29zqw==
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(261009223027099003)(11063799006)(18002099003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NZIdUyEKAjdtuSu1PXV51vv7Ff6uO2EH83lZ8gKCT0z1lezr4PDnrZ8YkFVQPJ93ezWpzGFk3GCqUSk1xmAAu06v/kUoYCoXVKSMXJbFKE5pQn6AGVwng2HztEkVCIAXnpuTKx9hQSej4nNn7zHWXOGICo3XSQ+YCH2KP/6Q6ZcK1skCMkAH5WsVPfXmHmyO+qF+pzyEHxMaMKFi6sL+cuAeID+Ur4XcHiNij0gyWYwLxU7sTbzX3V84br2/Ymu6VrMJFUy0NTAfKrzwZ2stm9lpm6ytpjQA0K6awf6fluN4gjwwgnGxCZ5FnH1FhWNpUbFhsEYXN7iiPNxUt+dxijC2sK8W4jGvm7gASzku1e9Ez6qKnGdqNiIKT/5GN7o64bXGrvsHZ2E9IeHpM4AfmV7bQUG+w13LSznLghXHkjhKsw02q4Cp756arzekwPTv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 11:59:24.1539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b882c74a-0c6f-4234-5669-08df2ea19588
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000046.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8136
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mlx5_devx_obj_ops_en() required DV flow and Dest TIR in addition to
DevX. Dest TIR is never set on Windows, so common code treated DevX
ports as Verbs. LRO stayed disabled although the device supports it.

Split the two questions. mlx5_devx_available() reports whether DevX
exists. mlx5_devx_obj_ops_en() reports whether the port selected DevX
object operations, using a flag in struct mlx5_obj_ops. Linux still
requires DV flow and Dest TIR when choosing those operations.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c    | 56 ++++++++++++++---------------
 drivers/net/mlx5/linux/mlx5_verbs.c |  1 +
 drivers/net/mlx5/mlx5.c             |  2 +-
 drivers/net/mlx5/mlx5.h             | 33 ++++++++++-------
 drivers/net/mlx5/mlx5_devx.c        |  3 +-
 drivers/net/mlx5/mlx5_ethdev.c      |  2 +-
 drivers/net/mlx5/mlx5_trigger.c     |  2 +-
 drivers/net/mlx5/mlx5_txq.c         | 10 +++---
 8 files changed, 59 insertions(+), 50 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 7c2c35c9454..4c357372929 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1446,31 +1446,6 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 		err = ENOMEM;
 		goto error;
 	}
-	/*
-	 * When user configures remote PD and CTX and device creates RxQ by
-	 * DevX, external RxQ is both supported and requested.
-	 */
-	if (mlx5_imported_pd_and_ctx(sh->cdev) && mlx5_devx_obj_ops_en(sh)) {
-		priv->ext_rxqs = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
-					     sizeof(struct mlx5_external_q) *
-					     MLX5_MAX_EXT_RX_QUEUES, 0,
-					     SOCKET_ID_ANY);
-		if (priv->ext_rxqs == NULL) {
-			DRV_LOG(ERR, "Fail to allocate external RxQ array.");
-			err = ENOMEM;
-			goto error;
-		}
-		priv->ext_txqs = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
-					     sizeof(struct mlx5_external_q) *
-					     MLX5_MAX_EXT_TX_QUEUES, 0,
-					     SOCKET_ID_ANY);
-		if (priv->ext_txqs == NULL) {
-			DRV_LOG(ERR, "Fail to allocate external TxQ array.");
-			err = ENOMEM;
-			goto error;
-		}
-		DRV_LOG(DEBUG, "External queue is supported.");
-	}
 	priv->sh = sh;
 	priv->dev_port = spawn->phys_port;
 	priv->pci_dev = spawn->pci_dev;
@@ -1822,7 +1797,8 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	}
 	/* Create context for virtual machine VLAN workaround. */
 	priv->vmwa_context = mlx5_vlan_vmwa_init(eth_dev, spawn->ifindex);
-	if (mlx5_devx_obj_ops_en(sh)) {
+	/* Linux DevX object operations also require DV flow and Dest TIR. */
+	if (mlx5_devx_available(sh) && sh->config.dv_flow_en && sh->dev_cap.dest_tir) {
 		priv->obj_ops = mlx5_devx_obj_ops;
 		mlx5_queue_counter_id_prepare(eth_dev);
 		priv->obj_ops.lb_dummy_queue_create =
@@ -1837,8 +1813,32 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	} else {
 		priv->obj_ops = mlx5_ibv_obj_ops;
 	}
-	if (sh->config.tx_pp &&
-	    priv->obj_ops.txq_obj_new != mlx5_txq_devx_obj_new) {
+	/*
+	 * When user configures remote PD and CTX and device creates RxQ by
+	 * DevX, external RxQ is both supported and requested.
+	 */
+	if (mlx5_imported_pd_and_ctx(sh->cdev) && mlx5_devx_obj_ops_en(priv)) {
+		priv->ext_rxqs = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
+					     sizeof(struct mlx5_external_q) *
+					     MLX5_MAX_EXT_RX_QUEUES, 0,
+					     SOCKET_ID_ANY);
+		if (priv->ext_rxqs == NULL) {
+			DRV_LOG(ERR, "Fail to allocate external RxQ array.");
+			err = ENOMEM;
+			goto error;
+		}
+		priv->ext_txqs = mlx5_malloc(MLX5_MEM_ZERO | MLX5_MEM_RTE,
+					     sizeof(struct mlx5_external_q) *
+					     MLX5_MAX_EXT_TX_QUEUES, 0,
+					     SOCKET_ID_ANY);
+		if (priv->ext_txqs == NULL) {
+			DRV_LOG(ERR, "Fail to allocate external TxQ array.");
+			err = ENOMEM;
+			goto error;
+		}
+		DRV_LOG(DEBUG, "External queue is supported.");
+	}
+	if (sh->config.tx_pp && !mlx5_devx_obj_ops_en(priv)) {
 		/*
 		 * HAVE_MLX5DV_DEVX_UAR_OFFSET is required to support
 		 * packet pacing and already checked above.
diff --git a/drivers/net/mlx5/linux/mlx5_verbs.c b/drivers/net/mlx5/linux/mlx5_verbs.c
index 103a03bd1ab..ce0a26c62bf 100644
--- a/drivers/net/mlx5/linux/mlx5_verbs.c
+++ b/drivers/net/mlx5/linux/mlx5_verbs.c
@@ -1242,4 +1242,5 @@ struct mlx5_obj_ops mlx5_ibv_obj_ops = {
 	.txq_obj_release = mlx5_txq_ibv_obj_release,
 	.lb_dummy_queue_create = NULL,
 	.lb_dummy_queue_release = NULL,
+	.devx = false,
 };
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 19491b9dc95..e2dbd2977b7 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1588,7 +1588,7 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 		config->tx_typical_pkt_sz = 0;
 	}
 	/* Check for LRO support. */
-	if (mlx5_devx_obj_ops_en(sh) && sh->cdev->config.hca_attr.lro_cap) {
+	if (mlx5_devx_available(sh) && sh->cdev->config.hca_attr.lro_cap) {
 		/* TBD check tunnel lro caps. */
 		config->lro_allowed = 1;
 		DRV_LOG(DEBUG, "LRO is allowed.");
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index e3df458915c..7923125c5cb 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -1862,6 +1862,7 @@ struct mlx5_obj_ops {
 	void (*txq_obj_release)(struct mlx5_txq_obj *txq_obj);
 	int (*lb_dummy_queue_create)(struct rte_eth_dev *dev);
 	void (*lb_dummy_queue_release)(struct rte_eth_dev *dev);
+	bool devx; /* True when these are DevX object operations. */
 };
 
 enum mlx5_ctrl_flow_type {
@@ -2241,27 +2242,35 @@ mlx5_flow_action_job_init(struct mlx5_priv *priv, uint32_t queue,
 #endif
 
 /**
- * Indicates whether HW objects operations can be created by DevX.
+ * Indicates whether DevX is available on the device.
  *
- * This function is used for both:
- *  Before creation - deciding whether to create HW objects operations by DevX.
- *  After creation - indicator if HW objects operations were created by DevX.
+ * Availability does not mean DevX object operations were selected.
  *
  * @param sh
  *   Pointer to shared device context.
  *
  * @return
- *   True if HW objects were created by DevX, False otherwise.
+ *   True if DevX is available, false otherwise.
  */
 static inline bool
-mlx5_devx_obj_ops_en(struct mlx5_dev_ctx_shared *sh)
+mlx5_devx_available(struct mlx5_dev_ctx_shared *sh)
 {
-	/*
-	 * When advanced DR API is available and DV flow is supported and
-	 * DevX is supported, HW objects operations are created by DevX.
-	 */
-	return (sh->cdev->config.devx && sh->config.dv_flow_en &&
-		sh->dev_cap.dest_tir);
+	return sh->cdev->config.devx;
+}
+
+/**
+ * Indicates whether the port uses DevX object operations.
+ *
+ * @param priv
+ *   Pointer to port private data.
+ *
+ * @return
+ *   True if DevX object operations are selected, false otherwise.
+ */
+static inline bool
+mlx5_devx_obj_ops_en(struct mlx5_priv *priv)
+{
+	return priv->obj_ops.devx;
 }
 
 /**
diff --git a/drivers/net/mlx5/mlx5_devx.c b/drivers/net/mlx5/mlx5_devx.c
index 4b30a4fade5..abb8e6588f4 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -58,7 +58,7 @@ mlx5_devx_extq_port_validate(uint16_t port_id)
 		rte_errno = ENOTSUP;
 		return -rte_errno;
 	}
-	if (!mlx5_devx_obj_ops_en(priv->sh)) {
+	if (!mlx5_devx_obj_ops_en(priv)) {
 		DRV_LOG(ERR,
 			"Port %u external queue isn't supported by Verbs API.",
 			port_id);
@@ -1754,4 +1754,5 @@ struct mlx5_obj_ops mlx5_devx_obj_ops = {
 	.txq_obj_release = mlx5_txq_devx_obj_release,
 	.lb_dummy_queue_create = NULL,
 	.lb_dummy_queue_release = NULL,
+	.devx = true,
 };
diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index 306c1cd734e..26ee58d1641 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -925,7 +925,7 @@ mlx5_hairpin_cap_get(struct rte_eth_dev *dev, struct rte_eth_hairpin_cap *cap)
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_hca_attr *hca_attr;
 
-	if (!mlx5_devx_obj_ops_en(priv->sh)) {
+	if (!mlx5_devx_obj_ops_en(priv)) {
 		rte_errno = ENOTSUP;
 		return -rte_errno;
 	}
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index c5f493117ba..ef71b59fe9c 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1364,7 +1364,7 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 		SAVE_RTE_ERRNO_AND_STOP(ret, dev);
 		goto error;
 	}
-	if (mlx5_devx_obj_ops_en(priv->sh) &&
+	if (mlx5_devx_obj_ops_en(priv) &&
 	    priv->obj_ops.lb_dummy_queue_create) {
 		ret = priv->obj_ops.lb_dummy_queue_create(dev);
 		if (ret) {
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index f9b254c6c5d..aa43cb16127 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -695,19 +695,17 @@ mlx5_txq_obj_verify(struct rte_eth_dev *dev)
  *
  * @param txq_ctrl
  *   Pointer to Tx queue control structure.
- * @param devx
- *   If the calculation is used for Devx queue.
  *
  * @return
  *   The number of WQEBB.
  */
 static int
-txq_calc_wqebb_cnt(struct mlx5_txq_ctrl *txq_ctrl, bool devx)
+txq_calc_wqebb_cnt(struct mlx5_txq_ctrl *txq_ctrl)
 {
 	unsigned int wqe_size;
 	const unsigned int desc = 1 << txq_ctrl->txq.elts_n;
 
-	if (devx) {
+	if (mlx5_devx_obj_ops_en(txq_ctrl->priv)) {
 		wqe_size = txq_ctrl->txq.tso_en ?
 			   RTE_ALIGN(txq_ctrl->max_tso_header, MLX5_WSEG_SIZE) : 0;
 		wqe_size += MLX5_WQE_CSEG_SIZE +
@@ -1171,7 +1169,7 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	tmpl->txq.idx = idx;
 	txq_set_params(tmpl);
 	txq_adjust_params(tmpl);
-	wqebb_cnt = txq_calc_wqebb_cnt(tmpl, !!mlx5_devx_obj_ops_en(priv->sh));
+	wqebb_cnt = txq_calc_wqebb_cnt(tmpl);
 	max_wqe = mlx5_dev_get_max_wq_size(priv->sh);
 	if (wqebb_cnt > max_wqe) {
 		DRV_LOG(ERR,
@@ -1721,7 +1719,7 @@ int mlx5_map_aggr_tx_affinity(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 	struct mlx5_priv *priv;
 
 	priv = dev->data->dev_private;
-	if (!mlx5_devx_obj_ops_en(priv->sh)) {
+	if (!mlx5_devx_obj_ops_en(priv)) {
 		DRV_LOG(ERR, "Tx affinity mapping isn't supported by Verbs API.");
 		rte_errno = ENOTSUP;
 		return -rte_errno;
-- 
2.21.0


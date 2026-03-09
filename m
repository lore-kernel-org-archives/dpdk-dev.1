Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF3FF3C241
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 12:48:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 781BF402BE;
	Mon,  9 Mar 2026 13:48:28 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
 by mails.dpdk.org (Postfix) with ESMTP id 5BE1740261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 13:48:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fy25Rqp20E3u55UsdIy10EGOK0+dh9Qp3jJIwLd1zzjIqKW1f5xgAyWocvbHXmfnZu8oMiDjTpelUm/DkGWQ+9MY6RtxOE+VvmVoMuFsoZ8a1PkKVrb3NKC70fyAlOs7PiF3u1XrAHWFxj3YAPDm2uEQXg/vt8MyfzkW3WVeruvgpMrsWdvKlrCYSxRFj29dKAgZbqQCzftL/U7ejm068jv8rfalSq23lG0eMLAJglNSY6JSDys5Y6ZMwM9yoedWl1iNTe3pvD7fqfbjrzXDa6+4oe9ayu0kNd44KBV8/0ZeCshnurII6megJGj07Xy8zNFD1QvATdh7MNNLCKPzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVFCqbvrypONY/FIGcgFn5WSn1egT3x6eDcKkoLkGnc=;
 b=B1t2aQHdGOQkuRldgz/LY1EYv7GBw9u2FCb7Qr85zPNFNNaZyO7sfTR5FP5utUWzyZO9Yw12k8rSjgYzhugVRnufojin8H5WdcM08vkggBLFsarrBb0+aGNZ/9bj6oLy4A0BvZ7zL2V0vk/4ot27Xqv5f317ae4RLqwVjPNoCLZLQRSLNgLWRbZZf7ie+tbVkPggCDGOAli48NYF2FcoIK0wHAOOzZvnwr+e2MQwFfW97yT3kQ3qON3lfRsjUkIDdOqMkh6+dJ2AdlLu4fE9EYYfSl9RmAXf7lVKEFF/F2q8oHM4O4GwhZ7ztRsAMs1PBwt9JtJ9VoidUnwLEhywpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVFCqbvrypONY/FIGcgFn5WSn1egT3x6eDcKkoLkGnc=;
 b=q1B2R8Hn/7n041SDpkBb9Ae4AaMDKBWYD7k24oKn3tnA/YtWwtuuHV2pcAK2nBLX84b2AcT+r/8YElT4IG6WuRvt05Ak+SfjjdwWRNJ4JObQRYK12CNwUepU798K2xVQF4YyB19B6aGxpnEe5nZ5cefaM2Y85nWRcEkm/PNSVZXBCe0Zg7wbjOPYsUMd5GnMHAdg6jJym3AxdHqD2q2MtnNkvi+aPCM2X8+6Vm/rSQLaHJLjfb4XPHctqFK/oF96L/Lcgii35mA+0WsUv+VtgyCsiHCP2iOo9QmjbzZwFl9yLqN+wwjL/qHTwiPfu2LY+3iWPYGjMij8guGWDj7YYQ==
Received: from CY5PR15CA0147.namprd15.prod.outlook.com (2603:10b6:930:67::16)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 12:48:20 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:67:cafe::35) by CY5PR15CA0147.outlook.office365.com
 (2603:10b6:930:67::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 12:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 12:48:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 05:48:03 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 05:48:01 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Maayan Kashani
 <mkashani@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH] net/mlx5: fix default flow engine on Windows
Date: Mon, 9 Mar 2026 13:47:53 +0100
Message-ID: <20260309124754.226628-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a33d6e-c94f-4db6-9880-08de7dda24ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016; 
X-Microsoft-Antispam-Message-Info: j3NjdMV0jLktqlKI8t5oJQDvDuA0Motkbkqw7Liuqcup1JWOUgyUN/ACRhBxmXhLNHEXwKhWy+QT+hyODHh9F81YI2kOYN9Rzwq9saqTE6gnGlWonbrDkYHOxofwypKtAeFY2yjp/eirD3lFdLfKABO1Wby5EQz0uwLWebWaz7VTZeurUmscgUS21Rzf582+LtZqlGviEvK5UG+i2KVmml++QuwVODP3jjwmET3vXcghZ5bqxI3FcXJzHyO1fxqhiXkkYbMcO6yKT3QOW2g3B0ibT03p0UNPgvGa7qJ3X4q8YAUe1TXO8HMOjK6bTsc1DMKOyg5APJmj5O3aoHLmDmgTzgfdmJMkr328Xrs/gKWF+7e66c+BSWB24Qp1hFKO9HmxocNrHGhwQ672nhPaEuKDoqvQd7Y2j/A4owvHcJAuRqSgH3a3APJf3LN2iLIgS7fuAIRtObdl9CXMwHwvkh/FfeHpIDfrhkv1lW76efXqto6BkJX5ttHjnAU6NZ89y5m23MaH6FYLDQy0l5j9pxahFPVCcEgcmgk97i2F5kHqos9iP/T/U0Rjbxw8A49MSRg3kXEqvlaN5yWrK/JTdRbbHmmg1hKRBc6Cuext7V4pIsBxzq+qcyphfEXaxJce3kDKhfrxSecyTU5kC5//kEwAI4Dk5RYgamy0IlLBI3n4MB339YgMFJgn0Qx+xzshY7vwTJe13jZEilr51/b4DnbEl0LrmeINmlg8DfYai9svHTu2W3ntKbt4jijaEUQa/3HkQJmkXpaoZzjM/5eWUQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fQ7qpgPUm4GHakAnJEUowbb45jJdQolhzhibJPZnORr99HPuPhO8a4A6exfJfH878sYW8pS8LmmhkKqbPqo4ZsGLDAy0QwfY6rb3XpoeToutHStWREWQzPOUWLHVwVq6Ykgj+kBgrP9Dq+slQqPzB7ujf3+sPa04w7eS2X9+FcKWMYn8umNmnr7sbSOcb/eN4osP6LflNlo7lXTfmY85E2teV/oT4QoqDtVggZ6ESm94S5b2K9AF5OuQsa9skCqNWEFVOK4BvLpWkv21n0bHw4JIl2unBm7E7iODugQrqy55kZ4EmVn+zNdqeC4bzPC+/R/Uxw/kgJj4EjHev8+88u5jX0RuRdE4WwW3PgRzNHMnrSlBU3zJT4etCiZVuvV/TsRpmCb8U5nR/zY4J/Ka3ekkCBOv0B1riRchsPwGD+1FPbqaNqfQNNqwxfRRhUIq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 12:48:20.4218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a33d6e-c94f-4db6-9880-08de7dda24ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630
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

Offending patch has changed the logic for handling default
configuration for dv_flow_en device argument.
This change has introduced a regression to Windows support.
On Windows, mlx5 PMD only supports flow API implementation
with dv_flow_en set to 1. With the change, this argument value was
changed based on device capabilities.
On newer NICs, dv_flow_en would be set to HW Steering flow engine
which is not supported on Windows.
On older NICs, it would be set to Verbs engine, which is also not
supported.

This patch fixes that by introducing platform-specific initialization
and fixup of relevant device arguments i.e., dv_flow_en and
allow_duplicate_pattern.
On Linux the existing logic is kept. On Windows dv_flow_en and
allow_duplicate_pattern are set by default to 1 (same as before
the offending patch).

Fixes: 170ebe941be3 ("net/mlx5: fix flow devargs handling for future HW")

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c   |  98 ++++++++++++++++++++++++++++
 drivers/net/mlx5/linux/mlx5_os.h   |   1 +
 drivers/net/mlx5/mlx5.c            | 100 ++++++++---------------------
 drivers/net/mlx5/mlx5.h            |   9 +++
 drivers/net/mlx5/windows/mlx5_os.c |  23 +++++++
 5 files changed, 158 insertions(+), 73 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 76edd19c70..01adcfc916 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -3371,3 +3371,101 @@ mlx5_os_mac_addr_flush(struct rte_eth_dev *dev)
 			       dev->data->mac_addrs,
 			       MLX5_MAX_MAC_ADDRESSES, priv->mac_own, vf);
 }
+
+static bool
+mlx5_hws_is_supported(struct mlx5_dev_ctx_shared *sh)
+{
+	return (sh->cdev->config.devx &&
+	       sh->cdev->config.hca_attr.wqe_based_flow_table_sup);
+}
+
+static bool
+mlx5_sws_is_any_supported(struct mlx5_dev_ctx_shared *sh)
+{
+	struct mlx5_common_device *cdev = sh->cdev;
+	struct mlx5_hca_attr *hca_attr = &cdev->config.hca_attr;
+
+	if (hca_attr->rx_sw_owner_v2 || hca_attr->rx_sw_owner)
+		return true;
+
+	if (hca_attr->tx_sw_owner_v2 || hca_attr->tx_sw_owner)
+		return true;
+
+	if (hca_attr->eswitch_manager && (hca_attr->esw_sw_owner_v2 || hca_attr->esw_sw_owner))
+		return true;
+
+	return false;
+}
+
+/**
+ * Initialize default shared configuration for arguments related to flow engine.
+ *
+ * @param[in] sh
+ *   Pointer to shared configuration.
+ * @param[in] sh
+ *   Pointer to shared device context.
+ */
+void
+mlx5_os_default_flow_config(struct mlx5_sh_config *config, struct mlx5_dev_ctx_shared *sh)
+{
+	bool hws_is_supported = mlx5_hws_is_supported(sh);
+	bool sws_is_supported = mlx5_sws_is_any_supported(sh);
+
+	if (!sws_is_supported && hws_is_supported)
+		config->dv_flow_en = 2;
+	else
+		config->dv_flow_en = 1;
+
+	if (config->dv_flow_en == 2)
+		config->allow_duplicate_pattern = 0;
+	else
+		config->allow_duplicate_pattern = 1;
+}
+
+static bool
+mlx5_kvargs_is_used(struct mlx5_kvargs_ctrl *mkvlist, const char *key)
+{
+	const struct rte_kvargs_pair *pair;
+	uint32_t i;
+
+	for (i = 0; i < mkvlist->kvlist->count; ++i) {
+		pair = &mkvlist->kvlist->pairs[i];
+		if (strcmp(pair->key, key) == 0 && mkvlist->is_used[i])
+			return true;
+	}
+	return false;
+}
+
+void mlx5_os_fixup_flow_en(struct mlx5_sh_config *config,
+			   struct mlx5_dev_ctx_shared *sh)
+{
+	bool hws_is_supported = mlx5_hws_is_supported(sh);
+	bool sws_is_supported = mlx5_sws_is_any_supported(sh);
+
+	/* Inform user if DV flow is not supported. */
+	if (config->dv_flow_en == 1 && !sws_is_supported && hws_is_supported) {
+		DRV_LOG(WARNING, "DV flow is not supported. Changing to HWS mode.");
+		config->dv_flow_en = 2;
+	}
+}
+
+void
+mlx5_os_fixup_duplicate_pattern(struct mlx5_sh_config *config,
+				struct mlx5_kvargs_ctrl *mkvlist,
+				const char *key)
+{
+	/* Handle allow_duplicate_pattern based on final dv_flow_en mode.
+	 * HWS mode (dv_flow_en=2) doesn't support duplicate patterns.
+	 * Warn only if user explicitly requested an incompatible setting.
+	 */
+	bool allow_dup_pattern_set = mkvlist != NULL &&
+		mlx5_kvargs_is_used(mkvlist, key);
+	if (config->dv_flow_en == 2) {
+		if (config->allow_duplicate_pattern == 1 && allow_dup_pattern_set)
+			DRV_LOG(WARNING, "Duplicate pattern is not supported with HWS. Disabling it.");
+		config->allow_duplicate_pattern = 0;
+	} else if (!allow_dup_pattern_set) {
+		/* Non-HWS mode: set default to 1 only if not explicitly set by user */
+		config->allow_duplicate_pattern = 1;
+	}
+}
diff --git a/drivers/net/mlx5/linux/mlx5_os.h b/drivers/net/mlx5/linux/mlx5_os.h
index 4ef0916173..4d073048fb 100644
--- a/drivers/net/mlx5/linux/mlx5_os.h
+++ b/drivers/net/mlx5/linux/mlx5_os.h
@@ -42,4 +42,5 @@ enum mlx5_tunnel_offloads {
 	MLX5_TUNNELED_OFFLOADS_GENEVE_CAP = 0,
 #endif
 };
+
 #endif /* RTE_PMD_MLX5_OS_H_ */
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 4e0bc26754..e795948187 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1461,45 +1461,6 @@ mlx5_dev_args_check_handler(const char *key, const char *val, void *opaque)
 	return 0;
 }
 
-static bool
-mlx5_hws_is_supported(struct mlx5_dev_ctx_shared *sh)
-{
-	return (sh->cdev->config.devx &&
-	       sh->cdev->config.hca_attr.wqe_based_flow_table_sup);
-}
-
-static bool
-mlx5_sws_is_any_supported(struct mlx5_dev_ctx_shared *sh)
-{
-	struct mlx5_common_device *cdev = sh->cdev;
-	struct mlx5_hca_attr *hca_attr = &cdev->config.hca_attr;
-
-	if (hca_attr->rx_sw_owner_v2 || hca_attr->rx_sw_owner)
-		return true;
-
-	if (hca_attr->tx_sw_owner_v2 || hca_attr->tx_sw_owner)
-		return true;
-
-	if (hca_attr->eswitch_manager && (hca_attr->esw_sw_owner_v2 || hca_attr->esw_sw_owner))
-		return true;
-
-	return false;
-}
-
-static bool
-mlx5_kvargs_is_used(struct mlx5_kvargs_ctrl *mkvlist, const char *key)
-{
-	const struct rte_kvargs_pair *pair;
-	uint32_t i;
-
-	for (i = 0; i < mkvlist->kvlist->count; ++i) {
-		pair = &mkvlist->kvlist->pairs[i];
-		if (strcmp(pair->key, key) == 0 && mkvlist->is_used[i])
-			return true;
-	}
-	return false;
-}
-
 /**
  * Parse user device parameters and adjust them according to device
  * capabilities.
@@ -1540,8 +1501,6 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 	int ret = 0;
 	size_t alignment = rte_mem_page_size();
 	uint32_t max_queue_umem_size = MLX5_WQE_SIZE * mlx5_dev_get_max_wq_size(sh);
-	bool hws_is_supported = mlx5_hws_is_supported(sh);
-	bool sws_is_supported = mlx5_sws_is_any_supported(sh);
 
 	if (alignment == (size_t)-1) {
 		alignment = (1 << MLX5_LOG_PAGE_SIZE);
@@ -1550,17 +1509,10 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 
 	/* Default configuration. */
 	memset(config, 0, sizeof(*config));
+	mlx5_os_default_flow_config(config, sh);
 	config->vf_nl_en = 1;
 	config->dv_esw_en = 1;
-	if (!sws_is_supported && hws_is_supported)
-		config->dv_flow_en = 2;
-	else
-		config->dv_flow_en = 1;
 	config->decap_en = 1;
-	if (config->dv_flow_en == 2)
-		config->allow_duplicate_pattern = 0;
-	else
-		config->allow_duplicate_pattern = 1;
 	config->fdb_def_rule = 1;
 	config->cnt_svc.cycle_time = MLX5_CNT_SVC_CYCLE_TIME_DEFAULT;
 	config->cnt_svc.service_core = rte_get_main_lcore();
@@ -1576,30 +1528,7 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 		}
 	}
 	/* Adjust parameters according to device capabilities. */
-	if (config->dv_flow_en && !sh->dev_cap.dv_flow_en) {
-		DRV_LOG(WARNING, "DV flow is not supported.");
-		config->dv_flow_en = 0;
-	}
-	/* Inform user if DV flow is not supported. */
-	if (config->dv_flow_en == 1 && !sws_is_supported && hws_is_supported) {
-		DRV_LOG(WARNING, "DV flow is not supported. Changing to HWS mode.");
-		config->dv_flow_en = 2;
-	}
-	/* Handle allow_duplicate_pattern based on final dv_flow_en mode.
-	 * HWS mode (dv_flow_en=2) doesn't support duplicate patterns.
-	 * Warn only if user explicitly requested an incompatible setting.
-	 */
-	bool allow_dup_pattern_set = mkvlist != NULL &&
-		mlx5_kvargs_is_used(mkvlist, MLX5_ALLOW_DUPLICATE_PATTERN);
-	if (config->dv_flow_en == 2) {
-		if (config->allow_duplicate_pattern == 1 && allow_dup_pattern_set)
-			DRV_LOG(WARNING, "Duplicate pattern is not supported with HWS. Disabling it.");
-		config->allow_duplicate_pattern = 0;
-	} else if (!allow_dup_pattern_set) {
-		/* Non-HWS mode: set default to 1 only if not explicitly set by user */
-		config->allow_duplicate_pattern = 1;
-	}
-
+	mlx5_fixup_flow_config(config, sh, mkvlist);
 	if (config->dv_esw_en && !sh->dev_cap.dv_esw_en) {
 		DRV_LOG(DEBUG, "E-Switch DV flow is not supported.");
 		config->dv_esw_en = 0;
@@ -3802,6 +3731,31 @@ mlx5_read_queue_counter(struct mlx5_devx_obj *q_counter, const char *ctr_name,
 	return ret;
 }
 
+/**
+ * Fix up shared configuration passed by user based on device capabilities.
+ *
+ * @param[in] config
+ *   Pointer to shared configuration.
+ * @param[in] sh
+ *   Pointer to shared device context.
+ * @param[in] mkvlist
+ *   Key/value list of passed options
+ */
+void
+mlx5_fixup_flow_config(struct mlx5_sh_config *config,
+		       struct mlx5_dev_ctx_shared *sh,
+		       struct mlx5_kvargs_ctrl *mkvlist)
+{
+	if (config->dv_flow_en && !sh->dev_cap.dv_flow_en) {
+		DRV_LOG(WARNING, "DV flow is not supported.");
+		config->dv_flow_en = 0;
+	}
+
+	/* Apply platform-dependent logic. */
+	mlx5_os_fixup_flow_en(config, sh);
+	mlx5_os_fixup_duplicate_pattern(config, mkvlist, MLX5_ALLOW_DUPLICATE_PATTERN);
+}
+
 /**
  * Callback to remove a device.
  *
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index c54266ec26..e5f3701bc3 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2296,6 +2296,9 @@ struct mlx5_physical_device *
 mlx5_get_locked_physical_device(struct mlx5_priv *priv);
 void mlx5_unlock_physical_device(void);
 int mlx5_read_queue_counter(struct mlx5_devx_obj *q_counter, const char *ctr_name, uint64_t *stat);
+void mlx5_fixup_flow_config(struct mlx5_sh_config *config,
+			    struct mlx5_dev_ctx_shared *sh,
+			    struct mlx5_kvargs_ctrl *mkvlist);
 
 /* mlx5_ethdev.c */
 
@@ -2603,6 +2606,12 @@ int mlx5_os_set_allmulti(struct rte_eth_dev *dev, int enable);
 int mlx5_os_set_nonblock_channel_fd(int fd);
 void mlx5_os_mac_addr_flush(struct rte_eth_dev *dev);
 void mlx5_os_net_cleanup(void);
+void mlx5_os_default_flow_config(struct mlx5_sh_config *config, struct mlx5_dev_ctx_shared *sh);
+void mlx5_os_fixup_flow_en(struct mlx5_sh_config *config,
+			   struct mlx5_dev_ctx_shared *sh);
+void mlx5_os_fixup_duplicate_pattern(struct mlx5_sh_config *config,
+				     struct mlx5_kvargs_ctrl *mkvlist,
+				     const char *key);
 
 /* mlx5_txpp.c */
 
diff --git a/drivers/net/mlx5/windows/mlx5_os.c b/drivers/net/mlx5/windows/mlx5_os.c
index 55b647eddc..4952b674c0 100644
--- a/drivers/net/mlx5/windows/mlx5_os.c
+++ b/drivers/net/mlx5/windows/mlx5_os.c
@@ -892,3 +892,26 @@ mlx5_os_net_cleanup(void)
 }
 
 const struct mlx5_flow_driver_ops mlx5_flow_verbs_drv_ops = {0};
+
+void
+mlx5_os_default_flow_config(struct mlx5_sh_config *config __rte_unused,
+			    struct mlx5_dev_ctx_shared *sh __rte_unused)
+{
+	config->dv_flow_en = 1;
+	config->allow_duplicate_pattern = 1;
+}
+
+void
+mlx5_os_fixup_flow_en(struct mlx5_sh_config *config __rte_unused,
+		      struct mlx5_dev_ctx_shared *sh __rte_unused)
+{
+	/* Nothing to fix up */
+}
+
+void
+mlx5_os_fixup_duplicate_pattern(struct mlx5_sh_config *config __rte_unused,
+				struct mlx5_kvargs_ctrl *mkvlist __rte_unused,
+				const char *key __rte_unused)
+{
+	/* Nothing to fix up */
+}
-- 
2.47.3


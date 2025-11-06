Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E71CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 08:38:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 086F640E1F;
	Thu,  6 Nov 2025 09:38:57 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
 by mails.dpdk.org (Postfix) with ESMTP id A5CED40E1F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 09:38:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FveaNYQdCeLxsJyKp5TTIrUBUTxYBejBAYvgxgP3vSAshEMLBnDJXfkyIajqdoyvhJkTxGR2FKJ3f6W5ByFUG8gnFF6mpX+6IrVMenDTXcsyXi9C4knD4PbjqZFLkpRDPCmTRFl50s3CBnH3nEbE0z29rHA53H15q7deierpvT25VtMBT/KW3KyBNHr1YyCmBKYjdU7SwFa7yYb+kHjifo36RxN1NjMm89+LB1WJwlDuXQTO6MwvHrBZ8OhGBH4qxDMHKxLRQwbLf/5gDE2cgjnVicTv/v6rklQtTZ6WJZZcMlk81IrETU0O46fBjYDVCbZJJqTntO3CfDnB46DxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBl+OXLJ3orM2NHrzIK66Kva/7wuizlrorLimrDbLbI=;
 b=do2JWiMDcpct79yriSvEXyXRAIzXnYWA1t7M1QWKdW9c8GbGDcqV/oOcQgBFmhSda2wimbBMogHqQyGpo3PrHLHlhNaiZhZW2GY46E0CeBs9DKFl/7O5wPhvRVMEXsV3iywymyijXlYS57kayCepcOuaSw9DbtwelTgQGhKDTaWw7l7pXPoM0HQRP+xWAWhP3XKifQGGgH4LzDBfN3lvcbeA5/kyvHBU0ohQwCfQgwournkYDa140Y9SBcZ9FWWAB5o21ZZ24mG8lHAWwViZLCh7AAw9/JO2MSIKA7xkKkaBJbvX3/ZmwFv3VQROuKZnObjFsFNPLCHPbb69ZTurtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBl+OXLJ3orM2NHrzIK66Kva/7wuizlrorLimrDbLbI=;
 b=NGD9zBfrk4/ekRJdRvo89qwjyqU2DIgvFDRs7visqw3cxUUO0Oz0156vz1gdtBFJwbunICi81gKmlzSDpkxcURtTrodPJg0dhiVDYM59DG3+10bnb2tdgkQN19EtdB0sOHpRfiywR8iVuhN4AWDLV3e1y506RGIzCOtgMzzGtosVI8mmSKOybKoC7h9bRH/IwtW2O8GHac3X63nThGnuTl8kg0rS3kkJr80W+VrlVFmYkc4COiBSAfSaKJvqCY10wxkGMOjVYbWqb4B08GUkpiiCdJjFGCM5Vpejc2xgXqSvJ5Q76QOeh5EdtCBGKd5gf5gVGhaBKzFvZN6k9VFBmQ==
Received: from PH1PEPF000132E8.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::28)
 by BN5PR12MB9540.namprd12.prod.outlook.com (2603:10b6:408:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 08:38:46 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2a01:111:f403:f912::5) by PH1PEPF000132E8.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 08:38:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 08:38:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 00:38:30 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 00:38:29 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 00:38:27 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH 2/2] net/mlx5: update flow devarg handling for future HW
Date: Thu, 6 Nov 2025 10:38:17 +0200
Message-ID: <20251106083817.166689-2-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20251106083817.166689-1-mkashani@nvidia.com>
References: <20251106083817.166689-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|BN5PR12MB9540:EE_
X-MS-Office365-Filtering-Correlation-Id: b06b2afe-bc47-4692-e22d-08de1d0fe66c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BzQG71AUSsMF6mVURGv0HF9yan7XmmqI3Vim+osheelMvk4slj/yiF39IvbL?=
 =?us-ascii?Q?iXDA6SFbe+cIn8/AKN4/xhWJsoc+BOwZWiS4M4hKHb/BYU13qxACH9A2kDb0?=
 =?us-ascii?Q?j+JNomVG2FZiQ0xdj7g7mbrBzRVcGe5uhovveMVYUygfifQM37thPIqnwwSU?=
 =?us-ascii?Q?/lwmvVm/ipsrsZcE+xEjEDJI3Ex5WTWHZUoFS/Fvgg2PNzTRDx/AG2dFH1Ue?=
 =?us-ascii?Q?aj8z/NwzyRXsYFjd3zMpuRSZYwlzasz/rfYO3OfQXKeXxbjNW+XC49hieHcX?=
 =?us-ascii?Q?oABAClijjtgujZK4lXO9m69TuAiTh5gex5khIKsFKdX+5xJx1XK9YpZ8j2kQ?=
 =?us-ascii?Q?3fMYUFdP9dHPLw1zXlCxi+4OLGNNPP+KWS2fbMXkVoVDhpAGsSohqtCFiBVE?=
 =?us-ascii?Q?XXQ2V0hDpAj/1lh3vBN3/xEG2CNB6QtLfgidNh5H1rtBdDGkZAUyTGxFdX+Z?=
 =?us-ascii?Q?ZRjkLfy25p3vTzgBvFs9QL0VXE0CDrJQquwabciaUdaG9j461BoeLgo39weF?=
 =?us-ascii?Q?hn0xOAayq1tX5+6loxBJh+Qyv5MrxLMdJzyRk0or70YU9E4SirBL0mmfKxRv?=
 =?us-ascii?Q?On6IXwc20bU3rTHhvKDj53B8OrfpGvcV4lXVK5VndXY8XgILYfEMQHmMfup8?=
 =?us-ascii?Q?zbwBgjsY+wLIIbjAquw8fD+sAH8UUdjFdylXLwx+sTEJxgCcQzVnKZsMwWEo?=
 =?us-ascii?Q?dQ93LxUBGWcqce3kqmevZP1QX3M1wqdSOWvCffhdY6aMFWN47mpHnb/iLJNz?=
 =?us-ascii?Q?FISB5U3yJn7zTQg6OltONIlqKXX8YJOsNDJ2fiCuBWzmZdmwDjxdbu8+62on?=
 =?us-ascii?Q?P2h5JPxagoqVQea6LwNkHZz6u/fkoKiq1Z41QBnbOkfzXtu55fJ0JvDzBjrJ?=
 =?us-ascii?Q?gIYSzGhAuX+9wRviBLfbhnrFiua/s71oKnT9Y7Fl9I9hMrurjWbiFvT8W6NU?=
 =?us-ascii?Q?zR9z+f2iXMBMJf/CbMGR8aITktr6lMuXF0zNq+wFqz3irKa8ULECYmHKgs2d?=
 =?us-ascii?Q?AWRy2ShdsH514vXlQvI1Etm9W4EfN2jwLhAFyYa7l3MnKCORzR+2NIawvbCE?=
 =?us-ascii?Q?LNo5GQhhB3+Q+i71kuZDPn6qo0wL5UDHySGI2T65Nhequ1oXvwiAhERS0WLE?=
 =?us-ascii?Q?q/Cl0nXmWEOyM8fxmOHWOk4ewYBp3/Y48NwL9LHDlyW97Hr+/LVrY57AUpeb?=
 =?us-ascii?Q?QqaX5jtxALiVojhFEaIV7xLC0jlpNFqPud1TNOdtxzCbq9H+MJeYbYEfXWfN?=
 =?us-ascii?Q?jncMtqJxK5SrQ2teFf2RWOJzq0rORomptjwsIXV39Te4L5tdlg7t9vrUjhVn?=
 =?us-ascii?Q?kY3qlZvcz4dJP4OJy49Cm8uVljWNmAxgWsJLTmKILcGB5mxnhjGXqlAfYewv?=
 =?us-ascii?Q?MkQCfMWUvFd7EucL8AOGjqWWsijtP7kadk6wUZm4MR1SknTWVUUXG+0HhTw4?=
 =?us-ascii?Q?ev0aeAsfNGay3QwLyh7Yvu6zW6FMN7GvCp1NrykmXUCDO4ZHyLox8egNrbVQ?=
 =?us-ascii?Q?NOt506E06c0yqM3uoGcENgyK9VJQzT9bCagNcbAm+NIsrizd2knjPrmifsl5?=
 =?us-ascii?Q?FZ+VxVX7RwzoQcUIqhI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 08:38:45.9625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b06b2afe-bc47-4692-e22d-08de1d0fe66c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9540
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

SWS (software steering) will be disabled on future hardware generations.
Update the defaults for the dv_flow_en and allow_duplicate_pattern
devargs accordingly.

- Default dv_flow_en devarg value will be chosen based on whether
  NIC supports SW steering and/or HW steering.
- If DV flow is not supported and allow_duplicate_pattern is
  set by the user, forcibly disable it and emit a clear log message.

This change improves reliability by ensuring only valid
configurations are applied, and provides clear feedback to
the user when fallbacks are triggered.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/nics/mlx5.rst | 11 +++++--
 drivers/net/mlx5/mlx5.c  | 71 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 37495359d4f..91983089702 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -694,8 +694,11 @@ for an additional list of options shared with other mlx5 drivers.
   Value 2 enables the WQE based hardware steering.
   In this mode, only queue-based flow management is supported.
 
-  It is configured by default to 1 (DV flow steering) if supported.
-  Otherwise, the value is 0 which indicates legacy Verbs flow offloading.
+  By default, the PMD will set this value according to capability.
+  If DV flow steering is supported, it will be set to 1.
+  If DV flow steering is not supported and HW steering is supported,
+  then it will be set to 2.
+  Otherwise, it will be set to 0.
 
 - ``dv_esw_en`` parameter [int]
 
@@ -838,8 +841,10 @@ for an additional list of options shared with other mlx5 drivers.
   - 1. Allow insertion of rules with the same pattern items.
     In this case, all rules are inserted but only the first rule takes effect,
     the next rule takes effect only if the previous rules are deleted.
+    This option is not supported in :ref:`HWS mode <mlx5_hws>`.
+    If this option is set to 1 in HWS mode, it will be set to 0.
 
-  By default, the PMD will set this value to 1.
+  By default, the PMD will set this value according to capability.
 
 
 .. _mlx5_net_stats:
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index ea235cf36be..dd3460f8d4b 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1443,6 +1443,45 @@ mlx5_dev_args_check_handler(const char *key, const char *val, void *opaque)
 	return 0;
 }
 
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
 /**
  * Parse user device parameters and adjust them according to device
  * capabilities.
@@ -1484,6 +1523,8 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 	int ret = 0;
 	size_t alignment = rte_mem_page_size();
 	uint32_t max_queue_umem_size = MLX5_WQE_SIZE * mlx5_dev_get_max_wq_size(sh);
+	bool hws_is_supported = mlx5_hws_is_supported(sh);
+	bool sws_is_supported = mlx5_sws_is_any_supported(sh);
 
 	if (alignment == (size_t)-1) {
 		alignment = (1 << MLX5_LOG_PAGE_SIZE);
@@ -1494,9 +1535,15 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 	memset(config, 0, sizeof(*config));
 	config->vf_nl_en = 1;
 	config->dv_esw_en = 1;
-	config->dv_flow_en = 1;
+	if (!sws_is_supported && hws_is_supported)
+		config->dv_flow_en = 2;
+	else
+		config->dv_flow_en = 1;
 	config->decap_en = 1;
-	config->allow_duplicate_pattern = 1;
+	if (config->dv_flow_en == 2)
+		config->allow_duplicate_pattern = 0;
+	else
+		config->allow_duplicate_pattern = 1;
 	config->fdb_def_rule = 1;
 	config->cnt_svc.cycle_time = MLX5_CNT_SVC_CYCLE_TIME_DEFAULT;
 	config->cnt_svc.service_core = rte_get_main_lcore();
@@ -1517,6 +1564,26 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 		DRV_LOG(WARNING, "DV flow is not supported.");
 		config->dv_flow_en = 0;
 	}
+	/* Inform user if DV flow is not supported. */
+	if (config->dv_flow_en == 1 && !sws_is_supported && hws_is_supported) {
+		DRV_LOG(WARNING, "DV flow is not supported. Changing to HWS mode.");
+		config->dv_flow_en = 2;
+	}
+	/* Handle allow_duplicate_pattern based on final dv_flow_en mode.
+	 * HWS mode (dv_flow_en=2) doesn't support duplicate patterns.
+	 * Warn only if user explicitly requested an incompatible setting.
+	 */
+	bool allow_dup_pattern_set = mkvlist != NULL &&
+		mlx5_kvargs_is_used(mkvlist, MLX5_ALLOW_DUPLICATE_PATTERN);
+	if (config->dv_flow_en == 2) {
+		if (config->allow_duplicate_pattern == 1 && allow_dup_pattern_set)
+			DRV_LOG(WARNING, "Duplicate pattern is not supported with HWS. Disabling it.");
+		config->allow_duplicate_pattern = 0;
+	} else if (!allow_dup_pattern_set) {
+		/* Non-HWS mode: set default to 1 only if not explicitly set by user */
+		config->allow_duplicate_pattern = 1;
+	}
+
 	if (config->dv_esw_en && !sh->dev_cap.dv_esw_en) {
 		DRV_LOG(DEBUG, "E-Switch DV flow is not supported.");
 		config->dv_esw_en = 0;
-- 
2.21.0


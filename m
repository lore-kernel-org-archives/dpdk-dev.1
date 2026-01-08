Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7666CCF6BE5
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 08:12:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 436614028C;
	Thu,  8 Jan 2026 09:12:58 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
 by mails.dpdk.org (Postfix) with ESMTP id 2E74E40261
 for <dev@dpdk.org>; Thu,  8 Jan 2026 09:12:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgscUdurj6sfcPIJ6Mml2VH/mqZy7+MZkav+r6heMcNeddAh0cRYE4frrfncPeAwkNu5SQ550WqNEmpj6TmKPSYA7XP0nY8Fnz8cE2iiydD3+A1cNaA7YgSdLyPriPbWVTITHqjLtY/8RBanJR4cZW9EYVCYxA0eVKSL8uHf6aIO2KBYD88BATNBTyNw/sg1JEc6Fvvg/kCgREupQs1Ofh9zsIjeadCQsFgrpjbi0uTomeBO0LaRse5dsValGveTOVoBUaZldmQT/iXDqfaaz0LOsdeFy+L/HZKJpPB8wOJLjAXcMwD2iYd79v2PMTTDRXw37aUEuDxiTtjch7qzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjDmhE0of2uSTujGnmpAYnovFWmq1xdvJ9h2NHrqoiI=;
 b=j//7hHhQD7wBa+5ragkzE/Kot4N0LI5eAGN7rHTKG4EMrKQyeBuZ2Dki8gmL2NMwysC30WjidGIIMEbxuJklr4TIcAVuICRp76vN9bbTFaLDATWcgKGeZB25YTQqr2l2OSZn6UcHj42cCzAY83ttLz+rh282AbGWxagsQJ7fnDfiAqlBDqZ+ZfRlJUC6rjuOflT97j0uYGsabPC0Jq8ICtFUEfs/ehbqsV33BMUTb5adlFiP1yPbDjE+GM4z/SiMfCbYIH4MPMQFe75bQr9ZrD3DawGDON3HSkRAIEr8Ipu/dDy+ReO5DvzaxrPWx0ghEf/NbPkqKCOs6pkMIM7NQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjDmhE0of2uSTujGnmpAYnovFWmq1xdvJ9h2NHrqoiI=;
 b=A3kDf8EIBRSn96uOk21LIQpVTxVVRgujNocE4pp+sxY23q9WsIlEqG5ZHgIoJONW6G3F6CbOuwrinf5l4XavwQChIBhLR5uU9lnUAprPt2uONMv4lHjpB6exmBONoxcp3UpmPSEvAhnpjdWfdhWKPsS4fz4izcJJkPXpI0ZIqXq8X6GMcTdLbd4D5oLeMAEoE5dD/XsJr4jp6EXwrmDakbMQDfrGG48fn957afr23z0iTh/6iGo9K68WZVDdoH+lImXKD9mJ8sd0qvO2h0pBnopAZMzDacVqvYQEMuNh20JjkGCvuE2nYQn+w5l0YZSLKN0KWqS437FHPciIoURauQ==
Received: from DS7PR06CA0043.namprd06.prod.outlook.com (2603:10b6:8:54::25) by
 CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Thu, 8 Jan 2026 08:12:49 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:8:54:cafe::ce) by DS7PR06CA0043.outlook.office365.com
 (2603:10b6:8:54::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Thu, 8
 Jan 2026 08:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Thu, 8 Jan 2026 08:12:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 00:12:38 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 8 Jan 2026 00:12:38 -0800
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 8 Jan 2026 00:12:35 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH] net/mlx5: add RSS TIR registration API
Date: Thu, 8 Jan 2026 10:12:31 +0200
Message-ID: <20260108081232.5420-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|CH2PR12MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: 06801277-4ed3-4ba0-7574-08de4e8db653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|7142099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yd1R/7b93zveL2V88jl9Cjmxpv0kXhLxarNttkOXS9vjuyR0QZpM0HW0fOTw?=
 =?us-ascii?Q?PB0FG/LyUOXGfLSs+9siXUSA3CFA9u30WFNH6ddh9TqEg5OK20dgnua7EStt?=
 =?us-ascii?Q?dDFABvDec0dphw7Ia7FRn/ugtJjCjDK0Og3D6UXoU01kA2dCZ288+O4Dvd4/?=
 =?us-ascii?Q?f4y9pWXg2cQZE22rXNL3a+cg7jsoXmySBA8phzFMpJZqD8pNMFmJQMqMZPt3?=
 =?us-ascii?Q?sRNi74oH517IicIpTDDY7Bk2vLJIrk1qfo87vXaDqHVPqm/68Jf2TQHYItJG?=
 =?us-ascii?Q?V3i60tdh88zBMIbrEB8PQ75kFcReqRwLN167LHqaZOs9ZAuAMlHrzfRNsKHq?=
 =?us-ascii?Q?vFP5v7hJCcFxMv5KwGQVSYeSHhDvQUE6+t2cyxImvLjr+UQ8wj2wn7PXJphE?=
 =?us-ascii?Q?FzH7/oHu6ZPhBNarvBdFgYkvB/1ZdfuMvn+SHQXM8uyCsR415ziVGwjP6FGj?=
 =?us-ascii?Q?c+65DSVGMtkis9QLKez53EH32on4EGHHBhJifZXTWNVHPVvkyfR07CDpymbW?=
 =?us-ascii?Q?e9Pqcp8wrSNFLh+O1rCFjcn4AfTHK1Wn9SjzwC54GIaUI5XTh1HEDwjgQ0zg?=
 =?us-ascii?Q?UC2rsUabmdKXvKVAjFJjGndOJivVQPAm0l/eOL3VYR3k2oiFFH3p+h5JzRNd?=
 =?us-ascii?Q?5qNUnlNK+g3XzqY4xQhj8ZNv3O4LkqykoAfRRN/kqjCgWBYP1+6kZLjq+BK6?=
 =?us-ascii?Q?ZWTjyKd/3wXD7llYv1L8saBquQOkwOdNazB49gHaxUNTIuZBS31Xc2eaDPED?=
 =?us-ascii?Q?5Un96nBBOU1aunJb4JbCsByn9yT4TPPnlCYIeSkLH45nXu7S12k723KNw/tJ?=
 =?us-ascii?Q?c6E3C3YhkmPMacGWJnj24yjxCMcskERbKUpVXPYOxCJS1FS8z2cHc7ctLQd7?=
 =?us-ascii?Q?mkTS+WPLVuvZXjkZ7Me+VvdpPz3Hy4tz86AJzhZrtAuVt6N2YQopZWROC3pP?=
 =?us-ascii?Q?pCQZfKQEVrWeoCoh6urpcvyQ7vzPMUSjW863Pkd8QToraOaK+7BjfIvFBJF6?=
 =?us-ascii?Q?8NvKH+5ICCMS2MDMWmpgBiQCdvAK/SVleTNyPUzBfhUgJVX8rFXikzC9y+L+?=
 =?us-ascii?Q?Kz4lW1q/DONQQDqrx7fE1P9pqxS4XRTbZOC6fHaokIjKFnYIVyy0ulRd8abK?=
 =?us-ascii?Q?K4nEr11esGenIjScf6Av6JO/XJGT+28/ZyAmHPwTaz3gNjMIF8LSKtCARblO?=
 =?us-ascii?Q?lYIyDklXOzYkV3IYgy799dWqprPf8PoDMxDd29igEQEGbV5yp2I9LygPVlE0?=
 =?us-ascii?Q?/6DGo29nxOT9RR38AwmHQpSHgyyj0+qC4AsZJlDajyW9z2Cs8CJAXLykUuQ2?=
 =?us-ascii?Q?z4j/emOUmCbbPi1LL75Wovbr/9akzg1UGM9nbIsy9w3OEcXnLjaMVd7/W011?=
 =?us-ascii?Q?X7haBsqtTJUPvgOQrPpe3QzDa8A667zfJlWOtNfNoH1EXHXFKBKDBH8P2Ywi?=
 =?us-ascii?Q?0pTc9Ym+Kl17eL9IH5SVmEJp/OimD+gJeOI+iIAZ+MMCgVnToY0knW2JkvW1?=
 =?us-ascii?Q?jJMSXL9FPAGdSwKtuoiX0akKYgd3oZYqBh6YkdSX1WU/X2/qeGfGdEyZGJRT?=
 =?us-ascii?Q?nQOIuoNAMg6l+4CClpk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7142099003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 08:12:48.8037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06801277-4ed3-4ba0-7574-08de4e8db653
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
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

mlx5 PMD is a bifurcated driver, which uses rdma-core APIs to
communicate with HW instead of UIO or VFIO directly.

It is possible for external libraries built on rdma-core to steer
traffic to DPDK-managed Rx queues using mlx5dv flow API. This
requires access to TIR object handles.

TIR (Transport Interface Receive) is a hardware object that defines
how incoming packets are distributed across Rx queues. It encodes
the complete RSS configuration including the hash function type,
hash key, set of destination queues, and which packet fields
(IP addresses, ports, etc.) participate in the hash calculation.
When a flow rule uses a TIR as its destination, the hardware applies
this RSS configuration to matching packets.

Add the following functions to mlx5 PMD private API:

- rte_pmd_mlx5_rss_tir_register(): Create a TIR DevX object based on
  the provided RSS configuration. The returned TIR handle can be used
  as a destination action in mlx5dv flow steering APIs from rdma-core.

- rte_pmd_mlx5_rss_tir_unregister(): Release the TIR object when no
  longer needed.

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 82 +++++++++++++++++++++++++++++++++
 drivers/net/mlx5/rte_pmd_mlx5.h | 54 ++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index c41b99746f..98483abc7f 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2022 NVIDIA Corporation & Affiliates
  */
 
+#include <eal_export.h>
 #include <rte_flow.h>
 #include <rte_flow_driver.h>
 #include <rte_stdatomic.h>
@@ -574,6 +575,87 @@ flow_hw_hashfields_set(struct mlx5_flow_rss_desc *rss_desc,
 	*hash_fields |= fields;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_rss_tir_register, 26.03)
+int
+rte_pmd_mlx5_rss_tir_register(uint16_t port_id,
+			      const struct rte_flow_action_rss *rss,
+			      struct rte_pmd_mlx5_rss_devx *devx)
+{
+	struct rte_eth_dev *dev;
+	struct mlx5_hrxq *hrxq;
+	struct mlx5_flow_rss_desc rss_desc = {
+		.hws_flags = MLX5DR_ACTION_FLAG_ROOT_RX,
+	};
+
+	if (rte_eth_dev_is_valid_port(port_id) < 0) {
+		DRV_LOG(ERR, "port %u: no Ethernet device", port_id);
+		rte_errno = ENODEV;
+		return -rte_errno;
+	}
+	if (!rss->queue_num || !rss->queue) {
+		DRV_LOG(ERR, "port %u: invalid RSS queues configuration", port_id);
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+	if (rss->key && rss->key_len != MLX5_RSS_HASH_KEY_LEN) {
+		DRV_LOG(ERR, "port %u: RSS key length must be %d",
+			port_id, MLX5_RSS_HASH_KEY_LEN);
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+	dev = &rte_eth_devices[port_id];
+	if (!mlx5_hws_active(dev)) {
+		DRV_LOG(ERR, "port %u: HWS not active", port_id);
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+	rss_desc.queue_num = rss->queue_num;
+	rss_desc.const_q = rss->queue;
+	if (rss->queue_num > 1) {
+		memcpy(rss_desc.key,
+		       rss->key ? rss->key : rss_hash_default_key,
+		       MLX5_RSS_HASH_KEY_LEN);
+		rss_desc.key_len = MLX5_RSS_HASH_KEY_LEN;
+		rss_desc.types = !rss->types ? RTE_ETH_RSS_IP : rss->types;
+		rss_desc.symmetric_hash_function = MLX5_RSS_IS_SYMM(rss->func);
+		flow_hw_hashfields_set(&rss_desc, &rss_desc.hash_fields);
+		flow_dv_action_rss_l34_hash_adjust(rss->types,
+						   &rss_desc.hash_fields);
+		if (rss->level > 1) {
+			rss_desc.hash_fields |= IBV_RX_HASH_INNER;
+			rss_desc.tunnel = 1;
+		}
+	}
+
+	hrxq = mlx5_hrxq_get(dev, &rss_desc);
+	if (!hrxq) {
+		DRV_LOG(ERR, "port %u: failed to allocate DevX", port_id);
+		return -rte_errno;
+	}
+	devx->destroy_handle = hrxq;
+	devx->obj = hrxq->tir->obj;
+	devx->id = hrxq->tir->id;
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_rss_tir_unregister, 26.03)
+int
+rte_pmd_mlx5_rss_tir_unregister(uint16_t port_id, void *handle)
+{
+	struct rte_eth_dev *dev;
+	struct mlx5_hrxq *hrxq = handle;
+
+	if (rte_eth_dev_is_valid_port(port_id) < 0) {
+		DRV_LOG(ERR, "port %u: no Ethernet device", port_id);
+		rte_errno = ENODEV;
+		return -rte_errno;
+	}
+	dev = &rte_eth_devices[port_id];
+	mlx5_hrxq_obj_release(dev, hrxq);
+	return 0;
+}
+
 uint64_t
 mlx5_flow_hw_action_flags_get(const struct rte_flow_action actions[],
 			 const struct rte_flow_action **qrss,
diff --git a/drivers/net/mlx5/rte_pmd_mlx5.h b/drivers/net/mlx5/rte_pmd_mlx5.h
index 31f99e7a78..7acfdae97d 100644
--- a/drivers/net/mlx5/rte_pmd_mlx5.h
+++ b/drivers/net/mlx5/rte_pmd_mlx5.h
@@ -9,6 +9,7 @@
 
 #include <rte_byteorder.h>
 #include <rte_compat.h>
+#include <rte_flow.h>
 #include <rte_per_lcore.h>
 
 /**
@@ -626,6 +627,59 @@ __rte_experimental
 int
 rte_pmd_mlx5_enable_steering(void);
 
+struct rte_pmd_mlx5_rss_devx {
+	void *obj; /**< DevX object pointer. */
+	void *destroy_handle; /**< Destroy handle passed to #rte_pmd_mlx5_rss_tir_unregister. */
+	uint32_t id; /**< DevX object ID. */
+};
+
+/**
+ * Register TIR DevX object for RSS flow action.
+ *
+ * TIR (Transport Interface Receive) is a hardware object that encodes
+ * RSS configuration (hash function, key, destination queues) and serves
+ * as the destination for steering rules directing traffic to Rx queues.
+ *
+ * This function creates a TIR object based on the provided RSS configuration.
+ * The returned DevX handle can be used as a destination action in mlx5dv
+ * flow steering API from rdma-core, enabling external libraries to direct
+ * traffic to DPDK-managed Rx queues.
+ *
+ * @param[in] port_id
+ *   The port identifier of the Ethernet device.
+ * @param[in] rss
+ *  RSS flow action configuration.
+ * @param[out] devx
+ *   A pointer to an object that will store returned data.
+ *
+ * @return
+ *   - (0) if successful. *devx* will hold DevX object.
+ *   - (-ENODEV) if *port_id* invalid.
+ *   - (-EINVAL) if *rss* data was incorrect or port HWS was not activated.
+ *   - (-ENOMEM) memory allocation error.
+ */
+__rte_experimental
+int
+rte_pmd_mlx5_rss_tir_register(uint16_t port_id,
+				   const struct rte_flow_action_rss *rss,
+				   struct rte_pmd_mlx5_rss_devx *devx);
+
+/**
+ * Unregister RSS action DevX object.
+ *
+ * @param[in] port_id
+ *   The port identifier of the Ethernet device.
+ * @param[in] handle
+ *   DevX object handle (destroy_handle from rte_pmd_mlx5_rss_devx).
+ * @return
+ *   - (0) if successful.
+ *   - (-ENODEV) if *port_id* invalid.
+ */
+__rte_experimental
+int
+rte_pmd_mlx5_rss_tir_unregister(uint16_t port_id, void *handle);
+
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.43.0


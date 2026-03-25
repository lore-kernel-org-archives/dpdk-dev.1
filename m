Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD6DFEA837
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 09:09:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46F0240E2B;
	Wed, 25 Mar 2026 10:08:51 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
 by mails.dpdk.org (Postfix) with ESMTP id A81A840E27
 for <dev@dpdk.org>; Wed, 25 Mar 2026 10:08:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtGm28+lePUUHoXZs/LxT5pNLMbK4+aotgbiilDE84M+5rHtNOrd3m1i+FelTyfG5KyQpLyjkWf8QW2gLmEJSnV8klICJr+hnJcfXFkM8gAF6hOxk0zDoClCuJA/GopEwyyGSKMxNADia3AqHNlwQvJLqq8M1quclcMppOWsll2DyOrlzBQ0EtggCZQgvRlYy+eZZ3kpw7zDhB3AzYPLM9h1GXboVdQBgolIXZYYme1/CQxY7OwNYW37OY39Xc21pME0USXhE2W/u0Q4XMEQtn6pnUQEhWIYA3Xopiy9JaptXPWkQdHjnZwzfK0gMf9Lid0o2bAPF5l0GyDZCPekzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/aJvdpF/liUp8KJR+QSbqNzAFgxeoP6O7OIUVgVq7Y=;
 b=a4jiMEzqRUm7QszBTprUhTmPAfyVIY1GZ0vlIvCkMpL1XPCO782yMCMF75j+n3tG3xLWqJPJ2CypjWRSnJrPEkyO2jEna+UQCaI/plKOf5TZkLKz1uuVC4sJjMRNQZo9C5c62MB9SjJWQKLjbct8GsuTxhmmdWiwk8HwHrGmq0PQia8TPYOzKRtcdXY3VTPoKPlpJdPBBgf+iYtGYjLMsvMNF4Tuqy+S5IAKpB2avvspVZvlXQUaJFkpee8piWGd5cHfOB4YBAomKcAWhkhs/jNIOyrfUvfy4W2Znuf+EQU/vA7PdGwthDEOpWuuelrVxzKgaZtNOhsQbzZ6tRIHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/aJvdpF/liUp8KJR+QSbqNzAFgxeoP6O7OIUVgVq7Y=;
 b=B7JpNJkjFhjfrvdnD+3qw8MaOaVrOYsbRqFu3GT20kgCPHbAV8pqCyehDtah63KtZ9/eNKDOgShDo2YvBsofm7RD0OyLUg7YOw3Y28NVnUISs7kLkWyn1Ub4by0wDm37+dhrAK0EuzjcCeYOylLLykmQWudqFopg+aAdDxq0F7tAF9dzHBSz52K1fu/d6GJlwJiMuF1REDslJ19Anjr/9cdXro+9mqJPaeuU96L6m4zaY8A/tEl5DSbNEAXT7lxdmEHJb9felW5AW3BCvCDGhUVFPXyGTHa0QYXHNOv82IiPCDd5lsHMAdwhfi2o5niWUvwucHqrVnRSpeBPiz0NAA==
Received: from CH2PR10CA0027.namprd10.prod.outlook.com (2603:10b6:610:4c::37)
 by IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 09:08:44 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::d9) by CH2PR10CA0027.outlook.office365.com
 (2603:10b6:610:4c::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Wed,
 25 Mar 2026 09:08:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 09:08:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 02:08:31 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 02:08:27 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 26.07 5/5] net/mlx5: allow legacy source vport match
Date: Wed, 25 Mar 2026 10:07:57 +0100
Message-ID: <20260325090758.42403-6-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325090758.42403-1-dsosnowski@nvidia.com>
References: <20260325090758.42403-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: 73274bb3-c14e-45eb-31c3-08de8a4e1dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: VWLTdIqWhy8AmBAWkjbZ0GMsgdsrj88Q6/BtbOqbUrolMoXXmNGNVjWd8zMB5s1XsKpkXZM+DSI5DSAtagzLcQg6YIAFa/RE6F38iXfH/sRtG5SKllBcHntAYR5GE8DjFf1pdy9V5Am+ja8dQkEvjxOJuvV7Zzfco9Eh6IZ7n3MGx4hh7fMebcNTaD1kgmaUxvvmV8HFjEN76cGYlLFKorNnS8ErHJuVhrT4mRCmq0JPQo1rcBgwezZr6yBD446kna5FJMn3FnxC/gK3LqE8zVLWx36muuZFjbTUXZdwE9wFCsU/GCh4fgFSesivPioeQ9noZV2fes2KIlbfZJVINkIphInVeVWmxDTtnHesbiHS5LJPT3VKpSYIcyE4Q6sE7nWZfxtqHSgM9KLbXvvpcv7elI1LzdJH7aHazPtyOcXRpMm5OwsoX5zJGufDrU8YHGMG/wXfhc1xk4o5vjrP0qVMSUSgzuzDIVHfx037XAb658GUq01X58fHnnrDJoOI515vBFzXe4oYkaGtSvOUvmsN7rDLSp2XklWJCxDU6PGp7aERfhZBPenHdxumwMtIorLNOq1q8a7TjDGk8rd+OxS0ic6q1P0KCK9wo4QlHNax0apEpq1kYUnYWXT0MxoCe0PUZoRDsjC5JbS3v0JO61q42+iLN7Ac9LeG049v3JhhDd3aPg/TAB2ngRKBkdebWimXbKcWyBrw9gLSYpXvkNKIJJB5eSLoqgZ+g3uneAjJ1ch0G2cOjJIoYG33/cIgDQMHTqBV6S+n9Obq7hdWeA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H20Nn3RSvA04j473GaxV3z5aIRByoIm2Tx9n2Wu/D54AveiSVGNZtlxGyQsEfw7CfaNnM11jlE3wB+88uM61gkPkuf9Q1XghUgD6kN4EpilEe0HewHz4ffEmHuaEjwGve9FhaZqWB9uMgNrnQkPfmIoYD7wlTYy6nVBASWczzjH5iYG37VYicetlz8iYnp+KwcvY+SJqX9xtNUVyYENg8/pQKAoOqI9GIFhDnPMxT71ps3rWq3fgRPi+vG9D8M8E9RQHhtzf5YNi4nTes53kP0rSxyBTS6rQIwR2OUuPyu5qaJFqj9CUPgVkSd4wAbABfiwooL0GwsYKC5XmriLsQJP43uVK/gsqsv64rK/HCZMaMTMeZpRZLzoffpQioMs/ZhgpPTOK5ASB2BgWc2Lrup3sZDCSqc2aqCIiQFf6JpHiKmCO/WSFmkHsyxeGldUQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:08:44.3579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73274bb3-c14e-45eb-31c3-08de8a4e1dcc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029
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

Allow running mlx5 PMD on top of a device with switchdev enabled,
where vport metadata is disabled (esw_port_metadata devlink parameter
is set to false). This requires:

- Preceding patches introducing source vport match capabilities
  in HWS layer.
- Removing the check for vport metadata during port probing
  (it previously was one of the requirements).
- Modify Tx representor matching flow rules logic when vport metadata
  is not available - instead of metadata, match on vport ID.
    - vport ID is enough, because any shared FDB use case
      required vport metadata to be enabled.
- Disable internal usage of unified FDB, when vport metadata
  is not available.
- Force internal usage of source_vport match on root flow rules,
  when vport metadata is not available.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c | 34 +++++++-------------------------
 drivers/net/mlx5/mlx5.h          |  1 +
 drivers/net/mlx5/mlx5_flow_dv.c  |  3 +++
 drivers/net/mlx5/mlx5_flow_hw.c  | 28 +++++++++-----------------
 4 files changed, 20 insertions(+), 46 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 75a2936023..a9dd0be055 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1866,7 +1866,9 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 		 *   3. with unsupported FW
 		 *   4. all representors in HWS
 		 */
-		priv->unified_fdb_en = !!priv->master && sh->cdev->config.hca_attr.fdb_unified_en;
+		priv->unified_fdb_en = sh->cdev->config.hca_attr.fdb_unified_en &&
+				       priv->master &&
+				       priv->vport_meta_mask != 0;
 		/* Jump FDB Rx works only with unified FDB enabled. */
 		if (priv->unified_fdb_en)
 			priv->jump_fdb_rx_en = sh->cdev->config.hca_attr.jump_fdb_rx_en;
@@ -1874,32 +1876,10 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 			eth_dev->data->port_id,
 			priv->unified_fdb_en ? "is" : "isn't",
 			priv->jump_fdb_rx_en ? "is" : "isn't");
-		if (priv->sh->config.dv_esw_en) {
-			uint32_t usable_bits;
-			uint32_t required_bits;
-
-			if (priv->sh->dv_regc0_mask == UINT32_MAX) {
-				DRV_LOG(ERR, "E-Switch port metadata is required when using HWS "
-					     "but it is disabled (configure it through devlink)");
-				err = ENOTSUP;
-				goto error;
-			}
-			if (priv->sh->dv_regc0_mask == 0) {
-				DRV_LOG(ERR, "E-Switch with HWS is not supported "
-					     "(no available bits in reg_c[0])");
-				err = ENOTSUP;
-				goto error;
-			}
-			usable_bits = rte_popcount32(priv->sh->dv_regc0_mask);
-			required_bits = rte_popcount32(priv->vport_meta_mask);
-			if (usable_bits < required_bits) {
-				DRV_LOG(ERR, "Not enough bits available in reg_c[0] to provide "
-					     "representor matching.");
-				err = ENOTSUP;
-				goto error;
-			}
-		}
-		if (priv->vport_meta_mask)
+		/* Without vport metadata, PMD must rely on source_vport match. */
+		if (priv->sh->config.dv_esw_en && priv->vport_meta_mask == 0)
+			priv->vport_match = 1;
+		if (priv->sh->config.dv_esw_en)
 			mlx5_flow_hw_set_port_info(eth_dev);
 		if (priv->sh->config.dv_esw_en &&
 		    priv->sh->config.dv_xmeta_en != MLX5_XMETA_MODE_LEGACY &&
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 8cd6562633..7e8ef1d467 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2003,6 +2003,7 @@ struct mlx5_priv {
 	uint32_t tunnel_enabled:1; /* If tunnel offloading is enabled on rxqs. */
 	uint32_t unified_fdb_en:1; /* Unified FDB flag per port. */
 	uint32_t jump_fdb_rx_en:1; /* Jump from FDB Tx to FDB Rx flag per port. */
+	uint32_t vport_match:1; /* True if source_vport match is used instead of metadata */
 	uint16_t domain_id; /* Switch domain identifier. */
 	uint16_t vport_id; /* Associated VF vport index (if any). */
 	uint16_t vport_vhca_id; /* VHCA ID of the associated vport (if any). */
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 32e75b063f..c2a2874913 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -11050,6 +11050,9 @@ flow_dv_translate_item_represented_port(struct rte_eth_dev *dev, void *key,
 #ifndef HAVE_IBV_DEVICE_ATTR_ESW_MGR_REG_C0
 	if (priv->sh->config.dv_flow_en == 2)
 		vport_match = true;
+#else
+	if (priv->sh->config.dv_flow_en == 2)
+		vport_match = !!priv->vport_match;
 #endif
 	if (!pid_m && !pid_v)
 		return 0;
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 4871594c35..b6bb9f12a6 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -9939,33 +9939,23 @@ static __rte_always_inline uint32_t
 flow_hw_tx_tag_regc_mask(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
-	uint32_t mask = priv->sh->dv_regc0_mask;
 
-	/* Mask is verified during device initialization. Sanity checking here. */
-	MLX5_ASSERT(mask != 0);
-	/*
-	 * Availability of sufficient number of bits in REG_C_0 is verified on initialization.
-	 * Sanity checking here.
-	 */
-	MLX5_ASSERT(rte_popcount32(mask) >= rte_popcount32(priv->vport_meta_mask));
-	return mask;
+	if (priv->vport_meta_mask != 0)
+		return priv->sh->dv_regc0_mask;
+	else
+		return UINT32_MAX;
 }
 
 static __rte_always_inline uint32_t
 flow_hw_tx_tag_regc_value(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
-	uint32_t tag;
 
-	/* Mask is verified during device initialization. Sanity checking here. */
-	MLX5_ASSERT(priv->vport_meta_mask != 0);
-	tag = priv->vport_meta_tag >> (rte_bsf32(priv->vport_meta_mask));
-	/*
-	 * Availability of sufficient number of bits in REG_C_0 is verified on initialization.
-	 * Sanity checking here.
-	 */
-	MLX5_ASSERT((tag & priv->sh->dv_regc0_mask) == tag);
-	return tag;
+	if (priv->vport_meta_mask != 0)
+		return priv->vport_meta_tag >> (rte_bsf32(priv->vport_meta_mask));
+
+	/* Without REG_C match value available, resort to matching vport ID. */
+	return priv->vport_id | (priv->sh->cdev->config.hca_attr.vhca_id << 16);
 }
 
 static void
-- 
2.47.3


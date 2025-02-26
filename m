Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EE8C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 08:03:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F390640608;
	Wed, 26 Feb 2025 09:03:39 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by mails.dpdk.org (Postfix) with ESMTP id E8460402E0
 for <dev@dpdk.org>; Wed, 26 Feb 2025 09:03:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1uSuCPh87wyV2JkA5PHN4LXxMXx/loZLSMZWgWTydY0NxANwbg9vEv1uV1VEg1oTHyO60J/o3Lyp1D3w4MtL+rlaBQex1qgGvreWNcpq0xrhK4SOWtrOnoTv7s5S7rWTURMje6ZaScWa+PDWPnH85DA48+BLlI7JQu/DhN++lsUBJG5NG5vjzauD+oOqewRF1DBOYSv1fObN8gdntZJMn1t/bNnDfJZph9noOAcXdvXEvrNaKkkbMYdjyBw35khB0y9jTZQjZTIgDRQsHlX5fpHMBbGA3JPpziw/Ajc+nYh1vSzPAGLnUK/FC4vnm3+C+EOtwyTOD546RxcS/DTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJka59wcB4MkKxGK7Uyqwf7AMYrMHhj3ElxdvL1fCJs=;
 b=QMyaz9d6Uwt823kS7xsgldjG3GavXx0GeWukEfuKUvRCbRYS42ycTw3qkF8yIvHbfBZ6+/KWjuGdDjGS/smR8JCezVXo7YlT+5cVznYFdvJGfwL2dLGM+HnBCwfixo9qFIiRZT0wgCJmI4tH+R5S8rlS+kZnBf2Gg+gCH+EA5r67k0Rwbh/Knw+4Tq2CABcXhwjsmCjslQ0b3Lv/epsxyM5EsgcBP84kbhMFaj6opxVC6M5x3S8C7L60G7w7AUcU/1T544WJed0guM4D/SH3KwOJqYS7kuroLrEE+IZqfOANZAlo0izJ6qihvKrDbgbdhnCoM5R//BmQrex1GQWSiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJka59wcB4MkKxGK7Uyqwf7AMYrMHhj3ElxdvL1fCJs=;
 b=YZYIsL0+0rGZvjP7dWUtYvxlcP71NRPQJY09Ms2mNmnmCSLu2ftwj1EVvvqRt/L76fAowuWEI5xJ4gtu0K8DptDVio1xFf4BSe+t0fn/lk/3dT7c+jcrDYw8pVJOrIG3doy06coSN64QdIog4jGCb6H3WYdJO/rd8yOfSipDkTItu9FxnYgAFJzwzkCMCh7rEqWC+rmr6QnyI8GnNrKswbnDf0/BXHz3mod3MM9wEaRU9J1VZPo+fsdVK3wdFH5n63H0rswE2NA79mbIy356QAUlhgeHWqJJDtsmk66F2w7LgucCBlvj4MmXWI3Q5/3JwbeuQxprtVmGktBUN75XTQ==
Received: from SN4PR0501CA0112.namprd05.prod.outlook.com
 (2603:10b6:803:42::29) by MN0PR12MB5738.namprd12.prod.outlook.com
 (2603:10b6:208:371::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 08:03:34 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:803:42:cafe::eb) by SN4PR0501CA0112.outlook.office365.com
 (2603:10b6:803:42::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.11 via Frontend Transport; Wed,
 26 Feb 2025 08:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 08:03:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 00:03:19 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 00:03:19 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Feb 2025 00:03:17 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 2/2] net/mlx5: add MPLSoGRE matching in HWS
Date: Wed, 26 Feb 2025 10:02:57 +0200
Message-ID: <20250226080258.30127-2-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250226080258.30127-1-mkashani@nvidia.com>
References: <20250226080258.30127-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6238f4-7c4c-4f55-d620-08dd563c10e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a65ILCvy5fJkvmHaaRJUZMTgBkqRZ4RKT0t6GNhfgVXhAWvPVpI4UqBBmHbZ?=
 =?us-ascii?Q?QotVQVavYlnlkuW2aFgB2oKrPjTLmHcjS/ZUdv4EP5gR7CljJdmdodXalruk?=
 =?us-ascii?Q?5jBW9+uwMOtLgqtSCXinu4+QEEm3YlQMTDYZ5Xrk47RABBK+IzlOBvFj1H7Q?=
 =?us-ascii?Q?9cx8a7jielm5nHNYQzpF9vAgPVEKs+4UA/efXk+uE/MnuiPTgmVtYkL8rUku?=
 =?us-ascii?Q?KDzih+LEtvepySmsF5egiChT93TCRidJ1K3O2zfd5b3Nfg6mPQLQG8eaanTY?=
 =?us-ascii?Q?yfmpQ08XbHm74wpPS0ymQGhQZsOG54rQxMvpbzi0Ppjuby+Fc4tTasLQaRX1?=
 =?us-ascii?Q?8mmclX2Mshc4ftD4SGrmyMsAiII7eNYQOZ13ngNOwGiWrVXLXVisFGOIbGgK?=
 =?us-ascii?Q?a0ggoDrmqDd7l/Jy1pdEjPU+PyDVl4K0vYB4lJi6LS5qyd6g//ZIapAiXHZU?=
 =?us-ascii?Q?EW8egDNNZOHNEcaIb3JHJYM/UjiUiZ1Chk7hbite/0TB4YvEZJ8W3Mq9H5rn?=
 =?us-ascii?Q?eTHsPeBrM/rzNrWJBE+XHaqvstge8ayAijk/wMVvFkXtu3RCmjU8exIr7p+w?=
 =?us-ascii?Q?n74ZwmFYB445Tmel7UaD9rKONOIH6SKAlMYS/MfUO5l7B2bD94co0eTqvshO?=
 =?us-ascii?Q?o+MJ+8UvTJtz7QsyUHbp/p6YSlUPqkXb2gXRQfce2SAmDSaJC0c1nVYLrGRz?=
 =?us-ascii?Q?bzbxPot5j/VdEzK8BqVR+yIHDreZvtNrR6fvVU6a8bfKYAUR+PlgbLnj7wNa?=
 =?us-ascii?Q?a5M6czlgbzWMdQJV2ZofSK+zVtgYo0uCu9BQJyylbHGb8eCYS2co8qk3GjiL?=
 =?us-ascii?Q?tivoQhHJ+nscJ/EdhBusIHm5qsUfKYc0OmpwVWECrVCD3bfKeBx5Ojdg2jK2?=
 =?us-ascii?Q?EXby1V6VJyp1xYGCNd5Rlavbtc7U3FDuLpSNFHWC13WGPokQNzsnySL621Z9?=
 =?us-ascii?Q?pWVNvlPOphOteb6L1CtJQw/QRhdEuO+CksGV3Oe8/8icFsO3tbJxTIidr1SL?=
 =?us-ascii?Q?FaNyN+mvtSsQCI34wTLzaMc1XMlNjpY277JVE7Su6yce9KMuCVvV+aTgg/Xx?=
 =?us-ascii?Q?ITQqgBzT/wbMBKExHbxaSORlv4rY5PwpClRhlSpGvgXOWVQK33QgAk0JNlZe?=
 =?us-ascii?Q?03v9J0Bx9CSHQfYId8KJxS2WyBhnI67LJZ+MmnuqwQuDC1ke36Cp1kd/uiIu?=
 =?us-ascii?Q?PaTWE9itWzHVcvvwxvgN462NfhRYNjXzPnjmjZIAgEHj9Dl0jxOGK8S7WEgB?=
 =?us-ascii?Q?MnDdbM3VHZdJh+PJQZjDEWHarhha5OHxJ/C+D9tYxlllJNbFsFY92COmtdgj?=
 =?us-ascii?Q?qFWGf4pWzo0KeTp/Yr+wwZOzMuz79aM954Dva0vAkVqCxsMLaQj9JbZJVV7j?=
 =?us-ascii?Q?dlSEWZ27K6uFR89uvevqlpWOgWbWfpJNJYrGA+2UbJbVuThp9S/DTtMRROXK?=
 =?us-ascii?Q?cSRgwpCdflPqr9hSFStp0jrokuumu99kSe7+2rS5NmcPbJhvhf1fdSpQ6EVR?=
 =?us-ascii?Q?Ekr8+Eqclrt4VXE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 08:03:33.6793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6238f4-7c4c-4f55-d620-08dd563c10e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738
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

Remove limitations in validation and MPLS match translation.

For non relaxed mode, assume MPLSoUDP if no protocol is mentioned.
Set UDP dest port to MPLS type only for UDP protocol.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/nics/mlx5.rst              |  2 --
 drivers/net/mlx5/hws/mlx5dr_definer.c | 28 +++++++++++++--------------
 drivers/net/mlx5/mlx5_flow.c          |  7 -------
 3 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 316c3397d2e..204572c885e 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -356,8 +356,6 @@ Limitations
 
 - L3 VXLAN and VXLAN-GPE tunnels cannot be supported together with MPLSoGRE and MPLSoUDP.
 
-- MPLSoGRE is not supported in HW steering (``dv_flow_en`` = 2).
-
 - MPLSoUDP with multiple MPLS headers is only supported in HW steering (``dv_flow_en`` = 2).
 
 - Match on Geneve header supports the following fields only:
diff --git a/drivers/net/mlx5/hws/mlx5dr_definer.c b/drivers/net/mlx5/hws/mlx5dr_definer.c
index 837e0c47bda..ba4053c552f 100644
--- a/drivers/net/mlx5/hws/mlx5dr_definer.c
+++ b/drivers/net/mlx5/hws/mlx5dr_definer.c
@@ -1644,14 +1644,9 @@ mlx5dr_definer_conv_item_mpls(struct mlx5dr_definer_conv_data *cd,
 {
 	const struct rte_flow_item_mpls *m = item->mask;
 	struct mlx5dr_definer_fc *fc;
-	bool inner = cd->tunnel;
-
-	if (inner) {
-		DR_LOG(ERR, "Inner MPLS item not supported");
-		rte_errno = ENOTSUP;
-		return rte_errno;
-	}
+	bool is_udp;
 
+	/* If no protocol is set - assume MPLSoUDP */
 	if (!cd->relaxed) {
 		/* In order to match on MPLS we must match on ip_protocol and l4_dport. */
 		fc = &cd->fc[DR_CALC_FNAME(IP_PROTOCOL, false)];
@@ -1661,14 +1656,17 @@ mlx5dr_definer_conv_item_mpls(struct mlx5dr_definer_conv_data *cd,
 			fc->tag_set = &mlx5dr_definer_udp_protocol_set;
 			DR_CALC_SET(fc, eth_l2, l4_type_bwc, false);
 		}
-
-		/* Currently support only MPLSoUDP */
-		fc = &cd->fc[DR_CALC_FNAME(L4_DPORT, false)];
-		if (!fc->tag_set) {
-			fc->item_idx = item_idx;
-			fc->tag_mask_set = &mlx5dr_definer_ones_set;
-			fc->tag_set = &mlx5dr_definer_mpls_udp_port_set;
-			DR_CALC_SET(fc, eth_l4, destination_port, false);
+		is_udp = (fc->tag_set == &mlx5dr_definer_udp_protocol_set);
+
+		if (is_udp) {
+			/* Set UDP dest port to MPLS. */
+			fc = &cd->fc[DR_CALC_FNAME(L4_DPORT, false)];
+			if (!fc->tag_set) {
+				fc->item_idx = item_idx;
+				fc->tag_mask_set = &mlx5dr_definer_ones_set;
+				fc->tag_set = &mlx5dr_definer_mpls_udp_port_set;
+				DR_CALC_SET(fc, eth_l4, destination_port, false);
+			}
 		}
 	}
 
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 3fbe89a9d42..69d7621d0bf 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -3812,13 +3812,6 @@ mlx5_flow_validate_item_mpls(struct rte_eth_dev *dev __rte_unused,
 			return rte_flow_error_set(error, ENOTSUP,
 						  RTE_FLOW_ERROR_TYPE_ITEM, item,
 						  "multiple tunnel layers not supported");
-	} else {
-		/* Multi-tunnel isn't allowed but MPLS over GRE is an exception. */
-		if ((item_flags & MLX5_FLOW_LAYER_TUNNEL) &&
-		    !(item_flags & MLX5_FLOW_LAYER_MPLS))
-			return rte_flow_error_set(error, ENOTSUP,
-						  RTE_FLOW_ERROR_TYPE_ITEM, item,
-						  "multiple tunnel layers not supported");
 	}
 	if (!mask)
 		mask = nic_mask;
-- 
2.21.0


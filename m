Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26984CF3187
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 10:36:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 813CD402C3;
	Wed, 19 Nov 2025 11:36:34 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011006.outbound.protection.outlook.com
 [40.93.194.6]) by mails.dpdk.org (Postfix) with ESMTP id B1B8240265;
 Wed, 19 Nov 2025 11:36:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sP2i7itMFeK87e6yNc2RWSzb2t0qULLqqbrFra7x8BcC+QNfqJaICjvsRlj53PXCCUUrbFv2QxrrSWPpwXhs0nkz/8Jk/aI+26n0m93UcnA3HGVt8bN+7qiK/XnS917STs9el9WxZyoM14NE8biGJxVit5Bvgh4jGE+MpfZOnqPnyIeHnDajOEFbCHRhARGi3Zi7S/Ku5yvwtfZXG6jsS4B9rL6j9StXDtVuD3pr65Mg4SggHIrJ2P+dVNEp31qPQpS3CKo1mQdmdPSn4YcrNoyDo33mBP4E+qOyOs03b7lj7CcSHXpJWJkoRGOQO6vz6uSYRv+DVj44+OrmSdFBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFju5S/WMuFQMBpo+/X96fJ/b8lTxTf6aAch19I5hGA=;
 b=eOWkFTxw1xrzBzS17DhqqKEG35rs95EBxJ8zwfBh4A2fujbf0k3gJWSSOsjijNCDqYBRYlNxl/R80JknITZY/phn/y/peGKejtVYeBgUdPm8odT4kqjEv/l5Vy5bjqlo3I3hV0aGAjZZBGbyRr/BzPNyptiC6uaMYZHmiVoBk0SPEo6haWwaqXRRLAo1z5GJyGP7odzX9oeWcjd2MIsgFC6nkN7smL3ovTYPeWlnb6qNLVZI8yVDQbopcrcIxBwiInIU1bmxzAUnOXsx2oy9qf+0YDnkaqPmkGmBzQO0pfxsSo43yH7Ju0+SObSNgqpUwGS1gEkmm2ACbQerCKxT4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFju5S/WMuFQMBpo+/X96fJ/b8lTxTf6aAch19I5hGA=;
 b=RfDZbHuzKy0xBwYsWWFd+ZVsaOW41xREajgTI9U+GiYIGgktmzHClR7nBsJxaNmMGPk8C9OEcX3tG/H+k3Xxhfsxw9nWPsjdIY2xFRXUIM/CY4MuZ//oERf+OcHMqViQcFTWjeRKcv7jlLtzVLGagn0T87hYwsBwxYslPCqZDxqNOjsYb3PwdD8lurK54CsxzHiSKXxFeMtHXVQ8MZuihMDmKKURskr4l7gZQTO8lAn8FVcloyBKyj/2MW5mwWRqRXTtXN0zxJ+w1iH3863PrhOgeKun3Er6JLLsLOlMkOeotjO6ZhdYanjRbMQjMj7D1YSRv0SKtro5GECR5jae4g==
Received: from BL1P221CA0037.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::12)
 by BN7PPF9E4583E15.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6dc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:36:29 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:5b5:cafe::23) by BL1P221CA0037.outlook.office365.com
 (2603:10b6:208:5b5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 10:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 10:36:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 02:36:15 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 02:36:12 -0800
From: Junfeng Guo <junfengg@nvidia.com>
To: <dev@dpdk.org>, <stable@dpdk.org>
CC: <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <rasland@nvidia.com>, <junfengg@nvidia.com>
Subject: [PATCH] net/mlx5: fix IP tunnel detection for IPIP and IPv6 ENCAP
Date: Wed, 19 Nov 2025 12:35:54 +0200
Message-ID: <20251119103554.44203-1-junfengg@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|BN7PPF9E4583E15:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a484eee-9638-4471-236a-08de27577fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cqjNHAhd6Lln8zSwTYlqdzpqxu/3SD6LNCpXLViHlkV9G06VhxL/VLfnP13M?=
 =?us-ascii?Q?Chpi+egI0LMUZgDm5XYhR8vmJnFoj5QjTAnJbulviwsDynwBdoCHWBpnpd9o?=
 =?us-ascii?Q?R/m/bQ+SFHXgvNAkWPXRu0iLgAWW7NKDiz02HCn9gbZT6PB0cd3WLSb0Ea4Z?=
 =?us-ascii?Q?k8uaRQr1GvSFkhISe8/LiRrrZHdIED6GhBvxgVKrlqyFOUx7ALgJgpWsnDqO?=
 =?us-ascii?Q?vk02n17PQLwn5P2WMF5qx9f5/AWXigxDzrwx9gTy2KLyerZKi8wC+HzgMTpd?=
 =?us-ascii?Q?B7bEQXbniH3VDS6y92YQ6CrRZafSz31Cu8rBUl2h5szb41cErzNeMDHF/ZlC?=
 =?us-ascii?Q?aAABqMlDcISZQhKdlWXVmXh5RsdC+vb2hs9K4lGeuDVnInrQDJqBRdw1GNPm?=
 =?us-ascii?Q?TW0a/NDk/p9YqvihUxzZg7FC6lOCLfQcQ5UNtjuSlH/M4VTh2pjEPkRF9Pyt?=
 =?us-ascii?Q?X+bTL1YUiVF8INhBHXjB2OVGV0iXzKb19mpmY6qfaTJLLG7imSlFDsdDzAkd?=
 =?us-ascii?Q?CipUnLaTEuQYpPR+FxuDmY8GJ4h92fmsw5qztn9ct2VPfgZx+PhCr1uTe0lX?=
 =?us-ascii?Q?Dgf+zMr+/DXxL7ANMlgXR9u7g6xgM27/soORfBlsET+2dD9aUn5bJ744yhmV?=
 =?us-ascii?Q?S+1v9SA/vY3X5jLyAuYAMM8zJHBSgA/cDyvbY0PZRBeZrQ6immBfdwIVHD4T?=
 =?us-ascii?Q?S9LEXwZmG/A+RGnfS6zz5zxug751NbbGU6ZWR27LFyd7dnE6X/z06635yDY3?=
 =?us-ascii?Q?S6WDZtaRdjID71jC0w8ggNqHUdci5/gLILVkK8UwQGSuVBOxl/6f/A9Gy56j?=
 =?us-ascii?Q?aTGCG5gMEwAamdKD9LBrm9mRuEWhTO4WznAH1D05rQ1UJPnFJq6XYoXzlhsw?=
 =?us-ascii?Q?OS3qYEgBN3fQluExxxHLL9kT7B/dZd07vVcfAQCQZTKWF9C32iEZwO4oepe2?=
 =?us-ascii?Q?q3C6U/6SkiI6hXRy7FtxhvX+fWaNKeOSUh5+tuNahkA1n5jS6D5au+b902Tl?=
 =?us-ascii?Q?hmQ0M8MR/Ogg/p7wP+79VY8L/nU9QK+Zp2PYoXq8Bf6Fdc7zJGMR6WPp5g5D?=
 =?us-ascii?Q?H4E/z4Rifp8TO8U+8jElXrl0BECKhauQ4lTfEFzpTgqxrr7Vqx2lZaUkMiAg?=
 =?us-ascii?Q?KoF7dYSTKsRXEgj6JiYMK6oLVtqFi7KQAZeIyj9ZA69X2lDX4CaWy2k5BNrc?=
 =?us-ascii?Q?cEdQO5GcWmrMYETYi6P4zEzT8Iq+JapqsBr+dCuBCO31Bxf1wLf9owHmHkhc?=
 =?us-ascii?Q?PNyYbwf1PdQTl4rJX7/gP8qTgo3zsy9zO0zXdVho9yP4PSFRaFMhk5qwoqg3?=
 =?us-ascii?Q?d9Mt/mLe11DCbp8RHXATLYpw/OTm+OEKaa6QvXeOxFfWPu5SfXg635CLACb9?=
 =?us-ascii?Q?0mEe0rugzcMP333TPegg4iw3hWndoNPqn5w7v1N7f2LmeauMtPo0nTXa3GVL?=
 =?us-ascii?Q?ZIbIdAX77PPdQkyEh2DNWKkaYGa/KEFD3CY9Z5sfz3UElZBDhadNiBgTOrLb?=
 =?us-ascii?Q?u9ctgGGXRG13857MuhSbOArB72l202GyfRR88gL0R6UieZnlofUdID7U+los?=
 =?us-ascii?Q?iup73/pxfIjLuyJR5fI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 10:36:29.0429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a484eee-9638-4471-236a-08de27577fc6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9E4583E15
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

The HWS (Hardware Steering) IP tunnel detection implementation was not
recognizing IPIP tunnel types based on the next protocol value in the
outer IP header as specified by RFC 2003 (IP-in-IP) and RFC 2473
(IPv6 Encapsulation).

The issue was that the code treated all combinations of [IPv4|6] / [IPv4|6]
as IPIP tunnels, setting MLX5_FLOW_LAYER_IPIP flag regardless of the actual
protocol. While this happened to work for simple cases due to the fallback
classification, it violated RFC compliance and could cause issues with
protocol validation.

The fix adds RFC-compliant tunnel detection by
1. Checking the protocol field (IPPROTO_IPIP=4 or IPPROTO_IPV6=41) in the
   outer IP header to determine tunnel type
2. Adding protocol mismatch validation to ensure outer protocol matches
   inner header type
3. Correctly setting MLX5_FLOW_LAYER_IPV6_ENCAP for IPv6 encapsulation

The expected tunnel patterns are now:
- [ipv4 | ipv6] proto is 4 / ipv4 -> MLX5_FLOW_LAYER_IPIP
- [ipv4 | ipv6] proto is 41 / ipv6 -> MLX5_FLOW_LAYER_IPV6_ENCAP

For cases without protocol specification, fallback classification based on
inner header type is still supported.

Fixes: f66c7c3ab983 ("net/mlx5/hws: recognize IP-in-IP tunnel in definer layer")
Fixes: 4b7044562f59 ("net/mlx5: support IP-in-IP tunnel for all combinations")
Cc: stable@dpdk.org

Signed-off-by: Junfeng Guo <junfengg@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_definer.c |   4 +-
 drivers/net/mlx5/mlx5_flow.c          |   5 -
 drivers/net/mlx5/mlx5_flow_hw.c       | 162 ++++++++++++++++++++++----
 3 files changed, 143 insertions(+), 28 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_definer.c b/drivers/net/mlx5/hws/mlx5dr_definer.c
index afa70bf793..03d2794367 100644
--- a/drivers/net/mlx5/hws/mlx5dr_definer.c
+++ b/drivers/net/mlx5/hws/mlx5dr_definer.c
@@ -3381,6 +3381,7 @@ mlx5dr_definer_conv_items_to_hl(struct mlx5dr_context *ctx,
 			if (cd.last_item == RTE_FLOW_ITEM_TYPE_IPV4 ||
 			    cd.last_item == RTE_FLOW_ITEM_TYPE_IPV6) {
 				cd.tunnel = true;
+				/* [IPv4 | IPv6] / IPv4: IPIP */
 				item_flags |= MLX5_FLOW_LAYER_IPIP;
 			}
 			ret = mlx5dr_definer_conv_item_ipv4(&cd, items, i);
@@ -3391,7 +3392,8 @@ mlx5dr_definer_conv_items_to_hl(struct mlx5dr_context *ctx,
 			if (cd.last_item == RTE_FLOW_ITEM_TYPE_IPV4 ||
 			    cd.last_item == RTE_FLOW_ITEM_TYPE_IPV6) {
 				cd.tunnel = true;
-				item_flags |= MLX5_FLOW_LAYER_IPIP;
+				/* [IPv4 | IPv6] / IPv6: IPV6_ENCAP */
+				item_flags |= MLX5_FLOW_LAYER_IPV6_ENCAP;
 			}
 			ret = mlx5dr_definer_conv_item_ipv6(&cd, items, i);
 			item_flags |= cd.tunnel ? MLX5_FLOW_LAYER_INNER_L3_IPV6 :
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 2c48f1b01b..0821c93a9a 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -2892,11 +2892,6 @@ mlx5_flow_validate_item_ipv4(const struct rte_eth_dev *dev,
 						  "multiple tunnel "
 						  "not supported");
 	}
-	if (item_flags & MLX5_FLOW_LAYER_IPV6_ENCAP)
-		return rte_flow_error_set(error, EINVAL,
-					  RTE_FLOW_ERROR_TYPE_ITEM, item,
-					  "wrong tunnel type - IPv6 specified "
-					  "but IPv4 item provided");
 	if (item_flags & l3m)
 		return rte_flow_error_set(error, ENOTSUP,
 					  RTE_FLOW_ERROR_TYPE_ITEM, item,
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index c41b99746f..75ac3bce28 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -8384,23 +8384,132 @@ mlx5_hw_validate_item_nsh(struct rte_eth_dev *dev,
 	return mlx5_flow_validate_item_nsh(dev, item, error);
 }
 
-static bool
-mlx5_hw_flow_tunnel_ip_check(uint64_t last_item, uint64_t *item_flags)
+static inline uint8_t
+mlx5_hw_flow_get_next_protocol(const struct rte_flow_item *item)
+{
+	if (!item || !item->spec)
+		return 0xff;
+
+	switch (item->type) {
+	case RTE_FLOW_ITEM_TYPE_IPV4: {
+		const struct rte_flow_item_ipv4 *spec = item->spec;
+		const struct rte_flow_item_ipv4 *mask = item->mask;
+
+		/* If mask is NULL or next_proto_id field in mask is 0,
+		 * then next_protocol in spec should not be read
+		 */
+		if (!mask || mask->hdr.next_proto_id == 0)
+			return 0xff;
+
+		return spec->hdr.next_proto_id & mask->hdr.next_proto_id;
+	}
+	case RTE_FLOW_ITEM_TYPE_IPV6: {
+		const struct rte_flow_item_ipv6 *spec = item->spec;
+		const struct rte_flow_item_ipv6 *mask = item->mask;
+
+		/* If mask is NULL or proto field in mask is 0,
+		 * then proto in spec should not be read
+		 */
+		if (!mask || mask->hdr.proto == 0)
+			return 0xff;
+
+		return spec->hdr.proto & mask->hdr.proto;
+	}
+	case RTE_FLOW_ITEM_TYPE_IPV6_FRAG_EXT: {
+		const struct rte_flow_item_ipv6_frag_ext *spec = item->spec;
+		const struct rte_flow_item_ipv6_frag_ext *mask = item->mask;
+
+		/* If mask is NULL or next_header field in mask is 0,
+		 * then next_header in spec should not be read
+		 */
+		if (!mask || mask->hdr.next_header == 0)
+			return 0xff;
+
+		return spec->hdr.next_header & mask->hdr.next_header;
+	}
+	default:
+		return 0xff;
+	}
+}
+
+static int
+mlx5_hw_flow_tunnel_ip_check(uint64_t last_item,
+			     const struct rte_flow_item *last_l3_item,
+			     const struct rte_flow_item *item,
+			     uint64_t *item_flags,
+			     struct rte_flow_error *error)
 {
-	bool tunnel;
+	uint64_t tunnel_flag = 0;
+	uint8_t outer_protocol;
+
+	/* IP tunnel detection - only single-level tunneling supported */
+	if (last_l3_item && (last_item == MLX5_FLOW_LAYER_OUTER_L3_IPV4 ||
+			     last_item == MLX5_FLOW_LAYER_OUTER_L3_IPV6)) {
+		/*
+		 * Tunnel type determination strategy:
+		 * 1. If previous L3 item has protocol field specified, use it (RFC compliant)
+		 * 2. Otherwise, fall back to inner header type (what's being encapsulated)
+		 */
+		outer_protocol = mlx5_hw_flow_get_next_protocol(last_l3_item);
+
+		if (outer_protocol != 0xff) {
+			/* Proto field specified in outer hdr mask - use RFC-compliant detection */
+			switch (outer_protocol) {
+			case IPPROTO_IPIP:  /* 4 - IP-in-IP */
+				/* Outer header indicates IPv4 payload */
+				if (item->type == RTE_FLOW_ITEM_TYPE_IPV6)
+					return rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ITEM, item,
+						"protocol mismatch: outer proto is IPIP but inner is IPv6");
+				tunnel_flag = MLX5_FLOW_LAYER_IPIP;
+				break;
+			case IPPROTO_IPV6:  /* 41 - IPv6-in-IP */
+				/* Outer header indicates IPv6 payload */
+				if (item->type == RTE_FLOW_ITEM_TYPE_IPV4)
+					return rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ITEM, item,
+						"protocol mismatch: outer proto is IPV6 but inner is IPv4");
+				tunnel_flag = MLX5_FLOW_LAYER_IPV6_ENCAP;
+				break;
+			default:
+				/* Unknown/unsupported protocol, fall back to inner header type */
+				goto fallback_classification;
+			}
+		} else {
+fallback_classification:
+			/*
+			 * Protocol field not specified or unknown - classify based on
+			 * what is being encapsulated (inner header type)
+			 */
+			if (item->type == RTE_FLOW_ITEM_TYPE_IPV4)
+				tunnel_flag = MLX5_FLOW_LAYER_IPIP;
+			else if (item->type == RTE_FLOW_ITEM_TYPE_IPV6)
+				tunnel_flag = MLX5_FLOW_LAYER_IPV6_ENCAP;
+			else
+				return 0; /* Not an IP item - shouldn't happen, but be defensive */
+		}
+
+		/* Check for unsupported nested tunneling after tunnel is detected */
+		if (*item_flags & MLX5_FLOW_LAYER_TUNNEL)
+			return rte_flow_error_set(error, ENOTSUP,
+						  RTE_FLOW_ERROR_TYPE_ITEM, item,
+						  "multiple tunnel layers not supported");
+
+		*item_flags |= tunnel_flag;
+		return 1; /* Tunnel detected */
+	} else if (last_item == MLX5_FLOW_ITEM_OUTER_IPV6_ROUTING_EXT) {
+		/* Special case: IPv6 routing extension header */
+		/* Check for unsupported nested tunneling */
+		if (*item_flags & MLX5_FLOW_LAYER_TUNNEL)
+			return rte_flow_error_set(error, ENOTSUP,
+						  RTE_FLOW_ERROR_TYPE_ITEM, item,
+						  "multiple tunnel layers not supported");
 
-	if (last_item == MLX5_FLOW_LAYER_OUTER_L3_IPV4 ||
-	    last_item == MLX5_FLOW_LAYER_OUTER_L3_IPV6) {
-		tunnel = true;
-		*item_flags |= MLX5_FLOW_LAYER_IPIP;
-	} else if (last_item == MLX5_FLOW_LAYER_OUTER_L3_IPV6 ||
-		   last_item == MLX5_FLOW_ITEM_OUTER_IPV6_ROUTING_EXT) {
-		tunnel = true;
 		*item_flags |= MLX5_FLOW_LAYER_IPV6_ENCAP;
-	} else {
-		tunnel = false;
+		return 1; /* Tunnel detected */
 	}
-	return tunnel;
+
+	return 0; /* No tunnel */
 }
 
 const struct rte_flow_item_ipv4 hws_nic_ipv4_mask = {
@@ -8475,6 +8584,7 @@ __flow_hw_pattern_validate(struct rte_eth_dev *dev,
 			 struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
+	const struct rte_flow_item *last_l3_item = NULL;
 	const struct rte_flow_item *item;
 	const struct rte_flow_item *gtp_item = NULL;
 	const struct rte_flow_item *gre_item = NULL;
@@ -8677,21 +8787,28 @@ __flow_hw_pattern_validate(struct rte_eth_dev *dev,
 				    MLX5_FLOW_LAYER_OUTER_VLAN;
 			break;
 		case RTE_FLOW_ITEM_TYPE_IPV4:
-			tunnel |= mlx5_hw_flow_tunnel_ip_check(last_item,
-							       item_flags);
+			ret = mlx5_hw_flow_tunnel_ip_check(last_item, last_l3_item, item,
+							   item_flags, error);
+			if (ret < 0)
+				return ret;
+			tunnel |= (ret > 0);
 			ret = mlx5_flow_dv_validate_item_ipv4(dev, item,
-							      *item_flags,
-							      last_item, 0,
-							      &hws_nic_ipv4_mask,
-							      error);
+							*item_flags,
+							last_item, 0,
+							&hws_nic_ipv4_mask,
+							error);
 			if (ret)
 				return ret;
 			last_item = tunnel ? MLX5_FLOW_LAYER_INNER_L3_IPV4 :
-				    MLX5_FLOW_LAYER_OUTER_L3_IPV4;
+				MLX5_FLOW_LAYER_OUTER_L3_IPV4;
+			last_l3_item = item;
 			break;
 		case RTE_FLOW_ITEM_TYPE_IPV6:
-			tunnel |= mlx5_hw_flow_tunnel_ip_check(last_item,
-							       item_flags);
+			ret = mlx5_hw_flow_tunnel_ip_check(last_item, last_l3_item, item,
+							item_flags, error);
+			if (ret < 0)
+				return ret;
+			tunnel |= (ret > 0);
 			ret = mlx5_flow_validate_item_ipv6(dev, item,
 							   *item_flags,
 							   last_item, 0,
@@ -8701,6 +8818,7 @@ __flow_hw_pattern_validate(struct rte_eth_dev *dev,
 				return ret;
 			last_item = tunnel ? MLX5_FLOW_LAYER_INNER_L3_IPV6 :
 				    MLX5_FLOW_LAYER_OUTER_L3_IPV6;
+			last_l3_item = item;
 			break;
 		case RTE_FLOW_ITEM_TYPE_UDP:
 			ret = mlx5_flow_validate_item_udp(dev, item,
-- 
2.43.0

